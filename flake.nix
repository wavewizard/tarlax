{
  description = "Tarlax Dev Environment";

  inputs = {
    nixpkgs = { url = "nixpkgs/nixos-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
     
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
    let
      pkgs = import nixpkgs {inherit system; };
      beamPkgs = with pkgs.beam; packagesWith interpreters.erlang_27;
      inotify = pkgs.inotify-tools;
      postgres = pkgs.postgresql;
    in
    with pkgs;
      {devShell = let
         psql_setup_file = pkgs.writeText "setup.sql" ''
         DO
         $do$
         BEGIN
          IF NOT EXISTS ( SELECT FROM pg_catalog.pg_roles WHERE rolname = 'tarlax') THEN
            CREATE ROLE managemate CREATEDB LOGIN;
          END IF;
          END
         $do$'';
         postgres_setup = ''
         export PGDATA=$PWD/postgres_data
         export PGHOST=$PWD/postgres
         export LOG_PATH=$PWD/postgres/LOG
         export PGDATABASE=postgres
         export DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true
         export PG_TRUST_LOCALNET=true
         if [ ! -d $PGHOST ]; then
            mkdir -p $PGHOST
          fi
          if [ ! -d $PGDATA ]; then
           echo 'Initializing postgresql database...'
          LC_ALL=C.utf8 initdb $PGDATA --auth=trust >/dev/null
          fi'';
         start_postgres = pkgs.writeShellScriptBin "start_postgres" ''
         pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
         psql -f ${psql_setup_file} > /dev/null'';
         stop_postgres = pkgs.writeShellScriptBin "stop_postgres" ''
         pg_ctl -D $PGDATA stop'';
        in pkgs.mkShell {
          buildInputs = [
            beamPkgs.erlang
            beamPkgs.elixir_1_17
            postgres
            inotify
            glibcLocales
            postgresql
            start_postgres
            stop_postgres
            vscode
          ];

          shellHook = '' ${postgres_setup}
            ${start_postgres}'';
        };
      });
}
