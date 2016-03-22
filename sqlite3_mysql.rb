
#Take it line by line
ARGF.each do |line|
  # Remove lines not included in MySQL
  if line.include? "PRAGMA" \
  or line.include? "COMMIT" \
  or line.include? "BEGIN TRANSACTION" \
  or line.include? "CREATE UNIQUE INDEX" \
  or line.include? "sqlite_sequence"
    line = ""
  end
  
  #Write line to standard out
  $stdout.write line
end