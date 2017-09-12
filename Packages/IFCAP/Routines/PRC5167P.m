PRC5167P ;OI&T/DDA - INSTALL UTILITY ROUTINE ;7/2/12  13:58
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;;Per VHA Directive 2004-38, this routine should not be modified.
 ;
 Q
POST ; post install;
 ; ADD the two new eCMS related status entries
 N PRCERR,PRCD4423
 S PRCERR=""
 S PRCD4423=1
 S PRCIEN(1)=69
 S PRC4423(442.3,"+1,",.01)="Sent to eCMS (P&C)"
 S PRC4423(442.3,"+1,",.02)=69
 D UPDATE^DIE("","PRC4423","PRCIEN","PRCERR")
 ;I $D(PRCERR)
 K PRC4423,PRCIEN
 S PRCIEN(1)=77
 S PRC4423(442.3,"+1,",.01)="Returned to Service by eCMS (P&C)"
 S PRC4423(442.3,"+1,",.02)=77
 D UPDATE^DIE("","PRC4423","PRCIEN","PRCERR")
 K PRC4423,PRCIEN
UPDT ; Update status 70 to new text
 S PRC4423(442.3,"70,",.01)="To IFCAP Ordering Officer"
 D FILE^DIE("","PRC4423","PRCERR")
 K PRC4423
 ;
ID ; covered by ICR #5819
 D MES^XPDUTL("  - Setting ID nodes for file #410 and subfile #410.02")
 S ^DD(410,0,"ID","Z3")="D:$P($G(^(1)),U,8)]"""" EN^DDIOL(""Sent to eCMS"",,""?0""),EN^DDIOL("" "",,""!?2"")"
 S ^DD(410.02,0,"ID","Z2")="D:$P($G(@(DIC_+Y_"",4)"")),U,3)]"""" EN^DDIOL(""eCMS Item Line ID ""_$P(^(4),U,3),,""!?10"")"
 D MES^XPDUTL("  - ID nodes set")
 ;
 Q 
