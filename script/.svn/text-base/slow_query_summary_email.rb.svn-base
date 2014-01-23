#!/usr/local/ruby_enterprise/bin/ruby

require 'rubygems'
require 'benchmark'
require 'digest/md5'

=begin
# Time: 110225 11:00:14
# User@Host: root[root] @ localhost [127.0.0.1]
# Query_time: 12.621500  Lock_time: 0.000346 Rows_sent: 0  Rows_examined: 696908
SET timestamp=1298660414;
SELECT * FROM XYZ /* SQL_NO_CACHE */

# User@Host: root[root] @ localhost []
# Query_time: 0.000538  Lock_time: 0.000000 Rows_sent: 22  Rows_examined: 22
SET timestamp=1297074601;
SELECT /*!40001 SQL_NO_CACHE */ * FROM `user`;
=end

SLOW_QUERY_LOG = '/alikelist/mysql/logs/slow-queries.log'
OUT_FILE = "/tmp/#{__FILE__}"
ONE_DAY_AGO = 86400
EMAIL_RECIPIENTS = "khalid@likelist.com"
#EMAIL_RECIPIENTS = "rmulder@likelist.com,torben@alikelist.com,orrin@alikelist.com,luis@likelist.com,manish@alikelist.com,khalid@likelist.com"

@output = ""
@one_day_ago = Time.now.to_i - ONE_DAY_AGO
@start_logging = false
@start_sql = false

@time_elapsed = Benchmark.measure do 
@line_count = 0
File.open(SLOW_QUERY_LOG, 'r+').each do |line| 
  @line_count += 1

  if @start_logging
    if line[/# User@Host|# Time/]
      @start_sql = false
    end

    if line[/# Query_time/]
      @query_time = line 
    end

    @sql += line if @start_sql

    if line[/# User@Host/] && @query_time
      # @ignore = false
      
      next if @query_time.split(" ")[2].to_f < 1.0

      @sql.gsub!(/\n+/, ' ')
      @sql.gsub!(/\t+/, ' ')
      @sql.gsub!(/ +/, ' ')

      #@output << "#{@query_time.to_s.gsub(/\n/, '')} SQL_length: #{@sql.length} SQL_digest: #{Digest::MD5.hexdigest(@sql)}\n" unless @ignore
      @output << "#{@query_time.to_s.gsub(/\n/, '')} SQL_length: #{@sql.length} SQL: \"#{@sql}\"\n" unless @sql[/SQL_NO_CACHE/] or @sql[/match_model->/] or @sql[/lsp_update_activity_list/]
    end
    
    # @ignore = true if line[/SQL_NO_CACHE/]
   end
 
  splits = line.split(/ |=/)
  case splits[0]
    when 'SET'
      if splits[1] == 'timestamp'
        time = splits[2].to_i 
        next if time < @one_day_ago
        
        @start_logging = true
        @start_sql = true
        @sql = ""
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

# exec("mail #{EMAIL_RECIPIENTS} -s 'Slow Query Log Summary' < #{OUT_FILE}")

