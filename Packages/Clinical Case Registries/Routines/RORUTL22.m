RORUTL22 ;HCIOFO/SJA - COLLECT ROR DRUG MATCH ; 07/03/17 2:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;**32**;Feb 17, 2006;Build 20
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;  
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*32   Oct 2017   S ALSAHHAR   collect ROR Drug match
 ;                  
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;
EN(SDA) ; --- local drug match collecting - triggered by AMCH x-ref of the ROR GENERIC DRUG file (#799.51)
 N ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 S ZTRTN="MATCH^RORUTL22",ZTIO="",ZTSAVE("SDA")="",ZTDESC="ROR Generic Drug - Drug Match",ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD K ZTSK
 Q
 ;
MATCH ; --- run daily by nightly task job
 N GENIEN,IEN50,REGS
 K ^TMP($J)
 I IOST["C-" W !!,"Collect existing ROR drug match data...",!
 S REGS="",GENIEN=0 F  S REGS=$O(^ROR(799.51,"ARDG",REGS)) Q:REGS=""  S GENIEN=$S($G(SDA):SDA-1,1:0) F  S GENIEN=$O(^ROR(799.51,"ARDG",REGS,GENIEN))  Q:'GENIEN  D
 . I $G(SDA),(GENIEN'=$G(SDA)) Q
 . K ^TMP($J)
 . D AND^PSS50(GENIEN,,,"RORARR") I $D(^TMP($J,"RORARR",0)) D
 . . S IEN50=0 F  S IEN50=$O(^TMP($J,"RORARR",IEN50)) Q:'IEN50  S ^ROR(799.51,"AMCH",REGS,GENIEN,IEN50)=""
 K ^TMP($J)
 G END
 Q
 ;
XDRG(GENIEN,GROUP) ; --- run by RXADDGEN^RORUTL16 - Rx data search
 ; GENIEN  - VA Generic Durg IEN
 ; GROUP - Group code
 N PSS50
 S PSS50=0 F  S PSS50=$O(^ROR(799.51,"AMCH",GROUP_"#",GENIEN,PSS50)) Q:'PSS50  D
 . I $D(RORTSK("PARAMS","DRUGS","G")) D
 . . I '$D(@ROR8DST@(PSS50,GROUP)) S @ROR8DST@(PSS50,GROUP)=""
 Q
 ;
TASK ;  --- Entry point to automatic collect drug match
 N RORROOT
 D OPTSTAT^XUTMOPT("ROR DRUG MATCH",.RORROOT)
 I '+$G(RORROOT(1)) D RESCH^XUTMOPT("ROR DRUG MATCH",$$FMADD^XLFDT(DT,1)+.01,"","24H","L")
 Q
 ;
END ;--- exit
 Q
