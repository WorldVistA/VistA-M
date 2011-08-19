LRWRKS2 ;SLC/RWF/MILW/JMC - WORK SHEET ACCESSION LIST PART 2 ;2/7/91  14:48 ;
 ;;5.2;LAB SERVICE;**153**;Sep 27, 1994
 ;MILW/JMC commented out line "HED+1", repeated line at "HED+2", set %DT="T", avoid echoing date/time on print out.
 ;MILW/JMC 3/11/92 Commented out lines "LP4+2", "LP4+4", "LP3+2", "HED+5"
 ;                 Inserted lines "LP3+3", "LP4+5", & "HED+6"
ENT ;from LRWRKS
 D HED:$Y+4>IOSL!(LRDC)
 D LINE Q
LINE ;
 S LRDFN=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)):+^(0),1:"")
 K LRTSTS,LRORD S LRORD=0,LRURG=9
 S J=0 F  S J=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,J)) Q:J<1  S K=+^(J,0),X=$P(^(0),U,2),LRTSTS(J)=$S($D(^LAB(60,K,0)):^(0),1:""),LRORD=LRORD+1,LRORD(LRORD)=K S:X<LRURG LRURG=+X
 ;I LRXPD K LRTSTS,LRORD D ^LREXPD
 K LRTEST
LP4 S LRACC=^LRO(68,LRAA,1,LRAD,1,LRAN,.2)
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^"),Y=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^") D:Y ADD^LRX S LRCDT=Y
 I $L(LRDFN) S LRLLOC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7),LRDOC=$P(^(0),U,8),LRODNUM=$S($D(^(.1)):^(.1),1:""),LRIDT=$S($D(^(3)):9999999-^(3),1:0),LRSPEC=$S($D(^(5,1,0)):+^(0),1:0),LRSPEC=$S($D(^LAB(61,LRSPEC,0)):$P(^(0),U,1),1:"")
 S X=LRDOC,LRLLOC=LRLLOC D DOC^LRX
 S DFN=+$P(^LR(LRDFN,0),U,3),LRDPF=+$P(^(0),U,2),LRV=$S($D(^LR(LRDFN,"CH",LRIDT,0)):$P(^(0),U,3),1:0) D PT^LRX
 W !,LRACC,?17,$E(PNM,1,19),?41,SSN(1) W:LRV " Ver" W ?61,LRURG(LRURG)
 W !,LRUID,?17,LRCDT,?41,$E(LRDOC,1,18),?61,$E(LRLLOC,1,19)
 ;W !,LRACC,?16,$E(PNM,1,19),?40,SSN W:LRV " Ver" D VA^LRZUTIL
LP3 ;
 W !?17,LRLINE,?61,LRSPEC,!?17
 I 'LRSHORT S J=0 F  S J=$O(LRORD(J)) Q:J<1  S I=LRORD(J) W:$X>17 !?17,LRLINE,!?17 W $P(LRTSTS(I),U,1)
 ;I 'LRSHORT S J=0 F  S J=$O(LRORD(J)) Q:J<1  S I=LRORD(J) W:$X>16 !?16,LRLINE,!?16 W $P(LRTSTS(I),U,1) D COST^LRZUTIL
 I LRSHORT F J=0:0 S J=$O(LRORD(J)) Q:J<1  S I=LRORD(J) W:$X>17 ", " W:$L($P(LRTSTS(I),U,1))+$X>(IOM-4) !?17 W $P(LRTSTS(I),U,1)
 W !,LRLINE,$E(LRLINE,1,39) Q
LP5 S L=$P(LRTSTS(I),U,5),L=$P(L,";",2) I LRIDT,$D(^LR(LRDFN,"CH",LRIDT,L)) W ?37,$J(^(L),8)
 W:LRV ?45,"Ver" Q
 Q
BLANK W !,LRLINE,$E(LRLINE,1,39) Q
HED ;
 S X="NOW",%DT="T" D ^%DT S T=$E(Y,9,10)_":"_$E(Y,11,12)
 W:LRDC!(IOSL\2<$Y) @IOF
 W !!,"LAB ONLY WORK-SHEET FOR Accession area ",$P(^LRO(68,LRAA,0),U,1),?60,LRDT0,"@"_T W:LRUNC !?5,"Uncompleted work only"
 ;W !,"Accession",?16,"Name",?40,"ID",?50,"Doc",?60,"Loc",?70,"Urgency"
 W !,"Accession",?17,"Name",?41,"ID",?61,"Urgency",!,"UID",?17,"Collection Time",?41,"Doc",?61,"Loc"
 S LRDC=0 D BLANK Q
END W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
