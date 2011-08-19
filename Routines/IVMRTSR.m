IVMRTSR ;ALB/KCL - Report of IVM Transmissions ; 30 April 1993
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
EN ; Entry point
 W !!,"Income Verification Match - Transmission Report"
 S DIR(0)="S^1:SINGLE DATE REPORT;2:DATE RANGE REPORT"
 D ^DIR I 'Y!$D(DIRUT) G ENQ
 S IVMFLG=+Y
 ;
 ; Get report run dates
 D BEG I 'Y!$D(DIRUT) G ENQ
 I IVMFLG=1 S IVMEND=IVMBEG
 I IVMFLG=2 D END I 'Y!$D(DIRUT) G ENQ
 ;
 ; Select device for queueing/printing report
 S IVMRTN="SORT^IVMRTSR",ZTDESC="IVM TRANSMISSION REPORT"
 S ZTSAVE("IVMBEG")="",ZTSAVE("IVMEND")="",ZTSAVE("IVMFLG")=""
 D ^IVMUTQ
 ;
ENQ ; Cleanup
 K DA,DIRUT,IVMI,IVMA,IVMC,IVMBEG,IVMDATE,IVMEND,IVMNODE,IVMNODE1,IVMREC,IVMRTN,IVMTRD
 K X,X1,X2,^TMP("IVMRTSR",$J),IVMSTAT,IVMCNTS
 Q
 ;
 ;
BEG ; Enter Begin date for report
 S DIR(0)="DO^::EX",DIR("A")="Enter "_$S(IVMFLG=2:"Start ",1:"")_"DATE",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:'Y!$D(DIRUT) BEGQ S IVMBEG=+Y
 I IVMBEG>DT W !,?5,"Future dates are not allowed.",*7 K IVMBEG G BEG
BEGQ Q
 ;
END ; Select ending date for report
 S DIR(0)="DA^"_IVMBEG_":NOW:EX",DIR("A")="Enter End DATE: ",DIR("?")="^D HELP^%DTC" D ^DIR K DIR S IVMEND=+Y
 Q
 ;
 ;
SORT ; Sort data for report
 K ^TMP("IVMRTSR",$J)
 S (IVMI,IVMCNT,IVMCNT1,IVMA,IVMC,IVMNIN,IVMIN,IVMCNIN,IVMCIN)=0
 S IVMTRD=IVMBEG-.1 F  S IVMTRD=$O(^IVM(301.6,"ADT",IVMTRD)) Q:'IVMTRD!(IVMTRD>(IVMEND+.9))  S IVMI=0 F  S IVMI=$O(^IVM(301.6,"ADT",IVMTRD,IVMI)) Q:'IVMI  D
 .S IVMNODE=$G(^IVM(301.6,IVMI,0)),IVMNODE1=$G(^(1))
 .S IVMCNT=IVMCNT+1 ; Count the number of transmissions
 .I '$D(^TMP("IVMRTSR",$J,+IVMNODE)) S IVMCNT1=IVMCNT1+$$RETRANS(+IVMNODE,IVMI,IVMEND) ; Count multiple transmissions
 .;
 .; Count the category A's with/without insurance
 .I $P(IVMNODE1,"^",1)=4,$P(IVMNODE1,"^",2) S IVMIN=IVMIN+1
 .I $P(IVMNODE1,"^",1)=4,'$P(IVMNODE1,"^",2) S IVMNIN=IVMNIN+1
 .;
 .; Now count the category C's with/without insurance
 .I $P(IVMNODE1,"^",1)=6,'$P(IVMNODE1,"^",2) S IVMCNIN=IVMCNIN+1
 .I $P(IVMNODE1,"^",1)=6,$P(IVMNODE1,"^",2) S IVMCIN=IVMCIN+1
 .;
 .; Determine the transmission status and count
 .S IVMSTAT=$P(IVMNODE,"^",3)
 .I IVMSTAT=""!(("^0^1^2^3^")'[("^"_IVMSTAT_"^")) S IVMCNTS("NO")=$G(IVMCNTS("NO"))+1 Q
 .S IVMCNTS(IVMSTAT)=$G(IVMCNTS(IVMSTAT))+1
 ;
AVG ; If a date range report DO calculations 
 I IVMFLG=2,IVMCNT D
 .S X1=IVMEND,X2=IVMBEG D ^%DTC S IVMRNG=$G(X)+1 ; Get number of days included in date range
 .;
 .S IVMPERA=((IVMIN/IVMCNT)*100),IVMPERC1=((IVMCIN/IVMCNT)*100) ; %A and %C with insurance
 .S IVMPERB=((IVMNIN/IVMCNT)*100),IVMPERC=((IVMCNIN/IVMCNT)*100) ; %A and %C with no insurance
 ;
 ; Call print portion of report
 D EN^IVMRTSR1
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 D ENQ
 Q
 ;
RETRANS(IVMDATE,IVMREC,IVMEND) ; Extrinsic function that returns the number of retransmissions for a given IVM TRANSMISSION LOG entry
 N RESULT,IVMRETR
 S IVMRETR=0 ; Retransmission counter
 S ^TMP("IVMRTSR",$J,IVMDATE)=""
 F  S IVMREC=$O(^IVM(301.6,"B",IVMDATE,IVMREC)) Q:'IVMREC  D
 .S RESULT=$P($G(^IVM(301.6,IVMREC,0)),"^",2)
 .I RESULT<(IVMEND+.9) S IVMRETR=IVMRETR+1
 Q IVMRETR
