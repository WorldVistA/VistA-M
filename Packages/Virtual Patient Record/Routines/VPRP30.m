VPRP30 ;SLC/MKB -- SDA utilities for patch 30 ;8/18/21  14:21
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Aug 18, 2021;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ; -- Post install for VPR*1.0*30
 D PTF
 Q
 ;
PTF ; -- Add new source to Container file for PTF
 N PROC,DA,DR,DIE,DIC,X,X0,MSG,OK
 S PROC=+$O(^VPRC(560.1,"B","PROCEDURE",0)) Q:PROC<1
 S DA=+$O(^VPRC(560.1,"F",45.05,PROC,0)),OK=0
 I DA D  Q:OK  ;already done
 . S X0=$G(^VPRC(560.1,PROC,1,DA,0))
 . I $P(X0,U,2)>0,$P(X0,U,3)>0 S OK=1 Q  ;ok
 ; update, add message to Install log
 S DIE="^VPRC(560.1,"_PROC_",1,",DA(1)=PROC
 S MSG="VPR CONTAINER file source for #45.05"
 I 'DA D  Q:DA'>0
 . S DIC=DIE,DIC(0)="LX",X=45.05
 . K DA S DA(1)=PROC D FILE^DICN
 . I DA'>0 D BMES^XPDUTL("UNABLE to create "_MSG)
 S DR=".02///VPR PTF 601;.03///VPR DEL PTF 601" D ^DIE
 S X0=$G(^VPRC(560.1,DA(1),1,DA,0))
 S MSG=MSG_" "_$S($P(X0,U,2)<1:"UN",$P(X0,U,3)<1:"UN",1:"")_"SUCCESSFUL."
 D BMES^XPDUTL(MSG)
 Q
