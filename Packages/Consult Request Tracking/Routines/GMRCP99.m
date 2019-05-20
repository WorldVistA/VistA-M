GMRCP99 ;BIZ/WPB  - POST ROUTINE TO SET UP THE LINK FOR GMRCCCRA; 03/15/18
 ;;3.0;CONSULT/REQUEST TRACKING;**99**;FEB 27, 2018;Build 29
 ;
 ;Reference to $$KSP^XUPARAM("INST") Supported by DBIA2541
 ;Reference to IA#3550
 ;Reference to IA#3335
 ;Reference to IA#4316
 ;Reference to IA#2061
 Q
POST ;
 D LINK,SENDAPP,RECAPP,UPDTMGRP
 Q
LINK ; update the GMRCCRA Link
 N LIEN,OPSITE,DOMAIN,VAL,GMRCERR
 I $G(XPDQUES("POST1"))'?.3N1".".3N1".".3N1".".3N W !,"IP Address is in the wrong format!" Q  ; check for correct ip format
 S VAL="GMRCCCRA"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL) Q:'LIEN
 S FDA(870,LIEN_",",.02)=$$KSP^XUPARAM("INST") ; site station number
 S FDA(870,LIEN_",",4.5)=1 ; auto start
 S FDA(870,LIEN_",",400.01)=$G(XPDQUES("POST1")) ; ip address
 S FDA(870,LIEN_",",400.02)=$G(XPDQUES("POST2")) ; hl7 port
 D FILE^DIE(,"FDA","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the GMRCCCRA Link.")
 D MES^XPDUTL("GMRCCCRA Link has been updated.")
 Q
SENDAPP ; update the HL7 Application Parameter file to add Facility Name
 N AIEN,VAL,GMRCERR
 S VAL="GMRC CCRA SEND"
 S AIEN=$$FIND1^DIC(771,,"B",.VAL) Q:'AIEN
 S FDA(771,AIEN_",",3)=$$KSP^XUPARAM("INST") ; update facility
 D FILE^DIE(,"FDA","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the GMRC CCRA SEND Application Parameter.")
 D MES^XPDUTL("The GMRC CCRA SEND Application Parameter has been updated.")
 Q
RECAPP ; update the HL7 Application Parameter file to add Facility Name
 N AIEN,VAL,GMRCERR
 S VAL="GMRC CCRA RECEIVE"
 S AIEN=$$FIND1^DIC(771,,"B",.VAL) Q:'AIEN
 S FDA(771,AIEN_",",3)=200 ; update facility
 D FILE^DIE(,"FDA","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the GMRC CCRA RECEIVE Application Paramter.")
 D MES^XPDUTL("The GMRC CCRA RECEIVE Application Parameter has been updated.")
 Q
PROTO ; add protocol as ITEM to the GMRC EVSEND OR Protocol
 Q
 N GMRCPRTCL,GMRCIEN,GMRCIEN1,GMRCERR
 S GMRCPRTCL="GMRC CONSULTS TO CCRA",GMRCIEN=$O(^ORD(101,"B",GMRCPRTCL,0))
 S Y="GMRC EVSEND OR",GMRCIEN1=$O(^ORD(101,"B",Y,0))
 K FDA,GMRCERR
 S FDA(101.01,"+1,"_GMRCIEN1_",",.01)=GMRCIEN
 D UPDATE^DIE("","FDA","PRTCLITM","GMRCERR") ; add the protocol
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when adding ITEM to GMRC EVSEND OR protocol")
 D MES^XPDUTL("GRMC CONSULTS TO CCRA has been added to GMRC EVSEND OR Protocol.")
 Q
UPDTMGRP ; get the Alert notification mail group from the HL7 site parameters file and add the CCRA dev ops mail group to the remote members 
 N MGPIEN,FDA,GMRCERR
 S MGPIEN=$$GET1^DIQ(869.3,"1,",.05,"I")_","  ;DBIA4316
 S FDA(3.812,"?+1,"_MGPIEN,.01)="devops.ccra@domain.ext"  ;DBIA2061
 D UPDATE^DIE("","FDA","MGPIEN","GMRCERR")
 Q
