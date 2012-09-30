PSOLBL1 ;BHAM ISC/SAB - PRINTS LABEL ;1/20/93 14:25
 ;;7.0;OUTPATIENT PHARMACY;**107,110,225,326,367**;DEC 1997;Build 62
START S COPIES=COPIES-1
 W $C(13) S $X=0 W "VA (119)",?10,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3) W:('SIDE)&(PRTFL) ?40,"PLEASE REFER ONLY TO '",$S(REF:"1. REFILL REQUEST",1:"2. RENEWAL ORDER"),"'" W:+$G(RXP) ?100,"(PARTIAL)" W:$D(REPRINT) ?110,"(REPRINT)"
 W !,$P(PS,"^",2) W:('SIDE)&(PRTFL) ?40,"INSTRUCTION ON REVERSE SIDE OF THIS FORM" W:'SIDE ?102,"(Filled at ",$P(PS2,"^",2),")"
 W !,$P(PS,"^",7),", ",STATE,"  ",$P(PS,"^",5) W:'SIDE ?83,"*** ",$P(PS2,"^")," ***"
 W !,?22,$S(MW["C":"CERTIFIED MAIL",1:"") W:'SIDE ?38,SSNP,?69,"RX: ",RXN
 W !,?2,PNM W:'SIDE ?38,PNM,?64,"EXPIRES: ",EXDT W:('SIDE)&(PRTFL) ?83,"INDICATE ANY ADDRESS CHANGES"
 W !,?2,$S($D(PSMP(1)):PSMP(1),1:VAPA(1)) W:'SIDE ?38,$E(VAPA(1),1,25),?64,"REFILLS: ",REF ;W:('SIDE)&(PRTFL) ?83,LINE 
 W:('SIDE)&(PRTFL) ?83,"_____PERM.   _____TEMP." W:'PRTFL ?83,"* A 'NEW' RX IS REQUIRED.        *"
 S ADDR(3)=VAPA(4)_", "_$P($G(^DIC(5,+$P(VAPA(5),"^"),0)),"^",2)_"  "_VAPA(6),ADDR(2)="" S:VAPA(2)]"" ADDR(2)=VAPA(2)_" "_VAPA(3)
 I ADDR(2)="" S ADDR(2)=ADDR(3),ADDR(3)=""
 S ADDR(5)=$E(VAPA(4),1,13)_", "_$P($G(^DIC(5,+$P(VAPA(5),"^"),0)),"^",2)_"  "_VAPA(6)
 W !,?2,$S($D(PSMP(2)):PSMP(2),$D(PSMP(1)):"",1:$E(ADDR(2),1,35)) W:'SIDE ?38,$S($G(ADDR(3))="":ADDR(5),1:$E(ADDR(2),1,24)),?62,$S(RFLMSG]"":"*",1:" "),"LST FILL: "
 W:'SIDE $G(PSOLASTF)
 I 'SIDE W:PRTFL ?83,"ADDRESS: ",$E(LINE,1,23) W:'PRTFL ?83,"********** PLEASE NOTE ***********"
 W !,?2,$S($D(PSMP(3)):PSMP(3),$D(PSMP(1)):"",1:ADDR(3)) I 'SIDE W ?38,$S(ADDR(3)'="":ADDR(5),1:""),?64,"ROUTING: ",$S(MW="REGULAR":"MAIL",1:MW) W:PRTFL ?83,"CITY/STATE/ZIP: ",$E(LINE,1,16) W:'PRTFL ?83,"* THIS RX CAN NOT BE 'RENEWED'.  *"
 ;NEW LABEL WHITE SPACE
 I +$G(PSOBARS),'SIDE,$P(PSOPAR,"^",19)'=1 S X="S",X2=PSOINST_"-"_RX W !,?40 S X1=$X W @PSOBAR1,X2,@PSOBAR0,$C(13),!,$S($G(PS55)=2:"***DO NOT MAIL***",1:"**CRITICAL MEDICAL SHIPMENT**")
 E  F NLWS=1:1:5 W ! W:NLWS=5 $S($G(PS55)=2:"***DO NOT MAIL***",1:"**CRITICAL MEDICAL SHIPMENT**")
 ; Printing FDA Medication Guide (if there's one)
 I $$MGONFILE^PSOFDAUT(RX) D
 . W ?83,"Read FDA Med Guide"
 . I $G(REPRINT),'$D(RXRP(RX,"MG")) Q 
 . N FDAMG S FDAMG=$$PRINTMG^PSOFDAMG(RX,$P($G(PSOFDAPT),"^",2))
 W !
 ;
 W !,?8,"VA Medical Center" I 'SIDE W ?38,INT(1)
 W !,$P(PS,"^"),"  ",$P(PS,"^",3),"-",$P(PS,"^",4) W:'SIDE ?38,INT(2) I 'SIDE W:PRTFL ?83 W:'PRTFL ?83,"* PLEASE CONTACT YOUR PHYSICIAN. *"
 W !,?4,RXN,?15,$E(DATE,4,5),"/",$E(DATE,6,7),"/",$E(DATE,2,3),"   (",RXF+1," OF ",1+$P(RXY,"^",9),")" I 'SIDE W ?38,INT(3) W:(PRTFL)&('REF) ?83,"***** FOR PHYSICIAN USE ONLY *****" W:'PRTFL ?83,"**********************************"
 W !,PNM,?29,"#",$P(RXY,"^",7)
 W:'SIDE ?38,"CAP: ",$S(PSCAP:"**NON-SFTY**",1:"SAFETY")," WARN:",WARN,?68,$E(DATE,4,5),"/",$E(DATE,6,7),"/",$E(DATE,2,3)," " S I1=$P($H,",",2)\60 W:'SIDE I1\60,":",(I1#60\10)_(I1#10) W:('SIDE)&(PRTFL) ?83,"SIGNATURE : ",$E(LINE,1,20)
SIG F DR=1:1:$S(SGC<5:4,1:6) D SIG1
 I SGC>4 F I=1:1:22 W ! I I>22-SGC S DR=DR+1,X=$S($D(SGY(DR)):SGY(DR),1:"") W X W:'SIDE ?38,X
 ;I SGC>4 F I=1:1:$S($P($G(PSOPAR),"^",10):22,1:16) W ! I I>($S($P($G(PSOPAR),"^",10):28,1:22)-SGC) S DR=DR+1,X=$S($D(SGY(DR)):SGY(DR),1:"") W X W:'SIDE ?38,X
 W !?3,$E(PHYS,1,14),?25,"(",$P(RXY,"^",16),"/",$S($D(VRPH):VRPH,1:" "),")" W:'SIDE ?38,DRUG,?38+$L(DRUG)," (QTY:",$P(RXY,"^",7)," DAYS:",$P(RXY,"^",8)," FILL: ",RXF+1," OF ",1+$P(RXY,"^",9)," ISD:",ISD,")"
 W !,DRUG W:'SIDE ?38,PHYS,?62,RFLMSG,?100,PATST,"  ",PSCLN
 I $D(PSOBARS),PSOBARS W $C(13),# S $X=0
 E  W !
 I COPIES>0 S SIDE=1 G START
 ;STORE LABEL PRINT NODE
 D NOW^%DTC S NOW=% K %,%H,%I S RXF=0 F I=0:0 S I=$O(^PSRX(RX,1,I)) Q:'I  S RXF=I
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(RX,"L",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 S ^PSRX(RX,"L",IR,0)=NOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_$S($G(PCOMX)]"":$G(PCOMX),1:"From RX number "_$P(^PSRX(RX,0),"^"))_$S($G(RXP):" (Partial)",1:"")_$S($D(REPRINT):" (Reprint)",1:"")_"^"_PDUZ
 ;Storing FDA Medication Guide filename in the Prescription file
 I $$MGONFILE^PSOFDAUT(RX) D
 . I $G(RXRP(RX)),'$G(RXRP(RX,"MG")) Q
 . S ^PSRX(RX,"L",IR,"FDA")=$P($$MGONFILE^PSOFDAUT(RX),"^",2)
 S ^PSRX(RX,"TYPE")=0 K RXF,IR,FDA,NOW,I
 I '$D(PSSPND),$P(PSOPAR,"^",18) D CHCK2^PSOTRLBL
END K PSCLN,%DT,ADDR,DATE,DEA,DR,DR1,DRX,DRUG,FDT,SGY,RXY,RXZ,RYY,RFLMSG,RFL,%H,COPIES,DOB,DRUG,LIM,LMI,LINE,PS,PS1,PS2,INT,ISD,I1,MW,MAIL,STATE,SIDE,SSNP,SS,ST,ST1,PATST,PRTFL,PHYS,PNM,S,SL,SGC,PSMP,PSI,PSJ,VRPH,REPRINT,PS55,PS55X Q
 Q
 ;
SIG1 S X=$S($D(SGY(DR)):SGY(DR),1:"") W !,X
 I 'SIDE W ?38,X I PRTFL W ?83 W:DR=1 ?83,$S('REF:"PRINT NAME: "_$E(LINE,1,25),1:"") W:DR=2 "DATE: ",$E(LINE,1,10) W:(DR=2)&('REF) " DEA# ",$E(LINE,1,6) W:(DR=3)&('REF) "Refills: 0 1 2 3 4 5 6 7 8 9 10 11"
 Q
 ;
OSET I $G(RXFL(RX))']""!($G(RXFL(RX))=0) D  Q
 .S TECH=$P($G(^VA(200,+$P(^PSRX(RX,0),"^",16),0)),"^"),QTY=$P(^PSRX(RX,0),"^",7),PHYS=$S($D(^VA(200,+$P(^PSRX(RX,0),"^",4),0)):$P(^(0),"^"),1:"UKN") D 6^VADPT,PID^VADPT S SSNPN=""
 .S DAYS=$P(^PSRX(RX,0),"^",8),MFG="________",LOT="________"
 I '$D(^PSRX(RX,1,RXFL(RX),0)) K RXFL(RX) Q
 S TECH=$S($D(^VA(200,+$P(^PSRX(RX,1,RXFL(RX),0),"^",7),0)):$P(^(0),"^"),1:"UNKNOWN")
 S QTY=$P(^PSRX(RX,1,RXFL(RX),0),"^",4),PHYS=$S($D(^VA(200,+$P(^PSRX(RX,1,RXFL(RX),0),"^",17),0)):$P(^(0),"^"),$D(^VA(200,+$P(^PSRX(RX,0),"^",4),0)):$P(^(0),"^"),1:"UNKNOWN") D 6^VADPT,PID^VADPT S SSNPN=""
 S DAYS=$P(^PSRX(RX,1,RXFL(RX),0),"^",10),LOT="________",MFG="________"
 Q
