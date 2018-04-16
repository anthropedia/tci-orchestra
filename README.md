# TCI Factory

Manage all microservices together.


## Install

run `make install env=dev` (or _prod_ accordingly).


## Setup

Take the appropriate _Procfile_ depending on your env.
`ln -s Procfile.dev Procfile` or `ln -s Procfile.prod Procfile`

Configuration is individual in each project. Env variables can be passed in
the command line of the Procfile.


## Running

Just use your favorite Procfile runner like [Procman](https://theforeman.org/)
and start the projects: `foreman start`.
