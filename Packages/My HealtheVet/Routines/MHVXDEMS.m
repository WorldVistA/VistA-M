MHVXDEMS ;WAS/GPM - Secure Messaging Demographics extract ; 12/1/05 6:58pm [3/23/08 8:17pm]
 ;;1.0;My HealtheVet;**5**;Aug 23, 2005;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EXTRACT(QRY,ERR,DATAROOT) ; Entry point to extract demographics data
 ; Retrieves requested demographics data and returns it in DATAROOT
 ;
 ;  Integration Agreements:
 ;                       10061 : DEM^VADPT
 ;                             : ADD^VADPT
 ;                             : ELIG^VADPT
 ;                             : OPD^VADPT
 ;                             : OAD^VADPT
 ;                             : KVAR^VADPT
 ;                        1916 : PRPT^SCAPMC
 ;                       10035 : 2,.1041
 ;                        4459 : 2,.133
 ;
 ;  Input:
 ;       QRY - Query array
 ;          QRY(DFN) - (required) Pointer to PATIENT (#2) file
 ;  DATAROOT - Root of array to hold extract data
 ;
 ;  Output:
 ;  DATAROOT - Populated data array
 ;       ERR - Errors during extraction
 ;
 N DFN,U,X,MHVPCP,MHVERR,EXTIME,VADM,VAPA,VAPD,VAOA
 D LOG^MHVUL2("MHVXDEMS","BEGIN","S","TRACE")
 S U="^"
 S ERR=0
 S EXTIME=$$NOW^XLFDT
 K @DATAROOT
 S DFN=$G(QRY("DFN"))
 ;
 K VADM
 D DEM^VADPT
 S @DATAROOT@("DOB")=$P($G(VADM(3)),U)
 S @DATAROOT@("SEX")=$P($G(VADM(5)),U)
 S @DATAROOT@("MARITAL-STATUS")=$P($G(VADM(10)),U,2)
 S @DATAROOT@("RELIGION")=$P($G(VADM(9)),U,2)
 S @DATAROOT@("DOD")=$P($G(VADM(6)),U)
 ;
 K VAPA
 D ADD^VADPT
 S @DATAROOT@("ADD1")=$G(VAPA(1))
 S @DATAROOT@("ADD2")=$G(VAPA(2))
 S @DATAROOT@("ADD3")=$G(VAPA(3))
 S @DATAROOT@("CITY")=$G(VAPA(4))
 S @DATAROOT@("STATE")=$P($G(VAPA(5)),U,2)
 S @DATAROOT@("ZIP")=$P($G(VAPA(11)),U)
 S @DATAROOT@("COUNTY")=$P($G(VAPA(7)),U,2)
 S @DATAROOT@("PHONE")=$G(VAPA(8))
 ;
 K VAPD
 D OPD^VADPT
 S @DATAROOT@("BIRTH-CITY")=$G(VAPD(1))
 S @DATAROOT@("BIRTH-STATE")=$P($G(VAPD(2)),U,2)
 ;
 K VAOA
 S VAOA("A")=5
 D OAD^VADPT
 S @DATAROOT@("BUS-PHONE")=$G(VAOA(8))
 ;
 S @DATAROOT@("E-MAIL")=$$GET1^DIQ(2,DFN_",",.133)
 S @DATAROOT@("ATTENDING-PHYSICIAN")=$$GET1^DIQ(2,DFN_",",.1041)
 ;
 S X=""
 I $$PRPT^SCAPMC(DFN,,,,,,.MHVPCP,.MHVERR) I MHVPCP'="" S X=$P($G(@MHVPCP@(1)),U,2) K @MHVPCP
 I $G(MHVERR)'="" K @MHVERR
 S @DATAROOT@("PRIMARY-CARE-PHYSICIAN")=X
 ;
 D KVAR^VADPT
 S @DATAROOT=1_"^"_EXTIME
 D LOG^MHVUL2("MHVXDEMS","END","S","TRACE")
 Q
 ;
