PSIVLABR ;BIR/PR-REPRINT LABELS ;30 May 2001  12:36 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58,82,178,184**;16 DEC 97;Build 12
 ;
 ; Reference to ^%ZIS(2 is supported by DBIA 3435.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PS(51.2 is supported by DBIA 2178. 
 ;
 ;Needs DFN,ON, and PSIVNOL NOTE: If PSIVCT is defined then we do
 ;not count labels in the STATs file or increment cummulative doses or
 ;the last fill field.
 ;PSIVCT will be defined if reprinting scheduled labels, the suspense
 ;list, or if printing individual labels and they do not count.
 ;
DEM ;Get demographics and see if label is example only
 N X0,PSJIO,I
 S I=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=$G(^(I,0)) I X0]"" S PSJIO($P(X0,"^"))=^(1)
 S PSJIO=$S('$D(PSJIO):0,1:1)
 D ENIV^PSJAC,NOW^%DTC S PSIVNOW=$$ENDTC^PSGMI(%),VADM(2)=$E(VADM(2),6,9),PSIVWD=$S(+VAIN(4):$P(VAIN(4),U,2),1:"Opt. IV") I $D(PSIVEXAM) G ENX
 ;
 ;;NEW PSIVNOL,PSIV1 S (PSIVNOL,PSIV1)=1
 NEW PSIV1 S PSIV1=1
 G:PSIVNOL<1 Q D SETP S PSIVRM=$P(PSIVSITE,U,13),P16=$P($G(^PS(55,DFN,"IV",+ON,9)),U,3) S:PSIVRM<1 PSIVRM=30 I $D(PSIVCT),PSIVCT'=1 K PSIVCT
 I PSJIO,$G(PSJIO("FI"))]"" X PSJIO("FI")
 ;PSJRPHD is defined in REPRT^PSIVLBRP so header only print once.
 I $P(PSIVSITE,U,7),'$D(PSJRPHD) D
 . S PSIVFLAG=1,(LINE,PSIV1)=0,PSIV2=PSIVNOL,PSIVNOL=0 D RE
 . S PSIVRP="",PSIVRT=""
 . I $D(^PS(55,DFN,"IV",+ON,.2)) S PSIVRP=$P(^PS(55,DFN,"IV",+ON,.2),U,3) D
 .. I PSIV1'>0!'$P(PSIVSITE,U,3)!($P(PSIVSITE,U,3)=1&(P(4)'="P"))!($P(PSIVSITE,U,3)=2&("AH"'[P(4))) Q   ;QUIT IF "DOSE DUE AT" IS SET TO NOT PRINT
 .. S PSIVRT=$P(^PS(51.2,PSIVRP,0),U,1)
 .. S X="ROUTE: "_PSIVRT D:X]"" PMR
 . S X="Solution: _______________" D P S X="Additive: _______________" D P
 . S PSIVNOL=PSIV2
 . I 'PSJIO F LINE=LINE+1:1:(PSIVSITE+$P(PSIVSITE,U,16)) W !
 . I PSJIO,$G(PSJIO("EL"))]"" X PSJIO("EL")
 ;;I '$D(PSIVCT) D NOW^%DTC S Y=%,$P(^PS(55,DFN,"IV",+ON,9),U,1,2)=Y_"^"_PSIVNOL,$P(^(9),U,3)=$P(^(9),U,3)+PSIVNOL
 I '$D(PSIVCT) D NOW^%DTC S Y=%,$P(^PS(55,DFN,"IV",+ON,9),U,1,2)=Y_"^"_PSIVNOL,$P(^(9),U,3)=$P(^(9),U,3)+1
 K PSIVFLAG,PSIVSH G START
SETP S Y=^PS(55,DFN,"IV",+ON,0) F X=1:1:23 S P(X)=$P(Y,U,X)
 Q
ENX ;Print example label
 D SETP S PSIVFLAG=1,PSIVRM=$P(PSIVSITE,U,13) S:PSIVRM<1 PSIVRM=30
START S PSIV1=1,LINE=0 D RE D
 . Q:$D(PSIVFLAG) 
 . I 'PSJIO F LINE=LINE+1:1:(PSIVSITE+$P(PSIVSITE,U,16)) W !
 . I PSJIO,$G(PSJIO("EL"))]"" X PSJIO("EL")
 I PSJIO,$G(PSJIO("FE"))]"" X PSJIO("FE")
 D:'$D(PSIVCT) ^PSIVSTAT
Q K PSIV,PSIVDOSE,PSIVCT,PSIVWD,P16,LINE,MESS,PSIV2,PSIVFLAG,PSIVRM,PSIV1,PDOSE,PDATE,XX1,XX2,BAG,CX,PSIMESS Q
RE ;
 ;NEED THE CODE BELOW?
 ;;I PSIV1,P(4)="A"!(P(5)=0) S:P(15)>2880!('P(15)) P(15)=2880 S P(16)=P16+PSIV1#(1440/P(15)+.5\1) S:'P(16) P(16)=PSIV1
 I PSJIO,$G(PSJIO("SL"))]"" X PSJIO("SL")
 I PSIV1 D BARCODE
 S X="["_$P(^PS(55,DFN,"IV",+ON,0),U)_"]"_" "_VADM(2)_"  "_PSIVWD_"  "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3) D P
 S X=VADM(1) S:$P(PSIVSITE,U,9) X=X_"  "_$S(VAIN(5)]"":VAIN(5),1:"NF") D P S X=" " D P
 I $D(PSIVFLAG) F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IV",+ON,"AD",PSIV)) Q:'PSIV  S Y=^(PSIV,0),X=$S($D(^PS(52.6,+Y,0)):$P(^(0),"^"),1:"*********")_" "_$P(Y,U,2)_" " S:$P(Y,U,3)]"" X=X_" ("_$P(Y,U,3)_")" D
 . D P,MESS
 G:$D(PSIVFLAG) SOL
 F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IVBCMA",PSJIDNO,"AD",PSIV)) Q:'PSIV  S Y=^(PSIV,0),X=$S($D(^PS(52.6,+Y,0)):$P(^(0),U),1:"********")_" "_$P(Y,U,2) D
 . D P,MESS
SOL F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IVBCMA",PSJIDNO,"SOL",PSIV)) Q:'PSIV  S PSIV=PSIV_"^"_+^(PSIV,0),YY=^(0) D
 . D SOL1,P
 . S X=$P(^PS(52.7,$P(PSIV,U,2),0),U,4) I X]"" S X="   "_X D P
 I P(23)'=""!(P(4)="S") S X="In Syringe: "_$E($P(^PS(55,DFN,"IV",+ON,2),U,4),1,25) D:P(4)="S"!(P(23)="S") P S X="*CAUTION* - CHEMOTHERAPY" D:P(23)'="" P
 S X=" " D P I PSIV1'>0!'$P(PSIVSITE,U,3)!($P(PSIVSITE,U,3)=1&(P(4)'="P"))!($P(PSIVSITE,U,3)=2&("AH"'[P(4))) G MEDRT
 S:'$D(PSIVDOSE) PSIVDOSE="" S X=$P(PSIVDOSE," ",PSIV1) D:$E(X)="." CONVER S X="Dose due at: "_$S(X="":"________",1:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" "_$E(X#1_"000",2,5)) D P
 ;
MEDRT ;Find Medication Route   
 S PSIVRP="",PSIVRT=""
 I $D(^PS(55,DFN,"IV",+ON,.2)) S PSIVRP=$P(^PS(55,DFN,"IV",+ON,.2),U,3) D
 .S PSIVRT=$P(^PS(51.2,PSIVRP,0),U,1)
 .S X="ROUTE: "_PSIVRT D:X]"" PMR
 ;
INF S X=$P(P(8),"@") D:X]"" P
 I $D(^PS(55,DFN,"IV",+ON,3)) S X=$P(^(3),"^") D:X]"" P
 S X=P(9) D:X]"" P
 S X=P(11) D:X]"" P
 ;PSJ*5*184 - Display all messages if more than one additive has a message.
 I $D(MESS) S PSIMESS="" F  S PSIMESS=$O(MESS(PSIMESS)) Q:PSIMESS=""  S X=PSIMESS D P
 I $D(^PS(59.5,PSIVSN,4)) S Y=^(4) F PSIV=1:1 S X=$P(Y,U,PSIV) Q:X=""  D P
 ;S X=PSIV1_"["_$S(PSIV1:PSIVNOL,1:PSIV2)_"]"_"  "_$S('PSIV1:PSIVNOW,1:"") D P
 S X=PSIVBAG D P
 Q
P F LINE=LINE+1:1 D  Q:$L(X)<1
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
 ;
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
SOL1 S X=$S($D(^PS(52.7,$P(PSIV,U,2),0)):$P(^(0),"^")_" "_$P(^PS(55,DFN,"IVBCMA",PSJIDNO,"SOL",+PSIV,0),U,2),1:"**********") Q
MESS ;PSJ*5*184 -make MESS a local array so all messages display for all additives.
 I $P(^PS(52.6,+Y,0),U,9)]"" S MESS($P(^PS(52.6,+Y,0),U,9))=""
 Q
CONVER ;Expand dose to date.dose and set in X
 I P(15)>1440 S X=$$CONVER1^PSIVORE2($P(PSIVDOSE," "),P(15),(PSIV1-1)) Q
 S PDOSE=X S:PSIV1=2 PDATE=$E($P(PSIVDOSE," "),1,7)
 I $P(PSIVDOSE," ",PSIV1-1)#1'<PDOSE!(P(15)>1440) S:$D(X1) XX1=X1 S:$D(X2) XX2=X2 S X1=PDATE,X2=1 D C^%DTC S PDATE=X,X=X_PDOSE S:$D(XX1) X1=XX1 S:$D(XX2) X2=XX2 Q
 S X=PDATE_PDOSE
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
