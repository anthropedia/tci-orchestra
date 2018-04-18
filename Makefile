mk_venv=python3 -m venv venv && . venv/bin/activate && pip install wheel -r requirements.txt

install:
	-git clone git@bitbucket.org:anthropedia/tci-admin.git admin
	cd admin && ${mk_venv}
	-git clone git@bitbucket.org:anthropedia/tci-api.git api
	cd api && ${mk_venv}
	-git clone git@bitbucket.org:anthropedia/tci-researchers.git researchers
	cd researchers && ${mk_venv}
	-git clone git@bitbucket.org:anthropedia/tci-professionals.git professionals
	cd professionals && ${mk_venv}
	-git clone https://github.com/anthropedia/tci-online.git online
	cd online && ${mk_venv}
	-git clone https://github.com/anthropedia/tci-assets.git assets
	@echo "Install completed! You may now run `make run`."

generate-token:
	@echo "Generated token 'abc123'"
	@cd `pwd`/api && source ./venv/bin/activate && MONGODB_URI=mongodb://localhost:27017/tki python -c "from core.models import AppToken; AppToken.objects.create(name='TKI', key='abc123');" && cd -

run:
	foreman start

start-gunicorn:  # service=<str:service_name> port=<int:port_number> <[optional] str:gunicorn_args>
	mkdir -p ./log/${service}/
	cd ${service} && \
		. ./venv/bin/activate && \
		pip install -r requirements.txt -r ../requirements.txt && \
	 	gunicorn -b 127.0.0.1:${port} app ${gunicorn_args} \
		 	--error-logfile ../log/${service}/error.log \
		 	--access-logfile ../log/${service}/access.log
