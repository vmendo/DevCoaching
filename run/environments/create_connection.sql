-- Prompt and accept the connection name and connection string from the user
ACCEPT conn_name    CHAR PROMPT 'Enter the name of the connection to be saved:'
ACCEPT conn_string  CHAR PROMPT 'Enter the database connection string:'

-- Create a new SQLcl connection
!echo 'Creating Connection ...'
conn -savepwd -save &conn_name &conn_string
 
--List current connections
!echo 'List connections'
cm list

-- How to use the new connection
PROMPT 'To connect use: conn -name &conn_name'

