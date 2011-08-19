PXRHS05 ;ISL/SBW - PCE V EXAM extract routine ;12/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13**;Aug 12, 1996
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
 ;  ^TMP("PXE,$J,EXAM,InvDt,IFN,0) = EXAM [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ RESULTS CODE [I;.04] ^ RESULTS [E;.04]
 ;     ^ ORDERING PROVIDER [E;1202] ^ ENCOUNTER PROVIDER [E;1204] ^
 ;  ^TMP("PXE",$J,EXAM,InvDt,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXE",$J,EXAM,InvDt,IFN,"S") = DATA SOURCE [E;80102]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     EXAM  - EXAM name
 ;     InvDt - Inverse FileMan date of DATE OF event or visit
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^AUPNVXAM("AA",DFN))
 N PXEX,PXIVD,PXIFN,CNT,IBEGDT,IENDDT
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXE",$J)
 S PXEX=""
 F  S PXEX=$O(^AUPNVXAM("AA",DFN,PXEX)) Q:PXEX=""  D
 . S PXIVD=IBEGDT,CNT=0
 . F  S PXIVD=$O(^AUPNVXAM("AA",DFN,PXEX,PXIVD)) Q:PXIVD'>0!(PXIVD>IENDDT)  D  Q:CNT'<OCCLIM
 . . S PXIFN=0
 . . F  S PXIFN=$O(^AUPNVXAM("AA",DFN,PXEX,PXIVD,PXIFN)) Q:PXIFN'>0  D  Q:CNT'<OCCLIM
 . . . N DIC,DIQ,DR,DA,REC,VDATA,EXAM,EXDT,RESULTC,RESULT,COMMENT
 . . . N OPROV,EPROV,HLOC,HLOCABB,SOURCE,IDT
 . . . S DIC=9000010.13,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 . . . S DR=".01;.03;.04;1201;1202;1204;80102;81101"
 . . . D EN^DIQ1
 . . . Q:'$D(REC)
 . . . S VDATA=$$GETVDATA^PXRHS03(+REC(9000010.13,DA,.03,"I"))
 . . . S EXAM=REC(9000010.13,DA,.01,"E")
 . . . S EXDT=REC(9000010.13,DA,1201,"I")
 . . . S:EXDT']"" EXDT=$P(VDATA,U)
 . . . S IDT=9999999-EXDT
 . . . I IDT<IBEGDT!(IDT>IENDDT) Q  ;Only get data within date range
 . . . S RESULTC=REC(9000010.13,DA,.04,"I")
 . . . S RESULT=REC(9000010.13,DA,.04,"E")
 . . . S OPROV=REC(9000010.13,DA,1202,"E")
 . . . S EPROV=REC(9000010.13,DA,1204,"E")
 . . . S HLOC=$P(VDATA,U,5)
 . . . S HLOCABB=$P(VDATA,U,6)
 . . . S SOURCE=REC(9000010.13,DA,80102,"E")
 . . . S COMMENT=REC(9000010.13,DA,81101,"E")
 . . . S ^TMP("PXE",$J,EXAM,IDT,DA,0)=EXAM_U_EXDT_U_RESULTC_U_RESULT_U_OPROV_U_EPROV
 . . . S ^TMP("PXE",$J,EXAM,IDT,DA,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 . . . S ^TMP("PXE",$J,EXAM,IDT,DA,"S")=SOURCE
 . . . S ^TMP("PXE",$J,EXAM,IDT,DA,"COM")=COMMENT
 . . . S CNT=CNT+1
 Q
