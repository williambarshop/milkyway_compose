#git clone https://github.com/gdiepen/docker-convenience-scripts.git
#mv docker-convenience-scripts/docker_clone_volume.sh .
#rm -rf docker-convenience-scripts
#sh docker_clone_volume.sh milkyway-stack_galaxy_storage milkyway-stack_galaxy_storage-old
sudo docker stack rm milkyway-stack
sleep 30
sudo cp /var/lib/docker/volumes/milkyway-stack_galaxy_storage/ /var/lib/docker/volumes/milkyway-stack_galaxy_storage_old
sudo docker volume rm milkyway-stack_galaxy_storage
sh deploy_stack.sh
sleep 120
sudo docker stack rm milkyway-stack
sleep 30
sudo rm -rf /var/lib/docker/volumes/milkyway-stack_galaxy_storage/_data/postgresql/
sudo rsync -var /var/lib/docker/volumes/milkyway-stack_galaxy_storage_old/_data/postgresql/ /var/lib/docker/volumes/milkyway-stack_galaxy_storage/_data/postgresql/

#implement this to grab any config differences...
#$ cd /data/galaxy-data/.distribution_config
#$ for f in *; do echo $f; diff $f ../../galaxy-data-old/galaxy-central/config/$f; read; done

sudo rsync -var /var/lib/docker/volumes/milkyway-stack_galaxy_storage_old/_data/database/files/* /var/lib/docker/volumes/milkyway-stack_galaxy_storage/_data/database/files/
sudo rm /var/lib/docker/volumes/milkyway-stack_galaxy_storage_old/
sudo docker run -it --rm -v /var/lib/docker/volumes/milkyway-stack_galaxy_storage/_data/:/export wbarshop/milkyway_galaxy "/bin/bash && startup && sh manage_db.sh upgrade && exit"
sleep 60
sh deploy_stack.sh
sleep 30
