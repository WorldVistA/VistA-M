DGENCDA2 ;ALB/CJM,ISA/KWP,Zoltan,JAN,CKN - Catastrophic Disabilty API - File Data;May 24, 1999,Nov 14, 2001 ; 9/22/05 5:40pm
 ;;5.3;Registration;**232,387,653**;Aug 13,1993;Build 2
 ;
STORE(DFN,DGCDIS,ERROR) ;
 ;Description: Creates a catastrophic disability record for a patient.
 ;          Attempts to add catastrophically disabled eligibility code.
 ;Input:
 ;  DFN - Patient IEN
 ;  DGCDIS - the catastrophic disability array, passed by reference
 ;Output:
 ;  Function Value - returns 1 if successful, otherwise 0
 ;  ERROR - if not successful, an error message is returned,pass
 ;          by reference
 N SUCCESS,FDA,SUB,HIEN,HSUB,FDB,NIEN,EIEN
 S SUCCESS=1
 S ERROR=""
 D  ;drops out if invalid condition found
 . I $G(DFN),$D(^DPT(DFN,0))
 . E  S SUCCESS=0,ERROR="PATIENT NOT FOUND" Q
 . I '$$LOCK^DGENCDA1(DFN) S SUCCESS=0,ERROR="RECORD IN USE, CAN NOT BE EDITED" Q
 . I '$$CHECK^DGENCDA1(.DGCDIS,.ERROR) S SUCCESS=0 Q
 . S HIEN=$P($G(^DPT(DFN,.399,0)),"^",3)+1
 . S HIEN=HIEN_","_DFN_","
 . S FDA(2,DFN_",",.39)=DGCDIS("VCD")
 . S FDB(2.399,HIEN,.39)=DGCDIS("VCD")
 . S FDA(2,DFN_",",.391)=DGCDIS("BY")
 . S FDB(2.399,HIEN,.391)=DGCDIS("BY")
 . S FDA(2,DFN_",",.392)=DGCDIS("DATE")
 . S FDB(2.399,HIEN,.392)=DGCDIS("DATE")
 . S FDA(2,DFN_",",.393)=DGCDIS("FACDET")
 . S FDB(2.399,HIEN,.393)=DGCDIS("FACDET")
 . S FDA(2,DFN_",",.394)=DGCDIS("REVDTE")
 . S FDB(2.399,HIEN,.394)=DGCDIS("REVDTE")
 . S FDA(2,DFN_",",.395)=DGCDIS("METDET")
 . S FDB(2.399,HIEN,.395)=DGCDIS("METDET")
 . S FDA(2,DFN_",",.3951)=DGCDIS("VETREQDT")
 . S FDB(2.399,HIEN,.3951)=DGCDIS("VETREQDT")
 . S FDA(2,DFN_",",.3952)=DGCDIS("DTFACIRV")
 . S FDB(2.399,HIEN,.3952)=DGCDIS("DTFACIRV")
 . S FDA(2,DFN_",",.3953)=DGCDIS("DTVETNOT")
 . S FDB(2.399,HIEN,.3953)=DGCDIS("DTVETNOT")
 . S SUB="",HSUB=0
 . S NIEN=0 F  S SUB=$O(DGCDIS("DIAG",SUB)) Q:'SUB  D
 . . I DGCDIS("DIAG",SUB)="" Q
 . . S NIEN=NIEN+1
 . . S FDB(2.396,NIEN_","_DFN_",",.01)=DGCDIS("DIAG",SUB)
 . . S HSUB=HSUB+1
 . . S FDB(2.409,HSUB_","_HIEN,.01)=DGCDIS("DIAG",SUB)
 . S NIEN=0 F  S SUB=$O(DGCDIS("PROC",SUB)) Q:'SUB  D
 . . I DGCDIS("PROC",SUB)="" Q
 . . S EIEN=0 F  S EIEN=$O(DGCDIS("EXT",SUB,EIEN)) Q:'EIEN  D
 . . . S NIEN=NIEN+1
 . . . S FDB(2.397,NIEN_","_DFN_",",.01)=DGCDIS("PROC",SUB)
 . . . S HSUB=HSUB+1
 . . . S FDB(2.409,HSUB_","_HIEN,.01)=DGCDIS("PROC",SUB)
 . . . S FDB(2.397,NIEN_","_DFN_",",1)=DGCDIS("EXT",SUB,EIEN)
 . . . S FDB(2.409,HSUB_","_HIEN,1)=DGCDIS("EXT",SUB,EIEN)
 . S NIEN=0 F  S SUB=$O(DGCDIS("COND",SUB)) Q:'SUB  D
 . . I DGCDIS("COND",SUB)="" Q
 . . S NIEN=NIEN+1
 . . S FDB(2.398,NIEN_","_DFN_",",.01)=DGCDIS("COND",SUB)
 . . S HSUB=HSUB+1
 . . S FDB(2.409,HSUB_","_HIEN,.01)=DGCDIS("COND",SUB)
 . . S FDB(2.398,NIEN_","_DFN_",",1)=DGCDIS("SCORE",SUB)
 . . S FDB(2.409,HSUB_","_HIEN,2)=DGCDIS("SCORE",SUB)
 . . S FDB(2.398,NIEN_","_DFN_",",2)=DGCDIS("PERM",SUB)
 . . S FDB(2.409,HSUB_","_HIEN,3)=DGCDIS("PERM",SUB)
 . S FDB(2.399,HIEN,.01)=$$NOW^XLFDT
 I SUCCESS D
 . N SUBFDA,SUBFILE
 . S SUCCESS=$$DELETE^DGENCDA1(DFN)
 . Q:'SUCCESS
 . D FILE^DIE("K","FDA","DGCDERR")
 . I $G(DIERR) D  Q
 . . S ERROR="FILEMAN UNABLE TO PERFORM UPDATE"
 . . S SUCCESS=0
 . . D ERRDISP^DGENCDA1(2)
 . S SUBFILE=""
 . S ERROR="FILEMAN UPDATE FAILED FOR "
 . F  S SUBFILE=$O(FDB(SUBFILE)) Q:SUBFILE=""  D  Q:'SUCCESS
 . . N IEN,NODE,ITEM
 . . S IEN=""
 . . F ITEM=0:1 S IEN=$O(FDB(SUBFILE,IEN)) Q:'IEN  D  Q:'SUCCESS
 . . . N DIC,Y,DO,DD,DINUM,DA,NODE
 . . . I SUBFILE'=2.409 D
 . . . . S NODE=SUBFILE-2
 . . . . S DIC("P")=$P($G(^DD(2,SUBFILE-2,0)),"^",2)
 . . . . S DA(1)=DFN
 . . . E  D
 . . . . S NODE=".399,"_$P(IEN,",",2)_",1"
 . . . . S DIC("P")=$P($G(^DD(2.399,.396,0)),"^",2)
 . . . . S DA(1)=$P(IEN,",",2),DA(2)=DFN
 . . . S DIC="^DPT("_DFN_","_NODE_","
 . . . S DIC(0)="L"
 . . . S X=FDB(SUBFILE,IEN,.01)
 . . . S DINUM=+IEN
 . . . D FILE^DICN
 . . . I Y=-1 S ERROR="FAILED TO ADD ENTRY TO #"_SUBFILE,SUCCESS=0
 . . Q:'SUCCESS
 . . K SUBFDA
 . . M SUBFDA(SUBFILE)=FDB(SUBFILE)
 . . D FILE^DIE("K","SUBFDA","DGCDERR")
 . . I $G(DIERR) D
 . . . S ERROR=ERROR_" #"_SUBFILE
 . . . S SUCCESS=0
 . . . D ERRDISP^DGENCDA1(SUBFILE)
 . I SUCCESS S ERROR=""
 D CLEAN^DILF
 D UNLOCK^DGENCDA1(DFN)
 Q SUCCESS
