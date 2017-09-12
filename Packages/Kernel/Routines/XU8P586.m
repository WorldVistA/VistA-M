XU8P586 ; BA/BP - PERSON CLASSES;09/22/11
 ;;8.0;KERNEL;**586**; July 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;
 D DEL ;clean entry 1174-1175 if existed
 D ADD ;add entry 1174-1175 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1174-1175
 N XUDATA
 S XUDATA="1174^Optometry^Optometry Resident^^a^^V060808^390200000X^^41^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1175^Podiatry^Podiatry Resident^^a^^V120213^390200000X^^48^^^I"
 D ADD1(XUDATA)
 Q
 ;^USC(8932.1,D0,0)= (#.01) PROVIDER TYPE [1F] ^ (#1) CLASSIFICATION [2F] ^ 
 ;                ==>(#2) AREA OF SPECIALIZATION [3F] ^ (#3) STATUS [4S] ^ (#4) 
 ;                ==>DATE INACTIVATED [5D] ^ (#5) VA CODE [6F] ^ (#6) X12 CODE 
 ;                ==>[7F] ^ (#7) reserved [8F] ^ (#8) SPECIALTY CODE [9F] ^ 
 ;^USC(8932.1,D0,11,0)=^8932.111^^  (#11) DEFINITION
 ;^USC(8932.1,D0,11,D1,0)= (#.01) DEFINITION [1W] ^ 
 ;^USC(8932.1,D0,90002)=  ^ (#90002) INDIVIDUAL/NON [2S] ^
 ;
ADD1(XUDATA) ; add single entry
 N FDA,FDAIEN,XUD
 S XUD=$G(XUDATA)
 S FDAIEN(1)=$P(XUD,"^")
 S FDA(8932.1,"+1,",.01)=$P(XUD,"^",2)
 S FDA(8932.1,"+1,",1)=$P(XUD,"^",3)
 S FDA(8932.1,"+1,",2)=$P(XUD,"^",4)
 S FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",5)=$P(XUD,"^",7)
 S FDA(8932.1,"+1,",6)=$P(XUD,"^",8)
 S FDA(8932.1,"+1,",8)=$P(XUD,"^",10)
 S FDA(8932.1,"+1,",90002)=$P(XUD,"^",12)
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
 ;
DEL ; Delete entries
 N XU581,DIK,DA
 F XU581=1174,1175 S DIK="^USC(8932.1,",DA=XU581 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 F XUI=1174,1175 D DEF1(XUI)
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
 ;
1174 ;
 ;;An individual who is enrolled in an organized health care 
 ;;education/training program leading to a degree, certification, 
 ;;registration, and/or licensure to provide health care. 
 ;;END
1175 ;
 ;;An individual who is enrolled in an organized health care 
 ;;education/training program leading to a degree, certification, 
 ;;registration, and/or licensure to provide health care. 
 ;;END
 ;
GETDEF ; get definitions
 N XUI,XUY
 F XUI=1174,1175 D
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
GET ;
 N XU586
 F XU586=1174,1175 D GET1(XU586)
 Q
 ;
GET1(XUIEN) ; Get information of given entry from Person Class file.
 N XUI
 S XUI=" ;;"_XUIEN_"^"_$G(^USC(8932.1,XUIEN,0))
 S $P(XUI,"^",12)=$G(^USC(8932.1,XUIEN,90002))
 W !," N XUDATA"
 W !," S XUDATA=","""",$P(XUI,";;",2),""""
 W !," D ADD1(XUDATA)"
 Q
