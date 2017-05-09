defmodule OtpSyncCall do
  use GenServer

  # API

  def start, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def request, do: GenServer.call(__MODULE__, :request)

  # Callbacks

  def init(_) do
    IO.inspect "Start init"
    :timer.sleep(3_000)
    IO.inspect "Initialized"

    {:ok, nil}
  end

  def handle_call(:request, _, state) do
    IO.inspect "Worker starts"
    :timer.sleep(3_000)
    IO.inspect "Worker ends"
    {:reply, :result, state}
  end
end
