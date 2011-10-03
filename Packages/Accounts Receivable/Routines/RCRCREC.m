RCRCREC ;ALB/CMS - RC AND DHCP RECONCILIATION REPORTS ; 16-JUN-00
V ;;4.5;Accounts Receivable;**61,63,147,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Tasked from the RC RC SERV routine
 ; INPUT: RCJOB,RCSITE,RCVAR,RCXTYP,RCXMY,RCBDT,RCEDT,RCXMZ
 ;OUTPUT: Four mail messages to G.RC RC REFERRALS
 ;
 N OUT,RCDIV,RCDOMNM
 D RCDIV^RCRCDIV(.RCDIV)
 ;
 ; - if only one RC division of care, run process and quit
 I '$O(RCDIV(0)) D EN G MAINQ
 ;
 ; - build new array by the RC domain and division, i.e.
 ;     rcdiv("rcdomain",rc domain name,division)=""
 I $O(RCDIV(0)) S RCDIV=0 F  S RCDIV=$O(RCDIV(RCDIV)) Q:'RCDIV  D 
 .S RCDIV("RCDOMAIN",$P(RCDIV(RCDIV),"^",2),RCDIV)=""
 ;
 ; - run process for each RC domain/office
 S RCDOMNM="" F  S RCDOMNM=$O(RCDIV("RCDOMAIN",RCDOMNM)) Q:RCDOMNM=""  D EN
 ;
MAINQ I '$D(OUT) K ^XTMP(RCXTYP,RCXMZ)
 K RCJOB,RCSITE,RCVAR,RCXTYP,RCXMY,RCXMZ
 Q
 ;
 ;
EN ; Process bills for each specific RC Office
 D INIT
 D ^RCRCREC2
 D SEND ; Create the four messages and send them to RCXMY
 K ^TMP("PRCA",$J)
 Q
 ;
 ;
INIT ;Initialize variables and arrays
 N I,LN,MTYP,RCREG
 K ^TMP("PRCA",$J)
 S RCSITE=$$SITE^RCMSITE
 ;
 ; - set RC reference name for message
 S RCREG=$S($G(RCDOMNM)]"":RCDOMNM,1:"REGIONAL COUNSEL SYSTEM")
 ;
 F I=1:1:4 D
 .S ^TMP("PRCA",$J,"MR"_I,0)=5
 .S ^TMP("PRCA",$J,"MR"_I,3)="               VAMC: "_RCSITE_" - "_$P($G(^DIC(4,RCSITE,0)),U,1)
 .S ^TMP("PRCA",$J,"MR"_I,4)="   "
 .S ^TMP("PRCA",$J,"MR"_I,5)="============================================================================="
 S ^TMP("PRCA",$J,"MR1",1)="   BILLS ACTIVE/REFERRED IN ACCOUNTS RECEIVABLE SYSTEM"
 S ^TMP("PRCA",$J,"MR1",2)="   BUT NOT PENDING IN "_RCREG
 S ^TMP("PRCA",$J,"MR2",1)="   BILLS PENDING IN "_RCREG
 S ^TMP("PRCA",$J,"MR2",2)="   BUT NOT ACTIVE/REFERRED IN ACCOUNTS RECEIVABLE SYSTEM"
 S ^TMP("PRCA",$J,"MR3",1)="   BILLS IN REGIONAL COUNSEL SYSTEM AND ACCOUNTS RECEIVABLE SYSTEM"
 S ^TMP("PRCA",$J,"MR3",2)="       WITH DIFFERENT DOLLAR AMOUNTS OR PATIENT SSN NUMBER"
 S ^TMP("PRCA",$J,"MR4",1)="   BILLS IN REGIONAL COUNSEL SYSTEM AND ACCOUNTS RECEIVABLE SYSTEM"
 S ^TMP("PRCA",$J,"MR4",2)="   WITH A DECREASE ADJUSTMENT BEFORE BILL REF.DT "
 I RCEDT,RCBDT D
 .S Y=RCBDT D D^DIQ
 .S ^TMP("PRCA",$J,"MR4",2)=^TMP("PRCA",$J,"MR4",2)_" ("_Y_" to "
 .S Y=RCEDT D D^DIQ
 .S ^TMP("PRCA",$J,"MR4",2)=^TMP("PRCA",$J,"MR4",2)_Y_")"
 ;  
INITQ Q
 ;
SEND ;Send reports to Mailman
 ;Loop for MR1 to MR4
 N MREP
 F MREP="MR1","MR2","MR3","MR4" D  ;
 .N LN S MTYP=$E(MREP,3)
 .I +$G(^TMP("PRCA",$J,MREP,0))=5 D  Q
 ..S ^TMP("PRCA",$J,MREP,6)="      NO RECORDS FOUND"
 ..M LN=^TMP("PRCA",$J,MREP) D XMB
 .D SBIG Q
SENDQ Q
 ;
SBIG ;Send the four large reports in a mail message to site and RC
 N DATA,II,LN,RETRY,XMCHAN,XMDUZ,XMSUB,XMY,XMZ S RETRY=0
 S XMCHAN=1,XMSUB="AR/RC - SITE: "_$G(RCSITE,"UNK")_" ("_+MTYP_" of 4) RECONCILIATION REPORT"
 S (XMDUN,XMDUZ)="ACCOUNTS RECEIVABLE RC SERVER"
 D XMZ^XMA2 I XMZ<1 S RETRY=RETRY+1 I RETRY<100 G SBIG
 I RETRY>99 D  D XMB S OUT=1 G SBIGQ
 .S MTYP=0
 .S LN(1)=" The AR/RC Reconciliation Report is having trouble creating"
 .S LN(2)="the four mail messages. Please contact an IRM support person."
 S II=0,LN=0 F  S II=$O(^TMP("PRCA",$J,MREP,II)) Q:'II  D
 .S DATA=^TMP("PRCA",$J,MREP,II)
 .I $L(DATA) S LN=LN+1 S ^XMB(3.9,XMZ,2,LN,0)=DATA
 I $D(^XMB(3.9,XMZ,2)) S ^XMB(3.9,XMZ,2,0)="^3.92^"_LN_U_LN_U_DT
 S XMY("G.RC RC REFERRALS")=""
 I $G(RCXMY)]"" S XMY(RCXMY)=""
 D ENT1^XMD I XMZ<1 S RETRY=RETRY+1 I RETRY<100 G XMB
SBIGQ Q
 ;
XMB ;Call to mailman
 ;INPUT: LN( for message text array
 ;       MTYP for message type (1 of 4) or 0 for (1 of 1)
 ;       RCSITE
 N RETRY,XMCHAN,XMDUZ,XMSUB,XMTEXT,XMY,XMZ S RETRY=0
 S XMCHAN=1,XMSUB="AR/RC - SITE: "_$G(RCSITE,"UNK")_" ("_$S(MTYP=0:1,1:+MTYP)_" of "_$S(MTYP=0:1,1:4)_") RECONCILIATION REPORT"
 S XMTEXT="LN(",XMDUZ="ACCOUNTS RECEIVABLE RC SERVER"
 S XMY("G.RC RC REFERRALS")=""
 I $G(RCXMY)]"" S XMY(RCXMY)=""
 D ^XMD I XMZ<1 S RETRY=RETRY+1 I RETRY<100 G XMB
XMBQ Q
 ;RCRCREC
