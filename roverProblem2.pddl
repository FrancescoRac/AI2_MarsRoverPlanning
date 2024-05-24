(define (problem roverProblem) (:domain roverDomain)
(:objects 
    
    base - base
    node1 node2 node3 node4  - location
    
    imu - imu
    stereocamera - stereocamera
    
    spectrocamera - spectrocamera
    multicamera - multicamera
    radar - radar
    
    
    zero - zero
    halfpi pi twopi - configuration
    
    soil1 soil2 soil3 - soil
)

;;;;;;;;;;;; Using these initial conditions the planner computes a plan where one sensor computes two acquisition of a sample 
;;;;;;;;;;;; while the other sensors are used one time in different location (each sensor is used in a different location)

(:init
    ;todo: put the initial state's facts and numeric values here
    
    ; path connection
    (connection base node1) (connection node1 base)
    (connection node1 node2) (connection node2 node1) 
    (connection node2 node3) (connection node3 node2)
    (connection node3 node4) (connection node4 node3)

    ; robot start position
    (in base) (stabil) 
    
    ; at the beginning position sensor must be off
    (deactive_pos_sensor imu) (deactive_pos_sensor stereocamera) 
    (pos_sensor_off)
    ; at the beginning analyzer sensor must be off
    (deactive_a_sensor spectrocamera) (deactive_a_sensor multicamera) (deactive_a_sensor radar)
    
    (retract_arm)
    
    (at zero)
    
    (on soil1 node1) (on soil2 node2) (on soil3 node3)
    
    ;(soilconf soil1 halfpi) (soilconf soil2 pi) (soilconf soil3 twopi)
    
    ; configuration
    (go zero halfpi) (go halfpi zero) 
    (go halfpi pi) (go pi halfpi) 
    (go twopi pi) (go pi twopi)
    
    ;
    (sensorsoil multicamera soil3 twopi)
    ;(sensorsoil spectrocamera soil3 halfpi)
    ;(sensorsoil radar soil3 pi)
    
    (sensorsoil spectrocamera soil2 halfpi)
    ;(sensorsoil radar soil2 twopi)
    
    (sensorsoil radar soil1 halfpi)
    
    
    ; to say where data must not be acquired
    
    (done_radar soil2)
    (done_radar soil3)
    
    (done_multicamera soil1)
    (done_multicamera soil2)
    
    (done_spectrocamera soil1)
    (done_spectrocamera soil3)
    
    ; to say where it is not needed acquire twice
    (acquiredTwice multicamera soil3)
    ;(acquiredTwice spectrocamera soil3)
    (acquiredTwice spectrocamera soil2)
    
    ;(acquiredTwice radar soil1)
    ;(acquiredTwice radar soil2)
    
)

(:goal (and
    ;(in base)
    ;(stabil)
    ;(retract_arm)
    ;(at pi)
    ;(analyze radar soil3)
    
    (forall (?s - soil) (trasmission ?s))
    ;(twice spectrocamera soil3)
    ;(acquiredTwice radar)
    ;(twice radar soil2)
    ;(trasmission soil1)
    
    ;(send soil1)
    ;(trasmission soil2)
    ;(send soil2)
    ;(trasmission soil3)
    ;(send soil3)
    ;(send soil2)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
