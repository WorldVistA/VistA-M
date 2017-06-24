TIUZRT ; DAL/GT-NDS - TIU -CALLABLE ENTRY POINTS FOR ZRT SEGEMENT ;9/6/16
 ;;1.0;TEXT INTEGRATION UTILITIES;**309**;Jun 20, 1997;Build 5
 ; 
 ; 
 Q
ZRT ;Manipulate update of MFN ZRT segment for 8926.1 file
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
    G 89261:IFN=8926.1
 Q
 ;
89261 ;Manipulate update of MFN ZRT segment for 8926.1 File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^LOINC:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=LOINC:90701,90743
 .I '$L(X)!(X="""""") D DS(8926.12,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(8926.12)) D DS(8926.12,IEN)  S XXIEN(8926.12)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(8926.12,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(8926.12,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)   S IENX="+"_I_","_IEN1_IENS,FDAA(8926.121,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 8926.121 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 Q
 ;
DS(SUBFILE,IENS) ;Delete subfile
 N ROOT,IDX,X
 S ROOT=$$ROOT^DILFD(SUBFILE,","_IENS,1)
 S IDX=0 F  S IDX=$O(@ROOT@(IDX)) Q:'IDX  D
 .N DA,DIK,DIC S DA(1)=+IENS,DA=IDX,DIK=$P(ROOT,")")_"," D ^DIK
 Q
 ;
DUP(SUB,X1,X2) ;
 ;Checkup for duplicate coding system (ICD, 10D, CPT...)
 D GETS^DIQ(IFN,IEN_",","**","","TMP") ;TMP(8926.12 - .128,"1,7,",.01)=86485   X1=CPT   X2=1234,4567,7890
 S II="" F  S II=$O(TMP(SUB,II)) Q:'II  S X3=$G(TMP(SUB,II,.01)) I $L(X3),X3=X1 D  Q
 .S ERROR="1^Error - "_II_" Duplicate Coding System"_" File #: "_IFN_" HLNODE="_HLNODE
 Q:$G(ERROR)
 ;Checkup for duplicate codes. (CPT:90701,90743,90701)
 N X6
 F I=1:1 S X5=$P(X2,",",I) Q:'$L(X5)  S X6(X5)=$G(X6(X5))+1 I X6(X5)>1 D  Q
 .S ERROR="1^Error - Duplicate Codes in Coding System"_" File #: "_IFN_" HLNODE="_HLNODE ;D ^%ZTER
 Q
 ;
M89261 ;Conversion of File: 8926.1 FIELD: 2  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"8926.12","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(8926.12,IENS,"**","","TMP") ;TMP(8926.121,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(8926.121,II)) Q:'II  S X3=$G(TMP(8926.121,II,.01)) S:$L(X3) X4=X4_X3_","
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
