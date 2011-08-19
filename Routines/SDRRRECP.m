SDRRRECP ;10N20/MAH;Recall Reminder Manual Printing; 09/20/2004
 ;;5.3;Scheduling;**536,569**;Aug 13, 1993;Build 3
 ;;This routine is called from SDRRLRP 
 ;;If the site has set TYPE OF NOTIFICATION to CARDS this routine
 ;;will run.
 K TYPE
MEN ;SET UP WHAT ARE THEY WOULD LIKE TO PRINT FOR CARDS
 K DIR,Y,DTOUT,DIROUT,DIRUT,DUOUT
 S DIR(0)="SO^1:Print Cards by Division;2:Print Cards by Clinic;3:Print Cards by Provider;4:Print Cards by Team;5:Print a Card by Patient;6:Print Cards for Nonresponsive Patients"
 W ! S DIR("A")="Please select what you are looking for"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)!($D(DIRUT))) QUIT S Q=Y
 I Q=1 G EN3
 I Q=2 G EN
 I Q=3 G EN2
 I Q=4 G EN1
 I Q=5 G EN4
 I Q=6 G EN5
 Q
 ;ALLK Q,Y,DIR
EN3 ;PRINT BY DIVISION
 S DIC="^DG(40.8,",DIC(0)="AEQMZ" D ^DIC G:Y<0 QUIT S DIV=+Y D SELDT G:Y<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDSC="Print Recall Cards by Division",ZTRTN="DQD1^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD1 K ^TMP($J)
 S PR=0 F  S PR=$O(^SD(403.5,"C",PR)) Q:PR=""  I $P($G(^SD(403.54,PR,0)),"^",3)=DIV S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)["60" S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 .S DFN=+DTA
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S PN=$P(VADM(1),U)
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .I $G(VADM(6),U)'="" Q
 .Q:$P(DTA,"^",6)<SDT!($P(DTA,"^",6)>EDT) 
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN ;PRINT BY CLINIC
 S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<0  S DIV=+Y D SELDT G:Y<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Cards by Clinic",ZTRTN="DQD^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD K ^TMP($J)
 S D0=0 F  S D0=$O(^SD(403.5,"E",DIV,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)["60" S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 .S DFN=+DTA
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .Q:$P(DTA,"^",6)<SDT!($P(DTA,"^",6)>EDT) 
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
QUIT K ADTA,D0,DFN,DIC,DIR,DIRUT,DTA,I,L,PN,POP,Y,DIV,EDT,PR,SDT,TIME,LAB,Y,STATE
 K DATE,DOD,X,Q,%DT,%ZIS,SDRR,VA,CHECK,ZTDESC,ZTDSC,ZTEAM,ZTIO,ZTRTN,ZTSAVE
 Q
SELDT S %DT="AEX",%DT("A")="Start with RECALL DATE: " D ^%DT Q:Y<0  S SDT=Y,%DT("A")="End with RECALL DATE: " D ^%DT I Y<SDT W $C(7),"  ??" G SELDT
 S EDT=Y Q
PR W @IOF F L=1:1:7 W !
 W !?20,$P($P(PN,",",2)," ",1)_" "_$P(PN,",")
 I $P(VAPA(1),U)'="" W !?20,$P(VAPA(1),U)
 I $P(VAPA(2),U)'="" W !?20,$P(VAPA(2),U)
 I $P(VAPA(3),U)'="" W !?20,$P(VAPA(3),U)
 W !?20,$P(VAPA(4),U),", "_STATE_"  ",$P(VAPA(6),U)
 I TIME'="" W !!?45,TIME
 I LAB'="" W !!?45,LAB
 Q
EN1 ;PRINT BY TEAM
 S DIC="^SD(403.55,",DIC(0)="AEQMZ",DIC("A")="Select Clinic Team: " D ^DIC Q:Y<0  S ZTEAM=+Y D SELDT G:Y<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Cards by Team",ZTRTN="DQT^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQT K ^TMP($J)
 S PR=0 F  S PR=$O(^SD(403.5,"C",PR)) Q:PR=""  I $P($G(^SD(403.54,PR,0)),U,2)=+ZTEAM S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)["60" S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 .S DFN=+DTA
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S PN=$P(VADM(1),U)
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .I $G(VADM(6),U)'="" Q
 .Q:$P(DTA,"^",6)<SDT!($P(DTA,"^",6)>EDT) 
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 ..D ^%ZISC G QUIT
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN2 ;PRINT BY PROV
 S DIC="^SD(403.54,",DIC(0)="AEQMZ",DIC("A")="Select Provider: " D ^DIC G:Y<0 QUIT S PR=+Y  D SELDT G:Y<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Cards by Prov",ZTRTN="DQP^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQP K ^TMP($J)
 S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 .S DFN=+DTA
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .Q:$P(DTA,"^",6)<SDT!($P(DTA,"^",6)>EDT) 
 .S CHECK=$$BADADR^DGUTL3 I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN4 ;PRINT BY Patient
 W ! S DIC="^SD(403.5,",DIC(0)="AEQMZ",DIC("A")="Select Patient: " D ^DIC G:Y<0 QUIT S D0=+Y
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Cards by Prov",ZTRTN="DPP^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DPP K ^TMP($J)
 S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
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
EN5 ;PRINT BY TEAM
 S DIC="^SD(403.55,",DIC(0)="AEQMZ",DIC("A")="Select Clinic Team: " D ^DIC S ZTEAM=+Y G:Y<0 QUIT
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Nonresponsive Recall Cards by Team",ZTRTN="DQDD^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQDD K ^TMP($J)
 N CHKDATE
 S PR=0 F  S PR=$O(^SD(403.5,"C",PR)) Q:PR=""  I $P($G(^SD(403.54,PR,0)),U,2)=+ZTEAM S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .I $P($G(^SD(403.5,D0,0)),"^",10)="" QUIT
 .; SD*569 - Prevent from printing more than ONE second card
 .I $P($G(^SD(403.5,D0,0)),"^",13)'="" QUIT
 .S CHKDATE=5 S RDATE=$P($G(^SD(403.5,D0,0)),"^",6) S CHECK=$$FMDIFF^XLFDT(RDATE,DT) I CHECK>CHKDATE K RDATE QUIT
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)["60" S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
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
 .S $P(^SD(403.5,D0,0),"^",13)=DT
 .D PR
 D ^%ZISC G QUIT
 Q
