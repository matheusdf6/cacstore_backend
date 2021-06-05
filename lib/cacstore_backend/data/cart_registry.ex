defmodule Cacstore.Data.CartRegistry do
  alias Cacstore.Data.CartServer
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def locate_cart(server, cart_hash) do
    GenServer.call(server, { :cart_process, cart_hash })
  end

  def handle_call({:cart_process, cart_hash }, _, cart_server_list) do
    case Map.fetch(cart_server_list, cart_hash) do
      {:ok, cart_server} -> {:reply, cart_server, cart_server_list}
      :error ->
        {:ok, new_cart } = CartServer.create(cart_hash)
        {:reply, new_cart , Map.put(cart_server_list, cart_hash, new_cart ) }
    end
  end

end
