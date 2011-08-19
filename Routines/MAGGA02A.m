MAGGA02A ;WOIFO/SG - REMOTE PROCEDURES FOR IMAGE PROPERTIES ; 3/9/09 12:50pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
IPDEFS ;+++++ DEFINITIONS OF PROPERTIES FOR IMAGE FILE (#2005)
 ;;==================================================================
 ;;| Parameter  | File  |Field|Type |Flags|        Comment          |
 ;;|------------+-------+-----+-----+-----+-------------------------|
 ;;|CAPTAPP     |2005   | 8.1 | S   | R   | CAPTURE APPLICATION     |
 ;;|CRTNDT      |2005   | 110 | D   | RW  | CREATION DATE           |
 ;;|DTSAVED     |2005   |   7 | D   | R   | DATE/TIME IMAGE SAVED   |
 ;;|GDESC       |2005   |  10 |     | RW  | SHORT DESCRIPTION       |
 ;;|IDFN        |2005   |   5 | P   | R   | PATIENT                 |
 ;;|ISTAT       |2005   |113  | S   | RW  | STATUS                  |
 ;;|ISTATBY     |2005   |113.2| P   | R   | STATUS BY               |
 ;;|ISTATDT     |2005   |113.1| D   | R   | STATUS DATE             |
 ;;|ISTATRSN    |2005   |113.3| P   | RW  | STATUS REASON           |
 ;;|IXCLASS     |       |     | P   | R   | CLASS INDEX             |
 ;;|IXORIGIN    |2005   |  45 | S   | RW  | ORIGIN INDEX            |
 ;;|IXPKG       |2005   |  40 | S   | RW  | PACKAGE INDEX           |
 ;;|IXPROC      |2005   |  43 | P   | RW  | PROC/EVENT INDEX        |
 ;;|IXSPEC      |2005   |  44 | P   | RW  | SPEC/SUBSPEC INDEX      |
 ;;|IXTYPE      |2005   |  42 | P   | RW  | TYPE INDEX              |
 ;;|LDESCR      |2005   |  11 | W   | R   | LONG DESCRIPTION        |
 ;;|OBJNAME     |2005   | .01 |     | R   | OBJECT NAME             |
 ;;|OBJTYPE     |2005   |   3 | P   | R   | OBJECT TYPE             |
 ;;|PARDF       |2005   |  16 | P   | RW  | PARENT DATA FILE#       |
 ;;|PARGRD0     |2005   |  17 |     | RW  | PARENT GLOBAL ROOT D0   |
 ;;|PARGRD1     |2005   |  63 |     | RW  | PARENT GLOBAL ROOT D1   |
 ;;|PARIPTR     |2005   |  18 |     | RW  | PARENT...IMAGE POINTER  |
 ;;|PROC        |2005   |   6 |     | RW  | PROCEDURE               |
 ;;|PROCDT      |2005   |  15 | D   | RW  | PROCEDURE/EXAM DATE/TIME|
 ;;|SAVEDBY     |2005   |   8 | P   | R   | IMAGE SAVE BY           |
 ;;|SENSBY      |2005   |112.2| P   | R   | CONTROLLED BY            |
 ;;|SENSDT      |2005   |112.1| D   | R   | CONTROLLED DATE          |
 ;;|SENSIMG     |2005   |112  | S   | RW  | CONTROLLED IMAGE         |
 ;;==================================================================
 ;
 ; Custom Flags:
 ;   R  Image property can be read
 ;   W  Image property can be modified
 ;
 Q
 ;
IPDEFS1 ;+++++ DEFINITIONS OF PROPERTIES FOR IMAGE AUDIT FILE (#2005.1)
 ;;==================================================================
 ;;| Parameter  | File  |Field|Type |Flags|        Comment          |
 ;;|------------+-------+-----+-----+-----+-------------------------|
 ;;|CAPTAPP     |2005.1 | 8.1 | S   | R   | CAPTURE APPLICATION     |
 ;;|CRTNDT      |2005.1 | 110 | D   | R   | CREATION DATE           |
 ;;|DTSAVED     |2005.1 |   7 | D   | R   | DATE/TIME IMAGE SAVED   |
 ;;|GDESC       |2005.1 |  10 |     | R   | SHORT DESCRIPTION       |
 ;;|IDFN        |2005.1 |   5 | P   | R   | PATIENT                 |
 ;;|ISTAT       |2005.1 |113  | S   | R   | STATUS                  |
 ;;|ISTATBY     |2005.1 |113.2| P   | R   | STATUS BY               |
 ;;|ISTATDT     |2005.1 |113.1| D   | R   | STATUS DATE             |
 ;;|ISTATRSN    |2005.1 |113.3| P   | R   | STATUS REASON           |
 ;;|IXCLASS     |       |     | P   | R   | CLASS INDEX             |
 ;;|IXORIGIN    |2005.1 |  45 | S   | R   | ORIGIN INDEX            |
 ;;|IXPKG       |2005.1 |  40 | S   | R   | PACKAGE INDEX           |
 ;;|IXPROC      |2005.1 |  43 | P   | R   | PROC/EVENT INDEX        |
 ;;|IXSPEC      |2005.1 |  44 | P   | R   | SPEC/SUBSPEC INDEX      |
 ;;|IXTYPE      |2005.1 |  42 | P   | R   | TYPE INDEX              |
 ;;|LDESCR      |2005.1 |  11 | W   | R   | LONG DESCRIPTION        |
 ;;|OBJNAME     |2005.1 | .01 |     | R   | OBJECT NAME             |
 ;;|OBJTYPE     |2005.1 |   3 | P   | R   | OBJECT TYPE             |
 ;;|PARDF       |2005.1 |  16 | P   | R   | PARENT DATA FILE#       |
 ;;|PARGRD0     |2005.1 |  17 |     | R   | PARENT GLOBAL ROOT D0   |
 ;;|PARGRD1     |2005.1 |  63 |     | R   | PARENT GLOBAL ROOT D1   |
 ;;|PARIPTR     |2005.1 |  18 |     | R   | PARENT...IMAGE POINTER  |
 ;;|PROC        |2005.1 |   6 |     | R   | PROCEDURE               |
 ;;|PROCDT      |2005.1 |  15 | D   | R   | PROCEDURE/EXAM DATE/TIME|
 ;;|SAVEDBY     |2005.1 |   8 | P   | R   | IMAGE SAVE BY           |
 ;;|SENSBY      |2005.1 |112.2| P   | R   | CONTROLLED BY            |
 ;;|SENSDT      |2005.1 |112.1| D   | R   | CONTROLLED DATE          |
 ;;|SENSIMG     |2005.1 |112  | S   | R   | CONTROLLED IMAGE         |
 ;;==================================================================
 ;
 ; Custom Flags:
 ;   R  Image property can be read
 ;   W  Image property can be modified
 ;
 Q
 ;
 ;+++++ COMPUTES THE VALUE OF THE IMAGE CLASS PROPERTY
 ;
 ; IMGFILE       Image file number
 ;
 ; IENS          IENS of the image record
 ;
 ; TPIENS        IEN or IENS of the Image Type record in the
 ;               IMAGE INDEX FOR TYPES file (#2005.83). If this
 ;               parameter is not greater than 0, then the IEN is
 ;               loaded from the image record referenced by the
 ;               IMGFILE and IENS parameters.
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 E  Return external value
 ;
 ;                 I  Return internal value
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see $$ERROR^MAGUERR)
 ;            0  Class value is not available
 ;          ...  Property record (for the result array)
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from outside
 ; of the MAGGA02* routines.
 ;
IXCLASS(IMGFILE,IENS,TPIENS,FLAGS) ;
 N MAGBUF1,MAGMSG,RC,TMP
 S RC=0
 ;--- If the Type Index IEN is not provided,
 ;--- then get it form the image record
 I TPIENS'>0  D  Q:(RC<0)!(TPIENS'>0) RC
 . S TPIENS=$$GET1^DIQ(IMGFILE,IENS,42,"I",,"MAGMSG")
 . S:$G(DIERR) RC=$$DBS^MAGUERR("MAGMSG",IMGFILE,IENS)
 . Q
 S TPIENS=(+TPIENS)_","
 ;--- Load the Image Class value(s)
 S TMP=$$TRFLAGS^MAGUTL05(FLAGS,"EI")
 D GETS^DIQ(2005.83,TPIENS,1,TMP,"MAGBUF1","MAGMSG")
 Q:$G(DIERR) $$DBS^MAGUERR("MAGMSG",2005.83,TPIENS)
 ;--- Store the property value(s) to the result array
 S TMP="IXCLASS"_U
 S:FLAGS["I" TMP=TMP_U_MAGBUF1(2005.83,TPIENS,1,"I")
 S:FLAGS["E" TMP=TMP_U_MAGBUF1(2005.83,TPIENS,1,"E")
 Q TMP
 ;
 ;+++++ REPLICATES THE CHANGES FOR A GROUP OF 1 IMAGE
 ;
 ; IMGIEN        IEN of the image record in the IMAGE file (#2005)
 ;
 ; .MAGFDA       FDA array with new data
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Replication is not needed
 ;           >0  IEN of the destination record for replication
 ;
REPLIC(IMGIEN,MAGFDA) ;
 N CNT,FIELD,IENS,IENS1,IMGIEN1
 ;
 ;=== Check if the data replication is needed
 S IMGIEN1=$$GRPIEN^MAGGI12(IMGIEN)  Q:IMGIEN1<0 IMGIEN1
 I IMGIEN1>0  D  Q:CNT<0 CNT  Q:+CNT'=1 0
 . ;--- Check if the IMGIEN references the only "child" of a group
 . S CNT=$$GRPCT^MAGGI14(IMGIEN1)
 . Q
 E  D  Q:IMGIEN1'>0 IMGIEN1
 . ;--- Check if the IMGIEN references a group of 1 child
 . S CNT=$$GRPCT^MAGGI14(IMGIEN)
 . I CNT<0  S IMGIEN1=CNT  Q
 . S IMGIEN1=$S(+CNT=1:$$GRPCH1^MAGGI14(IMGIEN,"E"),1:0)
 . Q
 ;
 ;=== Prepare the data for replication
 S IENS=IMGIEN_",",IENS1=IMGIEN1_","
 F FIELD=10,42,43,44,45,110,112,113,113.3  D
 . Q:'$D(MAGFDA(2005,IENS,FIELD))
 . S MAGFDA(2005,IENS1,FIELD)=MAGFDA(2005,IENS,FIELD)
 . Q
 ;---
 Q IMGIEN1
