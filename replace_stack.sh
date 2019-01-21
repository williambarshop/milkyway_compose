sudo docker stack rm milkyway-stack-ci && \
sleep 45 && \
sh remove_volume.sh && \
sleep 5 && \
sh deploy_stack.sh
