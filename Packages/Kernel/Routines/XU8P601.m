XU8P601 ; BA/BP - PERSON CLASSES;06/25/12
 ;;8.0;KERNEL;**601**; July 10, 1995;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Update Person Class file for 06/01/2012
POST ;
 D DEL ;clean entry 1180-1209 if existed
 D ADD ;add entry 1180-1209 in the file
 D DEF^XU8P601A ;update definition for entries
 D DEF^XU8P601B ;update definition for entries
 N X F X="XU8P601A","XU8P601B" X ^%ZOSF("DEL") ;delete routine.
 Q
 ;
ADD ;add the entry 1180-1209
 N XUDATA
 S XUDATA="1180^Behavioral Health & Social Service Providers^Psychoanalyst^^a^^V010423^102L00000X^^26^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1181^Behavioral Health & Social Service Providers^Poetry Therapist^^a^^V010701^102X00000X^^26^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1182^Chiropractic Providers^Chiropractor^Rehabilitation^a^^V020601^111NR0400X^^35^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1183^Allopathic & Osteopathic Physicians^Anesthesiology^Hospice and Palliative Medicine^a^^V180204^207LH0002X^^05^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1184^Allopathic & Osteopathic Physicians^Anesthesiology^Pediatric Anesthesiology^a^^V180205^207LP3000X^^05^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1185^Allopathic & Osteopathic Physicians^Emergency Medicine^Hospice and Palliative Medicine^a^^V180606^207PH0002X^^93^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1186^Allopathic & Osteopathic Physicians^Family Medicine^Bariatric Medicine^a^^V180708^207QB0002X^^08^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1187^Allopathic & Osteopathic Physicians^Family Medicine^Hospice and Palliative Medicine^a^^V180709^207QH0002X^^08^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1188^Allopathic & Osteopathic Physicians^Internal Medicine^Bariatric Medicine^a^^V181022^207RB0002X^^11^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1189^Allopathic & Osteopathic Physicians^Internal Medicine^Hospice and Palliative Medicine^a^^V181023^207RH0002X^^11^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1190^Allopathic & Osteopathic Physicians^Internal Medicine^Sleep Medicine^a^^V181024^207RS0012X^^11^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1191^Allopathic & Osteopathic Physicians^Internal Medicine^Transplant Hepatology^a^^V181025^207RT0003X^^11^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1192^Allopathic & Osteopathic Physicians^Obstetrics & Gynecology^Bariatric Medicine^a^^V181808^207VB0002X^^16^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1193^Allopathic & Osteopathic Physicians^Obstetrics & Gynecology^Hospice and Palliative Medicine^a^^V181809^207VH0002X^^16^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1194^Allopathic & Osteopathic Physicians^Otolaryngology^Sleep Medicine^a^^V182207^207YS0012X^^04^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1195^Allopathic & Osteopathic Physicians^Pediatrics^Hospice and Palliative Medicine^a^^V182518^2080H0002X^^37^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1196^Allopathic & Osteopathic Physicians^Pediatrics^Sleep Medicine^a^^V182519^2080S0012X^^37^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1197^Allopathic & Osteopathic Physicians^Pediatrics^Pediatric Transplant Hepatology^a^^V182520^2080T0004X^^37^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1198^Allopathic & Osteopathic Physicians^Physical Medicine & Rehabilitation^Neuromuscular Medicine^a^^V182605^2081N0008X^^25^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1199^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Bariatric Medicine^a^^V182915^2084B0002X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1200^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Behavioral Neurology & Neuropsychiatry^a^^V182916^2084B0040X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1201^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Diagnostic Neuroimaging^a^^V182917^2084D0003X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1202^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Hospice and Palliative Medicine^a^^V182918^2084H0002X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1203^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Neuromuscular Medicine^a^^V182919^2084N0008X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1204^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Psychosomatic Medicine^a^^V182920^2084P0015X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1205^Allopathic & Osteopathic Physicians^Psychiatry & Neurology^Sleep Medicine^a^^V182921^2084S0012X^^86^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1206^Allopathic & Osteopathic Physicians^Radiology^Diagnostic Neuroimaging^a^^V183011^2085D0003X^^94^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1207^Allopathic & Osteopathic Physicians^Radiology^Hospice and Palliative Medicine^a^^V183012^2085H0002X^^94^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1208^Allopathic & Osteopathic Physicians^Surgery^Hospice and Palliative Medicine^a^^V183108^2086H0002X^^02^^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1209^Allopathic & Osteopathic Physicians^Urology^Pediatric Urology^a^^V183402^2088P0231X^^34^^^I"
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
 F XU581=1180:1:1209 S DIK="^USC(8932.1,",DA=XU581 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 F XUI=1180:1:1209 D DEF1(XUI)
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
 F XUI=1180:1:1209 D
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
 F XU591=1180:1:1209 D GET1(XU591)
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
