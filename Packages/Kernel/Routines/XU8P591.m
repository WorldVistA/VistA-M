XU8P591 ; BA/BP - PERSON CLASSES;03/16/12
 ;;8.0;KERNEL;**591**; July 10, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Update Person Class file for 01/01/2012
POST ;
 D DEL ;clean entry 1176-1179 if existed
 D ADD ;add entry 1176-1179 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1176-1179
 N XUDATA
 S XUDATA="1176^Allopathic & Osteopathic Physicians^Obstetrics & Gynecology^Female Pelvic Medicine and Reconstructive Surgery^a^^V181807^207VF0040X^^16^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1177^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Behavioral Neurology & Neuropsychiatry^a^^V182914^2084B0040X^^26^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1178^Allopathic & Osteopathic Physicians^Urology^Female Pelvic Medicine and Reconstructive Surgery^a^^V183401^2088F0040X^^34^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1179^Allopathic & Osteopathic Physicians^Anesthesiology^Pediatric Anesthesiology^a^^V110403^207LP3000X^^05^^I"
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
 F XU581=1176,1177,1178,1179 S DIK="^USC(8932.1,",DA=XU581 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 F XUI=1176,1177,1178,1179 D DEF1(XUI)
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
1176 ;
 ;;A subspecialist in Female Pelvic Medicine and Reconstructive Surgery is a 
 ;;physician in Urology or Obstetrics and Gynecology who, by virtue of 
 ;;education and training, is prepared to provide consultation and 
 ;;comprehensive management of women with complex benign pelvic conditions, 
 ;;lower urinary tract disorders, and pelvic floor dysfunction. 
 ;;Comprehensive management includes those diagnostic and therapeutic 
 ;;procedures necessary for the total care of the patient with these 
 ;;conditions and complications resulting from them. 
 ;; 
 ;;Source: American Board of Medical Specialties, 2011.
 ;; 
 ;;Resources: www.abms.org 
 ;;END
1177 ;
 ;;Behavioral Neurology & Neuropsychiatry is a medical subspecialty 
 ;;involving the diagnosis and treatment of neurologically based behavioral 
 ;;issues.
 ;; 
 ;;Source: National Uniform Claim Committee.
 ;; 
 ;;Additional Resources: American Academy of Neurology, www.aan.com. 
 ;;END
1178 ;
 ;;A subspecialist in Female Pelvic Medicine and Reconstructive Surgery is a 
 ;;physician in Urology or Obstetrics and Gynecology who, by virtue of 
 ;;education and training, is prepared to provide consultation and 
 ;;comprehensive management of women with complex benign pelvic conditions, 
 ;;lower urinary tract disorders, and pelvic floor dysfunction. 
 ;;Comprehensive management includes those diagnostic and therapeutic 
 ;;procedures necessary for the total care of the patient with these 
 ;;conditions and complications resulting from them. 
 ;; 
 ;;Source: American Board of Medical Specialties, 2011. 
 ;; 
 ;;Resources: www.abms.org
 ;;END
1179 ;
 ;;An anesthesiologist who has had additional skill and experience in and is 
 ;;primarily concerned with the anesthesia, sedation, and pain management 
 ;;needs of infants and children. A pediatric anesthesiologist generally 
 ;;provides services including the evaluation of complex medical problems in 
 ;;infants and children when surgery is necessary, planning and care for 
 ;;children before and after surgery, pain control, anesthesia and sedation 
 ;;for any procedures out of the operating room such as MRI, CT scan, and 
 ;;radiation therapy.   
 ;;Source: American Academy of Pediatrics 7/1/2006
 ;;END
 ;
GETDEF ; get definitions
 N XUI,XUY
 F XUI=1176,1177,1178,1179 D
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
 F XU591=1176,1177,1178,1179 D GET1(XU591)
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
