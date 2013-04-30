DGREGG ;ALB/MRL,LBD - CONTINUATION OF REGISTRATION PROCESS ; 3/10/11 4:32pm
 ;;5.3;Registration;**565,797**;Aug 13, 1993;Build 24
 N DEF,DGDISTYP,DGSED,Y
 S DEF=0 W !! I $D(^DPT(DFN,.15))#10,$P(^(.15),"^",2)?7N W !,"Patient is ineligible for benefits." S DEF(1)=1,DEF=1
 ;Get Military Service Data (DG*5.3*797)
 D GETMSE
 I DGDISTYP>1&(DGDISTYP<9) W $S($D(DEF)\10:", He",1:"Patient") W:$X>70 ! W " did not receive an honorable discharge." S DEF(3)=1,DEF=1
 I DEF W !!
 S Y=0 F I=1:1:3 I $G(DGSED(I)) S:(DGSED(I)'<2800908) Y=DGSED(I) I DGSED(I)<2800908 S Y=0 Q
 I Y D
 .X ^DD("DD") W !,"Entered Service ",Y
 .W !,"Veteran must have completed at least 24 consecutive months of active"
 .W !,"military service. If veteran meets an exception to minimum duty requirements"
 .W !,"as listed on www.domain.ext/elig, veteran is eligible for VA health care."
 .W !,"Otherwise, enter Ineligible Date and Reason on Screen 10 -- veteran is"
 .W !,"eligible for care of SC conditions only.",!
 .K A
 Q
 ;
GETMSE ;Get Last Discharge Type and Service Entry Dates (DG*5.3*797)
 N DGMSE,I,J
 ;Get MSE data from MSE sub-file #2.3216, if it exists
 I $D(^DPT(DFN,.3216)) D  Q
 .D GETMSE^DGMSEUTL(DFN,.DGMSE)
 .S DGDISTYP=$P($G(DGMSE(1)),U,6)
 .F I=1:1:3 S DGSED(I)=$P($G(DGMSE(I)),U)
 ;otherwise, get MSE data from .32 node
 S DGMSE=$G(^DPT(DFN,.32))
 S DGDISTYP=$P(DGMSE,U,4)
 F I=1:1:3 S J=5*I+1,DGSED(I)=$P(DGMSE,U,J)
 Q
