PSGPRVR ;BIR/CML3-PROVIDER COST TOTALS ;12 DEC 97 /  9:54 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 D ENCV^PSGSETU I '$D(XQUIT) S HLP="PROVIDER" D ENDTS^PSGAMS I SD,FD D QUES I $S(PSGPRVRF="^":0,1:PSGPRVRP'="^") S RTN="PRVR" D EN3^PSGTI I 'POP,'$D(IO("Q")) D ENQ D:IO'=IO(0)!($E(IOST)'="C") ^%ZISC
 ;
DONE ;
 D ENKV^PSGSETU K DRG,DRGN,FD,ND,NF,NU,P,PRN,PR,PSGPRVRF,PSGPRVRP,PG,RTN,SD,ST,STOP,STRT,W,WN,HLP Q
 ;
ENQ ;
 K ^TMP("PSG",$J)
 F ST=SD:0 S ST=$O(^PS(57.6,ST)) Q:'ST!(ST>FD)  S W=0 F  S W=$O(^PS(57.6,ST,1,W)) Q:'W  S PR=0 F  S PR=$O(^PS(57.6,ST,1,W,1,PR)) Q:'PR  I $S('PSGPRVRF:1,1:$D(PSGPRVRF(PR))) D DRG
 S PR="" F Q=0:0 S PR=$O(^TMP("PSG",$J,PR)) Q:PR=""  S DRG="" F Q=0:0 S DRG=$O(^TMP("PSG",$J,PR,DRG)) Q:DRG=""  I '^(DRG),'$P(^(DRG),"^",2) K ^(DRG)
 D ^PSGPRVR0 K ^TMP("PSG",$J) Q
 ;
DRG ;
 S PRN=$S(PR="999Z":"UNKNOWN",1:$$ENNPN^PSGMI(PR)),DRG=0
 F  S DRG=$O(^PS(57.6,ST,1,W,1,PR,1,DRG)) Q:'DRG  I $D(^(DRG,0)) S ND=^(0),DRGN=$S(DRG="999Z":"UNKNOWN",1:$$ENDDN^PSGMI(DRG)),NF=$P($G(^PSDRUG(DRG,0)),U,9) D ADD
 Q
 ;
ADD ;
 S NU=$G(^TMP("PSG",$J,PRN,DRGN)),^(DRGN)=$P(NU,"^")+$P(ND,"^",2)-$P(ND,"^",4)_"^"_($P(NU,"^",2)+$P(ND,"^",3)-$P(ND,"^",5))_"^"_NF Q
 ;
QUES ;
 K PSGPRVRF S (PSGPRVRF,PSGPRVRP)=""
SH ;
 F  R !!,"Show ALL or SELECTED providers? ALL// ",PSGPRVRF:DTIME Q:PSGPRVRF="^"  D SHC Q:$D(PSGPRVRF)
 I PSGPRVRF="^" W !!,"...SHOW PROVIDERS not selected, report terminated..." Q
 I PSGPRVRF="A" G PAGE
 ;
SP ;
 F  W !!,"Select ",$S(PSGPRVRF>0:"another ",1:""),"PROVIDER: " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" SPH S DIC="^VA(200,",DIC(0)="QEM",DIC("S")="I $G(^(""PS""))" D ^DIC K DIC I Y>0 S PSGPRVRF=PSGPRVRF+1,PSGPRVRF(+Y)=""
 I X="^" S PSGPRVRF="^" W !!,"...PROVIDER(S) not selected, report terminated..." Q
 I 'PSGPRVRF G QUES
 S PSGPRVRP=1 Q
 ;
PAGE ;
 F  W !!,"Do you want to start a new page for each provider" S %='PSGPRVRF+1 D YN^DICN Q:%  W !!?2,"Enter 'YES' to have this report start a new page for each provider printed.",!,"Enter '^' to abort this print now."
 S PSGPRVRP=$S(%<0:"^",1:%=1) Q
 ;
SHC ;
 E  W $C(7) S PSGPRVRF="^" Q
 I PSGPRVRF="" W "  (ALL)" S PSGPRVRF="A" Q
 I PSGPRVRF?1."?" W !!?2,"Enter 'A' (or press RETURN) to show ALL providers on this report.  Enter 'S'",!,"to choose which providers you want to show on this report.",!,"PLEASE NOTE: If you choose to select which providers will print, a new "
 I  W "page",!,"will automatically be started for each provider." K PSGPRVRF Q
 F X="SELECTED","ALL" I $P(X,PSGPRVRF)="" W $P(X,PSGPRVRF,2) S PSGPRVRF=$E(PSGPRVRF) Q
 E  W $C(7),"  ??" K PSGPRVRF
 Q
 ;
SPH ;
 W !!?2,"Select a PROVIDER for which you wish to have cost data print." Q
