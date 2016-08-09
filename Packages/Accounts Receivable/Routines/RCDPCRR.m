RCDPCRR ;ALB/TJB - CARC/RARC DATA TABLE REPORT ;11/03/14 1:00pm
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; PRCA*4.5*303 - CARC/RARC DATA Table report 
 ;
 ; DESCRIPTION : The following generates a report that displays selected or all
 ;               CARC or RARC Codes from the Files 345 (CARC) or 346 (RARC).
 ;               several filters may be used to limit the codes displayed:
 ;                 * CARCs only, RARCs only or Both - default is both.
 ;                 * Display Active, Inactive or Both - default is active
 ;                 * Report Date - default today
 ;                 * Output to excel (Yes/No)  -  default is no
 ;
 ; INPUTS      : The user is prompted for the following:
 ;                  CARC/RARC/Both Codes
 ;                  Prompt for codes to display 
 ;                  Active/Inactive
 ;                  Report Date
 ;                  Output report to Excel
 ;
EN ; Entry point for Report
 N DUOUT,DTOUT,DIR,X,Y,Z,I,JJ,KK,DL,CD,EXLN,IX,RCDT1,RCDET,ZTRTN,ZTSK,ZTDESC,ZTSAVE,ZTSTOP,%ZIS,POP
 N RCJOB,RCCD,RCRD,RCNOW,RCODE,RCSTAT,RCPG,RCHR,RCDISP,IDX,TY,FILE,IEN,ZN,RCQUIT,XCNT
 S RCQUIT=0
 ;
 ; Quick Search
 G:$G(QS)'=1 R1 ; Go to regular report
 ;
 D GCD(.RCCD,.RCDET)
 I $G(RCCD)="EXIT" G ARCQ
 S RCDISP=0,RCSTAT="B",RCDT1=$$DT^XLFDT K ^TMP("RC_CARC_RARC_TABLE",$J)
 D GETCODES($G(RCCD("CARC")),$G(RCCD("RARC")),RCSTAT,RCDT1,$NA(^TMP("RC_CARC_RARC_TABLE",$J)))
 S RCODE="CARC^RARC",RCNOW=$$NOW^RCDPRU(),RCPG=0,$P(RCHR,"=",IOM)=""   ;,IOSL=40
 G REPORT
 ;
R1 ;
 S RCODE=""
 S DIR("A")="Select (N)o CARCs or (A)ll CARCs?: ",DIR(0)="SA^N:No CARCs to Include;A:All CARCs Included"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDET=$$UP(Y)
 I RCDET="A" S RCCD("CARC")="ALL",RCODE="CARC"
 ;
 S DIR("A")="Select (N)o RARCs or (A)ll RARCs?: ",DIR(0)="SA^N:No RARCs to Include;A:All RARCs Included"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDET=$$UP(Y)
 I RCDET="A" S RCRD("RARC")="ALL",RCODE=$S(RCODE'="":RCODE_"^RARC",1:"RARC")
 ; 
 I RCODE']"" W !!,"Error: No Codes selected for display...",!,"Please select either CARC and/or RARC to include on report",! G R1
 ;
 S DIR("A")="Include (A)ctive codes, (I)nactive codes or (B)oth?: ",DIR(0)="SA^A:ACTIVE Codes;I:INACTIVE Codes;B:BOTH ACTIVE/INACTIVE Codes"
 S DIR("?")="Active/Inactive will be based on the date selected."
 S DIR("?",1)="Please indicate Active/Inactive/Both for codes included on the report."
 S DIR("?",2)="Active and Inactive codes will be determined by the date of the report."
 S DIR("B")="ACTIVE" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCSTAT=$$UP(Y)
 ;
DT1 ; Check the date 
 S DIR("?")="Enter Date for the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("B")="T",DIR("A")="Report Date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDT1=Y
 I RCDT1<2950102 W !,"Invalid date entered, no records for report.",!,"Please select a date after 1/1/1995.",! G DT1
 ;
 W !
 ; Send output to excel. (Removed excel output because description would be truncated)
 S RCDISP=0
 ;S RCDISP=$$DISPTY^RCDPRU()
 ;D:RCDISP INFO^RCDPRU
 ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENQ^RCDPCRR",ZTDESC="AR - CARC & RARC DATA REPORT",ZTSAVE("*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENQ ; Return here for queued print
 S RCNOW=$$NOW^RCDPRU(),RCPG=0,$P(RCHR,"=",IOM)=""
 ;
 K ^TMP("RC_CARC_RARC_TABLE",$J)
 D GETCODES($G(RCCD("CARC")),$G(RCRD("RARC")),RCSTAT,RCDT1,$NA(^TMP("RC_CARC_RARC_TABLE",$J)))
 ;
REPORT ;
 ; Report
 I RCDISP=0 D
 . S RCPG=1 W @IOF
 . I $G(QS)=1 D HDRP("EDI LOCKBOX CARC/RARC QUICK SEARCH",1,"Page: "_RCPG)
 . E  D HDRP("EDI LOCKBOX CARC/RARC TABLE DATA REPORT",1,"Page: "_RCPG)
 . D HDRP("REPORT RUN DATE: "_RCNOW,1)
 . D:+$G(QS)'=1 HDRP($$HDR2(RCSTAT,RCDET,RCDT1),1) W !!
 . W $$HDR3(),!
 . W RCHR,! S RCSL=8
 E  W "CODE^START^STOP^MODIFIED^VDATE^TYPE^DESCRIPTION^NOTES",!
 S IDX=RCODE
 F JJ=1:1 S TY=$P(IDX,U,JJ),CD="" Q:TY=""!RCQUIT  S FILE=$S(TY="RARC":346,1:345) F  S CD=$O(^TMP("RC_CARC_RARC_TABLE",$J,TY,CD)) Q:CD=""!RCQUIT  D
 . S IEN="",IEN=$O(^TMP("RC_CARC_RARC_TABLE",$J,TY,CD,IEN)),ZN=$G(^TMP("RC_CARC_RARC_TABLE",$J,TY,CD,IEN))
 . K RCDAT,RCERR
 . D GETS^DIQ(FILE,IEN_",","4;5","","RCDAT","RCERR") ; Get Description (4) and Notes (5) fields
 . I RCDISP D  ; Output Excel
 .. S EXLN=$P(ZN,U,1)_U_$$DATE($P(ZN,U,2))
 .. S EXLN=EXLN_U_$S($P(ZN,U,3)="":"",1:$$DATE($P(ZN,U,3)))_U_$S($P(ZN,U,4)="":"",1:$$DATE($P(ZN,U,4)))_U_$S($P(ZN,U,5)="":"",1:$$DATE($P($P(ZN,U,5),".",1)))_U_TY
 .. ; Collect Discription into a single variable for output
 .. S KK="",DL=""
 .. F  S KK=$O(RCDAT(FILE,IEN_",",4,KK)) Q:KK=""  S DL=DL_$G(RCDAT(FILE,IEN_",",4,KK))
 .. S EXLN=EXLN_U_DL
 .. ;Add notes
 .. S EXLN=EXLN_U_$G(RCDAT(FILE,IEN_",",5))
 .. W EXLN,!
 . E  D  ; Output to the screen
 .. W ?(4-$L($P(ZN,U,1))),$P(ZN,U,1),?8,$$DATE($P(ZN,U,2))
 .. W:$P(ZN,U,3)'="" ?21,$$DATE($P(ZN,U,3)) W:$P(ZN,U,4)'="" ?35,$$DATE($P(ZN,U,4)) W ?51,TY W:$P(ZN,U,5)'="" ?64,$$DATE($P($P(ZN,U,5),".",1)) W ! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL) G:RCQUIT ARCQ
 .. ;Accumulate the Word Processing Description Field
 .. S IX="",XCNT=0 K ^UTILITY($J,"W")
 .. F  S IX=$O(RCDAT(FILE,IEN_",",4,IX)) Q:IX=""  S X=RCDAT(FILE,IEN_",",4,IX),DIWL=6,DIWR=IOM,DIWF="W" D ^DIWP S RCSL=RCSL+1 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL) G:RCQUIT ARCQ
 .. D ^DIWW S RCSL=RCSL+1
 .. I RCSL>=(IOSL-3) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL) G:RCQUIT ARCQ
 .. ;Print the Notes Field
 .. I $G(RCDAT(FILE,IEN_",",5))'="" K ^UTILITY($J,"W") S X="NOTES: "_RCDAT(FILE,IEN_",",5),DIWL=6,DIWR=IOM,DIWF="" D ^DIWP,^DIWW S RCSL=RCSL+1
 .. W ! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-3) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL) G:RCQUIT ARCQ
 ;
 D:'RCQUIT ASK^RCDPRU(.RCSTOP)
ARCQ ; Clean up and quit
 K DHDR,RCEXCEL,RCLIST,RCODE,DIWL,DIWR,DIWF,IX,DATA,ERROR,QS
 K ^TMP("RC_CARC_RARC_TABLE",$J)
 Q
 ;
GETCODES(CARC,RARC,STAT,RDT,ARRAY,DESC) ;
 ; CARC = CARC data to retrieve
 ; RARC = RARC data to retrieve
 ;      CARC and RARC can be a single code, a list of codes, range or combination.
 ; STAT = Retrieve Active, Inactive or Both codes
 ; RDT = Report date (used to determine Active/Inactive status)
 ; ARRAY = Stuff the data into ARRAY passed for as a string for indirection
 ; DESC (optional) = Add description to ARRAY, second ^ is length, if
 ;      undefined or less than 10 characters description
 ;      length will be 10 characters, maximum is 250 characters
 I $G(DESC)="" S DESC=0
 I CARC]"" D ELEM("CARC",345,CARC,STAT,RDT,.ARRAY,DESC)
 I RARC]"" D ELEM("RARC",346,RARC,STAT,RDT,.ARRAY,DESC)
 Q
 ;
ELEM(TYPE,FILE,DAT,STAT,RDT,ARRAY,DESC) ;
 N I,OKAY,R1,R2,RX,RY,RZ,O1,ELEM,DATA,START,STOP,DL,RCZT S DL=""
 I $G(DESC)'=0 S DL=$P(DESC,U,2) S:+$G(DL)<10 DL=10 S:$G(DL)>250 DL=250
 I DAT="ALL" S R1=$O(^RC(FILE,"B","")),R2=$O(^RC(FILE,"B",""),-1),DAT=R1_":"_R2
 F I=1:1 S ELEM=$P(DAT,",",I) Q:ELEM=""  D
 . I ELEM[":" D  ; Range
 .. S R1=$P(ELEM,":",1),R2=$P(ELEM,":",2),RX=$O(^RC(FILE,"B",R1),-1)
 .. F  S RX=$O(^RC(FILE,"B",RX)) Q:(RX]]R2)!(RX="")  D
 ... S O1=$O(^RC(FILE,"B",RX,"")),DATA=^RC(FILE,O1,0),START=$P(DATA,U,2),STOP=$P(DATA,U,3)
 ... D:DL'=""
 .... ; Get description if wanted
 .... K RCZT S RY=$$GET1^DIQ(FILE,O1_",",4,"","RCZT"),RY="",RZ="" F  S RZ=$O(RCZT(RZ)) Q:RZ=""  S RY=RY_RCZT(RZ)_" "
 .... S RY=$E(RY,1,DL)
 ... ;S OKAY=$S(STAT="B":1,STAT="I":$S(STOP="":0,STOP<=RDT:1,1:0),STAT="A":$S(STOP="":1,STOP>RDT:1,STOP<=RDT:0,1:0))
 ... S OKAY=$$STAT(STAT,RDT,STOP,START)
 ... S:OKAY @ARRAY@(TYPE,RX,O1)=DATA S:OKAY&(DL'="") @ARRAY@(TYPE,RX,O1)=@ARRAY@(TYPE,RX,O1)_U_RY
 . E  D
 .. ;Add an individual code
 .. S O1=$O(^RC(FILE,"B",ELEM,"")),DATA=^RC(FILE,O1,0),START=$P(DATA,U,2),STOP=$P(DATA,U,3)
 .. D:DL'=""
 ... ; Get description if wanted
 ... K RCZT S RY=$$GET1^DIQ(FILE,O1_",",4,"","RCZT"),RY="",RZ="" F  S RZ=$O(RCZT(RZ)) Q:RZ=""  S RY=RY_RCZT(RZ)_" "
 ... S RY=$E(RY,1,DL)
 .. ;S OKAY=$S(STAT="B":1,STAT="I":$S(STOP="":0,STOP<=RDT:1,1:0),STAT="A":$S(STOP="":1,STOP>RDT:1,STOP<=RDT:0,1:0))
 .. S OKAY=$$STAT(STAT,RDT,STOP,START)
 .. S:OKAY @ARRAY@(TYPE,ELEM,O1)=DATA S:OKAY&(DL'="") @ARRAY@(TYPE,ELEM,O1)=@ARRAY@(TYPE,ELEM,O1)_U_RY
 Q
 ;
STAT(INC,ZDT,SP,ST) ; Determine if this code should be included in report
 ; INC = Active, Inactive, Both; ZDT = Date of report ; ST = Start date of code ; SP = Stop Date of code
 N RET S RET=0
 I $G(INC)="B" S:($G(ZDT)>$G(ST)) RET=1 Q RET  ; Both active and inactive and start date before report date
 I $G(INC)="I" S RET=0 D  Q RET  ; Inactive codes
 . I $G(SP)="" S RET=0 Q  ; No stop date can't be inactive
 . I ($G(ZDT)>$G(SP)),($G(ZDT)>$G(ST)) S RET=1 Q  ; Inactive, Stop before report and Start date before report date
 I $G(INC)="A" S RET=0 D  Q RET
 . I $G(ZDT)>$G(ST),($G(SP)="") S RET=1 Q  ; Active, Start date before report date and no stop date
 . I $G(ZDT)>$G(ST),($G(SP)>$G(ZDT)) S RET=1 Q  ; Active, Start date before report date and stop date after report date
 Q 0  ; Return do not include
 ;
GCARC(RET) ; Get CARC data elements for report
 N RCLIST,RCODE,DTOUT,DUOUT,FILE
 S FILE=345
 S DIR("A")="Select (C)ARC, (R)ange of CARCs or (A)ll ?: ",DIR(0)="SA^A:All CARCs;C:Single CARC;R:Range/List of CARCs"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 S RCLIST=Y
 I RCLIST="A" S RET("CARC")="ALL" Q
 I RCLIST="C" D  Q
 .; if invalid code return here
C1 .;
 . S DIR("A")="Enter a CARC code",DIR(0)="P^345;EABZ" ;F^1:200"
 . S DIR("?")="Only a single codes can be entered as: A1"
 . S DIR("?",1)="Please enter one CARC code for the report."
 . S DIR("?",2)="The single validated code will be included in the report."
 . S DIR("??")="^D LIST^RCDPCRR(345)"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 . S RCODE=$$UP(X)
 . I (RCODE[":"),(RCODE["-"),(RCODE[",") W !!,"Code: "_RCODE_" not found. Please try again...",! S X="",RCODE="" G C1
 . I '$$VAL(FILE,.RCODE) W !!,"Code: "_RCODE_" not found, Please reenter...",! S X="",RCODE="" G C1
 . S RET("CARC")=RCODE
 ;
 I RCLIST="R" D
  .; if invalid range/list of codes return here
C2 . ;
 . S DIR("A")="Enter a List or Range of CARCs",DIR(0)="F^1:200"
 . S DIR("?")="Codes can be entered as: 1,2,4:15,A1-B6"
 . S DIR("?",1)="Please enter a list or range of CARC Codes, use a comma between elements"
 . S DIR("?",2)="and a colon ':' or '-' to delimit ranges of codes."
 . S DIR("??")="^D LIST^RCDPCRR(345)"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 . S RCODE=$$UP(X) I '$$VAL(FILE,.RCODE) W !!,"Code: "_RCODE_" not found. Please try again...",! S X="",RCODE="" G C2
 . S RET("CARC")=RCODE
 Q
 ;
LIST(FILE) ; Used for "??" to list the CARC or RARC code and 60 characters of the description
 N I,C,QQ,Y,DTOUT,DUOUT,CNT,DIR,RC1,RCZ S CNT=0,C=IOSL-3,QQ=0
 S JJ=0 F I=1:1 S JJ=$O(^RC(FILE,JJ)) Q:(+JJ=0)!(QQ=1)  D
 . S RCZ=^RC(FILE,JJ,0),RC1=$P($G(^RC(FILE,JJ,1,1,0)),".")
 . S CNT=CNT+1 W !,$S($P(RCZ,U,3)&($P(RCZ,U,3)'>DT):"*",1:" ")_$J($P(RCZ,U),4),?7,$E(RC1,1,60)
 . I CNT#C=0 S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT)!(Y="")!(Y="^") S QQ=1 Q
 Q
GRARC(RET) ; Get RARC data elements for report
 N RCLIST,RCODE,DTOUT,DUOUT,FILE
 S FILE=346
 S DIR("A")="Select a (R)ARC, Ra(N)ge of RARCs or (A)ll?: ",DIR(0)="SA^A:All RARCs;R:Single RARC;N:Range/List of RARCs"
 S DIR("B")="All" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 S RCLIST=Y
 I RCLIST="A" S RET("RARC")="ALL" Q
 ;
 I RCLIST="R" D  Q
 . ; if invalid code return here
G1 . ;
 . S DIR("A")="Enter a RARC code",DIR(0)="F^1:200"
 . S DIR("?")="Only a single codes can be entered as: A1"
 . S DIR("?",1)="Please enter one RARC for the report."
 . S DIR("?",2)="The single validated code will be included in the report."
 . S DIR("??")="^D LIST^RCDPCRR(346)"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 . S RCODE=$$UP(X)
 . I (RCODE[":"),(RCODE["-"),(RCODE[",") W !!,"Code: "_RCODE_" not found. Please try again...",! S X="",RCODE="" G G1
 . I '$$VAL(FILE,.RCODE) W !!,"Code: "_RCODE_" not found, Please try again...",! S X="",RCODE="" G G1
 . S RET("RARC")=RCODE
 ;
 I RCLIST="N" D
 .; if invalid range of codes return here
G2 . ;
 . S DIR("A")="Enter a List or Range of RARC codes",DIR(0)="F^1:200"
 . S DIR("?")="Codes can be entered as: M1,M16:M20,M40-M45"
 . S DIR("?",1)="Please enter a list or range of RARC Codes, use a comma ',' between elements"
 . S DIR("?",2)="and a colon ':' or '-' to delimit ranges of codes."
 . S DIR("??")="^D LIST^RCDPCRR(346)"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 . S RCODE=$$UP(X)
 . I '$$VAL(FILE,.RCODE) W !!,"Code: "_RCODE_" not found, Please try again...",! S X="",RCODE="" G G2
 . S RET("RARC")=RCODE
 Q
 ;
GCD(RET,CS) ; Get CARC and/or RARC data elements for Quick Search report
 N RCLIST,RCODE,DTOUT,DUOUT,FILE,CK0,CK1,CD,EX
 S FILE(0)=345,FILE(1)=346
GC1 ;if invalid code return here
 S DIR("A")="Enter a CARC or RARC Code",DIR(0)="F^1:200"
 S DIR("?")="Enter codes as a single code or list of codes as: 1 or 1,M1"
 S DIR("?",1)="Please enter CARCs and/or RARCs for the report."
 S DIR("?",2)="The validated code(s) will be included in the report."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RET="EXIT",RCSTOP=1 Q
 S RCLIST=$$UP(X)
 I (RCLIST[":")!(RCLIST["-") W !!,"Code: "_RCLIST_" not found. Please try again...",! S X="",RCLIST="" G GC1
 ; Check each code
 S EX=0,CD="" K RET("CARC"),RET("RARC")
 F I=1:1 S CD=$P(RCLIST,",",I) Q:CD=""  D  I EX'=0 W !!,"Code: "_CD_" not found. Please try again...",! S X="",RCLIST="" G GC1
 . S CK0=$$VAL(FILE(0),.CD)
 . S CK1=$$VAL(FILE(1),.CD)
 . ; If both the CARC and RARC returns an invalid set the exit code and quit the checks 
 . I 'CK0,'CK1 S EX=1 Q  ; Abort if we don't have a valid code
 . ; Set the appropriate array either CARC or RARC.
 . S:CK0 RET("CARC")=$S($G(RET("CARC"))]"":$G(RET("CARC"))_","_CD,1:CD)
 . S:CK1 RET("RARC")=$S($G(RET("RARC"))]"":$G(RET("RARC"))_","_CD,1:CD)
 ; So are we processing just CARC, just RARC or both CARC and RARC
 S CS=$S(($G(RET("CARC"))]"")&($G(RET("CARC"))=""):"C",($G(RET("CARC"))="")&($G(RET("CARC"))]""):"R",1:"B")
 Q
 ;
DATE(X,F) ; date in external format See XLFDT1 for codes
 Q $$DATE^RCDPRU(X,$G(F))
 ;
HDR2(ST,RT,DT) ; Report header
 N LINE,REP
 S LINE=$S(ST="A":"ACTIVE",ST="I":"INACTIVE",1:"ACTIVE AND INACTIVE")
 S REP=$S(RT="C":"CARC",RT="R":"RARC",1:"CARC/RARC")
 S LINE=LINE_" "_REP_" DATA AS OF REPORT DATE: "_$$DATE(DT)
 Q LINE
 ;
HDR3() ; Fuction to return report column header lines, just used within this routine. 
 N LINE
 S LINE="CODE   START DATE   STOP DATE   DATE MODIFIED   CARC/RARC   LAST VISTA UPDATE"_$C(10,13)
 S LINE=LINE_"    CODE DESCRIPTION"
 Q LINE
 ;
HDRP(Z,X,Z1) ; Print Header (Z=String, X=1 (line feed) X=0 (no LF), Z1 (page number right justified)
 I X=1 W !
 W ?(IOM-$L(Z)\2),Z W:$G(Z1)]"" ?(IOM-$L(Z1)),Z1
 Q
NEWPG(RCPG,RCNEW,RCSL) ; Check for new page needed, output header
 ; RCPG = Page number passwd by referece
 ; RCNEW = 1 to force new page
 ; RCSL = page length passed by reference
 ; Function returns 1 if user chooses to stop output
 N RCSTOP S RCSTOP=0
 I RCNEW!'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK^RCDPRU(.RCSTOP) I RCSTOP Q
 . S RCPG=RCPG+1 W @IOF
 . I $G(QS)=1 D HDRP("EDI LOCKBOX CARC/RARC QUICK SEARCH",1,"Page: "_RCPG)
 . E  D HDRP("EDI LOCKBOX CARC/RARC TABLE DATA REPORT",1,"Page: "_RCPG)
 . D HDRP("REPORT RUN DATE: "_RCNOW,1)
 . D:+$G(QS)'=1 HDRP($$HDR2(RCSTAT,RCDET,RCDT1),1) W !!
 . W $$HDR3(),!
 . W RCHR,! S RCSL=7
 Q RCSTOP
 ;
VAL(XF,CODE) ; Validate a range or list of CARC (345), RARC (346) or PLB (345.1) Codes
 ; If invalid code is found VAILD = 0 and CODE will contain the offending codes
 Q $$VAL^RCDPRU(XF,.CODE)
 ;
UP(TEXT) ; Translate text to upper case
 Q $$UP^XLFSTR(TEXT)
 ;
