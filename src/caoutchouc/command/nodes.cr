module Caoutchouc
  class Nodes < Command
    def name
      "nodes"
    end

    def short_doc
      "get list of nodes from /_cluster/state"
    end

    def run
      master_node = client.cluster_state.master_node
      nodes = client.nodes
      length = nodes.values.max_by(&.name.length).name.length
      nodes.each do |node_name, node|
        if node_name == master_node
          print! "MASTER "
        else
          print! "       "
        end
        print! node.name.ljust(length, ' ')
        print! "  master=true" if node.master?
        print! "  data=true" if node.data?
        print! "\n"
      end
    end
  end

  Command.register(Nodes.new)
end
