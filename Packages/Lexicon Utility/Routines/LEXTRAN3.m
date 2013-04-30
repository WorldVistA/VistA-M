LEXTRAN3 ;ISL/FJF - Lexicon Process MFS Mapping Update Change ; 30 Aug 2011  12:27 AM
 ;;2.0;LEXICON UTILITY;**58**;Sep 23, 1996;Build 53
 ; Per VHA Directive 2004-038, this routine should not be modified
 ; 
 ; This routine is invoked by the entry action logic of the
 ; 'LEX MAPPING CHANGE EVENT' protocol which in turn is triggered
 ; by a new style cross-reference field monitor for the either of
 ; the two record indices 'AMAP' or 'AMAPS' on file 757.33.
 ; 
 ; External References
 ; DBIA 5782  SCTMAP^GMPLX1
 ;   
CTRL ; control
 ;
 ; check XUHUIX* arrays to see if before and after are different
 ; if they are the same then take no action
 ; XUHUIX* arrays are inherited from x-reference field monitor and 
 ; thus exist before control passes to this routine (LEXTRAN3)
 ; 
 I '$$CHANGE() Q
 ;
 ; change processing
 N PLSUB,STATUS,RECORD,SCTCDE,ICDCDE,PRFIEN,MAPID,SCTMAPID,MAPORD
 ;initiate variables
 D INIT
 ;
 ; check to ensure SNOMED CT to ICD mapping (no 1 in 757.33)
 I MAPID'=SCTMAPID Q
 ;
 ;obtain preferred term IEN
 S PRFIEN=$$PRFIEN(SCTCDE)
 ;
 ; If the status was set to 1 (active) then move concept into 
 ;   the problem list subset 
 I STATUS=1 D  Q
 .;   add concept to PLS subset, provided that it is not already
 .;   in the subset
 .I '$$INPSUB(PRFIEN,PLSUB) D ADDPLS(PRFIEN,PLSUB)
 .;
 .;   and then update file 9000011
 .D UPDPLP(SCTCDE,ICDCDE,MAPORD)
 ;
 ; Otherwise status was set to 0; thus remove concept from problem
 ;   list subset
 ;
 ;   but first check to see if concept is involved in any other mappings
 ;   if it is then do not remove from problem list subset
 I $$ACTVMAP(SCTCDE,MAPID) Q
 ;
 D DELPLS
 ;
 Q
INIT ; initiate variables
 ; 
 ; record data
 N IMIEN
 S STATUS=XUHUIX(2)
 S IMIEN=$S($D(XUHUIDA(1)):XUHUIDA(1),1:XUHUIDA)
 S RECORD=^LEX(757.33,IMIEN,0)
 S SCTCDE=$P(RECORD,U,2)
 S ICDCDE=$P(RECORD,U,3)
 S MAPID=$P(RECORD,U,4)
 S MAPORD=$P(^LEX(757.33,IMIEN,3),U)
 ;
 ; update data
 ; 
 S PLSUB=7000038 ; problem list subset
 S SCTMAPID=1 ; SNOMED to ICD9 mapping
 Q
PRFIEN(SCTCDE) ; get preferred term IEN in 757.01 for subset update 
 N NOSYNS,LEX,PRFIEN
 S NOSYNS=$$GETSYN^LEXTRAN1("SCT",SCTCDE,,,1)
 S PRFIEN=$P(LEX("P"),U,2)
 Q PRFIEN
 ;
INPSUB(PRF,SUB) ; check if concept PRF is member of subset SUB
 ;
 N IN,SIEN
 S SIEN="",IN=0
 F  S SIEN=$O(^LEX(757.21,"B",PRF,SIEN)) Q:SIEN=""  D  Q:IN=1
 .I $P(^LEX(757.21,SIEN,0),U,2)=SUB S IN=1
 Q IN
 ;
CHANGE() ; check if the after data is different from the before data
 ; i.e. detect if any change
 N XSUB,CHANGE
 S (XSUB,CHANGE)=0
 F  S XSUB=$O(XUHUIX1(XSUB)) Q:+XSUB=0  D  Q:CHANGE=1
 .I XUHUIX1(XSUB)'=XUHUIX2(XSUB) S CHANGE=1 Q
 Q CHANGE
 ;
ADDPLS(PRF,SUB) ; Add the concept to the problem list subset
 ;
 ; determine IEN for preferred term
 N FDA,ORIEN,SUBERR
 S FDA(757.21,"+1,",.01)=PRF
 S FDA(757.21,"+1,",1)=SUB
 S ORIEN(1)=$$SUBIEN()
 D UPDATE^DIE(,"FDA","ORIEN","SUBERR")
 Q
 ;
UPDPLP(SCT,ICD,ORD) ; update patient problem list file
 ; SCTMAP^GMPLX1 is a CPRS problem list function which scans the patient
 ; data file and updates the SNOMED CT code field on the basis of the
 ; mapping change
 ; 
 ; check for existence of function; if not found do not attempt to call
 I $T(SCTMAP^GMPLX1)="" Q
 D SCTMAP^GMPLX1(SCT,ICD,ORD)
 Q
 ;
DELPLS ; remove a concept from subset
 ;
 N FDA,SUBERR
 S FDA(757.21,$$DELIEN()_",",.01)="@"
 D FILE^DIE(,"FDA","SUBERR")
 Q
 ;
ACTVMAP(SRC,MAP) ; return whether active map exists for given code and
 ; mapping identifier
 ;
 N ORD,TAR,IEN,ACT,LDAT,SIEN,STAT
 S (ORD,TAR,IEN)=""
 S ACT=0
 F  S ORD=$O(^LEX(757.33,"C",MAP,SRC,ORD)) Q:ORD=""  D  Q:ACT=1
 .F  S TAR=$O(^LEX(757.33,"C",MAP,SRC,ORD,TAR)) Q:TAR=""  D  Q:ACT=1
 ..F  S IEN=$O(^LEX(757.33,"C",MAP,SRC,ORD,TAR,IEN)) Q:IEN=""  D  Q:ACT=1
 ...S LDAT=$O(^LEX(757.33,IEN,2,"B",""),-1)
 ...S SIEN=$O(^LEX(757.33,IEN,2,"B",LDAT,""))
 ...S STAT=$P(^LEX(757.33,IEN,2,SIEN,0),U,2)
 ...I STAT=1 S ACT=1
 Q ACT
 ;
SUBIEN() ; get next IEN for addition to 757.21
 ;
 N BASE,C
 S BASE=70000000,C=":"
 Q $S($O(^LEX(757.21,C),-1)<BASE:BASE,1:$O(^LEX(757.21,C),-1)+1)
 ;
DELIEN() ; determine IEN of record to be erased from 757.21
 ;
 N SSIEN,DIEN
 S (SSIEN,DIEN)=""
 F  Q:DIEN'=""  S SSIEN=$O(^LEX(757.21,"B",PRFIEN,SSIEN)) Q:SSIEN=""  D
 .I $P(^LEX(757.21,SSIEN,0),U,2)=PLSUB S DIEN=SSIEN
 Q DIEN
