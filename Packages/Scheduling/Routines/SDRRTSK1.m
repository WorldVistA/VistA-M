SDRRTSK1 ;10N20/MAH - Recall Reminder-Clinic Print Task ;09/07/17
 ;;5.3;Scheduling;**536,579,643,654**;Aug 13, 1993;Build 5
 ;;This routine is called from SDRR TASK JOB CARD
 ;;and will be called if PARAM IS cards
 ;
 ; SD*654
 ; - fixes incomplete Canadian address.
 ;
START Q:'$D(^SD(403.53,0))
 S CRP=0
 F  S CRP=$O(^SD(403.53,CRP)) Q:'CRP  D
 .S TYPE=$P($G(^SD(403.53,CRP,0)),"^",2)
 .Q:TYPE["L"
 .S DATE=$P($G(^SD(403.53,CRP,0)),"^",4) Q:DATE=""  ;IF NOT SET ROUTINE WILL QUIT
 .S X="T+"_DATE D ^%DT S (ZSDT,ZEDT)=Y K Y
 .S (PRT,TEAM)=0
 .F  S TEAM=$O(^SD(403.55,"C",CRP,TEAM)) Q:TEAM=""  S PRT=$P($G(^SD(403.55,TEAM,0)),"^",3) D
 ..Q:PRT=""
 ..S DA=PRT
 ..S DIC="^%ZIS(1,",DR=".01;1;3",DIQ="DPTR",DIQ(0)="I" D EN^DIQ1
 ..N IOP S IOP=$G(DPTR("3.5",DA,".01","I")) D ^%ZIS
 ..S PROV=0 F  S PROV=$O(^SD(403.54,"C",TEAM,PROV)) Q:PROV=""  D
 ...S D0=0 F  S D0=$O(^SD(403.5,"C",PROV,D0)) Q:D0=""  D
 ....; SD*579 - if entry not exist, kill x-refs and quit
 ....I '$D(^SD(403.5,D0)) D KXREF Q
 ....S DTA=$G(^SD(403.5,D0,0))
 ....S TIME=""
 ....I $P($G(^SD(403.5,D0,0)),"^",9)>45 S TIME=$P($G(^SD(403.5,D0,0)),"^",9) S TIME="**"_TIME_"**"
 ....S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 ....S DFN=+DTA
 ....;Q:$P(DTA,U,6)<ZSDT!($P(DTA,U,6)>ZEDT)
 ....Q:$P(DTA,U,6)>ZEDT     ;alb/sat 643
 ....Q:$P(DTA,U,10)'=""     ;alb/sat 643
 ....Q:$$TESTPAT^VADPT(DFN)
 ....D ADD^VADPT,DEM^VADPT
 ....S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 ....S PN=$P(VADM(1),U)
 ....I $G(VADM(6),U)'="" Q
 ....N CHECK
 ....I $$BADADR^DGUTL3(DFN) S CHECK=1 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 .....S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 .....S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 .....D ^XMD
 .....K XMY,XMSUB,XMTEXT,XMDUZ
 .....Q
 .....;ADDED THE DATE INFORMATION
 ....I '$D(CHECK) S $P(^SD(403.5,D0,0),"^",10)=DT
 ....Q:$D(CHECK)
 ....U IO
 ....W @IOF F L=1:1:7 W !
 ....S PNAME=$$NAMEFMT^XLFNAME(PN,"G","")
 ....W !?20,PNAME
 ....D ADDR ; SD*654 fix incomplete addr
 ....I TIME'="" W !!?45,TIME
 ....I LAB'="" W !,?45,LAB
 ..D ^%ZISC
 K DPTR,DEVSB,DEVSB1,DIQ,DEVSB1,DA,DA1,DR
QUIT K DEV,PRT,ADTA,D0,DFN,DIC,DIR,DIRUT,DTA,I,L,PN,POP,Y,ZDIV,ZEDT,ZPR,ZSDT,FAST,TIME,ACC,TYPE,PTN,CRP,STATE,PNAME
 K LINE,LETTER,MESSAGE,TEST,CLINIC,DA,DATE,DEV1,DEVSB,DOD,FAIL,PROV,TEAM,X,DPT,LAB,SDRR,VA,LAB,DPT,SDRR,VA
 D KVAR^VADPT
 Q
 ;
KXREF ; SD*579 - If entry does not exist, kill all the x-refs.
 S STR="BCDE"
 F I=1:1:$L(STR) D
 .S X=$E(STR,I,I)
 .S N3=0 F  S N3=$O(^SD(403.5,X,N3)) Q:N3'>0  D
 ..S N4=0 F  S N4=$O(^SD(403.5,X,N3,N4)) Q:N4'>0  D
 ...I N4=D0 K ^SD(403.5,X,N3,N4)
 K I,STR,X,N3,N4
 Q
 ;
ADDR ; SD*654 Patient address
 ; Change state to abbr.
 N SDRRIENS,SDRRX
 I $D(VAPA(5)) S SDRRIENS=+VAPA(5)_",",SDRRX=$$GET1^DIQ(5,SDRRIENS,1),$P(VAPA(5),U,2)=SDRRX
 I $D(VAPA(17)) S SDRRIENS=+VAPA(17)_",",SDRRX=$$GET1^DIQ(5,SDRRIENS,1),$P(VAPA(17),U,2)=SDRRX
 K SDRRIENS,SDRRX
 ;
 N SDRRACT1,SDRRACT2,LL
 ; Check Confidential Address Indicator (0=Inactive,1=Active)
 S SDRRACT1=VAPA(12),SDRRACT2=$P($G(VAPA(22,2)),U,3)
 ; If Confidential address is not active, print regular address
 I ($G(SDRRACT1)=0)!($G(SDRRACT2)'="Y") D
 . F LL=1:1:3 W:VAPA(LL)]"" !,?20,VAPA(LL)
 . ; If country is blank, display as USA
 . I (VAPA(25)="")!($P(VAPA(25),U,2)="UNITED STATES") D
 . . ; Display city, state, zip
 . . W !?20,VAPA(4)_" "_$P(VAPA(5),U,2)_"  "_$P(VAPA(11),U,2)
 . E  D
 . . ; Display city, province, postal code
 . . W !?20,VAPA(4)_" "_VAPA(23)_"  "_VAPA(24)
 . ; Display country
 . W:($P(VAPA(25),U,2)'="UNITED STATES") !,?20,$P(VAPA(25),U,2)
 ; If Confidential address is active, print confidential address
 I $G(SDRRACT1)=1,$G(SDRRACT2)="Y" D
 . F LL=13:1:15 W:VAPA(LL)]"" !,?12,VAPA(LL)
 . I (VAPA(28)="")!($P(VAPA(28),"^",2)="UNITED STATES") D
 . . W !,?20,VAPA(16)_" "_$P(VAPA(17),U,2)_"  "_$P(VAPA(18),U,2)
 . E  D
 . . W !,?20,VAPA(27)_" "_VAPA(16)_" "_VAPA(26)
 . I ($P(VAPA(28),"^",2)'="UNITED STATES") W !?20,$P(VAPA(28),U,2)
 Q
