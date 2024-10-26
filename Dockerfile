# Use the official Jekyll image from Docker Hub
FROM jekyll/jekyll:latest

# Set the working directory inside the container
WORKDIR /srv/jekyll

# Copy the current directory contents to the container
COPY . .

# Install necessary gems
RUN bundle install

RUN chmod -R 0777 /srv/jekyll
RUN chown -R jekyll:jekyll /srv/jekyll
USER jekyll

# Expose the default port for Jekyll
EXPOSE 4000

# Command to serve the Jekyll site
CMD ["bundle", "exec","jekyll", "serve", "--host", "0.0.0.0", "--trace"]
