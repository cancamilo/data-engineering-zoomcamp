key_path=/Users/camilo.ramirez/plucky-imprint-375522-8abae62a2f9d.json
auth:
	@gcloud auth activate-service-account --key-file $(key_path)

echo:
	@echo "hello there"

test: echo
	@echo "what up"