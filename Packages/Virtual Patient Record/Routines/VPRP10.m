VPRP10 ;SLC/MKB -- SDA updates for patch 10 ;3/14/19  20:13
 ;;1.0;VIRTUAL PATIENT RECORD;**10**;Sep 01, 2011;Build 16
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; XUSAP                         4677
 ;
 ;
POST ; -- postinit tasks
 D LRAP
 ;D PRXY
 Q
 ;
LRAP ; -- switch protocol items
 N DA,DR,DIE,XQOR,LRAP
 S DA(1)=+$O(^ORD(101,"B","LR7O AP EVSEND OR",0)) Q:DA(1)<1
 S XQOR=+$O(^ORD(101,"B","VPR XQOR EVENTS",0))
 S LRAP=+$O(^ORD(101,"B","VPR LRAP EVENTS",0))
 S DA=$O(^ORD(101,"AD",LRAP,DA(1),0)) I DA D
 . S DR=".01////"_XQOR,DIE="^ORD(101,"_DA(1)_",10,"
 . D ^DIE
 Q
 ;
PRXY ; -- create proxy user
 I '$O(^VA(200,"B","VDIF,APPLICATION PROXY",0)) D
 . N X S X=$$CREATE^XUSAP("VDIF,APPLICATION PROXY","")
 Q
