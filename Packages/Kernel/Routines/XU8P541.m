XU8P541 ; BA/BP - LIST USERS HAVE INACTIVE PERSON CLASSES; 4/28/10
 ;;8.0;KERNEL;**541**; July 10, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;
 D ADDOP ;add a new option under the XUSER menu option
 D UPDPSC ;update the Person Class file
 D DELXU8P ;delete the routine XU8P541A
 Q
 ;
ADDOP ; Add a new option under the XUSER menu option.
 N XUA,XUB,XUC
 S XUA="XUSER"
 S XUB="XU-INACTIVE PERSON CLASS USERS"
 IF $$FIND1^DIC(19,,"X",XUA,,,),$$FIND1^DIC(19,,"X",XUB,,,) S XUC=$$ADD^XPDMENU(XUA,XUB,,)
 Q
 ;
UPDPSC ;
 D DEL ;clean entry 1161 if existed
 D ADD ;add entry 1161 in the file
 D DEF^XU8P541A ;update definition for entries
 Q
 ;
DELXU8P ;Delete the routine XU8P541A
 N X S X="XU8P541A" X ^%ZOSF("DEL")
 Q
 ;
ADD ;add the entry 1161 and 1162
 N XUDATA S XUDATA="1161^Transportation Services^Air Carrier^^^344800000X^^N"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1162^Technologists, Technicians & Other Technical Service^Perfusionist^^V151002^242T00000X^^I"
 D ADD1(XUDATA)
 Q
 ;
ADD1(XUDATA) ; add single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",5)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",6)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",8)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
DEL ; Delete entry
 N DIK,DA S DIK="^USC(8932.1,",DA=1161 D ^DIK
 N DIK,DA S DIK="^USC(8932.1,",DA=1162 D ^DIK
 Q
 ;
