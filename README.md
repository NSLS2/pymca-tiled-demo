# PyMca with Tiled

This project demonstrates how to use PyMca with an existing Tiled server.
It uses a fork of the PyMca project and two public NSLS-II Tiled servers.


## Getting started

Clone this repo locally and use 
[pixi](https://pixi.prefix.dev/v0.50.2/installation/)
to launch PyMca.

```shell
git clone https://github.com/nsls2/pymca-tiled-demo
cd pymca-tiled-demo
pixi run start
```

Click the Bluesky logo button on the data source selector panel to connect to
the tiled server. Browse the contents, double-clicking to enter a container, and
clicking the breadcrumbs to navigate to a parent container. 

When a Bluesky catalog of runs is selected, the "Open" button will be enabled.
An example at NSLS-II is "cms/raw".
Click "Open" to load the list of Bluesky runs in that catalog.

Select a run from the table and click "Import Data".
The data channels from the "primary" stream of that run will be listed in the
lower table.

Select one channel as an "X" axis and one or more channels as "Y" axes, then
click "ADD" to plot the selected data. The data plots are visible within the
"SCAN" plot in the "Main Window".


## Launch with a Tiled profile

Several Tiled profiles are preconfigured in the "profiles" directory of this
repo. Adding or editing profiles within this directory will make them available
to PyMca.

Launch PyMca with a known profile using pixi.

```shell
# Use the profile for CHX beamline data
pixi run pymca chx
```

Click the Bluesky logo button on the data source selector panel to connect to
the tiled server and automatically load Bluesky runs from the CHX beamline.

### Available Tiled profiles

See a list of Tiled profiles that are available by running a pixi task.

```shell
pixi run profiles
```


## Launch with the public Tiled demo server

A collection of example data is hosted as a public Tiled demonstration at
<https://tiled-demo.nsls2.bnl.gov>.

Launch PyMca and connect to the demo server using pixi.

```shell
pixi run demo
```


## Verbose logging in debug mode

Launch PyMca in debug mode using pixi.

```shell
pixi run debug  # Use the default Tiled profile

# Or launch with a different profile
pixi run debug bmm  # Load the BMM beamline data
```
