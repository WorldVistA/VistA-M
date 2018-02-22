PRCA320P ;LIB/RED-PRCA*4.5*320 POST INSTALL ;22 May 17
 ;;4.5;Accounts Receivable;**320**;Mar 20, 1995;Build 30
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR - 1157     ADD^XPDMENU and $$LKOPT^XPDMENU
 ; 
POSTINIT ;
 D ADDARDC
 D XREF
 Q
ADDARDC ; add menu option - ARDC DETAIL REPORT to existing option - PRCAD RECONCILE MENU
 N DA,DIK,MEN,OPT,RET
 ; RET - value returned from
 S MEN="PRCAD RECONCILE MENU"
 S DA(1)=+$$LKOPT^XPDMENU(MEN)
 S OPT="PRCA ARDC REPORT"
 S DA=+$$LKOPT^XPDMENU(OPT)  ; get option IEN
 I $D(^DIC(19,DA(1),10,"B",DA)) Q  ; Option already added
 D ADD^XPDMENU(MEN,OPT,"") ; Set ARDC DETAIL REPORT as an item in Reconciliation Reports menu
 Q
XREF ;  check "AC" xref
 N X,FLAG S FLAG=0
 F X=16,18,32,33,40,42 D
 . S I=0 F  S I=$O(^PRCA(430,"AC",X,I)) Q:'I  D
 .. I $P(^PRCA(430,I,0),U,8)'=X S FLAG=1 Q
 .. Q
 .Q
 I 'FLAG Q
 D MES^XPDUTL(" >>  At least one bad cross-reference was found in")
 D MES^XPDUTL(" >>  file #430! This needs to be fixed via FileMan.")
 D MES^XPDUTL(" >>  To fix this issue use the FileMan utilities - Re-index a file")
 D MES^XPDUTL(" >>  - Modify file #430, - use a Particular Index - Select field")
 D MES^XPDUTL(" >>  and choose: 'Current Status', and select the regular 'AC' index.")
 D MES^XPDUTL(" >>  ...")
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 Q
