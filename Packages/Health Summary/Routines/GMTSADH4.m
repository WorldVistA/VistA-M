GMTSADH4 ; SLC/SBW - Ad Hoc Summary Driver (Cont)      ; 07/18/2000
 ;;2.7;Health Summary;*37*;Oct 20, 1995
 ;
GETOCC ; Gets Occurrence Limit, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,2O",DIR("A")="OCCURRENCE LIMIT",DIR("B")=$P(GMTSEG(SBS),U,3)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETOCC
 S $P(GMTSEG(SBS),U,3)=Y
 Q
GETIME ; Gets Time Limit, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,3O",DIR("A")="TIME LIMIT",DIR("B")=$P(GMTSEG(SBS),U,4)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETIME
 S $P(GMTSEG(SBS),U,4)=Y
 Q
GETNAME ; Gets Header Name for Component
 N DIR,X,Y
 S DIR(0)="142.01,5O" S:$L($P(GMTSEG(SBS),U,5)) DIR("B")=$P(GMTSEG(SBS),U,5)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETIME
 S $P(GMTSEG(SBS),U,5)=Y
 Q
GETHOSP ; Gets Hospital Location displayed, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,6O",DIR("A")="Hospital Location displayed",DIR("B")=$P(GMTSEG(SBS),U,6)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETHOSP
 S $P(GMTSEG(SBS),U,6)=Y
 Q
GETICD ; Gets ICD Text displayed, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,7O",DIR("A")="ICD Text displayed",DIR("B")=$P(GMTSEG(SBS),U,7)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETICD
 S $P(GMTSEG(SBS),U,7)=Y
 Q
GETPROV ; Gets Provider Narrative displayed, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,8O",DIR("A")="Provider Narrative displayed",DIR("B")=$P(GMTSEG(SBS),U,8)
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETPROV
 S $P(GMTSEG(SBS),U,8)=Y
 Q
GETCPTM ; Gets CPT Modifier displayed, where applicable
 N DIR,X,Y
 S DIR(0)="142.01,9O",DIR("A")="CPT Modifier displayed",DIR("B")=$P(GMTSEG(SBS),U,8) S:DIR("B")="" DIR("B")="Y"
 ; DBIA 10026 call ^DIR
 D ^DIR
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DUOUT) Q
 I X["^" W "  ??" G GETCPTM
 S $P(GMTSEG(SBS),U,9)=Y
 Q
