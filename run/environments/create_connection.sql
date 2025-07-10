-- Create a new SQLcl connection
ACCEPT conn_name    CHAR PROMPT 'Enter the name of the connection to be saved:'
ACCEPT conn_string  CHAR PROMPT 'Enter the database connection string:'
conn -savepwd -save conn_name conn_string
 
--List current connections
connmgr list

PROMPT "Press [Enter] to continue ..."
--To connect to a named connection
PRINT "conn -name " || conn_name