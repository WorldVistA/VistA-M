TIURD1 ; SLC/JER - Reassign actions ;4/18/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**1,7,61,113**;Jun 20, 1997
MOVEADD(TIUDA) ; Move an addendum to another document
 N DFN,TIUDAT,TIUSCRN,TIUMOVE,TIUTYP,TIUODA
 S TIUTYP=$$CLINDOC^TIULC1(+$G(^TIU(8925,+$P($G(^TIU(8925,+TIUDA,0)),U,6),0)))
 I +TIUTYP'>0 S TIUTYP=38
 S TIUTYP(1)="1^"_TIUTYP_U_$P(^TIU(8925.1,+TIUTYP,0),U)
 S DFN=+$$PATIENT^TIULA
 I +DFN'>0 D  Q
 . W !!,"No PATIENT Selected: Aborting Transaction, No Harm Done...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . S TIUOUT=1
 ; --- If moving to different pt, keep retracted original ---
 I +$G(DFN)'=$P(TIUD0(0),U,2),(+$P(TIUD0(0),U,5)>5) D
 . W !,"Moving signed document to another Patient...A RETRACTED copy will be retained."
 . S TIUODA=TIUDA,TIUDA=+$$RETRACT^TIURD2(TIUDA)
 Q:+TIUDA'>0
 D SELPAT^TIULA2(.TIUDAT,TIUTYP,DFN)
 I +$G(TIUDAT)'>0,($D(TIUDAT)'>9) S TIUOUT=1 G ABORT
 S TIUDAT=+$G(TIUDAT(1))
 I +$$ISADDNDM^TIULC1(TIUDAT) D  G ABORT
 . W !!,$C(7),"You may not assign an addendum to an addendum...",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 . S TIUOUT=1
 D FROMTO^TIURD4(TIUDA,TIUDAT)
 I +$G(TIUDAT)>0,$$READ^TIUU("YO","Is this Correct","YES") D  Q
 . N TIUDD0,TIUDD12,TIUDD14
 . S TIUDD0=$G(^TIU(8925,+TIUDAT,0)),TIUDD12=$G(^(12)),TIUDD14=$G(^(14))
 . S DR=".02////"_$P(TIUDD0,U,2)_";.03////"_$P(TIUDD0,U,3)_";.06////"_+TIUDAT_";.07////"_$P(TIUDD0,U,7)_";.08////"_$S(+$P(TIUDD0,U,8):$P(TIUDD0,U,8),1:"@")_";.13////"_$P(TIUDD0,U,13)
 . S DR=DR_";1401////"_$P(TIUDD14,U)_";1402////"_$P(TIUDD14,U,2)_";1404////"_$P(TIUDD14,U,4)_";1205////"_$P(TIUDD12,U,5)_";1211////"_$P(TIUDD12,U,11)_";1212////"_$P(TIUDD12,U,12)
 . S DIE=8925,DA=+TIUDA D ^DIE
 . K DR N TIUTYP
 . S DR=".05///"_$$STATUS^TIULC(+TIUDA) D ^DIE
 . S TIUD0(1)=$G(^TIU(8925,TIUDA,0)),TIUD12(1)=$G(^(12))
 . D AUDREASS^TIURB1(TIUDA,.TIUD0,.TIUD12)
 . I +$G(TIUODA) D AUDREASS^TIURB1(TIUODA,.TIUD0,.TIUD12)
 . D SEND^TIUALRT(TIUDA)
 . W "." S TIUCHNG=1
ABORT ; Recover on abort
 W !!,"Okay...No Harm done!"
 I +$G(TIUODA),+$G(TIUDA),$D(TIUD0(0)) D RECOVER^TIURD4(TIUODA,TIUDA,.TIUD0)
 S TIUCHNG=0
 Q
PROMOTE(TIUDA) ; Promote addendum
 N DA,DR,DIE,TIUADD0,TIUTYPE,TIUPTYPE,TIUOUT,TIUVTYPE,TIUODA
 S TIUADD0=$G(^TIU(8925,+TIUDA,0))
 S TIUTYPE=+$G(^TIU(8925,+$P(TIUADD0,U,6),0)),TIUPTYPE=$P($G(^(0)),U,4),TIUVTYPE=$P($G(^(0)),U,13)
 S DR=".01////"_TIUTYPE_";.04////"_TIUPTYPE_";.06///@;.13////"_TIUVTYPE
 S DA=+TIUDA,DIE=8925
 D ^DIE K DA,DR,DIE
 D REASSIGO^TIURD3
 I +$G(TIUOUT)>0 D  Q
 . N DIE,DA,DR
 . I +$G(TIUODA),+$G(TIUDA),$D(TIUD0(0)) D RECOVER^TIURD4(TIUODA,TIUDA,.TIUD0)
 . W !!,"Restoring Addendum to original state..."
 . S DIE=8925,DA=$S(+$G(TIUODA):TIUODA,1:TIUDA)
 . S DR=".01////^S X=+TIUADD0;.04////^S X=$P(TIUADD0,U,4);.06////^S X=$P(TIUADD0,U,6)"
 . S DR=DR_";.07////^S X=$P(TIUADD0,U,7);.08////^S X=$S(+$P(TIUADD0,U,8):+$P(TIUADD0,U,8),1:""@"")"
 . D ^DIE
 ; If promotion successful & addendum retracted, reset 0-node of retracted record
 I +$G(TIUODA) D
 . N DIE,DA,DR
 . S DIE=8925,DA=TIUODA
 . S DR=".01////^S X=+TIUADD0;.04////^S X=$P(TIUADD0,U,4);.06////^S X=$P(TIUADD0,U,6)"
 . D ^DIE
 D SEND^TIUALRT(TIUDA)
 W !!,"ADDENDUM Promoted to be an ORIGINAL ",$$PNAME^TIULC1(TIUTYPE) H 2
 S TIUCHNG=1,VALMBCK="Q"
 Q
REPLACE(TIUDA) ; Replace original with addendum
 N TIUODA,TIUCONT,TIUOS,TIUAS,TIUOODA,TIUOD0
 W !!,$C(7),"This is an IRREVERSIBLE action..."
 S TIUCONT=$$READ^TIUU("YA","Are you SURE you wish to continue? ","NO")
 I '+TIUCONT S TIUCHNG=0 W !,"No changes made." Q
 W !,"Okay, here we go then..."
 S TIUODA=+$P(^TIU(8925,TIUDA,0),U,6) Q:+TIUODA'>0
 S TIUOD0=$G(^TIU(8925,TIUODA,0))
 I +$P(TIUOD0,U,5)>5 D
 . W !!,"A RETRACTED copy of the signed ORIGINAL will be retained.",!
 . S TIUOODA=TIUODA,TIUODA=$$RETRACT^TIURD2(TIUODA,"",+$P(TIUOD0,U,5),"",1)
 ; Load Signature
 D LOADSB^TIURD4(TIUODA,TIUDA,.TIUOS,.TIUAS)
 ; Move non-WP flds from add to orig
 D SWAPFLDS(TIUODA,TIUDA,0)
 ; Move original into ^TIU(8925,+TIUODA,"TEMP")
 D BUFFER^TIUEDIU(TIUODA) W "."
 ; Replace ^TIU(8925,+TIUODA,"TEMP") w ^TIU(8925,+TIUDA,"TEXT")
 K ^TIU(8925,+TIUODA,"TEMP")
 M ^TIU(8925,+TIUODA,"TEMP")=^TIU(8925,+TIUDA,"TEXT") W "."
 ; File changes
 K ^TIU(8925,+TIUODA,"TEXT")
 D MERGTEXT^TIUEDI1(TIUODA) W "."
 K ^TIU(8925,+TIUODA,"TEMP")
 ; Swap signatures
 D SWAPSB^TIURD4(TIUODA,TIUDA,.TIUOS,.TIUAS)
 ; Update status of new original
 D UPDSTAT^TIURD4(TIUODA)
 ; Resend alerts
 D SEND^TIUALRT(TIUODA)
 ; Delete Addendum Record
 D DELETE^TIUEDIT(TIUDA,0,"",1) W "...Done."
 S TIUCHNG=2 S:+$G(TIUOODA) TIUCHNG=TIUCHNG_U_TIUODA
 Q
SWAPADD(TIUDA) ; Swap addendum with original
 N TIUODA,TIUCONT K ^TMP("TIUSWAP",$J)
 N TIUOS,TIUAS
 W !!,$C(7),"Don't worry...This is a REVERSIBLE action."
 S TIUCONT=$$READ^TIUU("YA","Even so, are you SURE you wish to continue? ","NO")
 I '+TIUCONT S TIUCHNG=0 W !,"No changes made." Q
 W !,"Okay, you can always swap 'em back"
 S TIUODA=+$P(^TIU(8925,TIUDA,0),U,6) Q:+TIUODA'>0
 D LOADSB^TIURD4(TIUODA,TIUDA,.TIUOS,.TIUAS)
 ; Swap the non-WP flds
 D SWAPFLDS(TIUODA,TIUDA,1)
 ; Move original into ^TIU(8925,+TIUODA,"TEMP")
 D BUFFER^TIUEDIU(TIUODA) W "."
 ; Move ^TIU(8925,+TIUODA,"TEMP") into ^TMP("TIUSWAP",$J)
 M ^TMP("TIUSWAP",$J)=^TIU(8925,+TIUODA,"TEMP") W "."
 ; Replace ^TIU(8925,+TIUODA,"TEMP") with ^TIU(8925,+TIUDA,"TEXT")
 K ^TIU(8925,+TIUODA,"TEMP")
 M ^TIU(8925,+TIUODA,"TEMP")=^TIU(8925,+TIUDA,"TEXT") W "."
 ; File changes to orig
 K ^TIU(8925,+TIUODA,"TEXT")
 D MERGTEXT^TIUEDI1(TIUODA) W "."
 K ^TIU(8925,+TIUODA,"TEMP")
 ; Merge ^TMP("TIUSWAP",$J) into ^TIU(8925,+TIUDA,"TEMP")
 K ^TIU(8925,+TIUDA,"TEMP")
 M ^TIU(8925,+TIUDA,"TEMP")=^TMP("TIUSWAP",$J) W "."
 ; File changes to add
 K ^TIU(8925,+TIUDA,"TEXT")
 D MERGTEXT^TIUEDI1(TIUDA) W "."
 ; Swap signatures
 D SWAPSB^TIURD4(TIUODA,TIUDA,.TIUOS,.TIUAS)
 ; Update status of each record
 D UPDSTAT^TIURD4(TIUODA),UPDSTAT^TIURD4(TIUDA)
 ; Resend alerts
 D SEND^TIUALRT(TIUDA),SEND^TIUALRT(TIUODA)
 ; Clean up ^TIU(8925,+TIUDA,"TEMP" and ^TMP("TIUSWAP",$J)
 K ^TIU(8925,+TIUDA,"TEMP"),^TMP("TIUSWAP",$J) W "...Done." S TIUCHNG=1
 Q
SWAPFLDS(TIUODA,TIUADA,SWAP) ; Move Identifier fields
 N DA,DR,DIE,TIUOD12,TIUAD12,TIUOD13,TIUAD13,TIUOD15,TIUAD15
 S TIUOD12=$G(^TIU(8925,TIUODA,12)),TIUOD13=$G(^(13)),TIUOD15=$G(^(15))
 S TIUAD12=$G(^TIU(8925,TIUADA,12)),TIUAD13=$G(^(13)),TIUAD15=$G(^(15))
 S DR="1201////"_$S(+TIUAD12>0:+TIUAD12,1:"@")_";1202////"_$P(TIUAD12,U,2)
 S DR=DR_";1204////"_$P(TIUAD12,U,4)_";1208////"_$S($P(TIUAD12,U,8)]"":$P(TIUAD12,U,8),1:"@")_";1209////"_$S($P(TIUAD12,U,9)]"":$P(TIUAD12,U,9),1:"@")
 S DA=TIUODA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1302////"_$P(TIUAD13,U,2)_";1303////"_$P(TIUAD13,U,3)_";1304////"_$S($P(TIUAD13,U,4)]"":$P(TIUAD13,U,4),1:"@")
 S DR=DR_";1305////"_$S($P(TIUAD13,U,5)]"":$P(TIUAD13,U,5),1:"@")_";1306////"_$S($P(TIUAD13,U,6)]"":$P(TIUAD13,U,6),1:"@")_";1307////"_$S($P(TIUAD13,U,7)]"":$P(TIUAD13,U,7),1:"@")
 S DA=TIUODA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1501////"_$S($P(TIUAD15,U)]"":$P(TIUAD15,U),1:"@")_";1502////"_$S($P(TIUAD15,U,2)]"":$P(TIUAD15,U,2),1:"@")
 S DR=DR_";1505////"_$S($P(TIUAD15,U,5)]"":$P(TIUAD15,U,5),1:"@")_";1506////"_$S($P(TIUAD15,U,6)]"":$P(TIUAD15,U,6),1:"@")
 S DA=TIUODA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1507////"_$S($P(TIUAD15,U,7)]"":$P(TIUAD15,U,7),1:"@")_";1508////"_$S($P(TIUAD15,U,8)]"":$P(TIUAD15,U,8),1:"@")
 S DR=DR_";1511////"_$S($P(TIUAD15,U,11)]"":$P(TIUAD15,U,11),1:"@")_";1512////"_$S($P(TIUAD15,U,12)]"":$P(TIUAD15,U,12),1:"@")_";1513////"_$S($P(TIUAD15,U,13)]"":$P(TIUAD15,U,13),1:"@")
 S DA=TIUODA,DIE="^TIU(8925," D ^DIE K DR
 I '+$G(SWAP) Q
 S DR="1201////"_$S(+TIUOD12>0:+TIUOD12,1:"@")_";1202////"_$P(TIUOD12,U,2)
 S DR=DR_";1204////"_$P(TIUOD12,U,4)_";1208////"_$S($P(TIUOD12,U,8)]"":$P(TIUOD12,U,8),1:"@")_";1209////"_$S($P(TIUOD12,U,9)]"":$P(TIUOD12,U,9),1:"@")
 S DA=TIUADA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1302////"_$P(TIUOD13,U,2)_";1303////"_$P(TIUOD13,U,3)_";1304////"_$S($P(TIUOD13,U,4)]"":$P(TIUOD13,U,4),1:"@")
 S DR=DR_";1305////"_$S($P(TIUOD13,U,5)]"":$P(TIUOD13,U,5),1:"@")_";1306////"_$S($P(TIUOD13,U,6)]"":$P(TIUOD13,U,6),1:"@")_";1307////"_$S($P(TIUOD13,U,7)]"":$P(TIUOD13,U,7),1:"@")
 S DA=TIUADA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1501////"_$S($P(TIUOD15,U)]"":$P(TIUOD15,U),1:"@")_";1502////"_$S($P(TIUOD15,U,2)]"":$P(TIUOD15,U,2),1:"@")
 S DR=DR_";1505////"_$S($P(TIUOD15,U,5)]"":$P(TIUOD15,U,5),1:"@")_";1506////"_$S($P(TIUOD15,U,6)]"":$P(TIUOD15,U,6),1:"@")
 S DA=TIUADA,DIE="^TIU(8925," D ^DIE K DR
 S DR="1507////"_$S($P(TIUOD15,U,7)]"":$P(TIUOD15,U,7),1:"@")_";1508////"_$S($P(TIUOD15,U,8)]"":$P(TIUOD15,U,8),1:"@")
 S DR=DR_";1511////"_$S($P(TIUOD15,U,11)]"":$P(TIUOD15,U,11),1:"@")_";1512////"_$S($P(TIUOD15,U,12)]"":$P(TIUOD15,U,12),1:"@")_";1513////"_$S($P(TIUOD15,U,13)]"":$P(TIUOD15,U,13),1:"@")
 S DA=TIUADA,DIE="^TIU(8925," D ^DIE K DR
 Q
