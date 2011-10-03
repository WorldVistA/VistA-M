MHVXCLN ;WAS/DLF - Clinic extract ; 9/25/08 4:10pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;               10103 : $$DT^XLFDT
 ;                       $$NOW^XLFDT
 ;               10040 : ^SC("B"
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
 N DT,EXTIME,HIT,KEYNM,LOGND,CLINAR,CLIEN,CLNM,U,X
 ;
 S LOGND=$T(+0)_"^CLINIC"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S U="^",DT=$$DT^XLFDT,ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
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
XITLOG(ND,HT)     ; exit log
 D LOG^MHVUL2(ND,HT_" HITS","S","TRACE")
 D LOG^MHVUL2(ND,"END","S","TRACE") Q
 Q
