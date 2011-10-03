PSXLBLT ;BIR/HTW-CMOP Label Print..Trailer Docs ;[ 03/06/98  7:00 AM ]
 ;;2.0;CMOP;**1,13**;11 Apr 97
DOC1 ;  Print Multi-Rx documents
 I '$D(MRX) G FINAL
 S RXCT=0
DOCNEW W ?54,PNAME,"     ",SSN
 W !?54,PADD1
 W !?54,PADD2
 I $G(PADD3)]"" W !?54,$G(PADD3)
 I $G(PADD4)]"" W !?54,$G(PADD4)
 W !,?54,"Please check prescriptions to be refilled"
 F I=1:1:3 S RXCT=$O(MRX(RXCT)) Q:'RXCT  S MRX=MRX(RXCT) D
 .S RX=$P(MRX,U),TRUG=$P(MRX,U,2),REFREM=$P(MRX,U,3)
 .S EXPDT=$P(MRX,U,4),BAR=$P(MRX,U,5)
 .S EXPDT=$E(EXPDT,5,6)_"/"_$E(EXPDT,7,8)_"/"_$E(EXPDT,1,4)
 .W !,?54,"(____) ",TRUG
 .W !,?55,REFREM," ",?60,"Expires ",$G(EXPDT),"  Rx# ",RX
 .I $G(PSXBAR) S X="S",X2=BAR W !,?55 S X1=$X W @IOBARON,X2,@IOBAROFF
 W !?54,"(______________________________________)"
 W !?55,"PATIENT'S SIGNATURE   ",$E(DT,4,5),"/",$E(DT,6,7),"/",($E(DT,1,3)+1700)
 W @IOF
 I +$G(RXCT)>0 S RXCK=$O(MRX(RXCT)) I RXCK]"" K RXCK G DOCNEW
 K RXCT,RXCK,MRX,I,RX,TRUG,REFEM,EXPDT,X,X2
FINAL ;Set up Suspense Notification
 I $D(SRX) D
 .S SUS(1)=SSN
 .S SUS(2)=PNAME
 .S SUS(3)=PADD1
 .S SUS(4)=PADD2,CT=5
 .I $G(ADDR3)]"" S SUS(5)=PADD3,CT=6
 .I $G(PADD4)]"" S SUS(6)=PADD4,CT=7
 .S SUS(CT)="",CT=CT+1
 .S SUS(CT)="   The following prescriptions will be",CT=CT+1
 .S SUS(CT)="mailed to you at a future date.",CT=CT+1
 .S SUS(CT)="",CT=CT+1
 .S SUS(CT)="Rx#                   Drug",CT=CT+1
 .S SUS(CT)="============================================",CT=CT+1
 .S SUS(CT)="",CT=CT+1
 .F XX=0:0 S XX=$O(SRX(XX)) Q:'XX  D
 ..S SN=SRX(XX)
 ..S $P(PSXLGTH," ",(20-($L($P(SRX(XX),"^")))))=""
 ..S SUS(CT)=$P(SN,"^")_PSXLGTH_$P(SN,"^",2),CT=CT+1
 ..K PSXLGTH,SN
 ; Set up return address info for print
 S RAD($S($G(COPAYES):1,1:3))="Pharmacy Service (119)"
 S RAD($S($G(COPAYES):2,1:4))=SNAME
 S RAD($S($G(COPAYES):3,1:5))=SADD1
 S RAD($S($G(COPAYES):4,1:6))=SADD2
 S RAD($S($G(COPAYES):5,1:7))=SADD3
 I $G(COPAYES) F ZZZ=6:1:15 S RAD(ZZZ)=""
 I '$G(COPAYES) F ZZZ=8:1:17 S RAD(ZZZ)=""
 S RAD($S($G(COPAYES):16,1:18))="Use the label above to mail the computer"
 S RAD($S($G(COPAYES):17,1:19))="copies back to us.  Apply enough postage"
 S RAD($S($G(COPAYES):18,1:20))="to your envelope to ensure delivery."
 ;Print Return Address(Left),REF/NOREF/COPAY narr(middle),SUS(right)
 S CT=1
TOF W ?54,PNAME,"  ",SSN,"  ",$P(RNOW,"@"),!
 I $D(COPAYES),($G(PSXBAR)) S X="S",X1=$X,X2=SSN1 W ?54,@IOBARON,X2,@IOBAROFF,*13
PRINT I $G(F1),($G(F2)),($G(F3)) G EXIT
 W $G(RAD(CT)) I '$O(RAD(CT)) S F1=1
 I $G(NARR(CT))="COPAY",('$D(COPAYES)) S NARR("COPAY")="NO",F2=1
 I $G(NARR("COPAY"))="NO" G SUSP
 I $G(NARR(CT))="COPAY" G SUSP
 W ?54,$G(NARR(CT)) I '$O(NARR(CT)) S F2=1
SUSP I '$D(SUS) S CT=CT+1,F3=1 W ! G PRINT
 W ?102,$G(SUS(CT)),! I '$O(SUS(CT)) S F3=1
 S CT=CT+1
 G PRINT
EXIT K DIWF,DIWL,DIWR,Q2,Z1,Z2,XX
 K PADD1,PADD2,PADD3,PCITY,PNAME,PSTATE,PTEMP,PZIP,MAILID,W1,W2,W3,MRX
 K QTY,ID,TRUG,SPARE,REFCT,REFREM,REFLST,RX,SIG,SIG1,ADDR(2),SRX,CLINIC
 K RXCT,RFTXT,PHYS,REGMAIL,CLKRPH,FDT,COPAY,RENW,CAP,ISD,EXPDT,PSTAT,ZZT
 K TAYS,WARN,ADDR(3),LOT,MFG,NURSE,SSN,TEMP,ZX,VERPHARM,RX1,BAR,SIGN,Z
 K RESET,SSN1,SUS,ISD1,RAD,F1,F2,F3,COPAYES,NARR("COPAY"),PADD4
 W @IOF
 Q
