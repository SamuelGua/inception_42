# mkdir -p /Users/login/data/wordpress
# mkdir -p /Users/login/data/mariadb

make:
	docker compose -f srcs/docker-compose.yml up

clean:
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

fclean:
	docker system prune --volumes