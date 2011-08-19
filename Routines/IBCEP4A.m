IBCEP4A ;ALB/TMP - EDI UTILITIES for provider ID ;29-SEP-00
 ;;2.0;INTEGRATED BILLING;**137,232,280,349,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEW(IB) ; Add care unit
 ; Assumes IBINS is defined as ins co ien (file 36)
 ; IB = 0 or null if called from list manager, 1 if not
 N DIC,DIR,X,Y,Z,DA,DR,DIE,DO,DD,DLAYGO,IB95,IBADD,IBOK
 I '$G(IB) D FULL^VALM1
 ;
 ; Add an entry - either new care unit/ins co or a combination for
 ;  existing care unit/ins co
 S DIC("A")="SELECT CARE UNIT FOR THE INSURANCE CO: ",DIC="^IBA(355.95,",DIC("S")="I $P(^(0),U,3)=+$G(IBINS)",DIC(0)="AELMQ",DIC("DR")=".03////"_+$G(IBINS)_";.02",DLAYGO=355.95 D ^DIC K DIC,DLAYGO
 G:Y'>0 NEWQ
 S IB95=3,IB95("IBCU")=+Y
 D INSASS(IBINS,.IB95)
 I '$G(IB) D BLD^IBCEP4
NEWQ I '$G(IB) S VALMBCK="R"
 Q
 ;
CHANGE(IB) ; Edit a care unit name or combination for ins co IBINS
 ; Assumes IBINS is defined as ins co ien (file 36)
 ; IB = 0 or null if called from list manager, 1 if not
 N DIC,DIK,DIR,X,Y,Z,DA,DR,DIE,DO,DD,DLAYGO,IB95,IBOK,IBZ,IB0,IBEDIT,IBCK,IBDA,IBCHG,IBDELETE,Z100,DTOUT,DUOUT
 I '$G(IB) D FULL^VALM1 S Y=$$SEL()
 I $G(IB) S DIC("A")="CARE UNIT NAME: ",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=+$G(IBINS)",DIC="^IBA(355.95," W ! D ^DIC K DIC
 I Y'>0 G CHGQ
 S IB95("IBCU")=+Y,IBDELETE=0,IBDELETE(0)=$G(^IBA(355.95,0)),IBDELETE(1)=$G(^(1))
 ; Edit fields outside of FM to assure uniqueness of combos is maintained
 W ! S DIR("A")="CARE UNIT NAME: ",DIR("B")=$P($G(^IBA(355.95,+IB95("IBCU"),0)),U),DIR(0)="355.95,.01AO",DIR("S")="I $P(^(0),U,3)=IBINS" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G CHGQ
 I X="@" S DIR(0)="EA",DIR("A")="NOTHING DELETED - PRESS ENTER TO CONTINUE" D ^DIR K DIR G CHGQ
 I $P($G(^IBA(355.95,IB95("IBCU"),0)),U)'=Y S DIE="^IBA(355.95,",DR=".01///"_Y,DA=IB95("IBCU") D ^DIE ; File the name change
 S DR=".02",DIE="^IBA(355.95,",DA=IB95("IBCU") D ^DIE
 I $D(Y) G CHGQ
 ;
 I $O(^IBA(355.96,"ACARE",IB95("IBCU"),""))="" S IB95=3 D INSASS(IBINS,.IB95) G CHGQ
 ; only 1 combination found for ins/care unit
 I $O(^IBA(355.96,"ACARE",IB95("IBCU"),""),-1)=$O(^IBA(355.96,"ACARE",IB95("IBCU"),0)) D
 . S IBDA=$O(^IBA(355.96,"ACARE",IB95("IBCU"),0))
 ;
 ; Choose the combination to edit - more than 1 exists
 E  D
 . W !,"SELECT ONE OF THE FOLLOWING CARE UNIT COMBINATIONS:"
 . S DIC="^IBA(355.96,",DIC(0)="EMQ",DIC("S")="I $D(^IBA(355.96,""ACARE"","_IB95("IBCU")_",Y))",X=IBINS D ^DIC K DIC S IBDA=+Y
 ;
 I IBDA>0 D
 . N IBDA0,Q,Q0
 . S IBDA0=$G(^IBA(355.96,IBDA,0))
 . Q:IBDA0=""
 . W !!,"*** CARE UNIT COMBINATION FOR: ",$P($G(^IBA(355.95,+IB95("IBCU"),0)),U)," ***"
 . D DISP^IBCEP4("Q",IBINS,$P(IBDA0,U,6),$P(IBDA0,U,4),$P(IBDA0,U,5),1,.Q0)
 . S Z=0 F  S Z=$O(Q(Z)) Q:'Z  W !,Q(Z)
 . I $P(IBDA0,U,7) W !,"EXP DATE: ",$$FMTE^XLFDT($P(IBDA0,U,7),"2D")
 . W !,"CARE UNIT: ",$P($G(^IBA(355.95,+IBDA0,0)),U),!
 . W ! S DIR(0)="SA^E:EDIT;D:DELETE",DIR("B")="EDIT",DIR("A")="EDIT OR DELETE THIS CARE UNIT COMBINATION?: " D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) Q
 . I Y="D" D  Q
 .. S DIR(0)="YA",DIR("A")="ARE YOU SURE YOU WANT TO DELETE THIS CARE UNIT COMBINATION?: ",DIR("B")="NO" D ^DIR K DIR
 .. I Y=1 S DIK="^IBA(355.96,",DA=IBDA,IBCHG=1 D ^DIK
 . S (IBCK,IBCHG)=0,(IBEDIT,IBOK)=1
 . F  Q:'IBEDIT  S IBEDIT=0,IB0=$G(^IBA(355.96,+IBDA,0)) K IBZ F Z=.01,.03,.06,.04,.05 D  Q:'IBOK!IBEDIT
 .. S Z100=Z*100
 .. I Z100=1 W !,"CARE UNIT: ",$P($G(^IBA(355.95,IB95("IBCU"),0)),U) S IBZ(.01)=$P(IB0,U) Q
 .. I Z100=3 W !,"INSURANCE COMPANY: ",$$EXPAND^IBTRE(355.96,.03,$P(IB0,U,3)) S IBZ(.03)=$P(IB0,U) Q
 .. I Z100=5 S IBCK=1
 .. S IBZ(Z)=$$EDIT(Z,IB0,+IBDA,IBCK),IBCK=0
 .. I '$P(IBZ(Z),U,2) D  Q
 ... I $P(IB0,U,Z100)'=IBZ(Z) S IBCHG=1
 ... S $P(IB0,U,Z100)=IBZ(Z)
 .. S (IBOK,IBCHG)=0
 .. I $P(IBZ(Z),U,2)=2 D
 ... S DIR(0)="YA",DIR("A",1)="This entry already exists",DIR("A")="Do you want to re-edit?: " W ! D ^DIR K DIR W !
 ... I Y=1 S (IBOK,IBEDIT)=1
 . I IBOK Q:'IBCHG  S DIE="^IBA(355.96,",DR=".03////"_IBZ(.03)_";.04////"_IBZ(.04)_";.05////"_IBZ(.05)_";.06////"_IBZ(.06)_";.07",DA=+IBDA D ^DIE,BLD^IBCEP4 Q
 ;
 I '$G(IB) D BLD^IBCEP4
CHGQ I '$G(IB) S VALMBCK="R"
 Q
 ;
INSASS(IBINSZ,IB95) ; Assign care unit to or delete from an ins co
 ; IBINSZ = ien of ins co (file 36)
 ; IB95 = flag  ("IBCU")=care unit
 ;     can have subscripts to send in pre-entered data
 N DIR,DIC,DA,DR,X,Y,Z,IBFT,IBCT,IBPTYP,IBCU,IBCHG,IBINS,IBDA,IBPXDT,IBDICS
 S IBINS=IBINSZ
 S IBCHG=0,IBCU=$G(IB95("IBCU"))
 D FULL^VALM1
 I '$G(IBINSZ) K IB95 G INSQ
 W !
 F Z=.06,.04,.05,.07,.03 D  G:Z="" INSQ
 . ;
 . I $S(Z=.04:'$D(IB95("IBFT")),Z=.05:'$D(IB95("IBCT")),Z=.06:'$D(IB95("IBPTYP")),Z=.03:'$D(IB95("IBCU")),1:1) D
 .. N DA
 .. K IBDICS
 .. I Z=.04 D
 ... I $P($G(^IBE(355.97,+$G(IB95("IBPTYP")),0)),U,3)="1A" S IBDICS="I Y'=1 K X",DIR("B")="UB-04",DIR("?")="ONLY UB-04 IS VALID FOR A BLUE CROSS ID"
 .. S DIR(0)="355.96,"_Z_$S($G(IBDICS)="":"",1:"^^"_IBDICS) D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S VALMBCK="R",Z="" K:$G(IB95)=2 IB95 Q
 . ;
 . I Z=.04 S IBFT=$S($G(IB95("IBFT"))="":+Y,1:IB95("IBFT")) S IB95("IBFT")=IBFT Q
 . ;
 . I Z=.05 S IBCT=$S($G(IB95("IBCT"))="":+Y,1:IB95("IBCT")) S IB95("IBCT")=IBCT Q
 . ;
 . I Z=.06 S IBPTYP=$S($G(IB95("IBPTYP"))="":+Y,1:IB95("IBPTYP")) S IB95("IBPTYP")=IBPTYP Q
 . ;
 . I Z=.07 S IBPXDT=$S('$G(IB95("IBEXPDT")):+Y,1:IB95("IBEXPDT")) S IB95("IBEXPDT")=IBPXDT Q
 . ;
 . I Z=.03,$G(IB95)=3,$G(IB95("IBCU"))'="" D  Q:Z=""
 .. N Q  ; Assign from add care type
 .. S IBCT=0
 .. W !,"CARE UNIT: "_$$EXPAND^IBTRE(355.96,.01,IB95("IBCU"))
 .. S IB95("IBINS")=+IBINSZ
 .. I $D(^IBA(355.96,"AUNIQ",IBINSZ,IB95("IBCU"),IB95("IBFT"),IB95("IBCT"),IB95("IBPTYP"))) D  Q
 ... S DIR(0)="EA",DIR("A",1)="This combination already exists - NOT ADDED",DIR("A")="Press ENTER to continue" W ! D ^DIR K DIR W !
 .. S IBCT=1 S Y=$$ADDCU(IBINSZ,IB95("IBCU"),IB95("IBFT"),IB95("IBCT"),IB95("IBPTYP"))
 .. I Y<0 W ! S DIR("A",1)="  >> Care Unit NOT completely filed",DIR("A")="PRESS ENTER TO CONTINUE ",DIR(0)="EA" D ^DIR K DIR Q
 .. W ! S DIR(0)="EA",DIR("A",1)="  >> CARE UNIT COMBINATION FILED FOR THE INSURANCE CO",IBCT=1,IBCHG=1,DIR("A")="PRESS ENTER TO CONTINUE ",DIR(0)="EA" D ^DIR K DIR
 I $G(IBCHG) D BLD^IBCEP4
INSQ S VALMBCK="R"
 Q
 ;
EDIT(IBFLD,IB0,IBIEN,IBCK1) ; Allow addition/edit of fields in file 355.96
 ; without direct Fileman call so uniqueness can be checked
 ; IBFLD = field # in file 355.96
 ; IB0 = current 0-node of data in the entry in file 355.96
 ; IBIEN = ien of entry being edited in file 355.96
 ; IBCK1 = flag ... if 1, checks for uniqueness after field changed
 ;
 ; FUNCTION RETURNS: value of field if field is OK, second piece is null
 ;                   If not good, 2nd piece = 1 : no data or ^ entered
 ;                                          = 2 : record not unique
 N DIR,DA,Y,X,IBNEW,IBINS,IBVAL
 S IBINS=+IB0,IBNEW="",IBVAL=$$EXPAND^IBTRE(355.96,IBFLD,$P(IB0,U,(IBFLD*100)))
 S DIR(0)="355.96,"_IBFLD
 S:IBVAL'="" DIR("B")=IBVAL
 D ^DIR K DIR
 I Y=""!$D(DTOUT)!$D(DUOUT) S IBNEW="^1" G EDITQ
 S IBNEW=$P(Y,U)
 I $G(IBCK1) D
 . N X1,X2,X3,X4,X5
 . S X1=$S(IBFLD'=.03:IBINS,1:IBNEW),X2=$S(IBFLD'=.01:$P(IB0,U),1:IBNEW),X3=$S(IBFLD'=.04:$P(IB0,U,4),1:IBNEW),X4=$S(IBFLD'=.05:$P(IB0,U,5),1:IBNEW),X5=$S(IBFLD'=.06:$P(IB0,U,6),1:IBNEW)
 . I $S(X1=""!(X2="")!(X3="")!(X4="")!(X5=""):1,$O(^IBA(355.96,"AUNIQ",X1,X2,X3,X4,X5,0)):$O(^(0))'=IBIEN,1:0) S IBNEW=IBNEW_"^2"
 ;
EDITQ Q IBNEW
 ;
ADDCU(IBINSZ,IBCU,IBFT,IBCT,IBPTYP) ;  Add a new care unit record to file 355.96
 ; Same parameter definitions as EDIT
 N DIC,DA,X,Y,DLAYGO
 S DIC(0)="L",DLAYGO=355.96,DIC="^IBA(355.96,",DIC("DR")=".03////"_IBINSZ_";.04////"_IBFT_";.05////"_IBCT_";.06////"_IBPTYP,X=IBCU
 D FILE^DICN
 Q Y
 ;
DELETE(IB) ; delete a care unit name
 ; IB = 0 or null if called from list manager, 1 if not
 N DIR,X,Y
 I '$G(IB) D FULL^VALM1 S Y=$$SEL() I Y'>0 G DELETEQ
 S:'$G(IB) IB95("IBCU")=+Y
 S DIR("A",1)="THIS WILL DELETE THE CARE UNIT NAME AND ALL ITS COMBINATIONS",DIR("A")="ARE YOU SURE THIS IS WHAT YOU WANT TO DO?: ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR
 I Y'=1 S IB95("IBCU")="" Q  ; Changed their mind - don't delete
 S Z=0 F  S Z=$O(^IBA(355.96,"B",IB95("IBCU"),Z)) Q:'Z  S DIK="^IBA(355.96,",DA=Z D ^DIK
 S DA=IB95("IBCU"),DIK="^IBA(355.95," D ^DIK
 W ! S DIR(0)="EA",DIR("A",1)="CARE UNIT AND ALL ITS COMBINATIONS WERE DELETED",DIR("A")="PRESS ENTER TO CONTINUE " D ^DIR K DIR D BLD^IBCEP4
DELETEQ ;
 S:'$G(IB) VALMBCK="R"
 Q
 ;
SEL() ; Select entry from list
 ; returns ien in file 355.95 for selected entry
 N VALMY,SEL
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=+$O(VALMY(""))
 I SEL'>0 Q 0
 Q +$G(^TMP("IBPRV_CU",$J,"ZIDX",SEL))
 ;
