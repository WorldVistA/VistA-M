IBCNERPD ;DAOU/RO - INSURANCE COMPANY LINK REPORT ;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,416,521,528,595,602,687**;21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; IB*2.0*687 - split this report out from another report(rewriting it). We reused
 ; this routine that the old report no longer needs. Therefore, any changes based
 ; on the patches prior to IB*2.0*687 will no longer apply to this code. You will
 ; not find any references to them below.
 ;
 ; Input parameters: N/A
 ; Other relevant variables ZTSAVED for queueing:
 ;  IBCNERTN="IBCNERPD" (current routine name for queueing the COMPILE process)
 ;  IBCNESPD("ITYPE")=Ins Company type (1-Unlinked Insurance Companies, 2-Linked Insurance Companies)
 ;  IBCNESPD("IMAT")=Partial matching Ins carriers
 ;  IBCNESPD("IBOUT")=Output Format ('E'- Excel, 'R' - Report)
 ;  IBCNESPD("ISORT")=Primary Sort (1-Insurance Company Name, 2-Payer Name, 3-VA National Payer ID) 
 ;
 Q
 ;
EN ; Main entry pt
 ; Init vars
 N IBCNERTN
 S IBCNERTN="IBCNERPD"
 ;
 W @IOF
 ;IB*2*687/DTG - Add IIU to the report message display
 W !,"Insurance Company Link Report",!
 W !,"In order for an Insurance Company to be eligible for electronic insurance"
 W !,"eligibility communications via the eIV software or to transmit active"
 W !,"insurance to another VAMC via IIU, the Insurance Company needs to be"
 W !,"linked to an appropriate payer from the National EDI Payer list."
 W !,"The National EDI Payer list contains the names of the payers that are"
 W !,"currently participating with the eIV and/or IIU process."
 W !!,"This report option provides information to assist with finding unlinked"
 W !,"insurance companies or payers, which can subsequently be linked through the"
 W !,"INSURANCE COMPANY EDIT option."
 ;
R10 ; Prompt to select linked vs unlinked insurance companies report option
 N IBCNESPD,DEST,IBOUT,POP,STOP,ZTQUEUED,ZTREQ,ZTSTOP
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S STOP=0
 ;
 S DIR(0)="S^1:Unlinked insurance companies;2:Linked insurance companies"
 S DIR("A")="Select type of companies to display"
 S DIR("B")=""
 S DIR("?",1)="  1 - Only insurance companies that are not currently linked to a payer"
 S DIR("?")="  2 - Only insurance companies that are currently linked to a payer"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G EXIT
 S IBCNESPD("ITYPE")=Y
 I Y=1 S IBCNESPD("ISORT")=1   ; If Unlinked report the sort defaults to the primary sort and skip the sort prompt.
 ;
 W !!,"Text entered into the search keyword field will result in"
 W !,"the report selecting all insurance companies that contain"
 W !,"the entered text in the insurance company name."
 ;
R20 ; Prompt for Insurance Company Search 
 N DIR,X,Y,DIRUT
 W !
 S DIR(0)="FO"
 S DIR("A")="Enter an insurance company search keyword (RETURN for ALL)"
 S DIR("B")=""
 S DIR("?",1)="     Enter a keyword to search insurance company names that"
 S DIR("?",2)="     contain the keyword or simply hit RETURN to select ALL"
 S DIR("?",3)="     insurance companies. Examples of keyword: ('CIGNA' would"
 S DIR("?",4)="     return CIGNA, CIGNA HICN, NATIONAL CIGNA, REGION 1 CIGNA"
 S DIR("?")="     and any others with the term 'CIGNA' in it)"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S Y="" S STOP=1 G:$$STOP^IBCNERP1 EXIT G R10
 S IBCNESPD("IMAT")=Y
 ;
R30 ; Prompt to allow users to select output format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S IBCNESPD("ISORT")=$S(IBCNESPD("ITYPE")=1:1,1:"")
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1
 I STOP S IBCNESPD("ISORT")="" G:$$STOP^IBCNERP1 EXIT G R20
 S (IBOUT,IBCNESPD("IBOUT"))=Y
 ;
 ; If the report is in EXCEL format, set the sort to the primary sort and skip the Sort Prompt.
 I IBCNESPD("IBOUT")="E" S IBCNESPD("ISORT")=1
 ; If Unlinked Report or EXCEL format, this skips over SORT prompt.
 I IBCNESPD("ITYPE")=1!$G(IBCNESPD("ISORT"))=1 G R50
 ;
R40 ; Prompt to allow users to select primary sort
 N DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Insurance Company Name;2:Payer Name;3:VA National Payer ID"
 S DIR("A")="Select the primary sort field"
 S DIR("B")=1
 S DIR("?")="  Select the data field by which this report should be primarily sorted."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G:$$STOP^IBCNERP1 EXIT G R30
 S IBCNESPD("ISORT")=Y
 ;
R50 ; Proceed to compilation of the data and then generate the output of the report.
 I '$D(ZTQUEUED),IBOUT="R" D
 . W ! I IBCNESPD("ITYPE")=2 W !,"*** This report is 132 characters wide ***",!
 I IBOUT="E" W !!!,"*** To avoid wrapping, enter '0;256;999' at the 'DEVICE' prompt. ***",!
 D DEVICE(IBCNERTN,.IBCNESPD)
 I STOP D  G @DEST
 . I $$STOP^IBCNERP1 S DEST="EXIT" Q
 . I IBCNESPD("ITYPE")=1 S DEST="R30" Q
 . I IBCNESPD("IBOUT")="E" S DEST="R30" Q
 . S DEST="R40"
 ;
EXIT ; Exit pt
 Q
 ; 
DEVICE(IBCNERTN,IBCNESPD) ; Device Handler and possible TaskManager calls
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPD = Array passed by ref of the report params
 ;  IBOUT    = "R" for Report format or "E" for Excel format
 ;
 N POP,ZTDESC,ZTRTN,ZTSAVE
 ;
 S ZTRTN="COMPILE^IBCNERPD("""_IBCNERTN_""",.IBCNESPD)"
 S ZTDESC="IBCNE Insurance Company Link Report"
 S ZTSAVE("IBCNESPD(")=""
 S ZTSAVE("IBCNERTN")=""
 S ZTSAVE("IBOUT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
 Q
 ;
COMPILE(IBCNERTN,IBCNESPD) ;
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPD = Array passed by ref of the report params
 ;
 ; Init scratch globals
 K ^TMP($J,IBCNERTN)
 ; Compile Data
 D COMPDATA(IBCNERTN,.IBCNESPD)
 ; Print Data
 I '$G(ZTSTOP) D OUTPUT(IBCNERTN,.IBCNESPD)
 ; Close device
 D ^%ZISC
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN)
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q 
 ;
COMPDATA(IBCNERTN,IBCNESPD) ; Compile data
 N IBI,IBGRP,IBMAT,IBINAME,IBINS,IBPY,IBPYR,IBSORT,IBTYP
 N IBELOACT,IBENAACT,IBIADDR,IBICITY,IBIINST,IBINAACT,IBIPROF,IBISTATE,IBIZIP
 N APPEIV,APPIENS,APPIIU,IBPINST,IBPPROF,IBPVAID,IBPYARY,IBRPT,SORT1,SORT2,SORT3
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-",IBOUT="R" W !!,"Compiling report data ..."
 ;
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN)
 ;
 S IBTYP=$G(IBCNESPD("ITYPE"))
 S IBSORT=$G(IBCNESPD("ISORT"))
 S IBMAT=$G(IBCNESPD("IMAT"))
 S (SORT1,SORT2,SORT3)=""
 ;
 ; Loop thru the Insurance company file
 S IBINS=0
 F  S IBINS=$O(^DIC(36,IBINS)) Q:'IBINS  D  Q:$G(ZTSTOP)
 . I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 . S IBINAME=$$GET1^DIQ(36,IBINS,.01,"I")
 . I IBINAME="" Q
 . I IBMAT'="",'$F($$UP^XLFSTR(IBINAME),$$UP^XLFSTR(IBMAT)) Q  ; ICR #10104
 . ; Get active group count
 . S (IBI,IBGRP)=0 F  S IBI=$O(^IBA(355.3,"B",IBINS,IBI)) Q:'IBI  I '$$GET1^DIQ(355.3,IBI,.11,"I") S IBGRP=IBGRP+1
 . ;
 . S (IBENAACT,IBELOACT,IBINAACT,IBPPROF,IBPINST,IBPYR,IBPVAID)=""
 . ; Get PROF ID, INST ID and address from Insurance file
 . S IBIPROF=$$GET1^DIQ(36,IBINS,3.02,"I")  ;Ins co PROF ID
 . S IBIINST=$$GET1^DIQ(36,IBINS,3.04,"I")  ;Ins co INST ID
 . S IBIADDR=$$GET1^DIQ(36,IBINS,.111,"I"),IBIADDR=$E(IBIADDR,1,35)
 . S IBICITY=$$GET1^DIQ(36,IBINS,.114,"I"),IBICITY=$E(IBICITY,1,25)
 . S IBISTATE=$$GET1^DIQ(5,+$$GET1^DIQ(36,IBINS,.115,"I"),1)
 . S IBIZIP=$$GET1^DIQ(36,IBINS,.116,"I")
 . ; Get payer
 . S IBPY=$$GET1^DIQ(36,IBINS,3.10,"I")
 . ; If Unlinked Report and there is a Payer, quit.
 . I IBTYP=1,IBPY'="" Q
 . ; If Linked Report and there isn't a Payer, quit.
 . I IBTYP=2,IBPY="" Q
 . ; Linked Report, get data from the Payer File (#365.12)
 . I IBTYP=2 D
 . . S IBPYR=$$GET1^DIQ(365.12,IBPY,.01,"I")    ;Payer Name
 . . S IBPVAID=$$GET1^DIQ(365.12,IBPY,.02,"I")  ;VA National ID
 . . S IBPPROF=$$GET1^DIQ(365.12,IBPY,.05,"I")  ;PROF ID (eligibility)
 . . S IBPINST=$$GET1^DIQ(365.12,IBPY,.06,"I")  ;INST ID
 . . ; Get application info
 . . K IBPYARY
 . . D PAYER^IBCNINSU(IBPY,,"**","I",.IBPYARY)
 . . ; Payer EIV app
 . . S APPEIV=$$PYRAPP^IBCNEUT5("EIV",IBPY)
 . . I APPEIV'="" D
 . . . S APPIENS=""_APPEIV_","_IBPY_","_""
 . . . S IBENAACT=IBPYARY(365.121,APPIENS,.02,"I")
 . . . S IBENAACT=$S(IBENAACT=1:"YES",1:"NO")
 . . . S IBELOACT=IBPYARY(365.121,APPIENS,.03,"I")
 . . . S IBELOACT=$S(IBELOACT=1:"YES",1:"NO")
 . . ; Payer IIU app
 . . S APPIIU=$$PYRAPP^IBCNEUT5("IIU",IBPY)
 . . I APPIIU'="" D
 . . . S APPIENS=""_APPIIU_","_IBPY_","_""
 . . . S IBINAACT=IBPYARY(365.121,APPIENS,.02,"I")
 . . . S IBINAACT=$S(IBINAACT=1:"YES",1:"NO")
 . . ; Linked Report - SORT fields based upon the SORT that was chosen
 . . ;    IBSORT=1 equals the Primary Sort sequence:  IBINAME,IBPYR,IBPVAID
 . . ;    IBSORT=2 equals the Payer Sort sequence:    IBPYR,IBINAME,IBPVAID
 . . ;    IBSORT=3 equals the VA ID Sort sequence:    IBPVAID,IBINAME,IBPYR
 . . I IBSORT=1 S SORT1=IBINAME,SORT2=IBPYR,SORT3=IBPVAID
 . . I IBSORT=2 S SORT1=IBPYR,SORT2=IBINAME,SORT3=IBPVAID
 . . I IBSORT=3 S SORT1=IBPVAID,SORT2=IBINAME,SORT3=IBPYR
 . . I SORT1="" S SORT1=" "
 . I IBOUT="E" S SORT1=IBINAME,SORT2=IBPYR,SORT3=IBPVAID
 . ;
 . ; The Unlinked Report doesn't contain Payer info
 . I IBTYP=1 S (SORT1,SORT2,SORT3)=$S(IBINAME'="":IBINAME,1:" ")
 . ;
 . ; The Unlinked report only uses (IBGRP-IBIZIP). The REPORT format uses all fields
 . S IBRPT=IBINAME_U_IBGRP_U_IBIPROF_U_IBIINST_U_IBIADDR_U_IBICITY_U_IBISTATE_U_IBIZIP
 . S IBRPT=IBRPT_U_IBPYR_U_IBPVAID_U_IBENAACT_U_IBINAACT_U_IBELOACT_U_IBPPROF_U_IBPINST
 . S ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3,IBINS)=IBRPT
 Q
 ;
OUTPUT(IBCNERTN,IBCNESPD) ; Sets IO params for printing
 N IBMAT,IBPGC,IBPXT,IBSORT,IBTYP
 N CRT,DIR,DTOUT,DUOUT,LIN,MAXCNT,X,Y,ZZ
 ;
 S IBTYP=$G(IBCNESPD("ITYPE"))
 S IBSORT=$G(IBCNESPD("ISORT"))
 S IBMAT=$G(IBCNESPD("IMAT"))
 ;
 S (CRT,IBPGC,IBPXT,MAXCNT)=0  ;S (IBPXT,IBPGC)=0
 ;
 ; Determine IO params
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 D PRINT(IBCNERTN,IBTYP,IBSORT,.IBPGC,.IBPXT,MAXCNT,CRT,IBOUT)
 I $G(ZTSTOP)!IBPXT G OUTPUTX
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 I IBOUT="E",CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR ; End of Excel Report
OUTPUTX ; Exit pt
 Q
 ;
PRINT(RTN,IBTYP,SRT,PGC,PXT,MAX,CRT,IBOUT) ; Print data
 ; Input: RTN="IBCENRPB", PGC=page ct,
 ;   PXT=exit flg, MAX=max line ct/pg,
 ;  CRT=1/0, IBOUT="R"/"E"
 N CNT,DASH,EORMSG,NONEMSG,SORT1,SORT2,SORT3,SPACES
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S $P(DASH,"-",133)="",$P(SPACES," ",132)=""
 ;
 ;Excel header
 I IBOUT="E" D EHDR
 ;
 ; If No Data
 I '$D(^TMP($J,RTN)) D HEADER:(IBOUT="R") W !,?(80-$L(NONEMSG)\2),NONEMSG,!!
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,RTN,SORT1)) Q:SORT1=""  D  Q:PXT!$G(ZTSTOP)
 . S SORT2="" F  S SORT2=$O(^TMP($J,RTN,SORT1,SORT2)) Q:SORT2=""  D  Q:PXT!$G(ZTSTOP)
 . . S SORT3="" F  S SORT3=$O(^TMP($J,RTN,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:PXT!$G(ZTSTOP)
 . . . S CNT="" F  S CNT=$O(^TMP($J,RTN,SORT1,SORT2,SORT3,CNT)) Q:CNT=""  D  Q:PXT!$G(ZTSTOP)
 . . . . K DISPDATA  ; Init disp
 . . . . D DATA(.DISPDATA),LINE(.DISPDATA)
 ;
 I $G(ZTSTOP)!PXT G PRINTEX
 I IBOUT="R" D
 . I $Y+1>MAX!('PGC) D HEADER I $G(ZTSTOP)!PXT G PRINTEX
 W !,?(80-$L(EORMSG)\2),EORMSG
PRINTEX ;
 Q
 ;
DATA(DISPDATA) ;  Build display lines
 N ADDRESS,I,LCT,RPTDATA,ZIPCODE
 ; Merge into local variable
 M RPTDATA=^TMP($J,RTN,SORT1,SORT2,SORT3,CNT)
 ;
 ; Format Zip Codes, add a "-" after the first 5 digits and before the last 4 digits (99999-9999)
 S ZIPCODE=$E($P(RPTDATA,U,8),1,5)
 I $L($P(RPTDATA,U,8))>5 S ZIPCODE=$E($P(RPTDATA,U,8),1,5)_"-"_$E($P(RPTDATA,U,8),6,9)
 ;
 ; Excel format for Unlinked and Linked Reports
 I IBOUT="E" D  Q
 . S LCT=1,DISPDATA(1)=$P(RPTDATA,U)_U_$P(RPTDATA,U,5)_U_$P(RPTDATA,U,6)
 . S DISPDATA(1)=DISPDATA(1)_U_$P(RPTDATA,U,7)_U_ZIPCODE
 . S DISPDATA(1)=DISPDATA(1)_U_$P(RPTDATA,U,2)_U_$P(RPTDATA,U,3)_U_$P(RPTDATA,U,4)
 . I IBTYP=2 D
 . . F I=9:1:$L(RPTDATA,U) S DISPDATA(1)=DISPDATA(1)_U_$P(RPTDATA,U,I)
 ;
 ; Report format (Address(35), City(25), State(2) Zip Code
 S ADDRESS=$E($P(RPTDATA,U,5),1,35)_" "_$E($P(RPTDATA,U,6),1,25)_", "_$$LJ^XLFSTR($P(RPTDATA,U,7),"2T")_$E(SPACES,1,1)_$$LJ^XLFSTR(ZIPCODE,"10T")
 ;
 ; Unlinked Report
 I IBTYP=1 D
 . ; Line 1 - Ins co, # Active Groups, Claim Prof EDI#, Claim Inst EDI#
 . S DISPDATA(1)=$$LJ^XLFSTR($P(RPTDATA,U),"30T")_$E(SPACES,1,2)_$$RJ^XLFSTR($P(RPTDATA,U,2),5)
 . S DISPDATA(1)=DISPDATA(1)_$E(SPACES,1,18)_$$RJ^XLFSTR($P(RPTDATA,U,3),5)
 . S DISPDATA(1)=DISPDATA(1)_$E(SPACES,1,12)_$$RJ^XLFSTR($P(RPTDATA,U,4),5)
 . ; line 2 - Ins co Address
 . S DISPDATA(2)=$E(SPACES,1,9)_ADDRESS
 . ; line 3 - blank
 . S DISPDATA(3)=" "
 ; Linked Report
 I IBTYP=2 D
 . ; Line 1 - Ins Co(30),# Active Grps, Address line 1, City, ST, Zip, Prof/Inst EDI#
 . S DISPDATA(1)=$$LJ^XLFSTR($P(RPTDATA,U),"30T")_$E(SPACES,1,1)_$$RJ^XLFSTR($P(RPTDATA,U,2),5)
 . S DISPDATA(1)=DISPDATA(1)_$E(SPACES,1,4)_$$LJ^XLFSTR(ADDRESS,"68T")
 . I $P(RPTDATA,U,3)'=""!$P(RPTDATA,U,4) D
 . . S DISPDATA(1)=DISPDATA(1)_$E(SPACES,1,1)_$$RJ^XLFSTR($P(RPTDATA,U,3),5)_"/"_$$LJ^XLFSTR($P(RPTDATA,U,4),5)
 . ; Line 2 - Payer Name(31),VA ID,eIV Natl Enabled,IIU Natl Enabled,eIV Loc Enabled,EligProf/Inst EDI# 
 . S DISPDATA(2)=$E(SPACES,1,2)_$$LJ^XLFSTR($P(RPTDATA,U,9),"31T")_$E(SPACES,1,11)_$$LJ^XLFSTR($P(RPTDATA,U,10),10)
 . S DISPDATA(2)=DISPDATA(2)_$E(SPACES,1,1)_$$LJ^XLFSTR($P(RPTDATA,U,11),3)_$E(SPACES,1,17)_$$LJ^XLFSTR($P(RPTDATA,U,12),3)
 . S DISPDATA(2)=DISPDATA(2)_$E(SPACES,1,16)_$$LJ^XLFSTR($P(RPTDATA,U,13),3)
 . I $P(RPTDATA,U,14)'=""!$P(RPTDATA,U,15) D
 . . S DISPDATA(2)=DISPDATA(2)_$E(SPACES,1,12)_$$RJ^XLFSTR($P(RPTDATA,U,14),5)_"/"_$$RJ^XLFSTR($P(RPTDATA,U,15),5)
 . ; line 3 - blank
 . S DISPDATA(3)=" "
 ;
 Q
 ;
LINE(DISPDATA) ;  Print data
 N LNCT,LNTOT,NWPG
 S LNTOT=+$O(DISPDATA(""),-1)
 S NWPG=0
 F LNCT=1:1:LNTOT D  I $G(ZTSTOP)!PXT W ! Q
 . I IBOUT="R" D  Q:$G(ZTSTOP)!PXT
 . . I $Y+1>MAX!('PGC) D HEADER S NWPG=1 I $G(ZTSTOP)!PXT Q
 . W ! W:IBOUT="R" ?1 W DISPDATA(LNCT) Q
 . I 'NWPG!(NWPG&(DISPDATA(LNCT)'="")) W !,?1,DISPDATA(LNCT)
 . I NWPG S NWPG=0
 . Q
 Q
 ;
HEADER ; Report format Header
 N DIR,DTOUT,DUOUT,HDR,LIN,OFFSET,X,Y
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 G HEADERX
 S PGC=PGC+1
 W @IOF,!,"Insurance Company Link Report"
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC
 S OFFSET=$S(IBTYP=2:131,1:79)-$L(HDR)
 W ?OFFSET,HDR
 W !
 S HDR=$S(IBTYP=1:"Unlinked Insurance Companies",1:"Linked Insurance Companies")
 S HDR=HDR_" - "_$S(IBMAT="":"ALL",1:"that contains: "_IBMAT)
 S OFFSET=$S(IBTYP=2:131,1:79)-$L(HDR)/2
 W ?OFFSET,HDR
 W !
 I IBTYP=1 D
 . W !?32,"# Active",?56,"Prof.",?74,"Inst."
 . ;IB*2*687/DTG remove ':' after the Insurance Company in header
 . W !,"Insurance Company",?33,"Groups",?56,"EDI#",?74,"EDI#"
 . W !,$E(DASH,1,80)
 ;
 I IBTYP=2 D
 . ;IB*2*687/DTG remove ':' from the Insurance Company in header
 . ;W !,"Insurance Company:",?32,"# Active",?56,"eIV Nationally",?75,"IIU Nationally"
 . W !,"Insurance Company",?32,"# Active",?56,"eIV Nationally",?75,"IIU Nationally"
 . W ?94,"eIV Locally",?110,"Prof/Inst EDI#"
 . ;IB*2*687/DTG remove ':' after the Payer Name in header
 . W !,"  Payer Name",?32,"Groups",?45,"VA ID",?56,"Enabled",?76,"Enabled",?95,"Enabled"
 . W !,DASH
HEADERX ;
 Q
 ;
EHDR ; - Excel format Header
 N HDR,X
 S X="Insurance Company Link Report^"_$$FMTE^XLFDT($$NOW^XLFDT,1)
 W X,!
 S HDR=$S(IBTYP=1:"Unlinked Insurance Companies",1:"Linked Insurance Companies")
 S HDR=HDR_" - "_$S(IBMAT="":"ALL",1:"that contains: "_IBMAT)
 W HDR
 S X="Insurance Company^Street Address^City^State^Zip^# Active Groups^Claims Prof EDI#^Claims Inst EDI#"
 ; Unlinked Report
 I IBTYP=1 W !,X Q
 ; Linked Report - add addt'l fields
 I IBTYP=2 D
 . S X=X_"^Payer Name^VA ID^eIV Nationally Enabled^IIU Nationally Enabled^eIV Locally Enabled^"
 . S X=X_"Eligibility Prof EDI#^Eligibility Inst EDI#"
 . W !,X
 Q
