DDD ;O-OIFO/GFT - Build Meta Data Dictionary ;20JAN2013
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;;12/8/2015 lg modifications to accomodate OBJECT NAME field
 ;;12/8/2015 lg added CAMCASE module
 ;;12/17/2015 removed line MAKE+2 - I '$D(^DDD(0)) D ^DDDINIT Q:'$D(^DDD(0))  ; before 12/17/2015 -lg
 ;;PARTIAL,CLEAN,ADD,GETFILES,F1,XREF modules added for partial updates ; 12/28/2015 -lg
 ;;PART(ARRAY) entry point added to send a specific list of files to update ; 12/28/15 -lg
 ;;ADDED variable STDT for start date/time to stamp LAST UPDATED field #.07 that was added to ^DD ; 12/28/15 -lg
 ;;Rearranged and separated FILELIST and PARTIAL1 code, ADDED PARTIAL2 12/29/2015
 ;
MAKE ;
 N DDD,FLD,Z,I,L,F,STDT D DT^DICRW,NOW^%DTC S STDT=% ; 12/28/15 -lg
 I '$D(^DDD(0)) W !!,"Your Meta Data Dictionary files are missing.",!,"Please contact your IRM to fix the problem and then try again.",!! Q  ;D ^DDDINIT Q:'$D(^DDD(0))
 G AC:$D(^DIC("AC","DDD")) W !,"SINCE NO FILE IS IN APPLICATION GROUP 'DDD',",!,"the entire FileMan database will be scanned, and"
 D OK Q:'$D(%)
 F DDD=1.99:0 S DDD=$O(^DIC(DDD)) Q:'DDD  D BLD
 G END
 ;
AC W !,"Based on all Files identified as belonging to the 'DDD' Application Group," D OK Q:'$D(%)
 F DDD=0:0 S DDD=$O(^DIC("AC","DDD",DDD)) Q:DDD=""  D BLD
END S DIK="^DDD(" D IXALL^DIK W !,"<DONE>"
 D NOW^%DTC S ^DDD("MSC")=%  ; stamp last run date 12/22/15 -lg
 Q
 ;
BLD N FILE S FILE=DDD,F=$P(^DIC(DDD,0),"^")_"_"
FILE W "." F FLD=0:0 S FLD=$O(^DD(FILE,FLD)) Q:'FLD  S I=I+1 D FLD,XREF:$D(PARTIAL) ; added XREF during PARTIAL 12/23/15 -lg
 I $D(FILE)>9  S FILE=$O(FILE(0)) S F=FILE(FILE) K FILE(FILE) G FILE
 Q:$D(PARTIAL)  ; 12/22/15 -lg
DDDA N FN,IEN Q:'$D(^DIC("AC","DDDA",DDD))
 S FN=$$CREF^DILF(^DIC(DDD,0,"GL")),F=$P(^DIC(DDD,0),U)
 F IEN=0:0 S IEN=$O(@FN@(IEN)) Q:'IEN  S L=$P(@FN@(IEN,0),U),I=$O(^DDD("A"),-1)+1,^DDD(I,0)=F_"_"_L_U_L_U_DDD_U_.01_U_1_U_$$CAMCASE(F_L)  ; lg 12/22/15 see FLD+1 change
 Q
 ;
FLD Q:'$D(^DD(FILE,FLD,0))  S Z=^(0),%=$P(Z,U,2) I % Q:'$D(^DD(+%,.01,0))  S:$P(^(0),U,2)'["W" FILE(+%)=F_$P(Z,U)_"_"
 S ^DDD(I,0)=F_$P(Z,U)_U_$P(Z,U)_U_FILE_U_FLD_U_U_$$CAMCASE(F_$P(Z,U))_U_STDT ; lg 12/28/15
 S L=0
DESCR I $D(^DD(FILE,FLD,3)),^(3)]"" S L=1,^DDD(I,1,1,0)=^(3)
 F Z=0:0 S Z=$O(^DD(FILE,FLD,21,Z)) Q:'Z  S L=L+1,^DDD(I,1,L,0)=$E(" ",L=2)_^(Z,0)
 I L=0,%["P" S Z=+$P(%,"P",2) I $D(^DD(Z,.01,0)) S %=$P(^(0),U,2) N FILE,FLD S FILE=Z,FLD=.01 D DESCR
 S ^DDD(I,1,0)="^^"_L_U_L_U_DT
 Q
 ;
OK W !,"a Central Data Dictionary will now be compiled."
 K %
 N DIR
 S DIR(0)="Y"
 S DIR("A")="OK"
 S DIR("B")="No"
 S DIR("?",1)="If you say YES, File .9 will be re-constructed, "
 S DIR("?",2)="using the existing field definitions in your FileMan files."
 S DIR("?")="This process will take some time and use system resources."
 D ^DIR Q:Y'=1  S %=Y
 S I=0
 S ^DDD(0)=$P(^DDD(0),U,1,2)
 N J F J=0:0 S J=$O(^DDD(J)) Q:J=""  K ^(J) ; Kill all nodes including indexes.
 Q
 ;
BUILDS(FILE,FIELD) ;BUILDs in which a field appears
 Q:'FILE!'FIELD
 N D,I,J D IJ^DIUTL(FILE) F D=0:0 S D=$O(^XPD(9.6,D)) Q:'D  I $D(^(D,4,J(0),2,FILE,1,FIELD)) N D0 S D0=D,X=$P(^XPD(9.6,D,0),U) X DICMX Q:'$D(D)
 Q  ; lg 12/08/15
 ;
FILELIST(ARRAY) ; entry point to send a specific list of files by reference to update in array(file#)=""
 ; 12/28/15
 Q:$D(ARRAY)<9
 N DDD,FLD,Z,I,L,F,PARTIAL,UFILE,KREF,STDT
 D DT^DICRW,NOW^%DTC S STDT=% ; 12/28/15 -lg
 S PARTIAL="" ; flag indicating this process is a "PARTIAL" update
 S DDD=0 F  S DDD=$O(ARRAY(DDD)) Q:'DDD  S (UFILE(DDD),KREF(DDD))="" D GETFILES(DDD) K ARRAY(DDD)
 D CLEAN,ADD
 Q
 ;
PARTIAL1 ; entry point for a partial build 12/28/15 -lg
 N DDD,FLD,Z,I,L,F,PARTIAL,UFILE,KREF,STDT D DT^DICRW,NOW^%DTC S STDT=% ; 12/28/15 -lg
 S PARTIAL="" ; flag indicating this process is a "PARTIAL" update
 S DTCHK=$G(^DDD("MSC"))  ; date of last ^DDD run (full or partial)
 F DDD=1.99:0 S DDD=$O(^DIC(DDD)) Q:'DDD  I $G(^DIC(DDD,"%MSC"))>DTCHK S (UFILE(DDD),KREF(DDD))="" D GETFILES(DDD)
 Q:'$D(UFILE)
 D CLEAN,ADD
 D NOW^%DTC S ^DDD("MSC")=%  ; stamp last run date
 Q
 ;
PARTIAL2 ; Entry point for a partial build using ^DD(FILE,FIELD,"DT") 12/29/2015 BI
 N FILE,FIELD,DTCHK,CHGDATE,TOP
 S DTCHK=$P($G(^DDD("MSC")),".",1)  ; date of last ^DDD run (FULL, PARTIAL1, or PARTIAL2)
 S FILE=$O(^DD(2),-1)
 F  S FILE=$O(^DD(FILE)) Q:'FILE  D
 . S FIELD=0
 . F  S FIELD=$O(^DD(FILE,FIELD)) Q:'FIELD  D
 .. S CHGDATE=$G(^DD(FILE,FIELD,"DT"))
 .. I (CHGDATE>DTCHK)!(CHGDATE=DTCHK) D
 ... S TOP=FILE
 ... I '$D(^DIC(TOP,0)) F  S TOP=$G(^DD(TOP,0,"UP")) Q:TOP=""  Q:$D(^DIC(TOP,0))
 ... S:TOP ARRAY(TOP)=""
 D FILELIST(.ARRAY)
 D NOW^%DTC S ^DDD("MSC")=%  ; stamp last run date
 Q
 ;
GETFILES(FILE) ; get the sub-files for the parent file during a PARTIAL update
F1 ; 12/28/15 -lg
 F FLD=0:0 S FLD=$O(^DD(FILE,FLD)) Q:'FLD  S Z=$G(^(FLD,0)),%=$P(Z,U,2) I % Q:'$D(^DD(+%,.01,0))  S:$P(^(0),U,2)'["W" (KREF(+%),FILE(+%))=""
 I $D(FILE)>9  S FILE=$O(FILE(0)) K FILE(FILE) G F1
 Q
 ;
XREF ; cross-references individual field and update the ^DDD(0) with record ien and count during PARTIAL update
 ; 12/28/15 -lg
 N DIK,DA S DA=I,DIK="^DDD(" D IX1^DIK
 S $P(^DDD(0),U,3)=I,$P(^(0),U,4)=$P(^DDD(0),U,4)+1
 Q
 ;
ADD ; add records back to MDD during a PARTIAL update
 ; 12/28/15 -lg
 N FILE S I=$O(^DDD("A"),-1)
 S DDD=0 F  S DDD=$O(UFILE(DDD)) Q:'DDD  D BLD
 Q
CLEAN ; remove existing record entries and cross-references during a PARTIAL update
 ; new records will be added for the changed file at the end of the MDD.
 ; 12/28/15 -lg
 N NODE,DIK,DA
 S DDD=0,DIK="^DDD("
 F  S DDD=$O(KREF(DDD)) Q:'DDD  S NODE="^DDD(""AFF"",DDD)" F  S NODE=$Q(@NODE) Q:$QS(NODE,2)'=DDD  S DA=$QS(NODE,4) D ^DIK
 Q
 ;
CAMCASE(INTEXT)  ; lg 12/08/15
 N X,OUTTEXT
 S INTEXT=$TR(INTEXT,".","")
 S INTEXT=$TR(INTEXT,"/\-#?$()&[]","           ")
 S OUTTEXT=""
 F X=1:1:$L(INTEXT,"_") D
 . S:X'=$L(INTEXT,"_") OUTTEXT=OUTTEXT_$$CONVERT($P(INTEXT,"_",X))_"."
 . S:X=$L(INTEXT,"_") OUTTEXT=OUTTEXT_$$CONVERT($P(INTEXT,"_",X))
 Q OUTTEXT
 ;
CONVERT(INTEXT) ; lg 12/08/15
 N X,OUTTEXT
 S INTEXT=$$TRIM^XLFSTR(INTEXT)
 S INTEXT=$$LOW^XLFSTR(INTEXT)
 S OUTTEXT=""
 F X=1:1:$L(INTEXT," ") D
 . I X=1,$P(INTEXT," ",X)'="" S OUTTEXT=OUTTEXT_$P(INTEXT," ",X)
 . I X'=1,$P(INTEXT," ",X)'="" S OUTTEXT=OUTTEXT_$$UP^XLFSTR($E($P(INTEXT," ",X),1))_$E($P(INTEXT," ",X),2,999)
 Q OUTTEXT
