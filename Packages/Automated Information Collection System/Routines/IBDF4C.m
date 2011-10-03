IBDF4C ;ALB/DHH - CPT MODIFIER SELECTION ;26-MAY-1999
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,51**;APR 24,1997
MOD ;Entry point for selecting or modifying modifiers
 ; -- this is called by the input transform (fileman file: selection)
 ;   
 ;    slctn -- is the ien of selection file and should be cpt code
 ;    $$modp^icptmod  -- screens appropriate modifiers for a cpt code
 ;    $p($$mod^icptmod,"^",7)   -- check status of the modifier
 D
 .N DO,CPT,Y,DIC
 .Q:$G(SLCTN)=""
 .S CPT=$P(^IBE(357.3,SLCTN,0),"^")
 .Q:$G(CPT)=""
 .;;S DIC=81.3,DIC("S")="I ($$MODP^ICPTMOD(CPT,+Y,""I""))>0"
 .S DIC=81.3
 .;
 .;Is the modifier active and can it be used with this CPT code
 .S DIC("S")="I ($$MODP^ICPTMOD(CPT,+Y,""I""))>0,$P($$MOD^ICPTMOD(+Y,""I""),U,7)=1"
 .S DIC(0)="EM" D ^DIC
 .S (DIX,X)=$P(Y,"^",2)
 .I +Y<1 D
 .. D EN^DDIOL("Invalid CPT Modifier entered for CPT procedure code.")
 Q
 ;
 ;
ADD ;add cpt modifiers to the selection file
 ;
 ; -- this is to be called via IBDF4 AND IBDF4A
 ;
 ; -- check package interface file to see if CPT Modifiers are to be
 ;    asked.
 ;
 Q:$P($G(^IBE(357.6,+$P($G(^IBE(357.2,+IBLIST,0)),U,11),0)),U,21)'=1
 ;
 ; -- use fileman to allow user to add/edit modifiers
 ;    using CPT API to screen out inappropriate modifiers ( this is 
 ;    done via the input transform on the CPT MODIFIERS multiple field
 ;
 N DIE,DA,DR
 S DIE="^IBE(357.3,"
 S DA=SLCTN
 S DR="[IBDF CPT MODIFIER]"
 D ^DIE
 Q
LOOKUP ;response to ?? while entering CPT Modifiers
 ;xecutable help used this from file 357.3 cTP Modifier field
 ;
 N DO,CPT,DIC
 Q:$G(SLCTN)=""
 S CPT=$P(^IBE(357.3,SLCTN,0),"^")
 Q:$G(CPT)=""
 ;S IBDSAV=DIC
 ;;S X="??",DIC=81.3,DIC("S")="I ($$MODP^ICPTMOD(CPT,+Y,""I""))>0"
 S X="??",DIC=81.3
 ;
 ;Is the modifier active and can it be used with this CPT code
 S DIC("S")="I ($$MODP^ICPTMOD(CPT,+Y,""I""))>0,$P($$MOD^ICPTMOD(+Y,""I""),U,7)=1"
 S DIC(0)="EMQ" D ^DIC
 Q
