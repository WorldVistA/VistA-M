IBCNESI1 ;ALB/TAZ - MEDICARE POTENTIAL COB Patient Selection ;15 Jan 13
 ;;2.0;INTEGRATED BILLING;**497**;21-MAR-94;Build 120
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;Only enter at labels.
 ;
LIST ; Entry Point from IBCNESI
 ; IBSDT - Start Date
 ; IBEDT - End Date
 ; IBSORT - Sort Direction
 ; IBREP - Report or Screen
 ; IBCOMP - 
 ;  1 = include completed entries only
 ;  2 = include completed entries only with comments
 ;  3 = exclude completed entries
 ;  4 = exclude completed entries with comments
 ;
 N IBDT,IBDT1,IBPYR,IBMPYR,IBDFN,IBRIEN,IBRVIEN,IBEIEN,IBDATA,IENS,IBSEQ,IBCIEN,IBEIDCD,IBRVST,IBELIG,IBNOCMT,IBCNT
 K ^TMP($J,"IBCNESI1"),^TMP($J,"IBCNESI2"),^TMP("IBCNESI1",$J),^UTILITY("VADM",$J)
 S IBPYR=$P($G(^IBE(350.9,1,51)),U,25) ; get Medicare payer ien from IB site parameters
 S IBDT=IBSDT-.1,IBCNT=0
 D BLDTMP
 I IBREP="R" D EN^IBCNERPI
 Q
 ;
BLDTMP ;  construct the temporary global array according to filter and sort criteria selected by user
 F  S IBDT=$O(^IBCN(365,"AD",IBDT)) Q:'IBDT!(IBDT>(IBEDT+1))  D
 . S IBDFN=0
 . F  S IBDFN=$O(^IBCN(365,"AD",IBDT,IBPYR,IBDFN)) Q:'IBDFN  D
 .. S IBRIEN=0
 .. F  S IBRIEN=$O(^IBCN(365,"AD",IBDT,IBPYR,IBDFN,IBRIEN)) Q:'IBRIEN  D
 ... ; Transmission Status must be "Response Received"
 ... I $$GET1^DIQ(365,IBRIEN_",",.06,"I")'=$O(^IBE(365.14,"B","Response Received","")) Q
 ... ; Get Response Review Status and check if there are comments. Include/exclude entries according to the report type.
 ... S IBRVIEN=$O(^IBCN(365.2,"B",IBRIEN,"")),IBRVST=+$$GET1^DIQ(365.2,IBRVIEN_",",.02,"I")
 ... S IBNOCMT=IBCOMP#2 ; 1 - don't print comments, 0 - print comments
 ... I "^1^2^"[(U_IBCOMP_U),IBRVST'=2 Q           ; type = 1 or 2, status is not "review complete"
 ... I "^3^4^"[(U_IBCOMP_U),IBRVST=2 Q            ; type = 3 or 4, status is "review complete"
 ... ; Get eligibility Data and set up COB nodes
 ... S IBDT1=(IBDT\1)*IBSORT
 ... S IBEIEN=0
 ... F  S IBEIEN=$O(^IBCN(365,IBRIEN,2,IBEIEN)) Q:'IBEIEN  D
 .... ;Get Eligibility Code.  We want R codes only.
 .... S IENS=IBEIEN_","_IBRIEN_","
 .... S IBELIG=$$GET1^DIQ(365.02,IENS,.02) I IBELIG'="R" Q
 .... S IBEIDCD=$$GET1^DIQ(365.02,IENS,3.01) ;I ",PR,PRP,SEP,TTP,"'[(","_IBEIDCD_",") Q
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,3.03),^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"NAME")=IBDATA
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ENT ID CD")=$S(",PRP,SEP,TTP,"[(","_IBEIDCD_","):IBEIDCD,1:"")
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"EMFLAG")=$$MATCH(IBDFN,IBDATA)
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,3.04) I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ID")=IBDATA
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,3.05,"I") I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ID QUAL")=$P(^IBE(365.023,IBDATA,0),U,2)
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,4.01) I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 1")=IBDATA
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,4.02) I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ADDRESS 2")=IBDATA
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,4.03) I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"CITY")=IBDATA
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,4.04,"I") I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"STATE")=$$GET1^DIQ(5,IBDATA_",",1)
 .... S IBDATA=$$GET1^DIQ(365.02,IENS,4.05) I IBDATA'="" S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,"ZIP")=IBDATA
 .... S IBCIEN=0
 .... ; display Contact Information
 .... F  S IBCIEN=$O(^IBCN(365,IBRIEN,2,IBEIEN,6,IBCIEN)) Q:'IBCIEN  D
 ..... S IENS=IBCIEN_","_IBEIEN_","_IBRIEN_","
 ..... S IBDATA=$$GET1^DIQ(365.26,IENS,.04) I ",UR,TE,"'[(","_IBDATA_",") Q  ;Phone and Web only
 ..... S IBSEQ=$$GET1^DIQ(365.26,IENS,.01)
 ..... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"INS",IBEIEN,IBDATA,IBSEQ)=$$GET1^DIQ(365.26,IENS,1)
 ... ;If COB data found set up Patient Info
 ... I $D(^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN)) D
 .... N VAHOW,DFN,VADM
 .... S VAHOW=2,DFN=IBDFN D DEM^VADPT
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"PATIENT NAME")=$P($G(^UTILITY("VADM",$J,1)),U)
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"DOB")=$P($G(^UTILITY("VADM",$J,3)),U)
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"SSN")=$E($P($G(^UTILITY("VADM",$J,2)),U),6,10)
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"REV IEN")=+$G(IBRVIEN)
 ....;KML need to have capability of accessing the REV STATUS subscript when REVIEW STATUS is updated by user
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"REV STATUS")=+$G(IBRVST)_U_IBDT1_U_IBDFN
 .... S ^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN,"NO CMNT")=+$G(IBNOCMT)
 .... K ^UTILITY("VADM",$J)
 .... S IBCNT=IBCNT+1 I '$D(ZTQUEUED),'(IBCNT#15) W ". "
 ... M ^TMP($J,"IBCNESI2",IBRIEN)=^TMP($J,"IBCNESI1",IBDT1,IBDFN,IBRIEN)
 I IBREP="S" D EN^VALM("IBCNE MEDICARE COB LIST")
 Q
 ;
MATCH(IBDFN,INSCONM) ;Match Insurance Companies with Insurance Type subfile.
 N EXPDT,MATCH,NAME,IENS,IBITYP
 S MATCH=0
 S IBITYP=0
 F  S IBITYP=$O(^DPT(IBDFN,.312,IBITYP)) Q:'IBITYP  D  I MATCH Q
 . S IENS=IBITYP_","_IBDFN_","
 . S EXPDT=$$GET1^DIQ(2.312,IENS,.03) I EXPDT&(DT>(EXPDT-1)) Q  ;Only allow current Insurance Type entries
 . S NAME=$$GET1^DIQ(2.312,IENS,.01)
 . I NAME=$E(INSCONM,1,30) S MATCH=1  ;Names must be an exact match
MATCHQ ;
 Q $S(MATCH:"*",1:"")
 ;
HDR ; -- header code
 S VALMHDR(1)=""
 S VALMHDR(2)="Sorted in "_$S((IBSORT<0):"Reverse ",1:"")_"Chronological Order."
 S VALM("TITLE")="Medicare Potential COB List",VALMSG="*Exact Match"
 Q
 ;
INIT ; -- init variables and list array
 D BLDSCRN
 Q
 ;
HELP ; -- help code
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF
 W !,"Status of entries displayed:"
 W !,"   Y - Entry has been reviewed but is not yet complete"
 W !,"   N - Entry has not been reviewed"
 W !
 W !,"* Denotes that the Insurance Company in the Response Record"
 W !,"  matches an Insurance Company in the Insurance Type "
 W !,"  sub-file of the Patient File."
 D PAUSE^VALM1
 Q
 ;
EXIT ; -- exit code
 K ^TMP($J,"IBCNESI1"),^TMP($J,"IBCNESI2"),^TMP("IBCNESI1",$J),^UTILITY("VADM",$J)
 Q
 ;
EXPND ; -- expand code
 N DA,DD,DIC,DIK,DLAYGO,X,Y,IBDA,IBIEN
 D SEL(.IBDA,1) S:$O(IBDA(0)) IBRIEN=+IBDA($O(IBDA(0))) I '$G(IBRIEN) G EXPNDQ
 D EN^IBCNESI2(IBRIEN)
EXPNDQ ;
 D BLDSCRN
 S VALMBCK="R"
 Q
 ;
BLDSCRN ;build screen of worklist entries
 N IBLN,IBRVSTAT,LINEVAR,DISPDATE
 K @VALMAR
 S IBDT="",(IBLN,VALMCNT)=0
 F  S IBDT=$O(^TMP($J,"IBCNESI1",IBDT)) Q:'IBDT  D
 . S DISPDATE=1
 . S IBDFN=""
 . F  S IBDFN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN)) Q:'IBDFN  D
 .. S IBRIEN=""
 .. F  S IBRIEN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN,IBRIEN)) Q:'IBRIEN  D
 ... S IBRVSTAT=$P($G(^TMP($J,"IBCNESI1",IBDT,IBDFN,IBRIEN,"REV STATUS")),U)
 ... I IBRVSTAT=2 Q  ;Do not include completes on the screen
 ... ;Only display the date if there are incomplete entries on that date.
 ... I DISPDATE S LINEVAR="",LINEVAR=$$SETSTR^VALM1($$FMTE^XLFDT((IBDT*IBSORT),"2Z"),LINEVAR,3,11) D SET(LINEVAR,IBLN+1) S DISPDATE=0
 ... S LINEVAR="",IBLN=IBLN+1
 ... S LINEVAR=$$SETFLD^VALM1($J(IBLN,3),LINEVAR,"COUNTER")
 ... S LINEVAR=$$SETFLD^VALM1($J(" ",7)_$G(^TMP($J,"IBCNESI2",IBRIEN,"PATIENT NAME")),LINEVAR,"PATIENT")
 ... S LINEVAR=$$SETFLD^VALM1($G(^TMP($J,"IBCNESI2",IBRIEN,"SSN")),LINEVAR,"SSN")
 ... S LINEVAR=$$SETFLD^VALM1($$FMTE^XLFDT($G(^TMP($J,"IBCNESI2",IBRIEN,"DOB")),"2Z"),LINEVAR,"DOB")
 ... S LINEVAR=$$SETFLD^VALM1($J($S(IBRVSTAT:"Y",1:"N"),2),LINEVAR,"STATUS")
 ... ; Get 1st Insurance Co
 ... S IBEIEN=0
 ... S IBEIEN=$O(^TMP($J,"IBCNESI1",IBDT,IBDFN,IBRIEN,"INS",IBEIEN))
 ... S LINEVAR=$$SETFLD^VALM1($G(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"EMFLAG")),LINEVAR,"EMFLAG")
 ... S IBDATA=$E($G(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"NAME")),1,31)
 ... I ^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"ENT ID CD")]"" S IBDATA=IBDATA_" ("_$E(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"ENT ID CD"),1)_")"
 ... S LINEVAR=$$SETFLD^VALM1(IBDATA,LINEVAR,"INSCO")
 ... D SET(LINEVAR,IBLN,IBRIEN)
 ... F  S IBEIEN=$O(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN)) Q:'IBEIEN  D
 .... S LINEVAR=""
 .... S LINEVAR=$$SETFLD^VALM1($G(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"EMFLAG")),LINEVAR,"EMFLAG")
 .... S IBDATA=$E($G(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"NAME")),1,31)
 .... I ^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"ENT ID CD")]"" S IBDATA=IBDATA_" ("_$E(^TMP($J,"IBCNESI2",IBRIEN,"INS",IBEIEN,"ENT ID CD"),1)_")"
 .... S LINEVAR=$$SETFLD^VALM1(IBDATA,LINEVAR,"INSCO")
 .... D SET(LINEVAR,IBLN,IBRIEN)
 I VALMCNT=0 D SET("",IBLN+1),SET("* * * No Worklist Entries to Display * * *",IBLN+1),SET("Review Status is 'Complete' for all entries within given Date Range",IBLN+1)
 Q
 ;
SET(X,CNT,IBIEN) ;set up list manager screen array
 S VALMCNT=VALMCNT+1
 S @VALMAR@(VALMCNT,0)=X
 S @VALMAR@("IDX",VALMCNT,CNT)=""
 I $G(IBIEN),$G(@VALMAR@(CNT))="" S @VALMAR@(CNT)=VALMCNT_U_IBIEN
 Q
 ;
SEL(IBDA,ONE) ; Select entry(s) from list
 ; IBDA = array returned if selections made
 ;    IBDA(n)=ien of entry selected (file 365)
 ; ONE = if set to 1, only one selection can be made at a time
 N VALMY,VALMBG,VALMLST
 I $D(@VALMAR) D
 . S VALMBG=$O(@VALMAR@("IDX","")),VALMLST=$O(@VALMAR@("IDX",""),-1)
 . K IBDA
 . D FULL^VALM1
 . ;D EN^VALM2("",$S('$G(ONE):"",1:"S")) ; WCJ
 . D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))   ;WCJ
 . S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=$P($G(@VALMAR@(+IBDA)),U,2,6)
 Q
