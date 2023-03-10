VSITKIL ;ISL/ARS,JVS - NON INTERACTIVE CHECK DEPENDENT ENTRY COUNT ;May 17, 2017@12:01
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,204,211**;Aug 12, 1996;Build 454
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**1,2**;Aug 12, 1996
 ;;
KILL(VSITKDFN) ; ENTER THE VSIT YOU WANT CHECKED SET VSITKDFN=IEN
 ;  VSITKDFN = Vsit Ien   REQUIRED
 ;
 N DIK,VSITKDEC,VSITKND,LOCK,ERROR
 S VSITKND=""
 G:$G(VSITKDFN)'?1.N XIT
 G:$D(^XTMP("AUPNVSIT",VSITKDFN)) XIT
 S LOCK=$$LOCK^PXLOCK(VSITKDFN,DUZ,2,.ERROR,"VSITKIL")
 G:'LOCK XIT
 I '$D(^AUPNVSIT(VSITKDFN,0)) D UNLOCK^PXLOCK(VSITKDFN,DUZ,"VSITKIL") G XIT
 ;
 S VSITKDEC=$P(^AUPNVSIT(VSITKDFN,0),U,9)
 S VSITKND=$$DEC^VSITKIL(VSITKDFN)
 I VSITKND'=VSITKDEC S $P(^AUPNVSIT(VSITKDFN,0),U,9)=VSITKND,VSITKDEC=VSITKND
 ;Check delete flag and reindex
 I VSITKND>0,$P(^AUPNVSIT(VSITKDFN,0),U,11)=1 D
 . S $P(^AUPNVSIT(VSITKDFN,0),U,11)=0
 . S DA=VSITKDFN
 . S DIK="^AUPNVSIT("
 . D IX^DIK
 . K DIK,DA,DR
 I VSITKND=0 D
 . S DIK="^AUPNVSIT("
 . S DA=VSITKDFN
 . D ^DIK
 . K DIK,DA
 . D UNLOCK^PXLOCK(VSITKDFN,DUZ,"VSITKIL")
 . K VSITKDFN
 E  D UNLOCK^PXLOCK(VSITKDFN,DUZ,"VSITKIL")
XIT ;exit
 Q VSITKND
 ;
DOC ;  This routine checks the dependent entry count of the VISIT file for
 ;  accuracy.  If it is not correct it is replaced with a correct count
 ;  The count is determined by scanning each of the VISIT related
 ;  files for entries that point to that VISIT.  A count is incremented
 ;  each time a "hit" is made.  
 ; The user can enter the visit IEN and if there is not any entries 
 ;  pointing to the entry it is deleted. (not logically but totally)
 Q
 ;
DEC(VISIT,VISUAL) ;Test looking through DD to find fields pointing to the visit entries.
 ; VISIT=Visit ien to looked up and counted
 ; VISUAL= Set to 1 if you want and interactive display of what is found
 ;
 ; Look for file and field
 ;
 N COUNT,FIELD,FILE,GET,PIECE,PX,REF,SNDPIECE,STOP,SUB,VAUGHN
 N VDD,VDDN,VDDR
 ;
 S FILE=""
 F  S FILE=$O(^DD(9000010,0,"PT",FILE)) Q:FILE=""  D
 .S FIELD=""
 .F  S FIELD=$O(^DD(9000010,0,"PT",FILE,FIELD)) Q:FIELD=""  D
 ..S VDD(FILE,FIELD)=""
 D REF,QUE
 K VDDN,VDDR
 I $G(VISUAL) W !,"COUNT= "
 Q COUNT
 ;
REF ;Look for all of the regular cross references and other
 ;
 S FILE="" F  S FILE=$O(VDD(FILE)) Q:FILE=""  D
 .S FIELD="" F  S FIELD=$O(VDD(FILE,FIELD)) Q:FIELD=""  D
 ..D REG
 K VDD
 Q
 ;
REG ;Look for regular cross references
 ;
 S STOP=0
 I '$D(^DD(FILE,FIELD,1)) S VDDN(FILE,FIELD)="" Q
 S SUB=0 F  S SUB=$O(^DD(FILE,FIELD,1,SUB)) Q:SUB=""  D
 .S GET=$G(^DD(FILE,FIELD,1,SUB,0))
 .I $P(GET,U,3)']"" S VDDR(FILE,SUB)=FILE_U_FIELD_U_SUB S STOP=1
 .E  S VDDN(FILE,FIELD)=""
 Q
QUE ;CHECK OUT CROSS REFERENCE
 ;
 S FILE="",FIELD="",COUNT=0
 F  S FILE=$O(VDDR(FILE)) Q:FILE=""  D
 .S SUB=0 F  S SUB=$O(VDDR(FILE,SUB)) Q:SUB=""  S GET=$G(VDDR(FILE,SUB)) D
 ..S REF=$G(^DD($P(GET,U,1),$P(GET,U,2),1,$P(GET,U,3),1))
 ..I $P(REF,"""",1)["DA(1)" Q
 ..S PIECE=$P(REF," ",2)
 ..S SNDPIECE=$P(PIECE,"""",1,2)_""""
 ..S VAUGHN=$P(PIECE,"""",1,2)_""")"
 ..I $D(@VAUGHN) D
 ...S PX=SNDPIECE_",VISIT)"
 ...I $D(@PX) S COUNT=COUNT+$$COUNT(PX)
 Q
 ;
COUNT(NPX,UPPER) ;COUNT ENTRIES IN FILES AND SUB-FILES
 N LEVEL,TOTAL
 I $G(UPPER)'="" S NPX=$P(NPX,")")_","_UPPER_")"
 S LEVEL=0 F  S LEVEL=$O(@NPX@(LEVEL)) Q:'+LEVEL  D
 .I $D(@NPX@(LEVEL))>9 S TOTAL=$G(TOTAL)+$$COUNT(NPX,LEVEL)
 .I $D(@NPX@(LEVEL))<10 S TOTAL=$G(TOTAL)+1 W:$G(VISUAL) !,"   ",$P($NA(@NPX),")")_","_LEVEL
 Q +$G(TOTAL)
COMP ;COMPARE DEC WITH WHAT UTILITY SAYS
 ;Call this entry point to loop through the entire file to see the
 ;dependent entry points that aren't accurate
 ;
 N CNT,DEC,DEC1,KYRON
 ;
 S CNT=0
 S KYRON=0 F  S KYRON=$O(^AUPNVSIT(KYRON)) Q:KYRON'>0  D
 .S DEC=$P(^AUPNVSIT(KYRON,0),U,9)
 .S DEC1=$$DEC^VSITKIL(KYRON,0)
 .I DEC="",DEC1=0 ;ok, both are zero 
 .E  I DEC'=DEC1 D
 ..W !,"Visit= "_KYRON,?20,"Entry's Dependent Entry Count= "_DEC,?56,"Found= "_DEC1,?68,"BAD"
 ..S CNT=CNT+1
 ..S DEC1=$$DEC^VSITKIL(KYRON,1)
 W !!,"BAD COUNTS "_CNT
 Q
