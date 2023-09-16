# nCompass | Order-staging Dashboard

## Authors

Nathan Cox (<nate@campswim.co>)  
Chad Larson (<chad@ncompass.org>)

## Description

The nCompass order-staging dashboard tracks orders through their full lifecycle, from origination to database storage, with built-in error tracking and resolution, authentication, and authorization. Its custom graphQL API manages the compiling and relaying of data between the frontend and the databases used in the project.

## Locations

1. Front-end
    - URL
      - Local development: `http://localhost:3000/`
      - Manual deploy: `http://hulk.yoli.net:3001/`
      - CI/CD deploy: `http://hulk.yoli.net:3002/`
    - On the server
      - :3001: C:\inetpub\wwwroot\Dashboard APP\build\
      - :3002: C:\web\STAGE\ErpStageDashboard\
2. Back-end
    - URL
      - Local development: `http://localhost:4000/graphql/`
      - Manual deploy: `http:/hulk.yoli.net:4000/graphql/`
      - CI/CD deploy: N/A
    - On the server
      - Manual deploy: C:\inetpub\wwwroot\Dashboard API\
      - CI/CD: N/A

## To Run the App Locally

- run `npm i` from the program's root directory on the command line to install its dependencies.
- add the required environment variables in a dotenv file.
- Currently, the frontend requires Node version 16.10.0 or lower. To change the Node version you're using from the command line, type nvm use 16.10.0. (If you don't have NVM, you can install it by following [these instructions for your device](https://www.freecodecamp.org/news/node-version-manager-nvm-install-guide/).)
- run `npm start` from the CLI in separate terminal windows for both the front- and backends.

## To deploy the App Manually

1. Frontend
  
    - With the right environment variables extant in the .env file, run `npm run build` from the command line.
    - Copy the build folder.
    - RDP into the Hulk server and delete the current build folder.
    - Paste the new build folder into the same directory.

2. Backend

    - Copy the relevant folders and files from the local development environment.
    - RDP into the server.
    - Stop the service that runs the app by running `pm2 stop index.js` on the command line from the APP's root directory.
    - Delete all the files in the root directory.
    - Paste the new files into the root directory.
    - Run `npm i` from the command line at the root directory.
    - Run `pm2 start index.js --watch` from the root directory to start the app back up.

## To deploy the App via CI/CD (which has yet to be implemented)

1. Either push directly to main or perform a pull request from another branch to main.
2. Wait a few seconds and test the site.
3. Note: Because the pipeline is set up via Azure DevOps, in order to avoid the difficulties and potential side effects of punching a hole in the firewall of the IIS server in order to SSH in from a third-party website (like bitbucket), only the server administrator can see whether the build was successful or, more important, wasn't and why.
4. Currently, CI/CD is only set up for the frontend, not the backend, and has yet to be fully implemented with environment variables and a step that deletes the pre-existing files, instead of copying over them--they end up being merged, breaking the app. For any changes to effect on the backend, a step in the pipeline that stops and restarts the pm2 service that runs it will be required, as well.
