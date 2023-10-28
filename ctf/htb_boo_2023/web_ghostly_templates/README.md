# Ghostly Templates (medium web)

This one involved template injection for a Golang web server.  

The server had a feature where it would download and render a template page from any arbitary URL, and also had some internal functions that allowed you to read files and execute shell commands.

To solve, you just had to modify the normal server's template file to access the underlying methods to read the flag file.  Then spin up a web server and have the server pull your template and render it.

Link about Go template injection: https://www.onsecurity.io/blog/go-ssti-method-research/
