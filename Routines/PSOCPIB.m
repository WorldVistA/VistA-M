PSOCPIB ;BHAM ISC/EJW - PHARMACY CO-PAY IB-INITIATED COPAY CHARGE ;  07/27/01
 ;;7.0;OUTPATIENT PHARMACY;**71,137**;DEC 1997
 ;External reference to IBARX supported by DBIA 125
 ; files IB-initiated charges into original or refill node
 ; IB passes date/time^person initiating copay^Rx#^Fill#^Partial or full charge^IB transaction IEN from file #350
 N PSODA,PSOCOMM,PSOREF,PREA,SAVEDUZ,PSORSN
 S PREA="I"
 S SAVEDUZ=DUZ
 S DUZ=$P(Y(1),"^",2)
 S PSODA=$P(Y(1),"^",3)
 I 'PSODA Q
 S PSOREF=$P(Y(1),"^",4)
 D CHKIB
 S PSOCOMM=$S($P(Y(1),"^",5)="F":"FULL CHARGE",1:"PARTIAL CHARGE")
FILE ;         File IB number in ^PSRX
 S:PSOREF>0 ^PSRX(PSODA,1,PSOREF,"IB")=$P(Y(1),"^",6) ;  Filing in refill node
 I PSOREF>0,'$D(^PSRX(PSODA,"IB")) S ^PSRX(PSODA,"IB")="^^" ;  If refill "IB" exists, need "IB" entry on original fill node
 S:PSOREF=0 $P(^PSRX(PSODA,"IB"),"^",2)=$P(Y(1),"^",6) ;Filing in original fill (zero node)
 D ACTLOG^PSOCPA
 I $P($G(^PSRX(PSODA,"IB")),"^",1)="" D CANCEL ; IF Rx is 'no copay', send a cancel back to IB in 10 minutes for their IB-initiated charge
 S DUZ=SAVEDUZ
 Q
 ;
CANCEL ;
 S ZTRTN="CANCHG^PSOCPIB"
 S ZTDESC="Call IB back to cancel charges"
 S PSORX=Y(1)_"^"_$G(PSOPAR7)
 S ZTSAVE("PSORX")=""
 S ZTDTH=$$HADD^XLFDT($H,0,0,10),ZTIO=""
 D ^%ZTLOAD
 Q
 ;
CANCHG ; Cancel charges if IB initiates a charge for a 'no copay' Rx
 N PSODA,PSOCOMM,PSOREF,PREA,SAVEDUZ,X
 S PREA="C"
 S DUZ=$P(PSORX,"^",2)
 S PSODA=$P(PSORX,"^",3)
 S PSOREF=$P(PSORX,"^",4)
 S PSOPAR7=$P(PSORX,"^",7)
 S X=PSOPAR7_"^"_+$P(^PSRX(PSODA,0),"^",2)_"^^"_DUZ
 I PSOREF=0 D  I $O(X(""))="" Q
 . I $P($G(^PSRX(PSODA,"IB")),"^",2)>0 S X(PSODA)=$P(^PSRX(PSODA,"IB"),"^",2)_"^40"
 I PSOREF>0 D  I $O(X(""))="" Q
 . I $P($G(^PSRX(PSODA,1,PSOREF,"IB")),"^",1)>0 S X(PSODA)=$P(^PSRX(PSODA,1,PSOREF,"IB"),"^",1)_"^40"
 D CANCEL^IBARX
 I $D(Y(PSODA)),+$G(Y(PSODA))'=-1 D
 . S $P(^PSRX(PSODA,"IB"),"^",2)=+Y(PSODA),$P(^PSRX(PSODA,"IB"),"^",4)="" K Y(PSODA)
 . S PREA="C",PSOREF=0,PSOCOMM="AUTO-CANCEL IB-INITIATED CHARGE FOR 'NO COPAY' RX" D ACTLOG^PSOCPA
 F PSOREF=0:0 S PSOREF=$O(Y(PSOREF)) Q:PSOREF=""  Q:PSOREF>12  D
 . I +Y(PSOREF)'=-1,$D(^PSRX(PSODA,1,PSOREF)) S ^PSRX(PSODA,1,PSOREF,"IB")=+Y(PSOREF)
 . S PREA="C",PSOCOMM="AUTO-CANCEL IB-INITIATED CHARGE FOR 'NO COPAY' RX" D ACTLOG^PSOCPA
 Q
 ;
CHKIB ; SEE IF IB NUMBER ALREADY EXISTS AND IS A BILL OR UPDATE NUMBER (NOT A CANCEL NUMBER)
 N PSOIB,PSOSTAT
 I PSOREF=0 S PSOIB=$P($G(^PSRX(PSODA,"IB")),"^",2)
 I PSOREF'=0 S PSOIB=$P($G(^PSRX(PSODA,1,PSOREF,"IB")),"^",1)
 I PSOIB'="" D STATUS
 Q
 ;
STATUS ;
 S PSOSTAT=$$STATUS^IBARX(PSOIB)
 I PSOSTAT'=1,PSOSTAT'=3 Q
 S PSOCOMM="Copay charge(s) removed"
 D ACTLOG^PSOCPA
 Q
 ;
