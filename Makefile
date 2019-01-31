
generate-filters:
					erb src/logservice-logsearch-filters/logsearch-filters.conf.erb.erb > jobs/logservice-logsearch-filters/templates/logsearch-filters.conf.erb

create-release: generate-filters
				bosh create-release --version=${RELEASE_VERSION} --tarball=/tmp/logservice-${RELEASE_VERSION}.tgz --force

dist: generate-filters
		bosh create-release --version=${RELEASE_VERSION} --tarball=/tmp/logservice-${RELEASE_VERSION}.tgz --final
		git commit -am "bump to ${RELEASE_VERSION}"
		git push

build: create-release