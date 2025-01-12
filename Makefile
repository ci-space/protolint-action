build:
	docker build -t ci-space/protolint-action --progress=plain .
	docker run ci-space/protolint-action
