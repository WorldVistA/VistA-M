XU8P531 ;BT/BP-OAK Person Class File APIs; 7/8/09
 ;;8.0;KERNEL;**531**; July 10, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
POST ;
 D CORSP(77,904) ; correct SPECIALTY CODE for the entry #904
 D EDIT ; inactivate entries #1037 and 1066 and edit #198 and 669
 D DEL ; delete entries 1153-1158 if existed before this patch
 D ADD ; add new entries #1153-1158
 D DEF^XU8P531A,DEF^XU8P531B ; update definitons
 D DELXU8P ; delete post rotines XU8P531A and XU8P531B 
 Q
 ;
CORSP(XUPRO,XUIEN) ; correct SPECIALTY CODE by IEN
 I $G(XUPRO)="" Q
 I $G(XUIEN)'=+$G(XUIEN) Q
 S $P(^USC(8932.1,XUIEN,0),"^",9)="" ;clean the data before update
 D SETSP(XUPRO,XUIEN)
 Q
 ;
SETSP(XUPRO,XUIEN) ;set/add SPECIALTY CODE by IEN
 I $G(XUPRO)="" Q
 I $G(XUIEN)'=+$G(XUIEN) Q
 N DR,DIE,DA S DR="8///^S X=XUPRO",DIE="^USC(8932.1,",DA=XUIEN D ^DIE
 Q
 ;
DELXU8P ;
 ;Delete the routine XU8P509A,B,C,D:
 N X F X="XU8P531A","XU8P531B" X ^%ZOSF("DEL")
 Q
 ;
ADD ; Add new entries from 1153-1158
 N XUI,XUDATA
 F XUI=1:1:6 S XUDATA=$T(DATA+XUI) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . D ADD1(XUDATA)
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
 N XUI F XUI=1153:1:1158 D
 . N DIK,DA S DIK="^USC(8932.1,",DA=XUI D ^DIK
 Q
 ;
GET ;Get information of entries from the Person Class file
 N XUI
 F XUI=1153:1:1158 D GET1(XUI)
 Q
 ;
GET1(XUIEN) ; Get information of given entry from Person Class file.
 N XUI
 S XUI=$G(^USC(8932.1,XUIEN,0))
 S XUI=" ;;"_XUIEN_"^"_$P(XUI,"^",1,3)_"^"_$P(XUI,"^",6,9) W !,XUI
 Q
 ;
DATA ; information of entries from 1153-1156
 ;;1153^Other Service^Health Educator^^V081902^174H00000X^
 ;;1154^Allopathic & Osteopathic Physicians^Pediatrics^Child Abuse Pediatrics^V180506^2080C0008X^37
 ;;1155^Nursing Service Related^Doula^^V170603^374J00000X^
 ;;1156^Nursing Service Related^Religious Nonmedical Practitioner^^V170101^374K00000X^
 ;;1157^Allopathic & Osteopathic Physicians^Phlebology^^V182415^202K00000X^22
 ;;1158^Allopathic & Osteopathic Physicians^Pathology^Clinical Pathology^V182416^207ZC0006X^22
 ;;END
 ;;
EDIT ;Edit entries 198,669
 N FDA S FDA(8932.1,"198,",2)="Occupational Health" D FILE^DIE("","FDA","ZZERR")
 N FDA S FDA(8932.1,"669,",1)="Religious Nonmedical Nursing Personnel" D FILE^DIE("","FDA","ZZERR")
 ; inactivate the entry #1037,1066
 N FDA S FDA(8932.1,"1037,",3)="i",FDA(8932.1,"1037,",4)=3091001 D FILE^DIE("","FDA","ZZERR")
 N FDA S FDA(8932.1,"1066,",3)="i",FDA(8932.1,"1066,",4)=3091001 D FILE^DIE("","FDA","ZZERR")
 Q
