REGISTRY=wyga/http
PLATFORMS = linux/amd64,linux/i386,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x
BUILDX = docker buildx build --provenance false --platform $(PLATFORMS)
OUTPUT = --output type=image,push=true,compression=gzip,compression-level=9
TAGS = 200 204 403 404 500 503

all:
	$(foreach tag,$(TAGS),$(BUILDX) $(OUTPUT) -f Dockerfile -t $(REGISTRY):$(tag) --build-arg "STATUS_CODE=$(tag)"  --pull . ;)
