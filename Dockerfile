FROM centos:latest
MAINTAINER shahalam.ansari004@gmail.com

# Use the CentOS Vault repository instead of the default repositories
RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# Install required packages
RUN yum install -y httpd zip unzip

# Add the photogenic template to the web server
COPY photogenic.zip /var/www/html

# Set the working directory and unzip the downloaded template
WORKDIR /var/www/html/
RUN unzip photogenic.zip

# Move the contents of the extracted folder to the current directory
RUN cp -r photogenic/* .

# Clean up unnecessary files and directories
RUN rm -rf photogenic photogenic.zip

# Start Apache HTTPD in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose port 80 to allow HTTP traffic
EXPOSE 80
