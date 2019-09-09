## Requirements: 
- docker should be installed 

## How to run: 
- configure browsers in "./browsers_config/browsers.json" file - [see how](https://github.com/aerokube/selenoid/blob/master/docs/browsers-configuration-file.adoc)
- VNC needed ? Add "enableVNC: true" capability to your browser in test framework.
- configure ports and browsers limit in "./docker-compose.yml" file.
- run "bash start.sh"
- do your stuff 
- run "bash stop.sh"