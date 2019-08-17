defmodule ElhexDelivery.PostalCode.Store do
    use GenServer
    alias ElhexDelivery.PostalCode.DataParser

    def start_link do
        GenServer.start_link(__MODULE__, %{}, name: :postal_code_store)
    end

    def init(_) do
        {:ok, DataParser.parse_data}
    end

    def get_geolocation(postal_code) do
        GenServer.call(:postal_code_store, {:get_geolocation, postal_code})
    end

    def handle_call({:get_geolocation, postal_code}, _from, get_geolocation_data) do 
        geolocation = Map.get(get_geolocation_data, postal_code)
        {:reply, geolocation, get_geolocation_data}
    end
end