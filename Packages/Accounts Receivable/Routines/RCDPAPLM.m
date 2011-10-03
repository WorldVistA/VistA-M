RCDPAPLM ;WISC/RFJ-account profile top list manager routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N RCDPFXIT
 ;
ACCTPROF ;  this entry point called by link payment to prevent newing
 ;  the fast exit variable RCDPFXIT
 N RCDEBTDA
 ;
 ;  check to see if user has any selected status's to display,
 ;  if not, set up the default status's
 I $G(^DISV(DUZ,"RCDPAPLM","STATUS"))="" D DEFAULT^RCDPAPST
 ;
 F  D  Q:'RCDEBTDA
 .   W !! S RCDEBTDA=$$SELACCT
 .   I RCDEBTDA<1 S RCDEBTDA=0 Q
 .   D EN^VALM("RCDP ACCOUNT PROFILE")
 .   ;  fast exit
 .   I $G(RCDPFXIT) S RCDEBTDA=0
 Q
 ;
 ;
INIT ;  initialization for list manager list
 D INIT^RCDPAPLI
 Q
 ;
 ;
DIQ340(DA,DR) ;  diq call to retrieve data for dr fields in file 340
 N D0,DIC,DIQ,DIQ2
 K RCDPDATA(340,DA)
 S DIQ(0)="IE",DIC="^RCD(340,",DIQ="RCDPDATA" D EN^DIQ1
 Q
 ;
 ;
HDR ;  header code for list manager display
 I '$G(RCDEBTDA) S VALMHDR(1)="ACCOUNT NOT selected.",VALMHDR(2)="",VALMHDR(3)="" Q
 ;
 N DATA,IBRX,RCSPACE
 S DATA=$$ACCNTHDR(RCDEBTDA)
 ;
 S RCSPACE="",$P(RCSPACE," ",81)=""
 S VALMHDR(1)=$E("Account: "_$P(DATA,"^")_$P(DATA,"^",2)_RCSPACE,1,62)_$P(DATA,"^",3)
 S VALMHDR(2)=$E("   Addr: "_$P(DATA,"^",4)_", "_$P(DATA,"^",7)_", "_$P(DATA,"^",8)_"  "_$P(DATA,"^",9)_RCSPACE,1,58)_"  Phone: "_$P(DATA,"^",10)
 ;
 S VALMHDR(3)=RCSPACE
 I $P($G(^RCD(340,+RCDEBTDA,0)),"^")["DPT(" D
 .   S IBRX=$$RXST^IBARXEU(+$P($G(^RCD(340,+RCDEBTDA,0)),"^"),DT)
 .   S VALMHDR(3)="   RX Copay Exempt: "_$S($P(IBRX,"^")=1:"YES",$P(IBRX,"^")=0:"NO",1:"N/A")_RCSPACE
 .   I $P(IBRX,U)=1 D
 .   .   N DIC,X,Y
 .   .   S DIC="^IBE(354.2,",DIC(0)="M",X=+$P(IBRX,"^",3)
 .   .   D ^DIC
 .   .   I Y>0 S VALMHDR(3)=$E(VALMHDR(3),1,25)_"("_$P(Y,"^",2)_")"_RCSPACE
 S VALMHDR(3)=$E(VALMHDR(3),1,80)
 ;
 S VALMHDR(4)=RCSPACE
 I $G(RCTOTAL(1))="" S VALMHDR(4)="   ACCOUNT BALANCE: Unknown"
 I $G(RCTOTAL(1))'="" D
 .   S VALMHDR(4)="   ACCOUNT BALANCE: "_$J($G(RCTOTAL(1))+$G(RCTOTAL(2))+$G(RCTOTAL(3))-$G(RCTOTAL("PP")),0,2)
 .   S VALMHDR(4)=VALMHDR(4)_"               Pending Payments: "_$J($G(RCTOTAL("PP")),0,2)
 I $O(^RCD(340,RCDEBTDA,2,0)) S VALMHDR(4)=$E($G(VALMHDR(4))_"                                                                             ",1,72)_"COMMENT"
 ;
 ;  highlight account balance
 S VALMHDR(4)=IORVON_$E(VALMHDR(4),1,30)_IORVOFF_$E(VALMHDR(4),31,80)
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPAPLM",$J),^TMP("RCDPAPLMX",$J)
 Q
 ;
 ;
SELACCT() ;  select an account (debtor)
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of account
 N %,%Y,A1,C,DIC,DIYS,DTOUT,DUOUT,RCRJFLAG,X,Y
 F  D  Q:$G(RCRJFLAG)
 .   R !!,"Select ACCOUNT or BILL NUMBER: ",X:DTIME
 .   I '$T S Y=-1,DTOUT=1,RCRJFLAG=1 Q
 .   I X["^" S Y=-1,DUOUT=1,RCRJFLAG=1 Q
 .   I X="" S Y=0,RCRJFLAG=1 Q
 .   ;
 .   ;  lookup bill
 .   S Y=$O(^PRCA(430,"B",X,0)) I 'Y S Y=$O(^PRCA(430,"D",X,0))
 .   I Y,$P($G(^PRCA(430,Y,0)),"^",9) S Y=$P(^(0),"^",9),^DISV(DUZ,"^PRCA(430,")=Y,RCRJFLAG=1 Q
 .   ;
 .   ;  lookup account
 .   S DIC="^RCD(340,",DIC(0)="E"
 .   D ^DIC
 .   I Y'<0 S RCRJFLAG=1
 I Y<0,'$G(DUOUT),'$G(DTOUT) S Y=0
 Q +Y
 ;
 ;
ACCNTHDR(RCDEBTDA) ;  return account data (for headings)
 I '$G(RCDEBTDA) Q ""
 ;
 N ADDRESS,DOB,RCDPDATA,SSN,Y
 D DIQ340(RCDEBTDA,.01)
 ;
 ;  get SSN and DOB if applicable
 S SSN="",DOB=""
 I RCDPDATA(340,RCDEBTDA,.01,"I")["DPT" D
 .   S SSN="("_$P($G(^DPT(+RCDPDATA(340,RCDEBTDA,.01,"I"),0)),"^",9)_")"
 .   S Y=$P($G(^DPT(+RCDPDATA(340,RCDEBTDA,.01,"I"),0)),"^",3) I Y D DD^%DT
 .   S DOB="DOB: "_Y
 I RCDPDATA(340,RCDEBTDA,.01,"I")["VA(" D
 .   S SSN="("_$P($G(^VA(200,+RCDPDATA(340,RCDEBTDA,.01,"I"),0)),"^",9)_")"
 .   S Y=$P($G(^VA(200,+RCDPDATA(340,RCDEBTDA,.01,"I"),1)),"^",3) I Y D DD^%DT
 .   S DOB="DOB: "_Y
 ;
 S ADDRESS=$$DADD^RCAMADD(RCDPDATA(340,RCDEBTDA,.01,"I"))
 I $P(ADDRESS,"^")="" S $P(ADDRESS,"^")="NO STREET"
 I $P(ADDRESS,"^",4)="" S $P(ADDRESS,"^",4)="NO CITY"
 I $P(ADDRESS,"^",5)="" S $P(ADDRESS,"^",5)="NO STATE"
 I $P(ADDRESS,"^",6)="" S $P(ADDRESS,"^",6)="NO ZIP"
 ;
 ;  account name ^ ssn ^ dob ^ street1 ^ street2 ^ street3 ^ city
 ;  ^ state ^ zip ^ phone
 Q RCDPDATA(340,RCDEBTDA,.01,"E")_"^"_SSN_"^"_DOB_"^"_ADDRESS
