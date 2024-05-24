# AI2_MarsRoverPlanning

Project developed for the Artificial Intelligence 2 course at UniGe.
The aim of this project was to develop a pddl domain and problem for a mars rover which has to compute acquisitions of soil samples, analyze it and send the results to the earth base.
The rover is equipped with a series of advanced sensors (including spectrometers, multispectral cameras and radar for analysis activities, and stereoscopic cameras and IMU for navigation) and sophisticated data processing capabilities.


![MarsRover](https://github.com/FrancescoRac/AI2_MarsRoverPlanning/assets/93876265/13f81270-13d0-4d46-9414-0e02c24bc466)


## Actions Implemented

### Navigation and Positiong

### *Move(location1, location2)*
This action is used to move from one location to another. 
To compute this action the rover must have the position sensor activated and it has to be destabilized.

### *Activate_pos_sensor(base, IMU, stereocamera)*
This action is used to activate the sensors used for navigation. This action can only be activated when the rover is in the base.

### *Destabilize(location, IMU, stereocamera)*
This action is used to destabilize the rover once the position sensors are activated.


### *Move(location1, location2)*
This action is used to move from one location to another. 
To compute this action the rover must have the position sensor activated and it has to be destabilized.


### *Stabilize*
This action is used to stabilize the robot, means that the robot can't move anymore until Destabilize action happen.


### *Untack*


### *Positionate_ee*


### *Activate_a_sensor*


### *Acquire_data*


### Deactivate_a_sensor


### Retract


### Analayze_spectrocamera


### Analayze_radar


### Analayze_multicamera


### Prepare_trasmission


### Deactivate_pos_sensor


### Send_data


### Close_trasmission















