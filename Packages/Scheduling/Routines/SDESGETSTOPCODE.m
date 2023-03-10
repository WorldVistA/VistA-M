SDESGETSTOPCODE ;ALB/ANU - VISTA SCHEDULING READ STOP CODE DETAILS ;Jan 25,2022@15:01
 ;;5.3;Scheduling;**807**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
GETSTCDDTL(SDSTCDJSON,SDSTCD) ;get all details of Stop Code from CLINIC STOP file #40.7
 ; INPUT:
 ;  SDSTCD - Clinic Stop Code
 ;
 N ERRPOP,ERR,ERRMSG,SDECI,SDSTCDREC,SDSTCDIEN
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D GETSTCDINF
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S SDECI=0,SDSTCDIEN=""
 S ERR=""
 S ERRPOP=0,ERRMSG=""
 Q
 ;
VALIDATE ;Validate required fields are sent
 I $G(SDSTCD)="" D ERRLOG^SDESJSON(.SDSTCDREC,98) S ERRPOP=1 Q
 S SDSTCDIEN=$$FIND1^DIC(40.7,,"X",$G(SDSTCD),"C",,"SDERR")
 I $G(SDSTCDIEN)=""!$G(SDSTCDIEN)=0 D ERRLOG^SDESJSON(.SDSTCDREC,99) S ERRPOP=1 Q
 Q
 ;
GETSTCDINF ; Get Stop Code Information
 N SDFIELDS,SDDATA,SDMSG
 S SDFIELDS=".01;2;3;4;5;6"
 D GETS^DIQ(40.7,SDSTCDIEN_",",SDFIELDS,"IE","SDDATA","SDMSG")
 S SDSTCDREC("Stop Code","Name")=$G(SDDATA(40.7,SDSTCDIEN_",",.01,"E")) ;Stop Code Name
 S SDSTCDREC("Stop Code","IEN")=SDSTCDIEN ;Stop Code IEN
 S SDSTCDREC("Stop Code","Inactive Date")=$$FMTISO^SDAMUTDT($G(SDDATA(40.7,SDSTCDIEN_",",2,"I"))) ;Inactive Date
 S SDSTCDREC("Stop Code","Cost Distribution Center")=$G(SDDATA(40.7,SDSTCDIEN_",",4,"E")) ;Cost Distribution Center
 S SDSTCDREC("Stop Code","Restriction Type")=$G(SDDATA(40.7,SDSTCDIEN_",",5,"E")) ;Restrication Type
 S SDSTCDREC("Stop Code","Restriction Date")=$$FMTISO^SDAMUTDT($G(SDDATA(40.7,SDSTCDIEN_",",6,"I"))) ;Restriction Date
 Q
 ;
BLDJSON ; Build JSON format
 D ENCODE^SDESJSON(.SDSTCDREC,.SDSTCDJSON,.ERR)
 K SDUSRSREC
 Q
 ;
