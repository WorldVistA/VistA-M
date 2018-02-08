SDRRRECP ;10N20/MAH - Recall Reminder Manual Printing;09/20/2004
 ;;5.3;Scheduling;**536,569,579,654**;Aug 13, 1993;Build 5
 ;;This routine is called from SDRRLRP 
 ;;If the site has set TYPE OF NOTIFICATION to CARDS this routine
 ;;will run.
 ;
 ; SD*654
 ; - do not update date if card printed to a computer screen.
 ; - adds missing var DFN when calling $$BARADR^DGUTL3 and
 ;   quits printing if bad addr.
 ; - fixes incomplete Canadian address
 ;
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing card if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing card if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
QUIT K ADTA,D0,DFN,DIC,DIR,DIRUT,DTA,I,L,PN,POP,Y,DIV,EDT,PR,SDT,TIME,LAB,Y,STATE,PNAME
 K DATE,DOD,X,Q,%DT,%ZIS,SDRR,VA,CHECK,ZTDESC,ZTDSC,ZTEAM,ZTIO,ZTRTN,ZTSAVE
 Q
SELDT S %DT="AEX",%DT("A")="Start with RECALL DATE: " D ^%DT Q:Y<0  S SDT=Y,%DT("A")="End with RECALL DATE: " D ^%DT I Y<SDT W $C(7),"  ??" G SELDT
 S EDT=Y Q
PR W @IOF F L=1:1:7 W !
 S PNAME=$$NAMEFMT^XLFNAME(PN,"G","")
 W !?20,PNAME
 D ADDR
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing card if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 ..D ^%ZISC G QUIT
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing card if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN4 ;PRINT BY Patient
 W ! S DIC="^SD(403.5,",DIC(0)="AEQMZ",DIC("A")="Select Patient: " D ^DIC G:Y<0 QUIT S D0=+Y
 ;
 ; SD*654 - Check if it needs to quit before prompting for device
 S DFN=+$G(^SD(403.5,D0,0))
 I $$TESTPAT^VADPT(DFN) W !!,?5,"**You may have selected a test patient.**",!! G QUIT  ; quit if test pat
 D DEM^VADPT
 S PN=$P(VADM(1),U)
 ; SD*654 - add missing var DFN
 ;        - quit updating date and printing card if bad addr
 S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  W !!,?5,"**This patient has been flagged with a Bad Address Indicator.**",!! G QUIT
 . S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 . S SDRR(1)="Bad Address - card will not be printed for:"_"    "_PN_"    "_VA("BID")
 . D ^XMD
 . K XMY,XMSUB,XMTEXT,XMDUZ
 I $G(VADM(6),U)'="" W !!,?5,VADM(7),!! G QUIT  ; quit if DoD
 ; SD*654 - end
 ;
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Cards by Prov",ZTRTN="DPP^SDRRRECP" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DPP K ^TMP($J)
 S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"**FL",$P(^SD(403.5,D0,0),"^",8)="n":"**NFL",1:"")
 .S DFN=+DTA
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN5 ;PRINT BY NONRESPONSIVE PATIENTS
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing card if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address- card will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if card printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",13)=DT
 .D PR
 D ^%ZISC G QUIT
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
