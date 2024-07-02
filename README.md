# AI2_MarsRoverPlanning

Project developed for the Artificial Intelligence 2 course at UniGe.
The aim of this project was to develop a pddl domain and problem for a mars rover which has to compute acquisitions of soil samples, analyze it and send the results to the earth base.
The rover is equipped with a series of advanced sensors (including spectrometers, multispectral cameras and radar for analysis activities, and stereoscopic cameras and IMU for navigation) and sophisticated data processing capabilities.


![MarsRover](https://github.com/FrancescoRac/AI2_MarsRoverPlanning/assets/93876265/13f81270-13d0-4d46-9414-0e02c24bc466)


## Actions Implemented

### Navigation and Positiong

* <h4>Activate_pos_sensor(base, IMU, stereocamera):</h4>
This action is used to activate the sensors used for navigation. This action can only be activated when the rover is in the base.

* <h4>Deactivate_pos_sensor:</h4>
This action is used to deactivate position sensor once the rover is on the basis location to send start the trasmission with the earth.
The rover must be stabilized. 

* <h4>Move(location1, location2):</h4>
This action is used to move from one location to another. 
To compute this action the rover must have the position sensor activated and it has to be destabilized.

* <h4>Destabilize(location, IMU, stereocamera):</h4>
This action is used to destabilize the rover once the position sensors are activated.

* <h4>Stabilize:</h4>
This action is used to stabilize the robot, means that the robot can't move anymore until Destabilize action happen.

### Deployment of scientific instrument

* <h4>Untack:</h4>
This action is used to elongate the robotic arm of the rover. 
To compute this action the rover must be stabilized in a location (hopefully in a location where we want to acquire some soil sample.

* <h4>Positionate_ee:</h4>
This action is used to positionate the end effector of the robotic arm in some configuration.
The rover must be stabilized and the robotic arm must be elongated  and the analyzer sensor must be turned off to positionate the end effector.

* <h4>Retract:</h4>
This action is used to retract the robotic arm once soil samples have been acquired.
The rover must be stabilized and the analyzer sensor must be turned off.



### Data collection

* <h4>Activate_a_sensor:</h4>
This action is used to activate an analyzer sensor when necessary.
The rover must be stabilized, the robotic arm elongated and the end effetor positionated.

* <h4>Deactivate_a_sensor:</h4>
This action is used to deactivate an analyzer sensor when it's own task is completed.
The rover must be stabilized, the robotic arm elongated and the end effetor positionated.


### Data processing

* <h4>Analayze_spectrocamera:</h4>
This action is used to compute the analysis of samples acquired with the spectrocamera.
The rover must be stabilized, and it has to have acquired samples.

* <h4>Analayze_radar:</h4>
This action is used to compute the analysis of samples acquired with the radar.
The rover must be stabilized, and it has to have acquired samples.

* <h4>Analayze_multicamera:</h4>
This action is used to compute the analysis of samples acquired with the multicamera.
The rover must be stabilized, and it has to have acquired samples.

### Decision making 

* <h4>Acquire_data:</h4>
Since in certain locations may be necessary to carry out a specific reading twice. This action must be used each time a sensor have to acquire data.
The rover must be stabilized and the arm elongated.


### Data trasmission

* <h4>Prepare_transmission:</h4>
This action is used to perpare the rover at the transmission of the data acquired.

* <h4>Send_data:</h4>
This action is used to send the data acuired once the transmission is ready.

* <h4>Close_transmission:</h4>
This action is used to close the transmission once it the rover has done.














