IBCNERPK ;IB/BAA/AWC - IBCN HL7 RESPONSE REPORT COMPILE;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; variables from IBCNERPL:
 ;   IBCNERTN = "IBCNERPF" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   INCNESPJ("BEGDT") = start date for date range
 ;   INCNESPJ("ENDDT") = end date for date range
 ;   INCNESPJ("PYR",ien) = payer iens for report, if INCNESPJ("PYR")="A", then include all
 ;   INCNESPJ("TYPE") = report type: "R" - Report, "E" - Excel
 ;
 ; Output :
 ;
 ;   Detailed report:
 ;     ^TMP($J,IBCNERTN,Payer Name)=Count 
 ;     ^TMP($J,IBCNERTN,Payer Name,Patient Name,N)=Payer Name ^ Patient Name ^ Date sent  
 ;                      ^ Date Received ^ Trace number ^ Buffer Number
 ;
 Q
 ;
EN(IBCNERTN,INCNESPJ) ; Entry point
 N ALLPYR,ALLPAT,DATE,BDATE,EDATE,RPDATA,RTYPE,SORT,BUSER,CRBUF,TRACE
 S BUSER=$$FIND1^DIC(200,"","X","INTERFACE,IB EIV")
 S ALLPYR=$S($G(INCNESPJ("PYR"))="A":1,1:0)
 S ALLPAT=$S($G(INCNESPJ("PAT"))="A":1,1:0)
 S BDATE=$G(INCNESPJ("BEGDT"))
 S EDATE=$G(INCNESPJ("ENDDT"))
 I EDATE'="",$P(EDATE,".",2)="" S EDATE=$$FMADD^XLFDT(EDATE,0,23,59,59)
 S RTYPE=$G(INCNESPJ("TYPE"))
 I '$D(ZTQUEUED),$G(IOST)["C-" W !!,"Compiling report data ..."
 ; Kill scratch global
 S DATE=$O(^IBCN(365,"AD",BDATE),-1)
 F  S DATE=$O(^IBCN(365,"AD",DATE)) Q:'DATE!(DATE>EDATE)  D PAYERS(DATE,ALLPYR)
 D EN^IBCNERPL(IBCNERTN,.INCNESPJ)
 Q
 ;
PAYERS(DATE,ALLPYR) ; loop through payers
 N PYR
 S PYR=0
 I 'ALLPYR F  S PYR=$O(INCNESPJ("PYR",PYR)) Q:'PYR  D:$O(^IBCN(365,"AD",DATE,PYR,"")) PATIENTS(DATE,PYR,ALLPAT)
 I ALLPYR F  S PYR=$O(^IBCN(365,"AD",DATE,PYR)) Q:'PYR  D PATIENTS(DATE,PYR,ALLPAT)
 Q
 ;
PATIENTS(DATE,PYR,ALLPAT) ; loop through patients
 N PAT
 S PAT=0
 I 'ALLPAT F  S PAT=$O(INCNESPJ("PAT",PAT)) Q:'PAT  D:$O(^IBCN(365,"AD",DATE,PYR,PAT,"")) GETDATA(DATE,PYR,PAT)
 I ALLPAT F  S PAT=$O(^IBCN(365,"AD",DATE,PYR,PAT)) Q:'PAT  D GETDATA(DATE,PYR,PAT)
 Q
 ;
GETDATA(DATE,PYR,PAT) ; loop through responses and compile report
 N RDATE,SDATE,IENS2,INS,NOW,PATNAME,PYRNAME,RIEN,BUFFER,SSN,TOTMES,TQ,VDATE,CNT
 ;
 S NOW=$$NOW^XLFDT
 S RIEN="",CNT=0
 F  S RIEN=$O(^IBCN(365,"AD",DATE,PYR,PAT,RIEN)) Q:'RIEN  D
 .S BUFFER=$P(^IBCN(365,RIEN,0),U,4)
 .I BUFFER="" Q
 .S CRBUF=$P($G(^IBA(355.33,BUFFER,0)),U,2)
 .;I CRBUF'=BUSER Q
 .S IENS2=PAT_","
 .S RDATE=$P(^IBCN(365,RIEN,0),U,7) I RDATE=""!(RDATE<BDATE)!(RDATE>EDATE) Q
 .S SDATE=$P(^IBCN(365,RIEN,0),U,8),TRACE=$P(^IBCN(365,RIEN,0),U,9)
 .S PYRNAME=$P(^IBE(365.12,PYR,0),U),PATNAME=$$GET1^DIQ(2,IENS2,.01,"E")
 .S SSN=$$GET1^DIQ(2,IENS2,.09,"I"),SSN=$E(SSN,6,9)
 .S CNT=CNT+1
 .S ^TMP($J,IBCNERTN,PYRNAME)=$G(^TMP($J,IBCNERTN,PYRNAME))+1
 .S ^TMP($J,IBCNERTN)=$G(^TMP($J,IBCNERTN))+1
 .S ^TMP($J,IBCNERTN,PYRNAME,PATNAME,CNT)=PYRNAME_U_PATNAME_U_SSN_U_SDATE_U_RDATE_U_TRACE_U_BUFFER
 .Q
 Q
