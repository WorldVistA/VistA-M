VPRP31 ;SLC/MRY -- Patch 31 postinit ;2/4/21  12:07
 ;;1.0;VIRTUAL PATIENT RECORD;**31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
POST ; -- post-init
 D IDX,CONT
 Q
 ;
IDX ; -- add AVPR index to #8925.7
 N VPRX,VPRY
 S VPRX("FILE")=8925.7
 S VPRX("NAME")="AVPR"
 S VPRX("TYPE")="MU"
 S VPRX("USE")="A"
 S VPRX("EXECUTION")="F"
 S VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Trigger updates to VPR"
 S VPRX("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S VPRX("DESCR",2)="when this record is updated. No actual cross-reference nodes are set"
 S VPRX("DESCR",3)="or killed."
 S VPRX("SET")="D:$L($T(TIUS^VPREVNT)) TIUS^VPREVNT(DA)"
 S VPRX("KILL")="Q"
 S VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.04              ;Cosignature date/time
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 Q
 ;
CONT ; -- link new entity to Container file
 N DA,DR,DIE,X0,MSG
 S DA(1)=+$O(^VPRC(560.1,"B","MEMBER ENROLLMENT",0)) Q:DA(1)<1
 S DA=+$O(^VPRC(560.1,"F",2.312,DA(1),0)) Q:DA<1
 ; already linked?
 S X0=$G(^VPRC(560.1,DA(1),1,DA,0))
 I $P(X0,U,2)>0,$P(X0,U,3)>0 Q  ;ok
 ; update, add message to Install log
 S DIE="^VPRC(560.1,"_DA(1)_",1,"
 S DR=".03///VPR DEL INSURANCE" D ^DIE
 S X0=$G(^VPRC(560.1,DA(1),1,DA,0)),MSG="Pointer resolution "
 S MSG=MSG_$S($P(X0,U,3)<1:"UN",1:"")_"SUCCESSFUL."
 D BMES^XPDUTL(MSG)
 Q
