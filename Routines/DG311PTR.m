DG311PTR ;ALB/JJG-Patient Relation Pointer Utility ; 23 MAY 2000
 ;;5.3;Registration;**311**;Aug 13, 1993
 ;
 ; This routine will be run as a post-installation routine for patch
 ; DG*5.3*311. The main purpose for this routine is to clean up any
 ; invalid pointers to the PATIENT RELATION file (#408.12) that may
 ; exist in the PATIENT RELATION field (408.21,.02) of the INDIVIDUAL
 ; ANNUAL INCOME file (#408.21).
 ;
POST ;entry point for post-install, setting up checkpoints
 N %
 I $D(XPDNM) S %=$$NEWCP^XPDUTL("DGIEN21","MAIN^DG311PTR",0)
 Q
MAIN ;Main Driver
 N DGRECNT
 S DGRECNT=0
 D LOOP
 Q
LOOP ; Locate and correct invalid pointers
 N DGIEN21,DGIEN22,DGNOD22,DGIEN2,DGRLIEN
 S DGIEN21=""
 I $D(XPDNM) S DGIEN21=+$$PARCP^XPDUTL("DGIEN21")
 F  S DGIEN21=$O(^DGMT(408.21,"C",0,DGIEN21)) Q:'DGIEN21  D
 .S DGIEN22=0
 .S DGIEN22=$O(^DGMT(408.22,"AIND",DGIEN21,DGIEN22)) Q:'DGIEN22
 .S DGNOD22=$G(^DGMT(408.22,DGIEN22,0))
 .S DGIEN2=$P(DGNOD22,"^") Q:'DGIEN2
 .S DGRLIEN=0
 .S DGRLIEN=$O(^DGPR(408.12,"B",DGIEN2,DGRLIEN)) Q:'DGRLIEN
 .D UPDATE
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGIEN21",DGIEN21)  ; Update Checkpoint
 Q
UPDATE ;Update .02 field in Individual Annual Income file
 N DATA,DGENDA,ERROR
 S DATA(.02)=DGRLIEN,DGENDA=DGIEN21,ERROR=""
 I $$UPD^DGENDBS(408.21,.DGENDA,.DATA,.ERROR) D
 .S DGRECNT=DGRECNT+1
 Q
