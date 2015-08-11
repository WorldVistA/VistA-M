IBCEOB4 ;ALB/PJH - EPAYMENTS MOVE/COPY EEOB TO NEW CLAIM ;Jun 11, 2014@17:45:06
 ;;2.0;INTEGRATED BILLING;**451,511**;21-MAR-1994;Build 106
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Entry point for EEOB Move
MOVE(EOBIEN,IBIFN,DUZ,MDATE,JCOM,EVENT) ;
 ;
 N DA,DIC,DIE,DIK,DR,IEN101,OBILL,X,Y
 S OBILL=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,EOBIEN,0)),U))
 ;
 ;Create new MOVE/COPY HISTORY stub
 S DA(1)=EOBIEN
 S DIC="^IBM(361.1,"_DA(1)_",101,",DIC(0)="L",X=MDATE
 D FILE^DICN
 S IEN101=+Y Q:'IEN101
 ;
 ;Update detail on MOVE/COPY HISTORY
 K DA,DIE,DR,X,Y
 S DIE="^IBM(361.1,"_EOBIEN_",101,",DA=IEN101
 ;Update User, Date/Time, Comments,Move/Copy event
 S DR=".02///"_DUZ_";.03///"_JCOM_";.05///"_EVENT
 ;Update original bill number
 S DR=DR_";.04///"_OBILL
 D ^DIE
 ;
 ;Update bill number on EOB
 K DA,DIE,DR,X,Y
 S DIE="^IBM(361.1,",DA=EOBIEN,DR=".01///"_IBIFN
 D ^DIE
 ;
 ;Re-index updated EOB to correct PAYER NAME - IB*2*511
 K DA S DIK="^IBM(361.1,",DA=EOBIEN D IX^DIK
 ;
 ;Update any AR AMOUNTS DISTRIBUTION (split/edit detail)
 D FUNCTION(EOBIEN,OBILL,IBIFN)
 ;
 Q
 ;
 ;Entry point for EEOB Copy
COPY(EOBIEN,IBIFN,DUZ,MDATE,JCOM,EVENT) ;
 ;
 N IEN,IEN1,OBILL,NEWEOB
 ;
 ;Original Claim number
 S OBILL=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,EOBIEN,0)),U))
 ;
 ;Lock zero node before making inserts
 Q:'$$LOCK(0)
 ;
 ;Scan through list of new claims
 S IEN=0
 F  S IEN=$O(IBIFN(IEN)) Q:'IEN  D
 .;Create stub
 .N DA,DIC,DIE,DIK,DLAYGO,DR,IEN1,IEN101,X,Y
 .S DIC(0)="L",DIC="^IBM(361.1,",DLAYGO=361.1
 .;Use 399 ien as .01 field
 .S X=IEN
 .D FILE^DICN
 .S NEWEOB=+Y Q:'NEWEOB
 .;Lock the new entry
 .Q:'$$LOCK(NEWEOB)
 .;Copy details to new EOB (except for audit information)
 .N ARRAY
 .M ARRAY=^IBM(361.1,EOBIEN) K ARRAY(101)
 .M ^IBM(361.1,NEWEOB)=ARRAY
 .;Re-index new EOB
 .K DA,DIE,DIK,DR,IEN1,IEN101,X,Y
 .S DIK="^IBM(361.1,",DA=NEWEOB D IX^DIK
 .;Update .01 field in new EOB
 .K DA,X,Y
 .S DIE="^IBM(361.1,",DA=NEWEOB
 .S DR=".01////"_IBIFN(IEN)
 .D ^DIE
 .;Re-index updated EOB to correct PAYER NAME - IB*2*511
 .K DA,DIK,X,Y S DIK="^IBM(361.1,",DA=NEWEOB D IX^DIK
 .;
 .;Update any AR AMOUNTS DISTRIBUTION (split/edit detail)
 .D FUNCTION(NEWEOB,OBILL,IBIFN(IEN))
 .;
 .;Create stub for audit information
 .K DA,DIC,X,Y
 .S DA(1)=NEWEOB
 .S DIC="^IBM(361.1,"_DA(1)_",101,",DIC(0)="L",X=MDATE
 .D FILE^DICN
 .S IEN101=+Y Q:'IEN101
 .;
 .;Update detail on MOVE/COPY HISTORY
 .K DA,DIE,DR,X,Y
 .S DIE="^IBM(361.1,"_NEWEOB_",101,",DA=IEN101
 .;Update User, Date/Time, Comments,Event
 .S DR=".02///"_DUZ_";.03///"_JCOM_";.05///"_EVENT
 .S DR=DR_";.04///"_OBILL
 .D ^DIE
 .;
 .;Insert Other claim numbers
 .K DIC,DLAYGO,IEN1,X,Y
 .S IEN1=""
 .F  S IEN1=$O(IBIFN(IEN1)) Q:'IEN1  D
 ..;current claim excluded
 ..Q:IEN1=IEN
 ..N DA,DIC,DLAYGO,DR,X
 ..S DA(1)=IEN101,DA(2)=NEWEOB
 ..S DIC="^IBM(361.1,"_DA(2)_",101,"_DA(1)_",1,"
 ..S DIC(0)="L",X=IBIFN(IEN1)
 ..D FILE^DICN
 .;Unlock new entry
 .D UNLOCK(NEWEOB)
 ;
 ;Update original EOB audit information
 N DA,DIC,DIE,DLAYGO,DR,IEN1,IEN101,X,Y
 S DA(1)=EOBIEN
 S DIC="^IBM(361.1,"_DA(1)_",101,",DIC(0)="L",X=MDATE
 D FILE^DICN
 S IEN101=+Y Q:'IEN101
 ;
 ;Update User, Date/Time, Comments,Event
 K DA,DIC,X,Y
 S DIE="^IBM(361.1,"_EOBIEN_",101,",DA=IEN101
 S DR=".02///"_DUZ_";.03///"_JCOM_";.05///"_EVENT
 D ^DIE
 ;
 ;Insert Other claim numbers
 K DA,DIC,X,Y
 S IEN1=""
 F  S IEN1=$O(IBIFN(IEN1)) Q:'IEN1  D
 .K DA,DIC,DR,X
 .S DA(1)=IEN101,DA(2)=EOBIEN
 .S DIC="^IBM(361.1,"_DA(2)_",101,"_DA(1)_",1,"
 .S DIC(0)="L",X=IBIFN(IEN1)
 .D FILE^DICN
 ;
 ;Release zero node after inserts
 D UNLOCK(0)
 Q
 ;
REMOVE(EOBIEN,DUZ,JCOM) ;Mark EEOB as Removed - IB*2*511
 ; Timestamp
 N DA,DIC,DIE,DR,IEN101,OBILL,X,Y
 S OBILL=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,EOBIEN,0)),U))
 ;
 ;Create new MOVE/COPY HISTORY stub for remove action
 S DA(1)=EOBIEN
 S DIC="^IBM(361.1,"_DA(1)_",101,",DIC(0)="L",X=$$NOW^XLFDT
 D FILE^DICN
 S IEN101=+Y Q:'IEN101
 ;
 ;Update detail on MOVE/COPY HISTORY
 N DIE,DA,DR,X,Y
 S DIE="^IBM(361.1,"_EOBIEN_",101,",DA=IEN101
 ;Update User, Date/Time, Comments, Original Bill and Remove event
 S DR=".02///"_DUZ_";.03///"_JCOM_";.04///"_OBILL_";.05///R"
 D ^DIE
 ;
 ;Mark EEOB as removed to prevent further use
 N DIE,DA,DR,X,Y
 S DIE="^IBM(361.1,",DA=EOBIEN
 ;Update EEOB REMOVED
 S DR="102///1"
 D ^DIE
 Q
 ; 
 ;Update Split/Edit history for EOB
FUNCTION(EOBIEN,ONAME,NEWIEN) ;
 N DA,DIE,DR,NEWNAME,SUB,X,Y
 ;Check for split/edit history for original claim
 S SUB=$O(^IBM(361.1,EOBIEN,8,"B",ONAME,"")) Q:'SUB
 ;New bill name
 S NEWNAME=$P($G(^DGCR(399,NEWIEN,0)),U)
 ;Update bill number in Split/Edit history
 S DA(1)=EOBIEN,DIE="^IBM(361.1,"_DA(1)_",8,",DA=SUB
 S DR=".01///"_NEWNAME_";.03///"_NEWNAME
 D ^DIE
 Q
 ;
LOCK(EOBIEN) ;Lock Original EOB
 L +^IBM(361.1,EOBIEN):5 I  Q 1
 W !,"EOB in use by another user, try later"
 Q 0
 ;
UNLOCK(EOBIEN) ;Release EOB
 L -^IBM(361.1,EOBIEN)
 Q
 ;
