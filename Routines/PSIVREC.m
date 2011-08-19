PSIVREC ;BIR/CCH,PR-RECOMPILE IV STATS ;16 DEC 97 / 1:40 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
REC W !,"Enter Name of Drug to be recompiled" R !,"(if multiple names, separate by "",""): ",STR:DTIME W:'$T $C(7) G:'$T!("^"[STR) DONE I STR?1."?" S HELP="OMP" D ^PSIVHLP2 G REC
 S (ADDSTR,SOLSTR)="" F Z=1:1:$L(STR,",") S NM=$P(STR,",",Z) D LOOKUP I 'ADDSTR,'SOLSTR W ! G REC
QUE S ZTRTN="ENQ^PSIVREC",ZTIO="",ZTDTH=$H,ZTDESC="Recompile IV Stats"
 F G="I7","I8","ADDSTR","SOLSTR" S ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"Queued."
DONE K %DT,ADDSTR,COST,D,DA,DAT,DATA,FLE,G,HELP,IV,NM,PCE,I7,I8,SOLSTR,STR,X,Y,Z,ZTSK,C D ENIVKV^PSGSETU Q
LOOKUP W !,NM K DIC S X=NM,DIC(0)="EZ",DIC="^PS(52.6,",DIC("W")="W ""   (Additive)""" D ^DIC
 I Y'>0 S DIC="^PS(52.7,",DIC("W")="W $P(^(0),U,3),""  SOLUTION""",X=NM D ^DIC I Y'>0 K DIC W !!,NM_" NOT FOUND" Q
FOUND W !,$P(Y(0),"^")_" in the "_$S(DIC[52.6:"Additive",1:"Solution")_" File"
 I DIC[52.6 S ADDSTR=$S('ADDSTR:+Y,1:ADDSTR_","_+Y)
 E  S SOLSTR=$S('SOLSTR:+Y,1:SOLSTR_","_+Y)
 K DIC Q
ENQ ; done as background job to fix correct cost in stats file 50.8
 F IV=0:0 S IV=$O(^PS(50.8,IV)) Q:'IV  I $D(^PS(50.8,IV,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,IV,2,DAT)) Q:'DAT!(DAT>I8)  D FNDRG
 D DONE S:$D(ZTQUEUED) ZTREQ="@" Q
FNDRG Q:'$D(^PS(50.8,IV,2,DAT,2))  I ADDSTR S FLE=52.6 F PCE=1:1:$L(ADDSTR,",") S D=$P(ADDSTR,",",PCE) D FIX
 I SOLSTR S FLE=52.7 F PCE=1:1:$L(SOLSTR,",") S D=$P(SOLSTR,",",PCE) D FIX
 Q
FIX I $D(^PS(50.8,IV,2,DAT,2,"AC",FLE,D)) S DA=$O(^(D,0)),COST=$P(^PS(FLE,D,0),"^",7),$P(^PS(50.8,IV,2,DAT,2,DA,0),"^",5)=COST Q
