MAGGI14 ;WOIFO/SG - IMAGE FILE API (GROUP PROPERTIES) ; 5/1/09 2:48pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;##### FINDS REFERENCE TO "CHILD" IMAGE IN OBJECT GROUP MULTIPLE
 ;
 ; GRPIEN        Internal Entry Number of the group.
 ;
 ; IMGIEN        Internal Entry Number of the image.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  The multiple does not reference the image
 ;           >0  IEN of the record of the OBJECT GROUP multiple (#4)
 ;               that references the image.
 ;
FINDCHLD(GRPIEN,IMGIEN) ;
 N IEN,NODE,RC
 S NODE=$$NODE^MAGGI11(GRPIEN,.RC)
 I NODE=""  D STORE^MAGUERR(RC)  Q RC
 S IEN=0
 F  S IEN=$O(@NODE@(1,IEN))  Q:IEN'>0  Q:$P($G(^(IEN,0)),U)=IMGIEN
 Q $S(IEN>0:IEN,1:0)
 ;
 ;##### RETURNS THE 1ST IMAGE OF THE GROUP
 ;
 ; GRPIEN        Internal Entry Number of the image record
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 D  Consider deleted images (file #2005.1)
 ;                 E  Consider existing images (file #2005)
 ;
 ;               If neither 'E' nor 'D' flag is provided, then an
 ;               error code is returned.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Group contains no images of requested kind(s)
 ;           >0  IEN of the 1st image of the group
 ;
 ; Notes
 ; =====
 ;
 ; This function does not return an error code when it encounters an
 ; invalid image reference in the OBJECT GROUP multiple (4); it just
 ; skips the entry.
 ;
GRPCH1(GRPIEN,FLAGS) ;
 N CH1IEN,ERR,I,IEN,NODE
 S FLAGS=$G(FLAGS),CH1IEN=0
 ;--- Unknown/Unsupported flag(s)
 Q:$TR(FLAGS,"DE")'="" $$IPVE^MAGUERR("FLAGS")
 ;--- Missing required flag
 Q:$TR(FLAGS,"DE")=FLAGS $$ERROR^MAGUERR(-6,,"D,E")
 ;
 ;--- Get the global node of the record
 S NODE=$$NODE^MAGGI11(GRPIEN,.ERR)
 I NODE=""  D STORE^MAGUERR(ERR)  Q ERR
 ;
 ;--- Check the existing (non-deleted) group memebers
 I FLAGS["E"  D  I IEN>0  S:'CH1IEN!(IEN<CH1IEN) CH1IEN=IEN
 . S (I,IEN)=0
 . F  S I=$O(@NODE@(1,I))  Q:I'>0  D  Q:IEN>0
 . . S IEN=+@NODE@(1,I,0)  ; OBJECT GROUP (.01)
 . . I IEN>0,$D(^MAG(2005,IEN))>1  Q
 . . S IEN=0  ; Skip the bad entry
 . . Q
 . Q
 ;
 ;--- Check the deleted group memebers
 I FLAGS["D"  D  I IEN>0  S:'CH1IEN!(IEN<CH1IEN) CH1IEN=IEN
 . S IEN=0
 . F  D  Q:IEN'>0  Q:$D(^MAG(2005,IEN))>1
 . . S IEN=$O(^MAG(2005,"AGPD",GRPIEN,IEN))
 . . Q
 . ;~~~ Delete this comment and the following lines of code when
 . ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 . Q:IEN>0
 . S IEN=0
 . F  D  Q:IEN'>0  Q:$D(^MAG(2005.1,IEN))>1
 . . S IEN=$O(^MAG(2005.1,"AGP",GRPIEN,IEN))
 . . Q
 . ;~~~
 . Q
 ;
 ;---
 Q CH1IEN
 ;
 ;##### RETURNS NUMBERS OF IMAGES AND PAGES IN THE GROUP
 ;
 ; GRPIEN        Internal Entry Number of the image record
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 P  Include page counts (see the NUMBER OF PAGES
 ;                    field (114) for details).
 ;
 ;                 S  Return image counts grouped by image status in
 ;                    the array defined by the DETAILS parameter.
 ;
 ;                 U  Return image counts grouped by users in
 ;                    the array defined by the DETAILS parameter.
 ;
 ; [.DETAILS]    Reference to a local array where detailed image
 ;               counts are returned.
 ;
 ; DETAILS(
 ;   "S",
 ;     Status)   Counts of images with this internal value of the
 ;               STATUS field (112). Zero subscript is used if the
 ;               field is empty.
 ;                 ^01: Number of existing entries
 ;                 ^02: Number of deleted entries
 ;                 ^03: Number of existing images (pages)
 ;                 ^04: Number of deleted images (pages)
 ;
 ;               This list is compiled only if the "S" flag is
 ;               provided (see the FLAGS parameter above).
 ;   "U",
 ;     UserIEN,  Counts of images captured by this user (see the
 ;               IMAGE SAVE BY field (8). Zero subscript is used
 ;               if the field is empty.
 ;                 ^01: Number of existing entries
 ;                 ^02: Number of deleted entries
 ;                 ^03: Number of existing images (pages)
 ;                 ^04: Number of deleted images (pages)
 ;
 ;       Status) Counts of images with this internal value of the
 ;               STATUS field (112) captured by the user. Zero
 ;               subscript is used if the field is empty.
 ;                 ^01: Number of existing entries
 ;                 ^02: Number of deleted entries
 ;                 ^03: Number of existing images (pages)
 ;                 ^04: Number of deleted images (pages)
 ;
 ;               This list is compiled only if the "U" flag is
 ;               provided (see the FLAGS parameter above).
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;          '<0  Numbers of images in the group
 ;                 ^01: Number of existing entries
 ;                 ^02: Number of deleted entries
 ;                 ^03: Number of existing images (pages)
 ;                 ^04: Number of deleted images (pages)
 ;
 ; Notes
 ; =====
 ;
 ; Pieces 3 and 4 of the function result and nodes of the DETAILS are 
 ; populated only if the P flag is provided (see the FLAGS parameter).
 ;
 ; This function does not return an error code when it encounters an
 ; invalid image reference in the OBJECT GROUP multiple (4); it just
 ; skips the entry.
 ;
GRPCT(GRPIEN,FLAGS,DETAILS) ;
 N I,IEN,MAGF,NT,TMP,TOTALS
 K DETAILS("S"),DETAILS("U")
 ;--- Validate control flags
 S FLAGS=$G(FLAGS),NT=2
 Q:$TR(FLAGS,"PSU")'="" $$IPVE^MAGUERR("FLAGS")
 S:FLAGS["P" MAGF("P")="",NT=4
 S:FLAGS["S" MAGF("D","S")=""
 S:FLAGS["U" MAGF("D","U")=""
 ;--- Validate the record IEN
 I '$$ISVALID^MAGGI11(GRPIEN,.TMP)  D STORE^MAGUERR(TMP)  Q TMP
 ;
 ;--- Count existing (non-deleted) members and pages
 I $D(MAGF)>1  D
 . N CHIEN
 . S CHIEN=0
 . F  S CHIEN=$O(^MAG(2005,GRPIEN,1,CHIEN))  Q:CHIEN'>0  D
 . . S IEN=+$G(^MAG(2005,GRPIEN,1,CHIEN,0))  ; OBJECT GROUP (.01)
 . . Q:IEN'>0  Q:$D(^MAG(2005,IEN))<10
 . . S TOTALS(1)=$G(TOTALS(1))+1
 . . D GRPCT1(2005,IEN,1)
 . . Q
 . Q
 E  D
 . S TOTALS(1)=+$P($G(^MAG(2005,GRPIEN,1,0)),U,4)
 . Q
 ;
 ;--- Count deleted members and pages
 S IEN=0
 F  S IEN=$O(^MAG(2005,"AGPD",GRPIEN,IEN))  Q:IEN'>0  D
 . Q:$D(^MAG(2005,IEN))<10
 . S TOTALS(2)=$G(TOTALS(2))+1
 . D:$D(MAGF)>1 GRPCT1(2005,IEN,2)
 . Q
 ;
 ;~~~ Delete this comment and the following lines of code when
 ;~~~ the IMAGE AUDIT file (#2005.1) is completely eliminated.
 S IEN=0
 F  S IEN=$O(^MAG(2005.1,"AGP",GRPIEN,IEN))  Q:IEN'>0  D
 . Q:$D(^MAG(2005.1,IEN))<10
 . S TOTALS(2)=$G(TOTALS(2))+1
 . D:$D(MAGF)>1 GRPCT1(2005.1,IEN,2)
 . Q
 ;
 ;--- Calculate users' totals
 D:$D(MAGF("D","U"))
 . N STC,USRIEN
 . S USRIEN=""
 . F  S USRIEN=$O(DETAILS("U",USRIEN))  Q:USRIEN=""  D
 . . S STC=""  K TMP
 . . F  S STC=$O(DETAILS("U",USRIEN,STC))  Q:STC=""  D
 . . . S TMP=DETAILS("U",USRIEN,STC)
 . . . F I=1:1:NT  S TMP(I)=$G(TMP(I))+$P(TMP,U,I)
 . . . Q
 . . F I=1:1:NT  S $P(DETAILS("U",USRIEN),U,I)=+$G(TMP(I))
 . . Q
 . Q
 ;
 ;--- Return group totals
 S TMP=""
 F I=1:1:NT  S $P(TMP,U,I)=+$G(TOTALS(I))
 Q TMP
 ;
 ;+++++ DETAILED COUNTS FOR THE IMAGE
 ;
 ; FILE          File number (2005 or 2005.1)
 ; IEN           IEN of the image entry
 ; CP            Piece number for the entry count (1 or 2)
 ;
 ; Input Variables
 ; ===============
 ;   DETAILS, MAGF, TOTALS
 ;
 ; Output Variables
 ; ================
 ;   DETAILS, TOTALS
 ;
GRPCT1(FILE,IEN,CP) ;
 N NP,STC,TMP,USRIEN
 ;--- Count the pages
 D:$D(MAGF("P"))
 . S NP=+$P($G(^MAG(FILE,IEN,100)),U,10)  ; NUMBER OF PAGES (114)
 . S:NP'>0 NP=1
 . S TOTALS(CP+2)=$G(TOTALS(CP+2))+NP
 . Q
 ;--- Get the image status code for detailed counts
 Q:$D(MAGF("D"))<10
 S STC=+$$IMGST^MAGGI11(IEN,.TMP)  Q:TMP<0
 ;--- Counts by image statuses
 D:$D(MAGF("D","S"))
 . S TMP=$G(DETAILS("S",STC))
 . S $P(DETAILS("S",STC),U,CP)=$P(TMP,U,CP)+1
 . S:$G(NP)>0 $P(DETAILS("S",STC),U,CP+2)=$P(TMP,U,CP+2)+NP
 . Q
 ;--- Counts by users
 D:$D(MAGF("D","U"))
 . S USRIEN=+$P($G(^MAG(FILE,IEN,2)),U,2)  ; IMAGE SAVE BY (8)
 . S TMP=$G(DETAILS("U",USRIEN,STC))
 . S $P(DETAILS("U",USRIEN,STC),U,CP)=$P(TMP,U,CP)+1
 . S:$G(NP)>0 $P(DETAILS("U",USRIEN,STC),U,CP+2)=$P(TMP,U,CP+2)+NP
 . Q
 Q
