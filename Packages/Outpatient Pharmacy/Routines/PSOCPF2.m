PSOCPF2 ;BIR/BAA - Pharmacy CO-PAY Application Utilities for IB ;02/06/92
 ;;7.0;OUTPATIENT PHARMACY;**463,618,636**;DEC 1997;Build 14
 ;
 Q
 ;^TMP($J,"PSOCPFX",VCNT)=NAME_U_DFN_U_MED_U_RIEN_U_BLN_U_PRIEN_U_RFL_U_RX_U_DEBTOR
 ;
PATACP ; ACTION - Account Profile (AP)
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 D CLEAR^VALM1
 I $D(VALMY),$D(^TMP($J,"PSOCPF")) D
 . S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .. N RCDEBTDA
 .. S RC=$G(^TMP($J,"PSOCPFX",IBXX))
 .. S RCDEBTDA=$P(RC,U,9)  ;Need DEBTOR for AP
 .. I 'RCDEBTDA D  Q
 ... W !!,"There is no Bill associated with this entry."
 ... D PAUSE^VALM1
 .. D EN^VALM("RCDP ACCOUNT PROFILE")
 D BLD^PSOCPF
 S VALMBCK="R"
 Q
 ;
BILPRO ; view BILL PROFILE
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,REC,RCBILLDA
 D EN^VALM2($G(XQORNOD(0)))
 ;PSO*7*636 
 D CLEAR^VALM1
 I $D(VALMY),$D(^TMP($J,"PSOCPF")) D
 . S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .. S REC=$G(^TMP($J,"PSOCPFX",IBXX))
 .. S RCBILLDA=$P(REC,U,6)
 .. I RCBILLDA="" D  Q
 ... W !!,"There is no Bill associated with this entry."
 ... D PAUSE^VALM1
 .. D EN^VALM("RCDP BILL PROFILE")
 D BLD^PSOCPF
 S VALMBCK="R"
 Q
 ;
TPJI ; view THIRD PARTY JOIN INQUIRY
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,DFN,GOPAT,REC
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY),$D(^TMP($J,"PSOCPF")) D
 . S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .. S REC=$G(^TMP($J,"PSOCPFX",IBXX))
 .. S DFN=$P(REC,U,2)
 .. D EN^VALM("IBJT ACTIVE LIST")
 D BLD^PSOCPF
 S VALMBCK="R"
 Q
 ;
BILINQ ; view PATIENT BILLING INQUIRY
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,DFN,GOPAT,IBIL,REC,IBFULL,IBIFN
 D EN^VALM2($G(XQORNOD(0)))
 ;PSO*7*636 
 D CLEAR^VALM1
 I $D(VALMY),$D(^TMP($J,"PSOCPF")) D
 . S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .. S REC=$G(^TMP($J,"PSOCPFX",IBXX))
 .. S IBIL=$P(REC,U,5),IBFULL=1,IBIFN=""
 .. I IBIL="" D  Q
 ... W !!,"There is no Bill associated with this entry."
 ... D PAUSE^VALM1
 .. D EN^IBOLK
 D BLD^PSOCPF
 S VALMBCK="R"
 Q
 ;
PATINQ ; view PATIENT INQUIRY
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,DFN,GOPAT,REC
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY),$D(^TMP($J,"PSOCPF")) D
 . S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .. S REC=$G(^TMP($J,"PSOCPFX",IBXX))
 .. S DFN=$P(REC,U,2)
 .. D EN^DGRPD
 D BLD^PSOCPF
 S VALMBCK="R"
 Q
 ;
NP ; -- change patient,date and prescriptions.
 N VALMQUIT,IBDFN,PAT,DFN,SDATE,TDATE,IBDATES,SAVFIL
 ;PSO*7*618 MOVE NEW HERE FROM ASKRX
 N DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,PSOIENS,PSOIENS2,IEN,N,X,XX,Y
 D FULL^VALM1
 I $D(^TMP($J,"PSOCPFF",0)) S FILTERS(0)=^TMP($J,"PSOCPFF",0),SAVFIL(0)=FILTERS(0)
 S R=""
 F  S R=$O(^TMP($J,"PSOCPFF",1,R)) Q:R=""  S SAVFIL(1,R)=^TMP($J,"PSOCPFF",1,R)
 ;
 ;K ^TMP($J,"PSOCPFF") ;pso*7*618 fix/rewrite
 S IBDFN=$P(FILTERS(0),U,4)
 S PAT=$$ONEPAT^PSOCPF()
 I PAT=-1 D RESET S VALMBCK="R" G NPQ
 S (DFN,$P(FILTERS(0),U,4))=+PAT
 S SDATE=$P(FILTERS(0),U,1)
 S TDATE=$P(FILTERS(0),U,2)
 ;PSO*7*618 FIX/REWRITE CALL FMDATES IN THIS ROUTINE
 S IBDATES="Fill Dates",IBDATES=$$FMDATES(IBDATES,SDATE,TDATE)
 ;PSO *7*618 FIX/REWRITE Return to LM screen
 I IBDATES=-1 D RESET S VALMBCK="R" G NPQ
 I $D(VALMQUIT) D RESET S VALMBCK="R" G NPQ
 ;PSO*7*618 CALL ADDRX IN THIS ROUTINE
 D ADDRX^PSOCPF2
 ;PSO *7*618 FIX/REWRITE Return to LM screen
 I Y="^"!(Y<0) D RESET S VALMBCK="R" G NPQ
 S $P(FILTERS(0),U,1)=$P(IBDATES,U,1),$P(FILTERS(0),U,2)=$P(IBDATES,U,2)
 S ^TMP($J,"PSOCPF")=FILTERS(0)
 S R=""
 F  S R=$O(FILTERS(1,R)) Q:R=""  S ^TMP($J,"PSOCPFF",1,R)=FILTERS(1,R)
 W !,"Please be patient while I gather the requested data.",!
 S VALMBG=1 D SORT^PSOCPF1,HDR^PSOCPF,BLD^PSOCPF
 S VALMBCK="R"
NPQ Q
 ;
RESET ; Reset filters to current patient
 S (DFN,$P(FILTERS(0),U,4))=IBDFN
 S FILTERS(0)=$G(SAVFIL(0)) ;pso*7*618 ADD $g
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S RXS=$P(FILTERS(0),U,3),PAT=$P(FILTERS(0),U,4)
 S ^TMP($J,"PSOCPFF",0)=FILTERS(0)
 S R=""
 F  S R=$O(SAVFIL(1,R)) Q:R=""  S (FILTERS(1,R),^TMP($J,"PSOCPFF",1,R))=SAVFIL(1,R)
 Q
 ;PSO*7*618 FIX/REWRITE - COPIED FROM PSOCPF
FMDATES(PROMPT,SDT,EDT) ; ask for date range
 N %DT,X,Y,DT1,DT2,IB0,IB1,IB2
 S DT1="",IB1="Start with date entered: ",IB2="Go to date entered: "
 I $G(PROMPT)'="" S IB1="Start with "_PROMPT_": ",IB2="Go to "_PROMPT_": "
 I $D(SDT) K %DT S Y=SDT D DD^%DT S %DT("B")=Y
 ;
 S %DT="AEX",%DT("A")=IB1 D ^%DT K %DT
 ;PSO 618 PASS -1 BACK
 I Y<0!($P(Y,".",1)'?7N) Q -1
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>DT,'$D(EDT) S %DT("B")="Today"
 ; 
 I $D(EDT) K %DT S Y=EDT D DD^%DT S %DT("B")=Y
 ;
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT
 ;PSO 618 PASS -1 BACK
 I Y<0!($P(Y,".",1)'?7N) Q -1
 S DT1=DT2_U_$P(Y,".",1)
FMDQ Q DT1
 ;
 ;PSO*7*618 FIX/REWRITE COPIED FROM PSOCPF
ADDRX ; 
 ; Prescription filter
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Prescription(s)",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to not filter by Prescriptions."
 S DIR("?")="Enter 'S' to view entries for selected Prescription(s)."
 S $P(DIR(0),U,2)="A:All Prescriptions;S:Selected Prescriptions"
 W ! D ^DIR K DIR
 ;PSO 618 add DIRUT exit
 I $G(DIRUT)!(Y=-1) Q
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U,3)=$S(Y="A":0,1:1)
 ;
 I $P(FILTERS(0),U,3)=1 D ASKRX(.FILTERS)
 ;
 Q
ASKRX(FILTERS)   ; Sets a list of PrescriptionS to be displayed
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 ;PSO*7*618 MOVE TO NP
 ;N DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,PSOIENS,PSOIENS2,IEN,N,X,XX,Y
 S DIC=52,DIC(0)="AEQMN",FIRST=1
 K FILTERS(1)
 F  D  Q:+IEN<1
 . D ONERX(.DIC,.IEN,.FIRST)                   ; One Prescription prompt
 . Q:+IEN<1
 . S PSOIENS($P(IEN,U,2))=$P(IEN,U,1)
 . S PSOIENS2($P(IEN,U,1))=$P(IEN,U,2)
 I '$D(PSOIENS) S $P(FILTERS(0),U,3)=0 Q
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(PSOIENS(XX))
 . Q:XX=""
 . S N=PSOIENS(XX)
 . S FILTERS(1,N)=XX
 Q
ONERX(DIC,IEN,FIRST)  ; Prompts the user for a Medication
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Division
 ;                    null of no selection was made
 S DIC("A")=$S(FIRST:"Select a Prescription: ",1:"Select Another Prescription: ")
 D ^DIC
 S FIRST=0,IEN=Y
 I Y=-1 D RESET S VALMBCK="R" Q
 Q
