VPRP28 ;SLC/BLJ -- SDA utilities for patch 28 ;8/18/21  14:21
 ;;1.0;VIRTUAL PATIENT RECORD;**28**;Aug 18, 2021;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ; -- Post install for VPR*1.0*28
 D CONT
 D PCMM^VPRIDX
 ;
 Q
 ;
CONT ; -- link new entities to Container file
 N DA,DR,DIE,X0,MSG
 S DA(1)=+$O(^VPRC(560.1,"B","VACCINATION",0)) Q:DA(1)<1
 S DA=+$O(^VPRC(560.1,"F",9000010.707,DA(1),0)) Q:DA<1
 ; already linked?
 S X0=$G(^VPRC(560.1,DA(1),1,DA,0))
 I $P(X0,U,2)>0,$P(X0,U,3)>0 Q  ;ok
 ; update, add message to Install log
 S DIE="^VPRC(560.1,"_DA(1)_",1,"
 S DR=".02///VPR ICR EVENT;.03///VPR DEL ICR" D ^DIE
 S X0=$G(^VPRC(560.1,DA(1),1,DA,0)),MSG="Pointer resolution "
 S MSG=MSG_$S($P(X0,U,2)<1:"UN",$P(X0,U,3)<1:"UN",1:"")_"SUCCESSFUL."
 D BMES^XPDUTL(MSG)
 Q
