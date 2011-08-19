ECL ;BIR/MAM-Get Event Capture Location ;17 May 89
 ;;2.0; EVENT CAPTURE ;**25**;8 May 96
 S ECOUT=0
 D GETLOC(.LOC)
 I '$D(LOC(1)) D  R X:5 W @IOF Q
 . W !!,"You have no locations flagged for Event Capture.",!
 S:'$D(LOC(2)) ECLN=$P(LOC(1),"^"),ECL=$P(LOC(1),"^",2)
 I $D(LOC(2)) D LL I '$D(ECL) Q
 I '$G(NOTIOF) W @IOF
 Q
GETLOC(LOC) ;Get all event capture locations
 N I,CNT
 S (X,CNT)=0
 F I=0:0 S X=$O(^DIC(4,"LOC",X)) Q:X=""  D
 . S CNT=CNT+1,LOC(CNT)=X,Y=$O(^DIC(4,"LOC",X,0)),LOC(CNT)=LOC(CNT)_"^"_Y
 Q
LL ; select location
 W:'$G(NOTIOF) @IOF W !,"Event Capture Locations:  ",!
 S CNT=0 F I=0:0 S CNT=$O(LOC(CNT)) Q:'CNT  W !,CNT_". "_$P(LOC(CNT),"^")
ASK W !!,"Select Number: " R X:DTIME Q:'$T!("^"[X)!(X="")
 I '$D(LOC(X)) D  G LL
 . W !!,"Enter the number corresponding to the location you want to "
 . W "select.",!!,"Press <RET> to continue"
 . R X:DTIME
 S ECL=$P(LOC(X),"^",2),ECLN=$P(LOC(X),"^")
 Q
