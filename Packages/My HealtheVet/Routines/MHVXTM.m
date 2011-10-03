MHVXTM ;WAS/DLF - team extracts ; 9/25/08 4:12pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Integration Agreements:
 ;                2692 : TEAMS^ORQPTQ1
 ;               10103 : $$DT^XLFDT
 ;                       $$NOW^XLFDT
 ;              
 ;
TEAM(QRY,ERR,DATAROOT)             ; return all OE/RR teams
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
 N DT,EXTIME,HIT,KEYNM,LOGND,TMIEN,TMNM,U,X
 ;
 S LOGND=$T(+0)_"^TEAM"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S U="^",DT=$$DT^XLFDT,ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 D TEAMS^ORQPTQ1(.MHVTMAR)
 S (X,HIT)=0
 F  S X=$O(MHVTMAR(X)) Q:X=""  D
 .I $E($P(MHVTMAR(X),U,2),1,$L(QRY("LNAME")))=QRY("LNAME")  D
 ..S TMIEN=$P(MHVTMAR(X),U)
 ..S TMNM=$P(MHVTMAR(X),U,2)
 ..S HIT=HIT+1
 ..S @DATAROOT@("TEAMS",HIT)=TMIEN_U_TMNM
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 D XITLOG(LOGND,HIT)
 K MHVTMAR
 ;
 Q
XITLOG(ND,HT)     ; exit log
 D LOG^MHVUL2(ND,HT_" HITS","S","TRACE")
 D LOG^MHVUL2(ND,"END","S","TRACE") Q
 Q
