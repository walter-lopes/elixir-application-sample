defmodule ElhexDelivery.PostalCode.Supervisor do 
    use Supervisor

    def start_link do
        Supervisor.start_link(__MODULE__, [])
    end

    def init(_) do
        children = [
            worker(ElhexDelivery.PostalCode.Store, []),
            worker(ElhexDelivery.PostalCode.Navigator, []),
            worker(ElhexDelivery.PostalCode.Cache, [])
        ]

        supervise(children, strategy: :one_for_one)
    end
end