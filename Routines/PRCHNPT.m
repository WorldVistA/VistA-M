PRCHNPT ;SF/TKW-INPUT TRANSFORM ;9-1-89/1:58 PM
V ;;5.1;IFCAP;**108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified
EN1 ;INPUT TRANSFORM FOR NSN (FIELD #5) ON ITEM MASTER FILE (441)
 Q:'$D(X)  I '$D(^PRC(441.2,+X,0)) W $C(7),!,"First 4 digits MUST be an FSC code!!" K X Q
 S Z=$O(^PRC(441,"BB",X,0)) S:Z=DA Z=$O(^(DA)) I Z W $C(7),!,"This NSN has already been assigned to Item # "_Z_"!!" K X,Z Q
 K Z Q
 ; --------------------
 ; *108 - additional Input Transform code and Executable Help code added 4/6/2007 by T. Holloway
 ;
CONTRACT(PRCDA1,PRCINPUT) ; 443.6 : 443.61 : 4 - CONTRACT/BOA # Input Transform
 ; PRCDA1 = the IEN for file 443.6 passed in from the DA(1) variable.
 ; PRCINPUT = the user input passed in from the X variable
 N D,DA,DIC,DR,X
 S X=PRCINPUT
 S DA(1)=+$P(^PRC(443.6,PRCDA1,1),U)
 S DIC="^PRC(440,DA(1),4,",DIC(0)="QELM"
 D ^DIC K DIC
 Q Y
 ;
HLPCON(PRCDA1,PRCINPUT) ; 443.6 : 443.61 : 4 - CONTRACT/BOA # Executable Help
 ; PRCDA1 = the IEN for file 443.6 passed in from the DA(1) variable.
 ; PRCINPUT = the user input passed in from the X variable, will be some form of ?.
 N D,DA,DIC,DR,X,Y,Z1
 S X=PRCINPUT
 S DA(1)=+$P(^PRC(443.6,PRCDA1,1),U),Z1=$P(^(1),U,7)
 I '$D(^PRC(440,DA(1),4,0)) Q
 S DIC("S")=$S(Z1=2:"I $P(^PRC(440,DA(1),4,+Y,0),U,6)'=""B""",1:"I 1")
 S DIC="^PRC(440,DA(1),4,",DIC(0)="QEM" D ^DIC
 Q
