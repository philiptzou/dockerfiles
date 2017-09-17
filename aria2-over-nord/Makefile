build:
	@docker build -t philiptzou/aria2-over-nord:latest .

shell:
	@docker run -it --rm --privileged --env-file ~/.nord-env.list --entrypoint /bin/sh philiptzou/aria2-over-nord:latest
