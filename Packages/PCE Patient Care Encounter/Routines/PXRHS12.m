PXRHS12 ;ISL/SBW - PCE Visit Hospitalization data extract routine ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73**;Aug 12, 1996
 ; Extract returns Hospitalization visit data with associated ICD-9,
 ; CPT, and Provider data.
VISIT(DFN,ENDDT,BEGDT,OCCLIM) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         OCCLIM   - Maximum number of visits returned
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
 ;  ^TMP("PXHSV",$J,InvExDt,COUNT,"C",MODIFIER)="" [E;1/.01]
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
 Q:$G(DFN)']""!'$D(^AUPNVSIT("AAH",DFN))
 N PXCNT,PXIVD,PXVDF,PXBEG,CATCODE,IBEGDT,IENDDT,CHGIVD,PXSTOP
 S CATCODE="H" ;Get only Hospitalization visits
 S EXTRCODE="PCD" ;Get provider, CPT, and ICD-9 data
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXHSV",$J)
 S PXBEG=9999999-$P(ENDDT,"."),PXSTOP=(9999999-$P(BEGDT,"."))_".235959",PXCNT=0
 F  S PXBEG=$O(^AUPNVSIT("AAH",DFN,PXBEG)) Q:+PXBEG'>0!(PXBEG>PXSTOP)  D  Q:PXCNT'<OCCLIM
 .; Gets all valid visits on one day in last to first order
 .; X-ref is in visit inverse date order but not inverse time order
 . S (PXIVD,PXBEG)=$P(PXBEG,".")_".999999"
 . ;start with last visit on a dt and don't duplicate any visits
 . F  S PXIVD=$O(^AUPNVSIT("AAH",DFN,PXIVD),-1) Q:+PXIVD'>0!(PXIVD<$P(PXBEG,"."))  D  Q:PXCNT'<OCCLIM
 . .;invert PXIVD to same format as IBEGDT and IENDDT. For Visit file
 . .;date is inverted date/regular time. We want inverted date/time.
 . . S CHGIVD=9999999-((9999999-$P(PXIVD,"."))_"."_$P(PXIVD,".",2))
 . . Q:(CHGIVD<IBEGDT)!(CHGIVD>IENDDT)
 . . S PXVDF=""
 . . F  S PXVDF=$O(^AUPNVSIT("AAH",DFN,PXIVD,PXVDF)) Q:+PXVDF'>0  D GETREC^PXRHS02(PXVDF,$G(CATCODE),$G(EXTRCODE),"",.PXCNT)  Q:PXCNT'<OCCLIM
 Q
