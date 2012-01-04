IBCAPR2 ;ALB/BI - PRINT EOB/MRA ;20-SEP-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN(IBIFN) ; -- main entry point for IBCAPR2
 N IBI,IBICNT,EOBDATE
 N FRMTYP,INPAT,IBALL,IBSHEOB
 ;
 S VALMBCK="R"
 I '$G(IBIFN),$D(VALMBG),$D(VALMLST) S IBIFN=$$GETIBIFN
 Q:$G(IBIFN)=""
 S FRMTYP=$$FT^IBCEF(IBIFN)    ;Form Type
 S INPAT=$$INPAT^IBCEF(IBIFN)  ;Inpatient Flag
 ;
 D GETEOBCL^IBCAPR(IBIFN,.IBALL)  ; get all associated claims
 D GETEOBS(.IBALL,.IBSHEOB)  ; get all eobs associated with these claims
 S IBICNT=$$MRACNT^IBCEMU1(IBIFN,0) ; count of MRAs
 I $D(IBSHEOB) S IBI="",IBICNT="" F  S IBI=$O(IBSHEOB(IBI)) Q:IBI=""  S IBICNT=IBICNT+1  ; count of EOBs (reset counter since MRAs are in here)
 ;
 I IBICNT<1 D  Q
 . D FULL^VALM1
 . W !!?5,"There is no electronic EOB for this claim."
 . D PAUSE^VALM1
 . Q
 I IBICNT=1 D  Q
 .S EOBDATE=$O(^IBM(361.1,"ABD",IBIFN,"")) Q:'EOBDATE
 .S IBI=$O(^IBM(361.1,"ABD",IBIFN,EOBDATE,0)) Q:'IBI
 .I $$MRACNT^IBCEMU1(IBIFN,0) D MRAPRINT(IBI) Q
 .I $$MRACNT^IBCEMU1(IBIFN,1) D EOBPRINT(IBI) Q
 ;
 S IBI=$$SEL(.IBSHEOB)
 I +IBI=0 Q
 ;
 I $P($G(^IBM(361.1,IBI,0)),U,4)=1 D MRAPRINT(IBI) Q
 ;
 I $P($G(^IBM(361.1,IBI,0)),U,4)'=1 D EOBPRINT(IBI) Q
 ;
 Q
 ;
EOBPRINT(IBI,IBSHEOB) ; PRINT THE REQUESTED EOB
 N %ZIS,POP,FULLSTOP
 S FULLSTOP=0
 S %ZIS("A")="EOB Device: "
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  G EOBQUIT
 . S ZTRTN="REGION0^IBCAPR2(IBI,.IBSHEOB)"
 . S ZTSAVE("IB*")="",ZTSAVE("IEN")="",ZTSAVE("FRMTYP")="",ZTSAVE("INPAT")="",ZTSAVE("EOBDATE")=""
 . S ZTDESC="IB - EOB PRINTING"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K IO("Q"),ZTSK D HOME^%ZIS
 U IO D REGION0(IBI,.IBSHEOB)
EOBQUIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I FULLSTOP=0,$E(IOST,1,2)["C-" D PAUSE^VALM1
 D ^%ZISC
 Q
 ;
MRAPRINT(IBI) ; PRINT THE REQUESTED MRA
 N IEN,%ZIS,POP
 N IBQUIT,IBPGN S IBQUIT=0
 S IEN=IBI
 S %ZIS("A")="MRA Device: "
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  G MRAQUIT
 . S ZTRTN="PRNTMRA^IBCEMRAA"
 . S ZTSAVE("IB*")="",ZTSAVE("IEN")="",ZTSAVE("FRMTYP")="",ZTSAVE("INPAT")="",ZTSAVE("EOBDATE")=""
 . S ZTDESC="IB - MRA PRINTING"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K IO("Q"),ZTSK D HOME^%ZIS
 U IO D PRNTMRA^IBCEMRAA
MRAQUIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I $E(IOST,1,2)["C-" D PAUSE^VALM1
 D ^%ZISC
 Q
 ;
GETIBIFN() ; Get Internal Claim Pointer
 N DIR,IBDA,IBIFN S IBIFN=""
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S IBDA=$O(VALMY(0))
 S:IBDA IBIFN=$P($G(^TMP("IBCECOB",$J,IBDA)),U,2)
 Q IBIFN
 ;
WRITE(IBSTR) ;
 W IBSTR,!
 Q $$PAUSE
 ;
PAUSE() ;
 Q:$E(IOST,1,2)'["C-" 0
 I $Y>(IOSL-5) D  W @IOF,*13 I $D(DIRUT)!($D(DUOUT)) S FULLSTOP=1 K DIRUT,DTOUT,DUOUT Q 1
 . S DIR(0)="E" D ^DIR K DIR
 Q 0
 ;
 ; ---------- Start of EOB Printing Section ----------
REGION0(IBI,IBSHEOB) ; Print one or several EOBS depending what is passed in.
 ; Input:  IEN to EOB file 361.1 if only one to be printed
 ; Input: IBSHEOB (optional) array of EOBs to be printed
 I $G(IBI) D REGION1(IBI) Q
 S IBI=0 F  S IBI=$O(IBSHEOB(IBI)) Q:'+IBI  D REGION1(IBI) I $O(IBSHEOB(IBI)) W @IOF
 Q
REGION1(IBI) ; EOB Claim Header Information 
 N IBD,IBSTR,IBX,IBM,IBM1,IBM2,IBCA,IBCN
 N IBPR,IBPT,IBPY,IBST,IBTA,IBTS,IBTY,IBSPL
 ;
 ; Line 1
 S IBD="EOB/MRA Information"
 S IBSTR=$$SETLN(IBD,"",30,45) Q:$$WRITE(IBSTR)
 ;
 ; Line 2
 ; IBSPL = 0 if EOB represents one bill's payment
 ;       = 1 if AR had to split the EOB between multiple bills
 S IBSPL=+$O(^IBM(361.1,IBI,8,0)),IBSPL=(+$O(^(IBSPL))'=IBSPL)
 S IBM=$G(^IBM(361.1,IBI,0))
 S IBTY=$P(IBM,U,4),IBTY=$S(IBTY:"MEDICARE MRA",1:"NORMAL EOB")
 I IBTY'["MRA",IBSPL S IBTY="A/R SPLIT/COVERS MORE THAN 1 BILL"
 I $P(IBM,U,13)>1,$P(IBM,U,13)<5 S IBTY=IBTY_" ("_$$EXTERNAL^DILFD(361.1,.13,,$P(IBM,U,13))_")"
 S IBD="EOB Type: "_IBTY,IBSTR=$$SETLN(IBD,"",5,25)
 S IBD="Claim Number: "_$$GET1^DIQ(399,IBIFN_", ",.01),IBSTR=$$SETLN(IBD,IBSTR,51,25)
 Q:$$WRITE(IBSTR)
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
 Q:$$WRITE(IBSTR)
 ;
 ; Line 4
 S IBPY=$$GET1^DIQ(36,+$P(IBM,U,2)_", ",.01)
 S IBM2=$G(^IBM(361.1,IBI,2)),IBTA=$P(IBM2,U,3)
 ; if no Total Allowed Amount, sum up amounts on Line Level Adjustment
 I IBTA="" S IBTA=$$ALLOWED^IBCEMU2(IBI)
 S IBD="Payer Name: "_IBPY,IBSTR=$$SETLN(IBD,"",3,40)
 S IBD="Total Allowed Amount: "_$S('IBTA:IBX,1:IBTA)
 S IBSTR=$$SETLN(IBD,IBSTR,43,36)
 Q:$$WRITE(IBSTR)
 ;
 ; Line 5
 S IBTS=$P(IBM2,U,4)
 S IBPR=$$FMTE^XLFDT($P(IBM,U,6))
 S IBD="EOB Date: "_IBPR,IBSTR=$$SETLN(IBD,"",5,35)
 S IBD="Total Submitted Charges: "_$S('IBTS:IBX,1:IBTS)
 S IBSTR=$$SETLN(IBD,IBSTR,40,39)
 Q:$$WRITE(IBSTR)
 ;
 ; Line 6
 S IBD="Svc From Dt: "_$$DAT1^IBOUTL($P(IBM1,U,10))
 S IBSTR=$$SETLN(IBD,"",2,38)
 S IBD="Svc To Dt: "_$$DAT1^IBOUTL($P(IBM1,U,11))
 S IBSTR=$$SETLN(IBD,IBSTR,54,25)
 Q:$$WRITE(IBSTR)
 ;
 ; Line 7
 S IBCA=$P(IBM1,U)
 S IBST=$P(IBM,U,16),IBST=$$EXPAND^IBTRE(361.1,.16,+IBST)
 S IBSTR=""
 I IBTY["MRA" S IBD="MRA Review Status: "_IBST,IBSTR=$$SETLN(IBD,"",2,38)
 S IBD=$S('$G(IBSPL):"  ",1:"**")_"Reported Payment Amt: "_$S('IBCA:$J(IBX,"",2),1:$J(+IBCA,"",2))
 S IBSTR=$$SETLN(IBD,IBSTR,41,37)
 Q:$$WRITE(IBSTR)
 ;
REGION2 ; EOB MEDICARE RA Information
 ;
 I IBTY["MRA",$D(^IBM(361.1,IBI,21)) D
 . S IBD=$TR($J("",35)," ","-")_"Review"_$TR($J("",38)," ","-")
 . S IBSTR=$$SETLN(IBD,"",1,79) W IBSTR,!
 . S (IBST,IBCN)=0 F  S IBCN=$O(^IBM(361.1,IBI,21,IBCN)) Q:'IBCN  S X=$G(^(IBCN,0)) D
 .. S IBST=0
 .. S IBD="Review Date: "_$$DAT1^IBOUTL($P(X,U))
 .. S IBSTR=$$SETLN(IBD,"",1,30)
 .. S IBD="Reviewed By: "_$$GET1^DIQ(200,+$P(X,U,2)_", ",.01)   ; DBIA 10060
 .. S IBSTR=$$SETLN(IBD,IBSTR,40,39)
 .. Q:$$WRITE(IBSTR)
 .. S IBD=0 F  S IBD=$O(^IBM(361.1,IBI,21,IBCN,1,IBD)) Q:'IBD  S IBSTR=$$SETLN($S('IBST:"Comments: ",1:"")_$G(^(IBD,0)),"",1,$S('IBST:69,1:79)),IBST=1 Q:$$WRITE(IBSTR)
 . I 'IBST D
 .. S IBSTR=$$SETLN("None","",1,10)
 .. Q:$$WRITE(IBSTR)
 ;
REGION3 ; EOB CLAIM and LINE level Information
 N Z
 K ^TMP("PRCA_EOB",$J)
 D GETEOB^IBCECSA6(IBI,2)
 S Z="" F  S Z=$O(^TMP("PRCA_EOB",$J,IBI,Z),-1) Q:Z=""  Q:$TR($G(^TMP("PRCA_EOB",$J,IBI,Z))," ","")'=""  D
 . K ^TMP("PRCA_EOB",$J,IBI,Z)
 S Z=0 F  S Z=$O(^TMP("PRCA_EOB",$J,IBI,Z)) Q:'Z  S IBSTR=$$SETLN($G(^TMP("PRCA_EOB",$J,IBI,Z)),"",1,79) Q:$$WRITE(IBSTR)
 K ^TMP("PRCA_EOB",$J)
 ;
REGION4 ; EOB Display information about any 361.1 message storage or filing errors
 N Z
 I '$O(^IBM(361.1,IBI,"ERR",0)) Q
 S IBSTR=$$SETLN(" ** MESSAGE STORAGE ERRORS  **","",1,79) Q:$$WRITE(IBSTR)
 S Z=0 F  S Z=$O(^IBM(361.1,IBI,"ERR",Z)) Q:'Z  S IBSTR=$$SETLN($G(^(Z,0)),"",1,79) Q:$$WRITE(IBSTR)
 Q
 ;
SETLN(S,V,X,L) ; -- insert text(S) into variable(V)
 ;    S := string to insert
 ;    V := destination string
 ;    X := insert @ col X
 ;    L := clear # of chars (length)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
 ; ---------- End of EOB Printing Section ----------
 ;
EOBALL(IBIFN) ;
 ;
 ; This is passed in a claim and prints all EOBs associated with the claim.
 ; Only ask the device once.
 ; It prints EOB for current payer sequence and works backwards.
 ;
 N IBALL,IBSHEOB,IBI,Z
 D GETEOBCL^IBCAPR(IBIFN,.IBALL)
 ;
 D GETEOBS(.IBALL,.IBSHEOB)
 Q:'$D(IBSHEOB)    ; nothing to print
 ;
 Q:'$$OKTOPRT()
 D EOBPRINT("",.IBSHEOB)
 Q
 ;
OKTOPRT() ; This procedure is called when the user is printing bills
 ; and we know that one or more EOBs exist for this bill.  We ask the
 ; user if the EOB(s) should be printed at this time too.
 ;
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("A",1)="There are one or more EOBs associated with this bill."
 S DIR("A")="Do you want to print them now"
 S DIR("?")="Please answer Yes or No.  If you answer Yes, then you will be asked to supply the output device and all EOBs associated with this bill will then be printed."
 W !!
 D ^DIR
 Q $S(Y:1,1:0)
 ;
GETEOBS(IBALL,IBSHEOB) ; Get all the EOBS
 ; INPUT - IBALL array of claim numbers (IEN to 399)
 ; OUTPUT - IBSHEOB array of EOBs (IEN to 361.1)
 ;
 N IBIFN
 S IBIFN=0
 F  S IBIFN=$O(IBALL(IBIFN)) Q:IBIFN=""  D
 .S IBI=0 F  S IBI=$O(^IBM(361.1,"B",IBIFN,IBI)) Q:'IBI  S Z=+$O(^IBM(361.1,IBI,8,0)) I '$O(^(Z)) S IBSHEOB(IBI)=0  ; Entire EOB belongs to the bill
 .;
 .S IBI=0 F  S IBI=$O(^IBM(361.1,"C",IBIFN,IBI)) Q:'IBI  S IBSHEOB(IBI)=1 ; EOB has been reapportioned at the site
 ;
 Q
 ;
SEL(IBSHEOB) ; Function to display and allow user selection
 ; of an EOB/MRA on file in 361.1 for a sequence of bills.
 ;
 ; Input:  IBSHEOB   - array of internal bill numbers (required)
 ;         ex IBSHEOB(361.1 IEN1)=""
 ;            IBSHEOB(361.1 IEN2)=""
 ;
 ; Function Value:  IEN to file 361.1 or nil if no selection made
 ;
 NEW IBEOB,EOBDATE,COUNT,IEN,IBM,INSCO,SEQ,EOBDT,EOBTYP,CLMSTAT,LIST
 NEW J,A,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBM1
 ;
 S IBEOB=""
 Q:'$D(IBSHEOB) IBEOB
 S IEN="",COUNT=0
 F  S IEN=$O(IBSHEOB(IEN)) Q:'+IEN  D 
 . S IBM=$G(^IBM(361.1,IEN,0))
 . S INSCO=$$EXTERNAL^DILFD(361.1,.02,,$P(IBM,U,2))
 . S SEQ=$E($$EXTERNAL^DILFD(361.1,.15,,$P(IBM,U,15)),1)
 . S EOBDT=$$FMTE^XLFDT($P($P(IBM,U,6),".",1),"2Z")
 . S EOBTYP=$P("EOB^MRA",U,$P(IBM,U,4)+1)
 . S CLMSTAT=$$EXTERNAL^DILFD(361.1,.13,"",$P(IBM,U,13))
 . S COUNT=COUNT+1
 . S LIST(COUNT)=IEN_U_SEQ_U_INSCO_U_EOBDT_U_EOBTYP_U_CLMSTAT
 ;
 I 'COUNT G SELX                           ; no mra/eob data found
 ;
 ; Display mra/eob data
 S J="EOB's/MRA's"
 I COUNT>1 W !!,"The selected bill has multiple ",J," on file.  Please choose one."
 W !!?7,"#",?11,"Seq",?17,"Insurance Company",?40,"EOB Date"
 W ?51,"Type",?57,"Claim Status"
 F J=1:1:COUNT S A=LIST(J) D
 . W !?5,$J(J,3),?11,"(",$P(A,U,2),")",?17,$E($P(A,U,3),1,20)
 . W ?40,$P(A,U,4),?51,$P(A,U,5),?57,$P(A,U,6)
 . Q
 ;
 ; User Selection
 W ! S DIR(0)="NO^1:"_COUNT,DIR("A")="Select an EOB/MRA"
 D ^DIR K DIR
 I 'Y G SELX    ; no selection made
 S IBEOB=+$G(LIST(Y))
 ;
SELX ;
 Q IBEOB
 ;
PRINTOPT   ; PRINT EOB OPTION
 N DIC,IBIFN,Y
 S DIC="^IBM(361.1,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,4)='1"
 S DIC("W")="D EOBLST^IBCEMU1(Y)"   ; modify generic lister
 D ^DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) S IBQUIT=1 Q
 S IBI=$P(Y,U,1),IBIFN=$P(Y,U,2)
 D EOBPRINT(IBI) ; PRINT THE REQUESTED EOB
 Q
