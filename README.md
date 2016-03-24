SQLite3 to Mysql Dump Converter
==========================

Converts SQLite dump files to the mysql syntax to aid database switching, migration or replication.

Usage:
```
	$ ruby sqlite3_mysql.rb sqlite3dump.sql > outfile.sql
```
Piping in from the stdin is also possible:
```
	$ cat sqlite3dump.sql | ruby sqlite3_mysql.rb > outfile.sql
```
