DVBHQD1 ;ISC-ALBANY/PKE/PHH- HINQ receiver ; 5/15/06 10:58am
 ;;4.0;HINQ;**3,12,16,22,23,32,34,40,46,49,57,56**; 03/25/92 
 ;
 S:'$D(DTIME) DTIME=300 S DVBTIME=DTIME
EN S:$G(IO(0))="" IO(0)=$I S (C,DVBTSK,DVBABORT)=0,DVBXM=1,DTIME=30 U IO(0)
 ;
SEL S (DVBRTC,DVBTRY)=1,DVBNRT="Y"
 R !!," Select Input: (P)atient File, or (D)irect  P//",X:DTIME I '$T!(X["^") G HINQ
 I "Pp"[$E(X) S DVBPRGM="TM^DVBHIQD" G ASK
 I "Dd"[$E(X_1) S DVBPRGM="EN^DVBHQDE" G ASK
 I X["?" D HP^DVBHQAT G SEL
 G SEL
ASK S:$G(IO(0))="" IO(0)=$I W ! S Y=0,DVBIO=IO D @DVBPRGM
ASK1 I Y'<0,$D(DVBP),$L(DVBP)=4 S IO=DVBIO D STUFF^DVBHQAT:$D(DFN),MES
 I $D(DVBMISS) K DVBMISS D:DVBTRY>3 RETRY^DVBHQD2 G:DVBNRT="N" LOAD2^DVBHQD2 I DVBTRY<4&(DVBRTC<4) S DVBTRY=DVBTRY+1 U IO(0) W ?35,"Retrying Request." G ASK1
 S IO=DVBIO U IO(0) K DVBP S DVBABORT=0
 I '$D(Y) G ASK
 I Y>0 G ASK
 ;
HINQ U IO(0) W !!,"Do you wish to continue" S %=2 D YN^DICN G:'% HINQ I %=1 W ! G EN
EX S DTIME=$S($D(DVBTIME):DVBTIME,1:300)
 Q
MES ;
 S:$G(IO(0))="" IO(0)=$I S E=$L(DVBZ) I '$D(DVBDXX),($E(DVBZ,E-7,E-4)'=DVBNUM) S DVBZ=$E(DVBZ,1,E-4)_DVBNUM_$E(DVBZ,E-3,999)
 K E H 1 S DVBEND="NNNN" S:'$D(DVBXM) DVBXM=0 S:'$D(C) C=0
 ;
TOTIMS S TRY=0,CN=$F(DVBZ,"/CN",24),DVBZ0=DVBZ
 I $S('$D(DFN):1,DFN:0,1:1) S CN=0 D SEND^DVBHQD2,KTO^DVBHQD2 Q
 I 'CN D CNLKUP^DVBHQAT
 DO  D SEND^DVBHQD2 I TRY DO  I TRY H 1 D SEND^DVBHQD2
 .I CN,'TRY S DVBZ0=$E(DVBZ,1,23)_$E(DVBZ,24,CN-3)_$E(DVBZ,CN+9,999) Q
 .I CN,TRY S DVBZ1=$E(DVBZ,1,23)_$E(DVBZ,CN-2,999) Q
 .I 'CN S DVBZ0=DVBZ,TRY=0 Q
 I $D(DVBMISS)&($D(DVBPRGM)) I (DVBPRGM["TM") K DVBMISS D:DVBTRY>3 RETRY^DVBHQD2 G:DVBNRT="N" LOAD^DVBHQD2 I DVBTRY<4&(DVBRTC<4) S DVBTRY=DVBTRY+1 U IO(0) W ?35,"Retrying Request." G MES
 G KTO^DVBHQD2
 ;
 ;z1 is first x(),z9 is last x()
OK ;I 'DVBTSK DO
 ;. U IO(0) W !!?3 S Z1=0 F  S Z1=$O(X(Z1)) Q:'Z1  S LX=$G(LX)+$L(X(Z1)) W Z1," ",$L(X(Z1)),"   "
 ;. W !?9,LX,! K LX H 3 U IO
 S:$G(IO(0))="" IO(0)=$I S Z1=$O(X(0)) F  Q:$E(X(Z1))'=$C(10)  S X(Z1)=$E(X(Z1),2,999)
 I $G(X(Z1))["HINQ" S X(Z1)="HINQ"_$P(X(Z1),"HINQ",2)
 E  K X(Z1) DO
 . S Z1=$O(X(0)) I Z1="" S Z1=0,X(0)=""
 . I $G(X(Z1))["HINQ" S X(Z1)="HINQ"_$P(X(Z1),"HINQ",2)
 I $L(X(Z1))>25 S DVBLEN=+$E(X(Z1),22,25)
 I $L(X(Z1))'>25 D
 . I $D(X(Z1+1)) DO
 . . S DVBLEN=+$E($E(X(Z1),1,99)_$E(X(Z1+1),1,30),22,25)
 . I '$D(X(Z1+1)) D
 . . S DVBLEN=$L(X(Z1)) ;DVB*4*49 - error response may be < 25 chars
 I '$D(DVBLEN) S DVBABORT=DVBABORT+1 U IO(0) W:'DVBTSK !,"Missing string" U IO Q
 ;
 I $D(F3) S DVBLEN=DVBLEN-F3 K F3
 I "456789ABCDUVWNMXYZ"'[$E(X(Z1),5) S DVBLEN=DVBLEN-2
 ;
 S (Z,Z9,F2)=0 F  S Z=$O(X(Z)) Q:'Z  S Z9=Z,F2=F2+$L(X(Z))
 ;
 I DVBLEN'=F2,X(Z9)[$C(10) S DVBABORT=DVBABORT+1 U IO(0) W:'DVBTSK !,"Missing character" S DVBMISS="" Q
 I $E(X(Z1),5)'=2 S F2=F2+1
 ;
 I DVBLEN'=F2-1,X(Z9)'[$C(10),$S('$D(X(Z9-1)):1,1:$S(X(Z9-1)'[$C(10):1,1:0)) S DVBABORT=DVBABORT+1 U IO(0) W:'DVBTSK !,"Missing character" S DVBMISS="" Q
 ;trim,e will pack back to x(1)
 I Z9 S:$D(X) DVBSOX=X D TRIM,E^DVBHQAT S:$D(DVBSOX) X=DVBSOX K DVBSOX I $E(X(1),1,4)["HINQ","AXY69"'[$E($E(X(1),5)_1) D ALLM Q
 ;
 S DVBABORT=DVBABORT+1 Q:$E(X(1),1,4)'="HINQ"
 I $E(X(1),5)="A" U IO(0) W:'DVBTSK !,"VBA File not Available" U IO H 2 D ALL QUIT
 ;
 I DVBTSK,"69XY"[$E($E(X(1),5)_1) S DVBBADP="" D ALL QUIT
 I 'Z9 Q
 ;
ALL I 'DVBXM,$D(DFN),+DFN K:C ^TMP("DVBHINQ",$J,DFN) S Z=0 F  S Z=$O(X(Z)) Q:'Z  S ^TMP("DVBHINQ",$J,DFN,Z)=X(Z)
 E  I DVBXM D  K DVBTX Q
 . N DVBQT
 . D RS,A^DVBHIQR
 . I $G(DFN)>1,('DVBTSK),($E(X(1),5)=2),('$D(DVBERCS)) D CHKID I DVBQT D  Q
 . . N DVBTMP1,DVBTMP2
 . . S DVBTMP1=$G(DVBNOALR)
 . . S DVBTMP2=$G(DVBJ2)
 . . S DVBNOALR=";4///c;5////"_DUZ_";6///N",DVBJ2=1
 . . D FILE^DVBHQUP
 . . S DVBNOALR=DVBTMP1
 . . S DVBJ2=DVBTMP2
 . D RECMAL^DVBHQD2
 . D IALERT^DVBHT2,EN^DVBHIQM H 1 D WRT
 I DVBABORT=3!($D(DVBBADP)) S DFN=0
 Q
 ; do all if no error or retrying
ALLM I "BC"'[$E($E(X(1),5)_1) D ALL Q
 I CN,'TRY S TRY=1 D:DVBXM DCN Q
 I 'CN D ALL Q
 S X(1)=X(1)_"[TRY]1" D ALL Q
 ;
DCN S:$G(IO(0))="" IO(0)=$I U IO(0) W !,"..Name, SSN didn't work ....retrying using Claim Number",! U IO Q
 ;
RS Q:'$D(DFN)  Q:'DFN  Q:'$D(^DVB(395.5,DFN,0))  S DVBDFN=DFN,DVBCS=0
 F DVBSZ=0:0 S DVBSZ=$O(X(DVBSZ)) D SC^DVBHQST Q:'DVBSZ  D ST^DVBHQDB
 K DVBSZ,DVBDFN Q
 ;
TRIM Q:F1=999
 I '$D(F1) S F1=$F(X(Z9),DVBEND)
 I $E(X(Z9),F1-F4)=$C(10) S F1=F1-1
 S X(Z9)=$E(X(Z9),1,F1-F4)
 K F1 Q
 ;
WRT S:$G(IO(0))="" IO(0)=$I S DVBJIO=IO(0)
WRT1 S:$G(DVBJIO)="" DVBJIO=$I S:'$D(DVBIOSL) DVBIOSL=IOSL S:'$D(DVBIOST) DVBIOST=IOST S:'$D(DVBIOF) DVBIOF=IOF
 S X="" U DVBJIO W !!! D CODE^DVBHQUS W !! S Y0=$Y F Z=0:0 S Z=$O(^TMP($J,Z)) Q:'Z  I $D(^(Z,0)) W ^(0),! D:$Y-Y0>(DVBIOSL-4) SROLL^DVBHQD2 Q:X="^"  D:$Y<Y0 ABS^DVBHQD2
 Q:X="^"  K DVBJIO D SROLL^DVBHQD2 Q
 ;
CH S F1=0
 I X(W)=$C(10)_"NNNN" K X(W) S F1=999 Q
 I $L(X(W))>4!($L(X(W))<1) Q
 F A=$L(X(W)):-1:1 Q:$E(X(W),A)'="N"
 I A=1,$E(X(W),A)="N" S F1=$L(X(W-1))+1,F3=$L(X(W)),F4=5-$L(X(W)) K X(W)
 Q
CHKID ;checks 4 critical identifier fields
 ;fields are name, DOB, SSN and sex.
 ;DVBQT 0 to continue, 1 to stop processing
 N DA,DIC,DIQ,DIR,DR,X,Y
 N DVBBIRTH,DVBCNT,DVBNAM,DVBNM,DVBSEX,DVBSOCL,DVBSSN
 N DVBDIQ
 S DVBCNT=0
 S DVBQT=0
 S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ("
 S DR=".01;.02;.03;.09"
 D EN^DIQ1
 S DVBNAM=$S($D(DVBADR(1)):DVBADR(1),$D(DVBNAME):$E(DVBNAME,1,30),1:"")
 S DVBSEX=""
 I $D(DVBVET),$P(DVBVET,U)="A" S DVBSEX=$S($P(DVBVET,U,3)="M":"MALE",$P(DVBVET,U,3)="F":"FEMALE",1:"")
 I '$D(DVBVET),($D(DVBBIR)) S DVBSEX=$S($P(DVBBIR,U,25)="M":"MALE",$P(DVBBIR,U,25)="F":"FEMALE",1:"")
 S DVBSOCL=""
 I $D(DVBREF),($P(DVBREF,U)?9N) S DVBSOCL=$P(DVBREF,U)
 I $P($G(DVBREF),U)'?9N I $D(DVBSSN),(DVBSSN?9N) S DVBSOCL=DVBSSN
 S DVBBIRTH=""
 ;change date of birth to match the Patient file ext value (DVBBIRTH)
 I $D(DVBDOB),(DVBDOB?8N) S DVBBIRTH=$E(DVBDOB,1,2)_"/"_$E(DVBDOB,3,4)_"/"_$E(DVBDOB,5,8)
 ;change ext Patient file value for name to HINQ name format
 I '$$NAME(DVBDIQ(2,DFN,.01,"E")) S DVBCNT=DVBCNT+1
 I $G(DVBSEX)'=$G(DVBDIQ(2,DFN,.02,"E")) S DVBCNT=DVBCNT+1
 I $G(DVBBIRTH)'=$G(DVBDIQ(2,DFN,.03,"E")) S DVBCNT=DVBCNT+1
 I $G(DVBSOCL)'=$G(DVBDIQ(2,DFN,.09,"E")) S DVBCNT=DVBCNT+1
 I DVBCNT>0 D WARN
 Q
WARN ;warns user if there are any discrepancies between HINQ and VistA for 
 ;4 critical identifier fields - name, DOB, SSN and sex.
 N DIRUT,DUOUT
 U IO(0)
 H 1
 D TEXT
 D DISPL
 S DVBQT=1
 N DIR
 S DIR(0)="N^1:3:0",DIR("A")="Do you want to process the HINQ on "_DVBDIQ(2,DFN,.01,"E")_"? ",DIR("B")="NO"
 W !!
 S DIR("A",1)="Check displayed data before proceeding."
 S DIR("A",2)=""
 S DIR("A",3)="Choose one of the following:"
 S DIR("A",4)="    1.  Update this record."
 S DIR("A",5)="    2.  Take no action at this time."
 S DIR("A",6)="    3.  Delete this record from the SUSPENSE file."
 S DIR("A",7)=""
 S DIR("?")="      Select 1 - 3"
 S DIR("?",1)="  If you want to continue processing this HINQ enter 1."
 S DIR("?",3)="  If you cannot process this patient data at this time enter 2."
 S DIR("?",2)="  If the HINQ data is for the wrong patient, enter 3."
 S DIR("B")=2
 D ^DIR
 W !!
 I Y=1 S DVBQT=0 Q  ;update
 I Y=2 Q  ;ignore
 I Y="^"!($G(DIRUT)=1)!($G(DUOUT)=1) S DVBOUT="^" Q  ;"^" out of option
 N DA,DIK ;delete
 S DA=DFN
 S DIK="^DVB(395.5,"
 D ^DIK
 Q
TEXT ;warning text
 W @IOF
 W !!!!
 W ?2,"*********************************************************************"
 W !?2,"*     NOTE: IDENTIFYING DATA FROM HINQ AND VISTA DOES NOT MATCH     *"
 W !?2,"*    PATIENT FROM HINQ RESPONSE MAY NOT BE THE PATIENT REQUESTED    *"
 W !?2,"*********************************************************************"
 Q
DISPL ;display ID data
 W !!?17,"Patient File data",?45,"HINQ Data"
 W !?17,"-----------------",?45,"---------"
 W !?11,"Name: "_$G(DVBDIQ(2,DFN,.01,"E")),?45,$G(DVBNAM)
 W !?12,"Sex: "_$G(DVBDIQ(2,DFN,.02,"E")),?45,$G(DVBSEX)
 W !?2,"Date of Birth: "_$G(DVBDIQ(2,DFN,.03,"E")),?45,$G(DVBBIRTH)
 W !?12,"SSN: "_$G(DVBDIQ(2,DFN,.09,"E")),?45,$G(DVBSOCL)
 Q
NAME(DVBNM) ;set local variables to hold the VistA and HINQ formats of the
 ;patient name so they can be compared, DVB*4*56
 ;first check for the HINQ name on the first address line
 N DVBARR,DVBHFRST,DVBHLST,DVBHMID,DVBOK,DVBSTUB,DVBVFRST,DVBVLST,DVBVMID
 S (DVBARR,DVBOK,DVBSTUB)=0
 ;set variable with HINQ name parts
 I $G(DVBADR(1))]"" D
 . S DVBARR=1
 . S DVBHFRST=$P(DVBADR(1)," ") ;first name
 . S DVBHMID=$P(DVBADR(1)," ",2) ;middle name, if there is one
 . S DVBHLST=$P(DVBADR(1)," ",3) ;last name, if there was a middle name
 ;then check for the HINQ 7 character name stub
 I DVBARR=0,($G(DVBNAME)]"") S DVBSTUB=1
 ;get VistA name parts
 N DVBREST
 S DVBVLST=$P(DVBNM,",")
 S DVBREST=$P(DVBNM,",",2,3)
 S DVBVFRST=$P(DVBREST," ")
 S DVBVMID=$P(DVBREST," ",2)
 ;now compare
 I DVBARR=1 D  Q DVBOK
 . N DVBOK1,DVBOK2,DVBOK3
 . S (DVBOK1,DVBOK2,DVBOK3)=0
 . ;if name is long, HINQ first name may have been truncated to 1 char
 . I $L(DVBHFRST)=1 S DVBVFRST=$E(DVBVFRST)
 . ;if last name is > 16 chars, it may be truncated
 . I $L(DVBVLST)>16 S DVBVLST=$E(DVBVLST,1,$L(DVBHLST))
 . ;if name is long, HINQ middle name may have been truncated to 1 char
 . ;but, if there is no HINQ middle name, do not try to compare
 . I $G(DVBHMID)']"" S DVBOK3=1
 . I DVBOK3=0 D
 . . I $L(DVBHMID)=1 S DVBVMID=$E(DVBVMID)
 . . I DVBVMID=DVBHMID S DVBOK3=1
 . I DVBVFRST=DVBHFRST S DVBOK1=1
 . I DVBVLST=DVBHLST S DVBOK2=1
 . I DVBOK1=1,(DVBOK2=1),(DVBOK3=1) S DVBOK=1 Q
 ;if the first line of the address array is not populated, compare
 ;DVBNAME which is a HINQ stub name to the equivalent patient file stub
 I DVBARR=0,(DVBSTUB=1) D
 . N DVBVSTUB
 . I DVBVMID']"" S DVBVMID=" "
 . S DVBVSTUB=$E(DVBVFRST)_$E(DVBVMID)_$E(DVBVLST,1,5)
 . I DVBVSTUB=DVBNAME S DVBOK=1
 Q DVBOK
