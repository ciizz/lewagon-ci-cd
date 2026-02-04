include ../../../make.inc

build_docker_image:
		docker build -t $(DOCKER_IMAGE_NAME) .

run_docker_image:
		docker run --rm -e PORT=8000 -p 8000:8000 $(DOCKER_IMAGE_NAME)

push_docker_image:
		docker tag "$(DOCKER_IMAGE_NAME)" "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME)"
		docker push "$(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME)"

deploy_docker_image:
	gcloud run deploy $(IMAGE_NAME) \
		--image $(HOSTNAME)/$(PROJECT_ID)/$(REPOSITORY)/$(DOCKER_IMAGE_NAME) \
		--region $(LOCATION) \
		--platform managed \
		--allow-unauthenticated
