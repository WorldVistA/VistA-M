SDRRRECL ;10N20/MAH - Recall Reminder Manual Printing;09/20/2004
 ;;5.3;Scheduling;**536,561,569,579,654**;Aug 13, 1993;Build 5
 ;;This routine is called from SDRRLRP 
 ;;If the site has set TYPE OF NOTIFICATION to LETTER this routine
 ;;will run.
 ;
 ; SD*654
 ; - do not update date if letter printed to a computer screen.
 ; - adds missing var DFN when calling $$BADADR^DGUTL3 and
 ;   quits updating date and printing ltr if bad addr.
 ; - changes word 'card' to 'letter' in the message.
 ; - fixes incomplete Canadian address.
 ;
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
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing ltr if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address - letter will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if displaying to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
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
 ; SD*579 - Add date printed and last 4
 S PRNDT=$TR($$FMTE^XLFDT(DT,"5DF")," ","0")
 S LAST4=$E($P(VA("BID"),U),1,4)
 W @IOF
 W !,?65,PRNDT
 W !,?65,$E(PN,1)_LAST4
 F L=1:1:9 W !
 ;
 ; SD*579 - Fix suffix listed problem
 S PNAME=$$NAMEFMT^XLFNAME(PN,"G","")
 W !?20,PNAME
 D ADDR
 I $D(MESSAGE) W !!!!!,?25,MESSAGE
 ; SD*569 - Adjust the tab starting position
 I TIME'="" W !!!!?2,TIME
 I LAB'="" W !!!!!,?2,"*"_LAB
 W !!!
 S:'$D(MESSAGE) LETTER=$O(^SD(403.52,"B",DIV,LETTER))
 I LETTER>0 S LINE=0 F  S LINE=$O(^SD(403.52,LETTER,1,LINE)) Q:'LINE  W !,?2,$P(^SD(403.52,LETTER,1,LINE,0),"^",1)
 K MESSAGE,PRNDT,LAST4,PNAME
 Q
EN1 ;print letters by provider
 S DIC="^SD(403.54,",DIC(0)="AEQMZ",DIC("A")="Select Provider: " D ^DIC G:Y<0 QUIT S PR=+Y
 D SELDT G:Y<0 QUIT  ;SD*5.3*561 quit if no date range entered
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters by Provider",ZTRTN="DQD1^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD1 K ^TMP($J)
 U IO S D0=0 F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 .; SD*579 - If entry not exist, kill x-refs and quit.
 .I '$D(^SD(403.5,D0)) D KXREF Q
 .S DTA=$G(^SD(403.5,D0,0))
 .I CLINIC="" S FAIL=1 S MESSAGE="***NO CLINIC ON FILE**"
 .I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC))  S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 .I CLINIC'="",(FAIL=0) S DIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 .S TIME=""
 .I $P($G(^SD(403.5,D0,0)),"^",9)>30 S TIME=$P($G(^SD(403.5,D0,0)),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 .S DFN=+DTA
 .Q:$P(DTA,U,6)<SDT!($P(DTA,U,6)>EDT)
 .Q:$$TESTPAT^VADPT(DFN)
 .D ADD^VADPT,DEM^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .S PN=$P(VADM(1),U)
 .I $G(VADM(6),U)'="" Q
 .; SD*654 - add missing var DFN
 .;        - quit updating date and printing ltr if bad addr
 .S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ..S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ..S SDRR(1)="Bad Address - letter will not be printed for:"_"   "_PN_"   "_VA("BID")
 ..D ^XMD
 ..K XMY,XMSUB,XMTEXT,XMDUZ
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if letter printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
 .D PR
 D ^%ZISC G QUIT
EN3 ;PRINT LETTER FOR A TEAM
 W ! S DIC="^SD(403.55,",DIC(0)="AEQMZ",DIC("A")="Select Clinic Recall Team: " D ^DIC S TEAM=+Y K DIC G:Y<0 QUIT
 D SELDT G:Y<0 QUIT  ;SD*561 quit if no date range entered
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters for a Team",ZTRTN="DQD4^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD4 S PR=0 F  S PR=$O(^SD(403.54,"C",TEAM,PR)) Q:'PR  S D0=0 D
 .F  S D0=$O(^SD(403.5,"C",PR,D0)) Q:D0=""  S (CLINIC,FAIL)=0 S CLINIC=$P($G(^SD(403.5,D0,0)),"^",2) D
 ..; SD*579 - If entry not exist, kill x-refs and quit.
 ..I '$D(^SD(403.5,D0)) D KXREF Q
 ..S DTA=$G(^SD(403.5,D0,0))
 ..I CLINIC="" S FAIL=1 S MESSAGE="***NO CLINIC ON FILE**"
 ..I CLINIC'=""  I '$D(^SD(403.52,"B",CLINIC))  S MESSAGE="***NO CLINIC LETTER ON FILE**" S FAIL=1
 ..I CLINIC'="",(FAIL=0) S DIV=CLINIC S LETTER=0,LETTER=$O(^SD(403.52,"B",CLINIC,LETTER))
 ..S TIME=""
 ..I $P($G(^SD(403.5,D0,0)),"^",9)>30 S TIME=$P($G(^SD(403.5,D0,0)),"^",9) S TIME="**"_TIME_"**"
 ..S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 ..S DFN=+DTA
 ..Q:$P(DTA,U,6)<SDT!($P(DTA,U,6)>EDT)  ;SD*561 check selected date range
 ..Q:$$TESTPAT^VADPT(DFN)
 ..D ADD^VADPT,DEM^VADPT
 ..S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 ..S PN=$P(VADM(1),U)
 ..I $G(VADM(6),U)'="" Q
 ..; SD*654 - add missing var DFN
 ..;        - quit updating date and printing ltr if bad addr
 ..S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ...S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ...S SDRR(1)="Bad Address - letter will not be printed for:"_"   "_PN_"   "_VA("BID")
 ...D ^XMD
 ...K XMY,XMSUB,XMTEXT,XMDUZ
 ..;ADDED THE DATE INFORMATION
 ..; SD*654 - do not update date if letter printed to a computer screen.
 ..I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
 ..D PR
 D ^%ZISC G QUIT
 ;done and tested
EN4 ;PRINT LETTER FOR ONE PATIENT
 K X W ! S DIC="^SD(403.5,",DIC(0)="AEQMZ",DIC("A")="Select Patient: " D ^DIC S D0=+Y K DIC G:Y<0 QUIT
 S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<0  S DIV=+Y K DIC G:Y<0 QUIT
 I '$D(^SD(403.52,"B",DIV)) W !,?5,"**NO RECALL LETTER ON FILE**" G QUIT
 I '$D(^SD(403.5,"E",DIV,D0)) W *7,!!,?5,"**This patient does not have a recall reminder for the selected clinic**",!! G QUIT
 ;
 ; SD*654 - Check if it needs to quit before prompting for device
 S DFN=+$G(^SD(403.5,D0,0))
 D DEM^VADPT
 S PN=$P(VADM(1),U)
 ; SD*654 - add missing var DFN
 ;        - quit updating date and printing ltr if bad addr
 S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  W !!,?5,"**This patient has been flagged with a Bad Address Indicator.**",!! G QUIT
 . S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 . S SDRR(1)="Bad Address - letter will not be printed for:"_"   "_PN_" "_VA("BID")
 . D ^XMD
 . K XMY,SMSUB,XMTEXT,XMDUZ
 ; quit if DoD
 I $G(VADM(6),U)'="" W !!,?5,VADM(7),!! G QUIT
 ; quit if test pat
 I $$TESTPAT^VADPT(DFN) W !!,?5,"**You may have selected a test patient.**",!! G QUIT
 ; SD*654 - End
 ;
 S %ZIS="QM" D ^%ZIS G:POP QUIT I $D(IO("Q")) S ZTDESC="Print Recall Letters for a Patient",ZTRTN="DQD3^SDRRRECL" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
DQD3 K ^TMP($J)
 S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .; SD*569 - Quit if patient's clinic does not match the selected hospital location.
 .I $P(DTA,"^",2)'=DIV Q
 .S TIME=""
 .I $P(^SD(403.5,D0,0),"^",9)>30 S TIME=$P(^SD(403.5,D0,0),"^",9) S TIME="**"_TIME_"**"
 .S LAB=$S($P($G(^SD(403.5,D0,0)),"^",8)="f":"Lab test(s) have been ordered that require you to FAST",$P(^SD(403.5,D0,0),"^",8)="n":"Lab test(s) have been ordered, which need to be done before an appointment is made",1:"")
 .S DFN=+DTA
 .D ADD^VADPT
 .S STATE=$P(VAPA(5),"^",1),STATE=$$GET1^DIQ(5,STATE_",",1)
 .;ADDED THE DATE INFORMATION
 .; SD*654 - do not update date if letter printed to a computer screen.
 .I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",10)=DT
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
 ..; SD*579 - If entry not exist, kill x-refs and quit
 ..I '$D(^SD(403.5,D0)) D KXREF Q
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
 ..; SD*654 - add missing var DFN
 ..;        - quit updating date and printing ltr if bad addr
 ..S CHECK=$$BADADR^DGUTL3(DFN) I CHECK>0 S XMSUB="Bad Address for Recall Reminder Patient",XMTEXT="SDRR(" D  Q
 ...S XMY("G.SDRR BAD ADDRESS")="",XMDUZ=.5
 ...S SDRR(1)="Bad Address - letter will not be printed for:"_"   "_PN_"   "_VA("BID")
 ...D ^XMD
 ...K XMY,XMSUB,XMTEXT,XMDUZ
 ..;ADDED THE DATE INFORMATION
 ..; SD*654 - do not update date if letter printed to a computer screen.
 ..I $E(IOST,1,2)'="C-" S $P(^SD(403.5,D0,0),"^",13)=DT
 ..D PR
 D ^%ZISC G QUIT
 Q
 ;
KXREF ; SD*579 - kill x-refs if entry not exist
 S STR="BCDE"
 F I=1:1:$L(STR) D
 .S X=$E(STR,I,I)
 .S N3=0 F  S N3=$O(^SD(403.5,X,N3)) Q:N3'>0  D
 ..S N4=0 F  S N4=$O(^SD(403.5,X,N3,N4)) Q:N4'>0  D
 ...I N4=D0 K ^SD(403.5,X,N3,N4)
 K I,STR,X,N3,N4
 Q
 ;
ADDR ; SD*654 - Patient address
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
