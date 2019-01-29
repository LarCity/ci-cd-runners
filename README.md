# LarCity Runners for Frontend Projects

This project was started to provide images that can be utilized to run GCP-side builds for LarCity app projects.

## nginx-angular-cli

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
