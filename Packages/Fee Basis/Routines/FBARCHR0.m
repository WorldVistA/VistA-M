FBARCHR0 ; HINOIFO/BNT - ARCH Reports ; 05/09/11 5:30pm
 ;;3.5;FEE BASIS;**130**;JAN 30, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Integration Agreements:
 ;
 Q
 ;
 ;
SELSMDET(DFLT) ; Display (S)ummary or (D)etail Format
 ; Input Variable -> DFLT = 1 Summary
 ;                          2 Detail
 ;                          
 ; Return Value ->   1 = Summary
 ;                   0 = Detail
 ;                   ^ = Exit
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=1:"Summary",$G(DFLT)=0:"Detail",1:"Detail")
 S DIR(0)="S^S:Summary;D:Detail",DIR("A")="Display (S)ummary or (D)etail Format",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="S":1,Y="D":0,1:Y)
 Q Y
 ;
SELEXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^FBARCHR0"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXMSG
 ;
 Q EXCEL
 ;
SELPAT(DFLT) ; - Returns either a Fee Basis Patient IEN or 0 for All patients
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=1:"One Patient",$G(DFLT)=0:"All Patients",1:"All Patients")
 S DIR(0)="S^P:One Patient;A:All Patients",DIR("A")="Display One (P)atient or (A)ll Patients",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="P":1,Y="A":0,1:Y)
 I Y D
 . N DIR,DIRUT,DTOUT,DUOUT
 . ;Prompt to select FEE BASIS PATIENT file entry
 . S DIR(0)="P^161:EMZ",DIR("S")="I $D(^FBAAA(Y,""ARCHFEE"",0))"
 . D ^DIR I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 . I +Y S Y=+Y
 Q Y
 ;            
SELDATE(DFLT) ; Select Date Range
 ; Input Variable -> DFLT = 1 - ARCH Eligibility Date
 ;                          0 - All Dates
 ;
 ; Return Value -> P1^P2
 ; 
 ;           where P1 = From Date
 ;                    = ^ Exit
 ;                 P2 = To Date
 ;                    = blank for Exit
 ;
 N DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 S DFLT=$S($G(DFLT)=1:"ARCH Eligibility Date",$G(DFLT)=0:"All",1:"All")
 S DIR(0)="S^D:ARCH Eligibility Date;A:All",DIR("A")="Select a beginning ARCH Eligibility (D)ate or (A)ll",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="D":1,Y="A":0,1:Y)
 I Y'=1 Q Y
 ;
 S VAL="",DIR(0)="DA^:DT:EX",DIR("A")="Beginning ARCH Eligibility Date: ",DIR("B")="SEP 30, 2010"
 W ! D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^"
 ;
 I VAL="" D
 .S $P(VAL,U)=Y
 .S DIR(0)="DA^"_VAL_":DT:EX",DIR("A")="   Ending ARCH Eligibility Date: ",DIR("B")="T"
 .D ^DIR
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^" Q
 .;
 .;Define Entry
 .S $P(VAL,U,2)=Y
 ;
 Q VAL
 ;
SELELIG(DFLT) ; Select ARCH Eligibility Status
 ; Input Variable -> DFLT = 0 - NO patient is not ARCH eligible
 ;                          1 - YES patient is ARCH eligible
 ;                          2 - BOTH
 ;
 ; Return Value ->   0 - NO patient is not ARCH eligible
 ;                   1 - YES patient is ARCH eligible
 ;                   2 - BOTH
 ;                   ^ - EXIT
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=0:"NO",$G(DFLT)=1:"YES",1:"BOTH")
 S DIR(0)="S^Y:YES - Patient is ARCH Eligible;N:NO  - Patient is NOT ARCH Eligible;B:BOTH",DIR("A")="Which ARCH Eligibility Status should display (Y/N/B)",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="N":0,Y="Y":1,Y="B":2,1:Y)
 Q Y
 ;
SELELDET(DFLT) ; Select ARCH Eligibility Determination
 ; Input Variable -> DFLT = 0 - CAC
 ;                          1 - SAS DB Update
 ;                          2 - All
 ;
 ; Return Value ->   New Person File IEN of CAC
 ;                   -1 - SAS DB Update
 ;                   0 - All
 ;                   ^ - EXIT
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=0:"U",$G(DFLT)=1:"N",1:"A")
 S DIR(0)="S^C:Project ARCH CAC;S:SAS DB Update;A:All",DIR("A")="Select ARCH Elig Determination (C)AC, (S)AS DB update or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="C":1,Y="S":0,Y="A":-1,1:Y)
 I Y=1 D
 . N DIR,DIRUT,DTOUT,DUOUT
 . ;Prompt to select NEW PERSON file entry. Screen on ELIGIBILITY SOURCE
 . S DIR(0)="P^200:EMZ",DIR("S")="I $D(^FBAAA(""ARCHSRC"",Y))"
 . S DIR("A")="Select Project ARCH CAC"
 . D ^DIR I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 . S Y=+Y
 Q Y
 ;
SELJUST() ; Select the ARCH Justification Reason
 ; Return Value ->   FEE BASIS PROJECT ARCH JUSTIFICATION file #161.35 IEN
 ;
 N FBJUST,IEN,X,CNT,FBJAR,DIR,DTOUT,DUOUT,Y
 S (FBJUST,X,CNT)=0
 W !!,"     Project ARCH Justification Reasons",!
 F  S FBJUST=$O(^FBAA(161.35,"C",FBJUST)) Q:FBJUST=""  D
 . S IEN=$O(^FBAA(161.35,"C",FBJUST,0))
 . Q:$P(^FBAA(161.35,IEN,0),U,2)'=1
 . S CNT=CNT+1
 . S FBJAR(CNT)=FBJUST_U_IEN
 F  S X=$O(FBJAR(X)) Q:X=""  D
 . W !,?5,X
 . I $L($P(FBJAR(X),U))>69 D
 . . ; Handle the line breaks and hyphenate the word in the right spot
 . . I $E($P(FBJAR(X),U),70)'=" " D  Q
 . . . W ?10,$E($P(FBJAR(X),U),1,69),"-"
 . . . W !,?10,$E($P(FBJAR(X),U),70,$L($P(FBJAR(X),U)))
 . . W ?10,$E($P(FBJAR(X),U),1,70)
 . . W !,?10,$E($P(FBJAR(X),U),71,$L($P(FBJAR(X),U)))
 W !
 S DIR(0)="N^1:"_CNT,DIR("A")="Select ARCH Justification" D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q Y
 W "  ",$P(FBJAR(Y),U),!
 Q $P(FBJAR(Y),U,2)
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
 ;Display the message about capturing to an Excel file format
 ; 
EXMSG ;
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
 ;
 ;Screen Pause 1
 ;
 ; Return variable - FBQ = 0 Continue
 ;                          2 Quit
PAUSE N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" FBQ=2
 U IO
 Q
 ;
 ;Screen Pause 2
 ;
 ; Return variable - FBQ = 0 Continue
 ;                         2 Quit
PAUSE2 N X
 U IO(0) W !!,"Press RETURN to continue:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" FBQ=2
 U IO
 Q
 ;
CHKKEY(KEY) ; Check if user holds the appropriate security key
 ; Return 1 if user holds key, 0 if not and display message
 Q:KEY']"" 0
 I $D(^XUSEC(KEY,DUZ)) Q 1
 W !,"You must hold the "_KEY_" Security Key in order to continue."
 D PAUSE2
 Q 0
 ;
REPORT(REF,FBEXCEL,FBSCR,FBRPTNAM,FBPAT,FBBEGDT,FBENDDT,FBELIG,FBELDET,FBSUMDET,FBPAGE) ; Display the report
 N DFN,ELIGDT,DETUSR,FB11,ELIGIND,FBARCH0,FBCNT
 N NP,FBLOCNT,FBNCNT,FBNELCNT,FBNPAT,FBELPAT
 S (FBLOCNT,FBNCNT,FBNELCNT,FBCNT)=0
 D HDR(FBRPTNAM,.FBPAGE)
 I '$D(@REF) W !,"No data meets the criteria." G XREPORT
 ;
 S DFN="" F  S DFN=$O(@REF@(DFN)) Q:DFN=""  D  Q:FBQ
 . Q:'$D(^DPT(DFN))
 . ; Check the patient filter
 . I FBPAT Q:DFN'=FBPAT
 . S FBNPAT=1
 . S ELIGDT="" F  S ELIGDT=$O(@REF@(DFN,ELIGDT)) Q:ELIGDT=""  D  Q:FBQ
 . . ; Check the date filters
 . . I FBBEGDT,ELIGDT<FBBEGDT Q
 . . S FB11="" F  S FB11=$O(@REF@(DFN,ELIGDT,FB11)) Q:FB11=""  D  Q:FBQ
 . . . S FBARCH0=^FBAAA(DFN,"ARCHFEE",FB11,0)
 . . . S ELIGIND=$P(FBARCH0,U,2)
 . . . S DETUSR=$S($P(FBARCH0,U,3)]"":$P(^VA(200,$P(FBARCH0,U,3),0),U),1:"SAS DB UPDATE")
 . . . ; Check the Eligibility filter
 . . . I FBELIG'=2,FBELIG'=ELIGIND Q
 . . . ; Check Determination Source filter
 . . . I FBELDET>0,FBELDET'=$P(FBARCH0,U,3) Q
 . . . I FBELDET=0,$P(FBARCH0,U,3)]"" Q
 . . . ; Set eligibility counter
 . . . S FBELPAT(DFN)=$S((ELIGIND)&($P(FBARCH0,U,3)]""):1,(ELIGIND)&($P(FBARCH0,U,3)=""):2,1:0)
 . . . I FBNPAT S FBCNT=FBCNT+1
 . . . S NP=$$CHKP(1) Q:FBQ
 . . . I 'FBSUMDET D
 . . . . D WRLINE1(FBEXCEL,$S(FBNPAT:FBCNT,1:""),$P(^DPT(DFN,0),U),ELIGDT,ELIGIND,DETUSR)
 . . . . I $P(FBARCH0,U,4)]"" D WRLINE2(FBEXCEL,$P(FBARCH0,U,4))
 . . . . I $P(FBARCH0,U,5)]"" D WRLINE3(FBEXCEL,$P(FBARCH0,U,5))
 . . . ; Reset FBNPAT to not print the ID if same patient
 . . . S FBNPAT=0
 Q:FBQ
 ; Get the total eligible patients
 N DFN S DFN="" F  S DFN=$O(FBELPAT(DFN)) Q:DFN=""  D
 . ; Get locally defined eligible patients
 . I FBELPAT(DFN)=1 S FBLOCNT=FBLOCNT+1 Q
 . ; Get nationally defined eligible patients
 . I FBELPAT(DFN)=2 S FBNCNT=FBNCNT+1 Q
 . ; Get locally defined patients changed to Not Eligible
 . S FBNELCNT=FBNELCNT+1
 W !
 I (FBELIG=1)!(FBELIG=2) W !,"Total Nationally Determined Project ARCH Eligible Patients:  "_FBNCNT
 I (FBELIG=1)!(FBELIG=2) W !,"Total Locally Determined Project ARCH Eligible Patients:  "_FBLOCNT
 I (FBELIG=0)!(FBELIG=2) W !,"Total Locally Determined Eligible changed to Not Eligible:  "_FBNELCNT
 Q
 ;
WRLINE1(FBEXCEL,ID,PATIENT,ELIGDT,ELIGIND,DETERM) ; Write Line 1 of report
 I FBEXCEL W !,ID_U_PATIENT_U_$$FMTE^XLFDT(ELIGDT)_U_$S(ELIGIND=1:"YES",1:"NO")_U_DETERM Q
 ;
 W !,ID,?8,PATIENT,?35,$$FMTE^XLFDT(ELIGDT),?51,$S(ELIGIND=1:"YES",1:"NO"),?64,DETERM
 Q
 ;
WRLINE2(FBEXCEL,FBJUST) ; Write Line 2 of report
 I FBEXCEL W U_$P(^FBAA(161.35,FBJUST,0),U) Q
 ;
 W !,?10,$P(^FBAA(161.35,FBJUST,0),U)
 Q
 ;
WRLINE3(FBEXCEL,FBMILE) ; Write Line 3 of report
 I FBEXCEL W U_FBMILE Q
 ;
 W !,?12,FBMILE
 Q
 ;
 ;Check for End of Page
 ; Input variables -> FBLINES -> Number of lines from bottom
 ;                    FBEXCEL -> 1 - Print to Excel/0 Regular Display
 ; Output variable -> FBDATA  -> 0 -> New screen, no data displayed yet
 ;                               1 -> Data displayed on current screen
CHKP(FBLINES) Q:$G(FBEXCEL) 0
 S FBLINES=FBLINES+1
 I $G(FBSCR) S FBLINES=FBLINES+2
 I $G(FBSCR),'$G(FBDATA) S FBDATA=1 Q 0
 S FBDATA=1
 I $Y>(IOSL-FBLINES) D:$G(FBSCR) PAUSE Q:$G(FBQ) 0 D HDR(FBRPTNAM,.FBPAGE) Q 1
 Q 0
 ;
 ;Print one line of characters
ULINE(X) N I
 W ! F I=1:1:80 W $G(X,"-")
 Q
 ;
HDR(FBRPTNAM,FBPAGE) ;
 ;Display Excel Header
 I FBEXCEL D EXHDR Q
 ;
 ; Define FBDATA - Tells whether data has been displayed for a screen
 S FBDATA=0
 S FBPAGE=$G(FBPAGE)+1
 W @IOF
 W FBRPTNAM_" ("_$S(FBSUMDET=1:"SUMMARY",1:"DETAIL")_" REPORT)"
 W $$RJ("Page: "_FBPAGE,30)
 W !,"Print Date: "_$G(FBNOW)
 I +FBBEGDT W !,"Report Date From "_$$DATTIM(FBBEGDT)_" through "_$$DATTIM($P(FBENDDT,"."))
 ;
 ;
 D ULINE("-") Q:$G(FBQ)
 ; If just printing Summary, no need to print other headers
 I FBSUMDET Q
 D HEADLN1
 D HEADLN2
 D HEADLN3
 D ULINE("-")
 ;
 Q
 ;
EXHDR ; Write the Excel Report Header
 W !,"ID#"_U
 W "PATIENT"_U
 W "ELIG DATE"_U
 W "ELIGIBLE"_U
 W "DETERMINATION"_U
 W "LOCAL JUSTIFICATION"_U
 W "LOCAL VERIFICATION OF MILEAGE"_U
 Q
 ;
DATTIM(X) ;Convert FM date or date.time to displayable (mm/dd/yy HH:MM) format
 N DATE,FBT,FBM,FBH,FBAP
 S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 S FBT=$P(X,".",2) S:$L(FBT)<4 FBT=FBT_$E("0000",1,4-$L(FBT))
 S FBH=$E(FBT,1,2),FBM=$E(FBT,3,4)
 S FBAP="AM" I FBH>12 S FBH=FBH-12,FBAP="PM" S:$L(FBH)<2 FBH="0"_FBH
 I FBT S:'FBH FBH=12 S DATE=DATE_" "_FBH_":"_FBM_FBAP
 Q $G(DATE)
 ;
HEADLN1 ; Write the first header line
 W !,"ID#",?8,"Patient",?35,"Elig Date",?51,"Eligible",?64,"Determination"
 Q
 ;
HEADLN2 ; Write the second header line
 W !,?10,"Local Project ARCH Justification"
 Q
 ;
HEADLN3 ; Write the third header line
 W !,?12,"Local Verification of Mileage"
 Q
 ;
XREPORT Q
 ;
 ;left justified, blank padded
 ;adds spaces on right or truncates to make return string FBLEN characters long
 ;FBST- original string
 ;FBLEN - desired length
LJ(FBST,FBLEN) ;
 N FBL
 S FBL=FBLEN-$L(FBST)
 Q $E(FBST_$J("",$S(FBL<0:0,1:FBL)),1,FBLEN)
 ;
 ;right justified, blank padded
 ;adds spaces on left or truncates to make return string FBLEN characters long
 ;FBST- original string
 ;FBLEN - desired length
RJ(FBST,FBLEN)  ;
 S FBL=FBLEN-$L(FBST)
 I FBL>0 Q $J("",$S(FBL<0:0,1:FBL))_FBST
 Q $E(FBST,1,FBLEN)
