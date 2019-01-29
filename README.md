# LarCity Runners for Frontend Projects

This project was started to provide images that can be utilized to run GCP-side builds for LarCity app projects.

Each of the runners will have a build configuration included in the `docker-compose.yml` file, starting with the `nginx-angular-cli` runner.

## nginx-angular-cli

**Dockerfile** `nginx-angular-cli.dockerfile`

This runner provides the following libaries:

- @angular/cli v7.x
- npm 6.x / node 8.x
- yarn

As well as bootstraps NGINX to host a (demo) static web project, built to `[project_root]/dist/www`.

```bash
.
├── dist
├── docker-compose.yml
├── nginx-angular-cli.dockerfile
├── nginx.conf
├── node_modules
├── package.json
├── public
├── README.md
├── runners.code-workspace
├── src
├── webpack.config.js
└── yarn.lock
```
