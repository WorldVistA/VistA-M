IBTRC1 ;ALB/AAS - CLAIMS TRACKING -  INSURANCE ACTIONS ACTIONS ; 14-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G EN^IBTRC
 ;
AI ; -- Add ins. Action entry
 N X,Y,I,J,DA,DR,DIC,DIE,DR,DD,DO,IBQUIT,IBTRCDT,DIR,DIRUT,DUOUT
 ;
 ; -- select date
 S DIR(0)="356.2,.01",DIR("A")="Select Insurance Review or Contact Date",DIR("B")="NOW"
 D ^DIR K DIR
 I $D(DIRUT)!($D(DUOUT))!(+Y<1) G AIQ
 S IBTRCDT=+Y
 ;
 ; -- if not tracking id allow selecting
 I '$G(IBTRN) D
 .S DIC="^IBT(356,",DIC(0)="AEQ",D="ADFN"_DFN
 .D IX^DIC K DIC
 .I +Y>1 S IBTRN=+Y
 ;
 ; -- add entry
 D COM^IBTUTL3(IBTRCDT,$G(IBTRN),"",$G(IBTRV))
 ;
 ; -- edit based on type/action
 D QE1
 D BLD^IBTRC
 S VALMBCK="R"
AIQ Q
 ;
DT ; -- Delete Insurance Action entry
 I '$D(^XUSEC("IB CLAIMS SUPERVISOR",DUZ)) D SORRY^IBTRE1 G DTQ
 N I,J,IBXX,DIR,DIRUT,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX!$D(DIRUT)  D
 .S IBTRC=$P($G(^TMP("IBTRCDX",$J,+$O(^TMP("IBTRC",$J,"IDX",IBXX,0)))),"^",2)
 .I $O(^IBT(356.2,"AP",IBTRC,0)) W !,"Must first delete appeals associated with Denials" D PAUSE^VALM1 Q
 .;
 .W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure you want to delete entry #"_IBXX
 .D ^DIR I Y'=1 W !,"Entry #",IBXX," not Deleted!" Q
 .D DP1
 .Q
DTQ D BLD^IBTRC
 S VALMBCK="R" Q
 ;
DP1 ; -- actual deletion
 N DA,DIC,DIK
 ;
 ; -- delete reviews, communications,
 S DA=IBTRC,DIK="^IBT(356.2," D ^DIK
 W !,"Entry ",IBXX," Deleted!"
 Q
 ;
QE ; -- Quick edit Review entry
 N I,J,IBXX,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBTRC=$P($G(^TMP("IBTRCDX",$J,+$O(^TMP("IBTRC",$J,"IDX",IBXX,0)))),"^",2)
 .D QE1
QEQ S VALMBCK="R"
 D BLD^IBTRC
 Q
 ;
QE1 N X,Y,DA,DR,DIC,DIE,IBSEL,IBTLST
 D EDIT^IBTRCD1("[IBT QUICK EDIT]",1)
 Q
 I $$TRTP^IBTRE1(IBTRN)<3 D  ;clinical info only on inpt/outpt
 .; -- diagnosis edit
 .D EN^IBTRE3(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- procedure edit / only inpt. / outpt use add/edit
 .I $$TRTP^IBTRE1(IBTRN)<2 D EN^IBTRE4(IBTRN) Q:$G(IBSEL)["^"
 .;
 .; -- provider edit
 .D EN^IBTRE5(IBTRN)
 Q
 ;
NX(IBTMPNM) ; -- Go to next template
 ; -- Input template name
 N I,J,IBXXC,VALMY
 S IBTSAV("IBTRN")=IBTRN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXC=0 F  S IBXXC=$O(VALMY(IBXXC)) Q:'IBXXC  D
 .S IBTRC=$P($G(^TMP("IBTRCDX",$J,+$O(^TMP("IBTRC",$J,"IDX",IBXXC,0)))),"^",2)
 .D EN^VALM(IBTMPNM)
 .K IBAMT,IBAPR,IBADG,IBDA,IBDGCR,IBDGCRU1,IBDV,IBETYP,IBETYPD,IBI,IBICD,IBLCNT,IBSEL,IBT,IBTEXT,IBTNOD,VAUTD
 .K IBAPEAL,IBCDFN,IBCNT,IBDEN,IBDENIAL,IBDENIAL,IBPARNT,IBPEN,IBPENAL,IBTCOD,IBTRDD,IBTRSV,IBTYPE,VAINDT,VA
 .D KVAR^VADPT
 .Q
 S IBTRN=$G(IBTSAV("IBTRN"))
 I '$D(IBFASTXT) D BLD^IBTRC
 S VALMBCK="R"
 Q
 ;
EDIT(IBTEMP) ; -- Edit entries
 N I,J,IBXX,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) D FULL^VALM1 S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBTRC=$P($G(^TMP("IBTRCDX",$J,+$O(^TMP("IBTRC",$J,"IDX",IBXX,0)))),"^",2)
 .W !!,"Editing Entry #",IBXX,!
 .D EDIT^IBTRCD1(IBTEMP,1)
 S VALMBCK="R"
 D BLD^IBTRC
 Q
 ;
PRECRT(IBTRN) ; -- find precert number for a tracking entry
 ; -- input ibtrn = internal entry of tracking id.
 ;
 S PRECERT=""
 I '$G(IBTRN) G PRECQ
 S PRECERT=$O(^IBT(356.2,"APRE",IBTRN,0))
PRECQ Q PRECERT
 ;
SHOWSC ; -- display sc conditions
 N VAEL,TAB,IBTRCSC
 D FULL^VALM1
 D ELIG^VADPT
 W !!,"Patient: ",$$PT^IBTUTL1(DFN)
 I 'VAEL(3) W !,"Patient Not Service Connected",!! G SHOWQ
 W !,?5,"Service Connected Percent: "_+$P(VAEL(3),"^",2)_"%"
 S TAB=5,IBTRCSC=1 D SC^IBTOAT2
SHOWQ D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
CP ; -- change patient from within insurance reviews
 N VALMQUIT,IBDFN,IBTRNOLD,IBY
 D FULL^VALM1
 S IBDFN=DFN D PAT^IBCNSM
 I $D(VALMQUIT) S DFN=IBDFN
 S IBTRNOLD=IBTRN K IBTRN
 D TRAC^IBTRV
 I '$G(IBTRN) S DFN=IBDFN,IBTRN=IBTRNOLD
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 D BLD^IBTRC,HDR^IBTRC
 S VALMBCK="R"
CPQ Q
 ;
SCREEN(ACODE,CTYPE) ; -- screen for action field of file 356.2
 ; -- called by input transform
 ;    input  ACODE = piece 3 (action code) of entry being screen in 356.7
 ;           CTYPE = type of review, pointer to 356.11
 ;
 S CTYPE=$P($G(^IBE(356.11,+CTYPE,0)),"^",2) I 'CTYPE Q 1
 Q $S(CTYPE=10:1,CTYPE=20:1,CTYPE=30:1,CTYPE=50&(ACODE<30):1,1:0)
 ;Q $S(CTYPE=1:1,CTYPE=2&(ACODE'=30):1,CTYPE=3:1,CTYPE=5&(ACODE<30):1,1:0)
