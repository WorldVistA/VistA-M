FBARCHU ; HINOIFO/BNT - ARCH ELIGIBILITY ; 05/03/11 5:30pm
 ;;3.5;FEE BASIS;**130**;JAN 30, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Integration Agreements:
 ;
 Q
 ;
ADD ; Add patient to the ARCH ELIGIBILITY Multiple
 N FBQUIT,Y,X,DFN,DA,FBARCH,FBUSER,FBJUST,FBMILE,FBDATA,FBI11,FBIEN2,FBSITE,FBPOP,DUOUT,DTOUT,DIRUT,DIROUT,DINUM,DLAYGO,DILOCKTM,DD,DO,D,DIC,DIR
 S (FBARCH,FBQUIT)=0,(FBJUST,FBMILE)=""
 D SITEP^FBAAUTL Q:FBPOP  ;S FBAADDYS=+$P(FBSITE(0),"^",13),FBAAASKV=$P(FBSITE(1),"^",1),FBPROG=$S($P(FBSITE(1),"^",6)="":"I 1",1:"I $P(^(0),U,3)=2")
 W ! K DIC S DIC="^DPT(",DIC(0)="QEAZM" D ^DIC S DFN=+Y
 Q:'$D(^DPT(DFN))
 S DA=DFN I '$D(^FBAAA(DA,0)) D  Q:FBQUIT
 . L +^FBAAA(DFN):$G(DILOCKTM,3) I '$T D  S FBQUIT=1 Q
 . . W !,"This record is being edited by another user. Try again later.",!
 . K DD,DO S (X,DINUM)=DA,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN L -^FBAAA(DFN) K DIC
 S:'$D(^FBAAA(DFN,1,0)) ^(0)="^161.01D^^"
 I $D(^FBAAA(DFN,"ARCHFEE")) D  Q:FBQUIT
 . S FBI11=$O(^FBAAA(DFN,"ARCHFEE"," "),-1)
 . S FBARCH=$P(^FBAAA(DFN,"ARCHFEE",FBI11,0),U,2)
 . I $P(^FBAAA(DFN,"ARCHFEE",FBI11,0),U,3)="" D  Q
 . . W !,"This patient was determined Project ARCH Eligible by the"
 . . W !,"national extract and cannot be edited."
 . . W !!,"Only manually added patients can be edited."
 . . S FBQUIT=1 Q
 W !,$P(^DPT(DFN,0),U)_" is "_$S(FBARCH>0:"",1:"NOT ")_"Project ARCH eligible.",!
 S DIR("A")="Change to "_$S(FBARCH>0:"NOT ",1:"")_"Project ARCH eligible? (Y/N): "
 S DIR(0)="YA",DIR("B")="YES" D ^DIR
 I $G(DUOUT)!$G(DTOUT)!$G(DIROUT)!$G(DIRUT)!(Y="^") Q
 Q:'Y
 ;
 ; Prompt for Justification
 I 'FBARCH S FBJUST=$$SELJUST^FBARCHR0() I FBJUST="^" G XDEV
 ;
 ; Prompt for Verification of Mileage
 I 'FBARCH D  Q:FBQUIT
 . K DIR S DIR(0)="F^3:100:EMZ",DIR("A")="Enter Verification of Mileage"
 . S DIR("?")="Enter how the mileage requirement was verified (i.e. Google Maps, Zip Code listing, etc.)"
 . D ^DIR
 . I $G(DUOUT)!$G(DTOUT)!$G(DIROUT)!$G(DIRUT)!(Y="^") S FBQUIT=1 Q
 . S FBMILE=Y K DIR
 ;
 ;update eligibility
 S FBARCH=$S('FBARCH:1,1:0)
 S FBIEN2="+2,"_DFN
 S FBDATA(161.011,FBIEN2_",",.01)=$$DT^XLFDT()
 S FBDATA(161.011,FBIEN2_",",2)=FBARCH
 S FBDATA(161.011,FBIEN2_",",3)=DUZ
 I FBJUST]"" S FBDATA(161.011,FBIEN2_",",4)=FBJUST
 I FBMILE]"" S FBDATA(161.011,FBIEN2_",",5)=FBMILE
 ;
 D UPDATE^DIE("","FBDATA")
 K FBDATA
 W !!,$P(^DPT(DFN,0),U)_" is "_$S('FBARCH:"NOT ",1:"")_"Project ARCH eligible.",!
 K DIR S DIR(0)="E" D ^DIR
 ;
 Q
 ;
VIEW ; View Project ARCH Eligibility
 N Y,FBNOW,FBSUMDET,FBEXCEL,FBQ,FBRPTNAM,FBPAT,FBBEGDT,FBENDDT,FBELIG,FBELDET,FBDATA,FBSCR
 ; Quit if the user does not hold the FB ARCH security key
 Q:'$$CHKKEY^FBARCHR0("FB ARCH")
 ;
 ;Get current Date/Time
 D NOW^%DTC S Y=% D DD^%DT S FBNOW=Y
 ;
 S FBRPTNAM="Project ARCH Eligibility Report"
 ;
 ;Prompt to Display for One Patient or All Patients (Default to All)
 S FBPAT=$$SELPAT^FBARCHR0(0) I FBPAT="^" G XDEV
 ;
 ;Prompt to select Eligibility Determination Date Range
 ;Returns (Start Date^End Date)
 S FBBEGDT=$$SELDATE^FBARCHR0(0) D  I FBBEGDT="^" G XDEV
 . I FBBEGDT="^" Q
 . S FBENDDT=$P(FBBEGDT,U,2)
 . S FBBEGDT=$P(FBBEGDT,U)
 ;
 ;Prompt to select ARCH Eligibility
 S FBELIG=$$SELELIG^FBARCHR0(2) I FBELIG="^" G XDEV
 ;
 ;Prompt to select ARCH Eligibility Determination
 S FBELDET=$$SELELDET^FBARCHR0(2) I FBELDET="^" G XDEV
 ;
 ;Prompt to Display Summary or Detail Format (Default to Detail)
 ;Returns 1 for Summary, 0 for Detail
 S FBSUMDET=$$SELSMDET^FBARCHR0(2) I FBSUMDET="^" G XDEV
 ;
 ;Prompt for Excel Capture (Detail Only)
 S FBEXCEL=0 I 'FBSUMDET S FBEXCEL=$$SELEXCEL^FBARCHR0() I FBEXCEL="^" G XDEV
 ;
 ;Prompt for the Device
 S FBQ=0 D DEVICE(FBRPTNAM) Q:FBQ
 ;
 ;Compile and Run the Report
 D RUN(FBEXCEL,FBRPTNAM,FBSUMDET)
 I 'FBQ D PAUSE2^FBARCHR0
 ;
 Q
 ;
RUN(FBEXCEL,FBRPTNAM,FBSUMDET) ; Run the report
 N FBPAGE,FBTMP,FBCNT
 S FBTMP=$NA(^TMP($J,"ARCH"))
 K @FBTMP
 S FBPAGE=0
 W:FBSCR&'FBEXCEL !,"Please wait...",!
 ;
 ;Compile the report
 S FBCNT=$$ELIGLST(FBTMP) Q:'FBCNT
 U IO
 ;
 ;Display the report
 D REPORT^FBARCHR0(FBTMP,FBEXCEL,FBSCR,FBRPTNAM,FBPAT,FBBEGDT,FBENDDT,FBELIG,FBELDET,FBSUMDET,FBPAGE)
 I 'FBSCR W !,@IOF
 ;K @FBTMP
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
ELIGLST(FBTMP) ; Get the current eligibility list
 ; Returned in ^TMP($J,"ARCH",DFN,DATE,ELIG IEN)=""
 N DFN,FB11,FBDATE,FBCNT
 K @FBTMP
 S (FBCNT,FBDATE)=0
 F  S FBDATE=$O(^FBAAA("ARCH",FBDATE)) Q:FBDATE=""  D
 . S DFN="" F  S DFN=$O(^FBAAA("ARCH",FBDATE,DFN)) Q:DFN=""  D
 . . S FB11="" F  S FB11=$O(^FBAAA("ARCH",FBDATE,DFN,FB11)) Q:FB11=""  D
 . . . S @FBTMP@(DFN,$P(FBDATE,"."),FB11)=""
 . . S FBCNT=FBCNT+1
 . Q
 S @FBTMP@("TOTAL")=FBCNT
 Q FBCNT
 ;
 ;Prompt For the Device
 ;
 ; Returns Device variables and FBSCR
 ;
DEVICE(FBRPTNAM) ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S FBQ=1
 ;
 ;Check for exit
 I $G(FBQ) G XDEV
 ;
 S FBSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S FBQ=1
 . S ZTRTN="RUN^FBARCHU(FBEXCEL,FBRPTNAM,FBSUMDET)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC=FBRPTNAM
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
XDEV Q
