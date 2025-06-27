---
description: >-
  The goal of this guide is to help other node operators set up a grafana
  dashboard that monitors things in Layer such as average gas price for
  submitting a report, block times, total bonded tokens, and
hidden: true
---

# Setting up a Grafana Dashboard for your Layer Node

1. Navigate to your node’s home config folder and use your text editor of choice to edit config.toml
   1. Adjust the "Instrumentation Configuration Options" by setting `prometheus = true`. If port 26660 is unavailable, modify the `prometheus_listen_addr` field as
2. Open up app.toml and find the “**Telemetry Configuration**” section
   1. Set enabled to true, Set the prometheus\_retention\_time field to 60, and define a global label for the chain id.
3. Restart your node so that these changes can be applied
4. Install and set up a Prometheus server on the same machine or a different one
   1. I used these [docs](https://prometheus.io/docs/prometheus/latest/installation/?utm_source=chatgpt.com) to set mine up, but there is tons of documentation for setting up a prometheus server.&#x20;
5. Configure prometheus.yml to scrape your node for metrics
   1. Set Global Labels at the top of the file with the following `values: scrape_interval: 5s`, `evaluation_interval: 10s`, and `scrape_timeout: 4s`
   2. When setting up the scrape\_config section set the scrape\_interval to 5s, set your node IP address pointing to the port you set in step 1, and then add a params section where you will need to add `format: [‘prometheus’]` in order for grafana to be able to use the data.
6. Start your prometheus server
7. We are now ready to start setting up the grafana dashboard so you will need to either use grafana cloud or you can do what I did and host it yourself (here are some good docs for hosting your own [grafana server](https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/))
8. Once you have your grafana server set up navigate to its front end and add your prometheus server as a data source.
   1. Click “**Add new connection**” in the “**Connections**” section of the side bar
   2. Use the search bar to find the “**prometheus**” data source
   3. Set the prometheus server URL to your prometheus server (Ex: [http://{IP\_ADDRESS}:9090](about:blank))
   4. Adjust the internal behavior section to set the `scrape_interval` field to 15s and the `query_timeout` field to 60s
   5. Click “**Save and test**” at the bottom to verify it is working and save it for you to be able to use in your dashboard.
9. Go to the Dashboards page and click the new button and then select to import a dashboard and then use this [json file](https://github.com/tellor-io/layer/blob/main/layer_grafana_dashboard.json).
10. After the dashboard loads you will notice a lot of errors and that is expected. You will need to set up the panels to use the datasource that you just created.
    1. To set the data source of a panel click on the 3 vertical dots in the upper right hand corner of the panel and then select edit. Once you do that just select your data source from the drop down and click “**Run queries**” to verify that it works and then save the dashboard.
    2. You will most likely need to do this for each panel or once you figure out one you may be able to edit the dashboard json directly to add the right data source uid to each panel.
11. Once you have the data sources set up for everything you are good to go and are free to change anything and use any tool that grafana offers. And if you set up anything cool on your dashboard and want to share feel free to come to our discord to share it with other validators.
