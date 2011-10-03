SDRRRECL ;10N20/MAH;Recall Reminder Manual Printing; 09/20/2004
 ;;5.3;Scheduling;**536,561,569**;Aug 13, 1993;Build 3
 ;;This routine is called from SDRRLRP 
 ;;If the site has set TYPE OF NOTIFICATION to LETTER this routine
 ;;will run.
 K TYPE
MEN ;SET UP WHAT ARE THEY WOULD LIKE TO PRINT FOR LETTERS
 K DIR,Y,DTOUT,DIROUT,DIRUT,DUOUT
 S DIR(0)="SO^1:Print Letters by Clinic;2:Print Letters by Provider;3:Print Letters by Team;4:Print a Letter by Patient;5:Print Letters for Nonresponsive Patients"
 W ! S DIR("A")="Please select what you are looking for"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)!($D(DIRUT))) QUIT S Q=Y
 I Q=1 G EN
 I Q=2 G EN1
 I Q=3 G EN3
 I Q=4 G EN4
 I Q=5 G EN5
 Q
EN ;PRINT BY CLINIC
 S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<0  S DIV=+Y G:Y<0 QUIT
 I '$D(^SD(403.52,"B",DIV)) W !,?5,"**NO RECALL LETTER ON FILE**" G QUIT
 D SELDT G:Y<0 QUIT  ;SD*561 quit if no date range entered
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters by Clinic",ZTRTN="DQD^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD K ^TMP($J)
 U IO S D0=0 F  S D0=$O(^SD(403.5,"E",DIV,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 .S DFN=+DTA
 .Q:$P(DTA,U,6)<SDT!($P(DTA,U,6)>EDT)
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
 ;;done and tested
QUIT K ADTA,D0,DFN,DIC,DIR,DIRUT,DTA,I,L,PN,POP,Y,DIV,EDT,PR,SDT,FAST,TIME,ACC
 K LINE,LETTER,MESSAGE,TEST,DOD,CLINIC,FAIL,TEAM,LAB,SDRR,Q,%DT,%ZIS,CHECK,VA,ZTDESC,ZTIO,ZTRTN,ZTSAVE,STATE Q
 D KVAR^VADPT
 Q
SELDT S %DT="AEX",%DT("A")="Start with RECALL DATE: " D ^%DT Q:Y<0  S SDT=Y,%DT("A")="End with RECALL DATE: " D ^%DT I Y<SDT W $C(7),"  ??" G SELDT
 S EDT=Y Q
PR S LETTER=0
 W @IOF F L=1:1:11 W !
 W !?20,$P(PN,",",2)," ",$P(PN,",")
 I $P(VAPA(1),U)'="" W !?20,$P(VAPA(1),U)
 I $P(VAPA(2),U)'="" W !?20,$P(VAPA(2),U)
 I $P(VAPA(3),U)'="" W !?20,$P(VAPA(3),U)
 W !?20,$P(VAPA(4),U),", "_STATE_"  ",$P(VAPA(6),U)
 I $D(MESSAGE) W !!!!!,?25,MESSAGE
 ; SD*569 - Adjust the tab starting position
 I TIME'="" W !!!!?2,TIME
 I LAB'="" W !!!!!,?2,"*"_LAB
 W !!!
 S:'$D(MESSAGE) LETTER=$O(^SD(403.52,"B",DIV,LETTER))
 I LETTER>0 S LINE=0 F  S LINE=$O(^SD(403.52,LETTER,1,LINE)) Q:'LINE  W !,?2,$P(^SD(403.52,LETTER,1,LINE,0),"^",1)
 K MESSAGE
 Q
EN1 ;print letters by provider
 S DIC="^SD(403.54,",DIC(0)="AEQMZ",DIC("A")="Select Provider: " D ^DIC G:Y<0 QUIT S PR=+Y
 D SELDT G:Y<0 QUIT  ;SD*5.3*561 quit if no date range entered
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters by Provider",ZTRTN="DQD1^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD1 K ^TMP($J)
 U IO S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 .S DTA=$G(^SD(403.5,D0,0))
 .I CLINIC="" S FAIL=1 S MESSAGE="***NO CLINIC ON FILE**"
 .I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC))  S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 .I CLINIC'="",(FAIL=0) S DIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 .S DFN=+DTA
 .Q:$P(DTA,U,6)<SDT!($P(DTA,U,6)>EDT)
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN3 ;PRINT LETTER FOR A TEAM
 W ! S DIC="^SD(403.55,",DIC(0)="AEQMZ",DIC("A")="Select Clinic Recall Team: " D ^DIC S TEAM=+Y K DIC G:Y<0 QUIT
 D SELDT G:Y<0 QUIT  ;SD*561 quit if no date range entered
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters for a Team",ZTRTN="DQD4^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD4 S PR=0 F  S PR=$O(^SD(403.54,"C",TEAM,PR)) Q:'PR  S D0=0 D
 .F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 ..S DTA=$G(^SD(403.5,D0,0))
 ..I CLINIC="" S FAIL=1 S MESSAGE="***NO CLINIC ON FILE**"
 ..I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC))  S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 ..I CLINIC'="",(FAIL=0) S DIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 ..S TIME=""
 ..I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 ..S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 ..S DFN=+DTA
 ..Q:$P(DTA,U,6)<SDT!($P(DTA,U,6)>EDT)  ;SD*561 check selected date range
 ..Q:$$TESTPAT^VADPT(DFN)
 ..D ADD^VADPT,DEM^VADPT
 ..S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 ..S PN=$P(VADM(1),U)
 ..I $G(VADM(6),U)'="" Q
 ..S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ...S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ...S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ...D ^XMD
 ...K XMY,XMSUB,XMTEXT,XMDUZ
 ..;ADDED THE DATE INFORMATION
 ..S $P(^SD(403.5,D0,0),"^",10)=DT
 ..D PR
 D ^%ZISC G QUIT
 ;done and tested
EN4 ;PRINT LETTER FOR ONE PATIENT
 W ! S DIC="^SD(403.5,",DIC(0)="AEQMZ",DIC("A")="Select Patient: " D ^DIC S D0=+Y K DIC G:Y<0 QUIT
 S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<0  S DIV=+Y K DIC G:Y<0 QUIT
 I '$D(^SD(403.52,"B",DIV)) W !,?5,"**NO RECALL LETTER ON FILE**" G QUIT
 I '$D(^SD(403.5,"E",DIV,D0)) W *7,!!,?5,"**This patient does not have a recall reminder for the selected clinic**",!! G QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters for a Patient",ZTRTN="DQD3^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD3 K ^TMP($J)
 S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .; SD*569 - Quit if patient's clinic does not match the selected hospital location.
 .I $P(DTA,"^",2)'=DIV Q
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 .S DFN=+DTA
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN5 ;Print LETTERS for Nonresponsive
 S TEAM=""
 S DIC="^SD(403.55,",DIC(0)="AEQMZ",DIC("A")="Select Clinic Recall Team: " D ^DIC S TEAM=+Y K DIC G:TEAM<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters for Nonresponsive",ZTRTN="DQD5^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD5 N CHKDATE
 ;SD*5.3*561 remove extraneous write command following $O on next line
 S PR=0,CHKDATE=5 F  S PR=$O(^SD(403.54,"C",TEAM,PR)) Q:'PR  D
 .S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:'D0  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 ..I $P($G(^SD(403.5,D0,0)),"^",10)="" QUIT
 ..; SD*569 - Prevent from printing more than ONE second letter.
 ..I $P($G(^SD(403.5,D0,0)),"^",13)'="" QUIT
 ..S RDATE=$P($G(^SD(403.5,D0,0)),"^",6) S CHECK=$$FMDIFF^XLFDT(RDATE,DT) I CHECK>CHKDATE K RDATE QUIT
 ..S DTA=$G(^SD(403.5,D0,0))
 ..I CLINIC="" S FAIL=1 S MESSAGE="***NO CLINIC ON FILE**"
 ..I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC))  S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 ..I CLINIC'="",(FAIL=0) S DIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 ..S TIME=""
 ..I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 ..S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 ..S DFN=+DTA
 ..Q:$$TESTPAT^VADPT(DFN)
 ..D ADD^VADPT,DEM^VADPT
 ..S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 ..S PN=$P(VADM(1),U)
 ..I $G(VADM(6),U)'="" Q
 ..S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ...S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ...S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ...D ^XMD
 ...K XMY,XMSUB,XMTEXT,XMDUZ
 ..;ADDED THE DATE INFORMATION
 ..S $P(^SD(403.5,D0,0),"^",13)=DT
 ..D PR
 D ^%ZISC G QUIT
 Q
