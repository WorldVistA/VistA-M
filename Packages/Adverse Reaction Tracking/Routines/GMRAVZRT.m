GMRAVZRT ;FOBP/CLT - ALLERGIES - CALLABLE ENTRY POINTS FOR ZRT SEGMENT ; 14 Oct 2016  12:56 PM
 ;;4.0;GEN. MED. REC. - ALLERGIES;**55**;Mar 29, 1996;Build 9
 ;
 ;
 Q
ZRT ;Manipulate update of MFN ZRT segment for 120.82,120.83 files
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
 G 12082:IFN=120.82,12083:IFN=120.83
 Q
 ;
12082 ;Manipulate update of MFN ZRT segment for 120.82 File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA,X5
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^LOINC:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=LOINC:90701,90743
 .I '$L(X)!(X="""""") D DS(120.822,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(120.822)) D DS(120.822,IEN)  S XXIEN(120.822)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(120.822,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(120.822,"+1,"_IENS,.01)=X1 I X1[":"
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)   S IENX="+"_I_","_IEN1_IENS,FDAA(120.8221,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR") I $D(ERR)
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 120.8221 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 Q
 ;
12083 ;Manipulate update of MFN ZRT segment
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA,X5
 I IEN,NAME="VistA_Mapping_Target" D  Q  ;ZRT^VistA_CodingSystem_Mapping^SNOMED:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=SMOMED:90701,90743
 .I '$L(X)!(X="""""") D DS(120.833,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(120.833)) D DS(120.833,IEN)  S XXIEN(120.833)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(120.833,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(120.833,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)   S IENX="+"_I_","_IEN1_IENS,FDAA(120.8331,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 120.8331 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 ;I IEN,NAME="has_qualifier" D  Q  ;
 ;.I $P(HLNODE,HLFS,3)="""""" D DS(120.831,IEN) S OUT=1 Q
 ;.I '$G(XXIEN(120.831)) D DS(120.831,IEN)  S XXIEN(120.831)=1 ;CLEAN SUBFILE ENTRY
 Q
 ;
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
 D GETS^DIQ(IFN,IEN_",","**","","TMP") ;TMP(120.822 - .128,"1,7,",.01)=86485   X1=CPT   X2=1234,4567,7890
 S II="" F  S II=$O(TMP(SUB,II)) Q:'II  S X3=$G(TMP(SUB,II,.01)) I $L(X3),X3=X1 D  Q
 .S ERROR="1^Error - "_II_" Duplicate Coding System"_" File #: "_IFN_" HLNODE="_HLNODE
 Q:$G(ERROR)
 ;Checkup for duplicate codes. (CPT:90701,90743,90701)
 N X6
 F I=1:1 S X5=$P(X2,",",I) Q:'$L(X5)  S X6(X5)=$G(X6(X5))+1 I X6(X5)>1 D  Q
 .S ERROR="1^Error - Duplicate Codes in Coding System"_" File #: "_IFN_" HLNODE="_HLNODE ;D ^%ZTER
 Q
M12082 ;Conversion of File: 120.82 FIELD: 8  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"120.822","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(120.822,IENS,"**","","TMP") ;TMP(120.8221,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(120.8221,II)) Q:'II  S X3=$G(TMP(120.8221,II,.01)) S:$L(X3) X4=X4_X3_","
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
M12083 ;Conversion of File:120.83 FIELD: 2  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"120.833","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(120.833,IENS,"**","","TMP") ;TMP(120.8331"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(120.8331,II)) Q:'II  S X3=$G(TMP(120.8331,II,.01)) S:$L(X3) X4=X4_X3_","
 ;S X4=$S($L(X3):$E(X4,1,$L(X4)-1),1:"") S TMP1(LEV,X2,IENS,I)=X4
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
 ;Discovery coding
DFORALL(FILE,SF1,SF2,VMT) ; Discovery coding for all files.
 ;FILE = 120.82
 ;SF1 = 120.822
 ;SF2 = 120.8221
 ;VMT = VistA_Mapping_Target
 S VMT=$G(VMT,"VistA_Mapping_Target")
 N TMP,II,CNT,VAL,VAL1,X1,X2,X3,IEN
 S CNT=0,(VAL,VAL1)=""
 F  S CNT=$O(^TMP("HLA",$J,CNT)) Q:'CNT  S II=$G(^TMP("HLA",$J,CNT)) Q:'$L(II)  Q:$G(ERROR)  D
 .D:$P(II,HLFS)="MFE"
 ..S IEN=$P(II,HLFS,5),IEN=$P(IEN,"@",2),IEN=$O(^GMRD(FILE,"AVUID",IEN,0)) Q:'IEN
 ..K TMP D GETS^DIQ(FILE,IEN_",","**","","TMP","ERR") I $D(ERR) S ERROR="1^Error retrieving "_FILE_" GETS^DIQ data for IEN="_IEN_" "_II Q
 .D:$P(II,HLFS,2)=VMT  ;II=ZRT^VistA_Mapping_Target^CPT
 ..S VAL=$P(II,HLFS,3),X1="",X2="" ;VAL=CPT
 ..F  S X1=$O(TMP(SF1,X1)) Q:'$L(X1)  D:TMP(SF1,X1,.01)=VAL DSF(SF2)
 Q
DSF(SF) ;Discovery Processing Subfile
 S VAL1=VAL F  S X2=$O(TMP(SF,X2)) Q:'$L(X2)  D:$P(X2,",",2,99)=X1
 .S X3=$G(TMP(SF,X2,.01)) Q:'$L(X3)  S:VAL1'[":" VAL1=VAL1_":" S VAL1=VAL1_X3_","
 Q:'$L(VAL1)  Q:(VAL=VAL1)  S VAL1=$E(VAL1,1,$L(VAL1)-1) S $P(II,HLFS,3)=VAL1,^TMP("HLA",$J,CNT)=II
 Q
