SDRRTSK ;10N20/MAH - RECALL LETTER PRINT TASK ;FEB 04, 2016
 ;;5.3;Scheduling;**536,579,643**;Aug 13, 1993;Build 14
 ;THIS ROUTINE WILL PRINT LETTER FOR SELECTED METHOD OF PRINTING
 ;WILL LOOK AT CLINIC RECALL LOCATION
DATE ;lOOKS TO SEE HOW MANY DAYS IN ADVANCE TO PRINT LETTER
 Q:'$D(^SD(403.53,0))
 S CRP=0
 F  S CRP=$O(^SD(403.53,CRP)) Q:'CRP  D
 .S TYPE=$P($G(^SD(403.53,CRP,0)),"^",2)
 .Q:TYPE["C"
 .S DATE=$P($G(^SD(403.53,CRP,0)),"^",4) Q:DATE=""   ;IF NOT SET ROUTINE WILL QUIT
 .S X="T+"_DATE D ^%DT S (ZSDT,ZEDT)=Y K Y
 .S (PRT,TEAM)=0
 .F  S TEAM=$O(^SD(403.55,"C",CRP,TEAM)) Q:TEAM=""  S PRT=$P($G(^SD(403.55,TEAM,0)),"^",3) D
 ..Q:PRT=""
 ..S DA=PRT
 ..S DIC="^%ZIS(1,",DR=".01;1;3",DIQ="DPTR",DIQ(0)="I" D EN^DIQ1
 ..N IOP S IOP=$G(DPTR("3.5",DA,".01","I")) D ^%ZIS
 ..S PROV=0 F  S PROV=$O(^SD(403.54,"C",TEAM,PROV)) Q:PROV=""  D
 ...S (MESSAGE,D0,LETTER)=0 F  S D0=$O(^SD(403.5,"C",PROV,D0)) Q:D0=""  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 ....; SD*579 - Kill x-refs and quit if entry not exist
 ....I '$D(^SD(403.5,D0)) D KXREF Q
 ....S DTA=$G(^SD(403.5,D0,0))
 ....I CLINIC="" S MESSAGE="***NO CLINIC ON FILE**"
 ....I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC)) S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 ....I CLINIC'="",(FAIL=0) S ZDIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 ....S TIME=""
 ....I $P($G(^SD(403.5,D0,0)),"^",9)>45 S TIME=$P($G(^SD(403.5,D0,0)),"^",9) S TIME="**"_TIME_"**"
 ....S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
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
 ....;ADDED THE DATE INFORMATION
 ....I '$D(CHECK) S $P(^SD(403.5,D0,0),"^",10)=DT   ;NEW CODE
 ....Q:$D(CHECK)
 ....U IO
 ....; SD*579 - Add date printed and last 4
 ....S PRNDT=$TR($$FMTE^XLFDT(DT,"5DF")," ","0")
 ....S LAST4=$E($P(VA("BID"),U),1,4)
 ....W @IOF
 ....W !,?65,PRNDT
 ....W !,?65,$E(PN,1)_LAST4
 ....F L=1:1:9 W !
 ....; SD*579 - Fix suffix problem
 ....S PNAME=$$NAMEFMT^XLFNAME(PN,"G","")
 ....W !?20,PNAME
 ....I $P(VAPA(1),U)'="" W !?20,$P(VAPA(1),U)
 ....I $P(VAPA(2),U)'="" W !?20,$P(VAPA(2),U)
 ....I $P(VAPA(3),U)'="" W !?20,$P(VAPA(3),U)
 ....W !?20,$P(VAPA(4),U)," "_STATE_"  ",$P(VAPA(6),U)
 ....I LETTER=0 W !!!!!,?25,MESSAGE
 ....I TIME'="" W !!!!?2,"**"_TIME
 ....I LAB'="" W !!!!!,?2,"*"_LAB
 ....W !!!
 ....S:'$D(MESSAGE) LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 ....I LETTER>0 S LINE=0 F  S LINE=$O(^SD(403.52,LETTER,1,LINE)) Q:'LINE  W !,?2,$P(^SD(403.52,LETTER,1,LINE,0),"^",1)
 ..D ^%ZISC
 K DPTR,DEVSB,DEVSB1,DIQ,DEVSB1,DA,DA1,DR
 K MESSAGE,LETTER,PRNDT,LAST4,PNAME
QUIT K DEV,PRT,ADTA,D0,DFN,DIC,DIR,DIRUT,DTA,I,L,PN,POP,Y,ZDIV,ZEDT,ZPR,ZSDT,FAST,TIME,ACC,LAB,STATE
 K LINE,LETTER,MESSAGE,TEST,CLINIC,DA,DATE,DEV1,DEVSB,DOD,FAIL,PROV,TEAM,X,PROV,TEAM,CRP,DATE,TYPE,SDRR,DPT,VA
 D KVAR^VADPT
 Q
 ;
KXREF ; SD*579 - If entry not exist, kill all the x-refs.
 S STR="BCDE"
 F I=1:1:$L(STR) D
 .S X=$E(STR,I,I)
 .S N3=0 F  S N3=$O(^SD(403.5,X,N3)) Q:N3'>0  D
 ..S N4=0 F  S N4=$O(^SD(403.5,X,N3,N4)) Q:N4'>0  D
 ...I N4=D0 K ^SD(403.5,X,N3,N4)
 K I,STR,X,N3,N4
 Q
