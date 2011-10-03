RCDPEX3 ;ALB/TMK - ELECTRONIC EOB EXCEPTION PROCESSING - FILE 344.4 ;10-OCT-02
 ;;4.5;Accounts Receivable;**173,208,258**;Mar 20, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; IA# 5286 for call to $$PRVPHONE^IBJPS3()
 Q
 ;
VP ; View/Print ERA Msgs - File 344.4
 N X,Y,RCDA,RCTDA,RCALL,DIR,POP
 D FULL^VALM1
 S DIR(0)="SA^A:ALL;S:SELECTED",DIR("A")="PRINT (A)LL or (S)ELECTED RECORDS?: "
 S DIR("B")="ALL"
 D ^DIR K DIR
 G:$D(DUOUT)!$D(DTOUT) VPQ
 S RCALL=(Y="A")
 ;
 I 'RCALL D  G:'$O(RCDA("")) VPQ
 . D SEL(.RCDA)
 ;
 ; device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP VPQ
 I $D(IO("Q")) D  G VPQ
 . S ZTRTN="VPOUT^RCDPEX3",ZTDESC="AR - Print ERA/EEOB Data With Exceptions"
 . S ZTSAVE("RCDA")="",ZTSAVE("RCALL")="",ZTSAVE("^TMP(""RCDPEX_SUM-EOBDX"",$J,")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
VPOUT ; Entrypoint queued job
 ; RCDA, RCALL must be defined
 N Z,RCSTOP,RCZ,RCPG,RCDOT,RCTDA1
 K ^TMP($J,"RC_SUMRAW"),^TMP($J,"RC_SUMOUT")
 S (RCSTOP,RCPG)=0,RCDOT="",$P(RCDOT,".",79)=""
 I RCALL D
 . S RCZ=0 F  S RCZ=$O(^TMP("RCDPEX_SUM-EOBDX",$J,RCZ)) Q:'RCZ  S RCTDA=$G(^(RCZ)),RCTDA1=+$P(RCTDA,U,3),RCTDA=+$P(RCTDA,U,2) D  Q:RCSTOP
 .. D PRT(RCTDA,RCTDA1,.RCPG,.RCSTOP)
 .. I $O(^TMP("RCDPEX_SUM-EOBDX",$J,RCZ)) D WRTSEP(RCDOT,RCPG)
 I 'RCALL D
 . S RCZ=0 F  S RCZ=$O(RCDA(RCZ)) Q:'RCZ  D
 .. S RCTDA1=+$P(RCDA(RCZ),U,2),RCTDA=+RCDA(RCZ) D PRT(RCTDA,RCTDA1,.RCPG,.RCSTOP) I $O(RCDA(RCZ)) D WRTSEP(RCDOT,RCPG)
 ;
 I '$D(ZTQUEUED),'RCSTOP,RCPG D ASK(.RCSTOP)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 ;
VPQ K ^TMP($J,"RC_SUMRAW"),^TMP($J,"RC_SUMOUT")
 S VALMBCK="R"
 Q
 ;
WRTSEP(RCDOT,RCPG) ; Separating lines if more records to print
 W !,RCDOT,!,RCDOT
 I (($Y+5)>IOSL) D HDR(.RCPG) Q
 W !!
 Q
 ;
PRT(RCTDA,RCTDA1,RCPG,RCSTOP) ; Print data from file 344.4 and 344.41
 ; RCTDA = ien file 344.4
 ; RCTDA1 = ien file 344.41
 ; RCPG = last page extracted
 ; RCSTOP = returned 1 if passed by ref and process stopped
 ;
 N RCDIQ,RCDIQ1,RCDIQ2,RCXM1,RC,Z
 D GETS^DIQ(344.4,RCTDA_",","*","IEN","RCDIQ")
 D TXT0^RCDPEX31(RCTDA,.RCDIQ,.RCXM1,.RC) ; Get top level 0-node captioned fields
 ;
 I $O(^RCY(344.4,RCTDA,2,0)) S RC=RC+1,RCXM1(RC)="  **ERA LEVEL ADJUSTMENTS**"
 S Z=0 F  S Z=$O(^RCY(344.4,RCTDA,2,Z)) Q:'Z  D
 . D GETS^DIQ(344.42,Z_","_RCTDA_",","*","IEN","RCDIQ2")
 . D TXT2^RCDPEX31(RCTDA,Z,.RCDIQ2,.RCXM1,.RC) ; Get top level ERA adjs
 ;
 D GETS^DIQ(344.41,RCTDA1_","_RCTDA_",","*","IEN","RCDIQ1")
 D TXT00^RCDPEX31(RCTDA,RCTDA1,.RCDIQ1,.RCXM1,.RC)
 D DISP^RCDPESR0("^RCY(344.4,"_RCTDA_",1,"_RCTDA1_",1)","^TMP($J,""RC_SUMRAW"")",1,"^TMP($J,""RC_SUMOUT"")",75) ; Get formatted 'raw' data
 ;
 I $D(RCDIQ1(344.41,RCTDA1_","_RCTDA_",",2)) D
 . S RC=RC+1,RCXM1(RC)="  **RESOLUTION LOG DATA**"
 . S Z=0 F  S Z=$O(RCDIQ1(344.41,RCTDA1_","_RCTDA_",",2,Z)) Q:'Z  S RC=RC+1,RCXM1(RC)=RCDIQ1(344.41,RCTDA1_","_RCTDA_",",2,Z)
 . S RC=RC+1,RCXM1(RC)=" "
 S (RCSTOP,Z)=0
 F  S Z=$O(RCXM1(Z)) Q:'Z  S ^TMP($J,"RC_SUMOUT",Z-999)=RCXM1(Z)
 S Z=""
 F  S Z=$O(^TMP($J,"RC_SUMOUT",Z)) Q:'Z  D  Q:RCSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W !!,"***TASK STOPPED BY USER***" Q
 . I 'RCPG!(($Y+5)>IOSL) D  I RCSTOP Q
 .. D:RCPG ASK(.RCSTOP) I RCSTOP Q
 .. D HDR(.RCPG)
 . W !,$G(^TMP($J,"RC_SUMOUT",Z))
 ;
 Q
 ;
XFR ; Transfer EOB(s) to other site
 N RC,RC0,RCCHG,RCOK,RCDOMAIN,RCDEF,RCDA,RCWHY,RCER,RCECT,RCXTO,RCALL,RCCONT,DIR,X,Y,DA,DIE,DR,POP,RCDA,RCXDA,RCXDA1,RCDUZ,XMBODY,XMTO
 D FULL^VALM1
 D SEL(.RCDA)
 ;
 G:'$O(RCDA(0)) XFRQ
 S DIR("S")="I +$G(^DIC(4,+Y,6))",DIR(0)="PA^4:AME",DIR("A")="TRANSFER TO WHICH SITE?: " D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G XFRQ
 S RCXTO=+Y,RCCHG=0
 ;
 S RCDOMAIN=$$EXTERNAL^DILFD(4,60,,+$G(^DIC(4,+RCXTO,6))),RCECT=0
 I RCDOMAIN="" D  G XFRQ
 . S DIR("A",1)="THERE IS NO VALID DOMAIN SET UP FOR THIS SITE. YOU MUST CHOOSE ANOTHER ONE.",DIR("A")="PRESS RETURN TO CONTINUE",DIR(0)="EA" W ! D ^DIR K DIR
 ;
 S RCDEF=$$PRVPHONE^IBJPS3()                  ; IA 5286
 I RCDEF'="" S RCDEF="AGENT CASHIER-"_RCDEF
 ;
 S DIR("A",1)="ENTER THE CONTACT INFORMATION FOR THE PERSON AT YOUR SITE"
 S DIR("A",2)="   WHO MAY BE CONTACTED BY THE OTHER SITE REGARDING THIS EEOB"
 S DIR("A")="   (1-45 CHARACTERS): "_$S(RCDEF'="":RCDEF_"// ",1:"")
 S DIR(0)="FA"_$S(RCDEF'="":"O",1:"")_"^1:45" W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G XFRQ
 I Y="" S Y=RCDEF
 S RCCONT=Y
 ;
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO PRINT THE EEOB(s)?: ",DIR("B")="Y"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G XFRQ
 I Y=1 S RCER=0 D  I RCER G XFRQ
 . N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 . S %ZIS="QM" D ^%ZIS I POP S RCER=1 Q
 . I $D(IO("Q")) D  Q
 .. S RCALL=0
 .. S ZTRTN="VPOUT^RCDPEX3",ZTDESC="AR - Print EEOB Data Before Transfer"
 .. S ZTSAVE("RCDA")="",ZTSAVE("RCALL")="",ZTSAVE("^TMP(""RCDPEX_SUM-EOBDX"",$J)")=""
 .. D ^%ZTLOAD
 .. I '$D(ZTSK) S RCER=1
 .. K ZTSK,IO("Q") D HOME^%ZIS
 . S RCALL=0
 . D VPOUT^RCDPEX3
 ;
 S RCWHY(1)="Transfer EEOB detail to another site"
 S RC=0 F  S RC=$O(RCDA(RC)) Q:'RC  D  L -^RCY(344.4,RCXDA,1,RCXDA1,0)
 . N RCBODY,RCAMT,RCBILL,RCX,XMZ
 . S RCXDA=+RCDA(RC),RCXDA1=+$P(RCDA(RC),U,2),RCWHY(2)=""
 . I '$$LOCK^RCDPEX31(RCXDA,RCXDA1,1) D  Q
 .. S RCECT=RCECT+1,RCER(RCECT)="**Selection #"_RC_" is being edited by another user - ... please try again later"
 . ;
 . S RC0=$G(^RCY(344.4,RCXDA,1,RCXDA1,0))
 . M RCBODY=^RCY(344.4,RCXDA,1,RCXDA1,1)
 . S RCAMT=$P(RC0,U,3)*100
 . S RCBILL=$P(RC0,U,5)
 . S DIR("A",1)="ONCE THIS EEOB HAS BEEN TRANSFERRED, ITS BILL # CANNOT BE EDITED",DIR("A")="ARE YOU SURE THIS IS NOT A CLAIM FOR YOUR SITE?: ",DIR(0)="YA",DIR("B")="NO" W ! D ^DIR K DIR
 . Q:Y'=1
 . I $P(RC0,U,11) D  Q:'RCOK
 .. S RCOK=1
 .. S DIR("A",1)="WARNING: EEOB FOR #"_RC_" ("_RCBILL_") HAS ALREADY BEEN TRANSFERRED",DIR("A",2)="   TO "_$P($G(^DIC(4,+$P(RC0,U,11),0)),U)_"   ON: "_$$FMTE^XLFDT($P(RC0,U,12),2)
 .. S DIR("A")="ARE YOU SURE YOU WANT TO TRANSFER IT AGAIN?: "
 .. S DIR(0)="YA",DIR("B")="NO" W ! D ^DIR K DIR
 .. I Y=1 Q
 .. S RCOK=0
 .. S RCECT=RCECT+1,RCER(RCECT)="**Selection #"_RC_" already transferred - "_RCBILL_" NOT transferred again"
 . K RCBODY(0)
 . S RCX=$G(RCBODY(1,0))
 . ;
 . I $P($G(^RCY(344.4,RCXDA,1,RCXDA1,0)),U,7)'=1 D  Q
 .. S RCECT=RCECT+1,RCER(RCECT)="**Selection #"_RC_" is not available for transfer - "_RCBILL_" NOT transferred"
 . ;
 . I $P(RCX,U)'["835ERA"!'$O(RCBODY(1)) D  Q
 .. S RCECT=RCECT+1,RCER(RCECT)="**Selection #"_RC_" format is not valid for transfer - "_RCBILL_" NOT transferred"
 . ;
 . S $P(RCX,U)="835XFR",$P(RCX,U,10,16)=(RCAMT_"^^^^^^"_RCCONT)
 . S RCBODY(1,0)=RCX
 . S RCBODY(+$O(RCBODY(""),-1)+1,0)="99^$"
 . S RCBODY(+$O(RCBODY(""),-1)+1,0)="NNNN"
 . S XMTO("S.RCDPE EDI LOCKBOX SERVER@"_RCDOMAIN)=""
 . S XMBODY="RCBODY",RCDUZ=$G(DUZ),DUZ=.5
 . D SENDMSG^XMXAPI(.5,"TRANSFER 3RD PARTY EEOB "_RCBILL_"(REF #"_RCXDA_";"_RCXDA1_"#)",XMBODY,.XMTO,,.XMZ)
 . ;
 . S DUZ=RCDUZ
 . I $G(XMZ) D  ; Report msg #
 .. S RCCHG=1
 .. S RCECT=RCECT+1,RCER(RCECT)="Entry #"_RC_" was successfully transferred - msg # is "_XMZ
 .. S DA(1)=RCXDA,DA=RCXDA1,DIE="^RCY(344.4,"_DA(1)_",1,",DR=".09////"_XMZ_";.11////"_RCXTO_";.12////"_$E($$NOW^XLFDT(),1,12) D ^DIE
 .. S RCWHY(2)=" Transfer to "_$P($G(^DIC(4,+RCXTO,0)),U)_" was successful"
 .. ;
 . E  D  ; error - transfer not done
 .. S RCECT=RCECT+1,RCER(RCECT)="**Entry #"_RC_" was NOT transferred due to a msg build error ("_RCBILL_")"
 .. S RCWHY(2)=" Transfer to "_$P($G(^DIC(4,+RCXTO,0)),U)_" was UNSUCCESSFUL"
 .. ;
 . D STORACT^RCDPEX31(RCXDA,RCXDA1,.RCWHY)
 ;
 I $O(RCER(0)) D
 . ; Write msgs
 . W !!,"TRANSFER OF EEOB TO "_$P($G(^DIC(4,RCXTO,0)),U)_" RESULTS: ",!
 . S RCECT=0 F  S RCECT=$O(RCER(RCECT)) Q:'RCECT  W !,"  ",RCER(RCECT)
 . W !
 ;
 D PAUSE^VALM1
 ;
XFRQ I $G(RCCHG) D BLD^RCDPEX2
 S VALMBCK="R"
 Q
 ;
SEL(RCDA,ONE) ; Select entry(s) from list
 ; RCDA = array returned if selections made
 ;    RCDA(n)=ien of bill selected file 344.4
 ; ONE = if set to 1, only one selection can be made at a time
 N RC
 K RCDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S RCDA=0 F  S RCDA=$O(VALMY(RCDA)) Q:'RCDA  S RC=$G(^TMP("RCDPEX_SUM-EOBDX",$J,RCDA)),RCDA(RCDA)=+$P(RC,U,2)_U_+$P(RC,U,3)
 Q
 ;
HDR(RCPG) ;Print report hdr
 ; RCPG = last page #
 I RCPG!($E(IOST,1,2)="C-") W @IOF,*13
 S RCPG=$G(RCPG)+1
 W !,?5,"EDI LOCKBOX EEOB DATA EXCEPTIONS - EEOB DETAIL",?55,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!,$TR($J("",IOM)," ","=")
 Q
 ;
ASK(RCSTOP) ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ; ***
 ; *** Entrypoints TXT* assume these variable definitions ***
 ; ***
 ; FUNCTIONs returns RCXM1 and RC if passed by reference
 ; RCTDA = ien, file 344.4
 ; RCXM1 = array returned with text, captioned
 ; RC = # of lines already in array (optional)
 ; RCDIQ and RCDIQ1 = arrays returned from GETS^DIQ
 ; ***
 ;
UPD ; Try to update the IB EOB file from exception in 344.41
 D UPD^RCDPEX31 ; Moved for space
 Q
 ;
