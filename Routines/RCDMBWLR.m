RCDMBWLR ;WISC/RFJ-diagnostic measures workload report (build it) ;1 Jan 01
 ;;4.5;Accounts Receivable;**167**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  called by nightly background job
 ;
 N RCASSIGN,RCBALANC,RCBILLDA,RCCLERK,RCDATA0,RCDATA1,RCDATA2,RCDATA7,RCDATA6
 N RCDEBT,RCDEBTDA,RCDPDATA,RCFDEATH,RCIFDESC,RCIFSTAT,RCNAME,RCSSN,RCRC
 K ^TMP("RCDMBWLR",$J)
 ;
 ;  loop all workload assignments and generate logic to screen bills
 S RCWLFLG=0
 S RCCLERK=0 F  S RCCLERK=$O(^IBE(351.73,RCCLERK)) Q:'RCCLERK  D
 .   S RCASSIGN=0 F  S RCASSIGN=$O(^IBE(351.73,RCCLERK,1,RCASSIGN)) Q:'RCASSIGN  D  I RCIFSTAT'="" D BUILDIF^RCDMBWLA S RCWLFLG=1
 .   .   ;
 .   .   S RCIFSTAT=""
 .   .   S RCIFDESC=""
 .   .   ;
 .   .   ;
 .   .   ;  screen on all bills by category or minimum balance
 .   .   S RCDATA0=$G(^IBE(351.73,RCCLERK,1,RCASSIGN,0))
 .   .   I $P(RCDATA0,"^",2)!($P(RCDATA0,"^",3)) D
 .   .   .   ;  screen on category
 .   .   .   I $P(RCDATA0,"^",2) D
 .   .   .   .   S RCIFSTAT="I $P(RCDATA0,U,2)="_$P(RCDATA0,"^",2)_" "
 .   .   .   .   S RCIFDESC="[CATEGORY equals "_$P($G(^PRCA(430.2,+$P(RCDATA0,"^",2),0)),"^")_"]"
 .   .   .   ;  screen on minimum bill balance
 .   .   .   I $P(RCDATA0,"^",3) D
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCBALANC>"_($P(RCDATA0,"^",3)-.01)_" "
 .   .   .   .   I RCIFDESC'="" S RCIFDESC=RCIFDESC_" AND "
 .   .   .   .   S RCIFDESC=RCIFDESC_"[MINIMUM BILL BALANCE greater than "_$J($P(RCDATA0,"^",3)-.01,0,2)_"]"
 .   .   .   I $P(RCDATA0,"^",5) D
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I 'RCRC "
 .   .   .   .   S RCIFDESC=RCIFDESC_"[EXCLUDE REGIONAL COUNSEL RECEIVABLES]"
 .   .   ;
 .   .   ;
 .   .   ;  screen on bill by first party
 .   .   S RCDATA1=$G(^IBE(351.73,RCCLERK,1,RCASSIGN,1))
 .   .   I $TR(RCDATA1,"^")'="" D  Q
 .   .   .   ;
 .   .   .   ;  screen on first party
 .   .   .   S RCIFSTAT=RCIFSTAT_"I RCDEBT[""DPT("" "
 .   .   .   ;
 .   .   .   ;  screen on days since last payment
 .   .   .   I $P(RCDATA1,"^") D
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I $$PAYDAYS^RCDMBWLA(RCBILLDA)>"_$P(RCDATA1,"^")_" "
 .   .   .   .   S RCIFDESC=RCIFDESC_"[DAYS SINCE LAST PAYMENT greater than "_$P(RCDATA1,"^")_"]"
 .   .   .   ;
 .   .   .   ;  screen on first patient name last patient name
 .   .   .   I $P(RCDATA1,"^",2)'=""!($P(RCDATA1,"^",3)'="") D  Q
 .   .   .   .   ;  if first patient name is null, set to @ char (before A)
 .   .   .   .   I $P(RCDATA1,"^",2)="" S $P(RCDATA1,"^",2)=$C(64)
 .   .   .   .   ;  if last patient name is null, set to / char (after Z)
 .   .   .   .   I $P(RCDATA1,"^",3)="" S $P(RCDATA1,"^",3)=$C(92)
 .   .   .   .   ;
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCNAME]"_$C(34)_$P(RCDATA1,"^",2)_$C(34)_",RCNAME']"_$C(34)_$P(RCDATA1,"^",3)_$C(34)_" "
 .   .   .   .   ;
 .   .   .   .   ;  if first patient name is null, set variable for description
 .   .   .   .   I $P(RCDATA1,"^",2)=$C(64) S $P(RCDATA1,"^",2)="<first>"
 .   .   .   .   ;  if last patient name is null, set variable for desctription
 .   .   .   .   I $P(RCDATA1,"^",3)=$C(92) S $P(RCDATA1,"^",3)="<last>"
 .   .   .   .   S RCIFDESC=RCIFDESC_"[PATIENT NAME is after "_$P(RCDATA1,"^",2)_" and before "_$P(RCDATA1,"^",3)_"]"
 .   .   .   ;
 .   .   .   ;  screen on social security number
 .   .   .   I $P(RCDATA1,"^",4)'=""!($P(RCDATA1,"^",5)'="") D  Q
 .   .   .   .   ;  if first ssn is null, set starting point
 .   .   .   .   I $P(RCDATA1,"^",4)="" S $P(RCDATA1,"^",4)="0000"
 .   .   .   .   ;  if last ssn is null, set ending point
 .   .   .   .   I $P(RCDATA1,"^",5)="" S $P(RCDATA1,"^",5)="9999"
 .   .   .   .   ;
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCSSN]"_$C(34)_$P(RCDATA1,"^",4)_$C(34)_",RCSSN']"_$C(34)_$P(RCDATA1,"^",5)_$C(34)
 .   .   .   .   ;
 .   .   .   .   ;  if first ssn is null, set variable for description
 .   .   .   .   I $P(RCDATA1,"^",4)="0000" S $P(RCDATA1,"^",4)="<first>"
 .   .   .   .   ;  if last ssn is null, set variable for desctription
 .   .   .   .   I $P(RCDATA1,"^",5)="9999" S $P(RCDATA1,"^",5)="<last>"
 .   .   .   .   S RCIFDESC=RCIFDESC_"[PATIENT SSN is after "_$P(RCDATA1,"^",4)_" and before "_$P(RCDATA1,"^",5)_"]"
 .   .   ;
 .   .   ;
 .   .   ;  screen on bills by third party
 .   .   S RCDATA2=$G(^IBE(351.73,RCCLERK,1,RCASSIGN,2))
 .   .   I $TR(RCDATA2,"^")'="" D  Q
 .   .   .   ;  screen on third party
 .   .   .   S RCIFSTAT=RCIFSTAT_"I RCDEBT[""DIC(36"" "
 .   .   .   ;  screen on days since transaction days
 .   .   .   I $P(RCDATA2,"^") D
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I $$TRANDAYS^RCDMBWLA(RCBILLDA)>"_$P(RCDATA2,"^")_" "
 .   .   .   .   S RCIFDESC=RCIFDESC_"[DAYS SINCE LAST TRANSACTION greater than "_$P(RCDATA2,"^")_"]"
 .   .   .   ;  screen on receivable type
 .   .   .   D RECTYP^RCDMBWLA
 .   .   .   ;  screen on first insurance name and last insurance name
 .   .   .   I $P(RCDATA2,"^",2)'=""!($P(RCDATA2,"^",3)'="") D
 .   .   .   .   ;  if first insurance name is null, set to @ char (before A)
 .   .   .   .   I $P(RCDATA2,"^",2)="" S $P(RCDATA2,"^",2)=$C(64)
 .   .   .   .   ;  if last insurance name is null, set to \ char (after Z)
 .   .   .   .   I $P(RCDATA2,"^",3)="" S $P(RCDATA2,"^",3)=$C(92)
 .   .   .   .   ;
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCNAME]"_$C(34)_$P(RCDATA2,"^",2)_$C(34)_",RCNAME']"_$C(34)_$P(RCDATA2,"^",3)_$C(34)_" "
 .   .   .   .   ;
 .   .   .   .   ;  if first insurance company name is null, set variable for description
 .   .   .   .   I $P(RCDATA2,"^",2)=$C(64) S $P(RCDATA2,"^",2)="<first>"
 .   .   .   .   ;  if last insurance company name is null, set variable for desctription
 .   .   .   .   I $P(RCDATA2,"^",3)=$C(92) S $P(RCDATA2,"^",3)="<last>"
 .   .   .   .   S RCIFDESC=RCIFDESC_"[INSURANCE COMPANY NAME is after "_$P(RCDATA2,"^",2)_" and before "_$P(RCDATA2,"^",3)_"]"
 .   .   .   ;
 .   .   .   ;  screen on first patient name last patient name
 .   .   .   I $P(RCDATA2,"^",4)'=""!($P(RCDATA2,"^",5)'="") D  Q
 .   .   .   .   ;  if first patient name is null, set to @ char (before A)
 .   .   .   .   I $P(RCDATA2,"^",4)="" S $P(RCDATA2,"^",4)=$C(64)
 .   .   .   .   ;  if last patient name is null, set to / char (after Z)
 .   .   .   .   I $P(RCDATA2,"^",5)="" S $P(RCDATA2,"^",5)=$C(92)
 .   .   .   .   ;
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCPTNAM]"_$C(34)_$P(RCDATA2,"^",4)_$C(34)_",RCPTNAM']"_$C(34)_$P(RCDATA2,"^",5)_$C(34)_" "
 .   .   .   .   ;
 .   .   .   .   ;  if first patient name is null, set variable for description
 .   .   .   .   I $P(RCDATA2,"^",4)=$C(64) S $P(RCDATA2,"^",4)="<first>"
 .   .   .   .   ;  if last patient name is null, set variable for description
 .   .   .   .   I $P(RCDATA2,"^",5)=$C(92) S $P(RCDATA2,"^",5)="<last>"
 .   .   .   .   S RCIFDESC=RCIFDESC_"[PATIENT NAME is after "_$P(RCDATA2,"^",4)_" and before "_$P(RCDATA2,"^",5)_"]"
 .   .   .   ;
 .   .   .   ;  screen on social security number
 .   .   .   I $P(RCDATA2,"^",6)'=""!($P(RCDATA2,"^",7)'="") D  Q
 .   .   .   .   ;  if first ssn is null, set starting point
 .   .   .   .   I $P(RCDATA2,"^",6)="" S $P(RCDATA2,"^",6)="0000"
 .   .   .   .   ;  if last ssn is null, set ending point
 .   .   .   .   I $P(RCDATA2,"^",7)="" S $P(RCDATA2,"^",7)="9999"
 .   .   .   .   ;
 .   .   .   .   S RCIFSTAT=RCIFSTAT_"I RCSSN]"_$C(34)_$P(RCDATA2,"^",6)_$C(34)_",RCSSN']"_$C(34)_$P(RCDATA2,"^",7)_$C(34)
 .   .   .   .   ;
 .   .   .   .   ;  if first ssn is null, set variable for description
 .   .   .   .   I $P(RCDATA2,"^",6)="0000" S $P(RCDATA2,"^",6)="<first>"
 .   .   .   .   ;  if last ssn is null, set variable for desctription
 .   .   .   .   I $P(RCDATA2,"^",7)="9999" S $P(RCDATA2,"^",7)="<last>"
 .   .   .   .   S RCIFDESC=RCIFDESC_"[PATIENT SSN is after "_$P(RCDATA2,"^",6)_" and before "_$P(RCDATA2,"^",7)_"]"
 .   .   .   ;
 .   .   ;
 .   .   ;  clerk has no assignment, quit
 .   .   Q
 ;
 ;
 I RCWLFLG D LOOP^RCDMBWLA
 ;
 I RCWLFLG D REPORT^RCDMBWL1
 ;
 K ^TMP("RCDMBWLR",$J),RCWLFLG
 Q
 ;
