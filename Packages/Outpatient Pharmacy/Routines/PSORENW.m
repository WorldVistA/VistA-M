PSORENW ;BIR/SAB-renew main driver ;4/25/07 8:42am
 ;;7.0;OUTPATIENT PHARMACY;**11,27,30,46,71,96,100,130,148,206**;DEC 1997;Build 39
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references L, UL, PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to LK^ORX2 and ULK^ORX2 supported by DBIA 867
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to MAIN^TIUEDIT supported by DBIA 2410
 ;
ASK ;
 K PSORENW("FILL DATE") D FILLDT^PSODIR2(.PSORENW) S:$G(PSORENW("DFLG")) VALMSG="Renew Rx request canceled",VALMBCK="R"
 I PSORENW("DFLG")!('$D(PSORENW("FILL DATE"))) S PSORENW("QFLG")=1,PSORENW("DFLG")=0 G ASKX
 S PSORNW("FILL DATE")=PSORENW("FILL DATE")
 D MW^PSOCMOPA(.PSORENW)
 I PSORENW("DFLG") S PSORENW("QFLG")=1,PSORENW("DFLG")=0 G ASKX
 S PSORNW("MAIL/WINDOW")=PSORENW("MAIL/WINDOW") S PSORX("MAIL/WINDOW")=$S(PSORENW("MAIL/WINDOW")="M":"MAIL",1:"WINDOW")
 D NOORE^PSONEW(.PSORENW) S:$G(PSORENW("DFLG")) VALMSG="Renew Rx request canceled",VALMBCK="R"
 I PSORENW("DFLG")!('$D(PSORENW("FILL DATE"))) S PSORENW("QFLG")=1,PSORENW("DFLG")=0
ASKX Q
 ;
EOJ ;
 K VERB,RTE,DRET,PSOMSG,PSORNW,PSOLIST,PSORENW,PSORX("BAR CODE"),PSORX("FILL DATE"),PSODIR,PSOID,PSONOOR,PSOCOU,PSOCOUU,PSOID,PSOFDMX,PSODRUG,COPY,PSOBCKDR
 S RXN=$O(^TMP("PSORXN",$J,0)) I RXN D
 .S RXN1=^TMP("PSORXN",$J,RXN) D EN^PSOHLSN1(RXN,$P(RXN1,"^"),$P(RXN1,"^",2),"",$P(RXN1,"^",3))
 .I $P(^PSRX(RXN,"STA"),"^")=5 D EN^PSOHLSN1(RXN,"SC","ZS",$P(RXN1,"^",4))
 K RXN,RXN1,^TMP("PSORXN",$J)
 I $G(PSONOTE) D MAIN^TIUEDIT(3,.TIUDA,PSODFN,"","","","",1)
 K PSONOTE
 Q
OERR ;entry for renew backdoor
 I $$LMREJ^PSOREJU1($P(PSOLST(ORN),"^",2),,.VALMSG,.VALMBCK) Q
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK S X=PSODFN_";DPT(" D LK^ORX2 I 'Y S VALMSG="Another person is entering orders for this patient.",VALMBCK="" D UL^PSSLOCK(PSODFN) Q
 K PSOID,PSOFDMX,PSORX("FILL DATE"),PSORENW("FILL DATE"),PSORX("QS"),PSORENW("QS"),PSOBARCD,COPY
 D PSOL^PSSLOCK($P(PSOLST(ORN),"^",2)) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG D ULPAT Q
 S PSOBCKDR=1,PSOFROM="NEW",PSORENW("OIRXN")=$P(PSOLST(ORN),"^",2),PSOOPT=3,(PSORENW("DFLG"),PSORENW("QFLG"),PSORX("DFLG"))=0
 S PSONEW("DAYS SUPPLY")=$P(^PSRX(PSORENW("OIRXN"),0),"^",8),PSONEW("# OF REFILLS")=$P(^(0),"^",9)
 D FULL^VALM1,ASK D:PSORENW("QFLG") KLIB^PSORENW1 D:PSORENW("QFLG") ULPAT D:PSORENW("QFLG") PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) G:PSORENW("QFLG") EOJ D ^PSORENW0
 D ULPAT,EOJ,KLIB^PSORENW1 K PSOOPT,PSONEW,PSORX("DFLG")
 Q
ULPAT K PSOMSG D UL^PSSLOCK(PSODFN) S X=PSODFN_";DPT(" D ULK^ORX2
 Q
RENEW(PLACER,PSOCPDRG) ;passes flag to CPRS for front door renews
 ;-1=couldn't find order, 0=unable to renew, 1=renewable
 ;Placer=Pharmacy number
 N PSOSURX,PSORFRM,PSOLC,PSODRG,PSODRUG0,RXN,ST,PSONEWOI,PSOOLDOI,PSOIFLAG,PSOINA
 I $G(PLACER)["S"!('$G(PLACER)) Q "-1^Not a Valid Outpatient Medication Order."
 S RXN=PLACER I '$D(^PSRX(RXN,0)) Q "-1^Not a Valid Outpatient Medication Order."
 S RX0=^PSRX(RXN,0),PSODRG=+$P(^PSRX(RXN,0),"^",6),ST=+^("STA"),PSODRUG0=^PSDRUG(PSODRG,0)
 S PSOIFLAG=0,PSOOLDOI=+$P($G(^PSRX(RXN,"OR1")),"^"),PSONEWOI=+$P($G(^PSDRUG(+$G(PSODRG),2)),"^") I PSONEWOI,PSONEWOI'=PSOOLDOI S PSOIFLAG=1
 S PSOINA=$P($G(^PS(50.7,PSONEWOI,0)),"^",4)
 I PSOINA,DT>PSOINA Q "0^This Orderable Item has been Inactivated."
 I ST=5 S PSOSURX=$O(^PS(52.5,"B",RXN,0)) I PSOSURX,$P($G(^PS(52.5,PSOSURX,0)),"^",7)="L" Q "0^Rx loading into a CMOP Transmission."
 S X1=DT,X2=-120 D C^%DTC I $P($G(^PSRX(RXN,2)),"^",6)<X Q "0^Prescription Expired more than 120 Days."
 S X1=DT,X2=-120 D C^%DTC I $P($G(^PSRX(RXN,3)),"^",5),$P($G(^(3)),"^",5)<X,$P(^("STA"),"^")=12 Q "0^Prescription Discontinued more than 120 Days."
 I $G(PSOCPDRG),$G(PSOCPDRG)'=$G(PSODRG) Q "0^Drug Mismatch, Non-Renewable."
 N PSOOCPRX,PSOOLPF,PSOOLPD,PSONOSIG S PSOOCPRX=RXN D CDOSE^PSORENW0 I PSOOLPF Q "0^Non-Renewable, invalid Dosage of "_$G(PSOOLPD)
 I PSONOSIG Q "0^Non-Renewable, missing Sig."
 I $P($G(^PSDRUG(PSODRG,2)),"^",3)'["O" Q "0^Drug is No longer used by Outpatient Pharmacy."
 I $G(^PSDRUG(PSODRG,"I"))]"",DT>$G(^("I")) Q "0^This Drug has been Inactivated."
 I ($P(PSODRUG0,"^",3)[1)!($P(PSODRUG0,"^",3)[2)!($P(PSODRUG0,"^",3)["W") Q "0^Non-Renewable "_$S($P(PSODRUG0,"^",3)["A":"Drug Narcotic.",1:"Drug.")
 I $D(^PS(53,+$P(RX0,"^",3),0)),'$P(^(0),"^",5) Q "0^Non-Renewable Prescription."
 S PSOLC=$P(RX0,"^"),PSOLC=$E(PSOLC,$L(PSOLC)) I $A(PSOLC)'<90 Q "0^Max number of renewals (26) has been reached."
 I ST,ST'=2,ST'=5,ST'=6,ST'=11,ST'=12,ST'=14 Q "0^Prescritpion is in a Non-Renewable Status."
 I $P($G(^PSRX(RXN,"OR1")),"^",4) Q "0^Duplicate Rx Renewal Request."
 I $O(^PS(52.41,"AQ",RXN,0)) Q "0^Duplicate Rx Renewal Request."
 K PSORFRM,PSOLC,PSODRG,PSODRUG0,RXN,ST
 Q 1_$S($G(PSOIFLAG):"^"_$G(PSONEWOI),1:"")
 ;
INST1 ;Set Pharmacy Instructions array
 N PSOTZ
 I $O(^PSRX(RXN,"PI",0)) S PHI=$G(^PSRX(RXN,"PI",0)),PSOTZ=0 D
 .F  S PSOTZ=$O(^PSRX(RXN,"PI",PSOTZ)) Q:PSOTZ=""  S PHI(PSOTZ)=$G(^PSRX(RXN,"PI",PSOTZ,0))
 Q
INST2 ;Set Instructions and Comments
 I '$G(PSORENW("OIRXN")) Q
 I $G(PSOFDR) Q
 N PSOPHL,PSOPRL
 I $O(^PSRX(PSORENW("OIRXN"),"PI",0)) K PHI S PHI=$G(^PSRX(PSORENW("OIRXN"),"PI",0)),PSOPHL="" D
 .F  S PSOPHL=$O(^PSRX(PSORENW("OIRXN"),"PI",PSOPHL)) Q:PSOPHL=""  S PHI(PSOPHL)=$G(^PSRX(PSORENW("OIRXN"),"PI",PSOPHL,0))
 I $O(^PSRX(PSORENW("OIRXN"),"PRC",0)) K PRC S PRC=$G(^PSRX(PSORENW("OIRXN"),"PRC",0)),PSOPRL="" D
 .F  S PSOPRL=$O(^PSRX(PSORENW("OIRXN"),"PRC",PSOPRL)) Q:PSOPRL=""  S PRC(PSOPRL)=$G(^PSRX(PSORENW("OIRXN"),"PRC",PSOPRL,0))
 Q
