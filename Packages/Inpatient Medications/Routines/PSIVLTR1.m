PSIVLTR1 ;BIR/PR-PRINT LABEL TRACKER BY PATIENT ;2 NOV 92 / 9:34 AM
 ;;5.0; INPATIENT MEDICATIONS ;**58**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 ;The following parameters are needed
 ;DFN - Patient
 ;ON  -Order number
 ;
DATA(DFN,ON) ;Get the information
 N PSJBLN,PSJD1,X,DA,DR,DIQ,DIC,PSJD2
 K PSJDNE S PSIVSCR=$E(IOST)="C",COU=0 D H I '$D(^PS(55,DFN,"IV",ON,"LAB")) W !,"No label log to report.",!
 F L=0:0 S L=$O(^PS(55,DFN,"IV",ON,"LAB",L)) Q:'L!$D(PSJDNE)  S COU=COU+1 I $D(^(L,0)) D 1
 Q:'$D(^PS(55,DFN,"IV",ON,"LAB"))
 D PAUSE,H2 S PSJBLN=0
 F  S PSJBLN=$O(^PS(55,DFN,"IVBCMA",PSJBLN)) Q:PSJBLN=""  D
 . K DA,DR,DIQ,DIC,PSJD2
 . S DIC="^PS(55,"_DFN_",""IVBCMA"",",DA=PSJBLN,DR=".01;.02;1;2;3;4;5",DIQ="PSJD2",DIQ(0)="IE" D EN^DIQ1
 . Q:$G(PSJD2(55.0105,PSJBLN,.02,"I"))'=ON
 . I PSIVSCR,($Y#IOSL)>23 D PAUSE,H2
 . W $$ENDTC1^PSGMI($G(PSJD2(55.0105,PSJBLN,4,"I"))),?18,$G(PSJD2(55.0105,PSJBLN,.01,"I")) I $X>39 W !
 . W ?40,$G(PSJD2(55.0105,PSJBLN,5,"E"))
 . S X=$G(PSJD2(55.0105,PSJBLN,3,"I")) W ?50,$S(X:"YES",1:"NO"),?56,$G(PSJD2(55.0105,PSJBLN,2,"E"))
 . I $G(PSJD2(55.0105,PSJBLN,1,"I"))]"" W ?66,$$ENDTC1^PSGMI($G(PSJD2(55.0105,PSJBLN,1,"I")))
 . W !
 ;
K ;
 K NUMLAB,TRA,CD,DATE
 Q
 ;
1 ;Get num labels, track, daily usage
 ;naked reference refers to ^PS(55,DFN,"IV",ON,"LAB",L,0)
 S N=^(0),Y=$P(N,U,2) X ^DD("DD") S DATE=Y,USER=$P(N,U,4),OG=$P(N,U,3),OG=$S(OG=1:"DISPENSED",OG=2:"RECYCLED",OG=3:"DESTROYED",OG=4:"CANCELLED",1:"SUSPENDED")
 S NUMLAB=$P(N,U,5) S:$P(N,U,3)=1!($P(N,U,3)=5) TRA=$P(N,U,6),TRA=$S(TRA=1:"INDIVIDUAL",TRA=2:"SCHEDULED",TRA=3:"SUSPENSE",1:"ORDER ACTION") S CD=$S($P(N,U,7):"YES",1:"NO") D P
 Q
P ;Print out info
 W !,COU,?3,DATE,!,?18,OG,?32,$E($P(^VA(200,USER,0),U),1,15),?50,NUMLAB W:$P(N,U,3)=1!($P(N,U,3)=5) ?60,TRA W:$P(N,U,3)=1 ?77,CD D:$P(N,U,3)'=1&($P(N,U,8)'="") ERROR W ! I ($Y#IOSL)>23,PSIVSCR D PAUSE
 K NUMLAB,TRA,CD,DATE,USEROG
 Q
 ;
PAUSE ;
 N DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSJDNE=1
 Q
H ;Header
 W !!,"LABEL LOG:",!!,"#",?3,"DATE/TIME",?18,"ACTION",?32,"USER",?47,"#LABELS",?60,"TRACK",?75,"COUNT",! F I=1:1:80 W "=" W:I=80 !
 Q
H2 ;Header for Unique ID #s
 W !!,"Unique IDs for this order:",!!
 W "Label Date/Time",?18,"Unique ID",?40,"Status",?50,"Count",?56,"BCMA Action - Date/Time",!!
 Q
ERROR ;
 W !!?40,"Bag(s) DISPENSED in IV Room: ",$P(^PS(59.5,$P($P(N,U,8)," "),0),U)
 W !?40,"Bag(s) ",OG_" in IV Room: ",$P(^PS(59.5,$P($P(N,U,8)," ",2),0),U)
 Q
