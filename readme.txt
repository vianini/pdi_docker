docker build -t pdi:latest .


docker run -it --name pdiRun \
-v /etl:/opt/PDI/data-integration/etl:rw \
pdi teste.kjb
