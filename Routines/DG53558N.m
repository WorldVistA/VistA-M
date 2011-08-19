DG53558N ;ALB/GN/GTS - DG*5.3*558 CLEANUP FOR DUPE MEANS TEST FILE (cont) ; 12/14/05 15:47pm
 ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
CLNDUPS(DFN) ;
 ;This code was removed from DG53558 and added here to allow expansion of code in DG53558.
 ;Entry point to drive through TMP array and delete all Duplicates except last one per day per status
 ; INPUT - DFN : Patient file IEN
 ;       - Several local variables
 ;
 ; OUTPUT -  Several local and global variables (including TMP, and ^XTMP) (Defined and
 ;           KILLed by DG53558).
 ;
 S ICDT=""
 F  S ICDT=$O(TMP(DFN,ICDT)) Q:ICDT=""  D
 . ;
 . ;if this is the IVM test that is set to not prim, then flip it
 . S IVMIEND=$G(TMPIVM(DFN,ICDT))  ;DG*5.3*579
 . I IVMIEND D
 . . D SETPRIM(IVMIEND,1,.IVMPFL)
 . . S LINK=$P($G(^DGMT(408.31,IVMIEND,2)),"^",6)
 . . D:LINK SETPRIM(LINK,1,.IVMPFL)  ;set any linked test to PRIM
 . ;
 . S MTVER=""
 . F  S MTVER=$O(TMP(DFN,ICDT,MTVER)) Q:MTVER=""  D
 . . ;
 . . S MTST=""
 . . F  S MTST=$O(TMP(DFN,ICDT,MTVER,MTST)) Q:MTST=""  D
 . . .;keep at least one test per day per status, even if not PRIM
 . . . D:'$D(TMP(DFN,ICDT,MTVER,MTST,"P")) SETPRI(.TMP)
 . . . ;    drive thru ien's and del dupes
 . . . S MTIEN=0
 . . . F  S MTIEN=$O(TMP(DFN,ICDT,MTVER,MTST,MTIEN)) Q:'MTIEN  D
 . . . . S PRIM=$G(^DGMT(408.31,MTIEN,"PRIM"))
 . . . . S LINK=$P($G(^DGMT(408.31,MTIEN,2)),"^",6)
 . . . . ;
 . . . .;if this ien is primary & it is not the IVM test or Linked to
 . . . .;the IVM test, then it should be flipped back to Not Primary
 . . . . I IVMIEND,PRIM,MTIEN'=IVMIEND,LINK'=IVMIEND D     ;DG*5.3*579
 . . . . . D SETPRIM(MTIEN,0,.IVMPFL)
 . . . . . S TMP(DFN,ICDT,MTST,MTIEN)=0
 . . . .;
 . . . . I TMP(DFN,ICDT,MTVER,MTST,"P")'=MTIEN D
 . . . . . S TYPE=$P($G(^DGMT(408.31,MTIEN,0)),"^",19),TYPNAM=""
 . . . . . S:TYPE]"" TYPNAM=$G(^DG(408.33,TYPE,0))
 . . . . . D DELMT^DG53558M(MTIEN,DFN,.IVMPUR,.DELETED,.LINK)
 . . . . . Q:'DELETED
 . . . . . S ^XTMP(NAMSPC_".DET",DFN,ICDT,MTVER,MTIEN)=TYPNAM
 . . . . . I LINK,'$D(^DGMT(408.31,LINK,0)) S LINK=0
 . . . . . Q:'LINK
 . . . . . S LTYP=$P($G(^DGMT(408.31,LINK,0)),"^",19),LTNAM=""
 . . . . . S:LTYP LTNAM=$G(^DG(408.33,LTYP,0))
 . . . . . S ^XTMP(NAMSPC_".DET",DFN,ICDT,MTVER,LINK)=LTNAM
 . . . . M ^XTMP(NAMSPC,DFN,ICDT,MTVER,MTST)=TMP(DFN,ICDT,MTST)
 Q
 ;
 ;DG*5.3*579 released SETPRIM and 688 moved it to this routine.
SETPRIM(DA,PR,IVMP) ; set an Income Test (in #408.31) to either Prim or Not
 Q:'$D(DA)!'$D(PR)
 N DR,DIE,DGDATA,DGPRI
 S DGPRI=$G(^DGMT(408.31,DA,"PRIM"))
 Q:DGPRI=PR                               ;quit if already at that sts
 S IVMP=$G(IVMP)+1
 S DGDATA="FLIPPED TO "_$S(PR=0:"NOT PRIMARY",1:"PRIMARY")
 S:$D(NAMSPC) ^XTMP(NAMSPC_".DET",DFN,ICDT,DA)=DGDATA
 S DR="2////"_PR,DIE="^DGMT(408.31,"
 D:'$G(TESTING) ^DIE
 Q
 ;
SETPRI(TMP) ;indicate like a primary (in TMP) to avoid it from being deleted
 N IEN
 S IEN=$O(TMP(DFN,ICDT,MTVER,MTST,""),-1)
 S TMP(DFN,ICDT,MTVER,MTST,IEN)=1
 S TMP(DFN,ICDT,MTVER,MTST,"P")=IEN
 Q
