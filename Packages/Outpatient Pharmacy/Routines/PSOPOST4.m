PSOPOST4 ;BIR/RTR-Copay conversion routine ;11/13/01
 ;;7.0;OUTPATIENT PHARMACY;**71**;DEC 1997
 ;mail message, and queue the job?
 D BMES^XPDUTL("Queuing background conversion job...")
 S ZTDTH=$H,ZTRTN="EN^PSOPOST4",ZTIO="",ZTDESC="Copay install background job" D ^%ZTLOAD K ZTDTH,ZTRTN,ZTIO,ZTDESC
 Q
EN ;Set Service Connected field, if possible
 N PSODATE,PSOBEG,PSOIN,PSOCPAT,PSOPST,PSOIB,PSODRG,PSORXPST,PSSTEXT,PSOXIN
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=-365 D C^%DTC S PSOBEG=X
 F PSODATE=PSOBEG:0 S PSODATE=$O(^PSRX("AC",PSODATE)) Q:'PSODATE!(PSODATE'<DT)  S PSOIN="" F  S PSOIN=$O(^PSRX("AC",PSODATE,PSOIN)) Q:'PSOIN  D
 .S PSOCPAT=$P($G(^PSRX(PSOIN,0)),"^",2) Q:'PSOCPAT
 .I $P($G(^PSRX(PSOIN,"IBQ")),"^")'="" Q
 .S PSOPST=$P($G(^PSRX(PSOIN,0)),"^",3),PSODRG=$P($G(^(0)),"^",6),PSOIB=$P($G(^("IB")),"^")
 .I PSOIB=2 S $P(^PSRX(PSOIN,"IBQ"),"^")=0 Q
 .I '$G(PSODRG)!('$G(PSOPST)) Q
 .I $P($G(^PSDRUG(PSODRG,0)),"^",3)["S"!($P($G(^(0)),"^",3)["I") Q
 .I '$G(PSOIB) D
 ..S PSORXPST=$P($G(^PS(53,PSOPST,0)),"^")
 ..I PSORXPST["50" D
 ...S PSORXPST=$TR(PSORXPST,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ...I PSORXPST["<"!(PSORXPST["LESS THAN") D
 ....S PSOXIN=$$RXST^IBARXEU(PSOCPAT,PSODATE) I $P($G(PSOXIN),"^")=0 S $P(^PSRX(PSOIN,"IBQ"),"^")=1
MAIL ;
 I $G(DUZ) D
 .S XMDUZ="Outpatient Pharmacy Copay Installation",XMSUB="Outpatient Pharmacy Copay Job",XMY(DUZ)=""
 .S PSSTEXT(1)="The background job for the Outpatient Pharmacy Copay patch (PSO*7*71)",PSSTEXT(2)="is now complete. The SERVICE CONNECTED field in the PRESCRIPTION file",PSSTEXT(3)="has been populated for all applicable prescriptions."
 .S XMTEXT="PSSTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
