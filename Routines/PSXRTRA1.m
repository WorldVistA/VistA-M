PSXRTRA1 ;BIR/PDW-RETRANSMISSION REPORT SUBROUTINE ;11 AUG 2002
 ;;2.0;CMOP;**41,51**;11 Apr 97
 ;Reference to ^PSRX(   supported by DBIA #1977
REPORT ;
 K ^TMP($J,"PSXRTRPT"),LSSN S CNT=21
 S PTNM="" F  S PTNM=$O(^PSX(550.2,OLDBAT,15,"C",PTNM)) Q:PTNM=""  D
 . S DFN=0 F  S LSSN="" S DFN=$O(^PSX(550.2,OLDBAT,15,"C",PTNM,DFN)) Q:DFN'>0  D RXS
 D MM
 K PTNM,RXPTR,XSTAT
 Q
RXS ;
 S RXPTR=0 F  S RXPTR=$O(^PSX(550.2,OLDBAT,15,"C",PTNM,DFN,RXPTR)) Q:RXPTR=""  D
 . S FILL=$O(^PSX(550.2,OLDBAT,15,"C",PTNM,DFN,RXPTR,""))
 . D TXT
 Q
MM S XMSUB="CMOP Retransmission Report for "_$G(OLDBATNM),XMDUZ=.5,XMDUN="CMOP Managers"
 D XMZ^XMA2 G:$G(XMZ)'>0 MM
 S ^XMB(3.9,XMZ,2,1,0)="CMOP Re-Transmission Report"
 S ^XMB(3.9,XMZ,2,2,0)=$G(PSXBATNM)_" Re-Transmission of "_$G(OLDBATNM)
 S ^XMB(3.9,XMZ,2,3,0)=" "
 S ^XMB(3.9,XMZ,2,4,0)="The Original Transmission # "_$G(OLDBATNM)_" contained:"
 S ^XMB(3.9,XMZ,2,5,0)="Beginning Message Number: "_$P(^PSX(550.2,OLDBAT,1),"^",5)
 S ^XMB(3.9,XMZ,2,6,0)="Ending Message Number   : "_$P(^PSX(550.2,OLDBAT,1),"^",6)
 S ^XMB(3.9,XMZ,2,7,0)="Total Orders            : "_$P(^PSX(550.2,OLDBAT,1),"^",7)
 S ^XMB(3.9,XMZ,2,8,0)="Total Rx's              : "_$P(^PSX(550.2,OLDBAT,1),"^",8)
 S ^XMB(3.9,XMZ,2,9,0)=" "
 S ^XMB(3.9,XMZ,2,10,0)="Retransmission # "_$G(PSXBATNM)_" contained:"
 S ^XMB(3.9,XMZ,2,11,0)="Beginning Message Number: "_$G(MCT)
 S ^XMB(3.9,XMZ,2,12,0)="Ending Message Number   : "_$G(LMSG)
 S ^XMB(3.9,XMZ,2,13,0)="Total Orders            : "_$G(PSXMSGCT)
 S ^XMB(3.9,XMZ,2,14,0)="Total Rx's              : "_$G(PSXRXCT)
 S ^XMB(3.9,XMZ,2,15,0)=" "
 S ^XMB(3.9,XMZ,2,16,0)="Following is a list of the original prescription orders and their status."
 S ^XMB(3.9,XMZ,2,17,0)="** Prescriptions that have been refilled or released are not sent. **"
 I '$D(^TMP($J,"PSXRTRPT")) S ^XMB(3.9,XMZ,17,0)="All prescriptions were transmitted" S CNT=17 G MAIL
 F JJ=18,19,20 S ^XMB(3.9,XMZ,2,JJ,0)=" "
 S XX="Patient",Y="SSN",XX=$$SETSTR^VALM1("SSN",XX,25,3)
 S XX=$$SETSTR^VALM1("RX",XX,40,2),XX=$$SETSTR^VALM1("RELEASE DATE | FILL'=",XX,55,21)
 S ^XMB(3.9,XMZ,2,21,0)=XX
 M ^XMB(3.9,XMZ,2)=^TMP($J,"PSXRTRPT","MM")
MAIL ;
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_CNT_"^"_CNT_"^"_DT
 K XMY
 S XMY(DUZ)="" ;****TESTING
 D GRP^PSXNOTE ;****TESTING
 D ENT1^XMD
 Q
TXT ; store PAT & RX info for mail message
 D DEM^VADPT S SSN=$P(VADM(2),U,2),PATNM=VADM(1)
 S RXNM=$P(^PSRX(RXPTR,0),U)_"-"_FILL
 S XSTAT=""
 I '$D(^PSX(550.2,PSXBAT,15,"B",RXPTR)) D
 .S XSTAT=$$TESTREL^PSXRTRAN(RXPTR,FILL)
 .S:XSTAT="SENT" XSTAT="OTHER"
 S XX=""
 I $G(LSSN)'=SSN D
 . S XX=$E(PATNM,1,23)
 . S XX=$$SETSTR^VALM1(SSN,XX,25,$L(SSN))
 S XX=$$SETSTR^VALM1(RXNM,XX,40,$L(RXNM))
 S:$L(XSTAT) XX=$$SETSTR^VALM1(XSTAT,XX,60,$L(XSTAT))
 S CNT=$G(CNT)+1,LSSN=SSN
 S ^TMP($J,"PSXRTRPT","MM",CNT,0)=XX
 Q
CANMSG ; lock on 550.1 not achieved send transmission cancelled message
 S PSXCS=+$G(PSXCS)
 S XMSUB=$S($G(PSXCS):"",1:"NON-")_"CS Retransmission Cancelled"
 S XMTEXT="TXT("
 S TXT(1,0)="The "_$S($G(PSXCS):"",1:"NON-")_"CS Manual Transmission was cancelled "_$$GET1^DIQ(550.2,OLDBAT,.01)
 S TXT(2,0)="It could not obtain a lock on the RX QUEUE file. #550.1"
 S TXT(3,0)="This indicates that a transmission was in progress."
 S TXT(6,0)=" "
 S TXT(7,0)="If you are getting this message frequently, please contact your IRM Group"
 D EN^PSXNOTE ;****TESTING
 D ^XMD
 Q
SETSTAT ;Set RX CMOP status to re-transmitted
 N RXDA,CMPDA
 S RXDA=0 F  S RXDA=$O(^PSX(550.2,PSXBAT,15,"B",RXDA)) Q:RXDA'>0  D
 . S CMPDA=$O(^PSRX(RXDA,4,"B",OLDBAT,0)) Q:'CMPDA
 . Q:'CMPDA  Q:'$D(^PSRX(RXDA,4,CMPDA,0))
 . S $P(^PSRX(RXDA,4,CMPDA,0),U,4)=2
 Q
