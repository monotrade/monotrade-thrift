thrift -r --gen gv src/Index.thrift

dot gen-gv/Types.gv -Tpng -o gen-uml/Types.png
dot gen-gv/Strategy.gv -Tpng -o gen-uml/Strategy.png
dot gen-gv/Gateway.gv -Tpng -o gen-uml/Gateway.png