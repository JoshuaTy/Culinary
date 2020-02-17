defmodule Culinary.AccountsTest do
    use Culinary.DataCase, async: true

    alias Culinary.Accounts
    alias Culinary.Accounts.Customer

    describe "register_customer/1" do
        @valid_attrs %{
            name: "Customer",
            address: "Cebu City",
            contact_number: 123456,
        }

        @invalid_attrs %{}
        
        test "with valid data inserts user" do
            assert {:ok, %Customer{id: id}= customer} = Accounts.create_customer(@valid_attrs)
            assert customer.name == "Customer"
            assert customer.address == "Cebu City"
            assert [%Customer{id: ^id}] = Accounts.list_customers()
        end

        test "with invalid data does not insert user" do
            assert {:error, _changeset} = Accounts.create_customer(@invalid_attrs)
            assert Accounts.list_customers() == []
        end

        test "enforces unique usernames" do
            assert {:ok, %Customer{id: id}} = Accounts.create_customer(@valid_attrs)
            assert {:error, changeset} = Accounts.create_customer(@valid_attrs)

            assert %{name: ["has already been taken"]} = 
                    errors_on(changeset)

            assert [%Customer{id: ^id}] = Accounts.list_customers()
        end


    end
end