PSIVORLB ;BIR/MLM-PRINT OUT LABELS ; 8/5/08 9:22am
 ;;5.0; INPATIENT MEDICATIONS ;**58,184**;16 DEC 97;Build 12
 ;
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ;
ENX ;Print example label
 D FULL^VALM1
 S PSIVFLAG=1,PSIVRM=$P(PSIVSITE,U,13) S:PSIVRM<1 PSIVRM=30 D:$E(P("OT"))="I" ORFLDS^PSIVEDT1 W:$E(P("OT"))'="I" !,"Med Route: ",$P(P("MR"),U,2),!
START F PSIV1=1:1:PSIVNOL S LINE=0 D RE I '$D(PSIVFLAG) F LINE=LINE+1:1:(PSIVSITE+$P(PSIVSITE,U,16)) W !
Q K PSIVDOSE,P16,LINE,MESS,PSIVCT,PSIV2,PSIVFLAG,PSIVRM,PSIV1,PDOSE,PDATE,XX1,XX2,BAG,CX,PSIMESS Q
RE ;
 D:'$D(VADM(2)) DEM^VADPT
 I PSIV1,P(4)="A"!(P(5)=0) S:P(15)>2880!('P(15)) P(15)=2880 S P(16)=P16+PSIV1#(1440/P(15)+.5\1) S:'P(16) P(16)=1440/P(15)+.5\1
 W DFN,!
 S X=$S(P("PON")["V":"["_+P("PON")_"]",1:"")_$P($P(VADM(2),U,2),"-",3)_"  "_$S(+VAIN(4):$P(VAIN(4),U,2),1:"Opt IV")_"  "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) D P
 S X=VADM(1) S:$P(PSIVSITE,U,9) X=X_"  "_$S(VAIN(5)]"":VAIN(5),1:"NF") D P S X=" " D P
 I $D(PSIVFLAG) F PSIV=0:0 S PSIV=$O(DRG("AD",PSIV)) Q:'PSIV  S Y=DRG("AD",PSIV),X=$S($P(Y,U,2)]"":$P(Y,U,2),1:"*********")_" "_$P(Y,U,3)_" " S:$P(Y,U,4)]"" X=X_" ("_$P(Y,U,4)_")" D P,MESS
 G:$D(PSIVFLAG) SOL
 F PSIV=0:0 S PSIV=$O(DRG("AD",PSIV)) Q:'PSIV  S Y=DRG("AD",PSIV),X=$S($P(Y,U,2)]"":$P(Y,U,2),1:"********")_" "_$P(Y,U,3) I ","_$P(Y,U,4)_","[(","_P(16)_",")!('$P(Y,U,4)) D P,MESS
SOL F PSIV=0:0 S PSIV=$O(DRG("SOL",PSIV)) Q:'PSIV  S Y=DRG("SOL",PSIV) D SOL1,P S X=$P(^PS(52.7,+$P(Y,U),0),U,4) I X]"" S X="   "_X D P
 I P(23)'=""!(P(4)="S") S X="In Syringe: "_$E(P("SYRS"),1,25) D:P(4)="S"!(P(23)="S") P S X="*CAUTION* - CHEMOTHERAPY" D:P(23)'="" P
 S X=" " D P I PSIV1'>0!'$P(PSIVSITE,U,3)!($P(PSIVSITE,U,3)=1&(P(4)'="P"))!($P(PSIVSITE,U,3)=2&("AH"'[P(4))) G INF
 S:'$D(PSIVDOSE) PSIVDOSE="" S X=$P(PSIVDOSE," ",PSIV1) D:$E(X)="." CONVER S X="Dose due at: "_$S(X="":"________",1:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" "_$E(X#1_"000",2,5)) D P
INF S X=$P(P(8),"@") D:X]"" P I P("OPI")]"" S X=$P(P("OPI"),"^") D P
 S X=P(9) D:X]"" P
 S X=P(11) D:X]"" P
 ; PSJ*5*184 - Display all messages if more than one additive has a message.
 I $D(MESS) S PSIMESS="" F  S PSIMESS=$O(MESS(PSIMESS)) Q:PSIMESS=""  S X=PSIMESS D P
 I $D(^PS(59.5,PSIVSN,4)) S Y=^(4) F PSIV=1:1 S X=$P(Y,U,PSIV) Q:X=""  D P
 S X=PSIV1_"["_PSIVNOL_"]" D P
 Q
P F LINE=LINE+1:1 X:LINE>+PSIVSITE "S LINE=1 F ZZ=1:1 Q:ZZ>$P(PSIVSITE,""^"",16)  W !" K ZZ W $E(X,1,PSIVRM),! S X=$E(X,PSIVRM+1,999) Q:$L(X)<1
 Q
SOL1 S X=$S($P(Y,U,2)]"":$P(Y,U,2)_" "_$P(Y,U,3),1:"**********") Q
MESS ; PSJ*5*184 - make MESS a local array so all messages display for all additives.
 I $P(^PS(52.6,+$P(Y,U),0),U,9)]"" S MESS($P(^PS(52.6,+$P(Y,U),0),U,9))=""
 Q
CONVER ;Expand dose to date.dose and set in X
 I P(15)>1440 S X=$$CONVER1^PSIVORE2($P(PSIVDOSE," "),P(15),(PSIV1-1)) Q
 S PDOSE=X S:PSIV1=2 PDATE=$E($P(PSIVDOSE," "),1,7)
 I $P(PSIVDOSE," ",PSIV1-1)#1'<PDOSE!(P(15)>1440) S:$D(X1) XX1=X1 S:$D(X2) XX2=X2 S X1=PDATE,X2=1 D C^%DTC S PDATE=X,X=X_PDOSE S:$D(XX1) X1=XX1 S:$D(XX2) X2=XX2 Q
 S X=PDATE_PDOSE
 Q
