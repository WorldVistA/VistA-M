IBNCPEV3 ;ALB/DMB - ECME RXS WITH NON-BILLABLE STATUS ;5/22/08
 ;;2.0;INTEGRATED BILLING;**534**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #6131 documents the usage of this entry point by the ECME application
 ;
COLLECT(BEGDT,ENDDT,MWC,RELNRL,IBDRUG,DRUGCLS,ALLRCNT,IBPHARM,IBINS,IBNBSTS,IBELIG1,IBGLTMP) ;
 ; Compile the data for the new Non-Billable Status report
 ; Input:
 ;    BEGDT - Beginning Date
 ;    ENDDT - Ending Date
 ;      MWC - A:All; M:Mail; W:Window; C:CMOP Prescriptions
 ;   RELNRL - 1:All; 2:Released; 3:Not Released
 ;   IBDRUG - 0:All; DRUG to report on (ptr to #50)
 ;  DRUGCLS - 0:All; DRUG CLASS to report on
 ;  ALLRCNT - A:All; R:Most recent
 ;  IBPHARM/IBPHARM(ptr) - 0:All pharmacies; 1:Array of IENs of pharmacies
 ;  IBINS/IBINS(ptr) - 0:All insurances or list of file 36 IENs
 ;  IBNBSTS/IBNBSTS(x) - 0:All; 1:Array of Non-Billable Status
 ;  IBELIG1/IBELIG1(x) - 0:All; 1:Array of multiple eligibilities
 ;  IBGLTMP - Temporary Global Storage (returned with extracted data)
 ; Output:
 ;    1 - Successful
 ;   -1 - Unsuccessful
 ;     
 ; Check Parameters
 I $G(IBGLTMP)="" Q -1
 ;
 N DATE,IEN,IEN1,X,X0,X2,X7,DIV,INS,RX,FILL,DRUG,RLDT,ELIG
 N DFN,DRGCOST,STATUS
 K ^TMP($J)
 ;
 ; Loop through the IB NCPDP Event Log for the data range
 S DATE=BEGDT-.1 F  S DATE=$O(^IBCNR(366.14,"B",DATE)) Q:'DATE!(DATE>ENDDT)  D
 . S IEN="" F  S IEN=$O(^IBCNR(366.14,"B",DATE,IEN)) Q:'IEN  D
 .. S IEN1=0 F  S IEN1=$O(^IBCNR(366.14,IEN,1,IEN1)) Q:'IEN1  D
 ... S X0=$G(^IBCNR(366.14,IEN,1,IEN1,0))
 ... ;
 ... ; If not a Billable Status Check, quit
 ... I +X0'=1 Q
 ... ;
 ... ; If successful, quit
 ... I $P(X0,"^",7)'=0 Q
 ... ;
 ... ; Check Non-Status Reason matches user input
 ... I IBNBSTS=1,'$D(IBNBSTS(+$P(X0,U,2))) Q
 ... ;
 ... ; Check Division matches user input
 ... S DIV=+$P(X0,U,9)
 ... I IBPHARM=1,'$D(IBPHARM(DIV)) Q
 ... ;
 ... ; Check Insurance matches user input
 ... S INS=$$GETINS(IEN,IEN1)
 ... I IBINS'=0,'$$CHKINS(IBINS,+INS) Q
 ... S INS=$P(INS,"^",2)
 ... ;
 ... ; Get Rx and Fill
 ... S X2=$G(^IBCNR(366.14,IEN,1,IEN1,2))
 ... S RX=$P(X2,U,12),FILL=$P(X2,U,3)
 ... I 'RX S RX=$P(X2,U,2)
 ... I 'RX Q
 ... ;
 ... ; Check Fill Type matches user input
 ... I MWC'="A",MWC'=$$MWC^PSOBPSU2(RX,FILL) Q
 ... ;
 ... ; Check Drug matches user input
 ... S DRUG=$$FILE^IBRXUTL(RX,6,"I")
 ... I IBDRUG,IBDRUG'=DRUG Q
 ... ;
 ... ; Check Drug Class matches user input
 ... I DRUGCLS'=0,DRUGCLS'=$$CLSNAME($$DRUGDIE(DRUG,25,"I")) Q
 ... ;
 ... ; Check Released matches user input
 ... S RLDT=$P($$RXRLDT^PSOBPSUT(RX,FILL),".")
 ... I RELNRL'=1 Q:RELNRL=2&'RLDT  Q:RELNRL=3&RLDT
 ... ;
 ... ; Check Eligibilities matches user input
 ... S X7=$G(^IBCNR(366.14,IEN,1,IEN1,7))
 ... S ELIG=$P(X7,U,5)
 ... I IBELIG1=1,'$D(IBELIG1(ELIG)) Q
 ... ;
 ... ; Get Data
 ... ;  Division, Insurance, Patient Name, SSN, Eligibility, RX, Fill
 ... ;  Date, Drug Cost, Drug, Released On, Fill Type,
 ... ;  Status (RX status/Released-Not released)
 ... S DFN=+$P(X0,U,3)
 ... S DRGCOST=$$COST(RX,FILL)
 ... S STATUS=$$RXAPI1^IBNCPUT1(RX,100,"I")
 ... ; If most recent, temporary Sort by RX and Fill
 ... ; Else store in the global
 ... I ALLRCNT="R" S ^TMP($J,"IBNCPEV3",+RX,+FILL,DATE)=DIV_U_INS_U_DFN_U_ELIG_U_DRGCOST_U_0_U_DRUG_U_RLDT_U_STATUS_U_$P(X0,U,2)
 ... E  S @IBGLTMP@(DIV,INS,+DFN,DATE,+RX,+FILL)=ELIG_U_DRGCOST_U_0_U_DRUG_U_RLDT_U_STATUS_U_$P(X0,U,2)
 ;
 ; If most recent, get most recent record for each RX and fill and populate the array
 I ALLRCNT="R" D
 . S RX="" F  S RX=$O(^TMP($J,"IBNCPEV3",RX)) Q:'RX  D
 .. S FILL="" F  S FILL=$O(^TMP($J,"IBNCPEV3",RX,FILL)) Q:FILL=""  D
 ... S DATE=$O(^TMP($J,"IBNCPEV3",RX,FILL,""),-1)
 ... S X=$G(^TMP($J,"IBNCPEV3",RX,FILL,DATE)),DIV=$P(X,U,1),INS=$P(X,U,2),DFN=$P(X,U,3)
 ... S @IBGLTMP@(DIV,INS,+DFN,DATE,RX,FILL)=$P(X,U,4,10)
 . ; Clean up scratch global
 . K ^TMP($J,"IBNCPEV3")
 Q 1
 ;
 ;
DRUGDIE(IEN,FLD,FORMAT,IBARR) ;
 ;  Return field values for Drug file 
 ;  Function returns field data if one field is specified. If
 ;    multiple fields, the function will return "" and the field
 ;    values are returned in IBARR
 ; Example: W $$DRUGDIE^IBNCPEV3(134,25,"E",.ARR)
 ;  IEN - IEN of DRUG FILE #50
 ;  FLD - Field Number(s) (like .01)
 ;  FORMAT - Specifies internal or external value of returned field
 ;         - optional, defaults to "I"
 ;  IBARR - Array to return value(s). Optional. Pass by reference.
 ;           See EN^DIQ documentation for variable DIQ
 ;
 I $G(IEN)="" Q ""
 I $G(FLD)="" Q ""
 I $G(FORMAT)'="E" S FORMAT="I"
 N DIQ,PSSDIY,IBDIQ
 S IBDIQ="IBARR",IBDIQ(0)=FORMAT
 D EN^PSSDI(50,"IB",50,.FLD,.IEN,.IBDIQ)
 Q $G(IBARR(50,IEN,FLD,FORMAT))
 ;
CLSNAME(CLASS) ;
 ; Get Drug Class Name
 I $G(CLASS)="" Q ""
 K ^TMP($J,"IBPEV-CLASS")
 N Y,IEN
 S Y=""
 D C^PSN50P65(CLASS,"","IBPEV-CLASS")
 S IEN=$O(^TMP($J,"IBPEV-CLASS",0))
 I IEN]"" S Y=$G(^TMP($J,"IBPEV-CLASS",IEN,1))
 K ^TMP($J,"IBPEV-CLASS")
 Q Y
 ;
GETINS(IEN,IEN1) ;
 ;Get the Insurance from INSURANCE multiple
 ;Input: IEN  = IEN of the IB NCPCP BILLING EVENT LOG
 ;       IEN1 = IEN of the EVENT subfile
 ;
 ;Output: Insurance Company Pointer or null if not found
 ;
 I '$G(IEN) Q "0^UNKNOWN INSURANCE"
 I '$G(IEN1) Q "0^UNKNOWN INSURANCE"
 ;
 ; Get Group Plan from first INSURANCE multiple entry
 N IEN2,GPLAN,INS,INSNM
 S IEN2=$O(^IBCNR(366.14,IEN,1,IEN1,5,0))
 I 'IEN2 Q "0^UNKNOWN INSURANCE"
 S GPLAN=$P($G(^IBCNR(366.14,IEN,1,IEN1,5,IEN2,0)),"^",2)
 I 'GPLAN Q "0^UNKNOWN INSURANCE"
 ;
 ; Get Insurance Company from the Group Plan record
 S INS=+$G(^IBA(355.3,GPLAN,0))
 I INS=0 Q "0^UNKNOWN INSURANCE"
 S INSNM=$$GET1^DIQ(36,INS,.01,"E")
 I INSNM="" S INSNM="UNKNOWN INSURANCE"
 Q INS_"^"_INSNM
 ;
CHKINS(LIST,INS) ;
 ;Check if the IB NCPDP EVENT LOG has the user-entered insurance
 ;Input: LIST = Semi-colon separated list of Insurances selected by the user
 ;       INS  = IEN of the Insurance Company (#36) file
 ;
 ;Output: 1 = Match found
 ;        0 = No match found
 ;
 I $G(LIST)="" Q 0
 I '$G(INS) Q 0
 ;
 N I,IN1,RETV
 S RETV=0
 F I=2:1 S IN1=$P($G(LIST),";",I) Q:IN1=""  S RETV=$S(IN1=INS:1,1:0) Q:RETV
 Q RETV
 ;
COST(RX,FILL) ;
 ; Calculate Drug Cost for RX/Fill
 ; Input:
 ;   RX:   Prescription IEN
 ;   FILL: Fill Number
 ; Output:
 ;   Drug Cost
 ;
 I '$G(RX) Q ""
 I $G(FILL)="" Q ""
 ;
 N DATA,COST,QTY
 I FILL=0 S COST=$$FILE^IBRXUTL(RX,17,"I"),QTY=$$FILE^IBRXUTL(RX,7,"I")
 I FILL S COST=$$SUBFILE^IBRXUTL(RX,FILL,"",1.2,"I"),QTY=$$SUBFILE^IBRXUTL(RX,FILL,"",1,"I")
 Q COST*QTY
 ;
