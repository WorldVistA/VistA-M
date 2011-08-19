PRCABIL ;SF-ISC/RSD-CREATE BILL IN FILE 430 ;6/1/94  2:43 PM
V ;;4.5;Accounts Receivable;**70**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
SVC K PRCAP("S") I $D(^VA(200,DUZ,5)),$D(^DIC(49,+^(5),0)) S PRCAP("S")=+^VA(200,DUZ,5) Q
 W !,"You must be assigned a SERVICE/SECTION in the New Person file.",!?3,"See your Site Manager."
ENPOQ K DIC,DLAYGO,%DT,L,PRCAP,Z Q
EN3 ;CALLED FROM CROSS REFERENCE OF DEBTOR FIELD IN FILE 430
 Q
EN4 ;SUMS AMOUNTS FOR DESCRIPTION FIELD IN FILE 430
 S PRCAMT=0 F I=0:0 S I=$O(^PRCA(430,DA,101,I)) Q:'I  I $D(^(I,0)) S X=^(0) S:$P(X,"^",6) PRCAMT=PRCAMT+$P(X,"^",6)
 K I Q
EN5 ;CALLED FROM X-REF OF FIELD 7,MOVES DATA INTO FIELD 9
 S PRCAKCAT=$S($D(^PRCA(430.2,+$P(^PRCA(430,DA,0),U,2),0)):$P(^(0),U,6),1:"") I "OV"[PRCAKCAT K PRCAKCAT Q
 Q:'$D(^DPT(+X,0))  S PRCAK6=X,PRCAK7=DA,Z0=X_";DPT(" I $D(^RCD(340,"B",Z0)) S X=+$O(^(Z0,0)) G:$D(^RCD(340,X,0)) EN5S
 K DD,DO S DIC="^RCD(340,",DIC(0)="L",DLAYGO=340,X=Z0 D FILE^DICN K DIC,DLAYGO,DO S X=+Y,DIC=DIE
EN5S S DA=PRCAK7 I "NT"[PRCAKCAT S ^PRCA(430,"C",X,DA)="",X=PRCAK6 K PRCAK7,PRCAK6,PRCAKCAT Q
 K:$P(^PRCA(430,DA,0),U,9)]"" ^PRCA(430,"C",$P(^(0),U,9),DA) S $P(^PRCA(430,DA,0),U,9)=X,^PRCA(430,"C",X,DA)="" S X=PRCAK6 K PRCAKCAT,PRCAK6,PRCAK7,DLAYGO Q
EN6 ;SETS DIC("S") FOR DEBTOR FIELD IN FILE 430
 K DIC("S") I $D(PRCABT) D
 .I PRCABT=1!(PRCABT=2) S DIC("S")="I $P(^(0),U)[""PRC(440""!($P(^(0),U)[""DIC(4"")"
 .I PRCABT=3 S DIC("S")="I $P(^(0),U)[""VA(200""!($P(^(0),U)[""PRC(440"")"
 .Q
 S:$D(PRCAT) DIC("S")="I $P(^(0),U)["_$S("CP"[PRCAT:""";DPT""","V"[PRCAT:""";PRC""","T"[PRCAT:""";DIC(36""","N"[PRCAT:""";DIC(4""","O"[PRCAT:""";VA(200""",1:""";VA(200""!($P(^(0),U)["";PRC"")")
 I $D(PRCABT) D
 .I PRCABT=1!(PRCABT=2) S DIC("V")="I "",440,4,""[("",""_+$P(^(0),U)_"","")"
 .I PRCABT=3 S DIC("V")="I "",440,200,""[("",""_+$P(^(0),U)_"","")"
 .Q
 S:$D(PRCAT) DIC("V")="I $P(^(0),U,1,2)["_$S("CP"[PRCAT:"""2^""","V"[PRCAT:"""440""","T"[PRCAT:"""36""","N"[PRCAT:"""4^I""","O"[PRCAT:"""200""",1:"""200""!($P(^(0),U)[""440"")") Q
