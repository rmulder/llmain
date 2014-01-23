#!/usr/local/ruby_enterprise/bin/ruby

require 'rubygems'
require 'benchmark'

=begin
# Time: 110225 11:00:14
# User@Host: root[root] @ localhost [127.0.0.1]
# Query_time: 12.621500  Lock_time: 0.000346 Rows_sent: 0  Rows_examined: 696908
SET timestamp=1298660414;
SELECT * FROM XYZ
=end

SLOW_QUERY_LOG = '/alikelist/mysql/logs/slow-queries.log'
OUT_FILE = '/tmp/out'
ONE_DAY_AGO = 86400
#EMAIL_RECIPIENTS = "khalid@likelist.com"
EMAIL_RECIPIENTS = "khalid@likelist.com,rmulder@likelist.com"

@output = ""
@capture_flag = false

@one_day_ago = Time.now.to_i - ONE_DAY_AGO
@time_elapsed = Benchmark.measure do 
@line_count = 0
File.open(SLOW_QUERY_LOG, 'r+').each do |line| 
  @line_count += 1

  splits = line.split(/ |=/)
  case splits[0]
    when 'SET'
      if splits[1] == 'timestamp'
        time = splits[2].to_i 
        @capture_flag = false
        next if time < @one_day_ago
        @capture_flag = true
        @output << "Timestamp: " << Time.at(time).to_s << "\n"
        next
    end
  end

  if @capture_flag and !line[/# User@Host/]
    @output << line 
    if line[/# Query_time:/]
      splits = line.split(/ /)
      if splits[2].to_f < 1
        @output << "# Comment: Query is not using an index\n"
      else
        @output << "# Comment: Query is taking longer then 1 second to complete\n"
      end
    end
  end
end

end.real

@output << "\n"
@output << "Line count: #{@line_count}\n"
@output << "Time elapsed: #{@time_elapsed} seconds\n"

f = File.open(OUT_FILE, 'w+') 
f << @output
f.close

exec("mail #{EMAIL_RECIPIENTS} -s 'Slow Query Log' < /tmp/out")
