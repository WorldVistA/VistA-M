PSOASAP2 ;BIRM/KML - American Society for Automation in Pharmacy (ASAP) Segments & Fields ;09/07/12
 ;;7.0;OUTPATIENT PHARMACY;**772**;DEC 1997;Build 105
 ;External reference to ALIAS multiple (2.01) of the PATIENT file (#2) supported by DBIA 5708
 ;External reference to VADM array supported by DBIA 10061
 ;External reference to DEA NUMBERS file (#8991.9) supported by DBIA 7002
 ;External reference to ARCHIVE^ORDEA API supported by ICR 5709
 ;External reference to the STATE file (#5) supported by DBIA 10056
 ;            
 ;
 ; ******************** ASAP 5.0 and above versions ******************** 
 ;
 ; *** IS Segment - Information Source ***
IS01() ; Unique Information Source ID 
 ;ASAP 4.2+ : IS01 is alphanumeric so data equals 'VA'_$$SITE^VASITE()
 ;     5.0+: IS01 became numeric so data is the NPI from the Institution file
 N IS01,DA,SITE,NPINUM,NPINST
 S SITE=+$$SITE^VASITE()
 S IS01="VA"_SITE
 I PSOASVER'<5.0 D       ; pso*7*772 don't proceed for anything before 5.0
 . S DA=$O(^PS(59,"C",SITE,0))
 . I 'DA S IS01=SITE_$$GET1^DIQ(4,SITE,1.04)  Q
 . S NPINST=$$GET1^DIQ(59,DA,101,"I")
 . I 'NPINST S IS01=SITE_$$GET1^DIQ(4,SITE,1.04)  Q   ; ISO1 = VA site code_facility zip code
 . S NPINUM=+$$NPI^XUSNPI("Organization_ID",NPINST,DT) ; get NPI from file 4
 . S IS01=$S(NPINUM>0:NPINUM,1:SITE_$$GET1^DIQ(4,SITE,1.04))  ; if NPI, IS0 = NPI else IS01 = VA site code_facility zip code
 Q IS01
 ;
 ;*** TH Segment - Transaction Type
 ;
TH06() ;ASAP 3.0 : Response ID (Not Used)
 ;      ASAP 4.0+: Creation Time. Format: HHMMSS or HHMM
 ;      ASAP 5.0+: Creation Time. Data element increased in length from 6 to 7 to accomodate ZULU time  Format: HHMMSSZ
 Q $S(PSOASVER="3.0":"",PSOASVER<5.0:$E($P($$HTFM^XLFDT($H),".",2)_"000000",1,6),1:$$UTCTIM($$HTFM^XLFDT($H)))   ; PSO772
 ;
 ; *** PAT Segment ***
 ;
PAT16() ;Patient ZIP Code
 ; US Zip Code
 ; if US then get VAPA(11), if ASAP version is 5 then get 2nd piece of VAPA(11) which is the US zip code with hyphens
 ; otherwise if ASAP version is a prior version then send zip code w/o hyphens (piece one)
 I $$PAT22^PSOASAP0()="" Q $S(PSOASVER<5.0:$P($G(VAPA(11)),"^"),1:$P($G(VAPA(11)),"^",2))  ;pso*7*772
 ; International Postal Code
 Q $P($G(VAPA(24)),"^")
 ;
PAT24() ; 
 ; ASAP 5.0: Patient Preferred or Alias Last Name (new in 5.0)
 Q:+PSOASVER<5.0 ""  ;data element is not defined before 5.0
 N X
 K ^TMP("DILIST",$J)
 D LIST^DIC(2.01,","_PATIEN_",",.01)
 S X=$O(^TMP("DILIST",$J,1,999),-1) ; get the last ENTRY recorded
 Q $S(X:$P(^TMP("DILIST",$J,1,X),","),1:"")
 ;
PAT25() ; 
 ; ASAP 5.0: Patient Preferred or Alias First Name (new in 5.0)
 Q:+PSOASVER<5.0 ""   ;data element is not defined before 5.0
 N X
 K ^TMP("DILIST",$J)
 D LIST^DIC(2.01,","_PATIEN_",",.01)
 S X=$O(^TMP("DILIST",$J,1,999),-1) ; get the last ENTRY recorded
 Q $S(X:$P(^TMP("DILIST",$J,1,X),",",2),1:"")
 ;
PAT26() ; 
 ; ASAP 5.0: Patient Race Category (new in 5.0)
 Q:+PSOASVER<5.0 ""
 N PAT26,DESC,LINE,FOUND
 S FOUND=0,PAT26=""
 F LINE=2:1 S DESC=$T(RACE+LINE),DESC=$P(DESC,";",2) Q:DESC="#"  Q:FOUND  D
 . I $G(VADM(12))>1 S PAT26="06" S FOUND=1 Q
 . I $P($G(VADM(12,1)),"^",2)=$P(DESC,"^") S PAT26=$P(DESC,"^",2) S FOUND=1 Q
 Q PAT26
 ;
PAT27() ;
 ; ASAP 5.0: Patient Ethnicity (new in 5.0)
 Q:+PSOASVER<5.0 ""
 N PAT27,LINE,DESC,FOUND
 S FOUND=0,PAT27=""
 F LINE=2:1 S DESC=$T(ETHNICITY+LINE),DESC=$P(DESC,";",2) Q:DESC="#"  Q:FOUND  D
 . I $P($G(VADM(11,1)),"^",2)=$P(DESC,"^") S PAT27=$P(DESC,"^",2) S FOUND=1 Q
 Q PAT27
 ;
 ;    *** DSP Segment ***
DSP08() ;ASAP 3.0 : Unique System ID - Drug (Not Used)
 ;       ASAP 4.0+:Product ID (NDC - National Drug Code)
 I PSOASVER="3.0" Q ""
 N DSP08,I,X,Y S DSP08=""
 I RECTYPE="V",$G(RTSDATA("NDC"))'="" S DSP08=$$NUMERIC^PSOASAP0(RTSDATA("NDC"))
 I 'DSP08 S DSP08=$$NUMERIC^PSOASAP0($$GET1^DIQ(50,DRUGIEN,31))
 I 'DSP08 S DSP08=$$NUMERIC^PSOASAP0($$GETNDC^PSONDCUT(RXIEN,+FILLNUM))
 I $E(PSOASVER,1,4)="4.2A"!($E(PSOASVER,1,4)="4.2B")!(PSOASVER>4.2) I ($L(DSP08)>0)&($L(DSP08)<11) S DSP08=$$RJ^XLFSTR(DSP08,11,0)  ;pso,772  pad NDC with zeros
 Q DSP08
 ;
DSP27() ; ASAP 5.0: Time Filled (new with 5.0)
 Q:+PSOASVER<5.0 ""
 N X,UTCX
 S X=$S((RECTYPE="V")&($G(RTSDATA("RELDTTM"))'=""):$G(RTSDATA("RELDTTM")),$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM):$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM),1:DT)
 S UTCX=$$UTCTIM(X) ; UTC Time
 Q UTCX
 ;
DSP29() ; ASAP 5.0: Total Quantity Remaining on Prescription (new with 5.0)
 Q:+PSOASVER<5.0 ""
 N DSP04,DSP06,DSP09
 Q:$$GET1^DIQ(52,RXIEN,45.3,"I") 0
 S DSP04=$$DSP04^PSOASAP()  ; # of Refills 
 S DSP06=$$DSP06^PSOASAP()  ; fill number
 S DSP09=$$DSP09^PSOASAP()  ;qty dispensed
 Q (DSP04-DSP06)*DSP09
 ;
DSP30() ;ASAP 5.0: Total Quantity Remaining Drug Dosage Units Code (new in 5.0) 
 Q:+PSOASVER<5.0 ""
 N UNITS
 S UNITS=$$GET1^DIQ(50,DRUGIEN,82,"I")
 Q $S(UNITS="EA":"01",UNITS="ML":"02",UNITS="GM":"03",1:"")
 ;
DSP34() ;ASAP 5.0: DEA Schedule/State Designation (new in 5.0)
 Q:+PSOASVER<5.0 ""
 N DEA
 S DEA=$$GET1^DIQ(50,DRUGIEN,3)
 Q $S($E(DEA):"0"_$E(DEA),1:"")  ;if DEA contains a number it will always be the first character
 ;
 ; *** PRE Segment ***
PRE11() ;ASAP 5.0: Prescriber Address Information 1 (added in 5.0)
 Q:+PSOASVER<5.0 ""
 N ADD1,ORDNUM,DEANUM
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I") ;pointer to 101.52
 Q:ORDNUM']"" ""
 S DEANUM=$$ORDERARCHIVE(ORDNUM)
 Q:DEANUM']"" ""
 S ADD1=$$GET1^DIQ(8991.9,+$$FIND1^DIC(8991.9,,"X",DEANUM,"B"),1.3)
 Q $S(ADD1]"":ADD1,1:$P($G(^TMP($J,"ORDEA",ORDNUM,3)),"^"))
 ;
PRE12() ;ASAP 5.0: Prescriber Address Information 2 (added in 5.0)
 Q:+PSOASVER<5.0 ""
 N ADD2,ORDNUM,DEANUM
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I") ;pointer to 101.52
 Q:ORDNUM']"" ""
 S DEANUM=$$ORDERARCHIVE(ORDNUM)
 Q:DEANUM']"" ""
 S ADD2=$$GET1^DIQ(8991.9,+$$FIND1^DIC(8991.9,,"X",DEANUM,"B"),1.4)
 Q $S(ADD2]"":ADD2,1:$P($G(^TMP($J,"ORDEA",ORDNUM,3)),"^",2))
 ;
PRE13() ;ASAP 5.0: Prescriber City Address (added in 5.0)
 Q:+PSOASVER<5.0 ""
 N CITYADD,ORDNUM,DEANUM
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I") ;pointer to 101.52
 Q:ORDNUM']"" ""
 S DEANUM=$$ORDERARCHIVE(ORDNUM)
 Q:DEANUM']"" ""
 S CITYADD=$$GET1^DIQ(8991.9,+$$FIND1^DIC(8991.9,,"X",DEANUM,"B"),1.5)
 Q $S(CITYADD]"":CITYADD,1:$P($G(^TMP($J,"ORDEA",ORDNUM,3)),"^",4))
 ;
PRE14() ;ASAP 5.0: Prescriber State Address (added in 5.0)
 Q:+PSOASVER<5.0 ""
 N ORDNUM,DEANUM,STATEIEN
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I") ;pointer to 101.52
 Q:ORDNUM']"" ""
 S DEANUM=$$ORDERARCHIVE(ORDNUM)
 Q:DEANUM']"" ""
 S STATEIEN=+$$GET1^DIQ(8991.9,+$$FIND1^DIC(8991.9,,"X",DEANUM,"B"),1.6,"I")
 S STATEIEN=$S(STATEIEN:STATEIEN,1:$$FIND1^DIC(5,,"X",$P($G(^TMP($J,"ORDEA",ORDNUM,3)),"^",5),"B"))
 Q $$GET1^DIQ(5,STATEIEN,1)
 ;
PRE15() ;ASAP 5.0: Zip Code Address (added in 5.0)
 Q:+PSOASVER<5.0 ""
 N ZIPCODE,ORDNUM,DEANUM
 S ORDNUM=$$GET1^DIQ(52,RXIEN,39.3,"I") ;pointer to 101.52
 Q:ORDNUM']"" ""
 S DEANUM=$$ORDERARCHIVE(ORDNUM)
 Q:DEANUM']"" ""
 S ZIPCODE=$$GET1^DIQ(8991.9,+$$FIND1^DIC(8991.9,,"X",DEANUM,"B"),1.7)
 Q $S(ZIPCODE]"":ZIPCODE,1:$P($G(^TMP($J,"ORDEA",ORDNUM,3)),"^",6))
 ;
RACE ; mapping of race and codes for PAT26
 ; race in VistA^code in ASAP specification
 ;AMERICAN INDIAN OR ALASKA NATIVE^01
 ;ASIAN^02
 ;BLACK OR AFRICAN AMERICAN^03
 ;NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER^04
 ;WHITE^05
 ;UNKNOWN BY PATIENT^99
 ;#
 ;
ETHNICITY ; mapping of ethnicity and codes for PAT27
 ; ethnicity in VistA^code in ASAP specification
 ;DECLINED TO ANSWER^99
 ;HISPANIC OR LATINO^01
 ;NOT HISPANIC OR LATINO^02 
 ;UNKNOWN BY PATIENT^99  
 ;#
 ;
ORDERARCHIVE(X) ; returns data from the ORDER DEA ARCHIVE INFO file (#101.52) 
 ; Input - X = PLACER ORDER NUMBER (#52,39.3)
 ; Output - ^TMP($J,"ORDEA",ORIFN)
 ;         - DEA # (101.52,10)
 ;Q $$GET1^DIQ(101.52,$$FIND1^DIC(101.52,,"X",$$GET1^DIQ(52,RXIEN,39.3,"I"),"B"),10)
 N DEA
 D ARCHIVE^ORDEA(X)
 S DEA=$P($G(^TMP($J,"ORDEA",X,2)),"^")
 Q DEA
 ;
UTCTIM(FMDTM,TIMLEN) ; UTC Time
 ; Input=FM Date/Time
 ; Output=UTC time only, with appended "Z"
 N HLDATIM,FMDTMU,HLDATIM,HLTIMU
 S:'$G(TIMLEN) TIMLEN=7
 Q:FMDTM="" ""
 ; GET HL7 formatted version of FMDTM input
 S HLDATIM=$$FMTHL7^XLFDT(FMDTM)
 ; Convert HLDATIM to UTC date/time in FM format
 S FMDTMU=$$HL7TFM^XLFDT(HLDATIM,"U")
 ; Convert the UTC date/time from FM to HL7 (UTC) format
 S HLDATIM=$$FMTHL7^XLFDT(FMDTMU)
 ; Extract time portion of UTC date/time and append "Z"
 S HLTIMU=$E($P(HLDATIM,"-"),9,99)
 I $L(HLTIMU)<(TIMLEN-1) S HLTIMU=$$LJ^XLFSTR(HLTIMU,TIMLEN-1,0)
 Q HLTIMU_"Z"
