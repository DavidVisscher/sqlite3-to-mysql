
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

  #Fix problems with sqlite3 numbers by making (almost) every INTEGER a mysql BIGINT type
  line = line.gsub("INTEGER", "BIGINT") unless line.include? " id " or line.include? " ID "

  #replace datetime('now') function from sqlite with mysql equivalent
  #datetime is sometimes wrapped, so try to remove the extra () first
  line = line.gsub("(datetime('now'))","NOW()")
  #then replace the unwrapped function
  line = line.gsub("datetime('now')","NOW()")

  line = line.gsub("datetime default","TIMESTAMP DEFAULT")
  line = line.gsub("DATETIME DEFAULT","TIMESTAMP DEFAULT")

  tempLine = ''
  in_string = false

  #fix quotes in table names etc.

  line.split("").each do |c| #iterate over every character in the line
    if not in_string
      if c == "'"
        in_string = true
      elsif c == '"'
        tempLine = tempLine + '`'
        next
      end
    elsif c == "'"
      in_string = false
    end
    tempLine = tempLine + c
  end

  line = tempLine

  #Write line to standard out
  $stdout.write line
end