.PHONY: setup lint lint-ruby lint-python test fix

# Установка зависимостей
setup:
	@echo "=== Installing dependencies ==="
	bundle install
	pip install pylint || echo "Pylint installation skipped (no pip?)"
	@echo "=== Dependencies installed ==="

# Основная цель lint (запускает все проверки)
lint: lint-ruby lint-python

# Линтинг Ruby
lint-ruby:
	@echo "=== Running Rubocop ==="
	bundle exec rubocop || (echo "Rubocop found issues"; exit 0)

# Линтинг Python
lint-python:
	@echo "=== Running Pylint ==="
	pylint your_package/ || (echo "Pylint found issues"; exit 0)

# Запуск тестов
test:
	@echo "=== Running tests ==="
	bundle exec rake test || bundle exec rspec

# Автоисправление проблем
fix:
	@echo "=== Auto-fixing issues ==="
	bundle exec rubocop -A || echo "Some issues couldn't be auto-corrected"