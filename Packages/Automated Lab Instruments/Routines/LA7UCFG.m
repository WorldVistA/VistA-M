LA7UCFG ;DALOI/JMC - Configure Lab Universal Interface ;9/26/16  12:13
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**66,88,94**;Sep 27, 1994;Build 1
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 Q
 ;
EN ; Configure files #62.48 and #62.4 and auto release
 N DIR,DIROUT,DIRUT,DUOUT,LA7QUIT,X,Y
 F  D  Q:$D(DIRUT)
 . S DIR(0)="SO^1:LA7 MESSAGE PARAMETER (#62.48);2:AUTO INSTRUMENT (#62.4);3:Auto Release System Parameter;4:Configuration Report (132 COL);5:Holders of Lab keys;6:Ordering Provider Contact Parameter"
 . S DIR(0)=DIR(0)_";7:Convert LAB UI 1.6 to Enhanced Acknowledgement Mode"
 . S DIR("A")="Select which function to configure/report"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D E6248 Q
 . I Y=2 D  Q
 . . S LA7QUIT=0
 . . F  D E624 Q:LA7QUIT
 . I Y=3 D EDITPAR^XPAREDIT("LA UI AUTO RELEASE MASTER") Q
 . I Y=4 D PRINT Q
 . I Y=5 D ENKEY Q
 . I Y=6 D EDITPAR^XPAREDIT("LA UI PROVIDER CONTACT INFO") Q
 . I Y=7 D ENACK^LA7UCFG1 Q
 Q
 ;
 ;
E6248 ; Setup/edit file #62.48
 ;
 N DA,DIC,DIE,DLAYGO,DR,LA76248,X,Y
 W !
 S DIC="^LAHM(62.48,",DIC(0)="AELMQ",DIC("S")="I $P(^(0),U,9)=1",DLAYGO=62.48
 D ^DIC K DIC("S")
 I Y<1 Q
 S (DA,LA76248)=+Y
 L +^LAHM(62.48,LA76248):DILOCKTM
 I '$T W !?5,"Another user is editing this entry." Q
 S DIE=DIC,DR="2;3;4;20"
 D ^DIE
 L -^LAHM(62.48,LA76248)
 Q
 ;
 ;
E624 ; Setup/edit file #62.4
 ;
 N DA,DIC,DIE,DLAYGO,DR,FDA,LA7624,LA76248,LA7ERR,X,Y
 ;
 ;ZEXCEPT: LA7QUIT
 ;
 W !
 S DIC="^LAB(62.4,",DIC(0)="AELMQ",DIC("S")="I $P(^(0),U)'[""LA7V"",$P(^(0),U)'[""LA7P""",DLAYGO=62.4
 D ^DIC K DIC("S")
 I Y<1 S LA7QUIT=1 Q
 S (DA,LA7624)=+Y
 ;
 L +^LAB(62.4,LA7624):DILOCKTM
 I '$T W !?5,"Another user is editing this entry." Q
 ;
 S DIE=DIC,DR=".01;3;5;6;8;10;11;12;18;.02;95;98;99;30;107"
 I DUZ(0)="@" S DR(2,62.41)=".01;2;6;15;7;8;9;12;13;14;16;17;18;19"
 E  S DR(2,62.41)=".01;6;15;7;8;9;12;13;14;16;17;18;19"
 D ^DIE
 ;
 ; Stuff file build logic into entry if UI interface
 S LA76248=$P($G(^LAB(62.4,LA7624,0)),"^",8)
 I $D(DA),LA76248,$P($G(^LAHM(62.48,LA76248,0)),"^",9)=1 D
 . W !!,"Setting fields for auto download  FILE BUILD ENTRY (#93) to: EN"
 . W !,"                                FILE BUILD ROUTINE (#94) to: LA7UID"
 . S FDA(1,62.4,LA7624_",",93)="EN"
 . S FDA(1,62.4,LA7624_",",94)="LA7UID"
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 . W " ...",$S('$D(LA7ERR(1)):"Done",1:"Update FAILED")
 . I $D(LA7ERR(1)) W !,"Error Reported by FileMan: ",$G(LA7ERR(1,"DIERR",1,"TEXT",1))
 ;
 ; If entry set for Auto Release then check related load list for desginated auto release profile.
 I $P($G(^LAB(62.4,LA7624,9)),U,11) D
 . N DA,DIE,DR,LA7682
 . S LA7682=$P($G(^LAB(62.4,LA7624,0)),U,4)
 . I $D(^LRO(68.2,"AR",1,LA7682)) Q  ; Loadlist already have profile flagged for auto release
 . W !!,"As this auto instrument is configured for auto release,"
 . W !,"please designate the associated load list profile to be used for auto release.",!
 . W !,"Editing load list: ",$P(^LRO(68.2,LA7682,0),U),!
 . S DIE="^LRO(68.2,",DA=LA7682,DR=50,DR(2,68.23)="2.4"
 . D ^DIE
 ;
 L -^LAB(62.4,LA7624)
 Q
 ;
 ;
PRINT ; Print lab universal interface configuration report
 N %ZIS,DIC,LA7624,ZTDTH,ZTSK,ZTRTN,ZTIO,ZTSAVE,X,Y
 ;
 D EN^DDIOL("","","!")
 S DIC="^LAB(62.4,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U)'[""LA7V"",$P(^(0),U)'[""LA7P"""
 D ^DIC
 I Y<1 Q
 S LA7624=+Y
 ;
 S %ZIS="MQ" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQP^LA7UCFG",ZTSAVE("LA7624")="",ZTDESC="Print Lab Universal Interface Configuration Report"
 . D ^%ZTLOAD,^%ZISC
 . D EN^DDIOL("Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued"),"","!")
 ;
DQP ; entry point from above and TaskMan
 ;
 N X,Y
 N LA7EXIT,LA7LINE,LA7LINE2,LA7NOW,LA7PAGE
 N LRLL,LRPROF
 S LA7NOW=$$HTE^XLFDT($H),(LA7EXIT,LA7PAGE)=0
 S LA7624(0)=$G(^LAB(62.4,LA7624,0))
 S LA7LINE=$$REPEAT^XLFSTR("=",IOM)
 S LA7LINE2=$$REPEAT^XLFSTR("-",IOM)
 D HDR
 N ARPCNT,LA7PROXY,LA7PROXID,LA7DIV,LA7SITE,LA7VAF,PCNT,LR60,LRD,LRDN,LRX,XURET
 W !,"VistA Lab Auto Release Master: ",$S($$GET^XPAR("SYS^PKG","LA UI AUTO RELEASE MASTER",1,"E")="":"NO (DISABLED)",1:$$GET^XPAR("SYS^PKG","LA UI AUTO RELEASE MASTER",1,"E"))
 ;
 W !!,"VistA Application Proxy",?28,"ID/DUZ",?45,"HL7 encoding format",!,LA7LINE2
 F LA7PROXY="LRLAB, AUTO VERIFY","LRLAB, AUTO RELEASE" D
 . S LA7PROXID=$$FIND1^DIC(200,,"X",LA7PROXY,"B")
 . S LA7DIV=+$$KSP^XUPARAM("INST")
 . S LA7SITE=$$RETFACID^LA7VHLU2(LA7DIV,0,1)
 . S LA7VAF=$$GET1^DIQ(4,LA7DIV_",","AGENCY CODE","I")
 . I LA7VAF="V" S LA7SITE="VA"_LA7SITE
 . W !,?2,LA7PROXY,?25,$S(LA7PROXID'=0:$J(LA7PROXID,10),1:"** NOT DEFINED **")
 . I LA7PROXID'=0 W ?38," ",LA7PROXID_"-"_LA7SITE_"^"_$$HLNAME^XLFNAME(LA7PROXY,"S","^")_"^^^^99VA4"
 W !!,"HL7 Components: <ID Number (ST)> ^ <Family Name (FN)> ^ <Given Name (ST)> ^ ^ ^ ^ ^ <Source Table (IS)> ^"
 ;
 W !!!,"Instrument Auto Download Status.: ",$$GET1^DIQ(62.4,LA7624_",",98)
 I $$GET1^DIQ(62.4,LA7624_",",98)'="YES" W !?10,"**Warning - Auto Download not enabled for auto instrument: ",$P(LA7624(0),"^",1)
 W !,"Instrument Auto Download Routine: ",$S($$GET1^DIQ(62.4,LA7624_",",93)'="":$$GET1^DIQ(62.4,LA7624_",",93),1:"(Entry Not Defined)"),$S($$GET1^DIQ(62.4,LA7624_",",94)'="":"^"_$$GET1^DIQ(62.4,LA7624_",",94),1:"(Routine Not Defined)")
 ;
 W !!,"Instrument Auto Release Status: ",$$GET1^DIQ(62.4,LA7624_",",99)
 ;I $$GET1^DIQ(62.4,LA7624_",",99)'="YES" W !?10,"**Warning - Auto Release not enabled for auto instrument: ",$P(LA7624(0),"^",1)
 ;
 W !!,"Associated Lab UI Message Configuration: ",$$GET1^DIQ(62.4,LA7624_",",8)
 I $$GET1^DIQ(62.4,LA7624_",",8)="" W !?10,"**Warning - Message Configuration not defined for auto instrument: ",$P(LA7624(0),"^",1)
 ;
 W !!,"Associated Load/Work List: ",$$GET1^DIQ(62.4,LA7624_",",3)
 S LRLL=$P(LA7624(0),"^",4) ;load/work list
 I 'LRLL W !?10,"**Warning - No load/work list defined for auto instrument: ",$P(LA7624(0),"^",1)
 ;
 S LRX=$$FIND1^DIC(200,"","OX","LRLAB,AUTO RELEASE","B","") I LRX<1 W !?10,"**Warning - Unable to identify proxy 'LRLAB,AUTO RELEASE' in NEW PERSON file" ;find duz of proxy
 I LRX S XURET=$$DIV4^XUSER(.XURET,.LRX) ;return proxy's divisions
 S PCNT=0,ARPCNT=0,LRPROF=0
 I LRLL F  S LRPROF=$O(^LRO(68.2,LRLL,10,LRPROF)) Q:'LRPROF  D
 . S PCNT=PCNT+1 ; count profiles
 . I $$GET1^DIQ(68.23,LRPROF_","_LRLL_",",2.4)="YES" D
 . . S ARPCNT=ARPCNT+1 ;count auto release profiles
 . . W !?5,"Auto Release Profile: ",$$GET1^DIQ(68.23,LRPROF_","_LRLL_",",.01)
 . . S LRD=+$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),"^",5),LRDN=$$GET1^DIQ(68.23,LRPROF_","_LRLL_",",2.3) ;default reference lab and name
 . . W !?11,"Performing Lab: ",$S(LRDN'="":LRDN,1:"** None Defined **")
 . . I '$D(XURET(LRD)) D
 . . . I LRDN'="" W !?11,"**Warning - 'LRLAB,AUTO RELEASE' proxy has not been assigned division '",LRDN,"' in",!?24,"the file NEW PERSON (#200), field DIVISION (#16)."
 . . . I LRDN="" W !?11,"**Warning - Performing lab required to be specified for Auto Release."
 I 'PCNT W !?10,"**Warning - No profile defined for auto release"
 I 'ARPCNT W !?10,"**Warning - No profile enabled for auto release"
 I ARPCNT>1 W !?10,"**Warning - Multiple profiles enabled for auto release (should only be one)"
 ;
 I ($Y+6)>IOSL D HDR
 I LA7EXIT D CLEAN Q
 D SH1
 S I=0 F  S I=$O(^LAB(62.4,LA7624,3,I)) Q:'I  S X(0)=$G(^(I,0)),X(2)=$G(^(2)) I $P(X(2),"^",4)=1 D  Q:LA7EXIT
 . S LR60=+$P(X(0),"^",1)
 . I ($Y+6)>IOSL D HDR Q:LA7EXIT  D SH1 Q:LA7EXIT
 . W !,$J("["_I_"]",4),?5,$$GET1^DIQ(62.41,I_","_LA7624_",",.01),?45,$$GET1^DIQ(62.41,I_","_LA7624_",",6),?75,$$GET1^DIQ(62.41,I_","_LA7624_",",7),?95,$$GET1^DIQ(60,LR60_",",400)," [",$P($G(^LAB(60,LR60,.2)),"^",1),"]"
 . I $S($P(X(2),"^",13)'="":1,$P(X(2),"^",14)'="":1,1:0) D
 . . W !
 . . I $P(X(2),"^",13)'="" W ?10,"Specimen: ",$$GET1^DIQ(62.41,I_","_LA7624_",",8)
 . . I $P(X(2),"^",14)'="" W ?90,"Urgency: ",$$GET1^DIQ(62.41,I_","_LA7624_",",9)
 ;
 I LA7EXIT D CLEAN Q
 I ($Y+6)>IOSL D HDR
 I LA7EXIT D CLEAN Q
 D SH2
 S I=0 F  S I=$O(^LAB(62.4,LA7624,3,I)) Q:'I  S X(2)=$G(^(I,2)) I $P(X(2),"^",3)'=0 D  Q:LA7EXIT
 . I ($Y+6)>IOSL D HDR Q:LA7EXIT  D SH2 Q:LA7EXIT
 . W !,$J("["_I_"]",4),?5,$$GET1^DIQ(62.41,I_","_LA7624_",",.01),?45,$$GET1^DIQ(62.41,I_","_LA7624_",",6),?75,$J($$GET1^DIQ(62.41,I_","_LA7624_",",12),5),?85,$$GET1^DIQ(62.41,I_","_LA7624_",",13),?95,$$GET1^DIQ(62.41,I_","_LA7624_",",14)
 . W ?105,$$GET1^DIQ(62.41,I_","_LA7624_",",16),?115,$$GET1^DIQ(62.41,I_","_LA7624_",",17),?125,$$GET1^DIQ(62.41,I_","_LA7624_",",18)
 . I $P(X(2),"^",8)'="" W !?10,"Remark Prefix: ",$$GET1^DIQ(62.41,I_","_LA7624_",",19)
 . I $$GET1^DIQ(62.41,I_","_LA7624_",",2)'="" W !?10,"Param 1: ",$$GET1^DIQ(62.41,I_","_LA7624_",",2)
 ;
 I '$D(ZTQUEUED),'LA7EXIT,$E(IOST,1,2)="C-" D TERM
 D CLEAN
 Q
 ;
 ;
CLEAN ; Clean up and quit
 I $E(IOST,1,2)'="C-"  W @IOF
 I '$D(ZTQUEUED) D ^%ZISC
 E  S ZTREQ="@"
 Q
 ;
 ;
HDR ; Header for lab universal interface configuration report
 I '$D(ZTQUEUED),LA7PAGE,$E(IOST,1,2)="C-" D TERM Q:$G(LA7EXIT)
 W @IOF S $X=0
 S LA7PAGE=LA7PAGE+1
 W !,"Lab Universal Interface Configuration Report",?IOM-29," Page: ",LA7PAGE
 W !," for interface: ",$P(LA7624(0),"^"),?IOM-32," Printed: ",LA7NOW
 W !,LA7LINE,!
 Q
 ;
 ;
SH1 ;Sub header #1
 W !!,"ORDERABLE TESTS"
 W !,"Entry",?10,"Name",?45,"UI Test Code",?75,"Accession Area",?95,"Data Name [IEN]"
 W !,LA7LINE2
 Q
 ;
 ;
SH2 ;Sub head #2
 W !!,"REPORTABLE TESTS"
 W ?75,"Decimal",?84,"Result to",?95,"Accept",?105,"Ignore",?115,"Remove",?125,"Store"
 W !,"Entry",?10,"Name",?45,"UI Test Code",?75,"Places",?85,"Remark",?95,"Results",?105,"Results",?115,"Spaces",?125,"Remarks"
 W !,LA7LINE2
 Q
 ;
 ;
TERM ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" D ^DIR S:$D(DIRUT) LA7EXIT=1
 Q
 ;
 ;
ENKEY ;entry point to holder(s) of lab key(s) option
 N DIC,X,Y,LRKEY,LRUSER
 W ! F  S DIC="^DIC(19.1,",DIC(0)="QEAM",DIC("S")="I $E($P(^(0),U,1),1,2)=""LR""",DIC("A")="Select "_$S($D(LRKEY):"Another ",1:"")_"LAB SECURITY KEY NAME: " D  Q:Y<0
 . D ^DIC I Y<0 Q
 . I '$D(^XUSEC($P(Y,"^",2))) W !!?5,"There are no holders of this key." Q
 . S LRKEY($P(Y,"^",2))="" ;array of lab keys
 I '$D(LRKEY) W !!,"No security keys selected." Q
 I X="^" Q
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="All USERS" D ^DIR K DIR I $D(DIRUT) Q
 I Y=1 S LRUSER="ALL" ;selecting all lab keys
 I 'Y W ! F  K DIC S DIC="^VA(200,",DIC(0)="QEAM",DIC("A")="Select "_$S($D(LRUSER):"Another ",1:"")_"USER: " D  Q:Y<0
 . D ^DIC I Y<0 Q
 . S LRUSER(+Y)="" ;array of lab keys
 I X="^" Q
 S ZTSAVE("LRKEY*")="",ZTSAVE("LRUSER*")=""
 W ! D EN^XUTMDEVQ("START^LA7UCFG","USERS HOLDING LAB KEYS",.ZTSAVE,"M") I 'POP Q
 W !,"NO DEVICE SELECTED OR REPORT PRINTED!!"
 Q
 ;
 ;
START ;print users holding lab keys
 N %,I,JJ,KTAB,LIN,LN,LRID,LRK,LRNAM,PG,POP,PRTDT,QFLG,SS,TAB,X,Y
 S (PG,QFLG)=0,U="^",$P(LN,"-",IOM+1)="" K ^TMP("LA7UCFG",$J)
 D NOW^%DTC S PRTDT=$$FMTE^XLFDT($E(%,1,12))
 ;
 I $G(LRUSER)="ALL" S LRK="" F  S LRK=$O(LRKEY(LRK)) Q:LRK=""  S LRID=0 F  S LRID=$O(^XUSEC(LRK,LRID)) Q:'LRID  D
 . S ^TMP("LA7UCFG",$J,$P($G(^VA(200,LRID,0)),"^",1),LRID,LRK)=""
 I $O(LRUSER(0)) S LRID=0 F  S LRID=$O(LRUSER(LRID)) Q:'LRID  S LRK="" F  S LRK=$O(LRKEY(LRK)) Q:LRK=""  I $D(^XUSEC(LRK,LRID)) D
 . S ^TMP("LA7UCFG",$J,$P($G(^VA(200,LRID,0)),"^",1),LRID,LRK)=""
 ;
 D KEYHDR I QFLG D EXIT Q
 S LRNAM="" F  S LRNAM=$O(^TMP("LA7UCFG",$J,LRNAM)) Q:LRNAM=""!(QFLG)  D
 . S LRID=0 F  S LRID=$O(^TMP("LA7UCFG",$J,LRNAM,LRID)) Q:'LRID  D
 . . I $Y+4>IOSL!'PG D KEYHDR I QFLG Q
 . . W !,$J(LRID,9),?10,LRNAM
 . . S LRK="" F  S LRK=$O(^TMP("LA7UCFG",$J,LRNAM,LRID,LRK)) Q:LRK=""  D
 . . . W ?KTAB(LRK),"X"
 I '$D(^TMP("LA7UCFG",$J)) W !," ** NO USERS FOR SELECTED LAB KEY(S) **"
 ;
 ;
EXIT ;
 K ^TMP("LA7UCFG",$J)
 I $E(IOST,1,2)="C-"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
KEYHDR ;header for security key report
 I $E(IOST,1,2)="C-" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST,1,2)="C-",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 I $Y!($E(IOST,1,2)="C-") W @IOF
 S PG=PG+1
 W !,PRTDT,?IOM-10,"Page: ",PG
 S LIN(1)="HOLDERS OF LAB KEYS"
 F I=1:1 Q:'$D(LIN(I))  W !,?(IOM\2-($L(LIN(I))\2)),LIN(I)
 W !!?1,"DUZ/ID",?10,"NAME" S TAB=40,I="" F  S I=$O(LRKEY(I)) Q:I=""  S KTAB(I)=TAB+($L(I)/2) W ?TAB,I S TAB=TAB+$L(I)+1
 W !,LN
 Q
 ;
 ;
