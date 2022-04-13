FROM r-base

MAINTAINER Pedro Rafael D. Marinho "pedro.rafael.marinho@gmail.com"

RUN apt-get update && apt-get install -y \
                    libssl-dev \
                    libfontconfig1-dev \
                    libarchive-dev \
                    libfreetype6-dev \
                    libcurl4-openssl-dev \
                    libcairo2-dev \
                    libharfbuzz-dev \
                    libfribidi-dev \
                    libxml2-dev \
                    librsvg2-dev \
                    libmariadb-dev \
                    haskell-platform \
                    haskell-stack \
                    pandoc

# install needed R packages
RUN R -e "install.packages(c('shiny', 'flexdashboard', 'vroom', 'dplyr', 'fontawesome', 'stringr', 'DT'), dependencies = TRUE, repo='https://cloud.r-project.org/')"

# make directory and copy Rmarkdown flexdashboard file in it
#RUN mkdir /build_zone
ADD . /home

WORKDIR /home

# make all app files readable (solves issue when dev in Windows, but building in Ubuntu)
# RUN chmod -R 755 /home

# expose port on Docker container
EXPOSE 3838

# run flexdashboard as localhost and on exposed port in Docker container
CMD ["R", "-e", "rmarkdown::run('/home/index.Rmd', shiny_args = list(port = 3838, host = '0.0.0.0'))"]