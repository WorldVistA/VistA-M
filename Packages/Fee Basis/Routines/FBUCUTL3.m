FBUCUTL3 ;ALBISC/TET - UTILITY CONTINUATION ;10/10/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DELDAP(FBDA) ;delete disapproval reasons from disapproval multiple in 162.7
 ;if current disposition is 1 (approved) and prior was >1
 ;INPUT:  FBDA = ien of unauthorized claim, 162.7
 ;OUTPUT: none - delete disapproval reasons, if any, from claim
 N Y ;if coming from input template
 I $D(^FB583(FBDA,"D")) N DA,DIK,FBX S DA(1)=FBDA,DIK="^FB583("_FBDA_",""D"",",FBX=0 F  S FBX=$O(^FB583(FBDA,"D","B",FBX)) Q:'FBX  D
 .S DA=0 F  S DA=$O(^FB583(FBDA,"D","B",FBX,DA)) Q:'DA  D ^DIK
 K DA,DIK,FBX Q
DISDAP(FBDA) ;display disapproval reasons and enter in file if any selected
 ;INPUT:  FBDA = ien of unauthorized claim, 162.7
 ;OUTPUT:  if selection, and not already entered, reason is entered
 ;          in REASON FOR DISAPPROVAL (field 15, subfile 162.715).
 ;        FBOUT returned from call to FBUCUTL1
 N FBAR,FBARY,FBI,FBX
 D DISP9^FBUCUTL5(162.94) ;set array for selection
 D DISPX^FBUCUTL1(2) Q:FBOUT  ;display/select choices & display selection
 I 'FBOUT,+$G(FBARY) S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBX=$G(^(FBI)) I +FBX D DISAP^FBUCUTL(FBDA,+FBX) ;file entry
 K FBARY,FBI,FBX,^TMP("FBAR",$J),^TMP("FBARY",$J) Q
ADD ;add new person to file 200, new person file, if other party submits claim
 S FBY=$$ADD^XUSERNEW(".111:.116;9")
 I +FBY>0,'$P(FBY,U,3) W !,"No entry has been made to the New Person file.",!,"If a new entry is needed, enter the name within quotes.",!,*7
 K FBY Q
DISPNP ;display letters not printed
 ;INPUT:  none
 ;OUTPUT: FBAR = display count in array;piece positions for display
 ;        FBAR( array => ien;vet^ven^fee program^date of claim^status
 K ^TMP("FBAR",$J),FBAR N FBI,FBDCT,Z S (FBI,FBDCT)=0 F  S FBI=$O(^FB583("AL",1,FBI)) Q:'FBI  S Z=$G(^FB583(FBI,0)) I Z]"" D
 .S FBDCT=FBDCT+1,FBAR=FBI_";"_$E($$VET^FBUCUTL($P(Z,U,4)),1,12)_U_$E($$VEN^FBUCUTL($P(Z,U,3)),1,12)_U_$E($$PROG^FBUCUTL($P(Z,U,2)),1,14)_U_$$DATX^FBAAUTL($P(Z,U))_U_$E($P($G(^FB(162.92,+$P(Z,U,24),0)),U),1,16)
 .S ^TMP("FBAR",$J,FBDCT)=FBAR
 S FBAR=FBDCT I FBDCT S FBAR=FBAR_";"_"5^20^35^52^63^"
 S ^TMP("FBAR",$J,"FBAR")=FBAR
 Q
LOOKUP(FBO,FBSAVE,FB1725R) ;lookup claim, based on veteran/vendor, and status
 ;INPUT:  FBO = order string or 0 for all
 ;        FBSAVE = 1 to save xref variable (optional)
 ;        FB1725R = (optional) mill bill screening criteria with value
 ;            "M" for just mill bill claims
 ;            "N" for just non-mill bill claims
 ;            "A" (or null) for all claims
 ;OUTPUT:  FBARY = count;position^position, etc
 ;         TMP(FBARY => array of user selection
 ;        FBIX & FBIEN (returned only if fbsave)
 S FBOUT=0 D IEN I 'FBIEN S FBOUT=1 G LOOKUPQ
 D DISP7^FBUCUTL5(FBIX,FBIEN,FBO,$G(FB1725R)) ;screen on status/order
 D DISPX^FBUCUTL1(1,FBO) ;display list from which to select
LOOKUPQ K:'+$G(FBSAVE) FBIEN,FBIX K ^TMP("FBAR",$J) Q
IEN ;get ien of vendor or veteran from 162.7
 ;OUTPUT:  FBIEN = ien of either vendor, veteran or other claimant
 ;                 or 0 if failed/time out/up arrow out
 ;         FBIX  = lookup cross reference (APMS, AVMS or AOMS)
 N DIR,DIRUT,DTOUT,DUOUT,Y S DIR(0)="162.7,23O",DIR("A")="Select unauthorized claim",DIR("?")="You may select the claim by entering the vendor, veteran or other party."
 D ^DIR K DIR S FBIEN=$S($D(DIRUT):0,+Y'>0:0,1:+Y),FBIX=$S(Y["VA":"AOMS",Y["FB":"AVMS",1:"APMS")
 Q
LETDATE ;ask for date letter sent, don't allow future values
 ;INPUT:  FBOUT (optional) - flag if time out or up-arror out
 ;OUTPUT: FBOUT - 1 if time out or up-arrow out
 ;        FBLETDT - date if no fbout flag, otherwise 0
 N DIR,DIRUT,DTOUT,DUOUT,Y S FBLETDT=0 S:'$D(FBOUT) FBOUT=0 S DIR(0)="162.7,19.5" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1 I 'FBOUT S FBLETDT=Y
 Q
AUTHLKUP(FBUCP,FBDA) ;look up authorization - match on 583,vendor,program,auth from & to dates and veteran
 ;INPUT:  FBUCP = prior zero node of 162.7, unauthorized claim
 ;        FBDA  = ien of unauthorized claim
 ;OUTPUT: FBIEN = 0 if no match, otherwise ien of authorization
 S FBIEN=0 I $S('+$G(FBDA):1,$G(FBUCP)']"":1,1:0) Q
 N FBDA1,FBI,FBZ S FBDA1=+$P(FBUCP,U,4),FBI=0
 F  S FBI=$O(^FBAAA("ATST",+$P(FBUCP,U,13),FBDA1,0)) Q:'FBI  S FBZ=$G(^FBAAA(FBDA1,1,FBI,0)) I $P(FBZ,U,2)=$P(FBUCP,U,14),$P(FBZ,U,3)=$P(FBUCP,U,2),$P(FBZ,U,4)=$P(FBUCP,U,3),+$P(FBZ,U,9)=FBDA S FBIEN=FBI Q
 Q
EDOK(X,FBW) ;ok to edit modify/reopen or disposition input templates
 ;INPUT:  X= ien of 162.7
 ;        FBW= 1 to write, 0 not to write (optional)
 ;OUTPUT: 0 if NOT OK to edit; 1 if ok to edit
 N FBY S FBY=1 S:'$G(FBW) FBW=0
 I $$PAY^FBUCUTL(X,"^FB583(") D
 .W:FBW !,"Payments on file!",*7,!
 .I '$$OVER^FBUCUTL("FBAASUPERVISOR") W:FBW !,"You must hold the supervisor's key to edit any data other than Amount Approved.",! S FBY=0
 Q FBY
 ;
