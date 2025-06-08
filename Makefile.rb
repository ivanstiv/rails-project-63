.PHONY: install
lint: bundle exec rubocop
test: bundle exec rake test || bundle exec rspec

install:
	@echo "Installing dependencies..."
	bundle install
	@echo "Dependencies installed successfully!"
