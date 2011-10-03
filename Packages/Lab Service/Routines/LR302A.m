LR302A ;DALOI/FHS - LR*5.2*302 SAVE POINTER VALUES PREINSTAL;29-APR-2004
 ;;5.2;LAB SERVICE;**302**;Sep 27,1994
 ;Saves the pointer values for the globals being deleted. The post
 ;routine will restore the cooresponding pointers to the installed file.
EN ;
 I $G(^XTMP("LR302",1,0)) D  Q  ;Indicates the pointers have already been saved.
 . D BMES^LR302("Historical data previously saved")
 ;
 I '$G(LRDBUG) K ^XTMP("LR302")
 S ^XTMP("LR302",0)=$$FMADD^XLFDT(DT,90)_U_DT_U_"LR302 PreInstall Historical Resolved Data"
 ;
 N ERR,FILE,FLD,FLD2,FLD9,FLDP,FLDV,IEN,IEN2,LNC,LRD,LRI,LRI2,LRI3,OUT
SAVE642 ;Save a copy ^LAB(64.2 for checking later
 D
 . N LAST
 . Q:$G(^XTMP("LRNLT642",.01))
 . K ^XTMP("LRNLT642")
 . S LAST=$O(^LAB(64.2,99999),-1)
 . S ^XTMP("LRNLT642",.01)=LAST
 . S ^XTMP("LRNLT642",0)=$$HTFM^XLFDT($H+90,1)_U_DT_U_"LAB(64.2 Save"
 . M ^XTMP("LRNLT642",1)=^LAB(64.2)
60 ;Save values for file # 60.01,95.3
 D PRT(60)
 K ^XTMP("LR302",60.01),IEN,IEN2,FLD
 S FLD=95.3
 S IEN=0 F  S IEN=$O(^LAB(60,IEN)) Q:IEN<1  D
 . S IEN2=0 F  S IEN2=$O(^LAB(60,IEN,1,IEN2)) Q:IEN2<1  D
 . . D SAVE(60.01,IEN2_","_IEN_",",FLD,95.3)
 Q:$G(LRDBUG)
61 ;Save values from ^LAB(61  fields .09,.0961
 D PRT(61)
 K ^XTMP("LR302",61),OUT,ERR
 S FLD=".09;.0961"
 S LRI=0 F  S LRI=$O(^LAB(61,LRI)) Q:LRI<1  D
 . D SAVE(61,LRI_",",FLD,"")
 Q:$G(LRDBUG)
6205 ;Save values from ^LAB(62.05 field 4
 D PRT(62.05)
 K ^XTMP("LR302",62.05),OUT,ERR
 S FLD=4,LRI=0
 F  S LRI=$O(^LAB(62.05,LRI)) Q:LRI<1  D
 . D SAVE(62.05,LRI_",",FLD,"")
 Q:$G(LRDBUG)
624 ;Extract data from ^LAB(62.4, field .14
 D PRT(62.4)
 K FLD,IEN,^XTMP("LR302",62.4)
 S FLD=.14
 S IEN=0 F  S IEN=$O(^LAB(62.4,IEN)) Q:IEN<1  D
 . D SAVE(62.4,IEN_",",FLD,"")
 Q:$G(LRDBUG)
628 ;Save values from ^LAHM(62.8  fields 1.13,1.23,2.13,2.23,2.33
 D PRT(62.8)
 K OUT,ERR,FLD,FLD9,VAL,FLDV,IENX
 K ^XTMP("LR302",62.801)
 S FLD9="1.14;1.24;2.14;2.24;2.34",IEN=0
 S FLD="1.13;1.23;2.13;2.23;2.33"
 F  S IEN=$O(^LAHM(62.8,IEN)) Q:IEN<1  D
 . S IEN2=0 F  S IEN2=$O(^LAHM(62.8,IEN,10,IEN2)) Q:IEN2<1  D
 . . S IENX=IEN2_","_IEN_"," D SAVE(62.801,IENX,FLD,"")
 . . D SAVE(62.801,IENX,FLD9,95.3)
 Q:$G(LRDBUG)
6285 ;Extract data from ^LAHM(62.85  field .05
 D PRT(62.85)
 K IEN,FLD,OUT,ERR
 K ^XTMP("LR302",62.85)
 S IEN=0,FLD=.05 F  S IEN=$O(^LAHM(62.85,IEN)) Q:IEN<1  D
 . D SAVE(62.85,IEN_",",FLD,"")
 Q:$G(LRDBUG)
629 ; Extract data from ^LAHM(62.9,,60 fields 1.15,1.25,2.15,2.25,2.35
 D PRT(62.9)
 K IEN,IEN2,IENX,FLD,FLD9,OUT,ERR
 K ^XTMP("LR302",62.9001)
 S FLD="1.15;1.25;2.15;2.25;2.35"
 S FLD9="1.16;1.26;2.16;2.26;2.36",IEN=0
 F  S IEN=$O(^LAHM(62.9,IEN)) Q:IEN<1  D
 . S IEN2=0  F  S IEN2=$O(^LAHM(62.9,IEN,60,IEN2)) Q:IEN2<1  D
 . . S IENX=IEN2_","_IEN_"," D SAVE(62.9001,IENX,FLD,"")
 . . D SAVE(62.9001,IENX,FLD9,95.3)
 Q:$G(LRDBUG)
 G 642
6402 ;Save values from ^LAM(IEN,5,IEN2,1 fields
 N FLD2,OUT,ERR,LRD,IEN2,LRI2,LRI3
 S FLD2=".01;1"
 S LRI2=0 F  S LRI2=$O(^LAM(LRI,5,LRI2)) Q:LRI2<1  D
 . S LRI3=0 F  S LRI3=$O(^LAM(LRI,5,LRI2,1,LRI3)) Q:LRI3<1  D
 . . S IEN2=LRI3_","_LRI2_","_LRI_","
 . . D SAVE(64.02,IEN2,4,95.3)
 . . D SAVE(64.02,IEN2,FLD2,"")
 Q
642 ;Save values from ^LAB(64.2  1,4,7,8,9,15
 D PRT(64.2)
 K FLD,IEN,^XTMP("LR302",64.2)
 S FLD="1;4;7;8;9;15"
 S IEN=0 F  S IEN=$O(^LAB(64.2,IEN)) Q:IEN<1  D
 . D SAVE(64.2,IEN_",",FLD,"")
 Q:$G(LRDBUG)
682 ;Extract date for ^LRO(68.2,  field .14
 D PRT(68.2)
 K FLD,IEN,^XTMP("LR302",68.2)
 S FLD=.14
 S IEN=0 F  S IEN=$O(^LRO(68.2,IEN)) Q:IEN<1  D
 . D SAVE(68.2,IEN_",",FLD,"")
 Q:$G(LRDBUG)
696 ;
 D PRT(69.6)
 K FLD,FLD2,IEN,IEN2
 K ^XTMP("LR302",69.6),^(69.64)
 S FLD=6,FLD2=5,IEN=0
 F  S IEN=$O(^LRO(69.6,IEN)) Q:IEN<1  D
 . D SAVE(69.6,IEN_",",FLD,"")
 . S IEN2=0 F  S IEN2=$O(^LRO(69.6,IEN,2,IEN2)) Q:IEN2<1  D
 . . D SAVE(69.64,IEN2_","_IEN_",",FLD2,"")
 Q:$G(LRDBUG)
 S ^XTMP("LR302",1,0)=$$NOW^XLFDT_U_"Historical pointers saved"
 Q
SAVE(FILE,IENX,FLD,LNC) ;Save Data  (FILE #,IEN,Fields,95.3)
 K OUT,ERR,VAL,FLDP,FLDV
 I $G(IEN),(IEN#400=0) W "."
 D GETS^DIQ(FILE,IENX,FLD,"E","OUT","ERR")
 F FLDP=1:1 S FLDV=$P(FLD,";",FLDP) Q:'$L(FLDV)  D
 . S VAL=$G(OUT(FILE,IENX,FLDV,"E")) I $L(VAL) D
 . . S ^XTMP("LR302",FILE,IENX,FLDV)=$S(LNC=95.3:+VAL,1:VAL)
 Q
PRT(FILE) ;Display file name
 D BMES^LR302("Saving File #"_FILE_" data.")
 W !
 Q
