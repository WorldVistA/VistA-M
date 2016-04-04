PSXBPSMS ;BIRM/BSR - BPS (ECME) Utilities ;10/29/98  2:13 PM
 ;;2.0;CMOP;**48,77**;11 Apr 97;Build 3
 ;Reference to $$RXFLDT^PSOBPSUT supported by IA 4701
 ;
EN ;Main entry point.
 N EMCNT,DFN,ORCNT,PATCNT,DIV,RX,RFL,DFN,SSN,PATNM,PTLST,VADM
 K ^TMP("PSXEPHOUT",$J)
 S ^XTMP("PSXBPSMS",0)=$$FMADD^XLFDT(DT,35)_"^"_DT
 S DIV="",(EMCNT,ORCNT,PATCNT)=0
 F  S DIV=$O(^TMP("PSXEPHIN",$J,DIV)) Q:DIV=""  D
 .D HEADER(DIV)
 .S RX="" F  S RX=$O(^TMP("PSXEPHIN",$J,DIV,RX)) Q:RX=""  D
 ..S RFL=+$G(^TMP("PSXEPHIN",$J,DIV,RX))
 ..S ^XTMP("PSXBPSMS",1,RX,RFL,DT)=""
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
 N LTXT
 S LTXT=$$GET1^DIQ(52,RX,.01)_"/"_RFL
 S $E(LTXT,17)=$E(PATNM,1,18)_"("_SSN_")",$E(LTXT,42)=$E($$GET1^DIQ(52,RX,6),1,23)
 S $E(LTXT,67)=$$TRANS(RX,RFL)
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
 D STORELN("                                                                NOT TRANSMITTED")
 D STORELN("RX#/Fill        PATIENT(LAST4)           DRUG                     1ST DT  #DAYS")
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
 S PSBMSG(1)="The prescriptions listed in this message did not transmit to CMOP for one of"
 S PSBMSG(2)="the reasons below:"
 S PSBMSG(3)=" "
 S PSBMSG(4)="        A response from the third party payer was not received"
 S PSBMSG(5)=" "
 S PSBMSG(6)="        OR"
 S PSBMSG(7)=" "
 S PSBMSG(8)="        The prescriptions are non-billable in VistA"
 S PSBMSG(9)=" "
 S PSBMSG(10)="The prescriptions will remain in the CMOP queue and will transmit when the"
 S PSBMSG(11)="response from the third party payer is received, or the non-billable issue"
 S PSBMSG(12)="is resolved.  Examples of non-billable issues are prescriptions for"
 S PSBMSG(13)="sensitive medications that need Release of Information and prescriptions"
 S PSBMSG(14)="for non-billable drugs (e.g., OTC products for CHAMPVA and TRICARE patients)."
 S PSBMSG(15)=" "
 S M1=16
 S Y="" F  S Y=$O(^TMP("PSXEPHOUT",$J,"M",Y)) Q:Y=""  D
 .S PSBMSG(M1)=$P(^TMP("PSXEPHOUT",$J,"M",Y),"^"),M1=M1+1
 ; Send email to all users who hold a security key
 S USER=0
 I $D(^XUSEC("PSXMAIL")) D
 .F  S USER=$O(^XUSEC("PSXMAIL",USER)) Q:'USER  S XMY(USER)=""
 E  D
 .F  S USER=$O(^XUSEC("PSXCMOPMGR",USER)) Q:'USER  S XMY(USER)=""
 ;
 N DIV,SITES
 S DIV="",SITES=""
 F  S DIV=$O(^TMP("PSXEPHIN",$J,DIV)) Q:DIV=""  S SITES=SITES_$$GET1^DIQ(59,DIV_",",.01,"E")_","
 S XMSUB=$E("ePharmacy CMOP Not TRANSMITTED Rxs - "_$E(SITES,1,$L(SITES)-1),1,65)
 S XMTEXT="PSBMSG(",XMDUZ=.5
 D ^XMD
 Q
 ;
 ;Store E-mail line for later use.
STORELN(LINE) ;
 S EMCNT=EMCNT+1
 S ^TMP("PSXEPHOUT",$J,"M",EMCNT)=LINE
 Q
 ;
TRANS(RX,RFL) ;
 I '$G(RX) Q ""
 I $G(RFL)="" Q ""
 N TDT,CNT,FDT
 S CNT=0,FDT=9999999
 S TDT="" F  S TDT=$O(^XTMP("PSXBPSMS",1,RX,RFL,TDT)) Q:'TDT  D
 . S CNT=CNT+1
 S FDT=$O(^XTMP("PSXBPSMS",1,RX,RFL,""))
 I FDT=9999999 S FDT="        "
 E  S FDT=$E(FDT,4,5)_"/"_$E(FDT,6,7)_"/"_($E(FDT,2,3))
 Q FDT_$E("    ",1,5-$L(CNT))_CNT
 ;
 ;Clean all remaining arrays and variables
 ;Purge ^XTMP data older than 30 days
CLEAN ;
 K ^TMP("PSXEPHOUT",$J),^TMP("PSXEPHIN",$J)
 ; Purge ^XTMP data older than 30 days
 N FDT,RX,RFL,TDT
 S FDT=$$FMADD^XLFDT(DT,-30)
 S RX="" F  S RX=$O(^XTMP("PSXBPSMS",1,RX)) Q:'RX  D
 . S RFL="" F  S RFL=$O(^XTMP("PSXBPSMS",1,RX,RFL)) Q:RFL=""  D
 .. S TDT="" F  S TDT=$O(^XTMP("PSXBPSMS",1,RX,RFL,TDT)) Q:'TDT  D
 ... I TDT<FDT K ^XTMP("PSXBPSMS",1,RX,RFL,TDT)
 Q
