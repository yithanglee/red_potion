defmodule WebAcc do
  @moduledoc """
  WebAcc keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias WebAcc.{Repo, Settings}

  alias Settings.{
    StockLevel,
    StockMovement,
    PurchaseOrder,
    PurchaseOrderMaster,
    StockReceive,
    StockReceiveMaster
  }

  import Ecto.Query

  def reset() do
    Repo.delete_all(StockMovement)
    Repo.delete_all(PurchaseOrderMaster)

    Repo.delete_all(PurchaseOrder)

    Repo.delete_all(StockReceive)

    Repo.delete_all(StockReceiveMaster)
  end

  def recount_inventory() do
    sls = Repo.all(from(sl in StockLevel))

    for item <- sls do
      actions =
        Repo.all(
          from(
            s in StockMovement,
            where: s.product_id == ^item.product_id and s.location_id == ^item.location_id,
            select: %{action: s.action, qty: sum(s.quantity)},
            group_by: [s.action]
          )
        )

      final_qty =
        Enum.reduce(
          actions,
          %{onhand: 0, ordered: 0, available: 0},
          fn list_item, acc ->
            Settings.count_inventory(list_item, acc)
          end
        )

      case WebAcc.Settings.update_stock_level(item, final_qty) do
        {:ok, item} ->
          IO.inspect(item)
          nil

        {:error, cg} ->
          nil
      end
    end
  end
end
