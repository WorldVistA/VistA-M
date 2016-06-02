IBCNERPB ;DAOU/RO -  eIV PAYER LINK REPORT ;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,271,416,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input parameters: N/A
 ; Other relevant variables ZTSAVED for queueing:
 ;  IBCNERTN = "IBCNERPB" (current routine name for queueing the
 ;   COMPILE process)
 ; ********
 ;  IBCNESPC("REP")=1 for Payer List report, 2 for Company List
 ;  IBCNESPC("PTYPE")=Payer type (1-no active ins linked, 2-at least 1 ins linked, 3-All Payers)
 ;  IBCNESPC("PSORT")=Primary Sort for Payer report
 ;  IBCNESPC("PPYR")=single Payer name or '' for all
 ;  IBCNESPC("PDET")=Ins detail on payer report (1-include list of ins,2-do not list)
 ;
 ;  IBCNESPC("ITYPE")=Ins Company type (1-no payer link, 2-linked to payer, 3-All ins companies)
 ;  IBCNESPC("ISORT")=Primary Sort for Payer Insurance report
 ;  IBCNESPC("IMAT")=Partial matching Ins carriers
 ; Only call this routine at a tag
 Q
 ;
EN ; Main entry pt
 ; Init vars
 N STOP,IBCNERTN,POP,IBCNESPC,IBOUT
 ;
 S STOP=0
 S IBCNERTN="IBCNERPB"
 W @IOF
 W !,"eIV Payer Link Report",!
 W !,"In order for an Insurance Company to be eligible for electronic insurance"
 W !,"eligibility communications via the eIV software, the Insurance Company"
 W !,"needs to be linked to an appropriate payer from the National EDI Payer list."
 W !,"The National EDI Payer list contains the names of the payers that are"
 W !,"currently participating with the eIV process."
 W !!,"This report option provides information to assist with finding unlinked"
 W !,"insurance companies or payers, which can subsequently be linked through the"
 W !,"INSURANCE COMPANY EDIT option."
 ;
 ; Report type
R05 D RTYPE I STOP G:$$STOP EXIT G R05
 S IBCNESPC("PPYR")=""
 ; If rpt by ins company, go to questions
 I $G(IBCNESPC("REP"))=2 G R120
 ; Payer type params
R20 D PAYER I STOP G:$$STOP EXIT G R05
 I IBCNESPC("PPYR")'="" S IBCNESPC("PTYPE")=3 G R30
 ; Payer details
R25 D PTYPE I STOP G:$$STOP EXIT G R20
 S IBCNESPC("PDET")=2 I IBCNESPC("PTYPE")=1 G R40
 ; insurance company details
R30 D PDET I STOP G:$$STOP EXIT G R25
 I IBCNESPC("PPYR")'="" S IBCNESPC("ISORT")=1 G R100
 ; Type of data to return param
R40 D PSORT I STOP G:$$STOP EXIT G R20
 G R100
 ; Payer type params
R120 D ITYPE^IBCNERPC I STOP G:$$STOP EXIT G R05
 ; Partial Ins Name to include
R130 D IMAT^IBCNERPC I STOP G:$$STOP EXIT G R120
 I IBCNESPC("ITYPE")=1 S IBCNESPC("ISORT")=1 G R100
 ; Type of data to return param
R140 D ISORT^IBCNERPC I STOP G:$$STOP EXIT G R130
 ; Select output device
R100 ; Issue output width warning if not queued
 S IBOUT=$$OUT^IBCNERPC I STOP G:$$STOP EXIT G R05
 I IBCNERTN="IBCNERPB",'$D(ZTQUEUED),IBOUT="R" W !!!,"*** This report is 132 characters wide ***",!
 D DEVICE(IBCNERTN,.IBCNESPC) I STOP G:$$STOP EXIT G R05
 G EXIT
 ;
EXIT ; Exit pt
 Q
 ;
 ;
COMPILE(IBCNERTN,IBCNESPC) ;
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;
 ; Init scratch globals
 K ^TMP($J,IBCNERTN)
 ; Compile
 I IBCNERTN="IBCNERPB" D EN^IBCNERPC(IBCNERTN,.IBCNESPC)
 ; Print
 I '$G(ZTSTOP) D
 . I IBCNERTN="IBCNERPB" D EN3^IBCNERPD(IBCNERTN,.IBCNESPC)
 ; Close device
 D ^%ZISC
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN)
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
COMPILX ; COMPILE exit pt
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
RTYPE ; Prompt to allow users to select main report option
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Payer List;2:Insurance Company List"
 S DIR("A")="Select a report option"
 S DIR("B")=1
 S DIR("?",1)="  1 - Payer List:   This option lists the payers in the National"
 S DIR("?",2)="                    Payer list, and optionally provides information about"
 S DIR("?",3)="                    the insurance companies that are linked to that payer"
 S DIR("?",4)="  2 - Insurance"
 S DIR("?",5)="      Company List: This option lists insurance companies and"
 S DIR("?")="                    optionally displays linked payer information"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G RTYPEX
 S IBCNESPC("REP")=Y
 ;
RTYPEX ; RTYPE exit pt
 Q
 ;
PTYPE ; Prompt to select Payer Type to include
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Unlinked Payers;2:Linked Payers;3:ALL Payers"
 S DIR("A")="Select the type of payers to display"
 S DIR("B")="3"
 S DIR("?",1)="  1 - Only payers with no active insurance companies linked"
 S DIR("?",2)="  2 - Only payers with at least one insurance company linked"
 S DIR("?")="  3 - ALL Payers"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G PTYPEX
 S IBCNESPC("PTYPE")=Y
 ;
PTYPEX ; TYPE exit pt
 Q
PAYER ; Select Payer - File #365.12
 ; Init vars
 NEW DIC,DTOUT,DUOUT,X,Y
 ;
 W !!!
 S DIC(0)="ABEQ"
 S DIC("A")=$$FO^IBCNEUT1("Select a Payer (RETURN for ALL Payers): ",40,"L")
 ; Do not allow '~NO PAYER' or non-eIV payers
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER""),$$PYRAPP^IBCNEUT5(""IIV"",$G(Y))'="""""
 S DIC="^IBE(365.12,"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S Y="" S STOP=1 G PAYERX
 I Y=-1 S Y=""
 S IBCNESPC("PPYR")=Y
PAYERX ; Prompt for ending Payer value
 Q
PDET ; Prompt to select to display Insurance Company details to include
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:List linked insurance company detail;2:Do not list linked insurance company detail"
 S DIR("A")="Select insurance company detail option"
 S DIR("B")="1"
 S DIR("?",1)="  1 - Include a list of insurance companies linked to the payers"
 S DIR("?")="  2 - Do not list linked insurance companies, total number only"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G PDETEX
 S IBCNESPC("PDET")=Y
 ;
PDETEX ; TYPE exit pt
 Q
 ;
PSORT ; Prompt to allow users to select primary sort
 ; Init vars
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Payer Name;2:VA National Payer ID;3:Nationally Enabled Status;4:Locally Enabled Status;5:# of Linked Insurance Companies"
 S DIR("A")="Select the primary sort field"
 S DIR("B")=1
 S DIR("?")="  Select a data field by which this report should be primarily sorted."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G PSORTX
 S IBCNESPC("PSORT")=Y
 ;
PSORTX ; SORT exit pt
 Q
 ;
DEVICE(IBCNERTN,IBCNESPC) ; Device Handler and possible TaskManager calls
 ;
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;  IBOUT    = "R" for Report format or "E" for Excel format
 ;
 ; Init vars
 N ZTRTN,ZTDESC,ZTSAVE,POP
 ;
 S ZTRTN="COMPILE^IBCNERPB("""_IBCNERTN_""",.IBCNESPC)"
 S ZTDESC="IBCNE eIV Payer Link Report"
 S ZTSAVE("IBCNESPC(")=""
 S ZTSAVE("IBCNERTN")=""
 S ZTSAVE("IBOUT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
 ;
DEVICEX ; DEVICE exit pt
 Q
