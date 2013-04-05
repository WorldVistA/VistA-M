MAGGAII ;WOIFO/GEK/SG/JSL - RETURNS IMAGE INFO ; 2/20/09 11:37am
 ;;3.0;IMAGING;**93,94,122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;+++++ PERFORMS SPECIAL CONVERSION OF THE DATE/TIME
DTE(DTI) ;
 Q $TR($$FMTE^XLFDT(DTI,"5Z"),"@"," ")
 ;
 ;+++++ RETURNS THE FULL NAME OF THE IMAGE FILE
 ;
 ; MAGXX         IEN of the image record in the file #2005
 ;
 ; FILETYPE      Type of the image: "ABSTRACT", "BIG", or "FULL"
 ;
 ; [.MAGTYPE]    Reference to a local variable where the location
 ;               code is returned to:
 ;                 A  Accessible
 ;                 M  Magnetic
 ;                 O  Offline
 ;                 W  WORM
 ;
 ; [.MAGJBOL]    Reference to a local variable where the Jukebox
 ;               offline message is returned to.
 ; 
 ; Return Values
 ; =============
 ;           <0  ErrorCode~ErrorMessage
 ;           ""  Name is not available or an error
 ;
FILENAME(MAGXX,FILETYPE,MAGTYPE,MAGJBOL) ;
 N MAGFILE1,MAGJBCP,MAGOFFLN,MAGPREF
 S MAGPREF=""
 ;--- Don't queue a copy from the JukeBox.
 S MAGJBCP=0
 ;--- The FINDFILE^MAGFILEB returns:
 ;    MAGFILE1      File name (e.g. "LA100066.ABS")
 ;                  if no Network Location pointer or INVALID Pointer
 ;                  then MAGFILE1=-1~NO NETWORK LOCATION POINTER  
 ;                  or -1~INVALID NETWORK LOCATION POINTER
 ;    MAGFILE1(.01) Image description (e.g. "ONE,PATIENT   111223333")
 ;    MAGJBOL       Description of the offline server
 ;    MAGOFFLN      Non-zero if the jukebox is offline
 ;    MAGPREF       Path (e.g. "C:\TEMP\LA\10\00\")
 ;--- MAGTYPE       "MAG" or "WORM"
 D FINDFILE^MAGFILEB
 ;--- The MAGFILE1 may contain '^' in case of an error
 S MAGFILE1=$TR(MAGFILE1,"^","~")
 S:$D(MAGFILE1("ERROR")) MAGFILE1=MAGFILE1("ERROR")
 S MAGTYPE=$S($G(MAGOFFLN):"O",FILETYPE="FULL":"A",1:$E(MAGTYPE,1))
 ;--- The following line of code replicates the old functionality
 Q:FILETYPE'="BIG" $G(MAGPREF)_MAGFILE1
 ;--- Return the full name or an empty string in case of an error
 Q $S($E(MAGFILE1,1,2)="-1":"",1:$G(MAGPREF)_MAGFILE1)
 ; 
 ;##### RETURNS THE IMAGE DESCRIPTOR
 ;
 ; MAGIEN        IEN of the image record in the file #2005 or
 ;               in file #2005.1
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 D  Consider only deleted "child" images
 ;                 E  Consider only existing "child" images
 ;
 ;               If neither 'E' nor 'D' flag is provided, then an
 ;               error code is returned.
 ;
 ; [[.]GRPCNTS]  The $$INFO function need counts of images in the
 ;               group. If these numbers are already available,
 ;               they can be passed as the value of this parameter.
 ;                 ^01: Number of existing members of the group
 ;                 ^02: Number of deleted members of the group
 ;
 ;               If this parameter is not defiend or empty, the
 ;               $$INFO function calls the $$GRPCT^MAGGI14 and
 ;               returns the counts in this parameter if it is
 ;               passed by reference.
 ;
 ; Input Variables
 ; ===============
 ;
 ; MAGJOB(
 ;   "NETPLC",...)
 ;   "PTNM",...)
 ;   "RPCPORT")
 ;   "RPCSERVER")
 ;
 ; MAGNOCHK      Skip the questionable integrity checks if this
 ;               variable is defined and not zero.
 ;
 ; Output Variables
 ; ================
 ;
 ; MAGJOB(
 ;   "NETPLC",...)
 ;   "PTNM",...)
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;           >0  Image descriptor
 ;                 ^01: Image IEN
 ;                 ^02: Image full path and name
 ;                 ^03: Abstract full path and name
 ;                 ^04: SHORT DESCRIPTION field and description of
 ;                      offline JukeBox
 ;                 ^05: PROCEDURE/EXAM DATE/TIME field
 ;                 ^06: OBJECT TYPE
 ;                 ^07: PROCEDURE field
 ;                 ^08: display date
 ;                 ^09: PARENT DATA FILE image pointer
 ;                 ^10: ABSTYPE: 'M' magnetic, 'W' worm, 'O' offline
 ;                 ^11: 'A' accessible, 'O' offline
 ;                 ^12: DICOM Series Number
 ;                 ^13: DICOM Image Number
 ;                 ^14: Count of images in group; 1 if single image
 ;                      VISN15
 ;                 ^15: Site parameter IEN
 ;                 ^16: Site parameter CODE
 ;                 ^17: Error description of Integrity Check
 ;                 ^18: Image BIGPath and name
 ;                 ^19: Patient DFN
 ;                 ^20: Patient Name
 ;                 ^21: Image Class: Clin,Admin,Clin/Admin,Admin/Clin
 ;                 ^22: Date Time Image Saved (7)
 ;                 ^23: Document Date (110)
 ;                 ^24: Group IEN
 ;                 ^25: IEN of the 1s child of the group and child's
 ;                      type separated by colon
 ;                 ^26: RPC Broker server
 ;                 ^27: RPC Broker port
 ;                 ^28: Internal value of CONTROLLED IMAGE field (112) 
 ;                      converted to a number {0|1}
 ;                 ^29: Viewable Status
 ;                 ^30: Internal value of STATUS field (113)
 ;                 ^31: Image annotated flag (0 or 1)
 ;                 ^32: Image TIU note is completed (0 or 1)
 ;                 ^33: Annotation operation Status
 ;                 ^34: Annotation operation Status Description
 ;                 ^35: Package is the package: RAD,LAB,MED,SUR,NONE,PHOTOID
 ;
INFO(MAGIEN,FLAGS,GRPCNTS) ;
 N GROUP         ; 1 if the entry referenced by MAGIEN is a group
 N GRPCH1IEN     ; IEN of the first image of the group
 N GRPCH1NODE    ; Global node of the 1st image od the group
 N GRPCH1TYPE    ; Type of the first image of the group
 N GRPCHCNT      ; Number of images in the group
 N MAGNODE       ; Global node of the image referenced by MAGIEN
 N MAGRES        ; Result value (image descriptor)
 ;
 ;N MAG3P59 ;gek/ out in P94t7
 N MAGMSG,MAGN0,MAGN100,MAGN2,MAGN40,MAGJBOL
 N MAGVST,MDFN,IEN,PLC,PLCODE,RC,TMP,X,ANNOTATED,TMPN2
 ;
 ;=== Validate control flags
 S FLAGS=$G(FLAGS)
 ;--- Unknown/Unsupported flag(s)
 Q:$TR(FLAGS,"DE")'="" $$IPVE^MAGUERR("FLAGS")
 ;--- Missing required flag
 Q:$TR(FLAGS,"DE")=FLAGS $$ERROR^MAGUERR(-6,,"D,E")
 ;
 ;=== Get the global node of the record
 S MAGNODE=$$NODE^MAGGI11(MAGIEN)
 ;
 ;=== Initialize variables
 S MAGRES=MAGIEN,RC=0
 ;gek/ out in P94t7   S MAG3P59=$D(MAGJOB("RPCSERVER"))&$D(MAGJOB("RPCPORT"))
 D:'$D(MAGJOB("NETPLC")) NETPLCS^MAGGTU6
 I MAGNODE'=""  D
 . S MAGN0=$G(@MAGNODE@(0)),MAGN2=$G(@MAGNODE@(2))
 . S MAGN40=$G(@MAGNODE@(40)),MAGN100=$G(@MAGNODE@(100))
 E  S (MAGN0,MAGN2,MAGN40,MAGN100)=""
 ;
 ;=== Cache patient names; call $$GET 1 time not 2000
 S MDFN=$P(MAGN0,U,7)  ; PATIENT (5)
 I MDFN,'$D(MAGJOB("PTNM",MDFN))  D
 . S MAGJOB("PTNM",MDFN)=$$GET1^DIQ(2,MDFN_",",.01)
 . ;--- Cache no more than 10 records in the MAGJOB("PTNM")
 . S TMP=+$P($G(MAGJOB("PTNM")),U,10)
 . S MAGJOB("PTNM")=MDFN_U_$P($G(MAGJOB("PTNM")),U,1,9)
 . K:TMP>0 MAGJOB("PTNM",TMP)
 . Q
 ;
 ;=== Process the group header
 S GRPCHCNT=0,(GRPCH1IEN,GRPCH1NODE,GRPCH1TYPE)=""
 ;--- Count the images of the group
 S:$G(GRPCNTS)="" GRPCNTS=$$GRPCT^MAGGI14(MAGIEN)
 D:GRPCNTS'<0
 . S:FLAGS["E" GRPCHCNT=GRPCHCNT+$P(GRPCNTS,U,1)  ; Existing entries
 . S:FLAGS["D" GRPCHCNT=GRPCHCNT+$P(GRPCNTS,U,2)  ; Deleted entries
 . Q
 ;--- Check the object type
 S GROUP=$$ISGRP^MAGGI11(MAGIEN)
 I GROUP  D
 . ;--- Get the IEN of the first image of the group
 . S GRPCH1IEN=$$GRPCH1^MAGGI14(MAGIEN,FLAGS)
 . I GRPCH1IEN'>0  S GRPCH1IEN=""  Q
 . ;--- If we cannot get the global node of the 1st image of the
 . ;--- group (this should never happen) clear its IEN as well.
 . S GRPCH1NODE=$$NODE^MAGGI11(GRPCH1IEN,.TMP)
 . I GRPCH1NODE=""  S GRPCH1IEN=""  Q
 . ;--- Get the type of the first image of the group
 . S GRPCH1TYPE=$P(@GRPCH1NODE@(0),U,6)
 . Q
 ;--- Check the annotation info
 S ANNOTATED=+$P($G(^MAG(2005.002,MAGIEN,1,0)),U,4) ;p122 - add IMAGE annotated flag
 I 'ANNOTATED I $D(^MAG(2005,MAGIEN,210,0)) S ANNOTATED=1 ;VistARad annotation #2005.001/PS data #2005.05
 I 'ANNOTATED I GROUP!$D(^MAG(2005,MAGIEN,1,0)) D   ;p122 - find any child w/ annotation
 . N NO,CH S NO=0
 . F  S NO=$O(^MAG(2005,MAGIEN,1,NO)) Q:'NO  S CH=+$G(^(NO,0)) S:CH ANNOTATED=+$P($G(^MAG(2005.002,CH,1,0)),U,4) S:$D(^MAG(2005,CH,210,0)) ANNOTATED=1 Q:ANNOTATED
 . Q
 S:ANNOTATED ANNOTATED=1
 ;=== If this is a group and it is not empty, then use
 ;    the first image to get the names of image files.
 ;=== Otherwise, get them from the group header itself.
 S IEN=$S(GRPCH1IEN>0:GRPCH1IEN,1:MAGIEN)
 ;--- Get full path and file name of the Abstract.
 S $P(MAGRES,U,3)=$$FILENAME(IEN,"ABSTRACT",.TMP,.MAGJBOL)
 S $P(MAGRES,U,10)=TMP  ; Abstract type ('M', 'O', or 'W')
 ;--- Get the full path and file name of the FULL RES image.
 S $P(MAGRES,U,2)=$$FILENAME(IEN,"FULL",.TMP)
 S $P(MAGRES,U,11)=TMP  ; 'A' - accessible, 'O' - offline
 ;--- Get the full path and file name for the BIG image.
 S $P(MAGRES,U,18)=$$FILENAME(IEN,"BIG")
 ;
 ;=== Get the site parameters IEN and code
 S IEN=0
 I 'GROUP  D
 . ;--- If the record is a standalone image entry, then
 . ;--- get the location IEN from this entry.
 . S IEN=+$S($P(MAGN0,U,3):$P(MAGN0,U,3),1:$P(MAGN0,U,5))
 . Q
 E  I GRPCH1NODE'=""  D
 . ;--- If the group references "child" entries of requested kind(s), 
 . ;--- then get the network location IEN from the 1st one.
 . S TMP=$G(@GRPCH1NODE@(0))
 . S IEN=+$S($P(TMP,U,3):$P(TMP,U,3),1:$P(TMP,U,5))
 . Q
 E  I (FLAGS'["D")!(FLAGS'["E")  D
 . ;--- Otherwise, try to get the location IEN from the 1st "child"
 . ;--- image regardless of the requested kind (existing or deleted).
 . N CH1IEN,CH1NODE
 . S CH1IEN=$$GRPCH1^MAGGI14(MAGIEN,"DE")  Q:CH1IEN'>0
 . S CH1NODE=$$NODE^MAGGI11(CH1IEN)        Q:CH1NODE=""
 . S TMP=$G(@CH1NODE@(0))
 . S IEN=+$S($P(TMP,U,3):$P(TMP,U,3),1:$P(TMP,U,5))
 . Q
 S PLC=$P($G(MAGJOB("NETPLC",IEN)),U,1)     ; Site Parameters IEN
 S PLCODE=$P($G(MAGJOB("NETPLC",IEN)),U,2)  ; Site Code (e.g. "WAS")
 ;--- Groups of 0 images need this
 S:PLC="" PLC=$G(MAGJOB("PLC")),PLCODE=$G(MAGJOB("PLCODE"))
 ;
 ;=== SHORT DESCRIPTION field (10) and description of offline JukeBox
 S $P(MAGRES,U,4)=$P(MAGN2,U,4)_$G(MAGJBOL)
 ;
 ;=== Various fields
 S $P(MAGRES,U,5)=$P(MAGN2,U,5)  ; PROCEDURE/EXAM DATE/TIME (15)
 S $P(MAGRES,U,6)=$P(MAGN0,U,6)  ; OBJECT TYPE (3)
 S $P(MAGRES,U,7)=$P(MAGN0,U,8)  ; PROCEDURE (6)
 S $P(MAGRES,U,8)=$$DTE($P(MAGN2,U,5)) ; Ext. PROCEDURE/EXAM DATE/TIME
 S $P(MAGRES,U,9)=$P(MAGN2,U,8)  ; PARENT DATA FILE IMAGE POINTER (18)
 ;
 ;=== 2/1/99 Dicom Series number and Dicom Image Number
 ; $p(12) and $p(13)
 ;
 ;=== Number of images of requested kind in the group
 S $P(MAGRES,U,14)=$S(GRPCHCNT>0:GRPCHCNT,1:1)
 ;
 ;=== Site IEN and code
 S $P(MAGRES,U,15,16)=PLC_U_PLCODE
 ;
 ;=== Data integrity checks
 S TMP=$S('$G(MAGNOCHK):"Q",1:"")
 S MAGVST=$$VIEWSTAT^MAGGI12(MAGIEN,TMP,.MAGMSG)
 ;;W !,"MAGVST : ",$G(MAGVST) ; TESTING, TAKE OUT THIS LINE.
 I MAGVST["Q"  D
 . ;--- Remove the file name of the full resolution image
 . S $P(MAGRES,U,2)="-1~Questionable Data Integrity"
 . ;--- Replace the Abstract with the special bitmap
 . S $P(MAGRES,U,3)=".\bmp\imageQA.bmp"
 . ;--- Prevent the client from changing the Questionable
 . ;--- Integrity abstract bitmap to the Offline bitmap.
 . S:$P(MAGRES,U,6)'=11 $P(MAGRES,U,6)=99
 . S $P(MAGRES,U,10)="M"
 . ;--- Return the error message
 . S $P(MAGRES,U,17)=MAGMSG("Q")
 . Q
 ;
 ;=== Various fields
 S $P(MAGRES,U,19)=MDFN                    ; Patient IEN (DFN)
 S $P(MAGRES,U,20)=$S(MDFN:MAGJOB("PTNM",MDFN),1:MDFN)
 S $P(MAGRES,U,22)=$$DTE($P(MAGN2,U))      ; DATE/TIME IMAGE SAVED (7)
 S $P(MAGRES,U,23)=$$DTE($P(MAGN100,U,6))  ; CREATION DATE (110)
 ;
 ;=== Name of the image class
 S IEN=+$P(MAGN40,U,3)  ; TYPE INDEX (42)
 S:IEN>0 $P(MAGRES,U,21)=$$GET1^DIQ(2005.83,IEN_",",1,,,"MAGMSG")
 ;
 ;=== If the client is newer than patch 59, then we can set beyond
 ;    25 pieces. Additional "^" at the end of the result prevents
 ;=== problems on the client side.
 D  ;gek/ out in P94t7  I MAG3P59  D
 . S $P(MAGRES,U,24)=$P(MAGN0,U,10)      ; GROUP PARENT (14)
 . S:GRPCHCNT>1 $P(MAGRES,U,25)=GRPCH1IEN_":"_GRPCH1TYPE
 . S $P(MAGRES,U,26)=$G(MAGJOB("RPCSERVER")) ; GEK P94 put in $G
 . S $P(MAGRES,U,27)=$G(MAGJOB("RPCPORT")) ; GEK P94 put in $G
 . S TMP=+$P(MAGN100,U,7)                ; CONTROLLED IMAGE (112)
 . S $P(MAGRES,U,28)=TMP
 . S:TMP $P(MAGRES,U,3)=".\bmp\magsensitive.bmp"
 . S TMP=+$P(MAGN100,U,8)                ; STATUS (113)
 . S $P(MAGRES,U,29)=$$VSTCODE(MAGVST,TMP)
 . S $P(MAGRES,U,30)=TMP
 . ; patch 122 new data pieces (31-35) for annotation.
 . S $P(MAGRES,U,31)=$G(ANNOTATED)       ;IMAGE annotated
 . S TMP=""
 . ; if it is a child of a Group,  the Parent data is in the Group.
 . S TMPN2=MAGN2 I $P(MAGN0,U,10) S TMPN2=$G(^MAG(2005,$P(MAGN0,U,10),2))
 . I $P(TMPN2,U,6)=8925 D DATA^MAGGNTI(.TMP,$P(TMPN2,U,7)) S TMP=$P(TMP,U,6)
 . S $P(MAGRES,U,32)=$S(TMP="":"",TMP="COMPLETED":1,1:0) ; if TIU check Note status
 . S TMP="" ; use TMP to return Description.
 . S $P(MAGRES,U,33)=$$ANNSTAT^MAGGI12(MAGIEN,$P(MAGRES,U,29),.TMP) ;Annotation Status
 . S $P(MAGRES,U,34)=TMP ; This is Desc of Annotation Status
 . S $P(MAGRES,U,35)=$P(MAGN40,U,1)  ;the package RAD,LAB,MED,SUR...etc  
 . S $P(MAGRES,U,36)="" ; This forces "^" to be last character in string.
 . Q:GRPCH1NODE=""
 . ;--- If the group header is not marked as controlled but the 1st
 . ;    image is, override the sensitivity flag so that the image
 . ;--- abstract is not shown in the image list.
 . I '$P(MAGRES,U,28)  D:$P($G(@GRPCH1NODE@(100)),U,7)
 . . S $P(MAGRES,U,28)=1,$P(MAGRES,U,3)=".\bmp\magsensitive.bmp"
 . . Q
 . Q
 ;gek/ out in P94t7    E  S $P(MAGRES,U,25)=""
 ;
 ;=== Stop displaying a group of 1 as a group
 I GROUP,GRPCHCNT=1  D
 . N CH1N100,CH1VST
 . S $P(MAGRES,U,1)=GRPCH1IEN   ; IEN of the 1st image of the group
 . S $P(MAGRES,U,6)=GRPCH1TYPE  ; OBJECT TYPE (3) of the 1st image
 . ;gek/ out in P94t7  Q:'MAG3P59
 . ;--- Get the viewable status of the 1st "child"
 . S TMP=$S('$G(MAGNOCHK):"Q",1:"")
 . S CH1VST=$$VIEWSTAT^MAGGI12(GRPCH1IEN,TMP)
 . ;--- Get the image status of the 1st "child"
 . S CH1N100=$S(GRPCH1NODE'="":$G(@GRPCH1NODE@(100)),1:"")
 . S TMP=+$P(CH1N100,U,8)       ; STATUS (113)
 . ;--- Override the group's values with those of Child 1
 . S $P(MAGRES,U,29)=$$VSTCODE(CH1VST,TMP) ; numeric code of 'View Status'
 . S $P(MAGRES,U,30)=TMP ; Status
 . ; ANNOTATED due to only child was annotated 
 . S $P(MAGRES,U,31)=$G(ANNOTATED,0) ; IMAGE been annotated
 . ;      Don't change to Child for Report Parent info.
 . ;      Parent Data values are stored in '2' node of the Group.
 . S TMP=""
 . I $P(MAGN2,U,6)=8925 D DATA^MAGGNTI(.TMP,$P(MAGN2,U,7)) S TMP=$P(TMP,U,6)
 . S $P(MAGRES,U,32)=$S(TMP="COMPLETED":1,1:0)
 . ; Now need to change the Annotation Status, cause change in 'View Status'
 . S TMP="" ; use TMP to return Description.
 . S $P(MAGRES,U,33)=$$ANNSTAT^MAGGI12(GRPCH1IEN,$P(MAGRES,U,29),.TMP) ;Annotation Status
 . S $P(MAGRES,U,34)=TMP ; Annotation Status Description.
 . ; $P(35) is package RAD,LAB,SUR,MED,NOTE etc  defined in Group and Child.
 . Q
 ;
 ;===
 Q MAGRES
 ;
 ;+++++ CONVERTS THE VIEWABLE STATUS TO THE NUMERIC CODE
VSTCODE(VST,STATUS) ;
 Q $S(VST["D":12,VST["Q":21,VST["T":22,VST["R":23,1:+STATUS)
