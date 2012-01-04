IBCAPR ;ALB/BI - PRINT EOB/MRA ;20-SEP-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN(IBIFN) ; -- main entry point for IBCAPR
 S VALMBCK="R"
 I '$G(IBIFN),$D(VALMBG),$D(VALMLST) S IBIFN=$$GETIBIFN
 Q:$G(IBIFN)=""
 D EN^VALM("IBCAPR")
 Q
 ;
HDR ; -- header code
 N PTNAME,CLONED
 S PTNAME=$$GET1^DIQ(399,IBIFN_", ",.02)
 S VALMHDR(1)="PATIENT: "_PTNAME
 ;
 S CLONED=$$GET1^DIQ(399,IBIFN_", ",30)
 S:CLONED'="" VALMHDR(2)="CLONED FROM: "_CLONED
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCAPR",$J)
 S VALMCNT=$$EOB(IBIFN)-1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCAPR",$J)
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
EOB(IBIFN) ;  Obtain the EOB Information from Dictionary 361.1, EXPLANATION OF BENEFITS.
 ;
 N IBALL,IBI,IBILLCNT,IBLN,IBSHEOB
 N IBCA,IBCN,IBCT,IBFT,IBMSG,IBPR,IBPT,IBPY,IBQUIT,IBREC1,IBST
 N IBSTR,IBTA,IBTS,IBTY,IBX,IBXARRAY,IBXARRY,IBXDATA,IBXERR,IBXSAVE,IBZ,Z
 ;
 D GETEOBCL(IBIFN,.IBALL)   ; get all associated claims
 ;
 S IBLN=1,IBILLCNT=0
 ;
 S IBIFN=0
 F  S IBIFN=$O(IBALL(IBIFN)) Q:IBIFN=""  D
 .S IBI=0 F  S IBI=$O(^IBM(361.1,"B",IBIFN,IBI)) Q:'IBI  S Z=+$O(^IBM(361.1,IBI,8,0)) I '$O(^(Z)) S IBILLCNT=IBILLCNT+1,IBSHEOB(IBI)=0  ; Entire EOB belongs to the bill
 .;
 .S IBI=0 F  S IBI=$O(^IBM(361.1,"C",IBIFN,IBI)) Q:'IBI  S IBCT=IBCT+1,IBSHEOB(IBI)=1 ; EOB has been reapportioned at the site
 ;
 Q:'$D(IBSHEOB)    ; nothing to print
 ;
 S Z=0,IBI=0
 F IBZ=1:1 S IBI=$O(IBSHEOB(IBI)) Q:'IBI  D  I $O(IBSHEOB(IBI)) W @IOF
 . D REGION1(IBI,+IBSHEOB(IBI),IBZ,IBILLCNT)
 . D REGION2,REGION3,REGION4
 ;
 Q IBLN
 ;
REGION1(IBI,IBSPL,IBEOBCT,IBCTOF) ; Claim Header Information
 N IBD,IBSTR,IBX,IBM,IBM1,IBM2
 ;
 ; Line 1
 S IBEOBCT=$G(IBEOBCT),IBCTOF=$G(IBCTOF)
 S IBD="EOB/MRA Information"_$S(IBCTOF'="":" ("_IBEOBCT_" OF "_IBCTOF_")",1:"")
 S IBSTR=$$SETLN(IBD,"",30,45),$E(IBSTR,1,2)=">>",IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 2
 ; IBSPL = 0 if EOB represents one bill's payment
 ;       = 1 if AR had to split the EOB between multiple bills
 ; Assumes IBLN is defined and returns it with line count
 S IBM=$G(^IBM(361.1,IBI,0))
 S IBTY=$P(IBM,U,4),IBTY=$S(IBTY:"MEDICARE MRA",1:"NORMAL EOB")
 I IBTY'["MRA",IBSPL S IBTY="A/R SPLIT/COVERS MORE THAN 1 BILL"
 I $P(IBM,U,13)>1,$P(IBM,U,13)<5 S IBTY=IBTY_" ("_$$EXTERNAL^DILFD(361.1,.13,,$P(IBM,U,13))_")"
 S IBD="EOB Type: "_IBTY,IBSTR=$$SETLN(IBD,"",5,59)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 3
 S IBCN=$P(IBM,U,14)
 S IBX="0.00"
 S IBD="ICN: "_IBCN,IBSTR=$$SETLN(IBD,"",10,30)
 S IBM1=$G(^IBM(361.1,IBI,1))
 S IBPT=$P(IBM1,U,2)   ; patient responsibility 1.02 field
 I $P(IBM,U,4),$D(^IBM(361.1,IBI,"ERR")) S IBPT=0  ; filing error
 ; If MRA & UB, then calculate patient responsiblity value
 I $P(IBM,U,4),$$FT^IBCEF(+$P(IBM,U,1))=3 S IBPT=$$PTRESPI^IBCECOB1(IBI)
 S IBD="Patient Resp Amount: "_$S('IBPT:IBX,1:IBPT)
 S IBSTR=$$SETLN(IBD,IBSTR,44,35)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 4
 S IBPY=$$GET1^DIQ(36,+$P(IBM,U,2)_", ",.01)
 S IBM2=$G(^IBM(361.1,IBI,2)),IBTA=$P(IBM2,U,3)
 ; if no Total Allowed Amount, sum up amounts on Line Level Adjustment
 I IBTA="" S IBTA=$$ALLOWED^IBCEMU2(IBI)
 S IBD="Payer Name: "_IBPY,IBSTR=$$SETLN(IBD,"",3,40)
 S IBD="Total Allowed Amount: "_$S('IBTA:IBX,1:IBTA)
 S IBSTR=$$SETLN(IBD,IBSTR,43,36)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 5
 S IBTS=$P(IBM2,U,4)
 S IBPR=$$FMTE^XLFDT($P(IBM,U,6))
 S IBD="EOB Date: "_IBPR,IBSTR=$$SETLN(IBD,"",5,35)
 S IBD="Total Submitted Charges: "_$S('IBTS:IBX,1:IBTS)
 S IBSTR=$$SETLN(IBD,IBSTR,40,39)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 6
 S IBD="Svc From Dt: "_$$DAT1^IBOUTL($P(IBM1,U,10))
 S IBSTR=$$SETLN(IBD,"",2,38)
 S IBD="Svc To Dt: "_$$DAT1^IBOUTL($P(IBM1,U,11))
 S IBSTR=$$SETLN(IBD,IBSTR,54,25)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
 ; Line 7
 S IBCA=$P(IBM1,U)
 S IBST=$P(IBM,U,16),IBST=$$EXPAND^IBTRE(361.1,.16,+IBST)
 S IBSTR=""
 I IBTY["MRA" S IBD="MRA Review Status: "_IBST,IBSTR=$$SETLN(IBD,"",2,38)
 S IBD=$S('$G(IBSPL):"  ",1:"**")_"Reported Payment Amt: "_$S('IBCA:$J(IBX,"",2),1:$J(+IBCA,"",2))
 S IBSTR=$$SETLN(IBD,IBSTR,41,37)
 S IBLN=$$SET(IBSTR,IBLN)
 ;
REGION2 ; MEDICARE RA Information
 ;
 I IBTY["MRA",$D(^IBM(361.1,IBI,21)) D
 . S IBD=$TR($J("",35)," ","-")_"Review"_$TR($J("",38)," ","-")
 . S IBSTR=$$SETLN(IBD,"",1,79),IBLN=$$SET(IBSTR,IBLN)
 . S (IBST,IBCN)=0 F  S IBCN=$O(^IBM(361.1,IBI,21,IBCN)) Q:'IBCN  S X=$G(^(IBCN,0)) D
 .. S IBST=0
 .. S IBD="Review Date: "_$$DAT1^IBOUTL($P(X,U))
 .. S IBSTR=$$SETLN(IBD,"",1,30)
 .. S IBD="Reviewed By: "_$$GET1^DIQ(200,+$P(X,U,2)_", ",.01)   ; DBIA 10060
 .. S IBSTR=$$SETLN(IBD,IBSTR,40,39)
 .. S IBLN=$$SET(IBSTR,IBLN)
 .. S IBD=0 F  S IBD=$O(^IBM(361.1,IBI,21,IBCN,1,IBD)) Q:'IBD  S IBSTR=$$SETLN($S('IBST:"Comments: ",1:"")_$G(^(IBD,0)),"",1,$S('IBST:69,1:79)),IBST=1,IBLN=$$SET(IBSTR,IBLN)
 . I 'IBST D
 .. S IBSTR=$$SETLN("None","",1,10)
 .. S IBLN=$$SET(IBSTR,IBLN)
 Q
 ;
REGION3 ; CLAIM and LINE level Information
 N Z
 K ^TMP("PRCA_EOB",$J)
 D GETEOB^IBCECSA6(IBI,2)
 S Z=0 F  S Z=$O(^TMP("PRCA_EOB",$J,IBI,Z)) Q:'Z  S IBSTR=$$SETLN($G(^TMP("PRCA_EOB",$J,IBI,Z)),"",1,79),IBLN=$$SET(IBSTR,IBLN)
 K ^TMP("PRCA_EOB",$J)
 Q
 ;
REGION4 ; Display information about any 361.1 message storage or filing errors
 N Z
 I '$O(^IBM(361.1,IBI,"ERR",0)) Q
 S IBSTR=$$SETLN(" ** MESSAGE STORAGE ERRORS  **","",1,79),IBLN=$$SET(IBSTR,IBLN)
 S Z=0 F  S Z=$O(^IBM(361.1,IBI,"ERR",Z)) Q:'Z  S IBSTR=$$SETLN($G(^(Z,0)),"",1,79),IBLN=$$SET(IBSTR,IBLN)
 Q
 ;
SETLN(S,V,X,L) ; -- insert text(S) into variable(V)
 ;    S := string to insert
 ;    V := destination string
 ;    X := insert @ col X
 ;    L := clear # of chars (length)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
SET(STR,LN) ; set up TMP array with EOB Data
 S ^TMP("IBCAPR",$J,LN,0)=STR
 Q LN+1
 ;
PRTOPT1 ; LIST MANAGER FORM entry point to print EOB, asking for print device.
 N IBSCAN
 D FULL^VALM1
 D ^%ZIS Q:POP
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 D PAUSE^VALM1
 I X="^" S VALMBCK="Q" Q
 S VALMBCK="R"
 Q
 ;
PRTOPT2 ; LIST MANAGER FORM entry point to print to default print device.
 N IBSCAN,X,IOP
 D FULL^VALM1
 S VALMBCK="R"
 S IOP=$$EOBPRT
 D:IOP=""
 . Write !!,"*** The default EOB Printer doesn't seem to be defined ***"
 . D PAUSE^VALM1
 . S X="^"
 Q:$G(X)="^" 
 D ^%ZIS Q:POP
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 Q
 ;
PRTOPT3 ; LIST MANAGER FORM entry point to print EOB and MRA, asking for print devices.
 N IBSCAN
 D FULL^VALM1
 W !!,"Select Printer for the EOB",!
 D ^%ZIS Q:POP
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 D PAUSE^VALM1
 I X="^" S VALMBCK="Q" Q
 W !!,"Select Printer for the MRA",!
 D MRA^IBCEMRAA(IBIFN)
 D PAUSE^VALM1
 I X="^" S VALMBCK="Q" Q
 S VALMBCK="R"
 Q
 ;
PRTOPT4 ; LIST MANAGER FORM entry point to print EOB and MRA to default print devices.
 N IBSCAN,X,IOP
 D FULL^VALM1
 S VALMBCK="R"
 S IOP=$$EOBPRT
 D:IOP=""
 . Write !!,"*** The default EOB Printer doesn't seem to be defined ***"
 . D PAUSE^VALM1
 . S X="^"
 Q:$G(X)="^" 
 D ^%ZIS
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 S IOP=$$MRAPRT
 D:IOP=""
 . Write !!,"*** The default MRA Printer doesn't seem to be defined ***"
 . D PAUSE^VALM1
 . S X="^"
 Q:$G(X)="^" 
 D ^%ZIS
 U IO
 D PROC^IBCEMRAA
 D ^%ZISC
 Q
 ;
PRTOPT5(IBIFN) ; External entry point to print EOB information, asking for print device.
 N IBSCAN
 D EOB(IBIFN)
 D ^%ZIS Q:POP 0
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 K ^TMP("IBCAPR",$J)
 Q 1
 ;
PRTOPT6(IBIFN) ; External entry point to print EOB information to default print device.
 N IBSCAN,IOP
 I '$$PRTCHK16 Q $$PRTCHK16
 S IOP=$$EOBPRT
 Q:IOP="" "0^EOB PRINTER NOT DEFINED"
 D EOB(IBIFN)
 D ^%ZIS Q:POP
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 K ^TMP("IBCAPR",$J)
 Q 1
 ;
PRTOPT7(IBIFN) ; External entry point to print EOB and MRA information, asking for print devices.
 N IBSCAN
 D EOB(IBIFN)
 W !!,"Select Printer for the EOB",!
 D ^%ZIS Q:POP 0
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 K ^TMP("IBCAPR",$J)
 W !!,"Select Printer for the MRA",!
 D MRA^IBCEMRAA(IBIFN)
 Q 1
 ;
PRTOPT8(IBIFN) ; External entry point to print EOB and MRA information to default print devices.
 N IBSCAN,IOP
 I '$$PRTCHK16 Q $$PRTCHK16
 S IOP=$$EOBPRT
 Q:IOP="" "0^EOB PRINTER NOT DEFINED"
 D EOB(IBIFN)
 D ^%ZIS Q:POP "0^EOB PRINTER NOT DEFINED CORRECTLY"
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . U IO W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 K ^TMP("IBCAPR",$J)
 I '$$PRTCHK14 Q $$PRTCHK14
 S IOP=$$MRAPRT
 Q:IOP="" "0^MRA PRINTER NOT DEFINED"
 D ^%ZIS Q:POP "0^MRA PRINTER NOT DEFINED CORRECTLY"
 U IO
 D PROC^IBCEMRAA
 D ^%ZISC
 Q 1
 ;
PRINT8Q(IBIFN) ; External entry point to QUEUE the EOB and MRA print jobs
 ; Queue to Print EOB portion to the default EOB printer.
 N %ZIS,ZTDTH,ZTRTN,ZTSAVE,ZTDESC,POP,IOP,IBTSK1,IBTSK2
 I '$G(IBIFN) Q "0^CLAIM NUMBER NOT DEFINED"
 I '$$PRTCHK16 Q $$PRTCHK16
 S IOP=$$EOBPRT
 Q:IOP="" "0^EOB PRINTER NOT DEFINED"
 S %ZIS="QN"
 D ^%ZIS I POP Q "0^EOB PRINTER NOT DEFINED CORRECTLY"
 S ZTRTN="PRINT8Q1^IBCAPR"   ; Background re-entry point.
 S ZTDESC="EOB PRINT"
 S ZTSAVE("IB*")=""
 S ZTDTH=$H
 D ^%ZTLOAD S IBTSK1=$G(ZTSK)
 K ZTSK,IO("Q") D HOME^%ZIS
 ; Queue to Print MRA portion to the default MRA printer.
 K %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP
 I '$$PRTCHK14 Q $$PRTCHK14
 S IOP=$$MRAPRT
 Q:IOP="" "0^MRA PRINTER NOT DEFINED"
 S IBIFN=$$GETMRACL(IBIFN)
 Q:'IBIFN "0^NO MRA CLAIM TO PRINT"
 S %ZIS="QN"
 D ^%ZIS I POP Q "0^MRA PRINTER NOT DEFINED CORRECTLY"
 S ZTRTN="PROC^IBCEMRAA"   ; Background re-entry point.
 S ZTDESC="MRA PRINT"
 S ZTSAVE("IB*")=""
 S ZTDTH=$H
 D ^%ZTLOAD S IBTSK2=$G(ZTSK)
 K ZTSK,IO("Q") D HOME^%ZIS
 Q 1_"^"_IBTSK1_"^"_IBTSK2
PRINT8Q1 ; Background re-entry point.
 D EOB(IBIFN)
 F IBSCAN=1:1:$O(^TMP("IBCAPR",$J,""),-1) D
 . W ^TMP("IBCAPR",$J,IBSCAN,0),!
 D ^%ZISC
 Q
 ;
EOBPRT() ; Get EOB Printer Name
 Q $$GET1^DIQ(350.9,"1, ",8.16)
 ;
MRAPRT() ; Get MRA Printer Name
 Q $$GET1^DIQ(350.9,"1, ",8.19)
 ;
PRTCHK(ERROR) ;  ; Validate ALL printer parameters.
 ; USAGE EXAMPLES:  W $$PRTCHK^IBCAPR(.ERRMSG)," ",ERRMSG,!
 ;                  I '$$PRTCHK^IBCAPR Q
 N X,ERR14,ERR15,ERR16,ERR19,STATUS
 S ERROR="",STATUS=1
 S:'$$PRTCHK14(.X,.ERR14) STATUS=0
 S:'$$PRTCHK15(.X,.ERR15) STATUS=0
 S:'$$PRTCHK16(.X,.ERR16) STATUS=0
 S:'$$PRTCHK19(.X,.ERR19) STATUS=0
 Q:STATUS 1
 I ERR14'="" S ERROR=ERR14
 I ERR15'="" S ERROR=ERROR_$S(ERROR="":ERR15,1:", "_ERR15)
 I ERR16'="" S ERROR=ERROR_$S(ERROR="":ERR16,1:", "_ERR16)
 I ERR19'="" S ERROR=ERROR_$S(ERROR="":ERR19,1:", "_ERR19)
 Q 0
 ;
PRTCHK14(PRTNM,ERROR) ; Validate the CMS-1500 printer parameter.
 ; USAGE EXAMPLES:  I $$PRTCHK14^IBCAPR(.NAME,.ERRMSG) S IOP=NAME
 ;                  I '$$PRTCHK14^IBCAPR Q
 N POP
 S ERROR=""
 S IOP=$$CMS1500^IBCAPR1(),PRTNM=IOP
 I IOP="" S ERROR="CMS-1500 PRINTER NOT DEFINED" Q "0^"_ERROR
 S %ZIS="QN"
 D ^%ZIS I POP S ERROR="CMS-1500 PRINTER NOT DEFINED CORRECTLY" Q "0^"_ERROR
 Q 1
 ;
PRTCHK15(PRTNM,ERROR) ; Validate the UB-04 printer parameter.
 ; USAGE EXAMPLE:  I $$PRTCHK15^IBCAPR(.NAME,.ERRMSG) S IOP=NAME
 ;                  I '$$PRTCHK15^IBCAPR Q
 N POP
 S ERROR=""
 S IOP=$$UB4PRT^IBCAPR1(),PRTNM=IOP
 I IOP="" S ERROR="UB-04 PRINTER NOT DEFINED" Q "0^"_ERROR
 S %ZIS="QN"
 D ^%ZIS I POP S ERROR="UB-04 PRINTER NOT DEFINED CORRECTLY" Q "0^"_ERROR
 Q 1
 ;
PRTCHK16(PRTNM,ERROR) ; Validate the EOB printer parameter.
 ; USAGE EXAMPLE:  I $$PRTCHK16^IBCAPR(.NAME,.ERRMSG) S IOP=NAME
 ;                  I '$$PRTCHK16^IBCAPR Q
 N POP
 S ERROR=""
 S IOP=$$EOBPRT(),PRTNM=IOP
 I IOP="" S ERROR="EOB PRINTER NOT DEFINED" Q "0^"_ERROR
 S %ZIS="QN"
 D ^%ZIS I POP S ERROR="EOB PRINTER NOT DEFINED CORRECTLY" Q "0^"_ERROR
 Q 1
 ;
PRTCHK19(PRTNM,ERROR) ; Validate the MRA printer parameter.
 ; USAGE EXAMPLE:  I $$PRTCHK19^IBCAPR(.NAME,.ERRMSG) S IOP=NAME
 ;                  I '$$PRTCHK19^IBCAPR Q
 N POP
 S ERROR=""
 S IOP=$$MRAPRT(),PRTNM=IOP
 I IOP="" S ERROR="MRA PRINTER NOT DEFINED" Q "0^"_ERROR
 S %ZIS="QN"
 D ^%ZIS I POP S ERROR="MRA PRINTER NOT DEFINED CORRECTLY" Q "0^"_ERROR
 Q 1
 ;
GETIBIFN() ; Get Internal Claim Pointer
 N DIR,IBDA,IBIFN S IBIFN=""
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S IBDA=$O(VALMY(0))
 S:IBDA IBIFN=$P($G(^TMP("IBCECOB",$J,IBDA)),U,2)
 Q IBIFN
 ;
GETMRACL(IBIFN) ; Get MRA claim #
 ; Find if there was MEDICARE WNR on the bill being passed in and then get the claim associated with it.
 N IBMRASEQ,IBWNRFL,IBM1,IBMRACL
 F IBMRASEQ=1:1:3 S IBWNRFL=$$WNRBILL^IBEFUNC(IBIFN,IBMRASEQ) Q:+IBWNRFL
 I '+IBWNRFL Q 0  ; No Medicare WNR on Bill
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 S IBMRACL=$P(IBM1,U,4+IBMRASEQ)
 I +IBMRACL Q IBMRACL
 ;
 ; Since Medicare WNR does not generate a new bill # and hence may not
 ; point to a previous bill, this may need to grab the secondary bill
 I IBMRASEQ=1 S IBMRACL=$P(IBM1,U,6)
 ;
 Q +IBMRACL
 ;
GETEOBCL(IBIFN,IBALL) ; Get all Claims associated with this one. 
 ; If it's secondary, get primary
 ; If it's a tertiary, get secondary and primary
 ; Input: IBIFN - IEN to 399 for cliam being printed
 ;        IBALL by reference 
 ; Output: IBALL - Array of claim numbers which have EOBS for this claim.
 N IBCOBN,IBPRVCL,IBM1,LOOP
 S IBALL(IBIFN)=""
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 S IBCOBN=$$COBN^IBCEF(IBIFN)-1
 Q:IBCOBN<1
 F LOOP=IBCOBN:-1:1 S IBPRVCL=$P(IBM1,U,4+LOOP) S:IBPRVCL]"" IBALL(IBPRVCL)=""
 Q
