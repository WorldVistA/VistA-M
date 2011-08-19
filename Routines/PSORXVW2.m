PSORXVW2 ;ISC-BIRM/PDW - view cmop activity logs ;08 Dec 1999 12:48 PM
 ;;7.0;OUTPATIENT PHARMACY;**33,71,117,152,148**;DEC 1997
 ; External Referrence to file # 550.2 granted by DBIA 2231
 ;External reference to ^PS(50.607 supported by DBIA 2221
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to File ^PS(55 supported by DBIA 2228
 ;External reference to VA(200 supported by DBIA 10060
 ;get data from event multiple
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" "
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="CMOP Event Log:",IEN=IEN+1
 S ^TMP("PSOAL",$J,IEN,0)="Date/Time             Rx Ref  TRN-Order       Stat             Comments",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 F PSXA=0:0 S PSXA=$O(^PSRX(DA,4,PSXA)) Q:'PSXA  S PSX4=^(PSXA,0) D FIX D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$$DATE(DA,$P(PSX4,"^",3))_"         "_$S('PSXFIL:"Orig",1:"Ref "_$G(PSXFIL))_"    "_$G(PSXBREF)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"            "_$G(PSXT)_"    "_$S($G(PSXTST)=3:$E($P($G(PSXCAN),"^"),1,35),$G(PSXNDC)'="":"NDC: "_PSXNDC,1:"")
 . I PSXCAR="",PSXID="" Q
 . N X S X="Carrier: "_$E(PSXCAR,1,21)
 . S X=$$SETSTR^VALM1("Pkg ID: ",X,32,8)
 . S X=X_PSXID
 . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=X
 D:$O(^PSRX(DA,5,0))
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" "
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="CMOP Lot#/Expiration Date Log:",IEN=IEN+1
 .S ^TMP("PSOAL",$J,IEN,0)="Rx Ref               Lot #               Expiration Date"
 .S IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 .F PSXZ=0:0 S PSXZ=$O(^PSRX(DA,5,PSXZ)) Q:PSXZ']""  S PSXLOT=^(PSXZ,0) D
 ..S EXPDT=$P(PSXLOT,U,2)
 ..S EXPDT=$E(EXPDT,4,5)_"/"_$E(EXPDT,6,7)_"/"_$E(EXPDT,2,3)
 ..S RXREF=$P(PSXLOT,U,3)
 ..S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$S(RXREF=0:"Orig",RXREF>0:"Ref "_RXREF,1:"")_"               "_$P(PSXLOT,U)_"              "_EXPDT
FINI K ANS,Y,%,I,Z,PSXLOT,PSXL,PSX4,F,PSXA,C,ER,PSXFIL,PSX4,PSXREA,PSXVID
 K PSXREL,PSXTRDT,PSXT,PSXLOC,DTOUT,DUOUT,PSXSEQ,PSXA,PSXML,P,I1,I2
 K PSXP,PSXE,PSXE1,PSXERR,PSXBAT,ZD1,ZD2,ZDT,RXREF,PSXZ,PSXTST,PSXTCAN
 K PSXRDT,PSXNDC,PSXM,PSXL1,PSXCAN,PSX1,EXPDT,PSXBREF,RXREF1
 K PSXCAR,PSXID
 Q
FIX ; translate data
 S PSXBAT=$P(PSX4,U),PSXSEQ=$P(PSX4,U,2)
 S PSXFIL=$P(PSX4,U,3),PSXTST=$P(PSX4,U,4)
 S PSXBREF=$G(PSXBAT)_"-"_$G(PSXSEQ)
 S PSXZT=$P(PSX4,U,5),PSXZT1=$P(PSXZT,"."),PSXZT2=$P(PSXZT,".",2)
 I $G(PSXZT)']"" K PSXZT,PSXZT1,PSXZT2 G F1
 S PSXZT2=$E(PSXZT2,1,4)
 S PSXZT1=$E(PSXZT1,4,5)_"/"_$E(PSXZT1,6,7)_"/"_$E(PSXZT1,2,3)
 S PSXTCAN=PSXZT1_"@"_PSXZT2 K PSXZT1,PSXZT2,PSXZT
F1 S PSXNDC=$P(PSX4,U,8)
 S PSXCAN=$G(^PSRX(DA,4,PSXA,1))
 S PSXCAR=$P(PSXCAN,U,3)
 S PSXID=$P(PSXCAN,U,4)
 ; get cmop site
 S I1=PSXBAT   ; S I1=$O(^PSX(550.2,"B",PSXBAT,""))
P1 ; get transmission d/t
 S ZDT=$P(^PSX(550.2,I1,0),U,6),ZD1=$P(ZDT,"."),ZD2=$P(ZDT,".",2)
 S ZD2=$E(ZD2,1,4)
 S ZD1=$E(ZD1,4,5)_"/"_$E(ZD1,6,7)_"/"_$E(ZD1,2,3)
 S PSXTRDT=ZD1_"@"_ZD2
Q1 S:PSXTST=0 PSXT="TRAN"
 S PSXRDT="Not Released"
 I PSXTST=1 D
 .I PSXFIL>0,('$D(^PSRX(DA,1,PSXFIL,0))) S PSXT="Disp Refill Deleted" Q
 .S PSX1=$S(PSXFIL=0:$P(^PSRX(DA,2),"^",13),1:$P(^PSRX(DA,1,PSXFIL,0),"^",18))
 .Q:PSX1']""
 .I PSX1'["." S PSXRDT=$E(PSX1,4,5)_"/"_$E(PSX1,6,7)_"/"_$E(PSX1,2,3) G SKIP
 .S ZR=PSX1,ZR1=$P(ZR,"."),ZR2=$P(ZR,".",2)
 .S ZR2=$E(ZR2,1,4)
 .S PSXRDT=$E(ZR1,4,5)_"/"_$E(ZR1,6,7)_"/"_$E(ZR1,2,3)_"@"_ZR2
 .K ZR,ZR1,ZR2
SKIP .S PSXT="DISP"
 S:PSXTST=2 PSXT="RTRN"
 S:PSXTST=3 PSXT="NDISP"
 Q
 ;
COPAY ;Copay activity log
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=" ",IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Copay Activity Log:"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="#   Date        Reason               Rx Ref         Initiator Of Activity",IEN=IEN+1,$P(^TMP("PSOAL",$J,IEN,0),"=",79)="="
 I '$O(^PSRX(DA,"COPAY",0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="There's NO Copay activity to report" Q
 F N=0:0 S N=$O(^PSRX(DA,"COPAY",N)) Q:'N  S P1=^(N,0),DTT=P1\1 D DAT^PSORXVW1 D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=N_"   "_DAT_"    ",$P(RN," ",21)=" ",REA=$P(P1,"^",2),REA=$F("ARICE",REA)-1
 .I REA D
 ..S STA=$P("ANNUAL CAP REACHED^COPAY RESET^IB-INITIATED COPAY^REMOVE COPAY CHARGE^RX EDITED^","^",REA)
 ..S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA_$E(RN,$L(STA)+1,21)
 .E  S $P(STA," ",21)=" ",^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_STA
 .K STA,RN S $P(RN," ",15)=" ",RF=+$P(P1,"^",4)
 .S RFT=$S(RF>0:"REFILL "_RF,1:"ORIGINAL")
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_RFT_$E(RN,$L(RFT)+1,15)_$S($D(^VA(200,+$P(P1,"^",3),0)):$P(^(0),"^"),1:$P(P1,"^",3))
 .S:$P(P1,"^",5)]""!($P(P1,"^",6)]"")!($P(P1,"^",7)]"") IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Comment: "_$P(P1,"^",5)
 .I $P(P1,"^",6)]"" S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"  Old value="_$P(P1,"^",6)_"   New value="_$P(P1,"^",7)
 Q
DOSE ;displays dosing instruction for both simple and complex Rxs.
 I '$O(^PSRX(DA,6,0)) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="              Dosage: " Q
 F I=0:0 S I=$O(^PSRX(DA,6,I)) Q:'I  S DOSE=^PSRX(DA,6,I,0) D DOSE1
 K DOSE
 Q
DOSE1 ;
 I '$P(DOSE,"^",2),$P(DOSE,"^",9)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                Verb: "_$P(DOSE,"^",9)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="             *Dosage: "_$S($E($P(DOSE,"^"),1)="."&($P(DOSE,"^",2)):"0",1:"")_$P(DOSE,"^")_$S($P(DOSE,"^",3):$P(^PS(50.607,$P(DOSE,"^",3),0),"^"),1:"")
 I '$P(DOSE,"^",2),$P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Oth. Lang. Dosage: "_$G(^PSRX(DA,6,I,1))
 I $P(DOSE,"^",2),$P(DOSE,"^",9)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                Verb: "_$P(DOSE,"^",9)
 I $P(DOSE,"^",2) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="      Dispense Units: "_$S($E($P(DOSE,"^",2),1)=".":"0",1:"")_$P(DOSE,"^",2)
 I $P(DOSE,"^",2) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                Noun: "_$P(DOSE,"^",4)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="              *Route: "_$S($P(DOSE,"^",7):$P(^PS(51.2,$P(DOSE,"^",7),0),"^"),1:"")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="           *Schedule: "_$P(DOSE,"^",8)
 I $P(DOSE,"^",5)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="           *Duration: "_$P(DOSE,"^",5)_" ("_$S($P(DOSE,"^",5)["M":"MINUTES",$P(DOSE,"^",5)["H":"HOURS",$P(DOSE,"^",5)["L":"MONTHS",$P(DOSE,"^",5)["W":"WEEKS",1:"DAYS")_")"
 I $P(DOSE,"^",6)]"" S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="        *Conjunction: "_$S($P(DOSE,"^",6)="A":"AND",$P(DOSE,"^",6)="T":"THEN",$P(DOSE,"^",6)="E":"EXCEPT",1:"")
 Q
 ;
DATE(RX,RFL) ;
 I $G(PSXTST)=3,$G(PSXTCAN)'="" Q PSXTCAN
 I $G(PSXTST)=1 Q $G(PSXRDT)
 I $G(PSXTST)=3,'RFL,$$GET1^DIQ(52,RX,32.1,"I") Q $$FMTE^XLFDT($$GET1^DIQ(52,RX,32.1,"I"),2)
 I $G(PSXTST)=3,RFL,$$GET1^DIQ(52.1,RFL_","_RX,5,"I") Q $$FMTE^XLFDT($$GET1^DIQ(52.1,RFL_","_RX,32.1,"I"),2)
 Q $G(PSXTRDT)
 ;
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
