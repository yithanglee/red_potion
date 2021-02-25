# WebAcc

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


inventory modu
warehouse management - similar to swc



[] locations - warehouses, shops, etc
[] products - SKUs , updates the inventory level here....
[] stock movements - to justify its current inventory level, with locations, and support document references
[] purchase orders - targeting suppliers
[] stock receive notes (aka receiving) 
[] supplier_product - middle table

[] create a stock order request - list all the stock that needs to be order
[] stock order request - all the PO is inside this SOR


ERD

product has one barcode

product has many serial number - because manufacturer can give honor warranty 

stock level (aka inventory) has many stock movement - to justify current onhand

serial number has many stock movement

stock movement has one serial number

 