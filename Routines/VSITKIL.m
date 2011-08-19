VSITKIL ;ISL/ARS,JVS - NON INTERACTIVE CHECK DEPENDENT ENTRY COUNT ;8/15/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
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
 N DIK,VSITKDEC,VSITKND
 S VSITKND=""
 ;
 G:VSITKDFN'=+VSITKDFN!(VSITKDFN="") XIT
 G:'$D(^AUPNVSIT(VSITKDFN,0)) XIT
 ;
 L +^AUPNVSIT(VSITKDFN):45
 S VSITKDEC=$P(^AUPNVSIT(VSITKDFN,0),"^",9)
 S VSITKND=$$DEC^VSITKIL(VSITKDFN)
 I VSITKND'=VSITKDEC,VSITKND'=$P(^AUPNVSIT(VSITKDFN,0),"^",9) S $P(^AUPNVSIT(VSITKDFN,0),"^",9)=VSITKND
 ;Check delete flag and reindex
 I VSITKND>0,$P(^AUPNVSIT(VSITKDFN,0),"^",11)=1 D
 . S $P(^AUPNVSIT(VSITKDFN,0),"^",11)=0
 . S DA=VSITKDFN
 . S DIK="^AUPNVSIT("
 . D IX^DIK
 . K DIK,DA,DR
 I VSITKND=0 D
 . S DIK="^AUPNVSIT("
 . S DA=VSITKDFN
 . D ^DIK
 . K DIK,DA
 . L -^AUPNVSIT(VSITKDFN)
 . K VSITKDFN
 E  L -^AUPNVSIT(VSITKDFN)
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
 N BECKY,COUNT,FIELD,FILE,GET,PIECE,PX,REF,SNDPIECE,STOP,SUB,VAUGHN
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
 .I $P(GET,"^",3)']"" S VDDR(FILE,SUB)=FILE_"^"_FIELD_"^"_SUB S STOP=1
 .E  S VDDN(FILE,FIELD)=""
 Q
QUE ;CHECK OUT CROSS REFERENCE
 ;
 S FILE="",FIELD="",STOP="",COUNT=0
 F  S FILE=$O(VDDR(FILE)) Q:FILE=""  D
 .S SUB=0,STOP="" F  S SUB=$O(VDDR(FILE,SUB)) Q:SUB=""  Q:STOP=1  S GET=$G(VDDR(FILE,SUB)) D
 ..S REF=$G(^DD($P(GET,"^",1),$P(GET,"^",2),1,$P(GET,"^",3),1))
 ..I $P(REF,"""",1)["DA(1)" Q
 ..S PIECE=$P(REF," ",2)
 ..S SNDPIECE=$P(PIECE,"""",1,2)_""""
 ..S VAUGHN=$P(PIECE,"""",1,2)_""")"
 ..I $D(@VAUGHN) D  S STOP=1
 ...S PX=SNDPIECE_",VISIT)"
 ...I $D(@PX) D
 ....S BECKY=0 F  S BECKY=$O(@PX@(BECKY)) Q:BECKY=""  S COUNT=COUNT+1 W:$G(VISUAL) !,"   ",SNDPIECE_","_VISIT_","_BECKY
 Q
 ;
COMP ;COMPARE DEC WITH WHAT UTILITY SAYS
 ;Call this entry point to loop through the entire file to see the
 ;dependent entry points that aren't accurate
 ;
 N CNT,DEC,DEC1,KYRON
 ;
 S CNT=0
 S KYRON=0 F  S KYRON=$O(^AUPNVSIT(KYRON)) Q:KYRON'>0  D
 .S DEC=$P(^AUPNVSIT(KYRON,0),"^",9)
 .S DEC1=$$DEC^VSITKIL(KYRON,0)
 .I DEC="",DEC1=0 ;ok, both are zero 
 .E  I DEC'=DEC1 D
 ..W !,"Visit= "_KYRON,?20,"Entry's Dependent Entry Count= "_DEC,?56,"Found= "_DEC1,?68,"BAD"
 ..S CNT=CNT+1
 ..S DEC1=$$DEC^VSITKIL(KYRON,1)
 W !!,"BAD COUNTS "_CNT
 Q
