MHVXCLN ;WAS/DLF/KUM - Clinic extract ; 9/25/08 4:10pm
 ;;1.0;My HealtheVet;**6,10**;Aug 23, 2005;Build 50
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;               10103 : $$DT^XLFDT
 ;                       $$NOW^XLFDT
 ;               10004 : $$GET1^DIQ
 ;               10040 : ^SC("B"
 ;                4482 : ^SC("ACST"
 ;                  93 : Fields IEN and Stop Code Number in Hospital Location File (#44)
 ;                 557 : ^DIC(40.7       
 ;
CLIN(QRY,ERR,DATAROOT)               ; return all Clinics
 ;
 ; return provider data in DATAROOT
 ; QRY, ERR passed by ref.
 ;
 ;  Input:
 ;       QRY - Query array
 ;
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array
 ;             includes number of hits and timestamp
 ;       ERR - Errors during extraction, zero on success
 ;
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,CLIEN,CLNM,X
 ;
 S LOGND=$T(+0)_"^CLINIC"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S CLNM=$O(^SC("B",QRY("LNAME")),-1)
 I QRY("LNAME")="" S CLNM=99
 S DATAROOT=$E(DATAROOT,1,$L(DATAROOT)-1)_","_"""CLINICS"""_")"
 F  S CLNM=$O(^SC("B",CLNM)) Q:CLNM=""  D
 .S CLIEN=0
 .S CLIEN=$O(^SC("B",CLNM,CLIEN))
 .I $E(CLNM,1,$L(QRY("LNAME")))=QRY("LNAME")  D
 ..S HIT=HIT+1
 ..S @DATAROOT@(HIT)=CLIEN_U_CLNM
 ;
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 D XITLOG(LOGND,HIT)
 ;
 Q
SPCLIN(QRY,ERR,DATAROOT)               ; return all Clinics with Stop Code 719
 ;
 ; return provider data in DATAROOT
 ; QRY, ERR passed by ref.
 ;
 ;  Input:
 ;       QRY - Query array
 ;
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array
 ;             includes number of hits and timestamp
 ;       ERR - Errors during extraction, zero on success
 ;
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVCLIEN,MHVCLNM,MHVCSIEN,MHVCLPSC,MHVPSCIE,MHVPSCNU,X
 ;
 S LOGND=$T(+0)_"^CLINIC"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 ;I $G(QRY("FNAME"))=""!$G(QRY("FNAME"))=0 S ERR="1^Stop Code cannot be null." Q
 S MHVCSIEN=$$SCIEN($G(QRY("FNAME")))
 ;I $G(MHVCSIEN)=""!$G(MHVCSIEN)=0 S ERR="2^Unknown Stop Code:"_$G(QRY("FNAME")) Q
 S MHVCLIEN=0
 F  S MHVCLIEN=$O(^SC("ACST",MHVCSIEN,MHVCLIEN)) Q:'MHVCLIEN  D
 .S MHVCLNM=$$GET1^DIQ(44,+MHVCLIEN,.01,"I")
 .I ($G(MHVCLNM)'="")&($$UP^XLFSTR($E(MHVCLNM,1,$L($G(QRY("LNAME")))))=$G(QRY("LNAME"))!($G(QRY("LNAME"))=""))  D
 ..S HIT=HIT+1
 ..S MHVCLPSC=$$GET1^DIQ(44,+MHVCLIEN,8,"E")
 ..S MHVPSCIE=$$GET1^DIQ(44,+MHVCLIEN,8,"I")
 ..S MHVPSCNU=$$GET1^DIQ(40.7,+MHVPSCIE,1,"I")
 ..S @DATAROOT@(HIT)=MHVCLIEN_U_MHVCLNM_U_MHVPSCIE_U_MHVCLPSC_U_MHVPSCNU
 ;
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 D XITLOG(LOGND,HIT)
 ;
 Q
XITLOG(ND,HT)     ; exit log
 D LOG^MHVUL2(ND,HT_" HITS","S","TRACE")
 D LOG^MHVUL2(ND,"END","S","TRACE") Q
 Q
SCIEN(SCN) ;Get stop code IEN
 N SCIEN
 I SCN="" Q ""
 S SCIEN=$O(^DIC(40.7,"C",SCN,0))
 I $G(SCIEN)="" Q ""
 Q SCIEN
 ;
