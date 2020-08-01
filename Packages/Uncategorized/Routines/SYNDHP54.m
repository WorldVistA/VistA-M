SYNDHP54 ; HC/rbd/art - HealthConcourse - retrieve patient provider data ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient providers for encounters ------------------------------
 ;
PATPRVI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient encounter providers for ICN
 ;
 ; Return patient enc providers for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compares to Visit Date/Time
 ;   TODAT   - to date (inclusive), optional, compares to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient providers string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists patient providers for encounters
 ;             ICN^visit date|visit ien|provider name|role|prim/sec|address1|address2|city|state|zip|off. phone|specialization|resourceId^...
 ;          or patient enc providers in JSON format
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"DHPICN: ",DHPICN,"   FRDAT: ",FRDAT,"   TODAT: ",TODAT,"   RETJSON: ",RETJSON,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 ; get encounter providers
 N ENCPROV
 S RETSTA=$$PRVS(.ENCPROV,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.ENCPROV,.RETSTA)
 ;
 Q
 ;
PRVS(ENCPROV,PATIEN,DHPICN,FRDAT,TODAT) ; get providers for encounters for a patient
 ;
 N ENCPROVS,ZARR
 N PRCITY,PRID,PRNAM,PROFFPH,PRPRMSEC,PRREC,PRROLE,PRSTAD1,PRSTAD2,PRSTATE,PRVID,PRVSTDT,PRVVIEN,PRZIP
 N USRCLIEN,USRSPEC,VSTDT
 N P S P="|"
 ; scan visit providers "C" index for IEN
 N PRIEN S PRIEN=""
 F  S PRIEN=$O(^AUPNVPRV("C",PATIEN,PRIEN)) QUIT:PRIEN=""  D
 . N VPROV
 . D GET1VPROV^SYNDHP23(.VPROV,PRIEN,0)
 . I $D(VPROV("Vprov","ERROR")) M ENCPROV("EncProv",PRIEN)=VPROV QUIT
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VPROV")
 . S VSTDT=VPROV("Vprov","visitFM")
 . QUIT:'$$RANGECK^SYNDHPUTL(VSTDT,FRDAT,TODAT)  ;quit if outside of requested date range
 . S PRID=VPROV("Vprov","resourceId")
 . S PRNAM=VPROV("Vprov","provider")
 . S PRVVIEN=VPROV("Vprov","visitId")
 . S PRVSTDT=VPROV("Vprov","visitHL7")
 . S PRVID=VPROV("Vprov","providerId")
 . S PRPRMSEC=VPROV("Vprov","primarySecondary")
 . N PROVARR,PROVERR
 . N IENS S IENS=PRVID_","
 . D GETS^DIQ(200,IENS,"8;.111;.112;.114;.115;.116;.132;41.99","EI","PROVARR","PROVERR")
 . I $G(DEBUG),$D(PROVERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("PROVERR")
 . QUIT:$D(PROVERR)
 . S PRROLE=PROVARR(200,IENS,8,"E")
 . S VPROV("Vprov","provRole")=PRROLE
 . S PRSTAD1=PROVARR(200,IENS,.111,"E")
 . S VPROV("Vprov","provAddress1")=PRSTAD1
 . S PRSTAD2=PROVARR(200,IENS,.112,"E")
 . S VPROV("Vprov","provAddress2")=PRSTAD2
 . S PRCITY=PROVARR(200,IENS,.114,"E")
 . S VPROV("Vprov","provCity")=PRCITY
 . S PRSTATE=PROVARR(200,IENS,.115,"E")
 . S VPROV("Vprov","provState")=PRSTATE
 . S PRZIP=PROVARR(200,IENS,.116,"E")
 . S VPROV("Vprov","provZip")=PRZIP
 . S PROFFPH=PROVARR(200,IENS,.132,"E")
 . S VPROV("Vprov","provOffPhone")=PROFFPH
 . S VPROV("Vprov","provNpi")=PROVARR(200,IENS,41.99,"E")
 . S USRCLIEN=VPROV("Vprov","personClassId")
 . S USRSPEC=$$GET1^DIQ(8932.1,USRCLIEN_",",2)
 . S VPROV("Vprov","personClassSpecialty")=USRSPEC
 . I $G(DEBUG) W !,PRNAM_U_PRVSTDT_U_PRROLE_U_PRPRMSEC
 . S ZARR(DHPICN,PRVSTDT,PRVVIEN)=PRNAM_P_PRROLE_P_PRPRMSEC_P_PRSTAD1_P_PRSTAD2_P_PRCITY_P_PRSTATE_P_PRZIP_P_PROFFPH_P_USRSPEC_P_PRID
 . M ENCPROV("EncProv",PRIEN)=VPROV ;
 ;
 ; serialize data
 S (PRVSTDT,PRVVIEN)="",ENCPROVS=DHPICN
 F  S PRVSTDT=$O(ZARR(DHPICN,PRVSTDT)) QUIT:PRVSTDT=""  D
 .F  S PRVVIEN=$O(ZARR(DHPICN,PRVSTDT,PRVVIEN)) Q:PRVVIEN=""  D
 ..S PRREC=ZARR(DHPICN,PRVSTDT,PRVVIEN)
 ..S ENCPROVS=ENCPROVS_U_PRVSTDT_P_PRVVIEN_P_PRREC
 ..; visit date|visit ien|provider name|role|prim/sec|address1|address2|city|state|zip|off. phone|specialization|resourceId
 ;
 QUIT ENCPROVS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATPRVI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=20150101
 N TODAT S TODAT=20150301
 N JSON S JSON=""
 N RETSTA
 D PATPRVI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATPRVI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
