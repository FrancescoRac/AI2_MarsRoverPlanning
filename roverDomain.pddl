;Header and description

(define (domain roverDomain)

;remove requirements that are not needed
    (:requirements 
        :fluents 
        :negative-preconditions
        :existential-preconditions
        :universal-preconditions
        :adl)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    
    imu - pos_sensor
    stereocamera - pos_sensor
    
    multicamera - a_sensor
    spectrocamera - a_sensor
    radar - a_sensor
    
    base - location
    
    soil
    
    zero - configuration
    
)

(:predicates ;todo: define predicates here
    
    (connection ?l1 - location ?l2 - location) ; connection between locations
    
    (in ?l - location) ; to say the rover is in a location
    
    (deactive_pos_sensor ?s - pos_sensor) ; to say a positional sensor is deactivate
    
    (deactive_a_sensor ?s - a_sensor) ; to say a analyzer sensor is deactivate
    
    (stabil ) ; to say that the rover is stabil
    
    (retract_arm ) ; to say the arm of the robot is retract
    
    (at ?c - configuration) ; to say the end effector of the robot is at a specific configuration
    
    (on ?soil - soil ?l - location) ; to say a soil sample is on a location
    
    (acquiring ?l - location ?soil - soil ?s - a_sensor) ; to say a sensor is acquiring a soil in a specific location 
    
    (go ?c1 - configuration ?c2 - configuration) ; to go from one configuration to another
    
    (positionated) ; to say the end effector is positionated
    
    (sensorsoil ?s - a_sensor ?soil - soil ?c - configuration) ; to say the rover is going to acquire soil with a specific sensor in a specific configurration
    
    (analyze ?s - a_sensor ?soil - soil) ; to say a sensor analyze specific soil
    
    (prepare_trasmission ?soil - soil) ; to say the rover is preparing trasmission for a soil sample
    
    (trasmission ?soil - soil) ; 
    
    (done_radar ?soil - soil)(done_multicamera ?soil - soil)(done_spectrocamera ?soil - soil) ; to say a specific sensor has analyzed a soil sample
    
    (send ?soil - soil) ; to say the rover have to send a soil sample

    (pos_sensor_off) ; to say position sensors are off
    
    (twice ?s - a_sensor ?soil - soil ) ; to compute acquisition of data two times
    
    (acquiredTwice ?s - a_sensor ?soil - soil)
)

;Actions

(:action activate_pos_sensor
    :parameters (?l - location ?s1 - imu ?s2 - stereocamera)
    :precondition (and (in ?l) (deactive_pos_sensor ?s1) (deactive_pos_sensor ?s2) )
    :effect (and (in ?l) (not(deactive_pos_sensor ?s1)) (not(deactive_pos_sensor ?s2))(not(pos_sensor_off)) )
)



(:action destabilize
    :parameters (?l - location ?s1 - imu ?s2 - stereocamera)
    :precondition (and (in ?l) (stabil ) (not(deactive_pos_sensor ?s1)) (not(deactive_pos_sensor ?s2)) (retract_arm) )
    :effect (and (in ?l) (not(stabil)) )
)



(:action move
    :parameters (?from - location ?to - location )
    :precondition (and (in ?from) (connection ?from ?to) (not(stabil)) (retract_arm ) (not(pos_sensor_off)) )
    :effect (and (in ?to) (not(in ?from))  )
)



(:action stabilize
    :parameters (?l - location)
    :precondition (and (in ?l) (not(stabil)) )
    :effect (and (stabil ) (in ?l)   )
)



(:action untack
    :parameters (?l - location ?soil - soil )
    :precondition (and (in ?l) (retract_arm) (stabil) (on ?soil ?l) )
    :effect (and (not(retract_arm )) (in ?l) )
)



(:action positionate_end_effector
    :parameters(?from - configuration ?to - configuration)
    :precondition(and(at ?from)(not(retract_arm))(go ?from ?to) )
    :effect(and (at ?to) (not(at ?from)) )
)



(:action activate_a_sensor
    :parameters (?l - location ?s - a_sensor ?soil - soil ?c - configuration)
    :precondition (and (in ?l) (deactive_a_sensor ?s) (stabil) (not(retract_arm) ) (at ?c) (on ?soil ?l) (sensorsoil ?s ?soil ?c) )
    :effect (and (in ?l) (not(deactive_a_sensor ?s)) )
)



(:action acquireData
    :parameters (?l - location ?soil - soil ?s - a_sensor ?c - configuration )
    :precondition (and (in ?l) (not(deactive_a_sensor ?s)) (on ?soil ?l) (stabil) (at ?c) (not(twice ?s ?soil)) )
    :effect (and (in ?l) (on ?soil ?l) (acquiring ?l ?soil ?s)  
        (forall (?s1 - a_sensor)
            (when (acquiring ?l ?soil ?s1) 
                (and (acquiredTwice ?s1 ?soil) )
            ) 
        )
        (forall (?c2 - zero) 
            (and (not(at ?c2)) ) 
        )  
    )

)


(:action deactivate_a_sensor
    :parameters (?l - location ?s - a_sensor ?soil - soil ?c - zero)
    :precondition (and (in ?l) (stabil) (not(retract_arm)) (acquiring ?l ?soil ?s) (at ?c) )
    :effect (and (in ?l)  (deactive_a_sensor ?s)  )
)

(:action retract
    :parameters (?l - location ?s - a_sensor ?soil - soil ?ci - zero)
    :precondition (and (in ?l) (acquiring ?l ?soil ?s) (not(retract_arm)) (stabil) (at ?ci) (deactive_a_sensor ?s) (forall (?s - a_sensor) (deactive_a_sensor ?s) ))
    :effect (and (in ?l) (retract_arm) )
)

(:action analyze_spectrocamera
    :parameters (?l - location ?soil - soil ?s - spectrocamera )
    :precondition (and (in ?l) (retract_arm) (stabil) (acquiring ?l ?soil ?s) (deactive_a_sensor ?s) (acquiredTwice ?s ?soil) )
    :effect (and (analyze ?s ?soil) (in ?l)(done_spectrocamera ?soil) )
)

(:action analyze_multicamera
    :parameters (?l - location ?soil - soil ?s - multicamera )
    :precondition (and (in ?l) (retract_arm) (stabil) (acquiring ?l ?soil ?s) (deactive_a_sensor ?s) (acquiredTwice ?s ?soil) )
    :effect (and (analyze ?s ?soil) (in ?l)(done_multicamera ?soil))
)

(:action analyze_radar
    :parameters (?l - location ?soil - soil ?s - radar)
    :precondition (and (in ?l) (retract_arm) (stabil) (acquiring ?l ?soil ?s) (deactive_a_sensor ?s) (acquiredTwice ?s ?soil))
    :effect (and (analyze ?s ?soil) (in ?l) (done_radar ?soil) )
)

(:action prepare_trasmission
    :parameters (?soil - soil ?l - base)
    :precondition (and (done_radar ?soil)(done_multicamera ?soil)(done_spectrocamera ?soil) (in ?l) (stabil))
    :effect (and (prepare_trasmission ?soil))
)


(:action deactivate_pos_sensor
    :parameters (?l - base ?s1 - imu ?s2 - stereocamera)
    :precondition (and (not(deactive_pos_sensor ?s1)) (not(deactive_pos_sensor ?s2)) (in ?l) )
    :effect (and (pos_sensor_off ) (deactive_pos_sensor ?s1) (deactive_pos_sensor ?s2) )
)


(:action send_data
    :parameters (?l - base ?soil - soil)
    :precondition (and (in ?l) (stabil)(prepare_trasmission ?soil) (pos_sensor_off) )
    :effect (and (in ?l) (stabil) (send ?soil)  )
)

(:action close_trasmission
    :parameters (?l - base ?soil - soil)
    :precondition (and (in ?l) (stabil) (send ?soil) (pos_sensor_off) )
    :effect (and (trasmission ?soil))
)


)

