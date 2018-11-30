PXRHS05 ;ISL/SBW,PKR - PCE V EXAM extract routine ;08/22/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,211**;Aug 12, 1996;Build 244
 ; Extract returns EXAM data
EXAM(DFN,ENDDT,BEGDT,OCCLIM) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         OCCLIM   - Maximum # of each type of exam returned
 ;OUTPUT :
 ;  Data from V EXAM (9000010.13) file
 ;  ^TMP("PXE,$J,EXAM,InvDt,IFN,0) = PRINT NAME  or EXAM [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ RESULTS CODE [I;.04] ^ RESULTS [E;.04]
 ;     ^ ORDERING PROVIDER [E;1202] ^ ENCOUNTER PROVIDER [E;1204] ^
 ;  ^TMP("PXE",$J,EXAM,InvDt,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXE",$J,EXAM,InvDt,IFN,"S") = DATA SOURCE [E;81203]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     EXAM  - EXAM name
 ;     InvDt - Inverse FileMan date of DATE OF event or visit
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^PXRMINDX(9000010.13,"PI",DFN))
 N CNT,COMMENT,DATASRC,EPROV,EXAM,EXAMIEN,EXDT,HLOC,HLOCABB
 N IBEGDT,IDT,IENDDT,OPROV,PNAME,PXDT,PXEX,PXIFN
 N REC,RESULTC,RESULT,TMP0,TMP12,TMP220,TMP811,TMP812,VDATA
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ;Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXE",$J)
 S PXEX=""
 F  S PXEX=$O(^PXRMINDX(9000010.13,"PI",DFN,PXEX)) Q:PXEX=""  D
 . S PXDT=ENDDT+.01,CNT=0
 . F  S PXDT=$O(^PXRMINDX(9000010.13,"PI",DFN,PXEX,PXDT),-1) Q:PXDT'>0!(PXDT<BEGDT)  D  Q:CNT'<OCCLIM
 . . S PXIFN=0
 . . F  S PXIFN=$O(^PXRMINDX(9000010.13,"PI",DFN,PXEX,PXDT,PXIFN)) Q:PXIFN'>0  D  Q:CNT'<OCCLIM
 . . . S TMP0=$G(^AUPNVXAM(PXIFN,0))
 . . . S EXAMIEN=$P(TMP0,U,1)
 . . . Q:EXAMIEN=""
 . . . S TMP12=$G(^AUPNVXAM(PXIFN,12))
 . . . S TMP220=$G(^AUPNVXAM(PXIFN,220))
 . . . S TMP811=$G(^AUPNVXAM(PXIFN,811))
 . . . S TMP812=$G(^AUPNVXAM(PXIFN,812))
 . . . S VDATA=$$GETVDATA^PXRHS03($P(TMP0,U,3))
 . . . S EXAM=$P(^AUTTEXAM(EXAMIEN,0),U,1)
 . . . S PNAME=$P($G(^AUTTEXAM(EXAMIEN,200)),U,1)
 . . . I PNAME="" S PNAME=EXAM
 . . . S EXDT=$P(TMP12,U,1)
 . . . S:EXDT']"" EXDT=$P(VDATA,U,1)
 . . . S IDT=9999999-EXDT
 . . . I IDT<IBEGDT!(IDT>IENDDT) Q  ;Only get data within date range
 . . . S RESULTC=$P(TMP0,U,4)
 . . . S RESULT=$$EXTERNAL^DILFD(9000010.13,.04,"",$P(TMP0,U,4))
 . . . S OPROV=$$GET1^DIQ(9000010.13,PXIFN_",",1202)
 . . . S EPROV=$$GET1^DIQ(9000010.13,PXIFN_",",1202)
 . . . S HLOC=$P(VDATA,U,5)
 . . . S HLOCABB=$P(VDATA,U,6)
 . . . S DATASRC=$P(TMP812,U,3)
 . . . S COMMENT=TMP811
 . . . S ^TMP("PXE",$J,EXAM,IDT,PXIFN,0)=PNAME_U_EXDT_U_RESULTC_U_RESULT_U_OPROV_U_EPROV
 . . . S ^TMP("PXE",$J,EXAM,IDT,PXIFN,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 . . . S ^TMP("PXE",$J,EXAM,IDT,PXIFN,"COM")=COMMENT
 . . . S ^TMP("PXE",$J,EXAM,IDT,PXIFN,"MEASUREMENT")=TMP220
 . . . S ^TMP("PXE",$J,EXAM,IDT,PXIFN,"S")=DATASRC
 . . . S CNT=CNT+1
 Q
 ;
