LAEKT7D ;SLC/RWF/DLG - KODAK EKTACHEM 700 BUILD DOWNLOAD FILE. ;8/15/90  15:10 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;Call with LRLL = load list to build
 ;Call with LRTRAY1 = Starting tray number
 ;Call with LRLL = Auto Instrument pointer
 ;Call with LRFORCE=1 if send tray and cup.
A S:$D(ZTQUEUED) ZTREQ="@" S F=$O(^LAB(61,"B","CSF",0)) ;Get CSF pointer value.
 S X=^LAB(69.9,1,1),LRFLUID=$P(X,"^",3)_"^"_F_"^"_$P(X,"^",2)
 F LRTRAY=LRTRAY1:0 D:$D(^LRO(68.2,LRLL,1,LRTRAY)) TRAY S LRTRAY=$O(^LRO(68.2,LRLL,1,LRTRAY)),LRCUP1=1 Q:LRTRAY'>0
 Q
TEST S X="" F LRTEST=0:0 S LRTEST=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,1,LRTEST)) Q:LRTEST'>0  D T2
 Q
T2 Q:'$D(^TMP($J,LRTEST))  F I=0:0 S I=$O(^TMP($J,LRTEST,I)) Q:I'>0  S Y=^(I) S:X'[Y X=X_^(I) ;Don't repete a test
 Q
SAMPLE S LRL=^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,0),LRAA=+LRL,LRAD=$P(LRL,"^",2),LRAN=$P(LRL,"^",3),LRECORD=LRECORD_$E(LRAN_"               ",1,15) D PNM
 S F=$P(LRL,"^",5),F=$S($P(LRFLUID,"^",1)=F:1,$P(LRFLUID,"^",3)=F:3,$P(LRFLUID,"^",2)=F:2,1:0) ;If not one of the 3 fluids don't send
 I 'F W:'$D(ZTSK) !,"Accession not correct collection sample: ",LRACC Q
 S LRECORD=LRECORD_F_"0"_$S($G(LRFORCE):$C(LRCUP+32),1:" ")_"1.000" D TEST S LRECORD=LRECORD_X_PNM_"]"
 S ^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,2)=LRECORD
 Q
TRAY S LRECORD=$S($G(LRFORCE):$E("|"_"TRAY "_LRTRAY_"          ",1,16),1:"")
 F LRCUP=(LRCUP1-1):0 S LRCUP=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP)) Q:LRCUP'>0  D SAMPLE S LRECORD=""
 Q
PNM ;Get patient name and last 4 from an accession.
 S PNM="" Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S X=^(0),LRACC=^(.2),X=^LR(+X,0) I $P(X,"^",2)=2 S DFN=$P(X,"^",3) D PT^LRX S PNM=$E("|"_$E(PNM,1,20)_" "_$P(SSN,"-",3)_$J(" ",26),1,26)
 Q
