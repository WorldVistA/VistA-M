SYNDHP06 ; HC/rbd/art - HealthConcourse - get hospital location and institution data ;05/07/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get institution details for hospital location ------------------------------
 ;
HOSINSTI(RETSTA,HLOCNAME,RETJSON) ; takes Hospital Location name and returns Institution and Inst. details
 ;
 ; Return Institution and Inst. details for a given Hospital Location name
 ;
 ; Input:
 ;   HLOCNAME  - Hospital Location name
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return Location string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists institution details for hospital location name
 ;             LocName^LocIEN|institutionName|instIEN|instStreet1|instStreet2|instCity|instState|instZip|contactName1_Phone1*repeats|resourceId
 ;          or hospital location & institution data in JSON format
 ;
 ; validate Hospital Location name
 I $G(HLOCNAME)="" S RETSTA="-1^What location?" QUIT
 I '$D(^SC("B",HLOCNAME)) S RETSTA="-1^Hospital Location name not recognised^"_HLOCNAME Q
 ;
 N HLOCARR
 S RETSTA=$$INSTS(HLOCNAME,.HLOCARR)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.HLOCARR,.RETSTA)
 ;
 QUIT
 ;
INSTS(HLOCNAME,HLOCARR) ; get locations for encounters for a patient
 ;
 N C,P,S,A,ZARR
 N CONTNAM,CONTPH,CONTSTR,HSLOCID,INSTCITY,INSTIEN,INSTNAM,INSTST1,INSTST2,INSTSTAT,INSTZIP
 S C=",",P="|",S="_",A="*"
 N FNUM S FNUM=44        ; HOSPITAL LOCATION file
 ; scan hospital location "B" index for HLIEN
 N HLIEN S HLIEN=""
 F  S HLIEN=$O(^SC("B",HLOCNAME,HLIEN)) Q:HLIEN=""  D
 .N HOSPLOC
 .D GETHLOC^SYNDHP22(.HOSPLOC,HLIEN)
 .I $D(HOSPLOC("Hosploc","ERROR")) M HLOCARR("Location",HLIEN)=HOSPLOC QUIT
 .S INSTNAM=HOSPLOC("Hosploc","institution")
 .S INSTIEN=HOSPLOC("Hosploc","institutionId")
 .S HSLOCID=HOSPLOC("Hosploc","resourceId")
 .N SITE
 .D GET1SITE^SYNDHP10(.SITE,INSTIEN,0)
 .I $D(SITE("Site","ERROR")) M HLOCARR("Location",HLIEN)=SITE QUIT
 .S INSTST1=SITE("Site","streetAddr1")
 .S INSTST2=SITE("Site","streetAddr2")
 .S INSTCITY=SITE("Site","city")
 .S INSTZIP=SITE("Site","zip")
 .S INSTSTAT=SITE("Site","state")
 .S CONTSTR=""
 .N IENS2 S IENS2=""
 .F  S IENS2=$O(SITE("Site","contacts","contact",IENS2)) QUIT:IENS2=""  D
 ..N CONTACT S CONTACT=$NA(SITE("Site","contacts","contact",+IENS2))
 ..S CONTNAM=@CONTACT@("contact")
 ..S CONTPH=@CONTACT@("phone")
 ..S CONTSTR=CONTSTR_CONTNAM_S_CONTPH_A
 .S:CONTSTR]"" CONTSTR=$E(CONTSTR,1,$L(CONTSTR)-1)
 .I $G(DEBUG) W !,HLOCNAME,A,HLIEN,A,INSTNAM,A,INSTIEN,A,INSTST1,A,INSTST2,A,INSTCITY,A,INSTSTAT,A,INSTZIP,A,CONTSTR,A,HSLOCID,!!
 .S ZARR(HLOCNAME,HLIEN)=INSTNAM_P_INSTIEN_P_INSTST1_P_INSTST2_P_INSTCITY_P_INSTSTAT_P_INSTZIP_P_CONTSTR_P_HSLOCID
 .M HLOCARR("Location",HLIEN)=HOSPLOC
 .M HLOCARR("Location",HLIEN,"institution")=SITE("Site")
 ;
 ; serialize data
 N HLREC,VSTDT,VIEN
 N HLOC S HLOC=HLOCNAME
 S (VSTDT,VIEN)=""
 F  S HLIEN=$O(ZARR(HLOCNAME,HLIEN)) Q:HLIEN=""  D
 .S HLREC=ZARR(HLOCNAME,HLIEN)
 .S HLOC=HLOC_U_HLIEN_P_HLREC
 ;
 Q HLOC
 ;
 ; ----------- Unit Test -----------
T1 ;
 N LOCNAME S LOCNAME="GENERAL MEDICINE"
 N JSON S JSON=""
 N RETSTA
 D HOSINSTI(.RETSTA,LOCNAME,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N LOCNAME S LOCNAME="GENERAL MEDICINE"
 N JSON S JSON="J"
 N RETSTA
 D HOSINSTI(.RETSTA,LOCNAME,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
