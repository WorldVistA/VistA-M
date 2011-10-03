RTRAD ;MJK/TROY ISC;Radiology Specific Setup Menu; ; 4/9/87  12:39 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),3)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A S X="RAD" D ^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Clinic Set-up
 G 1^RTMAS
 ;
2 ;;Imaging Area Set-up
L2 D RA G Q:"^"[X D BOR^RTSYS:Y>0 G L2
Q K DA,D0,DR,DIE,RTBO,X,Y,I Q
RA W ! S DIC="^SC(",DIC("A")="Select Reception/Viewing/Rack Area: ",DIC(0)="IAEMLQ",DIC("DR")="2///I",DIC("S")="I $P(^(0),U,3)=""I""" D ^DIC K DIC Q:Y<0  D CHK^RTDPA3
 Q
 ;
3 ;;Create a Temporary Folder
 Q
 ;DO NOT USE --- POSSIBLE FUTURE OPTION
 W ! S RTRD(1)="Wet Reading^create a wet reading folder",RTRD(2)="Exam^create an temporary exam folder",RTRD(3)="Outside^create an outside film folder",RTRD("B")=1,RTRD("A")="What kind of temporary folder you want to create? "
 D SET^RTRD K RTRD S X=$E(X) G Q3:X="^" S RTPCE=$S(X="W":"3^WET",X="E":"4^TEMPORARY",1:"5^OUTSIDE")
 I $S('$D(^DIC(195.4,1,"RAD")):1,'$D(^DIC(195.2,+$P(^("RAD"),"^",RTPCE),0)):1,1:0) W !!,*7,"'",$P(RTPCE,"^",2),"' folder is not defined in overall system parameter file." G Q3
 S Y=+$P(^DIC(195.4,1,"RAD"),"^",+RTPCE) I $S('$D(^DIC(195.2,Y,"I")):0,'^("I"):0,DT'>^("I"):0,1:1) W !!,*7,"The '",$P(^DIC(195.2,Y,0),"^"),"' record type is inactive." G Q3
 D TYPE1^RTUTL,^RTDPA1
Q3 K RTPCE,RTTY Q
 ;
