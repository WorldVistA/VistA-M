PRCBMT1 ;WISC@ALTOONA/CLH-MULTIPLE TRANS CON'T ;10-3-89/2:09 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
REVIEW ;REVIEW DATA BEFORE POSTING
 I '$D(PRCB("ASK")) S %A="Do you want to review this transaction",%B="",%=1 D ^PRCFYN S:%<0 PRCB("^")="" Q:%'=1
 S:$D(PRCB("ASK")) IOP=ION K PRCB("ASK") N DA S DIC="^PRCF(421.1,",L=0,BY=".01",(TO,FR)=PRCB("TN"),FLDS="[PRCB TEMP REVIEW]" D EN1^DIP Q
EDIT I '$D(PRCB("ASK")) S %A="Do you want to edit this transaction",%B="",%=1 D ^PRCFYN S:%<0!(%=2&($D(PRCB("ERR",1)))) PRCB("^")="" K PRCB("ERR",1) S:%'=1 PRCB("ASK")="",PRCB("NOFLG")=1 Q:%'=1
 K PRCB("ASK") S DA=PRCB("TDA"),DIE="^PRCF(421.1,",DR="[PRCB ENTER TRANS]" D ^DIE K DIE D REVIEW
OUT K DIC,TO,FR,BY,L,FLDS Q
NOTE S X="Make note of this transaction number: "_PRCB("TN")_" and use for editing/posting at later time." D MSG^PRCFQ Q
PST S %A="Are you ready to post this transaction",%B="",%=1 D ^PRCFYN D:%=1  G:%=1 EN1 I %<0 S PRCB("^")="" D NOTE Q
 . D VERI^PRCBMT
 . I $D(PRCB("ERR")) W !,$C(7),"  Required data missing in this transaction" S %=2 K PRCB("ERR")
 . QUIT
 S %A="Do you want to edit this transaction",%B="",%=1 D ^PRCFYN I %<0 S PRCB("^")=""
 I %'=1 D NOTE Q
 S PRCB("ASK")="" D EDIT
 I PRCB("NOFLG")=1 Q
 G PST
 ;
EN1 S PRCB("TDA")=DA,(PRCBE,PRCBNUM)=0 F I=1:1 S PRCBNUM=$O(^PRCF(421.1,PRCB("TDA"),1,PRCBNUM)) Q:'PRCBNUM  I $D(^PRCF(421.1,PRCB("TDA"),1,PRCBNUM,0)) S PRCBE=PRCBE+1 Q
 S NXT=0 F I=1:1 S NXT=$O(^PRCF(421.1,PRCB("TDA"),1,NXT)) Q:'NXT  D GETTRAN
 I LOCKFLG'=1 S X=" <Transfer to Fund Distribution File Completed.>*" D MSG^PRCFQ W ! S PRCB("AUTOKILL")=""
 D DEL^PRCBMT,OUT^PRCBMT
 Q
GETTRAN ;GET TRANSACTION NUMBER AND POST DATA IN 421
 S:'$D(CNT) CNT=0 D SEQNUM^PRCBE I '$D(X) D GETTRAN S CNT=CNT+1 I CNT>5 W !,"Unable to get next transaction number.  Call Site manager for",!,"assistance." G OUT^PRCBMT
 S X=PRCB("TRANS"),DIC="^PRCF(421,",DLAYGO=421,DIC(0)="LOX" D ^DIC I $P(Y,"^",3)'=1 G GETTRAN
 S PRCB("PDA")=+Y,LOCKFLG=0
 L +^PRCF(421,PRCB("PDA")):5
 E  D EN^DDIOL("File in use by another user. Please try later.") S LOCKFLG=1 QUIT
 L +^PRCF(421.1,PRCB("TDA")):10
 E  D EN^DDIOL("File in use. Please try later.") L -^PRCF(421,PRCB("PDA")) S LOCKFLG=1 QUIT
 S TOREC=^PRCF(421,PRCB("PDA"),0)
 S FREC(0)=^PRCF(421.1,PRCB("TDA"),1,NXT,0)
 S $P(TOREC,"^",2)=$P(FREC(0),"^"),$P(TOREC,"^",6)=$P(^PRCF(421.1,PRCB("TDA"),0),"^",2),$P(TOREC,"^",23)=$P(FREC(0),"^",6)
 F I=2:1:5 S $P(TOREC,"^",I+5)=$P(FREC(0),"^",I)
 W !!,$P(FREC(0),U)," Filed with transaction number ",PRCB("TRANS")
 S I=$$ACC^PRC0C(PRC("SITE"),$P(TOREC,U,2)_U_PRC("FY")_U_PRC("BBFY"))
 S $P(TOREC,"^",16)=PRCF("SIFY")_"-"_$P(I,U,11)_"-"_$P(I,U,5)_"-"_$P(I,U,2)
 S $P(TOREC,"^",20)="0"
 S ^PRCF(421,PRCB("PDA"),0)=TOREC,%X="^PRCF(421.1,"_PRCB("TDA")_",2,",%Y="^PRCF(421,"_PRCB("PDA")_",1," D %XY^%RCR
 S ^PRCF(421,PRCB("PDA"),4)="0^0^0^0^"_$P(^PRCF(421.1,PRCB("TDA"),1,NXT,4),"^",5,6)
 S ^PRCF(421,"AL",PRCF("SIFY"),0,PRCB("PDA"))="",^PRCF(421,"AC",PRCF("SIFY")_"-"_+FREC(0),PRCB("PDA"))=""
 L -^PRCF(421,PRCB("PDA")),-^PRCF(421.1,PRCB("TDA"))
 Q
