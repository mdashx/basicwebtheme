.PHONY: deploy
deploy:
	ssh ${USER}@${HOST}	'mkdir -p ${DEPLOY_PATH}'
	hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DEPLOY_PATH}
