DG53819C ;ALB/MJB - POST INSTALL ROUTINE ; 11/19/09
 ;;5.3;Registration;**819**;Aug 13, 1993;Build 16
 ;
 Q
EN ; START UPDATES
 D ADD
 D UPD
 Q
ADD ;Add suffixes to the Suffix file (#45.68)
 N DGI,DGERR,DGSUFF,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSUFF=$P($T(DGSUFF+DGI),";;",2) Q:DGSUFF="QUIT"  D
 .D SUFFIX
 Q
SUFFIX ; Add Suffix
 K DD,DO
 N DA,DIC,DIE,DLAYGO,DR,X,Y,DGDT
 S DLAYGO=45.68
 S DIC="^DIC(45.68,",DIC(0)="XLZ"
 S X=$P(DGSUFF,U,1)
 S DGDT=$P(DGSUFF,U,2)
 D ^DIC I Y<0 D BMES^XPDUTL(">> Error adding Suffix.  Call Customer Support.") Q
 D BMES^XPDUTL(" >> Suffix added to FACILITY SUFFIX file.")
 S (DIC,DIE)="^DIC(45.68,"_+Y_",""E"",",DA(1)=+Y,DIC("P")=$P(^DD(45.68,10,0),U,2),DIC(0)="XLZ",X=DGDT
 D ^DIC
 I Y<0 D BMES^XPDUTL(">> Error adding Suffix Effective Date.  Call Customer Support.") Q
 S DA=+Y
 S DR=".01////^S X=DGDT;.02////1"
 D ^DIE
 Q
 ;
DGSUFF ; SUFFIX
 ;;B1^3091214
 ;;B2^3091214
 ;;B3^3091214
 ;;B4^3091214
 ;;PB^2971001
 ;;PC^2971001
 ;;PD^2971001
 ;;PE^2971001
 ;;QUIT
 ;
UPD ;Update suffixes in the Suffix file (#45.68)
 N DGI,DGERR,DGSUFF,DGIFN,DGQUES
 S DGIFN=0
 F DGI=1:1 S DGSUFF=$P($T(DGSUFU+DGI),";;",2) Q:DGSUFF="QUIT"  D
 .D SUFFUP
 Q
SUFFUP ; Update Suffix
 K DD,DO
 N DA,DIC,DIE,DLAYGO,DR,X,Y,DGDT
 S DLAYGO=45.68
 S DIC="^DIC(45.68,",DIC(0)="XLZ"
 S X=$P(DGSUFF,U,1)
 S DGDT=$P(DGSUFF,U,2)
 D ^DIC I Y<0 D BMES^XPDUTL(">> Error updating Suffix.  Call Customer Support.") Q
 D BMES^XPDUTL(" >> Suffix updated in FACILITY SUFFIX file.")
 S (DIC,DIE)="^DIC(45.68,"_+Y_",""E"",",DA(1)=+Y,DIC("P")=$P(^DD(45.68,10,0),U,2),DIC(0)="XLZ",X=2931001
 D ^DIC
 I Y<0 D BMES^XPDUTL(">> Error updating Suffix Effective Date.  Call Customer Support.") Q
 S DA=+Y
 S DR=".02////1"
 D ^DIE
 Q
 ;
DGSUFU ; SUFFIX
 ;;BV^2931001
 ;;BW^2931001
 ;;BX^2931001
 ;;QUIT
 ;
