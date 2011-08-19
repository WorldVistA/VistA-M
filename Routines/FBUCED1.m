FBUCED1 ;ALBISC/TET - EDIT UNAUTHORIZED CLAIM, cont'd
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DEL ;deletes unauthorized claim(s); if any pending info will delete also
 ;only claims which have not been dispositioned can be deleted.
 N FBACT,FBO,DIRUT,DTOUT,DUOUT,Y S FBACT="DEL",FBO="5^10^30^" D LOOKUP^FBUCUTL3(FBO) G END^FBUCED:FBOUT!('+$G(FBARY))
 N FBALL,FBDA,FBI,FBNODE,FBOUT,FBPL,FBW,FBZ S (FBALL,FBOUT)=0 D PARSE^FBUCUTL4(FBARY)
 S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  S FBNODE=$G(^(FBI)),FBDA=+$P(FBNODE,";"),FBZ=$$FBZ^FBUCUTL(FBDA) I FBZ]"" D  G:FBOUT DELQ
 .N FBDISP,FBGROUP D LINE^FBUCUTL4(FBNODE,FBI,FBPL,FBW)
 .N Y,DIRUT,DTOUT,DUOUT S DIR("A")="Are you sure you wish to delete",DIR("B")="Y",DIR(0)="Y" D ^DIR K DIR S:$D(DIRUT) FBOUT=1 Q:'Y
 .D GROUP^FBUCUTL7(FBZ,FBDA),DISPLAY^FBUCUTL7(FBDA,.FBGROUP,"^5^10^30^",+$P(FBZ,U,11))
 .I $$PRIME^FBUCUTL4(FBDA,FBZ) D PRIME^FBUCLNK1(.FBGROUP,FBDA,FBZ)
 .I +FBDISP D  Q:FBOUT
 ..N DA,DIK,FBDIRA,FBI S FBDIRA="Shall all of these claims be deleted"
 ..D READ^FBUCUTL7(FBDIRA,.FBOUT,.FBDISP) Q:FBOUT!('FBALL)
 ..S FBI=0,DIK="^FB583(" F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  I FBI'=FBDA S DA=FBI D ^DIK I $$PEND^FBUCUTL(FBDA) D PENDDEL(FBI)
 .W !,"Deleting claim" W $S('FBALL:"...",1:" and associated claims not dispositioned ...") S DA=FBDA,DIK="^FB583(" D ^DIK K DA,DIK
 .I $$PEND^FBUCUTL(FBDA) D PENDDEL(FBDA)
DELQ D END^FBUCED Q
PENDDEL(FBDA) ;delete pending information on unauthorized claim
 ;INPUT:  FBDA = internal entry number of unauthorized claim
 ;OUTPUT: none - pending information is deleted from file 162.8
 Q:'$G(FBDA)  N FBPEND,DA,DIK S DIK="^FBAA(162.8,",FBPEND=0
 F  S FBPEND=$O(^FBAA(162.8,"AC",FBDA,0)) Q:'FBPEND  S DA=FBPEND D ^DIK K DA
 Q
