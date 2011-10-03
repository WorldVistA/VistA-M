ENEQPMS3 ;(WASH ISC)/DH-Sort PMI Worklist ;5.15.97
 ;;7.0;ENGINEERING;**35,42**;Aug 17, 1993
SPL0 ;   For all entries?
 N ENX,ENDX,X1,X2
SPL1 W !,"For all ",$S(ENSRT="E":"ENTRY NUMBERS",ENSRT="I":"LOCAL ID's",ENSRT="L":"LOCATIONS",ENSRT="C":"EQUIPMENT CATEGORIES",ENSRT="S":"SERVICES",1:"??")
 S %=1,X="" D YN^DICN S:%<0 X="^" Q:%<0  I %<1 W !,"Please enter 'Y'es or 'N'o.",*7 G SPL1
 I %=1 D  Q
 . S ENSRT("ALL")=1
 . I ENSRT="L" D
 .. S ENSRT("LOC","ALL")=1
 .. S ENSRT("BY")="BWR" F X1="BLDG","WING","ROOM" S ENSRT(X1,"ALL")=""
 .. I $D(^ENG(6928.3,"D")) S ENSRT("BY")="DBWR",ENSRT("DIV","ALL")=""
 D @ENSRT
 I '$D(ENSRT) S X=U Q  ;Aborted location select
 I ENSRT'="L",'($D(ENSRT("FR"))&$D(ENSRT("TO"))) G SPL1
 Q
 ;
E ;  Entry numbers
 S DIC="^ENG(6914,",DIC(0)="AEQ",DIC("A")="Start with EQUIPMENT ENTRY NUMBER: "
 D ^DIC K DIC("A") Q:$D(DTOUT)!($D(DUOUT))!(Y'>0)
 S ENSRT("FR")=+Y
 S DIC("A")="Go to ENTRY NUMBER (must be larger than "_ENSRT("FR")_"): " S DIC("S")="I $P(^(0),U)>ENSRT(""FR"")"
 D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))!(Y'>0)
 S ENSRT("TO")=+Y
 Q
 ;
I ;  Local identifier
 S DIC="^ENG(6914,",ENDX="L"
I11 R !,"Start with: ",X:DTIME Q:X="^"!(X="")  S:X=" " X="?" G:$E(X)="?" I15
 S X2=$L(X) I $D(^ENG(6914,"L",X)) S ENSRT("FR")=X G I2
 I $E($O(^ENG(6914,"L",X)),1,X2)=X D IX^ENLIB1 G:X="" I11 Q:X="^"  S ENSRT("FR")=X W "   ",ENSRT("FR") G I2
 S ENX=X,ENIX=0 I X?.N D IX^ENLIB1 Q:X="^"  I $E(X,1,X2)=ENX S ENSRT("FR")=X W "   ",ENSRT("FR") G I2
 I 'ENIX W !,"No LOCAL IDENTIFIERS begin with: ",ENX
 K ENIX
I15 W !,"Would you like a list of all LOCAL IDENTIFIERS" S %=1 D YN^DICN S:%<0 X="^" Q:%<0  G:%'=1 I11
 S X="" D IX^ENLIB1 G:X="" I11 Q:X="^"  S ENSRT("FR")=X W "   ",ENSRT("FR")
I2 R !,"Go to: ",X:DTIME Q:X="^"  I $E(X)="?" W !,"Please enter a character string which follows or equals",!,ENSRT("FR")," This string will be the end point of our search." G I2
 I ENSRT("FR")]X W !,"This entry precedes ",ENSRT("FR"),".",*7 G I2
 S ENSRT("TO")=X W !,"OK. Including everything from ",ENSRT("FR")," to ",ENSRT("TO"),"."
 Q
 ;
L ;  Location
 D GEN^ENSPSRT
 Q
 ;
C ;  Equipment category
 S DIC="^ENG(6911,",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S (ENSRT("FR"),ENSRT("TO"))=+Y
 Q
 ;
S ;  Owning service
 S DIC="^DIC(49,",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S (ENSRT("FR"),ENSRT("TO"))=+Y
 Q
 ;
CONT S:$D(ENY) ENY=0 R !!,"<cr> to continue, '^' to abort...",X:DTIME
 Q
 ;ENEQPMS3
