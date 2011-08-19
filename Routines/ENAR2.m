ENAR2 ;(WASH ISC)/JED/DH-Archive Module ;3-9-89
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;EXPANSION OF ENAR1, CALLED BY ENAR1
ID ;DISPLAY ID INFO
 I '$D(ENDA),'($D(^ENAR(ENGBL,-1))#10) D ID1 Q
 I '$D(ENDA) S ENID=^ENAR(ENGBL,-1) S:$D(@ENID)=1 ENDA=+$P(ENID,",",4) I $D(@ENID)'=1 D ID1 Q
 I $E(IOST)'="P" S (DA,DJDN,W(1))=ENDA,(DJNM,DJSC)="ENAR",DJDIS=1 D ^ENJPARAM Q:'$D(DJRJ)  D ^ENJDPL,^ENJC2
 I $E(IOST)="P" S DIC="^ENG(6919,",DA=ENDA D EN^DIQ K DIC,DA Q
 K DA,DJCL,DJCP,DJDD,DJDIS,DJDN,DJDPL,DJEOP,DJF,DJFF,DJHIN,DJJ,DJK,DJKEY,DJRJ,DJSC,DJST,DJT,W,V Q
ID1 W !,"Insufficient data to display the ID information." Q
C ;CONFIRM ID DISPLAY
 D ID W !!!!,"Please confirm, is this the expected archive record" S %=1 D YN^DICN Q:%=1
 I %=0 W !,"The existing system archive global has the following ID information",!! G C
 S ENERR="ARCHIVE RECORD NOT CONFIRMED"
 Q
