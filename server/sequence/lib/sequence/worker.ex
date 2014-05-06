defmodule Sequence.Worker do
  use GenServer.Behaviour

  @port 5555
  
  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, [], [])
  end

  def init(_) do
    # Timeout immediately
    {:ok, [], 0}
  end

  def handle_info(:timeout, state) do
    {:ok, socket} = Exzmq.start([{:type, :rep}])
    Exzmq.bind(socket, :tcp, @port, [])
    loop(socket)
    {:noreply, state}
  end

  # Internal Functions
  defp loop(socket) do
    case Exzmq.recv(socket) do
      {:ok, [msg]} ->
        result = case msg |> Integer.parse do
                   {num, _} ->
                     [result: run(num)]
                   _ ->
                     [result: []]
                  end
        Exzmq.send(socket, [result |> JSON.encode!])

      _ ->
        Exzmq.send(socket, [[result: []] |> JSON.encode!])
    end
    loop(socket)
  end

  def run(n) do
    (1..n) |> Enum.to_list
  end

end
