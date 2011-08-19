DGREGG ;ALB/MRL,LBD - CONTINUATION OF REGISTRATION PROCESS ;16 AUG 88@1303
 ;;5.3;Registration;**565**;Aug 13, 1993
 K DEF S DEF=0 W !! I $D(^DPT(DA,.15))#10,$P(^(.15),"^",2)?7N W !,"Patient is ineligible for benefits." S DEF(1)=1,DEF=1
 I $D(^DPT(DA,.32))#10,$P(^(.32),"^",4)>1 W $S($D(DEF)\10:", He",1:"Patient") W:$X>70 ! W " did not receive an honorable discharge." S DEF(3)=1,DEF=1
 I DEF W !!
 S Y=0,A=$G(^DPT(DFN,.32)) F I=6,11,16 I $P(A,U,I) S:($P(A,U,I)'<2800908) Y=$P(A,U,I) I $P(A,U,I)<2800908 S Y=0 Q
 I Y D
 .X ^DD("DD") W !,"Entered Service ",Y
 .W !,"Veteran must have completed at least 24 consecutive months of active"
 .W !,"military service. If veteran meets an exception to minimum duty requirements"
 .W !,"as listed on www.va.gov/elig, veteran is eligible for VA health care."
 .W !,"Otherwise, enter Ineligible Date and Reason on Screen 10 -- veteran is"
 .W !,"eligible for care of SC conditions only.",!
 .K A
 Q
