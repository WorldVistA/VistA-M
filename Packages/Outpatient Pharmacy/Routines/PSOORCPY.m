PSOORCPY ;BIR/SAB-copy orders from backdoor ;Oct 20, 2022@15:12
 ;;7.0;OUTPATIENT PHARMACY;**10,21,27,32,46,100,117,148,313,411,444,468,504,477,441,545,700,753,770**;DEC 1997;Build 145
 ;External reference to LK^ORX2 supported by DBIA 867
 ;External reference to ULK^ORX2 supported by DBIA 867
 ;External reference to ^PSDRUG( supported by DBIA 221
 ;External reference to L^PSSLOCK supported by DBIA 2789
 ;External reference to UL^PSSLOCK supported by DBIA 2789
 ;External reference to PSOL^PSSLOCK supported by DBIA 2789
 ;External reference to PSOUL^PSSLOCK supported by DBIA 2789
 ;
 ; Cleaning up Titration/Maintenance variables (they shouldn't be defined - just to be safe)
 K PSOMTFLG,PSOTITRX,PSOSIGFL
COPY ; Rx Copy Functionality
 N PSORXIEN,PSOCHECK,PSOGOOUT,PSODEAUP,PSODRGIEN
 S PSORXIEN=+$P($G(PSOLST(ORN)),"^",2)
 ; Checking whether the Provider still qualifies as prescriber for the renewed Rx
 S PSOCHECK=$$CHKRXPRV^PSOUTIL(PSORXIEN)
 I 'PSOCHECK&(($P(PSOCHECK,U,4)'=1)&($P(PSOCHECK,U,4)'=2)) S VALMSG=$P(PSOCHECK,"^",2),VALMBCK="R" W $C(7) Q
 ;I $G(PSODRUG("DEA")) D  Q:'$L($G(PSORXED("DEACOPY")))
 S PSODRGIEN=$$GET1^DIQ(52,PSORXIEN,6,"I")
 I $$DRUGSCHD^PSOUTIL(PSODRGIEN) D
 . N PSDRGIEN S PSDRGIEN=$$GET1^DIQ(52,PSORXIEN,6,"I")
 . D FULL^VALM1 S PSODEAUP=$$SLDEA^PSODIR($P($G(^PSRX(PSORXIEN,0)),U,4),.PSORX,$$RXDEA^PSOUTIL(PSORXIEN),PSDRGIEN)
 . I $L($G(PSODEAUP)) S PSORXED("DEACOPY")=PSODEAUP D PAUSE^VALM1 Q
 . N PSODIR,PSORX S PSODIR("CS")=1 D PROV^PSODIR(.PSODIR)
 . I $G(PSODIR("PROVIDER"))&$L($G(PSORX("RXDEA"))) D  Q
 .. S PSORXED("PROVIDER")=PSODIR("PROVIDER"),PSORXED("DEACOPY")=PSORX("RXDEA")
 . I 'PSOCHECK S VALMSG=$P(PSOCHECK,"^",2),VALMBCK="R" W $C(7) D PAUSE^VALM1
 I $$LMREJ^PSOREJU1(PSORXIEN,,.VALMSG,.VALMBCK) Q
 ;I '$G(PSOMTFLG),$$TITRX^PSOUTL(PSORXIEN)="t" S VALMSG="Cannot Copy a 'Titration Rx'.",VALMBCK="" W $C(7) Q ;p441
 I $G(PSOBEDT) W $C(7),$C(7) S VALMSG="Invalid Action at this time !",VALMBCK="" Q
 I $G(PSONACT) W $C(7),$C(7) S VALMSG="No Pharmacy Orderable Item !",VALMBCK="" K PSOCOPY D ^PSOBUILD Q
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK S X=PSODFN_";DPT(" D LK^ORX2 I 'Y S VALMSG="Another person is entering orders for this patient.",VALMBCK="" D UL^PSSLOCK(PSODFN) Q
 D PSOL^PSSLOCK(PSORXIEN) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG G EX
 N VALMCNT K PSOEDIT S (PSOCOPY,COPY,PSORXED,ZZCOPY)=1 D FULL^VALM1
 S PSORXED("DFLG")=0,(RXN,DA,PSORXED("IRXN"))=PSORXIEN,PSORXED("RX0")=^PSRX(PSORXED("IRXN"),0),PSORXED("RX2")=$G(^(2)),PSORXED("RX3")=$G(^(3)),PSOI=$P($G(^("OR1")),"^"),PSOSIG=$P($G(^("SIG")),"^"),STAT=+^("STA")
 S PSORXED("RX7")=$G(^PSRX(PSORXED("IRXN"),7)) ;p753
 S PSORXED("INS")=$G(^PSRX(PSORXED("IRXN"),"INS"))
 S:$G(^PSRX(PSORXED("IRXN"),"INSS"))]"" PSORXED("SINS")=^PSRX(PSORXED("IRXN"),"INSS")
 S D=0 F  S D=$O(^PSRX(PSORXED("IRXN"),"INS1",D)) Q:'D  S PSORXED("SIG",D)=^PSRX(PSORXED("IRXN"),"INS1",D,0)
 I '$O(PSORXED("SIG",0)),$G(PSORXED("INS"))]"" S PSORXED("SIG",1)=PSORXED("INS")
 ;441-IND
 S PSORXED("IND")=$P($G(^PSRX(PSORXED("IRXN"),"IND")),"^"),PSORXED("INDF")=$P($G(^PSRX(PSORXED("IRXN"),"IND")),"^",2)
 S:$P($G(^PS(55,PSODFN,"LAN")),"^") PSORXED("INDO")=$P($G(^PSRX(PSORXED("IRXN"),"IND")),"^",3)
 I $G(^PSRX(PSORXED("IRXN"),"TN"))]"" S PSODRUG("TRADE NAME")=^PSRX(PSORXED("IRXN"),"TN")
 ;
 ; - This call copies the dosage into the new order and also split the Maintenance dose (if the case)
 D BLDDOSE(.PSORXED,$G(PSOMTFLG)) G OUT:$G(PSOGOOUT)
 ;
 I $G(^PSDRUG($P(PSORXED("RX0"),"^",6),"I"))]"",^("I")<DT S VALMSG=$S('$G(PSOMTFLG):"Cannot COPY. ",1:"")_"This drug has been inactivated!" S VALMBCK="R" G OUT
 I $P(^PSDRUG($P(PSORXED("RX0"),"^",6),2),"^",3)'["O" S VALMSG=$S('$G(PSOMTFLG):"Cannot COPY. ",1:"")_"Drug no longer used by Outpatient!",VALMBCK="R" G OUT
 ;Check for invalid Dosage
 N PSOOCPRX,PSOOLPF,PSOOLPD,PSONOSIG S PSOOCPRX=PSORXED("IRXN") D CDOSE^PSORENW0
 I PSOOLPF D  S VALMBCK="R" G OUT
 .S VALMSG=$S('$G(PSOMTFLG):"Cannot COPY. ",1:"")_"Invalid Dosage of "_$G(PSOOLPD)
 I PSONOSIG D  S VALMBCK="R" G OUT
 .S VALMSG=$S('$G(PSOMTFLG):"Cannot COPY. ",1:"")_"Missing Sig"
 ; 
 S PSORXED("MAIL EXEMPTION")=$P($G(PSORXED("RX7")),"^",2) ;p753
 ;
 I '$P($G(^PSDRUG($P(PSORXED("RX0"),"^",6),2)),"^") S VALMBCK="R" G OUT
 S DREN=$P(PSORXED("RX0"),"^",6),PSODAYS=$P(PSORXED("RX0"),"^",8)
 ; Checks if the current Days Supply value is greater than the Maximum Days Supply for the Drug
 I '$G(PSOMTFLG) D
 . S PSORXED("DAYS SUPPLY")=$P(PSORXED("RX0"),"^",8),PSORXED("QTY")=$P(PSORXED("RX0"),"^",7)
 . D DAYSUP^PSOUTIL(DREN,.PSORXED,1)
 S PSORXST=+$P($G(^PS(53,$P(PSORXED("RX0"),"^",3),0)),"^",7)
 S POERR=1 D DRG^PSOORDRG K POERR
 I $G(PSORX("DFLG")) S VALMBCK="R"
 ;
 I $G(PSOMTFLG) D  I $G(PSORXED("DFLG")) S VALMBCK="R" G OUT
 . S PSORXED("DAYS SUPPLY")=PSODAYS,PSORXED("QTY")=+$$GET1^DIQ(52,PSORXED("IRXN"),7)
 . W !!,"New Maintenance Rx (Review Quantity):",!,"Drug: ",$$GET1^DIQ(52,PSORXED("IRXN"),6)
 . D EN^PSOFSIG(.PSORXED,1) W !,"Days Supply: ",PSODAYS
 . N PSOQTY S PSORXED("FLD")=5 D QTY^PSODIR1(.PSORXED) W !
 ;
 D EN^PSOORED1(.PSORXED) I $G(PSORX("FN")) S VALMBCK="Q",PSOFROM="NEW" D DCORD^PSONEW2
 E  S VALMBCK="R"
OUT ;
 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2))
 K PSOCOPY D ^PSOBUILD,ACT^PSOORNE2
EX S X=PSODFN_";DPT(" D ULK^ORX2
 D UL^PSSLOCK(PSODFN)
 K PSOMSG,PSONEW,PSOSIG,STA,DREN,PSODAYS,PSORXST,PSOCOPY,PSORXED,FST,FLD,IEN,FLN,INCOM,PSOI,COPY,SIG,SIGOK
 K PSODRUG,^TMP("PSOPO",$J),PSOMTFLG
 D CLEAN^PSOVER1,EOJ^PSONEW K ZZCOPY
 Q
 ;
LOCK ;
 I $P($G(PSOPLCK),"^")'=0 Q
 I $$GET1^DIQ(59.7,1,102,"I")="MBM",$D(^XUSEC("PSO ERX WORKLOAD RPH",DUZ)) Q
 W !!,$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2),1:"Another person")_" is working on this patient."
 K DIR S DIR(0)="E",DIR("A")="     Press Return to Continue" D ^DIR K DIR
 Q
 ;
BLDDOSE(PSORXED,MAINTRXF) ; Copies the Dose from Original Rx into Copied/Maintenance Dose Rx
 N DOSEIEN,DOSE
 ; - Copying from the last THEN conjunction (Maintenance Dose Rx)
 ; - For Titration/Maintenance, DOSEIEN = the IEN in the prescription of the last THEN conjunction.
 ; - This value is used as a "seed" for the FOR loop starting point.
 I $G(MAINTRXF) D  Q
 . D LASTTHEN
 . S PSORXED("ENT")=0
 . F  S DOSEIEN=$O(^PSRX(PSORXED("IRXN"),6,DOSEIEN))  Q:'DOSEIEN!($G(PSOGOOUT))  D
 . . S DOSE=^PSRX(PSORXED("IRXN"),6,DOSEIEN,0)
 . . I $P(DOSE,"^",6)="X" S PSOGOOUT=1,VALMSG="Cannot COPY.  Invalid 'except' conjunction!" S VALMBCK="R" Q
 . . Q:$P(DOSE,"^")']""!($P(DOSE,"^",8)']"")
 . . S PSORXED("ENT")=PSORXED("ENT")+1
 . . D SETDOSE(.PSORXED,DOSEIEN,PSORXED("ENT"))
 . . D EN^PSOFSIG(.PSORXED)
 G OUT:$G(PSOGOOUT)
 ;
 ; - Copying dose for Regular Rx Copy
 S PSORXED("ENT")=0
 F DOSEIEN=0:0 S DOSEIEN=$O(^PSRX(PSORXED("IRXN"),6,DOSEIEN)) Q:'DOSEIEN  D
 . S DOSE=^PSRX(PSORXED("IRXN"),6,DOSEIEN,0) D
 . I $P(DOSE,"^",6)="X" S PSOGOOUT=1,VALMSG="Cannot COPY. Invalid 'except' conjunction!" S VALMBCK="R" Q
 . Q:$P(DOSE,"^")']""!($P(DOSE,"^",8)']"")
 . S PSORXED("ENT")=PSORXED("ENT")+1
 . D SETDOSE(.PSORXED,DOSEIEN,PSORXED("ENT"))
 G OUT:$G(PSOGOOUT)
 Q
 ;
SETDOSE(PSORXED,DOSEIEN,DOSESEQ) ; Sets the Dose in the PSORXED array
 N DOSE
 S DOSE=^PSRX(PSORXED("IRXN"),6,DOSEIEN,0)
 S PSORXED("DOSE",DOSESEQ)=$P(DOSE,"^")
 S PSORXED("UNITS",DOSESEQ)=$P(DOSE,"^",3)
 S PSORXED("DOSE ORDERED",DOSESEQ)=$P(DOSE,"^",2)
 S PSORXED("ROUTE",DOSESEQ)=$P(DOSE,"^",7)
 S PSORXED("SCHEDULE",DOSESEQ)=$P(DOSE,"^",8)
 S PSORXED("DURATION",DOSESEQ)=$P(DOSE,"^",5)
 S PSORXED("CONJUNCTION",DOSESEQ)=$P(DOSE,"^",6)
 S PSORXED("VERB",DOSESEQ)=$P(DOSE,"^",9)
 I $G(^PSRX(PSORXED("IRXN"),6,DOSEIEN,1))]"" D
 . S PSORXED("ODOSE",DOSESEQ)=^PSRX(PSORXED("IRXN"),6,DOSEIEN,1)
 I $G(PSORXED("DURATION",DOSESEQ))]"" D  K DR,DUR1
 . S DUR1=PSORXED("DURATION",DOSESEQ)
 . S PSORXED("DURATION",DOSESEQ)=$S($E(DUR1,1)'?.N:$E(DUR1,2,99)_$E(DUR1,1),1:DUR1)
 S PSORXED("NOUN",DOSESEQ)=$P(DOSE,"^",4)
 Q
 ;
LASTTHEN ; Determine the IEN of the last THEN conjunction on this prescription and set DOSEIEN to its value.
 N LASTTHEN,LAST
 S LASTTHEN="" F  S LASTTHEN=$O(^PSRX(PSORXED("IRXN"),6,LASTTHEN),-1) Q:LASTTHEN=""!($G(DOSEIEN)'="")  D
 . S DOSEIEN=""
 . S LAST=^PSRX(PSORXED("IRXN"),6,LASTTHEN,0)
 . I $P(LAST,"^",6)="T" S DOSEIEN=LASTTHEN Q
 Q
 ;
ORCOPY(PLACER) ; Checks if an Outpatient Pharmacy order can be copied by CPRS or not
 ; Input: (r) PLACER - PRESCRIPTION (#52) IEN or PENDING OUTPATIENT ORDERS (#52.31) IEN_"S"
 ;Output: p1: -1: Error (unable to find order) / 0: Not allowed to copy / 1: OK to copy
 ;        p2: Error message (p1 = -1 or 0)
 N PSODRG,PSOINACT,RXN,PSOGOOUT,DOSEIEN
 ;
 I PLACER["S",'$D(^PS(52.41,+$G(PLACER),0)) Q "-1^Not a Valid Outpatient Medication Pending Order."
 I PLACER'["S",'$D(^PSRX(+$G(PLACER),0)) Q "-1^Not a Valid Outpatient Medication Order."
 ;
 I PLACER["S" S PSODRG=+$$GET1^DIQ(52.41,+$G(PLACER),11,"I") I 'PSODRG Q 1  ; No Dispense Drug
 I PLACER'["S" S PSODRG=+$$GET1^DIQ(52,+$G(PLACER),6,"I")
 I $$GET1^DIQ(50,PSODRG,63)'["O" Q "0^Drug is no longer used by Outpatient Pharmacy."
 S PSOINACT=$$GET1^DIQ(50,PSODRG,100,"I") I PSOINACT,DT>PSOINACT Q "0^This Drug has been Inactivated."
 I PLACER'["S",$D(^PSRX(+$G(PLACER),0)),$$CONJ^PSOUTL(+$G(PLACER)) Q "0^Cannot COPY - invalid Except conjunction"
 ;
 Q 1
