PSOLBL2 ;BIR/SAB-LABEL OUTPUT CONT. ;11/18/92 19:15
 ;;7.0;OUTPATIENT PHARMACY;**16,19,30,71,92,117,135,326,367**;DEC 1997;Build 62
 ;External reference to ^PS(51 supported by DBIA 2224
 ;External reference to ^PS(54 supported by DBIA 2227
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^DPT supported by DBIA 3097
 ;External reference to GMRADPT supported by DBIA 10099
 I $P($G(^PSRX(RX,"SIG")),"^",2) K SGY D ^PSOLBL3 G SIGOLD
 D SIG
QUIT K SIG,E,F,S Q
SIG K OT S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""
 .I $D(^PS(51,"A",X)) D
 ..I $P($G(^PS(55,DFN,"LAN")),"^") S OT=$O(^PS(51,"B",X,0)) I OT,$P($G(^PS(51,OT,4)),"^")]"" S X=$P(^PS(51,OT,4),"^") K OT Q
 ..S %=^PS(51,"A",X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG," ",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_X_" "
 S X="",SGC=1 F J=1:1 S Z=$P(SGY," ",J) S:Z="" SGY(SGC)=X Q:Z=""  S:$L(X)+$L(Z)'<$S($P(PSOPAR,"^",28):46,1:34) SGY(SGC)=X,SGC=SGC+1,X="" S X=X_Z_" "
SIGOLD I '$P(PSOPAR,"^",28) D  K NHC
 .K DIC,DR,DIQ,NHC S DIC=2,DA=DFN,DR=148,DIQ="NHC",DIQ(0)="I"
 .D EN^DIQ1 K DIC,DR,DIQ
 .I NHC(2,DFN,148,"I")="Y"!($P($G(^PS(55,DFN,40)),"^")) S SGC=SGC+1,SGY(SGC)="Expiration:________ Mfg:_________"
 ;
DPT S X=$S($D(^DPT(DFN,0))#2:^(0),1:""),DOB=$P(X,"^",3),L=$E(X,1)
 S Y=$P(X,"^",9),PNM=$P(X,"^") D PID^VADPT S SS="",SSNP=""
 I $P(PSOPAR,"^",28) K SIG,E,F,S Q
GMRA X "N X S X=""GMRADPT"" X ^%ZOSF(""TEST"") Q" I '$T S (INT(1),INT(2),INT(3))="" Q
 S GMRA="0^1^111" D ^GMRADPT S I1=1,INT(1)="ALLERGIES: ",(INT(2),INT(3))="" F I=0:0 S I=$O(GMRAL(I)) Q:I'>0  S AL=$P(GMRAL(I),U,2) S:$L(INT(I1))+$L(AL)>42 I1=I1+1,INT(I1)="" S INT(I1)=INT(I1)_AL_", "
 ;K GMRA,GMRAL Q
 Q
SIGPH S SIGPH=SIG,X="",SGCPH=1 F J=1:1:100 S Z=$P(SIGPH," ",J) S:Z="" SIGPH(SGCPH)=X S:$L(X)+$L(Z)'<34 SIGPH(SGCPH)=X,SGCPH=SGCPH+1,X="" S X=X_Z_" "
 Q
WARN W:'$G(PSOBLALL) @IOF W ?54,PNM,!,?54,"Rx# ",RXN,!,?54,DRUG,!,?54,"DRUG WARNING:" S DIWL=55,DIWR=100,DIWF="W" F WW=1:1 Q:$P(WARN,",",WW,99)=""  S PSOWARN=$P(WARN,",",WW) D:$D(^PS(54,PSOWARN,0))
 .K ^UTILITY($J,"W") F AA=0:0 S AA=$O(^PS(54,PSOWARN,1,AA)) Q:'AA  S X=^(AA,0) D ^DIWP D ^DIWW
 K WW,PSOWARN,AA W:$G(PSOBLALL) @IOF Q
REP ;LEFT SIDE ONLY REPRINT FOR NEW LABEL STOCK
 K PSOSTLK,ZTKDRUG I $L($T(PSOSTALK^PSOTALK1)) D PSOSTALK^PSOTALK1 S PSOSTLK=1 ; PRINT SCRIPTALK LABEL IF APPLICABLE
 S ZTKDRUG="XXXXXX   SCRIPTALK RX   XXXXXX"
 S Y=DATE X ^DD("DD") S DATE=Y S TECH="("_$S($P($G(^PSRX(+$G(RX),"OR1")),"^",5):$P($G(^PSRX(+$G(RX),"OR1")),"^",5),1:$P(RXY,"^",16))_"/"_$S($G(VRPH)&($P(PSOPAR,"^",32)):VRPH,1:" ")_")"
 S PSZIP=$P(PS,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 W "VAMC ",$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP),?102,"(REPRINT)" W:$G(RXP) "(PARTIAL)" W !,$P(PS2,"^",2),"  ",$P(PS,"^",3),"-",$P(PS,"^",4),"   ",TECH
 W !,"Rx# ",RXN,"  ",DATE,"  Fill ",RXF+1," of ",1+$P(RXY,"^",9),!,PNM
 F DR=1:1 Q:$G(SGY(DR))=""  D:DR=4!(DR=7)!(DR=10)!(DR=13)  W !,$G(SGY(DR))
 .F GG=1:1:27 W !
 I DR>4 S KK=$S(DR=5!(DR=8)!(DR=11):2,(DR=6)!(DR=9)!(DR=12):1,1:0) I KK F HH=1:1:KK W !
 I DR=2 W !!
 I DR=3 W !
 W ! S PSDU=$P($G(^PSDRUG($P($G(^PSRX(RX,0)),"^",6),660)),"^",8) W $G(PHYS),!,"Qty: "_$G(QTY),"  ",$G(PSDU),$S($G(PSDU)="":"      ",1:" "),$S($G(NURSE):"Mfg______Exp______",1:"")
 I $G(PSOSTLK) W !,$S($G(PSOTALK)&('$G(PSOTREP)):ZTKDRUG,1:DRUG)
 I '$G(PSOSTLK) W !,DRUG
 K PSDU W !!,$P(PS,"^",2),!,$P(PS,"^",7),", ",STATE,"  ",$G(PSOHZIP),!!!!,"FORWARDING SERVICE REQUESTED",!
 I "C"[$E(MW) W ?21,"CERTIFIED MAIL",!
 E  W !
 W !,$S($G(PS55)=2:"***DO NOT MAIL***",1:"***CRITICAL MEDICAL SHIPMENT***")
 ;
 ; Printing FDA Medication Guide (if there's one)
 I $$MGONFILE^PSOFDAUT(+$G(RX)) D
 . W ?83,"Read FDA Med Guide"
 . I $G(REPRINT),'$D(RXRP(RX,"MG")) Q 
 . N FDAMG S FDAMG=$$PRINTMG^PSOFDAMG(RX,$P($G(PSOFDAPT),"^",2))
 ;
 W !!!,PNM,!,$S($D(PSMP(1)):PSMP(1),1:VAPA(1)),!,$S($D(PSMP(2)):PSMP(2),$D(PSMP(1)):"",1:$G(ADDR(2))),!,$S($D(PSMP(3)):PSMP(3),$D(PSMP(1)):"",1:$G(ADDR(3))),!,$S($D(PSMP(4)):PSMP(4),$D(PSMP(1)):"",1:$G(ADDR(4)))
 W @IOF Q
MUL ;
 I $G(PSOBARS),$P($G(PSOPAR),"^",19) W:J=1 !!! W:J=2 !
 E  W:J=1 !!!!!!!!! W:J=2 !!!!!!!! W:J=3 !!!!!! W:J=4 !!!! W:J=5 !!
 W !,"Use the label above to mail the computer",!,"copies back to us. Apply enough postage",!,"to your envelope to ensure delivery."
 Q
MULT W !,"Use the label above to mail the computer",?54,"(",PSLN,")",!,"copies back to us. Apply enough postage",?60,"PATIENT'S SIGNATURE   "_$E(DT,4,5),"/",$E(DT,6,7),"/",($E(DT,1,3)+1700),!,"to your envelope to ensure delivery."
 Q
PRINT S (PSONOPR,PSOWSTOP,PSOASTOP)=0 F CCC=1:1 Q:$G(PSONOPR)  D
 .W ?54,$G(^TMP($J,"PSOWPT",CCC)) S:'$O(^(CCC)) PSOWSTOP=1
 .W ?102,$G(^TMP($J,"PSOAPT",CCC)),! S:'$O(^(CCC)) PSOASTOP=1
 .I PSOWSTOP,PSOASTOP S PSONOPR=1
 K ^TMP($J,"PSOWARN"),^TMP($J,"ALWA"),^TMP($J,"PSOWPT"),^TMP($J,"PSOAPT"),PSONKA,PSONULL,WWW,GMRA,GMRAL,PSOWARN,JJJ,WCNT,RRR,ALG,ALCNT,EEE,FFF,PSOLG,PSOLGA,PSORY,CCC,PSONOPR,PSOWSTOP,PSOASTOP W @IOF
 Q
KILL K PSCLN,DATE,DR,RXY,RFLMSG,COPIES,DRUG,LMI,LINE,INT,ISD,I1,MW,STATE,SIDE,SGY,PATST,PRTFL,PHYS,SGC,VRPH,NLWS,Y,TECH,LFLDT,EXPDT,COPAYVAR,NURSE,X,X1,X2,PSCAP,LOT,DIFF,DAYS,ZZ,GG,HH,KK,ULN,PSZIP,PSOHZIP,PSOPROV,PSMP,REPRINT,PS55,PS55X
 K PSOLBLDR,PSOLBLPS,OSIG,OSGY
 Q
TRAIL I $P(^PS(59,PSOSITE,1),"^",28) D ^PSOLBLN2
 D:'$P(^PS(59,PSOSITE,1),"^",28) ^PSOLBLS I $D(^TMP($J,"PSOCP",DFN)),'$P(^PS(59,PSOSITE,1),"^",28) D INV^PSOCPE
 K RXPI,PSORX,RXP,PSOIOS,PSOLAPPL,XXX,TECH,COPAYVAR,PHYS,MFG,NURSE,STATE,SIDE,COPIES,EXDT,ISD,PSOINST,RXN,RXY,VADT,DEA,WARN,FDT,QTY,PARST,PDA,PS,PS1,PS2,PSL,PSNP,INRX,RR,XTYPE,SSNP,PNM,ADDR,PSODBQ,PSOLASTF
 K ^TMP($J,"PSOCP",+$G(PSOCPN)),PSDFNFLG,PSOLAPPL
 I '$G(PSOBLALL) K PSOCPN,PSOLBLCP
 Q
