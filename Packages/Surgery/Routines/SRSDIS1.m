SRSDIS1 ;B'HAM ISC/MAM - DISPLAY ONE ROOM ; [ 09/29/03  10:23 AM ]
 ;;3.0; Surgery ;**100,165**;24 Jun 93;Build 6
PICK W @IOF,!!,"Display of Available Operating Room Time",!!,"1. Display Availability (12:00 AM - 12:00 PM)",!,"2. Display Availability (06:00 AM - 08:00 PM)",!,"3. Display Availability (12:00 PM - 12:00 AM)"
 W !!,"Select Number: 2//  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 S:X="" X=2 I X<1!(X>3) D HELP G PICK
 S SRDTYPE=X D HDR
 S SRDT=SRSDATE F SRDAZE=0:1:14 S X1=SRDT,X2=SRDAZE D C^%DTC S SRSDATE=X,SRDATE=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3)_" " D LINE
 Q
HDR W @IOF,!!,"Operating Room: "_SROOM,?25,$S(SRDTYPE=2:"     (6:00 AM - 8:00 PM)",SRDTYPE=1:" (12:00 AM - 12:00 PM)",1:" (12:00 PM - 12:00 AM)"),!!,"DATE "
 I SRDTYPE=2 W "    6    7    8    9   10   11   12   13   14   15   16   17   18   19   20" Q
 I SRDTYPE=1 W "    12   1    2    3    4    5    6    7    8    9   10   11   12" Q
 W "    12   13   14   15   16   17  18   19   20   21   22   23   24"
 Q
LINE ; display graph for each room
 I '$D(^SRS(SROR,"S",SRSDATE,1)) D GRAPH(SRSDATE,SROR)
 S START=$S(SRDTYPE=2:41,SRDTYPE=1:11,1:71),END=$S(SRDTYPE=2:111,SRDTYPE=1:71,1:500)
 W !,SRDATE,$E(^SRS(SROR,"S",SRSDATE,1),START,END)
 Q
GRAPH(SRSDATE,SROR) ; set graph in ^SRS
 S ^SRS(SROR,"S",SRSDATE,0)=SRSDATE,^SRS(SROR,"SS",SRSDATE,0)=SRSDATE
 S X=$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S ^SRS(SROR,"S",SRSDATE,1)=X_"  |____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|",^SRS(SROR,"SS",SRSDATE,1)=^SRS(SROR,"S",SRSDATE,1)
 D DIS1^SRSBUTL  ;;3*165-RJS
 Q
HELP W !!,"Enter the number corresponding to portion of the display graph of available",!,"operating room time that you want to view.  If you want to view the room"
 W !,"between the hours of 6:00 AM and 8:00 PM, enter '2'.  A display of available",!,"operating room time will then appear on your screen."
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
