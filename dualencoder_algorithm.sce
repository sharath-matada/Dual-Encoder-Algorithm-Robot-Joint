//definitions
/********************************************************************************************************************************************************************************************/
//Encoder angles
 //Encoder reading between motor and ground - this is a multi turn value(deg)
 theta_motor_ground_multi= 0
 //Encoder reading between motor and output - this is a single turn value(deg)
 theta_motor_output_single = 0
 //Encoder reading between motor and output under ideal condition of infinite stiffness - single turn value(deg)
 theta_motor_output_ideal_single = 0
 //Encoder reading between motor and output under ideal condition of infinite stiffness(deg)
 theta_motor_output_ideal = 0

//Note: The theta_motor_ground_multi variable is measured on the input side and the theta_motor_output_single variable is measured on the output side. The direction is hence reversed for measurements made on opposite sides

 //Theoretical output angle measurement(deg)
 theta_output_ground_theo = 0
 //Output angle calculated using the two measurements taken (deg)
 theta_output_ground = 0
//Parameters
//gearratio
r = 80
//torsionalstiffness(Nm/rad)
k = 5.5 * 10e4 
// Load Applied(Nm)
T = 0
//Number of turns
N = 0
//deflection(rad)
d = 0
/***********************************************************************************************************************************************************************************************/
//Inputs
//Enter commanded input angle
 theta_motor_ground_multi = -80
//Enter Torque on the output joint
  T = 0

/***********************************************************************************************************************************************************************************************/
//Readings based on model of the strain-wave gear
theta_output_ground_theo =  -((theta_motor_ground_multi/r)) + ((180/%pi)*(T/k))
printf('Theoretical Output Angle(deg)')
disp(theta_output_ground_theo)

//Under above conditons 
theta_motor_output_single = ((theta_output_ground_theo)- (ceil((theta_output_ground_theo)/360)*360))-((-theta_motor_ground_multi)- (ceil((-theta_motor_ground_multi)/360)*360))

if theta_motor_output_single < 0 then
    theta_motor_output_single = 360 + theta_motor_output_single
end

//theta_motor_ground_multi = 0
//theta_motor_output_single = 359

printf('Multi Turn Encoder Reading(deg)')
disp(theta_motor_ground_multi)

printf('Single Turn Encoder Reading(deg)')
disp(theta_motor_output_single)

/************************************************************************************************************************************************************************************************/
//The below equations use only single turn encoder reading, multi-turn encoder reading to calculate output angle and gear ratio

theta_motor_output_ideal = -theta_motor_ground_multi*((r-1)/r)
N = ceil(theta_motor_output_ideal/360)
theta_motor_output = -theta_motor_output_single + (N*360)
disp(theta_motor_output)
if (theta_motor_output_ideal-2 <theta_motor_output)&&(theta_motor_output <theta_motor_output_ideal+2) then
    theta_motor_output = theta_motor_output
else
    //disp(theta_motor_output)
    theta_motor_output = (theta_motor_output) + 360
end
theta_output_ground =-(theta_motor_output+theta_motor_ground_multi)
/************************************************************************************************************************************************************************************************/
//Results
printf('Calculated Output Angle using encoder readings(deg)')
disp(theta_output_ground)
/*********************************************************************************************************************************************************************************************/
