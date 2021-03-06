defmodule FinanceDashboardWeb.PageLive do
  use FinanceDashboardWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    if is_nil(session["user_token"]) do
      {:ok, socket |> assign(query: "", results: %{}) |> assign(current_user: false)}
    else
      {:ok, socket |> assign(query: "", results: %{}) |> assign_current_user(session)}
    end
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    if not FinanceDashboardWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
