RTQ1 ;MJK/TROY ISC;Record Request Option; ; 1/30/87  10:11 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
MISS S RTASK=""
MISS1 G MISSQ:'$D(^RT(RT,"CL")),MISSQ:$S('$D(^RTV(195.9,+$P(^("CL"),"^",5),0)):1,$P(^(0),"^")'="2;DIC(195.4,":1,1:0)
 D DEMOS^RTUTL1,LINE^RTUTL3 W *7,!,RTD("N"),"'s ",RTD("T"),"is flagged as 'MISSING'" I '$D(RTASK) D NOASK G MISSQ
 K Y S RTRD(1)="Yes^request record",RTRD(2)="No^do not request record",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you still want to request this record? " D SET^RTRD K RTRD K:$E(X)'="Y" RT D LINE^RTUTL3
MISSQ K RTASK Q
 ;
NOASK ;
 W !?5,"* no processing allowed on the record until flag is removed"
 I $D(^DIC(195.2,+$P(^RT(RT,0),"^",3),0)),$P(^(0),"^",7)'="a",'$D(^XUSEC($S($P(RTAPL,"^",8)]"":$P(RTAPL,"^",8),1:"RTZ XXX"),DUZ)) W !?5,"* please notify the file room if you have found this record"
 D LINE^RTUTL3 K RTD,RT Q
 ;
CANCEL Q:'$D(^RTV(190.1,RTQ,0))!($P(^(0),"^",6)'="x")
 D DEMOS^RTUTL1,LINE^RTUTL3 S X=^RTV(190.1,RTQ,0) W !,"The request (#",RTQ,") for ",RTD("N"),"'s ",RTD("T"),!?10,"was cancelled by ",$S($D(^VA(200,+$P(X,"^",8),0)):$P(^(0),"^"),1:"UNKNOWN")," on " S Y=$P(X,"^",7)
 D DT^DIQ:Y W "." D LINE^RTUTL3 K X,Y,RTD,RTQ Q
 ;
TEST ;This entry point is used by the input transform for the REQUESTOR and
 ;DATE/TIME RECORD NEEDED fields of the REQUESTED RECORDS(190.1) file.
 ;
 S RTZ1="X^RTQ^RTQDT^RT^RTB" D SAVE^RTUTL1 S RT=+^RTV(190.1,DA,0),RTQDT=$S(RTX="RTQDT":X,1:+$P($P(^(0),"^",4),".")),RTB=$S(RTX="RTB":X,1:$P(^(0),"^",5))
 K RTFL F RTCHK=1:1:2 S X=RTZ("X") D @("CHK"_RTCHK) Q:$D(RTFL)
 ;This next line is from the edit request templ. if users ^out of this check. RTFL1 only set by template.
 K RTCHK,RTQ,RTQDT,RT,RTB D RESTORE^RTUTL1
 I $D(RTFL),$D(RTFL1) S X=RTFL1
 Q
 ;
CHK1 ;check for if the borrower already has a request pending for the
 ;record on the same day as the current request
 ;
 F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AC",RT,+$P(RTQDT,"."),RTQ)) Q:'RTQ  I RTQ'=DA,$D(^RTV(190.1,RTQ,0)),$P(^(0),"^",6)="r",$P(^(0),"^",5)=RTB,$S('$D(RTPULL):1,$P(^(0),"^",10)=RTPULL:1,1:0) S Y=^(0) K X Q
 Q:$D(X)  D LINE^RTUTL3
 W !,*7,"Borrower already has a request pending for this record on this date:",!?5,"User Requesting Record : ",$S($D(^VA(200,+$P(Y,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN"),!?5,"Date Request was Filed : " S Y=$P(Y,"^",2) D D^DIQ W Y
 S Y=$P(^RTV(190.1,RTQ,0),"^",4) D D^DIQ W !?5,"Record Request Number  : ",RTQ,!?5,"Date/Time Record Needed: ",Y D LINE^RTUTL3,ASK Q
 ;
CHK2 ;check to see if the REQUESTOR is the CURRENT BORROWER
 ;if so, then checks to see if the request is too soon. If too soon, then
 ;does not allow request. Otherwise, user is asked if they still want
 ;to make the request.
 ;
 Q:$S('$D(^RT(RT,"CL")):1,$P(^("CL"),"^",5)'=RTB:1,1:0)  S X=RTQDT D H^RTUTL3 Q:X<0
 S Y=$H,Y1=+$P(Y,",")*24*3600,Y1=Y1+$P(Y,",",2),X1=+$P(X,",")*24*3600,X1=X1+$P(X,",",2),Y=X1-Y1
 I Y<$S('$D(^RT(RT,0)):7200,'$D(^DIC(195.2,+$P(^(0),"^",3),0)):7200,1:$P(^(0),"^",13)*60) S RTFL=""
 D LINE^RTUTL3 W !,"REQUESTOR is the CURRENT BORROWER of the record."
 S Y=^RT(RT,"CL"),U1=+$P(Y,"^",7),Y=+$P(Y,"^",6) D D^DIQ W !?5,"DATE/TIME Record was CHARGED to Requestor: ",Y,!?5,"USER RESPONSIBLE for the Charge          : ",$S($D(^VA(200,U1,0)):$P(^(0),"^"),1:"UNKNOWN") K U1
 I $D(RTFL) W !!,"Request is not allowed for date/time specified. TOO SOON!"
 D LINE^RTUTL3,ASK:'$D(RTFL) Q
 ;
ASK I RTX="RTB" S Y=RTB D BOR^RTB
 I RTX="RTQDT" S Y=RTZ("X") D D^DIQ
 S RTRD(1)="Yes^make the record request for "_Y,RTRD(2)="No^select another time for the request ",RTRD("B")=2,RTRD("A")="Do you still wish to make the request for "_Y_"? ",RTRD(0)="S"
 D SET^RTRD K RTRD,RTFL S:$E(X)'="Y" RTFL="" Q
