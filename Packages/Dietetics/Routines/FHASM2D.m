FHASM2D ; HISC/REL - Target Weight - Anthropometric/Hamwi ;4/10/90  08:16
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
A ; Anthropometric Weight Calculation (Chumlea, 1988)
 S EXT="Y" D ANT^FHASM3
 S Y="" I ACIR=""!(CCIR="") W *7,!!,"Need Arm & Calf Circumference, at a minimum, to compute weight." Q
 G A1:SCA="",A2:KNEE="",A3
A1 I SEX="M" S Y=2.31*ACIR+(1.5*CCIR)-50.1 G A4
 S Y=1.63*ACIR+(1.43*CCIR)-37.46 G A4
A2 I SEX="M" S Y=1.92*ACIR+(1.44*CCIR)+(.26*SCA)-39.97 G A4
 S Y=.92*ACIR+(1.5*CCIR)+(.42*SCA)-26.19 G A4
A3 I SEX="M" S Y=1.73*ACIR+(.98*CCIR)+(.37*SCA)+(1.16*KNEE)-81.69 G A4
 S Y=.98*ACIR+(1.27*CCIR)+(.4*SCA)+(.87*KNEE)-62.35 G A4
A4 S Y0=+$J(Y*2.2,0,0),Y=+$J(Y*2.2,0,1)
 W !!,"Calculated Weight: ",$S(FHU="M":+$J(Y/2.2,0,0)_"kg",1:Y0_"#") Q
K ;Estimating Stature from Knee Height for Persons 60 to 90
 ;Years of Age by William Cameron Chumlea, PhD
 S KNEE=+$J(Y*2.54,0,1)
 I AGE<60 W !,*7,"Can only calculate knee height for persons aged 60 or older" S Y=-1 Q
 S A1=Y*2.54
 I SEX="M" S A1=60.65+(2.04*A1)
 I SEX="F" S A1=84.88+(1.83*A1)-(.24*AGE)
 S Y=$J(A1/2.54,0,0)
 S X1=$S(Y\12:Y\12_"'",1:"")_$S(Y#12:" "_(Y#12)_"""",1:""),X2=+$J(Y*2.54,0,0)_" cm"
 W "  (",$S(FHU'="M":X1,1:X2),")" Q
H ; Hamwi tARGET Weight
 ; Hamwi,George J. Therapy: Changing Dietary Concepts in Diabetes Mellitus:
 ; Diagnosis and Treatment, Vol. 1, Edited by T.S. Danowski.
 ; Amer. Diabetes Assn., 500 5th Ave, NYC, NY 10020, 1964, 73-78.
 S A1=$S(FRM="S":0.9,FRM="L":1.1,1:1)
 I SEX="M" S IBW=HGT-60*6+106*A1
 I SEX="F" S IBW=HGT-60*5+100*A1
 G ED
ED S X1=$S(FHU'="M":+$J(IBW,0,0)_" lb",1:+$J(IBW/2.2,0,1)_" kg")
E1 W !!,"Select Target Body Weight: ",X1,"// " R X:DTIME I '$T!(X["^") S IBW="",FHQUIT=1 Q
 Q:X=""  D WGT^FHASM1 I Y<1 D WGP^FHASM1 G E1
 S:IBW'=+Y IBW=+Y,METH="E" Q
