SYNDHP63 ;DHP/ART -  Write Lab Tests to VistA ;2019-01-31  10:43 AM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of DXC Technology 2017-2018
 ;
 QUIT
 ;
 ; -------- Create lab test for a patient
 ;
LABADD(RETSTA,DHPPAT,DHPLOC,DHPTEST,DHPRSLT,DHPRSDT,DHPLOINC) ;Create lab test
 ; This is a wrapper to setup a call to the ISI Lab Import processing
 ;
 ; Input:
 ;   DHPPAT  - Patient ICN (required)
 ;   DHPLOC  - Location Name (required)
 ;   DHPTEST - Test name (required if no valid LOINC code passed)
 ;   DHPRSLT - Test result value (required)
 ;   DHPRSDT - Test result date (required, HL7 format)
 ;   DHPLOINC - LOINC code
 ;
 ; Output:   RETSTA
 ;  1 - success
 ; -1 - failure -1^message
 ;
 N PATDFN,PATSSN,LABARRAY,RC,DHPRC,LOINCIEN,TESTIEN,LABTEST,SAVEIO
 ;
 S RETSTA("LABINPUT","DHPPAT")=DHPPAT
 S RETSTA("LABINPUT","DHPLOC")=DHPLOC
 S RETSTA("LABINPUT","DHPTEST")=DHPTEST
 S RETSTA("LABINPUT","DHPRSLT")=DHPRSLT
 S RETSTA("LABINPUT","DHPRSDT")=DHPRSDT
 S RETSTA("LABINPUT","DHPLOINC")=DHPLOINC
 ;
 I $G(DHPPAT)="" S RETSTA="-1^Missing patient identifier." QUIT
 I $G(DHPLOC)="" S RETSTA="-1^Missing location." QUIT
 I $G(DHPLOINC)="",$G(DHPTEST)="" S RETSTA="-1^Missing lab test name." QUIT
 I $G(DHPRSLT)="" S RETSTA="-1^Missing lab test result value." QUIT
 I $G(DHPRSDT)="" S RETSTA="-1^Missing lab test result date/time." QUIT
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised." QUIT
 S PATDFN=$O(^DPT("AFICN",DHPPAT,""))
 S PATSSN=$$GET1^DIQ(2,PATDFN_",",.09,"I") ;patient SSN
 I PATSSN="" S RETSTA="-1^Patient does not have an SSN." QUIT
 ;
 ; -- Check lab test date/time --
 S LABDTTM=$$HL7TFM^XLFDT(DHPRSDT)
 I $P(LABDTTM,".",2)="" S RETSTA="-1^Missing time for result date/time." QUIT
 ;chop off seconds
 S LABTM=$E($P(LABDTTM,".",2),1,4)
 S $P(LABDTTM,".",2)=LABTM
 S LABDTTM=$$HL7TFM^XLFDT($$FMTHL7^XLFDT(LABDTTM)) ;drop any trailing 0's in time
 ;
 ;Get lab test name for LOINC code
 I $G(DHPLOINC)'="" D
 . S LOINCIEN=$O(^LAB(95.3,"B",$P(DHPLOINC,"-",1),""))
 . QUIT:LOINCIEN=""
 . S TESTIEN=$O(^LAB(60,"AF",LOINCIEN,""))
 . QUIT:TESTIEN=""
 . S LABTEST=$$GET1^DIQ(60,TESTIEN_",",.01)
 I $G(LABTEST)="" S LABTEST=$$UP^XLFSTR(DHPTEST)
 I $G(LABTEST)="" S RETSTA="-1^Cannot determine lab test name." QUIT
 ;
 S LABARRAY("PAT_SSN")=PATSSN
 S LABARRAY("LAB_TEST")=LABTEST
 S LABARRAY("RESULT_DT")=LABDTTM
 S LABARRAY("RESULT_VAL")=DHPRSLT
 S LABARRAY("LOCATION")=DHPLOC
 S LABARRAY("LOINC")=DHPLOINC
 M RETSTA("LABDATA")=LABARRAY
 ;
 I $G(DEBUG)=1 D
 . W "ICN:      ",DHPPAT,!
 . W "SSN:      ",LABARRAY("PAT_SSN"),!
 . W "LOCATION: ",LABARRAY("LOCATION"),!
 . W "LOINC:    ",DHPLOINC,!
 . W "TEST:     ",LABARRAY("LAB_TEST"),!
 . W "RESULT:   ",LABARRAY("RESULT_VAL"),!
 . W "DATE:     ",LABARRAY("RESULT_DT"),!
 ;
 ;call ISI Labs Ingest
 S DHPRC=$$LAB^ISIIMP12(.RC,.LABARRAY)
 I +DHPRC=-1 S RETSTA=DHPRC QUIT
 ;
 S RETSTA=1
 ;
 QUIT
 ;
T1 ; test one
 ;
 M PARMS=^XTMP("SYNGRAPH",1,1267,"load","labs",13,"parms")
 S N=""
 F  S N=$O(PARMS(N)) Q:N=""  S @N=PARMS(N)
 D LABADD(.ZXC,DHPPAT,DHPLOC,DHPLAB,DHPOBS,DHPDTM,DHPLOINC)
 Q
