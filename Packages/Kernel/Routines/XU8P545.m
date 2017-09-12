XU8P545 ; BA/BP - LIST USERS HAVE INACTIVE PERSON CLASSES; 8/12/10
 ;;8.0;KERNEL;**545**; July 10, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
POST ;
 D UPDPSC ;update the Person Class file
 D SET741("N",741) ;update 741 to Non_individual taxonomy
 D DELXU8P ;delete the routine XU8P545A
 Q
 ;
UPDPSC ;
 D DEL ;clean entry 1163-1166 if existed
 D ADD ;add entry 1161 in the file
 D DEF^XU8P545A ;update definition for entries
 Q
 ;
DELXU8P ;Delete the routine XU8P545A
 N X S X="XU8P545A" X ^%ZOSF("DEL")
 Q
 ;
SET741(XUPRO,XUIEN) ;set/add Individual field by IEN
 I $G(XUPRO)="" Q
 I $G(XUIEN)'=+$G(XUIEN) Q
 N DR,DIE,DA S DR="90002///^S X=XUPRO",DIE="^USC(8932.1,",DA=XUIEN D ^DIE
 Q
ADD ;add the entry 1163 and 1166
 N XUDATA S XUDATA="1163^Respiratory, Rehabilitative and Restorative Service Provider^Mastectomy Fitter^^V130216^224900000X^^I"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1164^Respiratory, Rehabilitative and Restorative Service Providers^Pedorthist^^V130313^224L00000X^^I"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1165^Other Service Providers^Meals^^^174200000X^^N"
 D ADD1(XUDATA)
 N XUDATA S XUDATA="1166^Allopathic & Osteopathic Physicians^Orthopaedic Surgery^Pediatric Orthopaedic Surgery^V182107^207XP3100X^^I"
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
DEL ; Delete entries
 N XU545,DIK,DA F XU545=1163:1:1166 S DIK="^USC(8932.1,",DA=XU545 D ^DIK
 Q
 ;
GET ;
 N XU545
 F XU545=1163:1:1166 D GET1(XU545)
 Q
 ;
GET1(XUIEN) ; Get information of given entry from Person Class file.
 N XUI
 S XUI=$G(^USC(8932.1,XUIEN,0))
 S XUI=" ;;"_XUIEN_"^"_$P(XUI,"^",1,3)_"^"_$P(XUI,"^",6,9) W !,XUI
 Q
 ;
GETDATA ; get definitions
 N XUI,XUY
 F XUI=609,610,408,410,1095,1116,1163,1164,1165,1166 D
 . S XUY=$G(^USC(8932.1,XUI,11,0)),XUY=$P(XUY,"^",3)
 . I XUY>0 D GETDES(XUI,XUY)
 Q
 ;
GETDES(XUI,XUY) ; get single entry definition
 N XUA,XUB
 W !,XUI," ;"
 F XUA=1:1:XUY W !," ;;",$G(^USC(8932.1,XUI,11,XUA,0))
 W !," ;;END"
 Q
DEF ; Update definitions
 N XUI
 F XUI=609,610,408,410,1095,1116,1163,1164,1165,1166 D
 . D DEF1(XUI)
 Q
 ;
DEF1(XUI) ; Update definition for single entry XUI
 N XUI1,XUDATA,XUY
 K ^TMP($J,"XUBA")
 F XUY=1:1:100 S XUDATA=$T(@XUI+XUY) Q:XUDATA=" ;;END"  D 
 . S ^TMP($J,"XUBA",XUI,XUY,0)=$P(XUDATA,";;",2)
 S XUI1=XUI_","
 D WP^DIE(8932.1,XUI1,11,"K","^TMP($J,""XUBA"",XUI)")
 K ^TMP($J,"XUBA")
 Q
