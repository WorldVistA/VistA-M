SRSDISP ;B'HAM ISC/MAM - SELECT GRAPH DISPLAY ; [ 04/03/00  1:33 PM ]
 ;;3.0; Surgery ;**50,94,165**;24 Jun 93;Build 6
PICK W @IOF,!!,"Display of Available Operating Room Time",!!,"1. Display Availability (12:00 AM - 12:00 PM)",!,"2. Display Availability (06:00 AM - 08:00 PM)",!,"3. Display Availability (12:00 PM - 12:00 AM)"
 W !,"4. Do Not Display Availability"
 W !!,"Select Number: 2//  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 S:X="" X=2 I X<1!(X>4) D HELP G PICK
 S SRDTYPE=X I SRDTYPE<4 D HDR
 S SROR=0 F  S SROR=$O(^SRS(SROR)) Q:'SROR  I '$P(^(SROR,0),"^",6) D:$$ORDIV^SROUTL0(SROR,$G(SRSITE("DIV"))) LINE
 Q
HDR W @IOF,!!,"ROOM"
 I SRDTYPE=2 W "   6AM   7    8    9    10   11   12   13   14   15   16   17   18   19   20" Q
 I SRDTYPE=1 W "   12AM  1    2    3    4    5    6    7    8    9   10   11   12PM" Q
 W "   12PM  13   14   15   16   17   18   19   20   21   22   23   24"
 Q
LINE ; display graph for each room
 I '$D(^SRS(SROR,"S",SRSDATE,1)) D GRAPH
 S X2=1,X1=SRSDATE D C^%DTC I '$D(^SRS(SROR,"S",X,1)) S SRDAT=SRSDATE,SRSDATE=X D GRAPH S SRSDATE=SRDAT K SRDAT
 I SRDTYPE=4 Q
 S X=$P(^SRS(SROR,0),"^"),ROOM=$P(^SC(X,0),"^"),START=$S(SRDTYPE=2:41,SRDTYPE=1:11,1:71),END=$S(SRDTYPE=2:111,SRDTYPE=1:71,1:500)
 W !,$E(ROOM,1,8),?8,$E(^SRS(SROR,"S",SRSDATE,1),START,END)
 Q
GRAPH ; set graph in ^SRS
 S ^SRS(SROR,"S",SRSDATE,0)=SRSDATE,^SRS(SROR,"SS",SRSDATE,0)=SRSDATE
 S X=$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S ^SRS(SROR,"S",SRSDATE,1)=X_"  |____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|",^SRS(SROR,"SS",SRSDATE,1)=^SRS(SROR,"S",SRSDATE,1)
 D DIS1^SRSBUTL  ;;3*165-RJS
 Q
HELP W !!,"Enter the number corresponding to portion of the display graph of available",!,"operating room time that you want to view.  If you are scheduling a case"
 W !,"between the hours of 6:00 AM and 8:00 PM, enter '2'.  A display of available",!,"operating room time will then appear on your screen.  If you do not want to"
 W !,"see a display for any time period, enter '4'.  You will then be asked to",!,"select an operating room."
 W !!,"Press <RET> to continue  " R X:DTIME
 Q
