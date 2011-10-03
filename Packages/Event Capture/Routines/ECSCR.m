ECSCR ;BIR/MAM,TTH,JPW-Retrieve Event Capture Location ;1 May 96
 ;;2.0; EVENT CAPTURE ;**1,63,72**;8 May 96
 S (ECOUT,X,CNT)=0 F I=0:0 S X=$O(^DIC(4,"LOC",X)) Q:X=""  S CNT=CNT+1,LOC(CNT)=X S Y=$O(^DIC(4,"LOC",X,0)),LOC(CNT)=LOC(CNT)_"^"_Y
 ;If the LOC array contains only one location, set the LOC1 array.
 I '$D(LOC(2)) S ECL=$P(LOC(1),"^",2),ECLOC=1,LOC1(1)=LOC(1) Q
 I $D(LOC(2)),$D(ECN),$D(ECY) W @IOF,!!,"Choose Event Capture Location for this event code screen.",! K ECY,ECN D LOC G END
 I $D(LOC(2)) D LL I '$D(ECL) Q
END ;Exit routine
 Q
LL ; select location
 S ECLOC=0,ECWORD="create^selectable^select a"
 W !!,"Do you want to "_$P(ECWORD,"^")_" this Event Code Screen for ALL locations ? YES//  " R X:DTIME Q:'$T!(X="^")  S:X="" X="Y" S X=$E(X) I "Yy"[X S ECL="ALL" Q
 S ECLOC=1 ;Specific location.
 I "YyNn"'[X W !!,"Enter <RET> if this procedure will be "_$P(ECWORD,"^",2)_" from all locations,",!,"or ""NO"" to "_$P(ECWORD,"^",3)_" location.",!! G LL
 W @IOF,!,"Event Capture Locations:  ",!
LOC S CNT=0 F I=0:0 S CNT=$O(LOC(CNT)) Q:'CNT  W !,CNT_". "_$P(LOC(CNT),"^")
ASK W !!,"Select Location: " R X:DTIME Q:'$T!("^"[X)  I '$D(LOC(X)) W !!,"Enter the number corresponding to the location you want to select.",! G ASK
 I X="" Q
 I $D(LOC1(X)) W !,"This location has already been selected." G ASK
 W "  "_$P(LOC(X),"^") S NUM=X,LOC1(NUM)=LOC(X) S ECL="ALL"
 G ASK
 Q
ASK2 ;Display selection to the user.
 W !,"Event Code Screen Information:"
 W !,"----------------------------",!
 W !,"DSS Unit : "_ECDN,!,"Category : "_ECCN,!,"Procedure: "_$$NAM^ECSCR
 K Y,DIRUT
 W ! S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this information correct"
 D ^DIR Q:$D(DIRUT)  S ECANS=+Y
 Q
NAM() ;Display procedure name.
 I ECP'?1.N.";".E Q "UNKNOWN"
 N ECPF,ECPC
 S ECPF="^"_$P(ECP,";",2)
 S ECPC=$S($E($P(ECP,";",2),1)="E":1,1:3)
 S ECPN=$S(ECPC=1:$P(@(ECPF_+ECP_",0)"),U,ECPC),1:$P($$CPT^ICPTCOD(+ECP),U,ECPC))
 Q ECPN
