require 'benchmark'


Benchmark.bm do |r|
  TOTAL_COUNT = 5000
  MAX_WORKERS = 16

  r.report('seq:') do
    def fact(n) = (1..n).inject(:*) || 1
    @result_seq = TOTAL_COUNT.times.map do |i|
      fact(i)
    end.sort
  end

  r.report('thr:') do
    queue = Queue.new
    TOTAL_COUNT.times do |n|
      queue << n # fill up the queue with numbers
    end
    @result_threads = []

    workers = MAX_WORKERS.times.map do
      Thread.new do
        begin
          while n = queue.pop(true) # raises error when queue empty
            @result_threads << fact(n)
          end
        rescue ThreadError
          # queue has been processed, exit thread
        end
      end
    end
    workers.each(&:join)
    @result_threads.sort!

  end

  r.report('rac:') do
    workers = []

    workers = MAX_WORKERS.times.map do
      Ractor.new do
        while n = Ractor.receive
          Ractor.yield fact(n)
        end
      end
    end

    TOTAL_COUNT.times do |n|
      workers[n % MAX_WORKERS].send(n)
    end

    @result_ractors = TOTAL_COUNT.times.map do
      _r, result = Ractor.select(*workers)
      result
    end.sort

  end
end

