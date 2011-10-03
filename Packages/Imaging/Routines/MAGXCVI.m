MAGXCVI ;WOIFO/SEB,MLH - Image Index Conversion Generate ; 05/18/2007 11:23
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
 ; Extract fields from an image record and look them up in the
 ; conversion global ^XTMP("MAG30P25","MAPPING") for possible values for
 ; Package, Class, Type, Procedure/Event and Specialty.
 ; Currently uses the following fields:
 ; #3 - Object Type (0;6)
 ; #6 - Procedure (0;8)
 ; #8 - Image Save By (2;2)
 ; #10 - Short Desc (2;4)
 ; #14 - Group Parent (0;10)
 ; #16 - Parent Data File (2;6)
 ; #100 - Document Category (100;1)
 ;
 ; Entry point for the generate image indices option (MAG IMAGE INDEX GEN indices)
GEN N START,END,RUN,TMF
 N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTDTH,ZTIO ; -- TaskMan control variables
 N RECFLAG ; ------------------------------ true (1) if all image index entries should be recreated
 ;
 I '$D(^XTMP("MAG30P25","MAPPING")) D  Q
 . W !,"You must load the mapping file before running this option."
 . Q
 L +MAGTMP("IMAGE INDEX GENERATION"):0 E  D  Q
 . W !,"Image index generation still in progress. Please try again later."
 . Q
 L +MAGTMP("IMAGE INDEX COMMIT"):0 E  D  Q
 . W !,"Image index commit still in progress. Please try again later."
 . Q
 S (START,END)=0,RECFLAG=""
 D BOUNDS^MAGXCVP(.START,.END) I START="^" Q
 D RECREATE^MAGXCVP(.RECFLAG) I RECFLAG="^" Q
 D TASKMAN^MAGXCVP(.TMF) I TMF="^" G DONE
 S ZTSK=0 I TMF="" D GEN1(START,END,RECFLAG,0) G DONE
 S ZTRTN="GENTM^MAGXCVI",ZTDESC="GENERATE IMAGE INDEX VALUES",ZTDTH=TMF
 S ZTSAVE("START")=START,ZTSAVE("END")=END,ZTSAVE("RECFLAG")=RECFLAG,ZTIO=""
 D ^%ZTLOAD
 W !!,"Image index generation has been queued as task #"_ZTSK_"."
 L -MAGTMP("IMAGE INDEX COMMIT")
 L -MAGTMP("IMAGE INDEX GENERATION")
 Q
 ;
 ; TaskMan entry point for generating image indices
GENTM D GEN1(START,END,RECFLAG,1)
 Q
 ;
GEN1(START,END,RECFLAG,QUEUED) ; Main entry point.
 ;
 N MAGIEN,CT,RESULT,STARTDT,ENDDT,SUMMARY,STOP
 N CURDAT ; -- current FileMan date
 N EXPDAT ; -- expiration date for ^XTMP
 ;
 ; Don't let others run while we're running, but give adequate quit time
 ; to the foreground process that generated us.
 L +MAGTMP("IMAGE INDEX GENERATION"):1800 E  Q
 ; 10-day retention for the ^XTMP output node
 S CURDAT=$$DT^XLFDT
 S EXPDAT=$$FMADD^XLFDT(CURDAT,10)
 K ^XTMP("MAGCVIXGEN")
 S ^XTMP("MAGCVIXGEN",0)=EXPDAT_U_CURDAT_U_"IMAGE INDEX CONVERSION"
 K ^XTMP("MAG30P25","SUMMARY"),^TMP($J)
 S $P(^XTMP("MAG30P25","STATUS"),U,13,14)=1_U_ZTSK
 S STARTDT=$$HTE^XLFDT($H,1)
 S START=+$G(START),END=+$G(END),STOP=0
 I END=0 S END=+$P($G(^MAG(2005,0)),U,3)
 S $P(^XTMP("MAG30P25","STATUS"),U,1,5)=DUZ_U_START_U_STARTDT_U_U
 S MAGIEN=START-1 I MAGIEN=-1 S MAGIEN=0
 I 'QUEUED W !!
 F CT=0:1 S MAGIEN=$O(^MAG(2005,MAGIEN)) Q:MAGIEN>END!(+MAGIEN'=MAGIEN)  D  I STOP Q
 . D GEN2(MAGIEN,CT,RECFLAG,QUEUED) S $P(^XTMP("MAG30P25","STATUS"),U,6)=MAGIEN
 . I QUEUED,$$S^%ZTLOAD S STOP=1,$P(^XTMP("MAG30P25","STATUS"),U,13)=2
 . Q
 S ENDDT=$$HTE^XLFDT($H,1)
 S $P(^XTMP("MAG30P25","STATUS"),U,4,5)=$S(STOP:MAGIEN,1:END)_U_ENDDT
 S ^XTMP("MAG30P25","SUMMARY")=$P(^XTMP("MAG30P25","STATUS"),U,2,5)
 I 'STOP S $P(^XTMP("MAG30P25","STATUS"),U,13)=3
 D NOTIFY^MAGXCVP(.RESULT,1,STARTDT,ENDDT,START,END,RECFLAG)
 L -MAGTMP("IMAGE INDEX GENERATION") ; now others can get in
 Q
 ;
GEN2(MAGIEN,CT,XFREC,QUEUED) N INDXDATA
 N SUMMARY ; ---- summary node for this set of index field values
 N FQUIT ; -- flag to bypass records w/existing values not to be regen'd
 ;
 ;Patch 8 has been installed
 ;or "recreate previously calculated indices" question answered no.
 I $TR($G(^MAG(2005,MAGIEN,40)),"^")'="" D  Q:$G(FQUIT)
 . S FQUIT=1 ; Assume they may not recreate.
 . ; "Recreate previously calculated indices" question answered no?
 . I $E($G(XFREC))="N" K ^XTMP("MAGIXCVGEN",MAGIEN) Q  ; yes
 . ; Don't allow generation unless the previous calculation was done by us.
 . I $D(^MAGIXCVT(2006.96,MAGIEN)) K FQUIT ; ok
 . Q
 I 'QUEUED,CT#100=0 W MAGIEN
 I 'QUEUED,CT#10=0 W "."
 I XFREC="N",$D(^XTMP("MAGIXCVGEN",MAGIEN)) Q
 K ^XTMP("MAGIXCVGEN",MAGIEN)
 D GENIEN(MAGIEN,.INDXDATA)
 S ^XTMP("MAGIXCVGEN",MAGIEN)=$$NOW^XLFDT()_U_INDXDATA
 I INDXDATA="" S INDXDATA="(none)"
 S SUMMARY=$G(^XTMP("MAG30P25","SUMMARY",INDXDATA))
 I $P(SUMMARY,U,2)="" S $P(SUMMARY,U,2)=MAGIEN
 S $P(SUMMARY,U,3)=MAGIEN
 S $P(SUMMARY,U)=$P(SUMMARY,U)+1
 S ^XTMP("MAG30P25","SUMMARY",INDXDATA)=SUMMARY,^(INDXDATA,MAGIEN)=""
 Q
 ;
 ; Generate indices for one image (IEN=MAGIEN), return indices in INDXDATA
GENIEN(MAGIEN,INDXDATA) N GRPIEN,MAGTMP,MAGVALS,FLDDATA,MAPDATA,FLDNUM,UTYPE
 N D0,D1,INDXVAL,UNIQUE,FIRSTVAL,DESC,CHILD1
 N I ; --------- loop index
 N MAGNOD ; ---- nodes of the current record, for fast lookup
 N HITDESC ; --- flag set to TRUE if we get a hit on SHORT DESCRIPTION
 N SHDSCTXT ; -- short description text
 N CMPIDX ; ---- index array for comparison (to see if we already mapped)
 ;
 S GRPIEN=$P($G(^MAG(2005,MAGIEN,0)),U,10)
 I GRPIEN="" S GRPIEN=MAGIEN ; this image is not in a group
 I '$D(^MAG(2005,GRPIEN)) S GRPIEN=MAGIEN
 F I=0,2,100 S MAGNOD(I)=$G(^MAG(2005,GRPIEN,I))
 K MAGVALS
 S MAGVALS(3,"I")=$P(MAGNOD(0),U,6) ; object type
 S MAGVALS(6,"I")=$P(MAGNOD(0),U,8) ; procedure
 S MAGVALS(8,"I")=$P(MAGNOD(2),U,2) ; image save by
 S MAGVALS(10,"I")=$P(MAGNOD(2),U,4) ; short description
 S MAGVALS(16,"I")=$P(MAGNOD(2),U,6) ; parent data file
 S MAGVALS(100,"I")=$P(MAGNOD(100),U) ; descriptive category
 S CHILD1=$P($G(^MAG(2005,GRPIEN,1,1,0)),U)
 I CHILD1="" S CHILD1=MAGIEN ; this image is not in a group
 I CHILD1'="" S MAGVALS(3,"I")=$P($G(^MAG(2005,CHILD1,0)),U,6)
 S INDXDATA=""
 ; If these field values have already been indexed, reuse the previously
 ; mapped-to values.
 F FLDNUM=3,6,8,10,16,100 D
 . S X=$G(MAGVALS(FLDNUM,"I")),CMPIDX(FLDNUM)=$S(X]"":X,1:"@")
 . Q
 S INDXDATA=$G(^TMP($J,"CMPIDX",CMPIDX(3),CMPIDX(6),CMPIDX(8),CMPIDX(10),CMPIDX(16),CMPIDX(100)))
 I INDXDATA="" D GENINEW^MAGXCVI1 ; no previous indexing on these values
 ; save indices for possible later re-use
 S ^TMP($J,"CMPIDX",CMPIDX(3),CMPIDX(6),CMPIDX(8),CMPIDX(10),CMPIDX(16),CMPIDX(100))=INDXDATA
 Q
 ;
DONE W !!,"Done!"
 Q
 ;
 ; Silent call to generate and commit image indices for one image (IEN=MAGIEN)
ONE(MAGIEN) N INDXDATA
 D GENIEN(MAGIEN,.INDXDATA),COMIEN^MAGXCVC(MAGIEN,.INDXDATA)
 Q
