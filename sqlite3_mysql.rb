
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

  # Words we always want to replace
  line = line.gsub('autoincrement','auto_increment')
  line = line.gsub('AUTOINCREMENT','AUTO_INCREMENT')

  line = line.gsub("DEFAULT 't'", "DEFAULT '1'")
  line = line.gsub("DEFAULT 'f'", "DEFAULT '0'")

  line = line.gsub(", 't'",", '1'")
  line = line.gsub(", 'f'",", '0'")

  #Write line to standard out
  $stdout.write line
end