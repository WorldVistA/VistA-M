PXRHS08 ;ISL/SBW - PCE Visit Patient Education data extract ;2/14/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,16**;Aug 12, 1996
EDUC(DFN,ENDDT,BEGDT,OCCLIM,CATCODE) ; Control branching
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
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,0) = TOPIC [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ LEVEL OF UNDERSTANDING [E;.06] ^ ORDERING PROVIDER [E;1202] 
 ;     ^ ENCOUNTER PROVIDER [E;1204]
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXPE",$J,InvDt,TOPIC,IFN,"S") = DATA SOURCE [E;80102]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     InvDt - Inverse FileMan date of DATE OF event or visit
 ;     TOPIC - Patient Education Topic
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^AUPNVPED("AA",DFN))
 N PXIED,PXIVD,PXIFN,CNT,PDT,GMA,IBEGDT,IENDDT
 S:($G(OCCLIM)'="R")&(+$G(OCCLIM)'>0) OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXPE",$J)
 I OCCLIM="R" D  Q  ;Get each most recent topic for time period
 . S PXIED=""
 . F  S PXIED=$O(^AUPNVPED("AA",DFN,PXIED)) Q:PXIED=""  D
 . . S PXIVD=$O(^AUPNVPED("AA",DFN,PXIED,""))
 . . I (PXIVD'<IBEGDT)&(PXIVD'>IENDDT) D
 . . . S PXIFN=$O(^AUPNVPED("AA",DFN,PXIED,PXIVD,""))
 . . . D GETDATA
 ;
 ;. S CNT=0,PXIVD=IBEGDT
 ;. F  S PXIVD=$O(^AUPNVPED("AA",DFN,PXIVD)) Q:PXIVD'>0!(PXIVD>IENDDT)  D  Q:CNT'<OCCLIM
 ;. . S PXIFN=0
 ;. . F  S PXIFN=$O(^AUPNVPED("AA",DFN,PXIVD,PXIFN)) Q:PXIFN'>0  D GETDATA
 ;
 I OCCLIM>0 D  Q
 . S PXED=""
 . F  S PXED=$O(^AUPNVPED("AA",DFN,PXED)) Q:PXED=""  D
 . . S PXIVD=IBEGDT,CNT=0
 . . F  S PXIVD=$O(^AUPNVPED("AA",DFN,PXED,PXIVD)) Q:PXIVD'>0!(PXIVD>IENDDT)  D  Q:CNT'<OCCLIM
 . . . S PXIFN=0
 . . . F  S PXIFN=$O(^AUPNVPED("AA",DFN,PXED,PXIVD,PXIFN)) Q:PXIFN'>0  D  Q:CNT'<OCCLIM
 . . . . D GETDATA
 Q
 ;
GETDATA ;
 N DIC,DIQ,DR,DA,REC,VDATA,TOPIC,EDDT,LEVEL
 N OPROV,EPROV,HLOC,HLOCABB,SOURCE,IDT,COMMENT
 S DIC=9000010.16,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 S DR=".01;.03;.06;1201;1202;1204;80102;80201;81101"
 D EN^DIQ1
 Q:'$D(REC)
 S VDATA=$$GETVDATA^PXRHS03(+REC(9000010.16,DA,.03,"I"))
 Q:$G(CATCODE)'[$P(VDATA,U,3)  ;Only get data with passed serv. cat.
 S TOPIC=REC(9000010.16,DA,.01,"E")
 S EDDT=REC(9000010.16,DA,1201,"I")
 S:EDDT']"" EDDT=$P(VDATA,U)
 S IDT=9999999-EDDT
 I IDT<IBEGDT!(IDT>IENDDT) Q  ;Only get data within date range
 I OCCLIM="R" Q:$D(GMA(TOPIC))  ;Get only most recent Pat. Ed. topic
 S LEVEL=REC(9000010.16,DA,.06,"E")
 S OPROV=REC(9000010.16,DA,1202,"E")
 S EPROV=REC(9000010.16,DA,1204,"E")
 S HLOC=$P(VDATA,U,5)
 S HLOCABB=$P(VDATA,U,6)
 S SOURCE=REC(9000010.16,DA,80102,"E")
 S COMMENT=REC(9000010.16,DA,81101,"E")
 S ^TMP("PXPE",$J,IDT,TOPIC,DA,0)=TOPIC_U_EDDT_U_LEVEL_U_OPROV_U_EPROV
 S ^TMP("PXPE",$J,IDT,TOPIC,DA,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 S ^TMP("PXPE",$J,IDT,TOPIC,DA,"S")=SOURCE
 S ^TMP("PXPE",$J,IDT,TOPIC,DA,"COM")=COMMENT
 ; Counter by date not by visit. There may be multiple visits with
 ; multiple patient education topics for any given day
 I OCCLIM>0,PXIVD'=$G(PDT) S CNT=CNT+1,PDT=PXIVD
 I OCCLIM="R" S GMA(TOPIC)=""
 Q
