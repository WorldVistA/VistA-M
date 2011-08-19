PSXBPSMS ;BIRM/BSR - BPS (ECME) Utilities ;10/29/98  2:13 PM
 ;;2.0;CMOP;**48**;11 Apr 97
 ;Reference to $$RXFLDT^PSOBPSUT supported by IA 4701
 ;
EN ;Main entry point.
 N EMCNT,DFN,ORCNT,PATCNT,DIV,RX,DFN,SSN,PTLST,VADM
 K ^TMP("PSXEPHOUT",$J)
 S DIV="",(EMCNT,ORCNT,PATCNT)=0
 F  S DIV=$O(^TMP("PSXEPHIN",$J,DIV))  Q:DIV=""  D
 .D HEADER(DIV)
 .S RX="" F  S RX=$O(^TMP("PSXEPHIN",$J,DIV,RX)) Q:RX=""  D
 ..S DFN=+$P(^PSRX(RX,0),"^",2) D DEM^VADPT
 ..S SSN=$E($P(VADM(2),U),6,9),PATNM=(VADM(1))
 ..S ORCNT=$G(ORCNT)+1 D PATCNT(PATNM_SSN)
 ..D FORMAT
 .D FOOTER(DIV)
 D MAIL,CLEAN
 Q
 ;
 ; Format Row
FORMAT ;
 N LTXT,RFL
 S RFL=+$G(^TMP("PSXEPHIN",$J,DIV,RX)),LTXT=$$GET1^DIQ(52,RX,.01)_"/"_RFL
 S $E(LTXT,15)=$E(PATNM,1,18)_"("_SSN_")",$E(LTXT,40)=$E($$GET1^DIQ(52,RX,6),1,25)
 I $$PATCH^XPDUTL("PSO*7.0*148") S $E(LTXT,66)=$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RX,RFL))
 D STORELN(LTXT)
 Q
 ;
 ;Count patients.
PATCNT(NAMSSN) ;
 I '$D(PTLST(NAMSSN)) D
 .S PTLST(NAMSSN)=""
 .S PATCNT=$G(PATCNT)+1
 Q
 ;
 ;Build header.
HEADER(DIV) ;
 D STORELN("Division: "_$$GET1^DIQ(59,DIV,.01))
 D STORELN($TR($J("",79)," ","-"))
 D STORELN("RX#/Fill      PATIENT(LAST4SSN)        DRUG                      FILL DATE")
 D STORELN($TR($J("",79)," ","-"))
 Q
 ;       
 ;Output patient count & prescriptions count & division number
FOOTER(DIVN) ;
 D STORELN(" ")
 D STORELN("Total "_$$GET1^DIQ(59,DIVN,.01)_": "_PATCNT_" Patients and "_ORCNT_" Prescriptions.")
 D STORELN(" ")
 K PTLST S (ORCNT,PATCNT)=0
 Q
 ;
 ;Build and Send email to provider.
MAIL ;
 N PSBMSG,M1,Y,USER,XMTEXT,XMDUZ,XMSUB,XMY
 S PSBMSG(1)="The prescriptions listed below are third party electronically billable. They"
 S PSBMSG(2)="have not been transmitted to CMOP because they have been submitted to"
 S PSBMSG(3)="third party payer but we have not received a response regarding these"
 S PSBMSG(4)="prescriptions yet. The prescriptions will remain in the CMOP queue to be"
 S PSBMSG(5)="transmitted in the next transmission if the response from the third party"
 S PSBMSG(6)="payer has been received."
 S PSBMSG(7)=" "
 S M1=8
 S Y="" F  S Y=$O(^TMP("PSXEPHOUT",$J,"M",Y)) Q:Y=""  D
 .S PSBMSG(M1)=$P(^TMP("PSXEPHOUT",$J,"M",Y),"^"),M1=M1+1
 ; Send email to all users who hold a security key
 S USER=0
 I $D(^XUSEC("PSXMAIL")) D
 .F  S USER=$O(^XUSEC("PSXMAIL",USER)) Q:'USER  S XMY(USER)=""
 E  D
 .F  S USER=$O(^XUSEC("PSXCMOPMGR",USER)) Q:'USER  S XMY(USER)=""
 ;
 S XMTEXT="PSBMSG(",XMSUB="ePharmacy - CMOP Not TRANSMITTED Rx List"
 S XMDUZ=.5
 D ^XMD
 Q
 ;
 ;Store E-mail line for later use.
STORELN(LINE) ;
 S EMCNT=EMCNT+1
 S ^TMP("PSXEPHOUT",$J,"M",EMCNT)=LINE
 Q
 ;
 ;Clean all remaining arrays and variables.
CLEAN ;
 K ^TMP("PSXEPHOUT",$J),^TMP("PSXEPHIN",$J)
 Q
