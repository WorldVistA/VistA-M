PRCHCARD ;WISC/AKS-Purchase Card Reconciliation Report ;
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRCHFR,PRCHTO,FR,TO,L,DIC,BY,FLDS,Y,FROM,LASTTO,DIS,PRCF
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 S DIR(0)="F",DIR("?")="This is the valid Fund Control Point."
 S DIR("A")="START WITH FCP",DIR("B")="FIRST" D ^DIR Q:X["^"
 S (FROM,PRCHFR)=Y I Y?1.N S PRCHFR=Y_" "
 I Y="FIRST" S PRCHFR="" K DIR,X
 S (PRCHTO,LASTTO)="" I $G(Y)'="FIRST" D LAST Q:X["^"
PRINT I FROM]LASTTO S PRCHTO=LASTTO
 S FR=PRCHFR_",?,?",TO=PRCHTO_",?,?"
 S L=0,DIC=442,BY="[PRCH CREDIT SORT]"
 S DIS(0)="I $P(^PRC(442,D0,0),U,2)=25"
 S FLDS="[PRCH CARD PRINT" D EN1^DIP
 I PRCHFR]"",PRCHTO]"",FROM]LASTTO D LAST Q:X["^"  G PRINT
 QUIT
LAST S DIR(0)="F",DIR("?")="This is the valid Fund Control Point."
 S DIR("A")="GO TO FCP",DIR("B")="LAST" D ^DIR Q:X["^"
 S (LASTTO,PRCHTO)=Y
 I Y?1.N S PRCHTO=Y_"z"
 I Y="LAST" S PRCHTO="" K DIR
 Q
