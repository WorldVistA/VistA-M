PXRHS07 ;ISL/PKR - PCE V HEALTH FACTORS extract routine ;12/21/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,123,211**;Aug 12, 1996;Build 244
 ; Extract returns HEALTH FACTORS data
 ;Original version by SBW
HF(DFN,BEGDT,ENDDT,OCCLIM,ITEMS) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         OCCLIM   - Maximum number of days for which data is returned
 ;                    for each Health Factors item.
 ;                    If multiple visits on a given day, all data for
 ;                    these visit will be returned.
 ;                    Note: If event date is used, it may appear that too
 ;                          many occurrences are retrieved but it is
 ;                          it is based on visit date not event date.
 ;         ITEMS    - Optional array containing a selected list of
 ;                    HF Categories. If not used will get all catergories
 ;                    of health factors.
 ;OUTPUT :
 ;  Data from V HEALTH FACTORS (9000010.23) file
 ;  ^TMP("PXF,$J,HFC,HF,InvDt,IFN,0) = PRINT NAME  or Health Factor [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ SHORT NAME [E;9999999.64;.04] ^ LEVEL/SEVERITY [E;.04]
 ;     ^ ORDERING PROVIDER [E;1202] ^ ENCOUNTER PROVIDER [E;1204] 
 ;  ^TMP("PXF",$J,HFC,HF,InvDt,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXF",$J,HFC,HF,InvDt,IFN,"S") = DATA SOURCE [E;81203]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     HFC   - Health Factor Category name
 ;     HF    - Health Factor name
 ;     InvDt - Inverse FileMan date of Event Date and Time or Visit
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^PXRMINDX(9000010.23,"PI",DFN))
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 K ^TMP("PXF",$J)
 I '$D(ITEMS) D HFALL(DFN,BEGDT,ENDDT,OCCLIM)
 I $D(ITEMS) D HFSELECT(DFN,BEGDT,ENDDT,.ITEMS,OCCLIM)
 Q
 ;
 ;====================
ADDHF(HFIEN,VHFIEN,BEGDT,ENDDT) ;Check a specific health factor and determine
 ;if it should be added to the list. Return 1 if it was added to the
 ;list, 0 if it was not.
 N COMMENT,DATASRC,EPROV,EVENTDT,HFCAT,HFCNAME,HFNAME,HLOC,HLOCABB,IDT,OPROV
 N PNAME,SNAME,TEMP,TMP0,TMP12,TMP220,TMP811,TMP812,VDATA
 S TEMP=^AUTTHF(HFIEN,0)
 ;Is Display on Health Summary YES?
 I $P(TEMP,U,8)'="Y" Q 0
 S TMP0=$G(^AUPNVHF(VHFIEN,0))
 S TMP12=$G(^AUPNVHF(VHFIEN,12))
 S VDATA=$$GETVDATA^PXRHS03($P(TMP0,U,3))
 S EVENTDT=$P(TMP12,U,1)
 ;If there is no Event Date use the Visit Date.
 I EVENTDT="" S EVENTDT=$P(VDATA,U,1)
 ;Is it in the date range?
 I (EVENTDT<BEGDT)!(EVENTDT>ENDDT) Q 0
 S HFNAME=$P(TEMP,U,1)
 S SNAME=$P(TEMP,U,4)
 S PNAME=$P($G(^AUTTHF(HFIEN,200)),U,1)
 I PNAME="" S PNAME=HFNAME
 S HFCAT=$P(TEMP,U,3)
 S HFCNAME=$P(^AUTTHF(HFCAT,0),U,1)
 S TMP220=$G(^AUPNVHF(VHFIEN,220))
 S TMP811=$G(^AUPNVHF(VHFIEN,811))
 S TMP812=$G(^AUPNVHF(VHFIEN,812))
 S LEVEL=$$EXTERNAL^DILFD(9000010.23,.04,"",$P(TMP0,U,4))
 S OPROV=$$GET1^DIQ(9000010.23,VHFIEN_",",1202)
 S EPROV=$$GET1^DIQ(9000010.23,VHFIEN_",",1204)
 S HLOC=$P(VDATA,U,5)
 S HLOCABB=$P(VDATA,U,6)
 S DATASRC=$P(TMP812,U,3)
 S COMMENT=TMP811
 S IDT=9999999-EVENTDT
 S ^TMP("PXF",$J,HFCNAME,HFNAME,IDT,VHFIEN,0)=PNAME_U_EVENTDT_U_SNAME_U_LEVEL_U_OPROV_U_EPROV
 S ^TMP("PXF",$J,HFCNAME,HFNAME,IDT,VHFIEN,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 S ^TMP("PXF",$J,HFCNAME,HFNAME,IDT,VHFIEN,"COM")=COMMENT
 I TMP220'="" S ^TMP("PXF",$J,HFCNAME,HFNAME,IDT,VHFIEN,"MEASUREMENT")=TMP220
 S ^TMP("PXF",$J,HFCNAME,HFNAME,IDT,VHFIEN,"S")=DATASRC
 Q 1
 ;
 ;====================
HFALL(DFN,BEGDT,ENDDT,OCCLIM) ;Get all health factors for a patient in the
 ;date range and up to the occurrence limit for each health factor.
 N CNT,DATE,HFIEN,VHFIEN
 S HFIEN=""
 F  S HFIEN=$O(^PXRMINDX(9000010.23,"PI",DFN,HFIEN)) Q:(HFIEN="")  D
 . S CNT=0,DATE=""
 . F  S DATE=$O(^PXRMINDX(9000010.23,"PI",DFN,HFIEN,DATE),-1) Q:(DATE="")!(CNT'<OCCLIM)  D
 .. S VHFIEN=0
 .. F  S VHFIEN=$O(^PXRMINDX(9000010.23,"PI",DFN,HFIEN,DATE,VHFIEN)) Q:(VHFIEN="")!(CNT'<OCCLIM)  D
 ... I $$ADDHF(HFIEN,VHFIEN,BEGDT,ENDDT)=1 S CNT=CNT+1
 Q
 ;
 ;====================
HFCAT(HFCATIEN,DFN,BEGDT,ENDDT,OCCLIM) ;Process a category health factor.
 N HFIEN
 S HFIEN=""
 F  S HFIEN=$O(^AUTTHF("AC",HFCATIEN,HFIEN)) Q:HFIEN=""  D
 . D HFONE(HFIEN,DFN,BEGDT,ENDDT,OCCLIM)
 Q
 ;
 ;====================
HFONE(HFIEN,DFN,BEGDT,ENDDT,OCCLIM) ;Process a single health factor.
 N CNT,DATE,VHFIEN
 S CNT=0,DATE=""
 F  S DATE=$O(^PXRMINDX(9000010.23,"PI",DFN,HFIEN,DATE),-1) Q:(DATE="")!(CNT'<OCCLIM)  D
 . S VHFIEN=0
 . F  S VHFIEN=$O(^PXRMINDX(9000010.23,"PI",DFN,HFIEN,DATE,VHFIEN)) Q:(VHFIEN="")!(CNT'<OCCLIM)  D
 .. I $$ADDHF(HFIEN,VHFIEN,BEGDT,ENDDT)=1 S CNT=CNT+1
 Q
 ;
 ;====================
HFSELECT(DFN,BEGDT,ENDDT,ITEMS,OCCLIM) ;Selected health factors for a patient.
 N ETYPE,HFIEN
 S HFIEN=""
 F  S HFIEN=$O(ITEMS(HFIEN)) Q:HFIEN=""  D
 . S ETYPE=$P(^AUTTHF(HFIEN,0),U,10)
 . I ETYPE="C" D HFCAT(HFIEN,DFN,BEGDT,ENDDT,OCCLIM) Q
 . I ETYPE="F" D HFONE(HFIEN,DFN,BEGDT,ENDDT,OCCLIM)
 Q
 ;
