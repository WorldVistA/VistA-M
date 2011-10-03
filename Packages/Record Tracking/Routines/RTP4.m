RTP4 ;MJK/TROY ISC;Charge Out Pull List; ; 5/15/87  11:06 AM ;
 ;;2.0;Record Tracking;**3,46**;10/22/91 ;Build 46
6 ;Charge Out Pull List
 I '$D(RTAPL) D MES Q
 S RTRD(1)="Yes^designate requests as 'not fillable'",RTRD(2)="No^not designate any requests as 'not fillable'",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Do you wish to first designate some requests as 'not fillable'? "
 D SET^RTRD K RTRD Q:$E(X)="^"  I $E(X)="Y" D 5^RTP1
 D DIV G Q:'$D(RTDV) S RTMES="CHARGED OUT" D PULL^RTP6 K RTMES G Q:'$D(RTPULL)
 ;ask holding area
 K RTB D BOR^RTP40 G Q:$D(RTESC) I $D(RTB) S RTHOLD=""
 ;ask for perpetual records if RR
 S (RTYES,RTACCN)=""
 I $D(RTHOLD)!('$D(RTIRE))
 E  D BOR^RTP41 K DIC G Q:$S('$D(RTB):1,RTYES["^":1,RTACCN["^":1,1:0)
 ;
 I RTPULL="ALL" W !!?5,"*** Printing an 'UPDATE' listing maybe a good idea ***",!?5,"*** before charging out these records.             ***"
 S RTRD(1)="Yes^continue charge out process",RTRD(2)="No^stop charge out process",RTRD("A")="Are you sure you want to 'CHARGE OUT' these records? ",RTRD("B")=2,RTRD(0)="S" D SET^RTRD K RTRD G Q:$E(X)'="Y"
 ;
 D NOW^%DTC S RTQUEDT=%,RTVAR="RTACCN^RTFR^RTYES^RTAPL^RTQUEDT^RTDT^RTDV^RTPULL"_$S($D(RTB):"^RTB",1:"")_$S($D(RTIRE):"^RTIRE",1:"")_$S($D(RTHOLD):"^RTHOLD",1:""),RTDESC="Charge Out Pull List",RTPGM="START^RTP4" D ZIS^RTUTL G Q:POP
 ;
START U IO K ^TMP($J),RTP0 S RTBKGRD="",RTALL=+RTPULL,RTBEG=RTDT-.0001,RTEND=$S(RTDT[".":RTDT,1:RTDT_".2359") I $D(RTB),$D(RTHOLD) D ^RTP40 G Q
 I $D(RTB),$D(RTIRE) S ^TMP($J,"RTREQUESTS","RTB")=RTB K RTB
 S RTAG="SCAN" D CHK W @IOF F RTLIST="RTCANCEL","RTMISS" I $D(^TMP($J,RTLIST)) D LIST^RTP41
 W @IOF,!,"PULL LIST CHARGE-OUT LOG" D NOW^%DTC S Y=$E(%,1,12) D D^DIQ W ?51,"RUN DATE: ",Y D LINE^RTUTL3 W ! S RTAG="FILL" D CHK
 ;now go and make perpetual records
 I RTYES,$D(RTIRE),'$D(RTHOLD) D PERP^RTQ41
 ;
Q K RTACCN,RTYES,RTHOLD,DIC,RTAG,DR,RTESC,RTBKGRD,RTPGM,RTPLTY,RTVAR,RTLIST,RTN,RTSSN,RTSTAT,SAVX,RTB,RTC,RTBEG,RTEND,RTDESC,RTALL,RTQUEDT,RTPULL,RTPULL0,RTDV,RTDT,RTDEV
 K ^TMP($J)
 D CLOSE^RTUTL K %DT,DA,D0,DIE,N,A
 K Y,RT,J,RTE,X1,P Q
 ;rtp0,"^",10 is pull list type
CHK I 'RTALL F RTPDT=RTBEG:0 S RTPDT=$O(^RTV(194.2,"C",RTPDT)) Q:'RTPDT!(RTPDT>RTEND)  F RTPULL=0:0 S RTPULL=$O(^RTV(194.2,"C",RTPDT,RTPULL)) Q:'RTPULL  I $D(^RTV(194.2,RTPULL,0)) S RTP0=^(0) I "13"[$E($P(RTP0,"^",10)_"0") D CHKPULL D:Y @RTAG
 I $D(^RTV(194.2,+RTALL,0)) S RTPULL=+RTALL,RTP0=^(0) D CHKPULL D:Y @RTAG
 K RTPULL,RTP0,RTPDT Q
 ;^6 canceled, apl, div
CHKPULL S Y=0,X=RTP0 Q:$S($P(X,"^",6)="x":1,$P(X,"^",15)'=+RTAPL:1,$P(X,"^",12)'=RTDV:1,1:0)  S RTPLTY=$P(X,"^",10)
 I '$D(RTIRE),RTPLTY'=3 S Y=1 Q
 I $D(RTIRE),RTPLTY=3 S Y=1 Q
 Q
SCAN F RTN=0:0 K RT S RTN=$O(^RTV(190.1,"AP",RTPULL,RTN)) Q:'RTN  I $D(^RTV(190.1,RTN,0)) S RTQ=RTN,RTQ0=^(0),RT=+RTQ0 D SET
 Q
 ;
SET I $P(RTQ0,"^",6)="x" S ^TMP($J,"RTCANCEL",$P(RTP0,"^"),RTQ)=RTQ0 Q
 I $D(^RTV(190.2,"AM","m",RT))!($D(^RTV(190.2,"AM","s",RT))) S ^TMP($J,"RTMISS",$P(RTP0,"^"),RTQ)=RTQ0 Q
 S X=+$P(RTQ0,"^",4) Q:'X  S:'$D(^TMP($J,"RTREQUESTS",RT)) ^(RT)=X_"^"_RTQ S:X<^(RT) ^(RT)=X_"^"_RTQ ;;;Q
 ;rte=^(0)^1
 I RTYES,$D(RTIRE),$D(RTPLTY),RTPLTY=3,$D(^RT(RT,0)) S X=$P(^(0),"^") I X]"",'$D(^TMP($J,"RTE",X)) S ^(X)="" Q
 Q
 ;
DIV ;Entry point to determine if pull function is allowed
 ;   with RTAPL and RTDIV defined
 K RTDV,RTDEV I $S('$D(RTDIV):1,'$D(RTFR):1,'$D(^DIC(4,+RTDIV,0)):1,'$D(^DIC(195.1,+RTAPL,"INST",+RTDIV)):1,1:0) D MES Q
 W !!,"Institution: ",$P(^DIC(4,+RTDIV,0),"^") S RTDV=RTDIV,RTDEV=$P(RTFR,"^",6) Q
 ;
MES W !!?3,*7,"This function requires the user to be signed onto the",!?3,"system with INSTITUTION parameters defined.  Please use",!?3,"the Record Tracking Total System Menu to access this option." Q
 ;
FILL S RTCOMR="Pull List: "_$P(RTP0,"^") F RTQ=0:0 S RTQ=$O(^RTV(190.1,"AP",RTPULL,RTQ)) Q:'RTQ  I $D(^RTV(190.1,RTQ,0)),$P(^(0),"^",6)="r" S RTQ0=^(0) D FILL1
 K RTQ,RTQ0,RTCOMR S RTSTAT="c" D STAT^RTP W !?3,"...'",$P(RTP0,"^"),"' pull list has been charged out." Q
 ;
FILL1 Q:$S('$D(^RT(+RTQ0,"CL")):1,+$P(^("CL"),"^",6)>RTQUEDT:1,$P(RTQ0,"^",6)'="r":1,1:0)  I $P(RTP0,"^",16),$P(^("CL"),"^",5)'=$P(RTP0,"^",16) Q
 S RT=+RTQ0 I $D(^TMP($J,"RTREQUESTS",RT)),$P(^(RT),"^",2)=RTQ D:RTPLTY'=3 FILL^RTQ4 D:RTPLTY=3 FILL^RTQ41
 K RT Q
