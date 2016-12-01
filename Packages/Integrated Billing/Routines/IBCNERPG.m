IBCNERPG ;BP/YMG - IBCNE EIV INSURANCE UPDATE REPORT COMPILE;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528,549**;16-SEP-09;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*549 Changes to documentation for IBCNESPC("PYR")
 ; IB*2.0*549 Sort is by payer name
 ; IB*2.0*549 Add IBCNESPC("INSCO")
 ;
 ; variables from IBCNERPF:
 ;   IBCNERTN = "IBCNERPF"
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("INSCO") = "A" (All ins. cos.) OR "S" (Selected ins. cos.)
 ;   IBCNESPC("PYR") - If this ="A", then include all
 ;   IBCNESPC("PYR",ien) - payer iens for report
 ;                       = 0 = No company detail
 ;                       = 1^A = Company detail, all corresponding companies
 ;                       = 1^S = Company detail, selected corresponding companies
 ;   
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("TYPE") = report type: "S" - summary, "D" - detailed
 ;   IBOUT = "R" for Report format or "E" for Excel format
 ;
 ; Output variables passed to IBCNERPH:
 ;   Summary report:
 ;     ^TMP($J,IBCNERTN)=Total Count
 ;     ^TMP($J,IBCNERTN,SORT1)=Payer Count
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Company Count
 ;     SORT1 - Payer Name, SORT2 - Company Name
 ;
 ;   Detailed report:
 ;     ^TMP($J,IBCNERTN,SORT1)=Count 
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2)=Count 
 ;     ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3)=Payer Name ^ Insurance Company Name ^ Pat. Name ^ SSN ^
 ;                                         Date Inquiry Sent ^ Date Policy Auto Updated ^ Days old ^ 
 ;                                         Trace Number
 ;     SORT1 - Payer Name, SORT2 - Date received, SORT3 - Count
 ;
 Q
 ;
EN(IBCNERTN,IBCNESPCI,IBOUT) ; Entry point
 ; IB*2.0*549 For summary reports go through all payers regardless of settings
 ; IB*2.0*549 Report on selected payers and insurance companies
 N ALLPYR,ALLPAT,DATE,BDATE,EDATE,RPDATA,RTYPE,SORT
 S ALLPYR=$S($G(IBCNESPC("PYR"))="A":1,1:0)
 S ALLPAT=$S($G(IBCNESPC("PAT"))="A":1,1:0)
 S BDATE=$G(IBCNESPC("BEGDT"))
 S EDATE=$G(IBCNESPC("ENDDT"))
 I EDATE'="",$P(EDATE,".",2)="" S EDATE=$$FMADD^XLFDT(EDATE,0,23,59,59)
 S RTYPE=$G(IBCNESPC("TYPE"))
 ; IB*2.0*549 Sort is by payer name
 I '$D(ZTQUEUED),$G(IOST)["C-",IBOUT="R" W !!,"Compiling report data ..."
 ; Kill scratch global
 K ^TMP($J,IBCNERTN)
 S DATE=$O(^IBCN(365,"AD",BDATE),-1)
 ; IB*2.0*549 For summary reports go through all payers regardless of settings
 F  S DATE=$O(^IBCN(365,"AD",DATE)) Q:'DATE!(DATE>EDATE)  D PAYERS(DATE,ALLPYR,ALLPAT,RTYPE) Q:$G(ZTSTOP)
 ; IB*2.0*549 Report all selected payers and insurance companies
 I RTYPE="S" D RPTSEL(.IBCNESPC,.RPDATA)
 M ^TMP($J,IBCNERTN)=RPDATA
 Q
 ;
PAYERS(DATE,ALLPYR,ALLPAT,RTYPE) ; loop through payers
 ; IB*2.0*549 For summary reports go through all payers regardless of settings
 N PYR
 S PYR=""
 ; IB*2.0*549 For summary report, look at all payers (only report company info sometimes)
 I 'ALLPYR D
 .I RTYPE="D" D
 ..F  S PYR=$O(IBCNESPC("PYR",PYR)) Q:'PYR  D:$O(^IBCN(365,"AD",DATE,PYR,"")) PATIENTS(DATE,PYR,ALLPYR,ALLPAT,RTYPE) Q:$G(ZTSTOP)
 .E  D
 ..F  S PYR=$O(^IBCN(365,"AD",DATE,PYR)) Q:'PYR  D PATIENTS(DATE,PYR,ALLPYR,ALLPAT,RTYPE) Q:$G(ZTSTOP)
 E  D
 .F  S PYR=$O(^IBCN(365,"AD",DATE,PYR)) Q:'PYR  D PATIENTS(DATE,PYR,ALLPYR,ALLPAT,RTYPE) Q:$G(ZTSTOP)
 Q
 ;
PATIENTS(DATE,PYR,ALLPYR,ALLPAT,RTYPE) ; loop through patients
 ; IB*2.0*549 For summary reports go through all payers regardless of settings
 N PAT
 S PAT=""
 I 'ALLPAT F  S PAT=$O(IBCNESPC("PAT",PAT)) Q:'PAT  D:$O(^IBCN(365,"AD",DATE,PYR,PAT,"")) GETDATA(DATE,PYR,ALLPYR,PAT,RTYPE) Q:$G(ZTSTOP)
 I ALLPAT F  S PAT=$O(^IBCN(365,"AD",DATE,PYR,PAT)) Q:'PAT  D GETDATA(DATE,PYR,ALLPYR,PAT,RTYPE) Q:$G(ZTSTOP)
 Q
 ;
GETDATA(DATE,PYR,ALLPYR,PAT,RTYPE) ; loop through responses and compile report
 ; IB*2.0*549 Remove fields to be printed and variables
 ; IB*2.0*549 Add fields and INSCONM,DTINQSNT,DTPOLUPD,TRACENUM and others
 N AUTOUPD,CLNAME,DTINQSNT,DTPOLUPD,FLG,IENS2,IENS312,IIEN,INS,INSCOMNM,NOW
 N PATNAME,PYRNAME,RIEN,SORT1,SORT2,SORT3,SSN,TOTMES,TQ,TRACENUM,TYPE,VDATE
 ;
 S NOW=$$NOW^XLFDT
 S (TOTMES,INS)=0
 S RIEN="" F  S RIEN=$O(^IBCN(365,"AD",DATE,PYR,PAT,RIEN)) Q:'RIEN  D  Q:$G(ZTSTOP)
 .S TOTMES=TOTMES+1 I $D(ZTQUEUED),TOTMES#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .S TQ=+$P(^IBCN(365,RIEN,0),U,5) I TQ S INS=+$P(^IBCN(365.1,TQ,0),U,13)
 .I 'INS Q
 .; IB*2.0*549 If summary version of report & selected ins co were chosen, do not consider others
 .; IB*2.0*549 If summary version of report & selected ins co were chosen, count for payer only includes
 .;                         counts for selected ins co
 .S IENS2=PAT_",",IENS312=INS_","_IENS2
 .S VDATE=$$GET1^DIQ(2.312,IENS312,1.03,"I") I VDATE=""!(VDATE<BDATE)!(VDATE>EDATE) Q
 .S PYRNAME=$P(^IBE(365.12,PYR,0),U),PATNAME=$$GET1^DIQ(2,IENS2,.01,"E")
 .S AUTOUPD=+$$GET1^DIQ(2.312,IENS312,4.04,"I")
 .; IB*2.0*549 Only include the auto update person
 .Q:'AUTOUPD
 .; IB*2.0*549 Add insurance company name
 .S IIEN=$$GET1^DIQ(2.312,IENS312,.01,"I")
 .S INSCOMNM=$$GET1^DIQ(36,IIEN,".01","I") ; Insurance Company name
 .; IB*2.0*549 Remove unnecessary variables
 .; IB*2.0*549 Sort by Payer's name
 .; IB*2.0*549 For summary version of report, include count for insurance company
 .; IB*2.0*549 Do not display insurance company detail if user selected to not display such
 .S SORT1=PYRNAME
 .S TYPE=$G(IBCNESPC("PYR",PYR))
 .I RTYPE="S" D  Q
 ..S RPDATA=$G(RPDATA)+1
 ..; IB*2.0*549 If all payers was not chosen; and
 ..;            If selected payers was chosen and this payer was not selected then quit here
 ..I '(ALLPYR!('ALLPYR&$D(IBCNESPC("PYR",PYR)))) Q
 ..S RPDATA(SORT1)=$G(RPDATA(SORT1))+1
 ..; IB*2.0*549 Do not display company data if:
 ..;              1) If the user chose to not display company data
 ..;              2) The use chose to display company data, and chose to 
 ..;                 select companies, but did not choose this company
 ..S FLG=$S($P(TYPE,"^",1)=0:0,(TYPE="1^S")&'$D(IBCNESPC("PYR",PYR,IIEN)):0,1:1)
 ..I FLG D
 ...S SORT2=INSCOMNM
 ...S RPDATA(SORT1,SORT2)=$G(RPDATA(SORT1,SORT2))+1
 .S SSN=$$GET1^DIQ(2,IENS2,.09,"E")
 .; IB*2.0*549 Get date eIV inquiry sent, date policy auto-updated and eIV Trace number
 .S DTINQSNT=$$FMTE^XLFDT($$GET1^DIQ(365,RIEN_",",".08","I"),"2DZ")
 .S DTPOLUPD=$$FMTE^XLFDT($$GET1^DIQ(2.312,IENS312,1.05,"I"),"2DZ")
 .S TRACENUM=$$GET1^DIQ(365,RIEN_",",".09","I")
 .; IB*2.0*549 Remove 'Ck AB', 'Clerk/Auto' and 'Verified'
 .; IB*2.0*549 Add Insurance Company, date eIV inquiry sent,
 .;            date policy auto updated and eIV Trace number
 .S SORT2=DATE
 .S RPDATA=$G(RPDATA)+1
 .S RPDATA(SORT1)=$G(RPDATA(SORT1))+1
 .; IB*2.0*549 On the detailed report do not display date eIV response
 .;            received, 'Ck AB', 'Clerk/Auto' and Verified
 .; IB*2.0*549 Add insurance company name, date eIV inquiry sent,
 .;            date policy auto-updated, and eIV Trace number
 .I TYPE="1^S",'$D(IBCNESPC("PYR",PYR,IIEN)) Q  ; If user chose selected co option, and company was not selected
 .;                                               don't print company info
 .S (RPDATA(SORT1,SORT2),SORT3)=$G(RPDATA(SORT1,SORT2))+1
 .S RPDATA(SORT1,SORT2,SORT3)=PYRNAME_U_INSCOMNM_U_PATNAME_U_SSN_U_DTINQSNT_U_DTPOLUPD
 .S RPDATA(SORT1,SORT2,SORT3)=RPDATA(SORT1,SORT2,SORT3)_U_$$FMDIFF^XLFDT(NOW,DATE)_U_TRACENUM
 .Q
 Q
 ;
RPTSEL(IBCNESPC,RPDATA) ; Report all selected payers/insurance companies
 ; IB*2.0*549 Report all selected payers/insurance companies
 N PYR,PYRNAME,IIEN,INSCOMNM
 S PYR=""
 F  S PYR=$O(IBCNESPC("PYR",PYR)) Q:'PYR  D
 .S PYRNAME=$$GET1^DIQ(365.12,PYR,".01","I")
 .S:'$D(RPDATA(PYRNAME)) RPDATA(PYRNAME)=0
 .S IIEN=""
 .F  S IIEN=$O(IBCNESPC("PYR",PYR,IIEN)) Q:IIEN=""  D
 ..S INSCOMNM=$$GET1^DIQ(36,IIEN,".01","I")
 ..S:'$D(RPDATA(PYRNAME,INSCOMNM)) RPDATA(PYRNAME,INSCOMNM)=0
 Q
 ;
