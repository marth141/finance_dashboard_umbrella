defmodule FinanceDashboardWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  import Phoenix.HTML

  @doc """
  Renders a component inside the `FinanceDashboardWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, FinanceDashboardWeb.BillLive.FormComponent,
        id: @bill.id || :new,
        action: @live_action,
        bill: @bill,
        return_to: Routes.bill_index_path(@socket, :index) %>
  """
  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(_socket, FinanceDashboardWeb.ModalComponent, modal_opts)
  end

  def my_date_select(form, field, opts \\ []) do
    builder = fn b ->
      ~E"""
      <div class="flex space-x-4">
        <div class="flex-initial">
          <%= b.(:day, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %>
        </div>
        <div class="flex-initial">
          <%= b.(:month, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %>
        </div>
        <div class="flex-initial">
          <%= b.(:year, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %>
        </div>
      </div>
      """
    end

    Phoenix.HTML.Form.date_select(form, field, [builder: builder] ++ opts)
  end

  def my_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      ~E"""
      <div class="flex space-x-4">
      Date: <%= b.(:day, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %> / <%= b.(:month, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %> / <%= b.(:year, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %>
      Time: <%= b.(:hour, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %> : <%= b.(:minute, [class: "mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"]) %>
      </div>
      """
    end

    Phoenix.HTML.Form.datetime_select(form, field, [builder: builder] ++ opts)
  end
end
