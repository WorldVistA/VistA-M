IBY280PO ;ALB/TMK - IB*2*280 POST-INSTALL ;17-AUG-04
 ;;2.0;INTEGRATED BILLING;**280**;21-MAR-94
 ;
 N A,DLAYGO,DIC,DIE,DIK,DA,DR,DO,DD,Y,X,Z,Z0,Z1,Z3
 D BMES^XPDUTL("Post-Installation Updates")
 ;
 D BMES^XPDUTL("Moving LINE ITEM REMARKS for EEOBs to new fields")
EN S Z=0 F  S Z=$O(^IBM(361.1,Z)) Q:'Z  S Z0=0 F  S Z0=$O(^IBM(361.1,Z,15,Z0)) Q:'Z0  S Z3=$G(^(Z0,3)) I Z3'="" D
 . K A,DO,DD,DIC,DA,DLAYGO
 . S X=1,DA(2)=Z,DA(1)=Z0,DIC="^IBM(361.1,"_DA(2)_",15,"_DA(1)_",4,",DIC(0)="L"
 . S DIC("DR")="",DLAYGO=361.115
 . S DIC("DR")=$S($P(Z3,U)'="":".02////"_$P(Z3,U),1:"")
 . S DIC("DR")=DIC("DR")_$S($P(Z3,U,2)'="":$S(DIC("DR")'="":";",1:"")_".03////"_$P(Z3,U,2),1:"")
 . I '$D(^IBM(361.1,DA(2),15,DA(1),4,1,0)) D FILE^DICN Q:Y'>0
 . M A=DA K DA
 . S DA(1)=A(2),DA=A(1)
 . I Y>0 S DIE="^IBM(361.1,"_DA(1)_",15,",DR="3.01///@;3.02///@" D ^DIE K ^IBM(361.1,DA(1),15,DA,3)
 D ENDST
 ;
 ; search for all records in file 355.3 that contain internal code
        ; TR in field .15 (Electronic Plan Type) and change it back to CH.
 D BMES^XPDUTL("Reconvert 'TR' code to 'CH' for ELECTRONIC PLAN TYPE in file 355.3")
        S DA=0
        F  S DA=$O(^IBA(355.3,DA)) Q:'DA  D
        . Q:$P($G(^IBA(355.3,DA,0)),U,15)'="TR"
        . S DIE="^IBA(355.3,",DR=".15////CH" D ^DIE
 ;
 D ENDST
 ;
 D END
 Q
 ;
ENDST ; End step
 D BMES^XPDUTL("Step complete")
 Q
 ;
END ; End
 D BMES^XPDUTL("Post-install complete")
 Q
 ;
