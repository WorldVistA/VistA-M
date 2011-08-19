RCBDPSLM ;WISC/RFJ-patient statement top list manager routine ;1 Dec 00
 ;;4.5;Accounts Receivable;**162,198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N RCDEBTDA
 ;
 F  D  Q:'RCDEBTDA
 .   W !! S RCDEBTDA=$$SELACCT
 .   I RCDEBTDA<1 S RCDEBTDA=0 Q
 .   D EN^VALM("RCBD PATIENT STATEMENT")
 Q
 ;
 ;
INIT ;  initialization for list manager list
 N ORIGAMT,RCBILLDA,RCDATE,RCEVENDA,RCEVENT,RCFINCOM,RCLINE,RCOUTBAL,RCSTATE,RCSTDATE,RCTOTAL,RCTRANDA,RCTRCNT,RCVALUE
 K ^TMP("RCBDPSLM",$J),^TMP("RCBDPSLMDATA",$J)
 ;
 ;
 ;  get the last event (patient statement) entry
 S RCEVENDA=$$LASTEVNT^RCBDFST1(RCDEBTDA)
 I RCEVENDA D EVENTBAL^RCBDFST1(+RCEVENDA)
 ;
 ;  build list of bills (original amount) by statement date
 S RCDATE=0 F  S RCDATE=$O(^PRCA(430,"ATD",RCDEBTDA,RCDATE)) Q:'RCDATE  D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"ATD",RCDEBTDA,RCDATE,RCBILLDA)) Q:'RCBILLDA  D
 .   .   S ORIGAMT=+$P(^PRCA(430,RCBILLDA,0),"^",3) I 'ORIGAMT Q
 .   .   ;
 .   .   ;  estimate statement date
 .   .   S RCSTATE=$P(RCEVENDA,"^",2)
 .   .   I RCDATE>$P(RCEVENDA,"^",2) S RCSTATE=10000000
 .   .   ;
 .   .   S ^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE,RCDATE,0)=RCBILLDA_"^"_ORIGAMT
 ;
 ;  build list of transactions by statement date
 S RCDATE=0 F  S RCDATE=$O(^PRCA(433,"ATD",RCDEBTDA,RCDATE)) Q:'RCDATE  D
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"ATD",RCDEBTDA,RCDATE,RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;  get transaction value, no value, quit
 .   .   S RCVALUE=$$TRANVALU^RCDPBTLM(RCTRANDA) I RCVALUE="" Q
 .   .   ;  special case for prepayments (26)
 .   .   I $P(^PRCA(430,+$P($G(^PRCA(433,RCTRANDA,0)),"^",2),0),"^",2)=26 D
 .   .   .   S $P(RCVALUE,"^",2)=-$P(RCVALUE,"^",2)
 .   .   ;
 .   .   ;  estimate statement date
 .   .   S RCSTATE=$P(RCEVENDA,"^",2)
 .   .   I RCDATE>$P(RCEVENDA,"^",2) S RCSTATE=10000000
 .   .   I $P(^PRCA(433,RCTRANDA,0),"^",10) S RCSTATE=10000000
 .   .   ;
 .   .   S ^TMP("RCBDPSLMDATA",$J,RCDEBTDA,RCSTATE,RCDATE,RCTRANDA)=RCVALUE
 ;
 D INITCONT^RCBDPSL1
 Q
 ;
 ;
HDR ;  header code for list manager display
 D HDR^RCDPAPLM
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCBDPSLM",$J),^TMP("RCBDPSLMDATA",$J)
 Q
 ;
 ;
SELACCT() ;  select a first party acct
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of bill
 N %,%Y,C,DIC,DILN,DTOUT,DUOUT,X,Y
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^RCD(340,",DIC(0)="QEAM",DIC("A")="Select First Party ACCOUNT: "
 S DIC("S")="I $P($G(^RCD(340,+Y,0)),U)[""DPT("""
 D ^DIC
 I Y<0,'$G(DUOUT),'$G(DTOUT) S Y=0
 Q +Y
