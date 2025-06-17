require 'minitest/autorun'
require_relative '../lib/hexlet_code'

class TestHexletCodeForm < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new(name: 'John', job: 'hexlet')
  end

  def test_form_structure
    form = HexletCode.form_for @user
    assert form.start_with?('<form')
    assert_includes form, 'method="post"'
    assert_includes form, 'action="#"'
    assert form.end_with?('</form>')
  end

  def test_form_attributes
    form = HexletCode.form_for @user, url: '/users', class: 'form-form'
    assert_includes form, 'action="/users"'
    assert_includes form, 'class="form-form"'
  end

  def test_form_inputs
    form = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job
  end
    assert_includes form, '<input type="text" name="name" value="John">'
    assert_includes form, '<input type="text" name="job" value="hexlet">'
  end

  def test_form_input_attributes
    form = HexletCode.form_for @user do |f|
      f.input :name, class: 'input'
      f.input :job, as: :text
    end

    assert_includes form, '<input type="text" name="name" value="John" class="input">'
    assert_includes form, '<textarea name="job">hexlet</textarea>'
  end

  def test_form_submit
    form = HexletCode.form_for @user do |f|
      f.submit
    end

    assert_includes form, '<input type="submit" value="Save">'
  end

  def test_form_custom_submit
    form = HexletCode.form_for @user do |f|
      f.submit 'Create'
    end

    assert_includes form, '<input type="submit" value="Create">'
  end
    assert_includes form, '<input type="text" name="name" value="John">'
    assert_includes form, '<input type="text" name="job" value="hexlet">'
  end

  def test_form_input_attributes
    form = HexletCode.form_for @user do |f|
      f.input :name, class: 'input'
      f.input :job, as: :text
    end

    assert_includes form, '<input type="text" name="name" value="John" class="input">'
    assert_includes form, '<textarea name="job">hexlet</textarea>'
  end

  def test_form_submit
    form = HexletCode.form_for @user do |f|
      f.submit
    end

    assert_includes form, '<input type="submit" value="Save">'
  end

  def test_form_custom_submit
    form = HexletCode.form_for @user do |f|
      f.submit 'Create'
    end

    assert_includes form, '<input type="submit" value="Create">'
  end

  def test_form_without_block
    form = HexletCode.form_for @user
    assert_equal '<form action="#" method="post"></form>', form
  end

