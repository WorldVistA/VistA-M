DDD ; GFT/DI* - Build Meta Data Dictionary ;20JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;
MAKE ;
 N DDD,FLD,Z,I,L,F D DT^DICRW
 I '$D(^DDD(0)) D ^DDDINIT Q:'$D(^DDD(0))
 G AC:$D(^DIC("AC","DDD")) W !,"SINCE NO FILE IS IN APPLICATION GROUP 'DDD',",!,"the entire FileMan database will be scanned, and"
 D OK Q:'$D(%)
 F DDD=1.99:0 S DDD=$O(^DIC(DDD)) Q:'DDD  D BLD
 G END
 ;
AC W !,"Based on all Files identified as belonging to the 'DDD' Application Group," D OK Q:'$D(%)
 F DDD=0:0 S DDD=$O(^DIC("AC","DDD",DDD)) Q:DDD=""  D BLD
END S DIK="^DDD(" D IXALL^DIK W !,"<DONE>" Q
 ;
BLD N FILE S FILE=DDD,F=$P(^DIC(DDD,0),"^")_"_"
FILE W "." F FLD=0:0 S FLD=$O(^DD(FILE,FLD)) Q:'FLD  S I=I+1 D FLD
 I $D(FILE)>9  S FILE=$O(FILE(0)) S F=FILE(FILE) K FILE(FILE) G FILE
DDDA N FN,IEN Q:'$D(^DIC("AC","DDDA",DDD))
 S FN=$$CREF^DILF(^DIC(DDD,0,"GL")),F=$P(^DIC(DDD,0),U)
 F IEN=0:0 S IEN=$O(@FN@(IEN)) Q:'IEN  S L=$P(@FN@(IEN,0),U),I=$O(^DDD("A"),-1)+1,^DDD(I,0)=F_"_"_L_U_L_U_DDD_U_.01_U_1
 Q
 ;
 ;
FLD Q:'$D(^DD(FILE,FLD,0))  S Z=^(0),%=$P(Z,U,2) I % Q:'$D(^DD(+%,.01,0))  S:$P(^(0),U,2)'["W" FILE(+%)=F_$P(Z,U)_"_"
 S ^DDD(I,0)=F_$P(Z,U)_U_$P(Z,U)_U_FILE_U_FLD
 S L=0,^DDD(I,1,0)=""
DESCR I $D(^DD(FILE,FLD,3)),^(3)]"" S L=1,^DDD(I,1,1,0)=^(3)
 F Z=0:0 S Z=$O(^DD(FILE,FLD,21,Z)) Q:'Z  S L=L+1,^DDD(I,1,L,0)=$E(" ",L=2)_^(Z,0)
 I L=0,%["P" S Z=+$P(%,"P",2) I $D(^DD(Z,.01,0)) S %=$P(^(0),U,2) N FILE,FLD S FILE=Z,FLD=.01 D DESCR
 Q
 ;
OK W !,"a Central Data Dictionary will now be compiled.",!?7,"OK"
 S %=2 D YN^DICN I %-1 K % Q
 S I=0
 S ^DDD(0)=$P(^DDD(0),U,1,2)
 N J F J=0:0 S J=$O(^DDD(J)) Q:J=""  K ^(J) ; Kill all nodes including indexes.
 Q
 ;
 ;
 ;
BUILDS(FILE,FIELD) ;BUILDs in which a field appears
 Q:'FILE!'FIELD
 N D,I,J D IJ^DIUTL(FILE) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,4,J(0),2,FILE,1,FIELD)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)
