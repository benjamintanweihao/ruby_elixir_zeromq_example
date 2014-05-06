# Sequence Server

This is the server that runs on Elixir and uses ZeroMQ.

What it does is simple: 

Listens for a request. If that request is a _number_, then reply with a result  containing a list of numbers starting from 1 till that _number_. 
	
This is what the result looks like:

```
{:result => [1,2,3,4 ...]}
```

## Running the Sequence Server

1. Fetch dependencies.

	```
	% mix deps.get
	```

2. Start the server on `iex`

	```
	% iex -S mix
	```