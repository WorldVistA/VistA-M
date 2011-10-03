PXRHS06 ;ISL/SBW - PCE Visit Treatment data extract ;12/10/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13**;Aug 12, 1996
TREAT(DFN,ENDDT,BEGDT,OCCLIM,CATCODE) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
 ;         OCCLIM   - Maximum number of days for which data is returned
 ;                    (If multiple visits on a given day, all data for
 ;                    these visit will be returned) or an "R" for
 ;                    only the most recent occurrence of each topic
 ;                    Note: If event date is used, it may appear that too
 ;                          many occurrences are retrieved but it is
 ;                          it is based on visit date not event date.
 ;                    returned (Can include multiple codes)
 ;         CATCODE  - Pattern Match which controls visit data that is
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
 ;  Data from V TREATMENT (9000010.15) file
 ;  ^TMP("PXT,$J,InvDt,TREAT,IFN,0) = TREATMENT [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ HOW MANY [I;.04] ^ ORDERING PROVIDER [E;1202] 
 ;     ^ ENCOUNTER PROVIDER [E;1204]
 ;  ^TMP("PXT",$J,InvDt,TREAT,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXT",$J,InvDt,TREAT,IFN,"S") = DATA SOURCE [E;80102]
 ;  ^TMP("PXT",$J,InvDt,TREAT,IFN,"P") = PROVIDER NARRATIVE [E;.06]
 ;  ^TMP("PXT",$J,InvDt,TREAT,IFN,"PNC") = PROVIDER NARR. CATEGORY [E;80201]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     InvDt - Inverse FileMan date of DATE OF event or visit minus time
 ;     TREAT - TREATMENT PROVIDED
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^AUPNVTRT("AA",DFN))
 N PXIVD,PXIFN,CNT,PDT,IBEGDT,IENDDT
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXT",$J)
 S PXIVD=IBEGDT,CNT=0
 F  S PXIVD=$O(^AUPNVTRT("AA",DFN,PXIVD)) Q:PXIVD'>0!(PXIVD>IENDDT)  D  Q:CNT'<OCCLIM
 . S PXIFN=0
 . F  S PXIFN=$O(^AUPNVTRT("AA",DFN,PXIVD,PXIFN)) Q:PXIFN'>0  D
 . . N DIC,DIQ,DR,DA,REC,VDATA,TREAT,TRDT,NUM,PNARR,PNARRC,COMMENT
 . . N OPROV,EPROV,HLOC,HLOCABB,SOURCE,IDT
 . . S DIC=9000010.15,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 . . S DR=".01;.03;.04;.06;1201;1202;1204;80102;80201;81101"
 . . D EN^DIQ1
 . . Q:'$D(REC)
 . . S VDATA=$$GETVDATA^PXRHS03(+REC(9000010.15,DA,.03,"I"))
 . . Q:$G(CATCODE)'[$P(VDATA,U,3)  ;Only get data with passed serv. cat.
 . . S TREAT=REC(9000010.15,DA,.01,"E")
 . . S TRDT=REC(9000010.15,DA,1201,"I")
 . . S:TRDT']"" TRDT=$P(VDATA,U)
 . . S IDT=9999999-TRDT
 . . I IDT<IBEGDT!(IDT>IENDDT) Q  ;Only get data within date range
 . . S NUM=REC(9000010.15,DA,.04,"I")
 . . S OPROV=REC(9000010.15,DA,1202,"E")
 . . S EPROV=REC(9000010.15,DA,1204,"E")
 . . S HLOC=$P(VDATA,U,5)
 . . S HLOCABB=$P(VDATA,U,6)
 . . S SOURCE=REC(9000010.15,DA,80102,"E")
 . . S COMMENT=REC(9000010.15,DA,81101,"E")
 . . S PNARR=REC(9000010.15,DA,.06,"E")
 . . S PNARRC=REC(9000010.15,DA,80201,"E")
 . . S IDT=$P(IDT,".") ;Index with only date and no time
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,0)=TREAT_U_TRDT_U_NUM_U_OPROV_U_EPROV
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,"S")=SOURCE
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,"P")=PNARR
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,"PNC")=PNARRC
 . . S ^TMP("PXT",$J,IDT,TREAT,DA,"COM")=COMMENT
 . . ; Counter by date not by visit. There may be multiple visits with
 . . ; multiple treatments for any given day
 . . I PXIVD'=$G(PDT) S CNT=CNT+1,PDT=PXIVD
 Q
