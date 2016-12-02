defmodule Spawn2 do
  def greet do
    receive do
      { sender, msg } ->
        send sender, { :ok, "Hello, #{msg}" }
    end
  end
end

# heres a client
# Spawn the module onto this process
pid = spawn(Spawn2, :greet, [])

# the PID that the module is running on
# The message, my PID (self) and "World!"
send pid, {self, "World"}

receive do
  { :ok, message } ->
    IO.puts message
end

send pid, {self, "Kermit!"}
receive do
  {:ok, message} ->
    IO.puts message
end
