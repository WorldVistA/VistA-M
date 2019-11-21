TIUP323 ;BIZ/WPB  - POST ROUTINE TO SET UP THE LINK FOR TIUCCRA; 02/01/2019
 ;;1.0;TEXT INTEGRATION UTILITIES;**323**;Feb 1, 2019;Build 33
 ;
 ;Reference to $$KSP^XUPARAM("INST") Supported by DBIA2541
 ;Reference to IA#3550
 ;Reference to IA#3335
 Q
POST ;
 D LINK,SENDAPP,RECAPP
 Q
LINK ; update the TIUCCRA Link
 N LIEN,OPSITE,DOMAIN,VAL,TIUERR
 I $G(XPDQUES("POST1"))'?.3N1".".3N1".".3N1".".3N W !,"IP Address is in the wrong format!" Q  ; check for correct ip format
 S VAL="TIUCCRA"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL) Q:'LIEN
 S FDA(870,LIEN_",",.02)=$$KSP^XUPARAM("INST") ; site station number
 S FDA(870,LIEN_",",4.5)=1 ; auto start
 S FDA(870,LIEN_",",400.01)=$G(XPDQUES("POST1")) ; ip address
 S FDA(870,LIEN_",",400.02)=$G(XPDQUES("POST2")) ; hl7 port
 D FILE^DIE(,"FDA","TIUERR") K FDA
 D MES^XPDUTL("")
 I $D(TIUERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the TIUCCRA Link.")
 D MES^XPDUTL("TIUCCRA Link has been updated.")
 Q
SENDAPP ; update the HL7 Application Parameter file to add Facility Name
 N AIEN,VAL,TIUCERR
 S VAL="TIU CCRA SEND"
 S AIEN=$$FIND1^DIC(771,,"B",.VAL) Q:'AIEN
 S FDA(771,AIEN_",",3)=$$KSP^XUPARAM("INST") ; update facility
 D FILE^DIE(,"FDA","TIUCERR") K FDA
 D MES^XPDUTL("")
 I $D(TIUCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the TIU CCRA SEND Application Parameter.")
 D MES^XPDUTL("The TIU CCRA SEND Application Parameter has been updated.")
 Q
RECAPP ; update the HL7 Application Parameter file to add Facility Name
 N AIEN,VAL,TIUERR
 S VAL="TIU CCRA RECEIVE"
 S AIEN=$$FIND1^DIC(771,,"B",.VAL) Q:'AIEN
 S FDA(771,AIEN_",",3)=200 ; update facility
 D FILE^DIE(,"FDA","TIUERR") K FDA
 D MES^XPDUTL("")
 I $D(TIUERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the GMRC CCRA RECEIVE Application Parameter.")
 D MES^XPDUTL("The TIU CCRA RECEIVE Application Parameter has been updated.")
 Q
