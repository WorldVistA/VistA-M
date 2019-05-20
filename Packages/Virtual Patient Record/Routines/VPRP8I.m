VPRP8I ;SLC/MKB -- VPR patch 8 pre install ;10/14/18  11:22
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; VASITE                       10112
 ;
PRE ; -- pre init
 Q
 ;
POST ; -- post init
 D 560,SDA
 D EN^VPRIDX
 Q
 ;
560 ;set up Subscription file
 I $P($G(^VPR(1,0)),U)="" D
 . N SITE S SITE=$P($$SITE^VASITE,U,2)
 . S:SITE="" SITE="VISTA"
 . S $P(^VPR(1,0),U)=SITE,^VPR("B",SITE,1)=""
 . S $P(^VPR(0),U,3,4)="1^1"
 Q
 ;
SDA ;rebuild SDA index
 N X,Y,DA,DIK
 K ^DDE("SDA")
 S DIK="^DDE(",DIK(1)=".06^SDA"
 D ENALL^DIK
 Q
