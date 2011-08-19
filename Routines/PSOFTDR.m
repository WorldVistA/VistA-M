PSOFTDR ;BHAM/MHA  - free text dosage entry report ; 06/14/01
 ;;7.0;OUTPATIENT PHARMACY;**80,90**;DEC 1997
 ;External Ref. ^PSDRUG( is supp. by DBIA# 221
 ;External reference to ^PS(50.607 supported by DBIA 2221
BEG W !!,"This option provides a list of drugs for those prescriptions"
 W !,"where the dosage field has a free text entry.",!
 W ! S %DT(0)=-DT,%DT("A")="Beginning Date: ",%DT="APE" D ^%DT Q:Y<0!($D(DTOUT))  S (%DT(0),BEGDATE)=Y
 W ! S %DT("A")="Ending Date: " D ^%DT Q:Y<0!($D(DTOUT))  S ENDDATE=Y D:+$E(Y,6,7)=0 DTC
DEV K %ZIS,IOP,POP,ZTSK S PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION W !,"Please try later!" Q
 K PSOION I $D(IO("Q")) D  Q
 .S ZTDESC="Rx free text dosage report",ZTRTN="START^PSOFTDR" F G="BEGDATE","ENDDATE" S:$D(@G) ZTSAVE(G)=""
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
START N PSOPG,PSODT,PSORXN,PSORF,PSODS,PSODR,PSODRN,PSORX0,PSOPR,PSOCNT,PSOJ,PSOL,PSOY,PSOC,TY,PSO2,PSOU
 S TY="PSOFT" K ^TMP(TY,$J)
 S PSODT=BEGDATE-.01,Q=0 W:$E(IOST)="C" !!!,"Hmm.. working hard - please wait.."
ST1 F  S PSODT=$O(^PSRX("AD",PSODT)) Q:'PSODT!(PSODT>(ENDDATE_".999999"))  D  Q:$D(DIRUT)
 .S PSORXN=0 F  S PSORXN=$O(^PSRX("AD",PSODT,PSORXN)) Q:'PSORXN  D  Q:$D(DIRUT)
 ..S PSORF="" F  S PSORF=$O(^PSRX("AD",PSODT,PSORXN,PSORF)) Q:PSORF=""  D:'PSORF  Q:$D(DIRUT)
 ...Q:'$D(^PSRX(PSORXN,0))  S PSORX0=^(0),PSODR=+$P(PSORX0,"^",6)
 ...Q:'$D(^PSDRUG(PSODR,0))
 ...I $E(IOST)="C" S Q=Q+1 W:'(Q#50) "."
 ...I $O(^PSRX(PSORXN,6,0)) S PSOJ=0 F  S PSOJ=$O(^PSRX(PSORXN,6,PSOJ)) Q:'PSOJ  I $P(^(PSOJ,0),"^")]"" S PSODS=$P(^(0),"^"),PSO2=$P(^(0),"^",2),PSOU=$P(^(0),"^",3) D:PSO2 FT1 D:'PSO2 FT2
 U IO S PSOPG=1,PSOCNT=0 D HD
 I '$D(^TMP(TY,$J,"B")) W !!,"*****  No Records were found for this period  *****",!! G EXIT
DET S J="" F  S J=$O(^TMP(TY,$J,"B",J)) Q:J=""  D  Q:$D(DIRUT)
 .S L="",Q=0 F  S L=$O(^TMP(TY,$J,"B",J,L)) Q:L=""  D  Q:$D(DIRUT)
 ..S PSODR=$O(^TMP(TY,$J,"B",J,L,0))
 ..W:'Q !,$E(J,1,30)_" ("_PSODR_")"
 ..W:$L(L)>35 ?40,$E(L,1,35),!,?40,$E(L,36,99) W:$L(L)'>35 ?40,L
 ..W ?75,+^TMP(TY,$J,"B",J,L,PSODR,0),!,"    " S Q=Q+1
 ..S M=0 F  S M=$O(^TMP(TY,$J,"B",J,L,PSODR,M)) Q:'M!($D(DIRUT))  S YY=^TMP(TY,$J,"B",J,L,PSODR,M) D
 ...F I=1:1:$L(YY,";") S XX=$P(YY,";",I) D  Q:$D(DIRUT)
 ....S T=$P(^VA(200,+XX,0),"^")_":"_$P(XX,",",2)_" " W:($X+$L(T))>78 !,"    "
 ....W T D HD:($Y+5)>IOSL Q:$D(DIRUT)
 ...Q:$D(DIRUT)  D HD:($Y+5)>IOSL
 ..Q:$D(DIRUT)
 ..W ! D HD:($Y+5)>IOSL
EXIT W ! D ^%ZISC K DIR,DTOUT,DUOUT,DIROUT,DIRUT,^TMP(TY,$J),I,J,K,L,M,Q,T,X,XX,Y,YY,BEGDATE,ENDDATE
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
FT1 ;check for possible dosages. If does not match report
 S PSOC=1,PSOL=0 F  S PSOL=$O(^PSDRUG(PSODR,"DOS1",PSOL)) Q:'PSOL  S:$P(^(PSOL,0),"^",2)=PSODS PSOC=0
 I PSOC S PSODS=PSODS_$S(PSOU:$P($G(^PS(50.607,PSOU,0)),"^"),1:"") D PRD
 Q
FT2 ;check for local possible dosages. If does not exist report
 I '$D(^PSDRUG(PSODR,"DOS2")) D PRD Q
 S PSOC=1,PSOL=0 F  S PSOL=$O(^PSDRUG(PSODR,"DOS2",PSOL)) Q:'PSOL  S:$P(^(PSOL,0),"^")=PSODS PSOC=0
 D:PSOC PRD
 Q
PRD ;
 S PSODRN=$P(^PSDRUG(PSODR,0),"^"),PSOPR=+$P(PSORX0,"^",4)
 Q:'PSOPR
 I $D(^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,0)) D
 .S ^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,0)=^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,0)+1
 E  S ^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,0)=1
 I $O(^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,0)) D GETR
 E  S ^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,1)=PSOPR_",1"
 Q
GETR ;
 S (J,K)=0
 F  S K=$O(^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,K)) Q:'K!(J)  D
 .S Y=^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,K)
 .F I=1:1 S X=$P(Y,";",I) Q:'X!(J)  D
 ..I PSOPR=+X S J=$P(X,",",2)+1,$P(^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,K),";",I)=PSOPR_","_J Q
 .Q:J
 .I $L(Y)+$L(";"_(PSOPR_",1"))<246 S ^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,K)=Y_";"_(PSOPR_",1")
 .E  S ^TMP(TY,$J,"B",PSODRN,PSODS,PSODR,K+1)=PSOPR_",1",J=1
 Q
HD ;
 I PSOPG>1,$E(IOST)="C" S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q:$D(DIRUT)
 I PSOPG=1,$E(IOST)="C" W @IOF
 W:PSOPG>1 @IOF W "Run Date: " S Y=DT D DT^DIO2 W ?72,"Page "_PSOPG S PSOPG=PSOPG+1
 W !,?20,"Free Text Dosage Entry Report",!,?15,"for the Period: "
 S Y=BEGDATE D DT^DIO2 W " to " S Y=ENDDATE D DT^DIO2
 W !,"Drug",?40,"Free Text Entry",?74,"Count",!,"    Provider:Count"
 W ! F Y=1:1:79 W "-"
 W ! Q
DTC N DD,MM S DD=31,MM=+$E(Y,4,5) I MM'=12 S MM=MM+1,MM=$S(MM<10:"0",1:"")_MM,X2=Y,X1=$E(Y,1,3)_MM_"00" D ^%DTC S DD=X
 S ENDDATE=Y+DD
 Q
