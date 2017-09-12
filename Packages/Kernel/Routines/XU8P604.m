XU8P604 ; BA/BP - PERSON CLASSES;08/20/12
 ;;8.0;KERNEL;**604**; July 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Update Person Class file for 10/01/2012
POST ;
 D DEL ;clean entry 1210-1211 if existed
 D ADD ;add entry 1210-1211 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1210-1211
 N XUDATA
 S XUDATA="1210^Dental Providers^Dental Therapist^^a^^V030101^125J00000X^^^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1211^Dental Providers^Advanced Practice Dental Therapist^^a^^V030102^125K00000X^^^^^I"
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
 F XU581=1210:1:1211 S DIK="^USC(8932.1,",DA=XU581 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI D DEF1(1210)
 N XUI D DEF1(1211)
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
GETDEF ; get definitions
 N XUI,XUY
 F XUI=1210:1:1211 D
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
 N XU591
 F XU591=1210:1:1211 D GET1(XU591)
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
1210 ;
 ;;A Dental Therapist is an individual who has completed an accredited or 
 ;;non-accredited dental therapy program and who has been authorized by the 
 ;;relevant state board or a tribal entity to provide services within the 
 ;;scope of their practice under the supervision of a dentist. Functions 
 ;;that may be delegated to the dental therapist vary based on the needs of 
 ;;the dentist, the educational preparation of the dental therapist and 
 ;;state dental practice acts and regulations.
 ;; 
 ;;Source: Summarized from Minnesota Statute 150A.105
 ;;END
1211 ;
 ;;An Advanced Practice Dental Therapist is:
 ;;(1) A dental therapist who has completed additional training beyond basic 
 ;;dental therapy education and provides dental services in accordance with 
 ;;state advanced practice dental therapist laws or statutes; or
 ;;(2) A dental hygienist with a graduate degree in advanced dental therapy 
 ;;prepared for independent and interdependent decision making and direct 
 ;;accountability for clinical judgment across the dental health care 
 ;;continuum.
 ;; 
 ;;The individual has been authorized by the relevant state board or a 
 ;;tribal entity to provide services under the remote supervision of a 
 ;;dentist. The functions of the advanced practice dental therapist vary 
 ;;based on the needs of the dentist, the educational preparation of the 
 ;;advanced practice dental therapist and state dental practice acts and 
 ;;regulations. 
 ;; 
 ;;Source: Summarized from Minnesota Statute 150A.105
 ;;END
