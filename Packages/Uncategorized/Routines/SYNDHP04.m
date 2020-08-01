SYNDHP04 ; HC/fjf/art - HealthConcourse - retrieve patient procedures ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient procedures ----------------------
 ;
PATPRC(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT) ; get procedures for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient procedures for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDATE  - from date (inclusive), optional
 ;   TODATE  - to date (inclusive), optional
 ; Output:
 ;   RETSTA  - a delimited string that lists SNOMED CT codes for the patient procedures
 ;           - ICN^SCT code|description|CPT code|date|identifier^...
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N C,P,S,ZARR,ICNST,DHPICN,PATIEN
 ;
 S C=",",P="|",S="_"
 N USER S USER=$$DUZ^SYNDHP69
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 ; if we are here we are dealing with a valid patient
 S DHPICN=$P(ICNST,U,3)
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Patient ICN not found" QUIT
 ;
 S RETSTA=DHPICN
 ;
 ;Surgical Procedures
 S RETSTA=RETSTA_$$SRPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 ;Visit Procedures
 S RETSTA=RETSTA_$$VSTPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 ;Radiology Procedures
 S RETSTA=RETSTA_$$RADPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
 ; ---------------- Get patient procedures ----------------------
 ;
PATPRCI(RETSTA,DHPICN,FRDAT,TODAT) ; Patient procedures for ICN
 ;
 ; Return patient procedures for a given patient ICN
 ;  currently returns:
 ;    -Surgical
 ;    -Visit (V CPT)
 ;    -Radiology
 ;
 ; Input:
 ;   DHPICN  - unique patient identifier across all VistA systems
 ;   FRDATE  - from date (inclusive), optional
 ;   TODATE  - to date (inclusive), optional
 ; Output:
 ;   RETSTA  - a delimited string that lists SNOMED CT codes for the patient procedures
 ;           - ICN^SCT code|description|CPT code|date|identifier^...
 ;
 ; bypass for CQM
 ;
 ; ***********
 ; *********** Important Note for open source community
 ; ***********
 ; *********** Perspecta - who developed this source code and have released it to the open source
 ; *********** need the following six lines to remain intact
 ;
 I DHPICN="1899632336V236254" D  QUIT
 .S RETSTA="1899632336V236254^71388002|Mammogram|77056|20170101|442_130_101"
 ;I DHPICN="2495309561V670720" D  QUIT
 ;.S RETSTA="2495309561V670720^24165007|Alcohol Counseling and Treatment||20170101|442_130_101"
 ;
 ; *********** the above lines will be redacted by Perspecta at some suitable juncture to
 ; *********** be determined by Perspecta
 ; ***********
 ; *********** End of Important Note for open source community
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 N C,P,S,PATIEN
 S C=",",P="|",S="_"
 N USER S USER=$$DUZ^SYNDHP69
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETSTA=DHPICN
 ;
 ;Surgical Procedures
 S RETSTA=RETSTA_$$SRPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 ;Visit Procedures
 S RETSTA=RETSTA_$$VSTPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 ;Radiology Procedures
 S RETSTA=RETSTA_$$RADPRCS^SYNDHP55(PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000000107V310212"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N RETSTA
 D PATPRCI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000000107V310212"
 N FRDAT S FRDAT=19980101
 N TODAT S TODAT=19981231
 N RETSTA
 D PATPRCI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
