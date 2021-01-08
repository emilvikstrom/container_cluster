FROM bitwalker/alpine-elixir-phoenix:latest
RUN mix local.hex --force
COPY . /app
WORKDIR /app
EXPOSE 4000 4369 4711 
ENV ERL_AFLAGS="-sname app -cookie secret -kernel inet_dist_listen_min 4711 net_nest_listen_max 4711"
RUN mix compile
CMD ["/app/entrypoint.sh"]
