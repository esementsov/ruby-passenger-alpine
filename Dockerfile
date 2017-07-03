FROM alpine:3.6

LABEL name="Alpine Base Image"

ENV ENV="/etc/profile.d/rbenv.sh"
ENV RBENV_ROOT=/usr/local/rbenv
ENV RBENV_VERSION=2.2.2
ENV ac_cv_func_isnan yes
ENV ac_cv_func_isinf yes

RUN apk add --no-cache build-base\
				linux-headers\
				gnupg\
				openssl\
				gcc\
				bash\
				vim\
				ca-certificates\
				wget\
				git\
				make\
				patch\
				openssh\
				zip\
				unzip\
				zlib\ 
				zlib-dev\
				ruby\
				bind-tools\
				bzip2\
				g++\
				readline-dev\
				wget\
				postgresql\
				postgresql-dev\
				curl-dev\
				pcre-dev\
				postgresql-client\
				rsync\
				nodejs\
				tzdata\
				tar\
				procps\
				procps-dev

RUN			  echo 'export RBENV_ROOT=/usr/local/rbenv' > /etc/profile.d/rbenv.sh\
				&&  echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh\
				&&  echo 'export PATH="$RBENV_ROOT/shims:$PATH"' >> /etc/profile.d/rbenv.sh\
				&&  echo 'eval "$(rbenv init -)"'  >> /etc/profile.d/rbenv.sh\
				&&  chmod +x /etc/profile.d/rbenv.sh\ 
				&&  git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT}\
				&&  mkdir -p ${RBENV_ROOT}/plugins\
				&&  git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build\
				&&  git clone https://github.com/rbenv/rbenv-vars.git ${RBENV_ROOT}/plugins/rbenv-vars\
				&&  source /etc/profile.d/rbenv.sh\
				&&  ${RBENV_ROOT}/bin/rbenv install ${RBENV_VERSION}\
				&&  ${RBENV_ROOT}/shims/gem install passenger --no-ri --no-rdoc\
				&&  ${RBENV_ROOT}/shims/gem install bundler\
				&&  ${RBENV_ROOT}/shims/passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx\
				&&  ${RBENV_ROOT}/shims/passenger-config install-standalone-runtime --auto\
				&&  ${RBENV_ROOT}/bin/rbenv rehash
#				&&  apk del --no-cache gcc g++ linux-headers make ruby build-base


# COPY .ssh /root/.ssh

# RUN chmod 600 /root/.ssh/id_rsa

# HEALTHCHECK CMD passenger-status | awk '/Requests in queue:/{print $4}' || exit 1
