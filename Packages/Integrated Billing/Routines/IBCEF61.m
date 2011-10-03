IBCEF61 ;ALB/TMP - EDI TRANSMISSION RULES DEFINITION ;28-APR-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
SELRULE(IBRULE) ; Select rule
 D FULL^VALM1
 S IBRULE=""
 N IBR,IB
 D EN^VALM2($G(XQORNOD(0)),"S")
 S IBR=0 F  S IBR=$O(VALMY(IBR)) Q:'IBR  S IB=$G(^TMP("IBCE-RULEDX",$J,IBR)),IBRULE=+$P(IB,U,2)
 Q
 ;
ACTIVE(IBRULE) ; Edit rules' active/inactive dates
 ; IBRULE = ien of rule in file 364.4
 ;
 G:'$G(IBRULE) ACTQ
 N DA,DR,DIE,X,Y,Z,Z0
 S DA=$G(IBRULE),DIE="^IBE(364.4,"
 S DR=".02;.06"
 D ^DIE
 I $D(Y) S IBRULE=0 G ACTQ
 D REBLD^IBCEF6($G(IBACTIVE))
ACTQ S VALMBCK="R"
 Q
 ;
SCRACT ; Rebld display - only currently active
 S IBACTIVE=1
 D REBLD^IBCEF6(1)
 S VALMBCK="R"
 Q
 ;
NOSCR ; Rebld display - inactive and currently active
 S IBACTIVE=0
 D REBLD^IBCEF6(0)
 S VALMBCK="R"
 Q
 ;
BILTYP(IBRULE) ; Allow to edit bill types for rule
 ; IBRULE = ien of rule - file 364.4
 ;
 G:'$G(IBRULE) BILTYPQ
 N DA,DR,DIE,X,Y,Z,Z0,IBRT,IB,IBOK,IBCT
 S DA=$G(IBRULE),DIE="^IBE(364.4,",IBRT=$P($G(^IBE(364.4,IBRULE,0)),U,11)
 I $S(IBRT=9:0,1:IBRT'=1) D  G BILTYPQ
 . W !
 . S DIR(0)="EA",DIR("A",1)="RULE TYPE '"_$$EXPAND^IBTRE(364.4,.11,IBRT)_"' DOES NOT ALLOW BILL TYPE RESTRICTIONS",DIR("A")="PRESS RETURN " D ^DIR K DIR W !
 S (IBO,IBCT)=0 ;Extract existing entries
 F  S IBO=$O(^IBE(364.4,IBRULE,"BTYP",IBO)) Q:'IBO  S IBX=$P($G(^(IBO,0)),U),IBO(IBX)=IBO_U_$P(^(0),U,2,3),IBCT=IBCT+1,IB(364.41,IBCT,.01)=IBX,IBI(IBX)=IBCT F Z=2,3 I $P(IBO(IBX),U,Z)'="" S IB(364.41,IBCT,Z/100)=$P(IBO(IBX),U,Z)
 ; Display entries, allow to add/edit/delete
 D EN^IBCEF62
BILTYPQ S VALMBCK="R"
 Q
 ;
SEL(VALMY) ; Select one or more bill type restriction entries
 ; VALMY = passed by reference and returned subscripted by
 ; entry #(s) in the LM array selected
 ;
 N Z
 D FULL^VALM1
 N IBR
 D EN^VALM2($G(XQORNOD(0)))
 Q
 ;
BTEDIT(IBRULE) ; Edit bill type restriction dates
 ; IBRULE = ien of the bill type restriction being edited
 ;      (0)= ien of the RULE - file 364.4
 G:'$G(IBRULE) BTEQ
 ;
 N DA,DIE,DR,Y,X,VALMY,Z,IBBT
 ;
 S IBCT=0
 D SEL(.VALMY)
 G:'$O(VALMY(0)) BTEQ ; None selected
 ;
 S Z=0 F  S Z=$O(VALMY(Z)) Q:'Z  S IBBT=+$G(^TMP("IBCE-BTDX",$J,Z)) I IBBT D
 . S DA(1)=IBRULE,DA=IBBT,DIE="^IBE(364.4,"_DA(1)_",""BTYP"",",DR=".02;.03"
 . W !!,"Bill Type Restriction #"_Z_" - "_$E($G(^TMP("IBCE-BT",$J,Z,0)),5,50),!
 . D ^DIE
 . D REBLD^IBCEF62
 ;
BTEQ S VALMBCK="R"
 Q
 ;
BTADD(IBRULE) ; Add new bill type restrictions
 ; IBRULE = ien of rule entry - file 364.4
 N IB,IBCT,Z,IBOK
 D FULL^VALM1
 G:'$G(IBRULE) BTAQ
 ;
 S (IBCT,Z)=0
 S Z=0 F  S Z=$O(^IBE(364.4,IBRULE,"BTYP",Z)) Q:'Z  S IBCT=IBCT+1,IB(364.41,IBCT,.01)=$P($G(^(Z,0)),U)
 ;
 D BTYP^IBCEF51(.IB,.IBOK,0)
 ;
 I IBOK D
 . N Z
 . S Z=0 F  S Z=$O(^IBE(364.4,IBRULE,"BTYP",Z)) Q:'Z  S DA=Z,DA(1)=IBRULE,DIK="^IBE(364.4,"_DA(1)_",""BTYP""," D ^DIK
 . D ADDBTYP(.IB,IBRULE)
 . D REBLD^IBCEF62
 D SUCCESS(IBOK)
 ;
BTAQ S VALMBCK="R"
 Q
 ;
INSCO(IBRULE) ; Allow user to edit rule's ins co data
 ; IBRULE = ien of rule - file 364.4
 ;
 G:'$G(IBRULE) INSCOQ
 N DA,DR,DIE,X,Y,Z,Z0,IB,IB0
 S DA=$G(IBRULE),DIE="^IBE(364.4,"
 S IB0=$G(^IBE(364.4,IBRULE,0)),IB(".07O")=$P(IB0,U,7)
 S DR=$S($P(IB0,U,3)'=2:".07;S Y=$S(X=1:""@10"",X=2:""@20"",1:""@99"");",1:"")_"@10;3;S Y=""@99"";@20;2;S Y=""@99"";@99"
 D ^DIE
 S IB(.07)=$P($G(^IBE(364.4,IBRULE,0)),U,7)
 ;
 I IB(".07O"),IB(".07O")'=IB(.07),IB(".07O")'=3 D  ; Delete 'old' includes/excludes
 . S Z=$P("3^2",U,+IB(".07O")),Z0=0 F  S Z0=$O(^IBE(364.4,IBRULE,Z,Z0)) Q:'Z0  S DA=Z0,DA(1)=IBRULE,DIK="^IBE(364.4,"_DA(1)_","_Z_"," D ^DIK
 ;
 ; If all ins cos selected, delete existing specific ones in/excluded
 I 'IB(.07)!(IB(.07)=3) D
 . Q:IB(".07O")=IB(.07)
 . F Z=2,3 I $O(^IBE(364.4,IBRULE,Z,0)) S Z0=0 F  S Z0=$O(^IBE(364.4,IBRULE,Z,Z0)) Q:'Z0  S DA=Z0,DA(1)=IBRULE,DIK="^IBE(364.4,"_DA(1)_","_Z_"," D ^DIK
 E  D
 . Q:$O(^IBE(364.4,IBRULE,$S(IB(.07)=1:3,1:2),0))
 . W !,"Warning ... no insurance companies chosen to "_$S(IB(.07)=1:"in",1:"ex")_"clude"
 . D QUIT^IBCEF5
 D REBLD^IBCEF6($G(IBACTIVE))
 ;
INSCOQ S VALMBCK="R"
 Q
 ;
MISC(IBRULE) ; Edit other misc fields for the rule
 ; IBRULE = ien of rule - file 364.4
 ;
 I $G(IBRULE) D
 . N DA,DR,DIE,X,Y,Z,Z0
 . S DA=$G(IBRULE),DIE="^IBE(364.4,"
 . S DR=".08;1;4"
 . D ^DIE
 . D REBLD^IBCEF6($G(IBACTIVE))
 S VALMBCK="R"
 Q
 ;
DISPRUL(IBRULE) ; Display rule selected
 ; IBRULE = ien of rule - file 364.4
 ;
 I '$G(IBRULE) D FULL^VALM1
 N DIOBEG,FR,TO,BY,DIC,DA,L,FLDS,DHD
 S (FR,TO)=$G(IBRULE),DHD="[IBCE RULE DISPLAY HEADER]"
 S L=0,BY="@RULE NUMBER",DIC="^IBE(364.4,",FLDS="[IBCE RULE DISPLAY]"
 S DIOBEG="W !"
 W !!
 D EN1^DIP
DISPRQ S VALMBCK="R"
 D PAUSE^VALM1
 Q
 ;
SUCCESS(IBOK) ; Display msg after add rule
 ; IBOK = 1 if successful, 0 if not
 ;
 N DIR,Y,X
 S DIR(0)="EA"
 W !
 I $G(IBOK) S DIR("A",1)="TRANSMISSION RULE(s) HAVE BEEN SUCCESSFULLY FILED"
 I '$G(IBOK) S DIR("A",1)="NO TRANSMISSION RULES ADDED"
 S DIR("A")="PRESS RETURN " D ^DIR K DIR
 S VALMBCK="R"
 Q
 ;
ADDBTYP(IB,IBDA1) ; Add bill types in IB(364.41) to rule IBDA1
 ;
 N Z,Z0,IBC
 I $D(IB(364.41)) D
 . S IBC=0 F  S IBC=$O(IB(364.41,IBC)) Q:'IBC  D
 .. N DO,DD,DIC,DLAYGO,DA,X,Y
 .. S Z=.01 F  S Z=$O(IB(364.41,IBC,Z)) Q:'Z  S Z0=$G(IB(364.41,IBC,Z)) I Z0'="" D  ;Bill type excepts
 ... S DIC("DR")=$G(DIC("DR"))_$S($G(DIC("DR"))="":"",1:";")_Z_"///"_Z0
 .. I '$D(^IBE(364.4,IBDA1,"BTYP",0)) S DIC("P")=$$GETSPEC^IBEFUNC(364.4,.1)
 .. S X=IB(364.41,IBC,.01)
 .. S DA(1)=IBDA1,DIC="^IBE(364.4,"_IBDA1_",""BTYP"",",DIC(0)="L",DLAYGO=364.4
 .. D FILE^DICN
 Q
 ;
INSADD(IB,IBDA1) ; Add ins co exceptions from entries in
 ; IB(364.42 - exclude) or IB(364.43 - include) to rule IBDA1
 ;
 N Z,IBNODE,Z0
 F Z=364.42,364.43 S IBNODE=$E(Z,$L(Z)),Z0=0 F  S Z0=$O(IB(Z,Z0)) Q:'Z0  D
 . N DO,DD,DIC,DLAYGO,DA
 . I '$D(^IBE(364.4,IBDA1,IBNODE,0)) S DIC("P")=$$GETSPEC^IBEFUNC(364.4,IBNODE)
 . S DA(1)=IBDA1,DIC="^IBE(364.4,"_IBDA1_","_IBNODE_",",DIC(0)="L",DLAYGO=364.4,X=Z0
 . D FILE^DICN K DIC
 Q
 ;
BTDTOK(IBRULE,IBBT,IBDTYP,X) ; Check bill type date is consistent for rule
 ; IBRULE = ien of rule - file 364.4
 ; IBBT = ien of bill type in rule IBRULE (optional if check at top level)
 ; IBDTYP = 1 for active date check, 2 for inactive date check
 ; X = Value of date being validated
 ;
 ; Function returns 1 if consistencies are OK, 0 if not
 ;
 N IBOK,IBPCK,Z
 S IBOK=1
 S IBPCK=$S(IBDTYP=1:2,1:6)
 ;
 ; Check for consistency at rule level first
 ;
 ; Active dt must not be after rule's inact dt
 I IBDTYP=1,$P($G(^IBE(364.4,IBRULE,0)),U,6),X>$P(^(0),U,6) S Z=$$FMTE^XLFDT($P($G(^IBE(364.4,IBRULE,0)),U,6)) D EN^DDIOL("CANNOT BE AFTER RULE'S INACTIVE DATE OF "_$S('Z:"<MISSING>",1:Z),,"!!") S IBOK=0 G BTDTQ
 ;
 ; Inact dt must not be prior to rule's active dt
 I IBDTYP=2,$S('$P($G(^IBE(364.4,IBRULE,0)),U,2):'$G(IBBT),1:X<$P($G(^(0)),U,2)) S Z=$$FMTE^XLFDT($P($G(^IBE(364.4,IBRULE,0)),U,2)) D EN^DDIOL("CANNOT BE BEFORE RULE'S ACTIVE DATE OF "_$S('Z:"<MISSING>",1:Z),,"!!") S IBOK=0 G BTDTQ
 ;
 I $G(IBBT) D  ; Check for consistency at the bill type level
 . ; Active dt at bt level must be prior to inactive dt
 . I IBDTYP=1,$P($G(^IBE(364.4,IBRULE,"IBTYP",IBBT,0)),U,3),X>$P(^(0),U,3) S Z=$$FMTE^XLFDT($P(^IBE(364.4,IBRULE,"IBTYP",IBBT,0),U,3)) D EN^DDIOL("MUST BE PRIOR TO BILL TYPE'S INACTIVE DATE OF "_$S('Z:"<MISSING>",1:Z),,"!!") S IBOK=0 Q
 . ; Inactive dt at bt level must be after active dt
 . I IBDTYP=2,$S('$P($G(^IBE(364.4,IBRULE,"IBTYP",IBBT,0)),U,2):1,1:X<$P(^(0),U,2)) S Z=$$FMTE^XLFDT($P($G(^IBE(364.4,IBRULE,"IBTYP",IBBT,0)),U,2)) D EN^DDIOL("MUST BE AFTER BILL TYPE'S ACTIVE DATE OF "_$S('Z:"<MISSING>",1:Z),,"!!") S IBOK=0 Q
 . ;
 . S Z=0
 . F  S Z=$O(^IBE(364.4,IBRULE,"BTYP",Z)) Q:'Z  S Z0=$G(^(Z,0))  D  Q:'IBOK
 .. I $P(Z0,U,IBDTYP+1),$S(IBDTYP=1:X<$P(Z0,U,2),1:X>$P(Z0,U,3)) D EN^DDIOL("CHANGE WOULD INVALIDATE BILL TYPE RESTRICTION DATE",,"!!") S IBOK=0
BTDTQ Q IBOK
 ;
