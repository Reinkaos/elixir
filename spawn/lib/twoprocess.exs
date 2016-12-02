defmodule TwoProcess do
  def run(token1, token2) do
    pid1 = spawn(TwoProcess, :reply, [])
    pid2 = spawn(TwoProcess, :reply, [])

    send pid1, {self, token1}
    send pid2, {self, token2}

    receive do
      ^token2 -> IO.puts "Got reply: #{token2}"
    end

    receive do
      ^token1 -> IO.puts "Got reply: #{token1}"
    end
  end

  def reply do
    receive do
      {sender, msg} -> send sender, msg
    end
  end
end

TwoProcess.run("Hey", "bro")
