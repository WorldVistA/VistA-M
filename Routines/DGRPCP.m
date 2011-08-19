DGRPCP ;ALB/MRL/BAJ - CONSISTENCY PRINT ; OCT 25, 2005
 ;;5.3;Registration;**653**;Aug 13, 1993;Build 2
 ;
 ;DG*5.3*653  BAJ  10/25/2005
 ;modified code to prompt for and process inconsistencies found during Z07 build
 ;Also modified format of report.  Changed to print inconsistency descriptions instead
 ;of numbers.  See DGRPCP1 for detail.
 ;
 ;
 D ON^DGRPC G Q^DGRPCP1:DGER
1 K ^UTILITY($J) D DT^DICRW S Z="^" W !!,"Generate a listing of inconsistent data elements by:",! F I=1:1:3 S J=$P($T(T+I),";;",2),Z=Z_$P(J,"^",1)_"^" W !?4,$P(J,"^",1)
 R !!,"CHOOSE OUTPUT METHOD OR ENTER '^' TO QUIT:  ",X:DTIME S:'$T X="^" D IN^DGHELP G Q^DGRPCP1:X["^"!(X']"") I %=-1 W !!,"The available choices are:",! X "F I=1:1:3 S J=$P($T(T+I),"";;"",2) W !,$P(J,""^"",1),"" - "",$P(J,""^"",2)" G 1
 S DGHOW=X_"^"_$S(X="A":"ADMISSION",X="R":"REGISTRATION",1:"IDENTIFICATION")_" DATE"
D W !! S %DT="EAX",%DT(0)=-DT,%DT("A")="Start with "_$P(DGHOW,"^",2)_":  " D ^%DT G Q^DGRPCP1:Y'>0 S DGFRD=Y
 S Y=DGFRD X ^DD("DD") S %DT("A")="     Go To "_$P(DGHOW,"^",2)_":  "_Y_"// " D ^%DT I X']"" S DGTOD=DGFRD_".9999" G H
 G Q^DGRPCP1:Y'>0 S DGTOD=Y_".9999" I DGFRD>DGTOD W !?4,"TO DATE CAN'T BE BEFORE FROM DATE!!",*7 G D
H K %DT S Z="^NAME^TERMINAL DIGIT" R !!,"List by (N)ame or (T)erminal Digit:  ",X:DTIME S:'$T X="^" D IN^DGHELP G Q^DGRPCP1:X["^"
 I %=-1 W !!?4,"N - To generate listing in Alphabetical Order",!?4,"T - To generate listing in Terminal Digit Order." G H
Z07 S DGHOW1=X,Z="^Registration^Z07 Messages^All" R !!,"List (R)egistration, (Z)07 Messages or (A)ll Inconsistencies:  ",X:DTIME S:'$T X="^" D IN^DGHELP G Q^DGRPCP1:X["^"
 I %=-1 D  G Z07
 . W !!?4,"R - Generate a list of inconsistencies found during Registration"
 . W !?4,"Z - Generate a list of inconsistencies found during Z07 Message build"
 . W !?4,"A - Generate a list of all inconsistencies found"
 S DGFILT=$S("RZ"[X:X,1:"A")
 W !!,*7,"THIS OUTPUT REQUIRES 132 COLUMN OUTPUT" S DGVAR="DUZ^DGHOW^DGHOW1^DGFRD^DGTOD^DGFILT",DGPGM="^DGRPCP1" D ZIS^DGUTQ G Q^DGRPCP1:POP U IO G ^DGRPCP1
T ;
 ;;ADMISSION DATE^Patients admitted during a specified date range.
 ;;IDENTIFICATION DATE^Inconsistencies identified during a specified date range.
 ;;REGISTRATION DATE^Patients registered during a specified date range.
