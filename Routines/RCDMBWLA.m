RCDMBWLA ;WISC/RFJ-diagnostic measures workload report (build it) (Cont.) ;1 Jan 01
 ;;4.5;Accounts Receivable;**167,171**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
RECTYP ;  screen on receivable type
 I ($P(RCDATA2,"^",8)'="")&($P(RCDATA2,"^",8)'=5) D
 . S RCIFSTAT=RCIFSTAT_"I RCRECTYP="_$P(RCDATA2,"^",8)_" "
 . S RCIFDESC=RCIFDESC_"[RECEIVABLE TYPE equals "_$S($P(RCDATA2,"^",8)=1:"INPATIENT",$P(RCDATA2,"^",8)=2:"OUTPATIENT",$P(RCDATA2,"^",8)=3:"PROSTHETICS",$P(RCDATA2,"^",8)=4:"PHARMACY REFILL",$P(RCDATA2,"^",8)=5:"ALL RECEIVABLES")_"]"
 Q
 ;
 ;
BUILDIF ;  build if statement by clerk
 S ^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF")=RCIFSTAT
 S ^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"DESC")=RCIFDESC
 Q
 ;
 ;
PAYDAYS(RCBILLDA) ;  return number of days since last payment
 N DATA1,DAYS,RCDATE,RCTRANDA
 ;  loop all transactions in reverse order until you find last payment
 S RCDATE=0
 S RCTRANDA=99999999999 F  S RCTRANDA=$O(^PRCA(433,"C",RCBILLDA,RCTRANDA),-1) Q:'RCTRANDA  D  I RCDATE Q
 .   S DATA1=$G(^PRCA(433,RCTRANDA,1))
 .   ;  not a payment transaction
 .   I $P(DATA1,"^",2)'=2,$P(DATA1,"^",2)'=34 Q
 .   ;  get the transaction date
 .   S RCDATE=+$P($P(DATA1,"^",9),".")
 ;
 ;  if payment not found, use date bill activated
 ;  if there is a problem with AR and the bill does not have an
 ;  activation date, use default 1/1/1990
 I 'RCDATE S RCDATE=+$P($P($G(^PRCA(430,RCBILLDA,6)),"^",21),".") I 'RCDATE S RCDATE=2900101
 ;
 ;  calculate the number of days from today
 S DAYS=$$FMDIFF^XLFDT(DT,RCDATE)
 Q DAYS
 ;
 ;
TRANDAYS(RCBILLDA) ;  return number of days since last transaction
 N DAYS,RCDATE,RCTRANDA
 ;  get the last transaction date
 S RCTRANDA=+$O(^PRCA(433,"C",RCBILLDA,999999999999),-1)
 ;  get the transaction date
 S RCDATE=+$P($P($G(^PRCA(433,RCTRANDA,1)),"^",9),".")
 ;
 ;  if transaction not found, use date bill activated
 ;  if there is a problem with AR and the bill does not have an
 ;  activation date, use default 1/1/1990
 I 'RCDATE S RCDATE=+$P($P($G(^PRCA(430,RCBILLDA,6)),"^",21),".") I 'RCDATE S RCDATE=2900101
 ;
 ;  calculate the number of days from today
 S DAYS=$$FMDIFF^XLFDT(DT,RCDATE)
 Q DAYS
 ;
PTNAM(RCBILLDA) ;  return patient name if third party 
 S (RCPTNAM,RCSSN)=""
 N IBFOTP,IBBCAT,IBZ
 S IBBCAT=$P(RCDATA0,"^",2) Q:'IBBCAT "^"
 S IBFOTP=$$CATTYP^IBJD1(IBBCAT)
 I IBFOTP="T" D
 . I '$D(^DGCR(399,RCBILLDA,0)) Q
 . S IBZ=^DGCR(399,RCBILLDA,0),DFN=+$P(IBZ,"^",2)
 . D DEM^VADPT S RCPTNAM=VADM(1),RCSSN=+VADM(2)
 Q (RCPTNAM_"^"_RCSSN)
 ;
LOOP ;  loop all active bills and put them into the assignment list
 N RCPTNAM,RCSSN,RCX,RCRECTYP,RCY,RCCLDAT0
 S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"AC",16,RCBILLDA)) Q:'RCBILLDA  D
 .   ;  get the data from the bill file
 .   S RCDATA0=$G(^PRCA(430,RCBILLDA,0)) I RCDATA0="" Q
 .   S RCDATA6=$G(^PRCA(430,RCBILLDA,6)) S RCRC=$P(RCDATA6,"^",4)
 .   S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 .   S RCBALANC=$P(RCDATA7,"^")+$P(RCDATA7,"^",2)+$P(RCDATA7,"^",3)+$P(RCDATA7,"^",4)+$P(RCDATA7,"^",5)
 .   ;  get the data for the debtor
 .   K RCDPDATA
 .   D DIQ340^RCDPAPLM(+$P(RCDATA0,"^",9),.01)
 .   S RCNAME=$G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"E")) I RCNAME="" S RCNAME=" "
 .   S RCDEBT=$G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"I"))
 .   ;  get the patient name and SSN if third party bill
 .   S RCY=$$PTNAM^RCDMBWLA(RCBILLDA)
 .   S RCPTNAM=$P(RCY,"^"),RCSSN=$P(RCY,"^",2)
 .   ;  get the ssn-first party
 .   I $G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"I"))["DPT" S RCSSN=$P($G(^DPT(+$G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"I")),0)),"^",9)
 .   S RCSSN=$E($E(RCSSN,6,9)_"    ",1,4)
 .   ;  test for date of death
 .   S RCFDEATH=0
 .   I $G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"I"))["DPT(",$G(^DPT(+$G(RCDPDATA(340,+$P(RCDATA0,"^",9),.01,"I")),.35)) S RCFDEATH=1
 .   ;  get the receivable type
 .   S RCCLDAT0=$G(^DGCR(399,RCBILLDA,0))
 .   S RCX=$$BTYP^IBCOIVM1(RCBILLDA,RCCLDAT0)
 .   S RCRECTYP=$S(RCX="I":1,RCX="O":2,RCX="P":3,RCX="R":4,1:"")
 .   ;
 .   ;  loop assignments and see if they should appear on the clerks list
 .   S RCCLERK=0 F  S RCCLERK=$O(^TMP("RCDMBWLR",$J,RCCLERK)) Q:'RCCLERK  D
 .   .   S RCASSIGN=0 F  S RCASSIGN=$O(^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN)) Q:'RCASSIGN  D
 .   .   .   S RCIFSTAT=^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF")
 .   .   .   X RCIFSTAT
 .   .   .   I $T D
 .   .   .   .   I $D(^TMP($J,RCCLERK,RCBILLDA)) Q
 .   .   .   .   S RCDEBTDA=+$P(RCDATA0,"^",9)
 .   .   .   .   S ^TMP("RCDMBWLR",$J,RCCLERK,RCASSIGN,"IF",$E(RCNAME,1,30),RCDEBTDA,RCBILLDA)=RCSSN_"^"_RCFDEATH_"^"_RCBALANC_"^"_RCPTNAM
 .   .   .   .   S ^TMP($J,RCCLERK,RCBILLDA)=""
 Q
 ;
