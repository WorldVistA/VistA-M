PXRHS07 ;ISL/SBW - PCE V HEALTH FACTORS extract routine ;09/9/03
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**13,123**;Aug 12, 1996
 ; Extract returns HEALTH FACTORS data
HF(DFN,ENDDT,BEGDT,OCCLIM,ITEMS) ; Control branching
 ;INPUT  : DFN      - Pointer to PATIENT file (#2)
 ;         ENDDT    - Ending date/time in internal FileMan format
 ;                  - Defaults to today's date at 11:59 pm
 ;         BEGDT    - Beginning date/time in internal FileMan format
 ;                  - Defaults to one year prior to today's date
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
 ;  ^TMP("PXF,$J,HFC,HF,InvDt,IFN,0) = Health Factor [E;.01]
 ;     ^ EVENT DATE/TIME or VISIT/ADMIT DATE&TIME [I;1201 or .03] 
 ;     ^ SHORT NAME [E;9999999.64;.04] ^ LEVEL/SEVERITY [E;.04]
 ;     ^ ORDERING PROVIDER [E;1202] ^ ENCOUNTER PROVIDER [E;1204] 
 ;  ^TMP("PXF",$J,HFC,HF,InvDt,IFN,1) = HOSPITAL LOCATION [E;9000010;.22] 
 ;     ^ HOSP. LOC. ABBREVIATION [E;44;1]
 ;     ^ LOC OF ENCOUNTER [E;9000010;.06] ^ OUTSIDE LOC [E;9000010;2101]
 ;  ^TMP("PXF",$J,HFC,HF,InvDt,IFN,"S") = DATA SOURCE [E;80102]
 ;
 ;   [] = [I(nternal)/E(xternal); Optional file #; Record #]
 ;   Subscripts:
 ;     HFC   - Health Factor Category name
 ;     HF    - Health Factor name
 ;     InvDt - Inverse FileMan date of DATE OF event or visit
 ;     IFN   - Internal Record #
 ;
 Q:$G(DFN)']""!'$D(^AUPNVHF("AA",DFN))
 N PXHFC,IBEGDT,IENDDT,ITEM
 N HFIEN,CATIEN,CATNAME
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(BEGDT)'>0 BEGDT=DT-10000
 S:+$G(ENDDT)'>0 ENDDT=DT_".235959"
 ; Chg regular dt/time to inverted dt/time
 S IBEGDT=9999999-ENDDT,IENDDT=9999999-BEGDT
 K ^TMP("PXF",$J)
 ;I $D(ITEMS)'>0 D  Q
 ;. S PXHFC=0
 ;. F  S PXHFC=$O(^AUTTHF("AD","C",PXHFC)) Q:PXHFC'>0  D GETVHF(PXHFC,OCCLIM)
 ;I $D(ITEMS)>0 D
 ;. S PXHFC=0
 ;. F  S PXHFC=$O(ITEMS(PXHFC)) Q:PXHFC'>0  D GETVHF(PXHFC,OCCLIM)
 ;Q
 ;
 ;If no ITEMS are defined build a list of all health factors for the
 ;patient.
 I $D(ITEMS)'>0 D  Q
 . S PXHFC=0
 . F  S PXHFC=$O(^AUTTHF("AD","C",PXHFC)) Q:PXHFC'>0  D GETVHF(PXHFC,OCCLIM)
 ;. . S CATIEN=$P(^AUTTHF(PXHFC,0),U,3)
 ;.. S CATNAME=$P(^AUTTHF(CATIEN,0),U,1)
 ;.. D GETVHF(CATNAME,PXHFC,OCCLIM)
 ;
 ;Loop through the items array to find hf associate with category and
 ;individual health factor placed finding into temp array & sort by alpha
 S ITEM=""
 F  S ITEM=$O(ITEMS(ITEM)) Q:ITEM=""  D
 .;If a category get all health factors in category.
 . I $P(^AUTTHF(ITEM,0),U,10)="C" D  Q
 . . ;S CATNAME=$P(^AUTTHF(ITEM,0),U)
 . . ;S HFIEN=""
 . . ;F  S HFIEN=$O(^AUTTHF("AC",ITEM,HFIEN)) Q:HFIEN=""
 . . D GETVHF(ITEM,OCCLIM)
 .;If a factor just process it.
 . I $P(^AUTTHF(ITEM,0),U,10)="F" D
 . . S CATIEN=$P(^AUTTHF(ITEM,0),U,3)
 . . S CATNAME=$P(^AUTTHF(CATIEN,0),U,1)
 . . D PHF(ITEM,OCCLIM)
 Q
GETVHF(PXHFC,MAX) ;Get Health Factors within a category
 N PXHF
 S PXHF=0
 F  S PXHF=$O(^AUTTHF("AC",PXHFC,PXHF)) Q:PXHF'>0  D PHF(PXHF,MAX)
 Q
PHF(PXHF,MAX) ; Get Health Factors within a category
 N PXIVD,PXIFN,CNT,PDT
 ;S PXHF=0
 ;F  S PXHF=$O(^AUTTHF("AC",PXHFC,PXHF)) Q:PXHF'>0  D
 S CNT=0,PXIVD=0
 F  S PXIVD=$O(^AUPNVHF("AA",DFN,PXHF,PXIVD)) Q:PXIVD'>0!(CNT'<OCCLIM)  D
 . S PXIFN=0
 . F  S PXIFN=$O(^AUPNVHF("AA",DFN,PXHF,PXIVD,PXIFN)) Q:PXIFN'>0  D
 . . N DIC,DIQ,DR,DA,REC,VDATA,HFC,HF,EXDT,LEVEL,SNAME,COMMENT
 . . N OPROV,EPROV,HLOC,HLOCABB,SOURCE,IDT
 . . S DIC=9000010.23,DA=PXIFN,DIQ="REC(",DIQ(0)="IE"
 . . S DR=".01;.03;.04;1201;1202;1204;80102;81101"
 . . D EN^DIQ1
 . . Q:'$D(REC)
 . . S VDATA=$$GETVDATA^PXRHS03(+REC(9000010.23,DA,.03,"I"))
 . . S HF=REC(9000010.23,DA,.01,"E")
 . . S EXDT=REC(9000010.23,DA,1201,"I")
 . . S:EXDT']"" EXDT=$P(VDATA,U)
 . . S IDT=9999999-EXDT
 . . I IDT<IBEGDT!(IDT>IENDDT) Q  ;Only get data within date range
 . . I CNT'<OCCLIM Q
 . . D GETHF(REC(9000010.23,DA,.01,"I"),.HFC,.SNAME)
 . . S LEVEL=REC(9000010.23,DA,.04,"E")
 . . S OPROV=REC(9000010.23,DA,1202,"E")
 . . S EPROV=REC(9000010.23,DA,1204,"E")
 . . S HLOC=$P(VDATA,U,5)
 . . S HLOCABB=$P(VDATA,U,6)
 . . S SOURCE=REC(9000010.23,DA,80102,"E")
 . . S COMMENT=REC(9000010.23,DA,81101,"E")
 . . S ^TMP("PXF",$J,HFC,HF,IDT,DA,0)=HF_U_EXDT_U_SNAME_U_LEVEL_U_OPROV_U_EPROV
 . . S ^TMP("PXF",$J,HFC,HF,IDT,DA,1)=HLOC_U_HLOCABB_U_$P(VDATA,U,2)_U_$P(VDATA,U,4)
 . . S ^TMP("PXF",$J,HFC,HF,IDT,DA,"S")=SOURCE
 . . S ^TMP("PXF",$J,HFC,HF,IDT,DA,"COM")=COMMENT
 . . ;Counter by health factor and date, not by visit. There may be
 . . ;multiple health factors for any given day
 . . I PXIVD'=$G(PDT) S PDT=PXIVD
 . . S CNT=CNT+1
 Q
GETHF(DA,HFC,SNAME) ;
 N DIC,DIQ,DR,REC
 S DIC=9999999.64,DIQ="REC(",DIQ(0)="E",DR=".01;.03;.04"
 D EN^DIQ1
 I '$D(REC) S (HFC,SNAME)="" Q
 S HFC=REC(9999999.64,DA,.03,"E")
 S SNAME=REC(9999999.64,DA,.04,"E")
 Q
