IBCB2 ;ALB/AAS - Process bill after enter/edited ;13-DEC-89
 ;;2.0;INTEGRATED BILLING;**52,51,161,182,155,447,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRB2
 ;
 ;IBQUIT = Flag to stop processing
 ;IBVIEW = Flag showing Bill has been viewed
 ;IBDISP = Flag showing Bill entering display has been viewed.
 ;IBNOFIX = Flag to indicate do not ask to edit or review bill screens
 ;IBREEDIT = Flag to indicate Bill has been re-edited
 ;
VIEW ;View screens; if status allows editing , allow editing
 N Y,DIR
 S IBPOPOUT=0
 S IBVIEW=1,IBV=$S($D(IBV):IBV,1:1)
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="WANT TO "_$S('IBV:"EDIT",1:"REVIEW")_" SCREENS? ",DIR("?",1)="   YES - to "_$S('IBV:"EDIT",1:"REVIEW")_" the screens",DIR("?")="   NO - To take no action"
 D ^DIR K DIR
 S:$D(DTOUT) IBQUIT=1
 Q:Y'=1
 I $G(IBREEDIT)=1,'IBV S IBREEDIT=2   ; set flag indicating re-edit
VIEW1 S IBVIEW=1,IBEDIT=0
 D SCREENS
 S:$G(IBPOPOUT) IBQUIT=1
 Q
 ;
DISP S IB("S")=$S($D(^DGCR(399,IBIFN,"S")):^("S"),1:"")
 W ! D DISP^IBCNQ W !
 S IBDISP=1 Q
 Q
 ;
EDITS ; Perform edits on bill prior to authorization/transmission
 N IBREEDIT
ED1 ;
 S IBQUIT=0
 I '$D(IBER)!('$D(PRCASV)) D ALLED(.IBQUIT)
 ;
 ; If the user is wanting to quit, but there are some unresolved
 ; errors reported by ClaimsManager, then capture the user's Exit
 ; comments.
 ;
 I $$CM^IBCIUT1(IBIFN),IBQUIT,$P($G(^IBA(351.9,IBIFN,0)),U,2)=4 D COMMENT^IBCIUT7(IBIFN,1)
 ;
 Q:IBQUIT
 D:'$D(IBDISP) DISP
 ;
 ; If claim re-edit, then call the IB edit checks again
 I '$D(IBVIEW) S IBREEDIT=1 D VIEW I $G(IBREEDIT)=2 K IBER,IBDISP,IBVIEW G ED1
 Q
 ;
ALLED(IBQUIT) ; Billing edit/correction
 N IBQUIT1,IBDONE1,IBDONE,IBEDIT,IBCORR,IBER,IBPRT,IBXERR
 S (IBQUIT,IBDONE,IBCORR)=0,IBER=""
 ; IBDONE = 1 ==> exit, no errors 
 ; IBQUIT = 1 ==> exit, errors not corrected
 ;JWS;IB*2.0*592:Dental form #7 don't display Box 24 info for dental
 ;I $$FT^IBCEF(IBIFN)=2,'$G(IBNOFIX) D DISP24(IBIFN,.IBCORR,.IBQUIT)  ;/vd - IB*2.0*623 - Modified this line for US4055
 I ($$FT^IBCEF(IBIFN)=2!($$FT^IBCEF(IBIFN)=7)),'$G(IBNOFIX) D DISP24(IBIFN,.IBCORR,.IBQUIT)  ;/vd - IB*2.0*623
 ;JWS;IB*2.0*592:Dental form #7 do same as CMS-1500
 ;vd/IB*2.0*623 - Modified the following line as part of US4055
 ;F  D  Q:IBQUIT!IBDONE  D VIEW1 I $$FT^IBCEF(IBIFN)=2!($$FT^IBCEF(IBIFN)=7),'$G(IBNOFIX),'IBQUIT S IBCORR=0 D:$$FT^IBCEF(IBIFN)'=7 DISP24(IBIFN,.IBCORR,.IBQUIT)
 F  D  Q:IBQUIT!IBDONE  D VIEW1 I ($$FT^IBCEF(IBIFN)=2!($$FT^IBCEF(IBIFN)=7)),'$G(IBNOFIX),'IBQUIT S IBCORR=0 D DISP24(IBIFN,.IBCORR,.IBQUIT)  ;/vd - IB*2.0*623
 . I $G(IBPOPOUT) S IBQUIT=1
 . Q:IBQUIT!IBCORR
 . I $G(IBNOFIX) D
 .. W !!,"... Checking claim validity"
 . E  D
 .. W !!,"... Executing national IB edits"
 . D EN^IBCBB,LOCERR
 . I $G(IBER)'=""!$D(IBXERR) D  Q:'IBDONE
 .. D DSPLERR ; Displays warnings/errors
 .. K IBXERR
 .. Q:IBQUIT!(IBDONE)
 .. I $G(IBNOFIX) S IBDONE=1 Q
 .. I '$$ASKEDIT($G(IBAC)) W ! S IBQUIT=1 ; Don't want to re-edit
 .. ;
 . I $G(IBNOFIX) S IBDONE=1 Q
 . S IBEDIT=0
 . I $S($P($G(^DGCR(399,IBIFN,0)),U,13)>2:1,$D(PRCASV):'$D(PRCASV("OKAY")),1:0) D  S:'IBQUIT&'IBEDIT IBDONE=1 Q
 .. N IBQUIT1
 .. S IBQUIT1=0
 .. W !!!,"... Executing A/R edits"
 .. I $P($G(^DGCR(399,IBIFN,0)),U,13)>2 D GVAR^IBCBB,ARRAY^IBCBB1
 .. D ARCHK($G(IBNOFIX),0,.IBQUIT1,.IBQUIT,.IBEDIT,.PRCASV)
 . S IBDONE=1 ; No errors
 . S:$G(IBPRT("PRT"))'<0 IBQUIT=0
 Q
 ;
ARCHK(IBNOFIX,IBNOPRT,IBQUIT1,IBQUIT,IBEDIT,PRCASV) ; A/R Verification
 ; Returns IBEDIT, IBQUIT1, IBQUIT,PRCASV array if passed by reference
 ; IBNOFIX = 1 if no editing needed
 ; IBNOPRT = 1 if no printing needed
 F  D ^PRCASVC6 D  Q:IBQUIT1!IBEDIT  D GVAR^IBCBB,ARRAY^IBCBB1
 . I '$G(IBNOPRT) Q:$G(IBPRT("PRT"))<0
 . I PRCASV("OKAY") W:'$G(IBNOPRT) !!,"No A/R errors found" S IBQUIT1=1 Q
 . I 'PRCASV("OKAY") D  Q
 .. D DSPARERR($G(IBNOPRT)) ; Display A/R errors
 .. Q:IBQUIT
 .. I $G(IBNOFIX) S IBQUIT1=1 Q
 .. I '$$ASKEDIT($G(IBAC)) W !,"There is an unresolved A/R error - cannot authorize bill" D PAUSE^VALM1 S (IBQUIT,IBQUIT1)=1 Q
 .. S IBEDIT=1
 ;
 Q
 ;
DSPLERR ; Display national/local edits failed
 N Z
 D PRTH(.IBPRT)
 I IBPRT("PRT")<0 S IBQUIT=1 Q
 S Z=0 F  S Z=$O(^TMP($J,"BILL-WARN",Z)) Q:'Z  W !,^(Z) W:'$O(^(Z)) !
 S Y2=""
 I IBER'="WARN" F I=1:1 S X=$P(IBER,";",I) Q:X=""  W:I=1 !?5,"**Errors**:" I $D(^IBE(350.8,+$O(^IBE(350.8,"AC",X,0)),0)) S Y=^(0),Y1=$P(Y,"^",5),Y2=Y2_Y1 I Y1<5 W !?5,$E($P(Y,"^",2),1,80)
 ; IBXERR = local edits return error array
 ; If IBXERR returns = 1 then we have at least one error
 ;                   = "" or 0, then we have only local warnings
 ;           undefined = no local errors or warnings
 I $D(IBXERR) D
 . S I="" W !!,?3,"Local Edits:"
 . S:$G(IBXERR) Y2=3,IBER="L"
 . F  S I=$O(IBXERR(I)) Q:I=""  W !,?5,$E(IBXERR(I),1,75)
 I $G(IBPRT("PRT")) D CLOSE(.IBPRT)
 G:$G(IBNOFIX) Q
 I $G(IBER)="WARN"!($G(IBXERR)=0) D  ;Warnings only - make biller stop and look
 . W !
 . N DIR,X,Y
 . S DIR(0)="YA",DIR("B")="NO",DIR("A",1)="THIS BILL STILL HAS ONE OR MORE WARNINGS - PLEASE REVIEW THEM CAREFULLY",DIR("A")="ARE YOU SURE IT'S OK TO CONTINUE? "
 . D ^DIR K DIR
 . I Y'=1 S Y2=3 Q
 . S IBER="",IBDONE=1 K IBXERR
 I $S(Y2'["3"&'$G(IBXERR):0,1:1) K IBXERR
Q K ^TMP($J,"BILL-WARN")
 Q
 ;
DSPARERR(IBNOPRT) ; Displays A/R errors
 N I,J,Y,X,ERRPRT
 I '$G(IBNOPRT) D PRTH(.IBPRT) I IBPRT("PRT")<0 S IBQUIT=1 Q
 I $P($G(PRCAERR),U,2)'="" D
 . N Z
 . S Z=+$O(^IBE(350.8,"C",$P(PRCAERR,U,2),0)),Z=$P($G(^IBE(350.8,+Z,0)),U,2)
 . W !,?5,"An A/R error has been reported - bill cannot be authorized",!!,?5,$P(PRCAERR,U,2)," - ",$S(Z'="":Z,1:"??")
 E  D
 . W !,?5,"An undetermined A/R error was found - "_$G(PRCAERR)
 I $G(IBPRT("PRT")) D CLOSE(.IBPRT)
 Q
 ;
NOPTF S IBAC1=1 I $D(^DGCR(399,IBIFN,0)),$P(^(0),"^",8),'$D(^DGPT($P(^(0),"^",8),0)) S IBAC1=0
 Q
 ;
NOPTF1 W !!,*7,"PTF Record for this Bill was DELETED!",!,"Further processing not allowed.  Cancel and re-enter." Q
 ;
LOCERR ; Check for local edits
 ; Execute screen post-processor for bills with local scrn 9 affiliations
 N IBZ,IBXIEN,IBPRT
 K IBXERR
 S IBZ=$$LOCSCRN^IBCSC11(IBIFN)     ; IB*2.0*447 BI
 I IBZ S IBXIEN=IBIFN W !!,"... Executing local IB edits" D FPOST^IBCEFG7(IBZ,0,.IBXERR) I '$D(IBXERR) W !!,"No errors found for local edits"
 Q
 ;
PRTH(IBPRT,IBA) ; Print a heading for error/warnings sent to a printer
 ; Returns IBPRT = 1 if valid pritner selected
 ;         IBPRT = -1 if '^' entered
 ;         IBPRT = 0 if home device
 N POP,%ZIS,POP
 S %ZIS("A")="ERROR/WARNING OUTPUT DEVICE: "
 D ^%ZIS
 I POP S IBPRT("PRT")=-1 Q
 I IO=IO(0) S IBPRT("PRT")=0 Q
 S IBPRT("PRT")=1
 U IO
 W !,"INCONSISTENCIES LIST FOR BILL #: ",$P($G(^DGCR(399,IBIFN,0)),U),!,$J("",29),"AT: ",$$FMTE^XLFDT($$NOW^XLFDT,2),!,$J("",19),"GENERATED BY: ",$P($G(^VA(200,DUZ,0)),U),!!
 Q
 ;
CLOSE(IBPRT) ; Close device, reset printer flag
 D ^%ZISC
 S IBPRT("PRT")=0
 D HOME^%ZIS
 Q
 ;
ASKEDIT(IBAC) ; Ask if edit/review of bill is desired
 ; FUNCTION returns 0/1 for NO/YES
 ; IBAC = flag for function being performed - to determine edit/review
 N DIR,X,Y
 S DIR(0)="YA"
 S DIR("A",1)=" ",DIR("A",2)=" ",DIR("A")="Do you wish to "_$S($G(IBAC)<4:"edit",1:"review")_" the inconsistencies now? ",DIR("B")="NO"
 S DIR("?",1)=" ",DIR("?",2)=" ",DIR("?",3)="   YES - To edit inconsistent fields",DIR("?")="   NO - To discontinue this process."
 D ^DIR K DIR
 Q (Y=1)
 ;
SCREENS ;
 N IBH
 D ^IBCSCU,^IBCSC1
 I $G(IBV) K IBPOPOUT
 Q
 ;
DISP24(IBIFN,IBCORR,IBQUIT) ;
 ;/vd - IB*2.0*623/Beginning - modified the following US4055.
 ;W @IOF D BL24^IBCSCH(IBIFN,0)
 W @IOF
 I $$FT^IBCEF(IBIFN)=7 D DENTAL^IBCSCH2(IBIFN) I 1
 E  D BL24^IBCSCH(IBIFN,0)
 ;/vd - IB*2.0*623/End
 S DIR("A",1)=" ",DIR("A")="Are the above charges correct for this bill? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR
 I Y'=1 D
 . I Y=0,$$ASKEDIT($G(IBAC)) S IBCORR=1 Q
 . S IBQUIT=1
 Q
 ;
IICM(IBIFN) ; Ingenix ClaimsManager: Claim Scrubber
 ; Send the bill to ClaimsManager, the IBCISTAT variable returned from ClaimsManager indicates
 ;         3 - Passed CM with no errors
 ;         5 - User overriding the CM errors
 ;         7 - the CM interface isn't working
 ;        11 - User overriding the CM errors (CM not updated)
 ; 
 ; Returns False (0) if the bill fails the ClaimsManager Scrubber/errors found
 ; Returns True (1) if the bill passed the ClaimsManager Scrubber/no errors found or ClaimsManager not On at site
 ;
 N IBOK S IBOK=1
 I +$G(IBIFN),$$CM^IBCIUT1(IBIFN) S IBCISNT=1 D ST2^IBCIST I '$F(".3.5.7.11.","."_IBCISTAT_".") S IBOK=0
 Q IBOK
 ;
IIQMED(IBIFN) ; DSS QuadraMed Interface: QuadraMed Claim Scrubber
 ; Send the bill to the QuadraMed Claim Scrubber
 ; Returns False (0) if the bill fails the QuadraMed Scrubber/errors found
 ; Returns True (1) if the bill passed the QuadraMed Scrubber/no errors found or QuadraMed not On at site
 ;
 ; QuadraMed Scrubber EN^VEJDIBSC returns IBQMED = 1 if no error found, returns 0 if error found
 ;
 N IBQMED S IBQMED=1
 I +$G(IBIFN),$$QMED^IBCU1("EN^VEJDIBSC",IBIFN) D EN^VEJDIBSC(IBIFN)
 Q IBQMED
