defmodule Spawn1 do
  def greet do
    receive do
      { sender, msg } ->
        send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

# heres a client

pid = spawn(Spawn1, :greet, [])
# note that here self is the PID, send takes a pid and the message to send
# recieve matches against the sent message
send pid, {self, "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end
