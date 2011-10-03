IBCEM4 ;ALB/TMP - IB ELECTRONIC MESSAGE SCREEN TEXT MAINT ;19-APR-2001
 ;;2.0;INTEGRATED BILLING;**137,368**;21-MAR-1994;Build 21
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entry point for maintenance
 D EN^VALM("IBCE MESSAGE TEXT MAIN")
 Q
 ;
HDR ; Header code
 K VALMHDR
 Q
 ;
INIT ; Build list of text entries
 N Z,Z0
 S (IBCNT,VALMCNT)=0,VALMBG=1
 K ^TMP("IBCEMSGT",$J)
 S Z="" F  S Z=$O(^IBE(361.3,"AC",Z),-1) Q:Z=""  D SET(Z) S Z0="" F  S Z0=$O(^IBE(361.3,"AC",Z,Z0)) Q:Z0=""  D SET(Z,Z0)
 Q
 ;
EXIT ; -- Clean up list
 K ^TMP("IBCEMSGT",$J)
 D CLEAN^VALM10
 Q
 ;
SET(Z,Z0) ; Set data into display global
 N X,IB
 S IBCNT=IBCNT+1,X="",IB=""
 S:$G(Z0)'="" Z0="    "_Z0
 I $G(Z0)="" D
 . S Z0=$S('Z:"*** DO NOT REQUIRE REVIEW ***",1:"*** REQUIRE REVIEW ***"),IB=$J("",(80-$L(Z0))\2),Z0=IB_Z0
 . I 'Z D SET(Z," ")
 I Z0'="" S X=$$SETFLD^VALM1(Z0,X,"TEXT")
 S VALMCNT=VALMCNT+1,^TMP("IBCEMSGT",$J,VALMCNT,0)=X
 S ^TMP("IBCEMSGT",$J,"IDX",VALMCNT,IBCNT)=""
 I IB'="" D CNTRL^VALM10(VALMCNT,2+$L(IB),$L(Z0)-$L(IB),IORVON,IORVOFF)
 Q
EDIT ; Add/edit message text
 N DA,DIC,DLAYGO,DIE,DR,DIR,X,Y,IBUPD,IBSTOP,IBY
 D FULL^VALM1
 S (IBSTOP,IBUPD)=0
 F  D  Q:IBSTOP
 . S DIC(0)="AELMQ",DLAYGO=361.3,DIC="^IBE(361.3,",DIC("DR")="@1;.02;I X="""" W !,""MUST HAVE A VALUE FOR THIS FIELD"" S Y=""@1""" W ! D ^DIC
 . S IBY=Y
 . I IBY'>0 S IBSTOP=1 Q
 . I $P(IBY,U,3) S IBUPD=1 Q
 . S DIC="^IBE(361.3,",DA=+IBY W ! D EN^DIQ W !
 . S DIE="^IBE(361.3,",DA=+IBY,DR=".01" D ^DIE ; edit
 . I '$D(^IBE(361.3,+IBY,0)) S IBUPD=1 Q
 . I $P(IBY,U,2)'=$P(^IBE(361.3,+IBY,0),U) S IBUPD=1,DIE="^IBE(361.3,",DR=".05////"_$G(DUZ)_";.06///^S X=""NOW""" D ^DIE
 D:IBUPD INIT
 S VALMBCK="R"
 Q
 ;
CKREVU(IBTEXT,IBNR,IBSKIP,IBREV) ; Check IBTEXT contains 'no review
 ;        needed' text
 ; IBNR = returned if passed by reference - 'no review needed' text found
 ; IBSKIP = 1 if no check needed for 'always review'
 ; IBREV = returned if passed by reference and 'review always needed'
 ;         text found
 ;
 N T,Y,Z,Z0
 S (IBREV,Y)=0,Z="",IBTEXT=$$UP^XLFSTR($G(IBTEXT))
 I '$G(IBSKIP) F  S Z=$O(^IBE(361.3,"AC",1,Z)) Q:Z=""  I IBTEXT[$$UP^XLFSTR(Z) S IBREV=1 Q  ; Always review messages with this text
 I 'IBREV S Z="" F  S Z=$O(^IBE(361.3,"AC",0,Z)) Q:Z=""  I IBTEXT[$$UP^XLFSTR(Z) S Y=1,IBNR=Z Q  ; Message contains text to make review unnecessary
 Q Y
 ;
REPORT ; Produce a report of messages filed without review by user-selected
 ; date range for date received and sort by either bill# or message text
 N IBFR,IBTO,IBSORT,DIR,DA,DR,X,Y,ZTSAVE,ZTRTN,ZTDESC,ZTREQ
R1 S DIR("A")="FROM DATE RECEIVED: ",DIR(0)="DA^:"_DT_"::PAXE" D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 S IBFR=Y W "   ",$G(Y(0))
R2 S DIR("A")="TO DATE RECEIVED: ",DIR(0)="DAO^"_IBFR_":"_DT_"::PAE" D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 I Y'>0 W ! G R1
 S IBTO=Y W "   ",$G(Y(0))
 S DIR("A")="SORT BY",DIR(0)="SXBO^B:Bill #;M:Message Screen Text",DIR("B")="B" D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 I (Y="")!("BM"'[Y) W ! G R2
 S IBSORT=Y
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENRPT^IBCEM4",ZTSAVE("IB*")="",ZTDESC="IB - MESSAGES FILED WITHOUT REVIEW REPORT" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 U IO
ENRPT ; Queued job entrypoint
 N IB,IB0,IBDA,IB00,IB1,IBS1,IBPAGE,IBLINES,IBHDRDT,IBSB,IBSTOP,DIR,Y,X,Z
 W:$E(IOST,1,2)["C-" @IOF ;Only initial form feed for print to screen
 K ^TMP($J,"IBSORT")
 S IB=IBFR-.000001
 F  S IB=$O(^IBM(361,"ARD",IB)) Q:'IB!$G(ZTSTOP)  S IBDA=0 F  S IBDA=$O(^IBM(361,"ARD",IB,IBDA)) Q:'IBDA!$G(ZTSTOP)  S IB0=$G(^IBM(361,IBDA,0)) Q:IB0=""!'$P(IB0,U,14)  D
 . I $D(ZTQUEUED) Q:$$STOP(.ZTREQ,.ZTSTOP)
 . S IBS1=""
 . I IBSORT="M" D  ; Find text that caused auto-file
 .. S Z=0 F  S Z=$O(^IBM(361,IBDA,1,Z)) Q:'Z  I $$CKREVU($G(^IBM(361,IBDA,1,Z,0)),.IBS1,1) Q
 .. I IBS1="" S IBS1="??"
 . I IBSORT="B" S IBS1=$P($G(^DGCR(399,+IB0,0)),U)
 . I IBS1'="" S ^TMP($J,"IBSORT",IBS1,IBDA)=IB0
 S IBHDRDT=$$FMTE^XLFDT($$NOW^XLFDT(),"2P")
 S (IBSTOP,IBLINES,IBPAGE)=0
 S IB1=1,IB="" F  S IB=$O(^TMP($J,"IBSORT",IB)) Q:IB=""!$G(ZTSTOP)  D  Q:IBSTOP
 . S IBSB=$S(IBSORT="M":"MESSAGE SCREEN TEXT: "_IB,1:"")
 . I IBSB'="" S IBSB=$J("",(80-$L(IBSB)\2))_IBSB
 . D:IB1 RHDR(IBSB,.IBSTOP) Q:IBSTOP
 . I 'IB1,IBSORT="M" D  Q:IBSTOP
 .. I IBLINES>(IOSL-5) D RHDR(IBSB,.IBSTOP) Q
 .. W !!,IBSB,! S IBLINES=IBLINES+3
 . S (IB1,IBDA)=0 F  S IBDA=$O(^TMP($J,"IBSORT",IB,IBDA)) Q:'IBDA!$G(ZTSTOP)  D  Q:IBSTOP
 .. I $D(ZTQUEUED),$$STOP(.ZTREQ,.ZTSTOP) W !,"*********** REPORT STOPPED BEFORE IT COMPLETED!!! ***********" Q
 .. S IB0=$G(^TMP($J,"IBSORT",IB,IBDA)),IB00=$G(^DGCR(399,+IB0,0))
 .. I $G(IBLINES)>(IOSL-5) D RHDR("",.IBSTOP) Q:IBSTOP
 .. W !,$E($$BN1^PRCAFN(+IB0)_$J("",10),1,10),"  ",$E($P($G(^DPT(+$P(IB00,U,2),0)),U)_$J("",25),1,25)_"  "_$E($$FMTE^XLFDT($P(IB00,U,3),"2D")_$J("",8),1,8)_"  "_$E($$FMTE^XLFDT($P(IB0,U,2),"2D")_$J("",8),1,8)_"  "
 .. W $E($P($G(^DIC(36,+$$POLICY^IBCEF(+IB0,1,$P(IB0,U,7)),0)),U),1,20)
 .. S IBLINES=IBLINES+1
 .. I $G(IBLINES)>(IOSL-5) D RHDR("",.IBSTOP) Q:IBSTOP
 .. S Z=0 F  S Z=$O(^IBM(361,IBDA,1,Z)) Q:'Z  D  Q:IBSTOP
 ... N Z0,Z1
 ... S Z0=$G(^IBM(361,IBDA,1,Z,0))
 ... F Z1=1:75:$L(Z0) D:$G(IBLINES)>(IOSL-5) RHDR("",.IBSTOP) Q:IBSTOP  W !,?5,$E(Z0,Z1,Z1+74) S IBLINES=IBLINES+1
 G:IBSTOP!$G(ZTSTOP) ENSTOP
 I $G(IB1) D RHDR("") W !,"NO RECORDS MATCHING SEARCH CRITERIA WERE FOUND",!
 ;
 I $E(IOST,1,2)["C-"  K DIR S DIR(0)="E" D ^DIR K DIR
ENSTOP I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED),'$G(ZTSTOP) S ZTREQ="@"
 K ^TMP($J,"IBSORT")
 Q
 ;
RHDR(IBSB,IBSTOP) ; Report header
 ; IBSB'="" if sub header should print
 N Z,DIR,X,Y
 S IBPAGE=IBPAGE+1
 I IBPAGE>1,$E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S IBSTOP=1 G RHDRQ
 W !,@IOF
 W !,?22,"MESSAGES FILED WITHOUT REVIEW REPORT",?65,"PAGE: ",IBPAGE
 S Z="RUN DATE: "_IBHDRDT W !,?(80-$L(Z)\2),Z
 S Z="DATE RECEIVED RANGE: "_$$FMTE^XLFDT(IBFR,"2D")_"-"_$$FMTE^XLFDT(IBTO,"2D") W !,?(80-$L(Z)\2),Z,!
 W !,$J("",40),"EVENT      DATE"
 W !,"BILL #      PATIENT NAME"_$J("",15)_" DATE     RECEIVED  INSURANCE CO",!
 S Z="",$P(Z,"-",81)="" W Z
 S IBLINES=7
 I $G(IBSB)'="" W !,IBSB,! S IBLINES=IBLINES+2
RHDRQ Q
 ;
STOP(IBSTOP,IBREQ) ; Check for job being stopped
 I $$S^%ZTLOAD S IBSTOP=1 K IBREQ
 Q $G(IBSTOP)
 ;
