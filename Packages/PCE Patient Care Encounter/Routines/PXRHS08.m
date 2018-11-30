PXRHS08 ;ISL/SBW,PKR - PCE Visit Patient Education data extract ;12/21/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,16,211**;Aug 12, 1996;Build 244
EDUC(DFN,BEGDT,ENDDT,OCCLIM,CATCODE) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         OCCLIM   - Maximum number of days for which data is returned
 ;                    (If multiple visits on a given day, all data for
 ;                    these visit will be returned) or an "R" for
 ;                    only the most recent occurrence of each topic
 ;                    Note: If event date is used, it may appear that too
 ;                          many occurrences are retrieved but it is
 ;                          it is based on visit date not event date.
 ;         CATCODE  - Pattern Match which controls visit data that is
 ;                    returned (Can include multiple codes)
 ;               A = AMBULATORY
 ;               H = HOSPITALIZATION
 ;               I = IN HOSPITAL
 ;               C = CHART REVIEW
 ;               T = TELECOMMUNICATIONS
 ;               N = NOT FOUND
 ;               S = DAY SURGERY
 ;               O = OBSERVATION
 ;               E = EVENT (HISTORICAL)
 ;               R = NURSING HOME
 ;               D = DAILY HOSPITALIZATION DATA
 ;               X = ANCILLARY PACKAGE DAILY DATA
 ;
 ;OUTPUT : 
 ;  Data from V Patient Education (9000010.16) file
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,0) = PRINT NAME or TOPIC [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ LEVEL OF UNDERSTANDING [E;.06] ^ ORDERING PROVIDER [E;1202] 
 ;     ^ ENCOUNTER PROVIDER [E;1204]
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,"S") = DATA SOURCE [E;81203]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     InvDt - Inverse FileMan date of DATE OF event or visit
 ;     TOPIC - Patient Education Topic
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^PXRMINDX(9000010.16,"PI",DFN))
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 K ^TMP("PXPE",$J)
 N DATE,EDUIEN,VPEDIEN
 S EDUIEN=""
 F  S EDUIEN=$O(^PXRMINDX(9000010.16,"PI",DFN,EDUIEN)) Q:EDUIEN=""  D
 . S CNT=0,DATE=""
 . F  S DATE=$O(^PXRMINDX(9000010.16,"PI",DFN,EDUIEN,DATE),-1) Q:(DATE="")!(CNT'<OCCLIM)  D
 .. S VPEDIEN=0
 .. F  S VPEDIEN=$O(^PXRMINDX(9000010.16,"PI",DFN,EDUIEN,DATE,VPEDIEN)) Q:(VPEDIEN="")!(CNT'<OCCLIM)  D
 ... I $$ADDEDU(EDUIEN,VPEDIEN,BEGDT,ENDDT)=1 S CNT=CNT+1
 Q
 ;
ADDEDU(EDUIEN,VPEDIEN,BEGDT,ENDDT) ;
 N COMMENT,DATASRC,EPROV,EVENTDT,HLOC,HLOCABB,IDT,LEVEL,OPROV
 N PNAME,TMP0,TMP12,TMP220,TMP811,TMP812,TOPIC,VDATA
 S TMP0=$G(^AUPNVPED(VPEDIEN,0))
 S TMP12=$G(^AUPNVPED(VPEDIEN,12))
 S VDATA=$$GETVDATA^PXRHS03($P(TMP0,U,3))
 S EVENTDT=$P(TMP12,U,1)
 I EVENTDT="" S EVENTDT=$P(VDATA,U,1)
 ;Is it in the date range?
 I (EVENTDT<BEGDT)!(EVENTDT>ENDDT) Q 0
 ;Only get data with passed serv. cat.
 I $G(CATCODE)'[$P(VDATA,U,3) Q 0
 S TMP220=$G(^AUPNVPED(VPEDIEN,220))
 S TMP811=$G(^AUPNVPED(VPEDIEN,811))
 S TMP812=$G(^AUPNVPED(VPEDIEN,812))
 S TOPIC=$P(^AUTTEDT(EDUIEN,0),U,1)
 S PNAME=$P($G(^AUTTEDT(EDUIEN,0)),U,4)
 I PNAME="" S PNAME=TOPIC
 S LEVEL=$$EXTERNAL^DILFD(9000010.16,.06,"",$P(TMP0,U,6))
 S OPROV=$$GET1^DIQ(9000010.16,VPEDIEN_",",1202)
 S EPROV=$$GET1^DIQ(9000010.16,VPEDIEN_",",1204)
 S HLOC=$P(VDATA,U,5)
 S HLOCABB=$P(VDATA,U,6)
 S DATASRC=$P(TMP812,U,3)
 S COMMENT=TMP811
 S IDT=9999999-EVENTDT
 S ^TMP("PXPE",$J,IDT,TOPIC,VPEDIEN,0)=PNAME_U_EVENTDT_U_LEVEL_U_OPROV_U_EPROV
 S ^TMP("PXPE",$J,IDT,TOPIC,VPEDIEN,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 S ^TMP("PXPE",$J,IDT,TOPIC,VPEDIEN,"COM")=COMMENT
 S ^TMP("PXPE",$J,IDT,TOPIC,VPEDIEN,"MEASUREMENT")=TMP220
 S ^TMP("PXPE",$J,IDT,TOPIC,VPEDIEN,"S")=DATASRC
 Q 1
 ;
