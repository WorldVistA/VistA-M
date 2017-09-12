XU8P581 ; BA/BP - PERSON CLASSES; 07/27/11
 ;;8.0;KERNEL;**581**; July 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;
 D DEL ;clean entry 1171-1173 if existed
 D ADD ;add entry 1171-1173 in the file
 D DEF ;update definition for entries
 Q
 ;
ADD ;add the entry 1171-1173
 N XUDATA
 S XUDATA="1171^Allopathic & Osteopathic Physicians^Internal Medicine^Hypertension Specialist^a^^V182605^207RH0005X^^11^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1172^Respiratory, Developmental, Rehabilitative and Restorative^Clinical Exercise Physiologist^^a^^V130601^224Y00000X^^25^^I"
 D ADD1(XUDATA)
 N XUDATA
 S XUDATA="1173^Suppliers^Medical Foods Supplier^^a^^^335G00000X^^^^N"
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
 F XU581=1171,1172,1173 S DIK="^USC(8932.1,",DA=XU581 D ^DIK
 Q
 ;
DEF ; Update definitions
 N XUI
 F XUI=1171,1172,1173 D DEF1(XUI)
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
1171 ;
 ;;A Hypertension Specialist is a physician who concentrates on all aspects 
 ;;of the diagnosis and treatment of hypertension.
 ;; 
 ;;Source: American Society of Hypertension
 ;;Additional Resources: The American Society of Hypertension Specialists 
 ;;Program offers an examination and designation for Hypertension 
 ;;Specialists.  This subspecialty is not a Board certificate issued by 
 ;;either the American Board of Internal Medicine or the American 
 ;;Osteopathic Board of Internal Medicine.
 ;;END
1172 ;
 ;;A Clinical Exercise Physiologist is a health care professional who is 
 ;;trained to work with patients with chronic disease where exercise 
 ;;training has been shown to be of therapeutic benefit, including but not 
 ;;limited to cardiovascular and pulmonary disease, and metabolic disorders.
 ;; 
 ;;Source: What is a Clinical Exercise Physiologist? Clinical Exercise 
 ;;Physiology Association (CEPA), CEPA Executive Board, 2008 
 ;;END
1173 ;
 ;;A supplier of special replacement foods for clients with errors of 
 ;;metabolism that prohibit them from eating a regular diet. Medical foods 
 ;;are lacking in the compounds which cause complications of the metabolic 
 ;;disorder, and are not generally available in grocery stores, health food 
 ;;stores, or pharmacies.
 ;; 
 ;;Source: The Children with Special Healthcare Needs (CSHCN) Services 
 ;;Program, a program of the Texas Department of State Health Services.
 ;;END
 ;
GETDATA ; get definitions
 N XUI,XUY
 F XUI=1171,1172,1173 D
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
 N XU581
 F XU581=1171,1172,1173 D GET1(XU581)
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
