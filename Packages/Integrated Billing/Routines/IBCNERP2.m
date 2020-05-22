IBCNERP2 ;DAOU/BHS - IBCNE eIV RESPONSE REPORT COMPILE ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,528,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Input vars from IBCNERP1:
 ;  IBCNERTN="IBCNERP1"
 ;  IBCNESPC("BEGDT")=Start Dt for rpt
 ;  IBCNESPC("ENDDT")=End Dt for rpt
 ;  IBCNESPC("PYR")=Pyr IEN for rpt. If "", then show all.
 ;  IBCNESPC("PAT")=Pt IEN for rpt. If "", then show all.
 ;  IBCNESPC("TYPE")=A (All Responses) for date range OR M (Most Recent
 ;   Responses) for date range (by unique Pyr/Pt pair)
 ;  IBCNESPC("SORT")=1 (Pyr nm) OR 2 (Pt nm)
 ;  IBCNESPC("TRCN")=Trace #^IEN, if non-null, all other params are null
 ;  IBCNESPC("RFLAG")=Report Flag used to indicate which report is being
 ;   run.  Response Report (0), Inactive Report (1), or Ambiguous
 ;   Report (2).
 ;  IBCNESPC("DTEXP")=Expiration date used in the inactive policy report
 ;  IBOUT="R" for Report format or "E" for Excel format
 ;
 ; Output vars used by IBCNERP3:
 ;  Structure of ^TMP based on eIV Response File (#365)
 ;   IBCNERTN="IBCNERP1"
 ;   SORT1=PyrNm (SORT=1) or PtNm(SORT=2)
 ;   SORT2=PtNm (SORT=1) or PyrNm (SORT=2)
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,CNT,0/1) based on ^IBCN(365,DA,0/1)
 ;   CNT=Seq ct
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,2,EBCT) based on ^IBCN(365,DA,2,EBCT,0)
 ;   EBCT = Elig/Benefit multiple field IEN (ptr to 365.02)
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,2,EBCT,NTCT) based on
 ;   ^IBCN(365,DA,2,EB,0,NT,0) Notes for EB seg
 ;   NTCT = Notes Ct may not equal Notes IEN (365.22) if ln must wrap
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,3,CNCT) based on ^IBCN(365,DA,3,CNCT,0)
 ;   CNCT = Contact Person multiple field IEN (ptr to 365.03)
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,4,CT) based on ^IBCN(365,DA,4)
 ;    CT=1 if len of text <=70, else ln is split
 ;  ^TMP($J,IBCNERTN,SORT1,SORT2,5,CT) based on # lns of comments reqd
 ;    CT=1 to display future retransmission date
 ;
 ; Must call at EN
 Q
 ;
 ;
EN(IBCNERTN,IBCNESPC,IBOUT) ; Entry
 ; Init
 N IBDT,IBBDT,IBPY,IBPYR,IBPT
 N IBPAT,IBPTR,SORT1,SORT2,RPTDATA,IBTOT
 N PYRIEN,PATIEN,IBTRC,IBTYP,IBCT,IBSRT,IBEXP,FRST,TQN,DONTINC,IPRF
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-",$G(IBOUT)="R" W !!,"Compiling report data ..."
 ;
 ; Temp ct
 S (IBTOT,IBCT)=0
 ;
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN),^TMP($J,IBCNERTN_"X")
 ;
 S IBTRC=$G(IBCNESPC("TRCN"))
 ; Skip for TRACE#
 I IBTRC'="" G TRCN
 ;
 S IBBDT=IBCNESPC("BEGDT")
 S IBPY=$G(IBCNESPC("PYR"))
 S IBPT=$G(IBCNESPC("PAT"))
 S IBTYP=$G(IBCNESPC("TYPE"))
 S IBSRT=$G(IBCNESPC("SORT"))
 S IBEXP=$G(IBCNESPC("DTEXP"))
 S IPRF=$G(IBCNESPC("RFLAG"))
 ;
 ; Loop thru the eIV Response File (#365) by Date/Time Response Rec X-Ref
 ; S IBDT=$O(^IBCN(365,"AD",IBCNESPC("ENDDT")))
 ; Initialize IBDT to end date 
 S IBDT=IBCNESPC("ENDDT")_".999999"
 F  S IBDT=$O(^IBCN(365,"AD",IBDT),-1) Q:IBDT=""!($P(IBDT,".",1)<IBBDT)  D  Q:$G(ZTSTOP)
 . S PYRIEN=$S(IBPY="":0,1:$O(^IBCN(365,"AD",IBDT,IBPY),-1))
 . F  S PYRIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN)) Q:'PYRIEN!((IBPY'="")&(PYRIEN'=IBPY))  D  Q:$G(ZTSTOP)
 .. I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. ; Pyr nm from Pyr File (#365.12)
 .. S IBPYR=$P($G(^IBE(365.12,PYRIEN,0)),U)
 .. I IBPYR="" Q
 .. S PATIEN=$S(IBPT="":0,1:$O(^IBCN(365,"AD",IBDT,PYRIEN,IBPT),-1))
 .. F  S PATIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN)) Q:'PATIEN!((IBPT'="")&(PATIEN'=IBPT))  D  Q:$G(ZTSTOP)
 ... ; Pt nm from Pt File (#2)
 ... S IBPAT=$P($G(^DPT(PATIEN,0)),U)
 ... I IBPAT="" Q
 ... S IBPTR=0
 ... F  S IBPTR=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN,IBPTR)) Q:'IBPTR  D  Q:$G(ZTSTOP)
 .... S IBTOT=IBTOT+1
 .... ; Since non-positive identifications are no longer placed in the 
 .... ; insurance buffer, two new reports were added to allow users to
 .... ; view the responses.  One report (IPFR=1) shows only responses
 .... ; of inactive policies.  The other (IPFR=2) shows ambiguous responses.
 .... ; Any response that is not active nor inactive is considered 
 .... ; ambiguous for the purposes of this report.
 .... I IPRF D  Q:DONTINC
 ..... N EBIC,NODE1,PCD
 ..... S DONTINC=1
 ..... S TQN=$P($G(^IBCN(365,IBPTR,0)),U,5) Q:TQN=""  ; TQ ien (#365.1)
 ..... S NODE1=$G(^IBCN(365,IBPTR,1))
 ..... I $P($G(^IBCN(365.1,TQN,0)),U,11)="V" Q     ; If verification quit
 ..... I IPRF=1,($P(NODE1,U,12)="")!($P(NODE1,U,12)<$G(IBEXP)) Q
 ..... S FRST=$O(^IBCN(365,IBPTR,2,0))
 ..... I FRST="" Q
 ..... S PCD=$P($G(^IBCN(365,IBPTR,2,FRST,0)),U,6)
 ..... I PCD]"",PCD'="eIV Eligibility Determination" Q
 ..... S EBIC=$$GET1^DIQ(365.02,FRST_","_IBPTR_",","ELIGIBILITY/BENEFIT INFO:CODE")
 ..... I PCD]"",IPRF=1,EBIC'=6 Q
 ..... I PCD]"",IPRF=2,EBIC=6!(EBIC=1) Q
 ..... I $P(NODE1,U,14)]"" Q  ; Error Condition
 ..... I $P(NODE1,U,15)]"" Q  ; Error Action
 ..... I $P($G(^IBCN(365,IBPTR,4)),U)]"" Q  ; Error Text
 ..... S DONTINC=0
 ....;
 .... I $D(ZTQUEUED),IBTOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .... ; Sort fields
 .... S SORT1=$S(IBSRT=1:IBPYR,1:IBPAT)
 .... S SORT2=$S(IBSRT=1:IBPAT,1:IBPYR)
 .... ; Only check for Most Recent - Pyr/Pt pair
 .... I IBTYP="M",$D(^TMP($J,IBCNERTN_"X",PYRIEN,PATIEN)) Q
 .... ; Set temp ind.
 .... I IBTYP="M" S ^TMP($J,IBCNERTN_"X",PYRIEN,PATIEN)=""
 .... ; Update ct
 .... S IBCT=IBCT+1
 .... ; Sort data - build RPTDATA array
 .... K RPTDATA
 .... D GETDATA^IBCNERPE(IBPTR,.RPTDATA)
 .... ; Merge data from RPTDATA to ^TMP
 .... M ^TMP($J,IBCNERTN,SORT1,SORT2,IBCT)=RPTDATA
 .... ;IB*2.0*659/TAZ - Store Response File IEN for later use
 .... S ^TMP($J,IBCNERTN,SORT1,SORT2,IBCT,"RSPIENS")=IBPTR
 ;
 ; Purge index of duplicate Pyr/Pt combos
 K ^TMP($J,IBCNERTN_"X")
 ;
 G EXIT
 ;
TRCN ; Trace # proc.
 S IBPTR=$P(IBTRC,U,2)
 I IBPTR="" G EXIT
 ; Sort the data - build RPTDATA array
 KILL RPTDATA
 D GETDATA^IBCNERPE(IBPTR,.RPTDATA)
 ; Default sort - one record
 ; Pyr nm from Pyr File (#365.12)
 S PYRIEN=$P(RPTDATA(0),U,3)
 I PYRIEN="" G EXIT
 S SORT1=$P($G(^IBE(365.12,PYRIEN,0)),U,1)
 I SORT1="" G EXIT
 ; Pt nm from Pt File (#2)
 S PATIEN=$P(RPTDATA(0),U,2)
 I PATIEN="" G EXIT
 S SORT2=$P($G(^DPT(PATIEN,0)),U,1)
 I SORT2="" G EXIT
 ; Merge data- RPTDATA to ^TMP
 M ^TMP($J,IBCNERTN,SORT1,SORT2,1)=RPTDATA
 ;IB*2.0*659/TAZ - Store Response File IEN for later use
 S ^TMP($J,IBCNERTN,SORT1,SORT2,1,"RSPIENS")=IBPTR
 ;
EXIT ;
 Q
 ;
X12(FILE,CODE,FLD) ; Output based on File # and X12 code
 I $G(FILE)=""!($G(CODE)="") Q ""
 ; Quit w/o label if not defined in File Def.
 Q $$LBL(365.02,$G(FLD))_$P($G(^IBE(FILE,CODE,0)),U,2)  ;
LBL(FILE,FLD) ; Determine label from File Def.
 N IBLBL
 ;
 I $G(FILE)=""!($G(FLD)="") Q ""
 S IBLBL=$$GET1^DID(FILE,FLD,"","TITLE")
 Q $S(IBLBL'="":IBLBL_": ",1:"")
 ;
