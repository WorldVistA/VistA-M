PSIVHYPR ;BIR/PR-REPRINT LABELS ;26 FEB 97 / 3:20 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58,88,96,178,184**;16 DEC 97;Build 12
 ;
 ; Reference to ^%ZIS(2 is supported by DBIA 3435.
 ; Reference to ^PS(50.4 is supported by DBIA 2175.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ;
 ;NEEDS DFN, ON AND PSIVNOL (Total number of labels to print) and
 ;PSIVCT - $D(PSIVCT) NO COUNT LABEL
SSWARD ;Get patient SS# and ward location
 N X0,PSJIO,I
 S I=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=^(I,0),PSJIO($P(X0,"^"))=^(1)
 S PSJIO=$S('$D(PSJIO):0,1:1)
 D ENIV^PSJAC S VADM(2)=$E(VADM(2),6,9),PSIVWD=$S(+VAIN(4):$P(VAIN(4),U,2),1:"Opt. IV")
 ;;NEW PSIVNOL,PSIV1 S (PSIVNOL,PSIV1)=1
 NEW PSIV1 S PSIV1=1
 G:PSIVNOL<1 Q D SETP,PSIVHYP S PSIVRM=$P(PSIVSITE,U,13),P16=$P($G(^PS(55,DFN,"IV",+ON,9)),U,3) S:PSIVRM<1 PSIVRM=30 I $D(PSIVCT),PSIVCT'=1 K PSIVCT
 I PSJIO,$G(PSJIO("FI"))]"" X PSJIO("FI")
 ;PSJRPHD is defined in REPRT^PSIVLBRP
 I $P(PSIVSITE,U,7),'$D(PSJRPHD) D
 . S PSIVFLAG=1,(LINE,PSIV1)=0,PSIV2=PSIVNOL,PSIVNOL=0 D RE
 . S PSIVRP="",PSIVRT=""
 . I $D(^PS(55,DFN,"IV",+ON,.2)) S PSIVRP=$P(^PS(55,DFN,"IV",+ON,.2),U,3) D
 .. I PSIV1'>0!'$P(PSIVSITE,U,3)!($P(PSIVSITE,U,3)=1&(P(4)'="P"))!($P(PSIVSITE,U,3)=2&("AH"'[P(4))) Q   ;QUIT IF "DOSE DUE AT" IS SET TO NOT PRINT
 .. S PSIVRT=$P(^PS(51.2,PSIVRP,0),U,1)
 .. S X="ROUTE: "_PSIVRT D:X]"" PMR
 . S X="Solution: _______________" D PRNTL S X="Additive: _______________" D PRNTL
 . S PSIVNOL=PSIV2
 . I 'PSJIO F LINE=LINE+1:1:(PSIVSITE+$P(PSIVSITE,U,16)) W !
 . I PSJIO F I="EL","FE" I $G(PSJIO(I))]"" X PSJIO(I)
 I '$D(PSIVCT) D NOW^%DTC S Y=%,$P(^PS(55,DFN,"IV",+ON,9),U,1,2)=Y_"^"_PSIVNOL,$P(^(9),U,3)=$P(^(9),U,3)+1
 K PSIVFLAG,PSIVSH
START S PSIV1=1,LINE=0 D RE D
 . Q:$D(PSIVFLAG) 
 . I 'PSJIO F LINE=LINE+1:1:(PSIVSITE+$P(PSIVSITE,U,16)) W !
 . I PSJIO,$G(PSJIO("EL"))]"" X PSJIO("EL")
 I PSJIO,$G(PSJIO("FE"))]"" X PSJIO("FE")
 ;;D:'$D(PSIVCT) ^PSIVSTAT
 I '$D(PSIVCT) D ^PSIVSTAT S P(16)=P(16)+PSIVNOL
Q K HYPL,LINE,MESS,P16,PDATE,PDOSE,PSIV,PSIVA,PSIV1,PSIV2,PSIVCT,PSIVDOSE,PSIVFLAG,PSIVRM,PSIVWD,TVOL,PSIMESS Q
RE ;I PSIV1 S:P(15)>2880!('P(15)) P(15)=2880 S P(16)=P16+PSIV1#(1440/P(15)+.5\1) S:'P(16) P(16)=1440/P(15)+.5\1
 I PSJIO,$G(PSJIO("SL"))]"" X PSJIO("SL")
 I PSIV1 D BARCODE
 S X="["_$P(^PS(55,DFN,"IV",+ON,0),U)_"]"_" "_VADM(2)_"  "_PSIVWD_"  "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) D PRNTL
 S X=VADM(1) S:$P(PSIVSITE,U,9) X=X_"  "_$S(VAIN(5)]"":VAIN(5),1:"NF") D PRNTL S X=" " D PRNTL
 D:$P(PSIVSITE,U,12) TVOL
 S X="",$P(X,"=",PSIVRM-1)="" D PRNTL
 I $D(PSIVFLAG) F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IV",+ON,"AD",PSIV)) Q:'PSIV  S Y=^(PSIV,0),X=$S($D(^PS(52.6,+Y,0)):$P(^(0),U),1:"*********")_" "_$P(Y,U,2)_" " S:$P(Y,U,3)]"" X=X_" ("_$P(Y,U,3)_")" D
 . D PRNTL,MESS
 I $D(PSIVFLAG) F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IV",+ON,"SOL",PSIV)) Q:'PSIV  S PSIV=PSIV_"^"_+^(PSIV,0),YY=^(0) D
 . D SOL1,PRNTL
 . S X=$P(^PS(52.7,$P(PSIV,U,2),0),U,4) I X]"" S X="   "_X D PRNTL
 G:$D(PSIVFLAG) SOL
 F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IVBCMA",PSJIDNO,"SOL",PSIV)) Q:'PSIV  S PSIV=PSIV_"^"_+^(PSIV,0),YY=^(0) D
 . D SOL1,PRNTL
 . S X=$P(^PS(52.7,$P(PSIV,U,2),0),U,4) I X]"" S X="   "_X D PRNTL
 F I=0:0 S I=$O(HYPL(I)) Q:'I  S PSIV="" F I=I:0 S PSIV=$O(HYPL(I,PSIV)) Q:PSIV=""  D
 . F Z="" S Z=$O(HYPL(I,PSIV,Z)) Q:Z=""  S PSIVA=$S(I=50.4:PSIV,I=52.7:+^PS(55,DFN,"IVBCMA",PSJIDNO,"SOL",+$P(HYPL(I,PSIV,Z),U,2),0),1:+^PS(55,DFN,"IVBCMA",PSJIDNO,"AD",+$P(HYPL(I,PSIV,Z),U,2),0)) D HYP
SOL S X="",$P(X,"=",PSIVRM-1)="" D PRNTL
 S X=" " D PRNTL I PSIV1'>0!'$P(PSIVSITE,U,3)!($P(PSIVSITE,U,3)=1&(P(4)'="P"))!($P(PSIVSITE,U,3)=2&("AH"'[P(4))) G MEDRT
 S:'$D(PSIVDOSE) PSIVDOSE="" S X=$P(PSIVDOSE," ",PSIV1) D:$E(X)="." CONVER^PSIVLABL S X="Dose due at: "_$S(X="":"________",1:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" "_$E(X#1_"000",2,5)) D PRNTL
 ;
MEDRT ;Find Medication Route   
 S PSIVRP="",PSIVRT=""
 I $D(^PS(55,DFN,"IV",+ON,.2)) S PSIVRP=$P(^PS(55,DFN,"IV",+ON,.2),U,3) D
 .S PSIVRT=$P(^PS(51.2,PSIVRP,0),U,1)
 .S X="ROUTE: "_PSIVRT D:X]"" PMR
 ;
INF S X=$P(P(8),"@") D:X]"" PRNTL
 I $D(^PS(55,DFN,"IV",+ON,3)) S X=$P(^(3),U) D:X]"" PRNTL
 S X=P(9) D:X]"" PRNTL
 S X=P(11) D:X]"" PRNTL
 ;PSJ*5*184 - Display all messages if more than one additive has a message.
 I $D(MESS) S PSIMESS="" F  S PSIMESS=$O(MESS(PSIMESS)) Q:PSIMESS=""  S X=PSIMESS D PRNTL
 I $D(^PS(59.5,PSIVSN,4)) S Y=^(4) F PSIV=1:1 S X=$P(Y,U,PSIV) Q:X=""  D PRNTL
 S X=$S('+$G(PSIV1):"0[0]",1:PSIVBAG) D PRNTL
 Q
PRNTL N I F LINE=LINE+1:1 D  Q:$L(X)<1
 . I LINE>PSIVSITE D
 .. S LINE=1
 .. I 'PSJIO D  Q
 ... F ZZ=1:1 Q:ZZ>$P(PSIVSITE,"^",16)  W !
 .. F I="EL","SL" I $G(PSJIO(I))]"" X PSJIO(I)
 . K ZZ
 . F I="ST","STF" I $G(PSJIO(I))]"" X PSJIO(I)
 . W $E(X,1,PSIVRM)
 . F I="ETF","ET" I $G(PSJIO(I))]"" X PSJIO(I)
 . I 'PSJIO W !
 . S X=$E(X,PSIVRM+1,999)
 Q
PMR ; Print Med Route on label
 F LINE=LINE+1:1 D  Q:$L(X)<1
 . I LINE>PSIVSITE D
 .. S LINE=1
 .. I 'PSJIO D  Q
 ... F ZZ=1:1 Q:ZZ>$P(PSIVSITE,"^",16)  W !
 .. F I="EL","SL" I $G(PSJIO(I))]"" X PSJIO(I)
 . K ZZ
 . ;
 . F I="ST","STF","SM","SMF" I $G(PSJIO(I))]"" X PSJIO(I)
 . W $E(X,1,PSIVRM)
 . F I="ETF","ET","EMF","EM" I $G(PSJIO(I))]"" X PSJIO(I)
 . I 'PSJIO W !
 . S X=$E(X,PSIVRM+1,999)
 Q 
 ;
TVOL ;
 S PSIV=TVOL F X=0:0 S X=$O(^PS(55,DFN,"IVBCMA",PSJIDNO,"AD",X)) Q:'X  S X=X_"^"_^(X,0) S:$P(X,U,4)[P(16)!($P(X,U,4)="")!'PSIV1 PSIV=PSIV+$S($P(^PS(52.6,$P(X,U,2),0),U,10):$P(X,U,3)/$P(^(0),U,10),1:0)
 S X="Total Volume: "_(PSIV+.5\1) D PRNTL
 Q
SOL1 S X=$S($D(^PS(52.7,$P(PSIV,U,2),0)):$P(^(0),U)_" "_$P(^PS(55,DFN,"IVBCMA",PSJIDNO,"SOL",+PSIV,0),U,2),1:"**********") Q
HYP ;
 I PSIV="*" S X="*** Error in "_$S(I=50.4:"electrolyte",I=52.7:"solution",1:"additive") D PRNTL Q
 S X=+HYPL(I,PSIV,Z)
 S X=$S($D(^PS(I,PSIVA,0)):$P(^(0),U),1:"Undefined "_$S(I=50.4:"electrolyte",I=52.7:"solution",1:"additive"))_" "_(X+.005\.01/100)_" "_$P($P(HYPL(I,PSIV,Z),U)," ",2)
 D PRNTL
 Q
SETP S Y=^PS(55,DFN,"IV",+ON,0) F X=1:1:23 S P(X)=$P(Y,U,X)
 Q
MESS ;PSJ*5*184 -make MESS a local array so all messages display for all additives.
 I $P(^PS(52.6,+Y,0),U,9)]"" S MESS($P(^PS(52.6,+Y,0),U,9))=""
 Q
BARCODE D PSET^%ZISP
 I 'PSJIO D
 . I IOBARON]"" W @IOBARON
 . W PSJBCID
 . I IOBAROFF]"" W @IOBAROFF
 . W !
 I PSJIO D
 . F I="SB","SBF" I $G(PSJIO(I))]"" X PSJIO(I)
 . W PSJBCID
 . F I="EBF","EB" I $G(PSJIO(I))]"" X PSJIO(I)
 Q
PSIVHYP ;
 K HYPL S TVOL=0 F Z=52.6,52.7 F DRG=0:0 S DRG=$O(^PS(55,DFN,"IVBCMA",PSJIDNO,$S(Z=52.6:"AD",1:"SOL"),DRG)) Q:'DRG  S DRG=DRG_"^"_^(DRG,0) S $P(DRG,"^",4)="ALL" D DRG^PSIVHYP
 S TVOL=TVOL+.5\1 K EL,DRG,NAD,Z
 Q
