require "nokogiri"

# Open xml doc
@doc = Nokogiri::XML(File.open("./example.xml"))

# Work with namespace stuff
node = @doc.xpath("xmlns:Order")

node_value = node.first.content # Nokogiri Nodes.... Nokogiri NODES Everywhere!

cumbersome_query = "xmlns:Order/xmlns:OrderHeader/xmlns:OrderNumber/xmlns:AnotherNode/core:ImportantThing"

namespaced_node = @doc.xpath(cumbersome_query)

namespaced_node[0].content # "Some Important Value"