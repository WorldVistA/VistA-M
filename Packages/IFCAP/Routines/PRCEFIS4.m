PRCEFIS4 ;WISC/CTB/CLH-POST LIQUIDATION WHILE IN CODE SHEET MODULE ; 10/10/97  1400
V ;;5.1;IFCAP;**90**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:$D(PRCFA(1358))
 S PRCFA("CSM")="",ZX=$O(^PRCD(442.5,"C",1358,0))
 S PODA=$S($G(PRCFA("PODA"))]"":PRCFA("PODA"),$G(PRCF("PODA"))]"":PRCF("PODA"),1:"")
 D PO^PRCH58OB(.PODA,.PO)
 S PRCFA("TRDA")=$P(PO(0),"^",12) I PRCFA("TRDA")'>0 K PRCFA("TRDA") G EX1
 G:$P(PO(0),"^",2)'=ZX EX1
 I $D(PRCFD("PAYMENT")) G CI
 G OUT
 ;post 1358 liquidation is not asked - plt 4/93
 ;K ZX S DIR("A")="Do you wish to post a liquidation to the 1358 now",DIR("B")="No",DIR(0)="YO",DIR("?")="Enter YES to post, <RETURN> or No to quit"
 ;D ^DIR I Y'=1 G OUT
CI S:$G(PRCFA("PODA"))="" PRCFA("PODA")=$S($G(PODA)]"":PODA,$G(PRCF("PODA"))]"":PRCF("PODA"),1:"") D EN1^PRCELIQ
OUT ;W:'$D(PRCFD("PAYMENT")) !!,"Returning to Code Sheet Module",!!,$C(7) Q
 Q
EX1 K %,DIC,DIE,DR,PRCFA("CSM"),X,X1,ZX Q
 ;
EOM ; PRINT END OF MONTH REPORT
 S DIC="^PRC(442,",L=0,(BY,FLDS)="[PRCE 1358 EOM REPORT]" D EN1^DIP Q
 ;
PRINT ;PRINT ANY 1358
 S ZX=$O(^PRCD(442.5,"C",1358,0)) I ZX="" W !,"Error in PAT Type file, Contact your IFCAP coordinator.",$C(7),!! K ZX Q
 W !,"Brief or Standard output? (B/S): B// " R X:DTIME Q:'$T!(X["^")  S:X="" X="B" I "BbSs?"'[$E(X,1) W "??  B(rief) or S(tandard) ONLY",$C(7) G PRINT
 I $E(X,1)["?" W !,"  The Standard output is the complete 1358 document, the Brief output provides",!,"  only the transaction information." G PRINT
 I "Bb"[$E(X,1) F I=1:1 D ^PRCEFIS5 K PO,IOINHI,IOINLOW,IOINORM,ZX S %A="Do you wish to view another 1358",%B="",%=1 D ^PRCFYN K:%=1 PRC("CP") G:%=1 PRINT K I G EXIT
 I '$D(PRC("SITE")) S PRCF("X")="AS" D ^PRCFSITE
 S REP="PRCEFIS4" D PRF58E^PRCE58P
REP I $D(REP) S %A="Do you wish to print another 1358",%B="",%=2 D ^PRCFYN I %=1 W !! K PRC("CP") G PRINT
EXIT K %,%DT,%ZIS,BY,C2,C3,D,DA,DHD,DIE,PRCS,PRCSQ,FLDS,REP,FR,I,IOP,L,N,TO,X,Y,PRC("CP")
 S:$D(PRCXSITE) PRC("SITE")=PRCXSITE S:$D(PRCXCP) PRC("CP")=PRCXCP K PRCXCP,PRCXSITE Q
 Q
