defmodule OtpAsyncCall do
  use GenServer

  # API
  
  def start, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def request, do: GenServer.call(__MODULE__, :request)

  # Callbacks

  def init(_) do
    IO.inspect "Start init"
    send(self(), :long_init)
    IO.inspect "Initialized"

    {:ok, nil}
  end

  def handle_call(:request, from, state) do
    IO.inspect "Worker starts"
    spawn fn ->
      :timer.sleep(3_000)
      IO.inspect "Data response"
      GenServer.reply(from, :result)
    end

    IO.inspect "Worker ends"
    {:noreply, state}
  end

  def handle_info(:long_init, state) do
    IO.inspect "Long init starts"
    :timer.sleep(3_000)
    IO.inspect "Long init ends"

    {:noreply, state}
  end
end
