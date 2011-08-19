PRCAHV ;LL/ELZ-API for My HealtheVet ;06/17/02
 ;;4.5;Accounts Receivable;**183,209**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Based on ALSIBAL, LL/ELZ, Version 3.0, 10/30/01 (Ed Zeigler)
 ;
 ;
 ;Balance calculation (External entry point)
 ;Input:
 ;  PRCAICN - Patient's ICN (required)
 ;  PRCATY - Account Receivable Transaction Types, possible values (case insensitive):
 ;    "OPEN" (default) the same as "113,112,102,107" - open/active Trans. Types
 ;    "ALL", all Transaction Types
 ;    <list of Trans.Type numbers, comma delimited>
 ;Output:
 ;  1-success, 0-no data, '-1'-error, '-2'-patient doesn't exist, '-3'-program error
 ;  RESULT (by reference)=<balance value> or zero if error/no data
BALANCE(RESULT,PRCAICN,PRCATY) N DFN,RCST
 S RESULT=0 ;Initial value
 I $G(PRCAICN)="" S RCST=-1 G BALQ ;Bad parameter
 S DFN=$$DFN($G(PRCAICN)) I 'DFN S RCST=-2 G BALQ ;No such patient
 S RCST=$$INTBAL(.RESULT,DFN,.PRCATY)
BALQ Q RCST
 ;
 ;
 ;This function will look up a patient's detail to their copay balance
 ;Input:
 ;  PRCAICN - Patient's ICN
 ;  PRCATY - Account Receivable Transaction Types, possible values (case insensitive):
 ;    "OPEN" (default) the same as "113,112,102,107" - open/active Trans. Types
 ;    "ALL", all Transaction Types,
 ;    <list of Trans.Type numbers, comma delimited>
 ;Output: 1-success, 0-no data, '-1'-error, '-2'-patient doesn't exist, '-3'-program error
 ;        RESULT(1..n)=<Bill No>^<Date Bill Prepared(FM)>^<Description>^<Balance>^<Status Number>
 ;        RESULT may be undefined if error or no data
DETAIL(RESULT,PRCAICN,PRCATY) N DFN,RCST
 K RESULT ;Initial value
 I $G(PRCAICN)="" S RCST=-1 G DETQ ;Bad parameter
 S DFN=$$DFN($G(PRCAICN)) I 'DFN S RCST=-2 G DETQ ;No such patient
 S RCST=$$INTDTL(.RESULT,DFN,.PRCATY)
DETQ Q RCST
 ;
 ;
 ;This function will look up for transaction details for the given bill
 ;Input:
 ;  PRCABILL - Bill name (External number)
 ;Output:
 ; 1-success, 0-no data, '-1'-no parameter, '-2'-the bill doesn't exist, '-3'-program error
 ; RESULT(i)=<Trans.No>^<Date(FM)>^<Trans.Type>^<reserved>^<Trans. amount>^<Descr1>^<Descr2>^<Descr3>^<Descr4>^<Descr5>
 ; RESULT may be undefined if error or no data
 ; RESULT(1..n) may not be longer that 255 char - the Description may be truncated.
TRANS(RESULT,PRCABILL) N PRCAIEN,RCST
 K RESULT ;Initial value
 I $G(PRCABILL)="" S RCST=-1 G TRANSQ ;Bad parameter
 S PRCAIEN=$$BILIEN($G(PRCABILL)) I 'PRCAIEN S RCST=-2 G TRANSQ ;No such bill
 S RCST=$$INTTRANS(.RESULT,PRCAIEN)
TRANSQ Q RCST
 ;
 ;Conversions
 ;~~~~~~~~~~~
 ;Input: Paient's ICN
 ;Output: Patient's IEN (or 0 in not found)
DFN(PRCAICN) ;Receive patient's IEN by ICN
 N DFN
 I $G(PRCAICN)="" Q 0  ;No parameter
 S DFN=$O(^DPT("AICN",PRCAICN,0)) I 'DFN Q 0  ;Not found in x-ref
 I '$D(^DPT(DFN)) Q 0  ;Invalid cross-reference
 Q DFN
 ;
 ;Input: bill name ('external' number)
 ;Output: bill IEN (internal record number) or 0 if not found
BILIEN(PRCABN) ;Receive bill's IEN by name
 N PRCAIEN
 I $G(PRCABN)="" Q 0  ;No parameter
 S PRCAIEN=$O(^PRCA(430,"B",PRCABN,0)) I 'PRCAIEN Q 0  ;Not found in x-ref
 I '$D(^PRCA(430,PRCAIEN)) Q 0  ;Invalid cross-reference 
 Q PRCAIEN
 ;
 ;
 ;Internal functions
 ;~~~~~~~~~~~~~~~~~~
 ; These functions accept internal codes (IEN),
 ; return success code, 
 ; return requested data in parameter by reference (no data murging)
 ;
 ;
 ;Balance calculation (internal entry point)
 ;Input: DFN - Patient's IEN
 ;  PRCATY - Account Receivable Transaction Types, possible values:
 ;    "OPEN" (default) the same as "113,112,102,107" - open/active Trans. Types 
 ;    "ALL", all Transaction Types
 ;    <list of Trans.Type numbers, comma delimited>
 ;Output: 1-success, 0-no data, '-1'-error '-2'-patient doesn't exist
 ;        RESULT=<balance value> or zero if error/no data
INTBAL(RESULT,DFN,PRCATY) ; this will look up a patient's copay balance
 N X,Y,C,PRCADB,DEBT,TRAN,BILL,BAT
 S RESULT=0
 S X="ERROR^PRCAHV",@^%ZOSF("TRAP")
 S:'$D(U) U="^"
 ;
 I '$G(DFN) Q -1 ;No/bad parameter
 I '$D(^DPT(DFN)) Q -2 ;The patient does not exist
 S PRCADB=DFN_";DPT(",DEBT=$O(^RCD(340,"B",PRCADB,0)) I 'DEBT Q 0 ;No such debtor
 D ADJTYPE(.PRCATY) ; Adjust type (or set default)
 ;Standard call. Parameters: PRCATY - types list, DEBT - debtor
 K ^TMP("PRCAAPR",$J)
 D COMP^PRCAAPR S RESULT=+$G(^TMP("PRCAAPR",$J,"C"))
 K ^TMP("PRCAAPR",$J)
 Q 1
 ;
 ;Function: Details of patient's balance
 ;Input: DFN - Patient's IEN
 ;  PRCATY - Account Receivable Transaction Types, possible values:
 ;    "OPEN" (default) the same as "113,112,102,107" - open/active Trans. Types 
 ;    "ALL", all Transaction Types
 ;    <list of Trans.Type numbers, comma delimited>
 ;Output: 1-success, 0-no data, '-1'-error '-2'-patient doesn't exist
 ;        RESULT(1..n)=<Bill No>^<Date Bill Prepared(FM)>^<Description>^<Balance>^<Status Number>
 ;        RESULT may be undefined if error or no data
INTDTL(RESULT,DFN,PRCATY) ;
 N X,Y,C,PRCADB,DEBT,TRAN,BILL,BAT,RCS,RCX,RCC,RCZ,RCY,RCB,RCDT,RCP
 K RESULT
 S X="ERROR^PRCAHV",@^%ZOSF("TRAP")
 S:'$D(U) U="^"
 ;
 I '$G(DFN) Q -1  ;No/bad parameter
 I '$D(^DPT(DFN)) Q -2  ;No such patient
 S PRCADB=DFN_";DPT(",DEBT=$O(^RCD(340,"B",PRCADB,0)) I 'DEBT Q 0  ;No information for the patient
 ;
 D ADJTYPE(.PRCATY) ; Adjust type (or set default)
 ;Standard call. Parameters: PRCATY - types list, DEBT - debtor
 K ^TMP("PRCAAPR",$J),^TMP("PRCAHV",$J)
 D COMP^PRCAAPR
 ;
 ; Sort the bills by date, ignore 3rd party bills
 S (RCC,RCS)=0 F  S RCS=$O(^TMP("PRCAAPR",$J,"C",RCS)) Q:RCS<1  D
 . S RCX=0 F  S RCX=$O(^TMP("PRCAAPR",$J,"C",RCS,RCX))  Q:RCX<1  D
 .. ; No support for unprocessed payments
 .. I RCS=99 Q  ;S RCC=RCC+1,RESULT(RCC)="^^UNPROCESSED PAYMENT^"_$G(^TMP("PRCAAPR",$J,"C",RCS,RCX)) Q
 .. S RCY=$G(^PRCA(430,RCX,0))  Q:RCY=""
 .. S PRCADB=$P(RCY,"^",9) ; bill debtor
 .. I $P($G(^RCD(340,PRCADB,0)),U)'[";DPT(" Q  ;not a 1st party bill
 .. S RCDT=+$P(RCY,"^",10)
 .. S ^TMP("PRCAHV",$J,RCDT,RCS,RCX)=$G(^TMP("PRCAAPR",$J,"C",RCS,RCX))
 K ^TMP("PRCAAPR",$J)
 ;
 S (RCC,RCDT)=0 F  S RCDT=$O(^TMP("PRCAHV",$J,RCDT)) Q:'RCDT  D
 . S RCS=0 F  S RCS=$O(^TMP("PRCAHV",$J,RCDT,RCS))  Q:'RCS  D
 .. S RCX=0 F  S RCX=$O(^TMP("PRCAHV",$J,RCDT,RCS,RCX))  Q:'RCX  D
 ... N RCDESC
 ... D BILLDESC^RCCPCPS1(RCX)
 ... S RCB=0,RCZ=$G(^TMP("PRCAHV",$J,RCDT,RCS,RCX))
 ... F RCP=1:1:5 S RCB=RCB+$P(RCZ,U,RCP)
 ... S RCY=^PRCA(430,RCX,0)
 ... S RCC=RCC+1,RESULT(RCC)=$P(RCY,U)_U_$P(RCY,U,10)_U_RCDESC(1)_U_RCB_U_RCS
 ;
 K ^TMP("PRCAHV",$J)
 Q 1 ;Success, data not guaranteed
 ;
 ;Function: Transaction details
 ;Input: RCBILL - Bill IEN
 ;Output: 1-success, 0-no data, '-1'-no parameter '-2'-the bill doesn't exist, '-3'-program error
 ; RESULT(i)=<Trans.No>^<Date(FM)>^<Trans.Type>^<reserved>^<Trans. amount>^<Descr1>^<Descr2>^<Descr3>^<Descr4>^<Descr5>
 ; RESULT may be undefined if error or no data
INTTRANS(RESULT,RCBILL) ; returns transaction details for the given bill IEN
 N RCTRAN,RCNUM,X,Y,C
 K RESULT
 S X="ERROR^PRCAHV",@^%ZOSF("TRAP")
 S:'$D(U) U="^"
 I $G(RCBILL)="" Q -1 ;Bad parameter
 I '$D(^PRCA(430,RCBILL,0)) Q -2 ;The bill doesn't exist
 I '$D(^PRCA(433,"C",RCBILL)) Q 0 ;No data
 S (RCNUM,RCTRAN)=0 F  S RCTRAN=$O(^PRCA(433,"C",RCBILL,RCTRAN))  Q:'RCTRAN  D
 . Q:'$D(^PRCA(433,RCTRAN,0))  ;Corrupted cross-reference
 . N RCDESC,RCTOTAL,RCY,RCI,RCTXT,RCD,RCTTY,RCAMT
 . D TRANDESC^RCCPCPS1(RCTRAN)
 . S RCY=$G(^PRCA(433,RCTRAN,1))
 . S RCTTY=$P(RCY,U,2) ; Transaction Type
 . S RCAMT=$P(RCY,U,5) ; Transaction Amount
 . I ",2,8,9,10,11,14,19,47,34,35,29,"[(","_RCTTY_",") I RCAMT'<0 S RCAMT=-RCAMT
 . I ",2,8,9,10,11,12,14,19,47,34,35,29,"'[(","_RCTTY_",") I RCAMT<0 S RCAMT=-RCAMT
 . ;S RCTXT=RCTRAN_U_$P(RCY,U)_U_$G(RCTOTAL("INT"))_U_$G(RCTOTAL("ADM"))_U_$P(RCY,U,5)
 . S RCTXT=RCTRAN_U_$P(RCY,U)_U_RCTTY_U_U_RCAMT
 . S RCI=0 F  S RCI=$O(RCDESC(RCI)) Q:'RCI  S RCD=$$TRIM(RCDESC(RCI)) Q:($L(RCD)+$L(RCTXT))>254  S RCTXT=RCTXT_U_RCD
 . S RCNUM=RCNUM+1
 . S RESULT(RCNUM)=RCTXT
 ;
 Q 1 ;Success, data not guaranteed
 ;
TRIM(RCTXT) ;Remove starting and ending spaces
 N RCI,RES
 S RES=RCTXT
 F RCI=1:1:$L(RES) Q:$E(RES,RCI)'=" "
 I RCI>1 S $E(RES,1,RCI-1)=""
 F RCI=$L(RES):-1:1 Q:$E(RES,RCI)'=" "
 I RCI<$L(RES) S $E(RES,RCI+1,$L(RES))=""
 Q RES
 ;
 ;Adjust Account Receivable Transaction Type:
 ;1) Convert to upper case
 ;2) Undefined will became "OPEN"
 ;3) OPEN will became "113,112,102,107"
ADJTYPE(RCTYPE) ;
 S RCTYPE=$TR($G(RCTYPE,"OPEN"),"openal ","OPENAL") ; Convert tp upper case
 I RCTYPE="OPEN" S RCTYPE="113,112,102,107"
 Q
 ;
 ;Program error trap
ERROR Q -3
 ;
 ;Temporary entry points - test only! Will be removed after testing
TEST N C,R,P,A,O
 S (P,C)=0 F  S P=$O(^DPT("AICN",P)) Q:'P  S R=$$DETAIL(.O,P,"ALL") I R>0 I $D(O) W !,P,?20,R,! D TESTZW(.O) S C=C+1 Q:C>500
 Q
 ;
TEST2 N C,R,P,A
 S (P,C)=0 F  S P=$O(^PRCA(430,"B",P)) Q:'P  S R=$$TRANS(.A,P) I R W !,P,?20,R,! I $D(A) D TESTZW(.A) S C=C+1 Q:C>500
 Q
TESTZW(PRA) N RCI
 S RCI="" F  S RCI=$O(PRA(RCI)) Q:'RCI  W !,RCI,?10,PRA(RCI)
 Q
