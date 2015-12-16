MHVXWLC ;KUM - Extractions for SM Work Load Credit ; 3/5/14 9:10am
 ;;1.0;My HealtheVet;**11**;Mar 05, 2014;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;               10103 : $$DT^XLFDT
 ;                       $$NOW^XLFDT
 ;               10004 : $$GET1^DIQ
 ;
SPDSS(QRY,ERR,DATAROOT)               ; return all DSS Unts for Provider and Associated Clinic
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVPRDUZ,MHVACIEN,MHVSTRING,MHVDSS,MHVCOUNT,X,MHVC
 ;
 S LOGND=$T(+0)_"^DSSUNIT"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVPRVDUZ=$G(QRY("PDUZ"))
 S MHVACIEN=$G(QRY("ACLN"))
 S MHVSTRING=MHVACIEN_"^"_MHVPRVDUZ
 D DSSUNT^MHVUMRPC(.MHVDSS,.MHVSTRING)
 F  S MHVCOUNT=$O(MHVDSS(MHVCOUNT)) Q:'MHVCOUNT!($P(MHVDSS(1),"^",1)=0)  D
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=MHVDSS(MHVCOUNT)
 ;
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 I $P($G(MHVDSS(1)),"^",1)=0 S ERR="1^"_$P($G(MHVDSS(1)),"^",2)
 D XITLOG(LOGND,HIT)
 ;
 Q
SPECS(QRY,ERR,DATAROOT)               ; return all ECS Procedures from DSS Unts and Location IEN
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVPRDUZ,MHVACIEN,MHVSTRING,MHVDSS,MHVCOUNT,X
 ;
 S LOGND=$T(+0)_"^ECSPROC"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVDSSIEN=$G(QRY("DSSI"))
 S MHVLOCIEN=$G(QRY("LOCI"))
 S MHVSTRING=MHVDSSIEN_"^"_MHVLOCIEN
 D DSSPROCS^MHVUMRPC(.MHVPROC,.MHVSTRING)
 F  S MHVCOUNT=$O(MHVPROC(MHVCOUNT)) Q:'MHVCOUNT!($P(MHVPROC(1),"^",1)=0)  D
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=MHVPROC(MHVCOUNT)
 ;
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 I $P($G(MHVPROC(1)),"^",1)=0 S ERR="1^"_$P($G(MHVPROC(1)),"^",2)
 D XITLOG(LOGND,HIT)
 ;
 Q
PECLASS(QRY,ERR,DATAROOT)               ; returns Patient Eligibility and Classification Data
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVPRDUZ,MHVACIEN,MHVSTRING,MHVDSS,MHVCOUNT,X
 ;
 S LOGND=$T(+0)_"^PATECLASS"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVPATICN=$G(QRY("PICN"))
 S MHVDSSIEN=$G(QRY("DSSI"))
 S MHVPROCDT=DT
 S MHVSTRING=MHVPATICN_"^"_MHVDSSIEN_"^"_MHVPROCDT
 D PATECLS^MHVUMRPC(.MHVPROC,.MHVSTRING)
 S HIT=HIT+1
 I $G(MHVPROC(MHVCOUNT))="" S MHVPROC(MHVCOUNT)=""
 S @DATAROOT@(HIT)=MHVPROC(MHVCOUNT)
 F  S MHVCOUNT=$O(MHVPROC(MHVCOUNT)) Q:'MHVCOUNT!($P(MHVPROC(1),"^",1)=0)  D
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=MHVPROC(MHVCOUNT)
 ;
 S HIT=HIT-1 ; To take out Classification count as Classification and Primary eligibility are in one segment
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 I $P($G(MHVPROC(1)),"^",1)=0 S ERR="1^"_$P($G(MHVPROC(1)),"^",2)
 D XITLOG(LOGND,HIT)
 ;
 Q
SMPPRB(QRY,ERR,DATAROOT)               ; returns Patient Problem list Data
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVPRDUZ,MHVACIEN,MHVSTRING,MHVDSS,MHVCOUNT,X
 ;
 S LOGND=$T(+0)_"^SMPPRB"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVPATICN=$G(QRY("PICN"))
 S MHVSTRING=MHVPATICN
 D DIAGPL^MHVUMRPC(.MHVPRB,.MHVSTRING)
 F  S MHVCOUNT=$O(MHVPRB(MHVCOUNT)) Q:'MHVCOUNT!($P(MHVPRB(1),"^",1)=0)  D
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=MHVPRB(MHVCOUNT)
 ;
 S MHVC=1
 I $P($G(@DATAROOT@(MHVC)),"^",2)=0 S HIT=0
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 I $P($G(MHVPRB(1)),"^",1)=0 S ERR="1^"_$P($G(MHVPRB(1)),"^",2)
 D XITLOG(LOGND,HIT)
 ;
 Q
SMDIAG(QRY,ERR,DATAROOT)               ; returns Diagnosis Search results
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVPRDUZ,MHVACIEN,MHVSTRING,MHVDSS,MHVCOUNT,X,MHVSCHSTR
 ;
 S LOGND=$T(+0)_"^SMDIAG"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVSCHSTR=$G(QRY("DSRCH"))
 S MHVSTRING="757.01^"_MHVSCHSTR
 D DIAGSRCH^MHVUMRPC(.MHVPRB,.MHVSTRING)
 F  S MHVCOUNT=$O(MHVPRB(MHVCOUNT)) Q:'MHVCOUNT!($P(MHVPRB(1),"^",1)=0)  D
 .S HIT=HIT+1
 .S @DATAROOT@(HIT)=MHVPRB(MHVCOUNT)
 ;
 S MHVC=1
 I $P($G(@DATAROOT@(MHVC)),"^",2)=0 S HIT=0
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 I $P($G(MHVPRB(1)),"^",2)=0 S ERR="1^"_$P($G(MHVPRB(1)),"^",3)
 D XITLOG(LOGND,HIT)
 ;
 Q
SMFILE(QRY,ERR,DATAROOT)               ; File Workload Credit
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
 N EXTIME,HIT,KEYNM,LOGND,CLINAR,MHVSTR,MHVCOUNT,X
 ;
 ;FILE^LOCATION^DSS UNIT^CATEGORY^PROCEDURE DATE TIME^PROCEDURE^PATIENT IEN^ORDERING SECTION^ENTER BY^PAT STATUS^PROVIDER^DX^
 ;ASSOC CLINIC^PATIENT STATUS AND CLASSIFICATION DATA^ELIGIBILITY IEN
 ;
 S LOGND=$T(+0)_"^SMDIAG"  ; node for logging
 D LOG^MHVUL2(LOGND,"BEGIN","S","TRACE")
 ; needed vars.
 S ERR=0,EXTIME=$$NOW^XLFDT,HIT=0
 ;
 K @DATAROOT  ; clean up residue
 S HIT=0
 S MHVCOUNT=0
 ; All validations should be in Validation routine.  
 S MHVSTR=$G(QRY("ECFILE"))_"^"_$G(QRY("ECL"))_"^"_$G(QRY("ECD"))_"^"_$G(QRY("ECC"))_"^"_$G(QRY("ECDT"))_"^"
 S MHVSTR=MHVSTR_$G(QRY("ECP"))_"^"_$G(QRY("ECICN"))_"^"_$G(QRY("ECMN"))_"^"_$G(QRY("ECDUZ"))_"^"_$G(QRY("ECPTSTAT"))_"^"
 S MHVSTR=MHVSTR_$G(QRY("ECU"))_"^"_$G(QRY("ECDX"))_"^"_$G(QRY("EC4"))_"^"_$G(QRY("ECELCL"))
 D FILE^MHVECFLR(.MHVPRB,.MHVSTR)
 S HIT=HIT+1
 S @DATAROOT@(HIT)=MHVPRB(1)
 ;
 S @DATAROOT=HIT_U_EXTIME  ; hits ^ time
 D XITLOG(LOGND,HIT)
 ;
 Q
XITLOG(ND,HT)     ; exit log
 D LOG^MHVUL2(ND,HT_" HITS","S","TRACE")
 D LOG^MHVUL2(ND,"END","S","TRACE") Q
 Q
