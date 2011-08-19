PSIVWL1 ;BIR/RGY-WARD LIST ROUTINES ;02 AUG 96 / 9:40 AM
 ;;5.0; INPATIENT MEDICATIONS ;**81**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^VA(200 is supported by DBIA 10060
 ;
SELMAN ;
 K PSM,PSIVMT,PSIVOD,PSIVCD S PSCT=0 F I=0:0 S I=$O(^PS(59.5,PSIVSN,2,I)) Q:'I  S PSM(I)=^(I,0),PSCT=PSCT+1
P W !!?5,"The manufacturing times on file are:"
P0 F I=0:0 S I=$O(PSM(I)) Q:'I  S X=PSM(I) W !?10,I,"  ",$E($P(X,"^",5),1,2),":",$E($P(X,"^",5),3,4),"   ",$$CODES^PSIVUTL($P(X,"^",2),59.51,.02)_" covering ",$P(X,"^",3),"."
ASK ;
 S X="Enter manufacturing time(s):^^^^QUX=+QUX!(QUX["","")!(QUX="""")" D ENQ^PSIV Q:X["^"!(X="")  S PSM=X F I=1:1 S X=$P(PSM,",",I) Q:X=""  I '$D(PSM(X)) S PSM="*" Q
 I PSM="*" S HELP="ASKMAN" D ^PSIVHLP G P
SEL F PSIV=1:1 S I=$P(PSM,",",PSIV) Q:I=""  S PSIVMT($P(PSM(I),"^",2))=+(PSIVDT_"."_$P(PSM(I),"^",5)),PSIVOD($P(PSM(I),"^",2))=+(PSIVDT_"."_$P(PSM(I),"^")),PSIVCD($P(PSM(I),"^",2))=+(PSIVDT_"."_$P(PSM(I),"^",4)) D SEL1
 W ! S X=PSM K PSM Q
SEL1 I $P(PSM(I),"^")>$P(PSM(I),"^",4) S X1=PSIVDT,X2=1 D C^%DTC S X=$P(X,".") S $P(PSIVCD($P(PSM(I),"^",2)),".")=X ; INSTALL WITH V 17.3 OF FILEMAN
 Q
ENRSET W ! S X="Are you sure you want to RESET the Ward List (Y/N) ?^N" D ENYN^PSIV Q:"N^"[$E(X)  I X="?" S HELP="RESWL" D ^PSIVHLP1 G ENRSET
 D SELMAN F I=1:1 S Y=$P(X,",",I) Q:'Y  S $P(^PS(59.5,PSIVSN,2,Y,0),"^",6)=PSIVDT W !,"... Ward list #",$P(X,",",I)," reset"
 Q
PRNT ;
 D HDR:$Y+7>IOSL!(PSIVWARD'=WRD),INP^VADPT
 W !,VAIN(5),?30 S PSIV=$O(^PS(55,DFN,"IV",ON,"AD",0)) D:PSIV ENP2^PSIVRNL W ?70 S Y=P(3) D WD W ?92,+^PS(55,"PSIVWL",PSIVSN,WRD,PSIVT_+PSIVDT,DFN,ON),?100 W $P($G(^VA(200,+P(6),0)),U)
 W !,PSIV("NME") S SSNF=0 D ENP3^PSIVRNL Q
HDR W:$Y @IOF W !,"WARD LIST FOR IV ROOM: ",$P(^PS(59.5,PSIVSN,0),U)," AT " S Y=PSIVDT X ^DD("DD") W $P(Y,"@"),?70,"Printed on   : " S Y=PSIVRUN,UWLTY="" X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) W !
 F I=0:0 S UWLTY=$O(PSIVOD(UWLTY)) Q:UWLTY=""  S X=$$CODES^PSIVUTL(UWLTY,55.01,.04) W !,X,"S",?15," covering from " S Y=PSIVOD(UWLTY) D WD W " to " S Y=PSIVCD(UWLTY) D WD W "  Manufacturing time: " S Y=PSIVMT(UWLTY) D WD
 Q:NOFLG=1  W !!?92,"Qty",!,"Patient name",?40,"Order",?70,"Stop date",?90,"needed",?100,"Provider/Initial"
 W ! F X=1:1:110 W "-" W:X=50 " Ward: ",WRD," "
 S PSIVWARD=WRD
 K UWLTY
 Q
SETP S Y=^PS(55,DFN,"IV",ON,0) F X=1:1:23 S P(X)=$P(Y,"^",X)
 Q
WD X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) Q
CODES S X=$P($P(";"_$P(Y,"^",3),";"_X_":",2),";") Q
ENT ;
 ;Will print ward list
NOW D NOW^%DTC S PSIVRUN=$E(%,1,12),PSIVWARD="" K %,%I,%H
 S WRD="",NOFLG=1 F JX=0:0 S WRD=$O(^PS(55,"PSIVWL",PSIVSN,WRD)) Q:WRD=""  S PSIVT="" F JX=0:0 S PSIVT=$O(PSIVOD(PSIVT)) Q:PSIVT=""  S PSIVDT=PSIVOD(PSIVT) D NOW1
 W:NOFLG !!,"****NO DATA FOUND FOR THE WARD LIST WITH THE SELECTED IV TYPE(S)!****"
 G QPRNT
 Q
NOW1 F DFN=0:0 S DFN=$O(^PS(55,"PSIVWL",PSIVSN,WRD,PSIVT_+PSIVDT,DFN)) Q:'DFN  S PSIV("NME")=$P($G(^DPT(DFN,0)),U) D PID^VADPT,NXT
 Q
QPRNT K JX,PSIVT,PSIVWARD,PSIVDT,PSIVRUN,WRD Q
NXT F ON=0:0 S ON=$O(^PS(55,"PSIVWL",PSIVSN,WRD,PSIVT_+PSIVDT,DFN,ON)) Q:'ON  S NOFLG=0 D SETP,PRNT:"DPN"'[P(17)
 Q
ENINIT ;
 F Z1=0:0 S Z1=$O(^PS(59.5,PSIVSN,2,Z1)) Q:'Z1  S Z2=^(Z1,0),PSIVT="" F PSIV1=0:0 S PSIVT=$O(PSIVOD(PSIVT)) Q:PSIVT=""  I $P(PSIVOD(PSIVT),".",2)=$P(+("."_Z2),".",2),(PSIVT=$P(Z2,"^",2)) S $P(^(0),"^",6)=PSIVOD(PSIVT)\1+("."_$P(^(0),"^"))
 S Z1="" F PSIV1=0:0 S Z1=$O(^PS(55,"PSIVWL",PSIVSN,Z1)) Q:Z1=""  S PSIVT="" F PSIV1=0:0 S PSIVT=$O(^PS(55,"PSIVWL",PSIVSN,Z1,PSIVT)) Q:PSIVT=""  D K1
 K Z1,Z2 Q
K1 I $E(PSIVT,2,999)<(DT-1) K ^PS(55,"PSIVWL",PSIVSN,Z1,PSIVT),^PS(55,"PSIVWLM",PSIVSN,PSIVT) Q
 S Z2="" F PSIV1=0:0 S Z2=$O(PSIVOD(Z2)) Q:Z2=""  K:PSIVT=(Z2_PSIVOD(Z2)) ^PS(55,"PSIVWL",PSIVSN,Z1,PSIVT),^PS(55,"PSIVWLM",PSIVSN,PSIVT)
 Q
