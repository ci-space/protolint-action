build:
	docker build -t ci-space/protolint-action .
	docker run ci-space/protolint-action
