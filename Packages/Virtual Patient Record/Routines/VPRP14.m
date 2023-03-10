VPRP14 ;SLC/MKB -- Inits for patch 14 ;3/4/20  12:07
 ;;1.0;VIRTUAL PATIENT RECORD;**14**;Sep 01, 2011;Build 38
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;
PRE ; -- preinit to remove unused Entities
 N DIK,DA,VPRNM,X,DR,DIE,XQORM
 ; remove any old PLI patch entities
 S DIK="^DDE(",VPRNM="VPR P14 A"
 F  S VPRNM=$O(^DDE("B",VPRNM)) Q:VPRNM'?1"VPR P"2N1" "1.E  S DA=+$O(^(VPRNM,0)) I DA D ^DIK
 ; remove Social Hx items from test
 ; S DIK="^DDE(",VPRNM="VPR SHX A"
 ; F  S VPRNM=$O(^DDE("B",VPRNM)) Q:VPRNM'?1"VPR SHX "1.E  S DA=+$O(^(VPRNM,0)) I DA D ^DIK
P1 ; add Seq# to VPR item on PS event
 S X=+$O(^ORD(101,"B","VPR XQOR EVENTS",0))
 S DA(1)=+$O(^ORD(101,"B","PS EVSEND OR",0))
 S DA=+$O(^ORD(101,DA(1),10,"B",X,0))
 I DA,+$G(^ORD(101,DA(1),10,DA,0))=X,'$P(^(0),U,3) D
 . S DR="3///2",DIE="^ORD(101,"_DA(1)_",10," D ^DIE
 . S XQORM=DA(1)_";ORD(101," D XREF^XQORM
 Q
