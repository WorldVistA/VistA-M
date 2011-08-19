FBUCED0 ;ALBISC/TET - UPDATE UNAUTHORIZED GROUP ;10/29/01
 ;;3.5;FEE BASIS;**27**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT(FBDR,FBACT,FBOUT,FBARY) ;called from fbuced, edit to 162.7
 ;INPUT:  FBDR = template to be edited
 ;        FBACT = action on claim (DIS = disposition, REO = reopen, etc)
 ;        FBOUT = exit flag, 1 to exit
 ;        FBARY = count;positions of output array in tmp(fbary
 ;OUTPUT: FBOUT = 1 if exited
 ;        update unauthorized claim
 ;get fbda from array
 Q:'+$G(FBARY)!($G(FBDR)']"")!($G(FBACT)']"")  S FBOUT=+$G(FBOUT)
 N FBDIRA,FBDA,FBI,FBNODE,FBPL,FBW D PARSE^FBUCUTL4(FBARY)
 S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+$P(FBNODE,";") D  Q:FBOUT
 .N DA,DIE,DR,FBALL,FBDISP,FBGROUP,FBUCA,FBUCAA,FBUCP,FBUCPA,FBUCPDX,FBY,Y
 .I +$G(FBARY)>1 D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 .D PRIOR^FBUCEVT(FBDA,FBACT) S:FBACT="EDT"!(FBACT="REO") FBUCPDX=$G(^FB583(FBDA,"DX"))
 .I FBACT="DIS",$D(FBUCP),$P($G(FBUCP),"^",3)="" W !,"Vendor information is required for disposition." Q
 .I FBACT="DIS",$D(FBUCP),$P($G(FBUCP),"^",10)="" W !,"Patient Type Code is required for disposition." Q
 .S DIE="^FB583(",DA=FBDA,DR=FBDR,FBDISP=0 D LOCK^FBUCUTL(DIE,DA,0) I FBLOCK D ^DIE I $D(DTOUT) S FBOUT=1,DR="[FB UNAUTHORIZED PREVIOUS]",DA=FBDA D AFTER^FBUCEVT(DA,FBACT),^DIE L -^FB583(FBDA) K FBLOCK
 .I 'FBOUT S FBY=$S($D(Y):1,1:0) D AFTER^FBUCEVT(FBDA,FBACT) L -^FB583(FBDA) K FBLOCK D CKAUTH^FBUCUTL6(FBUCP,.FBUCA,FBDA),^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,FBACT) I FBACT="REO",'FBY&($$EDOK^FBUCUTL3(FBDA)) D
 ..;keep authoriziation info in synch for claim being edited via reopen
 ..N DA,DIE,DR,FBAIEN,FBAUTH,FBIEN,FBLOCK S FBAUTH=$$AUTH^FBUCUTL6(FBUCP,FBUCA)
 ..Q:FBAUTH=1!(FBAUTH=0)  S FBAIEN=+$P(FBUCA,U,27) Q:'FBAIEN  S FBIEN=FBAIEN
 ..S DA=+$P(FBUCP,U,4),DIE="^FBAAA(",DR="[FB UNAUTHORIZED EDIT]"
 ..D LOCK^FBUCUTL(DIE,DA,0) I FBLOCK D ^DIE L -^FBAAA(+$P(FBUCP,U,4)) S:$D(DTOUT) FBOUT=1 K DTOUT
 .;keep veteran & treatment from/to (what constitutes a group) in synch for rest in group
 .S FBALL=0 D GROUP^FBUCUTL7(FBUCP,FBDA),DISPLAY^FBUCUTL7(FBDA,.FBGROUP)
 .I +$G(FBDISP),$P(FBUCP,U,4,6)'=$P(FBUCA,U,4,6) S FBDIRA="Shall other claims be updated to same veteran & treat. from/to dates" D READ^FBUCUTL7(FBDIRA,.FBOUT,.FBDISP) D  Q:FBOUT
 ..I FBOUT S FBALL=0 ;if timeout during read, force an unlink
 ..I 'FBALL D UNLINK^FBUCLNK1(.FBGROUP,FBDA,FBUCA) Q  ;unlink claim module
 ..I FBALL D
 ...N FBDR
 ...S FBDR="S:'+$P(FBUCA,U,4) Y=""@1"";2////^S X=+$P(FBUCA,U,4);S Y=3;@1;2///@;S:'+$P(FBUCA,U,5) Y=""@2"";3////^S X=+$P(FBUCA,U,5);S Y=4;@2;3///@;S:'+$P(FBUCA,U,6) Y=""@3"";4////^S X=+$P(FBUCA,U,6);S Y=""@99"";@3;4///@;@99"
 ...N FBI,FBLOCK S FBI=0 F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  I FBI'=FBDA D DIE^FBUCUTL2("^FB583(",FBI,FBDR)
 .;if reopen or disposition, keep disposition and auth from/to dates in synch for same dispostion for rest in group, also keeps respective authorization in 161.01 in synch
 .I $S(FBUCA']"":1,FBACT'="REO"&(FBACT'="DIS")&(FBACT'="EDT"):1,FBACT="EDT"&(+$P(FBGROUP,U,5)):0,+$P(FBUCP,U,11)'=+$P(FBUCA,U,11)!($P(FBUCP,U,13,14)'=$P(FBUCA,U,13,14)):0,1:1) Q
 .S FBALL=0 D DISPLAY^FBUCUTL7(FBDA,.FBGROUP,"^"_+$P(FBUCP,U,24)_"^",+$P(FBUCP,U,11)) Q:'+FBDISP
 .I +$P(FBUCP,U,11)'=+$P(FBUCA,U,11) S FBDIRA="Shall all other claims be updated to the disposition" S:$P(FBUCP,U,13,14)'=$P(FBUCA,U,13,14) FBDIRA=FBDIRA_" & auth. from/to dates"
 .I $P(FBUCP,U,11)=$P(FBUCA,U,11) S FBDIRA="Shall all other claims be updated to the auth. from/to dates"
 .D READ^FBUCUTL7(FBDIRA,.FBOUT,.FBDISP) I 'FBALL!(FBOUT) Q
 .I +$P(FBUCA,U,11)'=+$P(FBUCP,U,11),('($P(FBUCA,U,11)=1!($P(FBUCA,U,11)=4))) S DIR(0)="Y",DIR("A")="Shall disapproval reason apply to all other claims" D ^DIR K DIR Q:$D(DIRUT)  S FBUCDISR=Y I Y D FBUCDISR(FBDA)
 .D  K FBUCDISR
 ..N FBDR,FBI,FBODA,FBUCP,FBUCPA
 ..S FBDR="S:'+$P(FBUCA,U,13) Y=""@1"";12////^S X=+$P(FBUCA,U,13);S Y=13;@1;12///@;S:'+$P(FBUCA,U,14) Y=""@2"";13////^S X=+$P(FBUCA,U,14);S Y=10;@2;13///@;S:'+$P(FBUCA,U,11) Y=""@3"";10////^S X=+$P(FBUCA,U,11);S Y=""@99"";@3;10///@;@99"
 ..S FBODA=FBDA,FBI=0 F  S FBI=$O(FBDISP(FBI)) Q:'FBI  I FBI'=FBODA D PRIOR^FBUCEVT(FBI,FBACT) D DIE^FBUCUTL2("^FB583(",FBI,FBDR) N FBUCA,FBUCAA D AFTER^FBUCEVT(FBI,FBACT) S FBDA=FBI D ^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBI,FBACT,$G(FBUCDISR))
 Q
FBUCDISR(FBDA) ;set up fbucdisr with disap. reasons for primary claim
 ;INPUT:  ien of unauthorized claim (usually primary)
 ;OUTPUT: fbucdisr=1^   (1 indicates user wishes for all linked
 ;                 claims to contain same disapproval reason as primary
 ;                 pieces following will contain the pointer values
 ;                 of the disap. reasons for the primary del by ^
 N I
 I $D(^FB583(FBDA,"D")) S I=0 F  S I=$O(^FB583(FBDA,"D",I)) Q:'I  S FBUCDISR=FBUCDISR_"^"_+^FB583(FBDA,"D",I,0)
 Q
