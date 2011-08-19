FHASE3 ; HISC/REL - Encounter Utilities ;5/7/92  08:46
 ;;5.5;DIETETICS;;Jan 28, 2005
FIL ; File encounter - DTE date/time   S1 enc. ident   S2 I/F   S3 comment
 S S1=$O(^FH(115.6,"AX",S1,"")) Q:S1<1
 K DIC,DD,DO S DIC="^FHEN(",DIC(0)="L",DLAYGO=115.7
F1 L +^FHEN(0) S DA=$P(^FHEN(0),"^",3)+1 I $D(^FHEN(DA)) S $P(^FHEN(0),"^",3)=DA L -^FHEN(0) G F1
 ;
 S (X,FHDA,DINUM)=DA D FILE^DICN L -^FHEN(0) S ASE=+Y K DIC,DLAYGO,DINUM
 S DTE=+DTE,S4=$S(S2="I":3,1:4),S4=$S($D(^FH(115.6,S1,0)):$P(^(0),"^",S4),1:0)
 S S5=$G(^DPT(DFN,.1)) S:S5'="" S5=$O(^DIC(42,"B",S5,0)) S S5=$G(^DIC(42,+S5,44))
 S ^FHEN(ASE,0)=ASE_"^"_DTE_"^"_DUZ_"^"_S1_"^^^"_S2_"^"_S4_"^I^1^^^"_DUZ_"^"_NOW
 S ^FHEN(ASE,"P",0)="^115.701P^"_DFN_"^1"
 S ^FHEN(ASE,"P",DFN,0)=DFN_"^"_S5_"^^"_S3
 S ^FHEN(ASE,"P","B",DFN,DFN)="",^FHEN("AP",DFN,DTE,ASE)="",^FHEN("AT",DTE,ASE)=""
 ;
 ; IF MULTIDIVISIONAL SITE STORE COMMUNICATIONS OFFICE CODE
 I $P($G(^FH(119.9,1,0)),U,20)'="N" D
 .S DA=FHDA,DIE="^FHEN(",DR="11////^S X=FHCOMM"
 .D ^DIE
 ;
 K ASE,DTE,S1,S2,S3,S4,S5 Q
