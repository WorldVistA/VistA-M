PSOPOST6 ;BIR/RTR-Update comples orders to CPRS ;03/29/02
 ;;7.0;OUTPATIENT PHARMACY;**101**;DEC 1997
 ;External reference to XPD(9.7 supported by DBIA 2197
 ;
 K ZTDTH
 N PSOBACKZ S PSOBACKZ=0
 I $D(ZTQUEUED) S ZTDTH=$H,PSOBACKZ=1
 I $G(ZTDTH)="" D
 .W !!,"This background job will find all Outpatient Pharmacy orders that have complex",!,"Dosing instructions, and will send an update to CPRS for the orders. This will"
 .W !,"fix the problem of some Sigs being truncated when displayed in CPRS. A mail",!,"message will be generated to this patch installer upon completion.",!
 W ! S ZTRTN="START^PSOPOST6",ZTIO="",ZTDESC="Patch PSO*7*101 background job" D ^%ZTLOAD I '$D(ZTSK) D  S XPDABORT=2
 .W !!,"The status of this install will remain 'Start of Install'. Please reinstall",!,"this patch and queue the background job at that time.",!
 .I '$G(PSOBACKZ) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 Q
START ;
 N Y,PSOTMSTA,PSOTMSTB,PSOCOMCT,PSOTEXTO,PSOCOMIN,PSOCOMDT,PSOPXIN,PSOCXT,PSOCXZ
 D NOW^%DTC S Y=% D DD^%DT S PSOTMSTA=$G(Y)
 S (PSOCOMCT,PSOCOMIN)=0
 S PSOCOMDT=$O(^XPD(9.7,"B","PSO*7.0*46","")) I PSOCOMDT S PSOCOMIN=$E($P($G(^XPD(9.7,PSOCOMDT,1)),"^"),1,7)
 I '$G(PSOCOMIN) S PSOCOMIN=3010429
 ;go back 30 days from POE install, in case of back issue dates
 S X1=PSOCOMIN,X2=-31 D C^%DTC S PSOCOMIN=X
 F  S PSOCOMIN=$O(^PSRX("AC",PSOCOMIN)) Q:PSOCOMIN=""  S PSOPXIN="" F  S PSOPXIN=$O(^PSRX("AC",PSOCOMIN,PSOPXIN)) Q:PSOPXIN=""  I $O(^PSRX(PSOPXIN,6,1)) D
 .I '$P($G(^PSRX(PSOPXIN,"OR1")),"^",2) Q
 .S PSOCXT=0,PSOCXZ=""
 .F  S PSOCXZ=$O(^PSRX(PSOPXIN,6,PSOCXZ)) Q:PSOCXZ=""!(PSOCXT>1)  I $G(^PSRX(PSOPXIN,6,PSOCXZ,0))'="" S PSOCXT=PSOCXT+1
 .S PSOROPCH="PATCH"
 .I PSOCXT>1 S PSOCOMCT=PSOCOMCT+1 D EN^PSOHLSN1(PSOPXIN,"RO")
MAIL ;Send mail message
 K PSOROPCH
 D NOW^%DTC S Y=% D DD^%DT S PSOTMSTB=$G(Y)
 S XMDUZ="PATCH PSO*7*101 INSTALLATION",XMSUB="OUTPATIENT COMPLEX ORDERS SEARCH",XMY(DUZ)=""
 K PSOTEXTO
 S PSOTEXTO(1)="The background job for patch PSO*7*101 is complete.",PSOTEXTO(2)="It started on "_$G(PSOTMSTA),PSOTEXTO(3)="It finished on "_$G(PSOTMSTB),PSOTEXTO(4)=" ",PSOTEXTO(5)="The total number of orders updated was "_$G(PSOCOMCT)_"."
 S XMTEXT="PSOTEXTO(" N DIFROM D ^XMD
 K XMDUZ,XMSUB,XMTEXT
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
