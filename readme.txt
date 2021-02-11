# criação da imagem
docker build -t pdi:latest .


# executa e cria container depois da execução mata o container grava o id em uma variavel  
container_id=$(docker run -it --rm  -v /home/vianini/ambiente/pentaho_server_docker/pentaho-pdi/etl:/opt/PDI/data-integration/etl:rw pdi teste.kjb 
)
 
echo $container_id

#execução direto pelo container 
docker run -it --rm -v /home/vianini/ambiente/pentaho_server_docker/pentaho-pdi/etl:/opt/PDI/data-integration/etl:rw pdi teste.kjb
