require 'rails_helper'
RSpec.feature 'Visit user profie' do
  before do
    @user = User.create(
      name: 'Bruno',
      last_name: 'Tostes',
      birthdate: '08/04/1988',
      email: 'bruno@example.com',
      password: 'password'
    )

    @address = Address.create(
      info: 'Rua Ribeiro de Barros , São Paulo',
      street: 'Rua Ribeiro de Barros',
      zipcode: '05010-040',
      city: 'São Paulo'
    )

    @cart = Cart.create
    @cart.address(address: @address)
    @user.update(cart: @cart)
  end

  scenario 'Logged user visit profile' do
    visit '/users/sign_in'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Log in'

    visit '/offers'

    expect(page).to have_content('Dados pessoais')
  end
end
