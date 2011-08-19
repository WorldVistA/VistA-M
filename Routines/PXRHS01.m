PXRHS01 ; SLC/SBW - PCE Visit data extract main routine ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73**;Aug 12, 1996
 ; Extract returns visit data with associated ICD-9, CPT, and
 ; Provider data.
VISIT(DFN,ENDDT,BEGDT,OCCLIM,CATCODE,EXTRCODE,TIMEORD) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         ENDDT    - Ending date/time in in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         OCCLIM   - Maximum number of visits returned
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
 ;         EXTRCODE - Pattern Match indicating which optional
 ;                    data is returned (Can be multiple)
 ;               P = return PROVIDER data
 ;               C = return CPT (procedure) data
 ;               D = return ICD-9 (diagnosis) data
 ;         TIMEORD  - Order visits on same day are indexed
 ;                    Default is inverse cronological order
 ;               1 = Time order in regular cronological order
 ;
 ;OUTPUT : 
 ;  Data from VISIT (9000010) file except for hosp. loc. abbr.
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,0) = VISIT/ADMIT DATE&TIME [I;.01] 
 ;        ^ TYPE [E;.03] ^ LOC. OF ENCOUNTER [E;.06]
 ;        ^ SERVICE CATEGORY [E;.07] ^ CHECK OUT DATE&TIME [I;.18] 
 ;        ^ HOSPITAL LOCATION [E;.22] ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;        ^ OUTSIDE LOCATION [E;2101] ^ CLINIC [E;.08]
 ;        ^ WALK IN/APPT [E;.16] ^ LEVEL OF SERVICE [E;.17]
 ;        ^ ELIGIBILITY [E;.21]
 ;  Data from V CPT (9000010.18) file
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"C",X) = CPT [I;.01] 
 ;        ^ PROVIDER NARRATIVE [E;.04]
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"C",X,MODIFIER)="" [E;1/.01]
 ;  Data from V POV (9000010.07) file
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"D",X) = POV [I;.01]
 ;        ^ MODIFIER [E;.06] ^ CAUSE OF DX [E;.07]
 ;        ^ PLACE OF ACCIDENT [E;.11] ^ PRIMARY/SECONDARY [E;.12]
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"D",X,"N") = PROVIDER NARRATIVE [E;.04]
 ;  Data from V PROVIDER (9000010.06) file
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"P",X) = PROVIDER [E;.01]
 ;        ^ PRIMARY/SECONDARY [E;.04]
 ;  Data from V HOSPITALIZATION (9000010.02) file (If Service Category
 ;  is for hospitalization)
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"H",X) = DATE OF DISCHARGE [I;.01]
 ;        ^ ADMITTING DX [E;.12]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     InvExDt - Inverse FileMan date of DATE OF visit [.01]
 ;     Count   - # of entry
 ;
 Q:$G(DFN)']""!'$D(^AUPNVSIT("AA",DFN))
 N PXCNT,PXIVD,PXVDF,PXBEG,IBEGDT,IENDDT,CHGIVD,PXSTOP,IHSDATE
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT+.235959
 K ^TMP("PXHSV",$J)
 S PXBEG=9999999-$P(ENDDT,"."),PXSTOP=(9999999-$P(BEGDT,"."))_".235959",PXCNT=0,IHSDATE=9999999-$$HSDATE+.235959
 F  S PXBEG=$O(^AUPNVSIT("AA",DFN,PXBEG)) Q:+PXBEG'>0!(PXBEG>PXSTOP)  Q:PXBEG>IHSDATE  D  Q:PXCNT'<OCCLIM
 .; Gets all valid visits on one day in last to first order
 .; X-ref is in visit inverse date order but not inverse time order
 . S (PXIVD,PXBEG)=$P(PXBEG,".")_".999999"
 . ;start with last visit on a dt and don't duplicate any visits
 . F  S PXIVD=$O(^AUPNVSIT("AA",DFN,PXIVD),-1) Q:+PXIVD'>0!(PXIVD<$P(PXBEG,"."))  D  Q:PXCNT'<OCCLIM
 . .;invert PXIVD to same format as IBEGDT and IENDDT. For Visit file
 . .;date is inverted date/regular time. We want inverted date/time.
 . . S CHGIVD=9999999-((9999999-$P(PXIVD,"."))_"."_$P(PXIVD,".",2))
 . . Q:(CHGIVD<IBEGDT)!(CHGIVD>IENDDT)
 . . S PXVDF=""
 . . F  S PXVDF=$O(^AUPNVSIT("AA",DFN,PXIVD,PXVDF)) Q:+PXVDF'>0  D GETREC^PXRHS02(PXVDF,$G(CATCODE),$G(EXTRCODE),$S(+$G(TIMEORD):PXIVD,1:""),.PXCNT)  Q:PXCNT'<OCCLIM
 Q
 ;
HSDATE() ; $$() -> switch date
 Q $P(^PX(815,1,0),U,3)
