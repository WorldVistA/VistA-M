GMRVVZRT ;DAL/GT-NDS VITAL SIGNS-CALLABLE ENTRY POINTS FOR ZRT SEGEMENT ;3/21/16
 ;;5.0;GEN. MED. REC. - VITALS;**30**;MAR 21, 2016;Build 14
 ;
 ; This routine uses the following IAs:
 ;  #6360 - FILE 120.51 CODING SYSTEM
 ;  #6361 - FILE 120.52 CODING SYSTEM
 ;  #6362 - FILE 120.53 CODING SYSTEM
 ;
 Q
ZRT ;Manipulate update of MFN ZRT segment for 120.51,120.52,120.53 files
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
    G 12051:IFN=120.51,12052:IFN=120.52,12053:IFN=120.53
 Q
 ;
12051 ;Manipulate update of MFN ZRT segment for 120.51 File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^LOINC:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=LOINC:90701,90743
 .I '$L(X)!(X="""""") D DS(120.518,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(120.518)) D DS(120.518,IEN)  S XXIEN(120.518)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(120.518,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(120.518,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)   S IENX="+"_I_","_IEN1_IENS,FDAA(120.5181,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 120.5181 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 Q
 ;
12052 ;Manipulate update of MFN ZRT segment
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^SNOMED:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=SMOMED:90701,90743
 .I '$L(X)!(X="""""") D DS(120.522,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(120.522)) D DS(120.522,IEN)  S XXIEN(120.522)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(120.522,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(120.522,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)   S IENX="+"_I_","_IEN1_IENS,FDAA(120.5221,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 120.5221 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 ;I IEN,NAME="has_qualifier" D  Q  ;
 ;.I $P(HLNODE,HLFS,3)="""""" D DS(120.521,IEN) S OUT=1 Q
 ;.I '$G(XXIEN(120.521)) D DS(120.521,IEN)  S XXIEN(120.521)=1 ;CLEAN SUBFILE ENTRY
 Q
 ;
12053 ;Manipulate update of MFN ZRT segment for 120.53 File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^SNOMED:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=SMOMED:90701,90743
 .I '$L(X)!(X="""""") D DS(120.532,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(120.532)) D DS(120.532,IEN)  S XXIEN(120.532)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(120.532,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(120.532,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)  S IENX="+"_I_","_IEN1_IENS,FDAA(120.5321,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 120.5321 HLNODE:"_HLNODE
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
 D GETS^DIQ(IFN,IEN_",","**","","TMP") ;TMP(120.518 - .128,"1,7,",.01)=86485   X1=CPT   X2=1234,4567,7890
 S II="" F  S II=$O(TMP(SUB,II)) Q:'II  S X3=$G(TMP(SUB,II,.01)) I $L(X3),X3=X1 D  Q
 .S ERROR="1^Error - "_II_" Duplicate Coding System"_" File #: "_IFN_" HLNODE="_HLNODE
 Q:$G(ERROR)
 ;Checkup for duplicate codes. (CPT:90701,90743,90701)
 N X6
 F I=1:1 S X5=$P(X2,",",I) Q:'$L(X5)  S X6(X5)=$G(X6(X5))+1 I X6(X5)>1 D  Q
 .S ERROR="1^Error - Duplicate Codes in Coding System"_" File #: "_IFN_" HLNODE="_HLNODE ;D ^%ZTER
 Q
M12051 ;Conversion of File: 120.51 FIELD: 8  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"120.518","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(120.518,IENS,"**","","TMP") ;TMP(120.5181,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(120.5181,II)) Q:'II  S X3=$G(TMP(120.5181,II,.01)) S:$L(X3) X4=X4_X3_","
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
M12052 ;Conversion of File:120.52 FIELD: 2  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"120.522","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(120.522,IENS,"**","","TMP") ;TMP(120.5221"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(120.5221,II)) Q:'II  S X3=$G(TMP(120.5221,II,.01)) S:$L(X3) X4=X4_X3_","
 ;S X4=$S($L(X3):$E(X4,1,$L(X4)-1),1:"") S TMP1(LEV,X2,IENS,I)=X4
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
M12053 ;Conversion of File:120.53 FIELD: 2  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"120.532","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(120.532,IENS,"**","","TMP") ;TMP(120.5321,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(120.5321,II)) Q:'II  S X3=$G(TMP(120.5321,II,.01)) S:$L(X3) X4=X4_X3_","
 ;S X4=$S($L(X3):$E(X4,1,$L(X4)-1),1:"") S TMP1(LEV,X2,IENS,I)=X4
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
