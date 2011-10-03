MAGXCVC ;WOIFO/SEB,MLH - Image Index Conversion Commit ; 05/18/2007 11:23
 ;;3.0;IMAGING;**17,25,31,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Entry point for the commit image indices option (MAG IMAGE INDEX COMMIT indices)
COMMIT N START,END,FLAG,TMF,STATUS
 N ZTDTH,ZTIO,ZTRTN,ZTDESC,ZTSAVE,ZTSK ; -- TaskMan variables
 N INPUT ; -------------------------------- user input holder
 ;
 S STATUS=$G(^XTMP("MAG30P25","STATUS"))
 L +MAGTMP("IMAGE INDEX GENERATE"):0 E  D  G COMMITX
 . W !,"Image index generation still in progress. Please try again later."
 . Q
 L +MAGTMP("IMAGE INDEX COMMIT"):0 E  D  G COMMITX
 . W !,"Image index commit still in progress. Please try again later."
 . Q
 I '$D(^XTMP("MAGIXCVGEN")) D  G COMMITX
 . W !,"You must generate the image indices before running this option."
 . Q
 S (START,END)=0,FLAG=""
 D BOUNDS^MAGXCVP(.START,.END) I START="^" G COMMITX
 D RECREATE^MAGXCVP(.FLAG) I FLAG="^" G COMMITX
 R !!,"Commit new index entries? N // ",INPUT:DTIME
 I INPUT="" S INPUT="N"
 S INPUT=$$UCASE^MAGXCVP($E(INPUT))
 I INPUT'="Y" W !,"OK, entries not committed." G COMMITX
 D TASKMAN^MAGXCVP(.TMF) I TMF="^" G COMMITX
 S ZTSK=0 I TMF="" D COM1(START,END,FLAG,0) G COMMITX
 S ZTRTN="COMTM^MAGXCVC",ZTDESC="COMMIT IMAGE INDEX VALUES",ZTDTH=TMF,ZTIO=""
 S ZTSAVE("START")=START,ZTSAVE("END")=END,ZTSAVE("FLAG")=FLAG
 D ^%ZTLOAD
 W !!,"Image index commitment has been queued as task #"_ZTSK_"."
 ;
COMMITX ; Clean up locks from COMMIT initial processing.
 L -MAGTMP("IMAGE INDEX GENERATE")
 L -MAGTMP("IMAGE INDEX COMMIT")
 Q
 ;
 ; TaskMan entry point for committing image indices
COMTM D COM1(START,END,FLAG,1)
 Q
 ;
COM1(START,END,FLAG,QUEUED) N MAGIEN,CT,INDXDATA,INDX,STARTDT,ENDDT,SUMMARY,STOP,HISTORY,RESULT
 N PREVLOG ; ------ log entry of a previous committal
 N PREV0 ; -------- beginning MAGIEN of previous range
 N PREVF ; -------- ending MAGIEN of previous range
 N RANGE ; -------- array containing the current range being committed
 N T0 ; ----------- internal index of ^TMP($J,"PREVRNG") for range checks
 ;
 L +MAGTMP("IMAGE INDEX COMMIT"):900 E  Q  ; don't let more than one commit run at once!
 K ^XTMP("MAG30P25","SUMMARY") S $P(^XTMP("MAG30P25","STATUS"),U,13,14)=4_U_ZTSK
 S STARTDT=$$HTE^XLFDT($H,1)
 S START=+$G(START),END=+$G(END),STOP=0
 I END=0 S END=+$P($G(^MAG(2005,0)),U,3)
 S MAGIEN=START-1 I MAGIEN=-1 S MAGIEN=0
 S $P(^XTMP("MAG30P25","STATUS"),U,7,11)=DUZ_U_START_U_STARTDT_U_U
 I 'QUEUED W !!
 ; Now run the entries that are ready to commit.
 ; 
 K RANGE
 F CT=0:1 S MAGIEN=$O(^XTMP("MAGIXCVGEN",MAGIEN)) Q:MAGIEN>END!(+MAGIEN'=MAGIEN)  D  I STOP Q
 . D COM2(MAGIEN,CT,FLAG,QUEUED)
 . S $P(^XTMP("MAG30P25","STATUS"),U,12)=MAGIEN
 . I QUEUED,$$S^%ZTLOAD S STOP=1,$P(^XTMP("MAG30P25","STATUS"),U,13)=5
 . Q
 S ENDDT=$$HTE^XLFDT($H,1)
 S $P(^XTMP("MAG30P25","STATUS"),U,10,11)=$S(STOP:MAGIEN,1:END)_U_ENDDT
 S ^XTMP("MAG30P25","SUMMARY")=$P(^XTMP("MAG30P25","STATUS"),U,8,11)
 S HISTORY=$G(^XTMP("MAG30P25","HISTORY"))+1,^XTMP("MAG30P25","HISTORY")=HISTORY
 S ^XTMP("MAG30P25","HISTORY",HISTORY)=$P(^XTMP("MAG30P25","STATUS"),U,8,11)
 I 'STOP D  ; end-of-processing cleanup
 . S $P(^XTMP("MAG30P25","STATUS"),U,13)=6
 . D ENTRY^MAGLOG("P17CV",$G(DUZ),START,$T(+0),"","",START_"_"_END)
 . D NOTIFY^MAGXCVP(.RESULT,2,STARTDT,ENDDT,START,END,FLAG)
 . Q
 L -MAGTMP("IMAGE INDEX COMMIT")
 Q
 ;
COM2(MAGIEN,CT,FREC,QUEUED) N INDXDATA,SUMMARY
 N FQUIT ; -------- quit flag
 N PREV0 ; -------- beginning MAGIEN of previous range
 ;
 I 'QUEUED,CT#100=0 W MAGIEN
 I 'QUEUED,CT#10=0 W "."
 ;Patch 8 has been installed (NOOP MLH 12/6/02)
 ;or "recreate previously calculated indices" question answered no.
 I $TR($G(^MAG(2005,MAGIEN,40)),"^")]"" D
 . S FQUIT=1 ; Assume they may not recreate.
 . I $E($G(FREC))="N" Q  ; "Recreate previously calculated indices" question answered no.
 . ; Don't allow committal unless the previous calculation was done by us.
 . I $D(^MAGIXCVT(2006.96,MAGIEN)) K FQUIT ; ok
 . Q
 Q:$G(FQUIT)
 ;
 S INDXDATA="" D COMIEN(MAGIEN,.INDXDATA)
 K ^XTMP("MAGIXCVGEN",MAGIEN)
 I INDXDATA="" S INDXDATA="(none)"
 S SUMMARY=$G(^XTMP("MAG30P25","SUMMARY",INDXDATA))
 I SUMMARY="" S ^XTMP("MAG30P25","SUMMARY",INDXDATA)=1_U_MAGIEN_U_MAGIEN
 E  S ^XTMP("MAG30P25","SUMMARY",INDXDATA)=(SUMMARY+1)_U_$P(SUMMARY,U,2)_U_MAGIEN
 S ^XTMP("MAG30P25","SUMMARY",INDXDATA,MAGIEN)=""
 S ^MAGIXCVT(2006.96,MAGIEN)=1 ; flag as converted by index generation
 Q
 ;
COMIEN(MAGIEN,INDXDATA) ; Commit indices for one image (IEN=MAGIEN), return indices in INDXDATA
 N VAL40 ; --- values on the 40 node
 N IX40 ; ---- index to pieces of the 40 node
 ;
 S INDXDATA=$G(INDXDATA)
 I INDXDATA="" S INDXDATA=$P($G(^XTMP("MAGIXCVGEN",MAGIEN)),U,2,7)
 I INDXDATA="" D GENIEN^MAGXCVI(MAGIEN,.INDXDATA)
 F  Q:$E(INDXDATA,$L(INDXDATA))'=U  S INDXDATA=$E(INDXDATA,1,$L(INDXDATA)-1)
 I INDXDATA]"" D
 . S ^MAG(2005,MAGIEN,40)=INDXDATA
 . Q
 E  D
 . K ^MAG(2005,MAGIEN,40)
 . Q
 Q
 ;
 ; Direct edit of image index fields (#40-44) in the image file (#2005).
IMAGE N I,DIC,DIE,DA,DR,X,Y,MAGIEN,MAGDFN,MAGTMP,BEFORE,AFTER
 W ! S DIC=2005,DIC(0)="AEQ" D ^DIC I Y=-1 Q
 S DIE=DIC,DR="[MAG IMAGE INDEX EDIT]",(MAGIEN,DA)=$P(Y,U)
 S MAGDFN=$P($G(^MAG(2005,MAGIEN,0)),"^",7)
 K MAGTMP
 D GETS^DIQ(2005,MAGIEN_",","40:45","I","MAGTMP")
 S BEFORE="" F I=40:1:45 S:BEFORE'="" BEFORE=BEFORE_"|" S BEFORE=BEFORE_MAGTMP(2005,MAGIEN_",",I,"I")
 D ^DIE
 K MAGTMP
 D GETS^DIQ(2005,MAGIEN_",","40:45","I","MAGTMP")
 S AFTER="" F I=40:1:45 S:AFTER'="" AFTER=AFTER_"|" S AFTER=AFTER_MAGTMP(2005,MAGIEN_",",I,"I")
 D ENTRY^MAGLOG("INDXCHG",$G(DUZ),$G(MAGIEN),"BEFORE: "_BEFORE_" "_"AFTER: "_AFTER,$G(MAGDFN),1)
 G IMAGE
 ;
