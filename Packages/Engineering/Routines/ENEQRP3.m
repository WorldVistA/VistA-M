ENEQRP3 ;(WCIOFO)/DH-Report of High Failure Items ;10/21/1998
 ;;7.0;ENGINEERING;**14,48,59**;Aug 17, 1993
F1 ;Print list of items with high repair counts
 W @IOF,!!,"Do you wish to analyze all equipment in the inventory" S %=2 D YN^DICN Q:%=-1  I %=1 S ENDVTYP=0 G F2
 I %=0 W !!,"Alternately, you may elect to have a specific EQUIPMENT CATEGORY analyzed." R !!,"      Press <RETURN> to continue...",R:DTIME K R G F1
 S DIC="^ENG(6911,",DIC(0)="AEQM" D ^DIC G:Y<1 EXIT S ENDA=+Y,ENDVTYP=$P(^ENG(6911,ENDA,0),"^",1)
F2 S DIR("A")="Starting date for this report",DIR(0)="D^:DT:AEP" D ^DIR G:Y'>0 EXIT S ENFR=Y
 S DIR("A")="Ending date for this report",DIR(0)="D^"_ENFR_":DT:AEP" D ^DIR G:Y'>0 EXIT S ENTO=Y
 K DIR
 ;
F3 W !,"Please enter the minimum number of repair episodes necessary",!,"for inclusion in this report. (1-99 per item) " R R:DTIME E  S R="^" W *7
 G:R="^" EXIT I +R=R,R?1.2N,R>0 S ENN=R G F4
 W !!,"Enter the number of repair episodes per item necessary before that item is to",!,"be identified as meeting the failure rate criteria (whole number only).",!,*7 G F3
F4 W !,"Include all vendor activity, (work actions beginning with a 'V')" S %=2 D YN^DICN G:%=-1 EXIT
 I %=0 D  G F4
 . W !,"This report will consider all entries in the Equipment Histories that are",!,"identified as 'General Repair' items.  You may also include entries that are"
 . W !,"identified as 'Vendor Service' items by answering [Y]es at this prompt."
 S ENVEND=$S(%=1:1,1:0),ENR=0 D DEV^ENLIB G:POP EXIT
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="F5^ENEQRP3",ZTSAVE("EN*")="",ZTDESC="Equipment Failure Report" D ^%ZTLOAD K ZTSK D ^%ZISC G EXIT
F5 K ^TMP($J) W:'$D(ZTQUEUED) !!,"   compiling the data..." D @$S(ENDVTYP'=0:"ET",1:"ALL") G FAP^ENEQRP4
ET S ENR=$O(^ENG(6914,"G",ENDA,ENR)),ENH=0,ENA=0,ENSTR(ENA)="" Q:ENR=""  I '$D(ZTQUEUED),'(ENR#10) W "."
 I $D(^ENG(6914,ENR,6)) S (K,K(ENA))=0 D SEARCH
 G ET
ALL S ENR=$O(^ENG(6914,ENR)) Q:ENR'>0  I '$D(ZTQUEUED),'(ENR#10) W "."
 I $D(^ENG(6914,ENR,6)) S (ENA,ENH,K)=0,K(ENA)=0,ENSTR(ENA)="" D SEARCH
 G ALL
SEARCH S ENH=$O(^ENG(6914,ENR,6,ENH)) G:ENH SRCH1
 I ENSTR(0)]"" F J=0:1 Q:'$D(K(J))  S K=K+K(J)
 I K>(ENN-1) F J=0:1 Q:'$D(ENSTR(J))  S ^TMP($J,"ENEQFA",ENR,J)=ENSTR(J)
 K A,B,C,ENH,ENSTR,K,ENA,J Q
SRCH1 S A=^ENG(6914,ENR,6,ENH,0),B=$P(A,"^",1),C=$P(B,"-"),D=$P(B,"-",2)
 I ENFR<C,ENTO>C D
 . I D["G1"!(D["RP") D ADD Q
 . I ENVEND,D["V" D ADD
 G SEARCH
 ;
ADD S:$L(ENSTR(ENA))>200 ENA=ENA+1,ENSTR(ENA)="",K(ENA)=0
 S K(ENA)=K(ENA)+1,$P(ENSTR(ENA),"^",K(ENA))=ENH
 Q
 ;
EXIT S ENERR=0 K E,ENDA,ENDVTYP,ENFR,ENTO,ENH,ENFY,ENQT,ENR,ENSTR,ENVEND,ENA
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENEQRP3
