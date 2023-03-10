MAGDRPCG ;WOIFO/PMK - Imaging RPCs ; Dec 06, 2021@10:34:52
 ;;3.0;IMAGING;**305**;Mar 19, 2002;Build 3
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
 ;
GETLRDFN(OUT,DFN,LRSSLIST) ; RPC = MAG DICOM GET LAB PAT LRDFN
 N LRDFN
 I '$D(DFN) S OUT="-1,DFN required" Q
 I DFN'?1N.N S OUT="-2,DFN must be a numeric value, not """_DFN_"""" Q
 I '$D(^DPT(DFN)) S OUT="-3,Patient with DFN """_DFN_""" is not defined" Q 
 I '$D(LRSSLIST) S OUT="-4,List of LRSS values is required" Q
 S LRDFN=$$GET1^DIQ(2,DFN,63)
 I LRDFN="" S OUT="-5,Patient has no Laboratory studies"
 E  D
 . N HIT,I,MSG,N
 . S HIT=0,MSG="-6,Patient has no Anatomic Pathology ",N=$O(LRSSLIST(""),-1)
 . F I=1:1 Q:'$D(LRSSLIST(I))  D  Q:HIT
 . . S LRSS=LRSSLIST(I) I $D(^LR(LRDFN,LRSS)) S HIT=1 Q
 . . S MSG=MSG_LRSS
 . . I I=1 S MSG=MSG_$S(N=2:" or ",N=3:", ",1:"")
 . . I I=2 S MSG=MSG_$S(N=3:", or ",1:"")
 . . Q
 . I 'HIT S OUT=MSG_" studies"
 . E  S OUT=LRDFN
 . Q
 Q
 ;
GETDFN(OUT,LRDFN) ; RPC = MAG DICOM GET LAB PAT DFN
 N FILENAME
 I '$D(LRDFN) S OUT="-1,LRDFN required" Q
 I LRDFN'?1N.N S OUT="-2,LRDFN must be a numeric value, not """_LRDFN_"""" Q
 I '$D(^LR(LRDFN)) S OUT="-3,Patient with LRDFN """_LRDFN_""" is not defined in LAB file (#63)" Q 
 ; check for PATIENT file (#2)
 S FILENAME=$$GET1^DIQ(63,LRDFN,.02)
 I FILENAME'="PATIENT" D  Q
 . S OUT="-4,Patient with LRDFN """_LRDFN_""" is in the """_FILENAME_""" file, not the PATIENT file (#2)"
 . Q
 S OUT=$$GET1^DIQ(63,LRDFN,.03,"I")
 Q
 ;
PATIENT(OUT,SORTORDER,LRDFN,LRSSLIST,BEGDATE,ENDDATE) ; RPC = MAG DICOM GET LAB BY PAT
 N DIRECTION,DONE,HIT,I,LRI,LRSS,NOUT,STARTDATE,STOPDATE
 K OUT
 I '$D(SORTORDER) S OUT="-1,SORTORDER required" Q
 I '$D(LRDFN) S OUT="-2,LRDFN required and may not be null" Q
 I '$D(LRSSLIST) S OUT="-3,List of LRSS values is required" Q
 I '$D(BEGDATE) S OUT="-4,BEGDATE required and may not be null" Q
 I '$D(ENDDATE) S OUT="-5,ENDDATE required and may not be null" Q
 ;
 I SORTORDER="ASCENDING" D
 . S DIRECTION=1
 . S STARTDATE=$$REVDATE(BEGDATE),STOPDATE=$$REVDATE(ENDDATE)
 . Q
 E  I SORTORDER="DESCENDING" D
 . S DIRECTION=-1
 . S STARTDATE=$$REVDATE(ENDDATE),STOPDATE=$$REVDATE(BEGDATE)
 . Q
 E  S OUT="-6,SORTORDER must be either ASCENDING or DESCENDING, not """_SORTORDER_"""" Q
 ;
 S NOUT=1
 ;
 S HIT=0 F I=1:1 Q:'$D(LRSSLIST(I))  S LRSS=LRSSLIST(I) I $D(^LR(LRDFN,LRSS)) D
 . S HIT=1,DONE=0,LRI=STARTDATE ; $O thru reverse dates
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRI),-DIRECTION) Q:'LRI  Q:DONE  D
 . . I DIRECTION=1,LRI<STOPDATE S DONE=1 Q
 . . I DIRECTION=-1,LRI>STOPDATE S DONE=1 Q
 . . D LOOKUP1(LRDFN,LRSS,LRI)
 . . Q
 . Q
 I NOUT=1 D
 . I 'HIT S OUT(1)="-7,Patient has no Anatomic Pathology (CY, EM, or SR) studies"
 . E  S OUT(1)="-8,Patient has no Anatomic Pathology (CY, EM, or SR) images"
 . Q
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
LOOKUP(OUT,LRDFN,LRSS,LRI) ; RPC = MAG DICOM GET LAB IMAGES
 N NOUT
 K OUT
 I '$D(LRDFN) S OUT="-1,LRDFN required and may not be null" Q
 I '$D(LRSS) S OUT="-2,LRSS required" Q
 I '$D(LRI) S OUT="-3,LRI required and may not be null" Q
 ;
 S NOUT=1
 ;
 D LOOKUP1(LRDFN,LRSS,LRI)
 ;
 I NOUT=1 D
 . S OUT(1)="-4,Patient has no Anatomic Pathology (CY, EM, or SR) images"
 . Q
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
LOOKUP1(LRDFN,LRSS,LRI) ; lookup an anatomic pathology image
 ; Images can be assocated with the TIU External Data file (#8925.91),
 ; or DICOM LAB TEMP LIST file (#2006.5838), or stored in the new
 ; SOP Class database IMAGE STUDY file (#2005.62) -- check all three
 N ACNUMB,NODE0X,NODE0Y,PARENTFILE
 S NODE0X=$G(^LR(LRDFN,LRSS,0)) Q:NODE0X=""
 S PARENTFILE=+$P(NODE0X,"^",2) Q:'PARENTFILE
 S NODE0Y=^LR(LRDFN,LRSS,LRI,0),ACNUMB=$P(NODE0Y,"^",6)
 ; W !,"ACNUMB = ",ACNUMB
 D TIU(LRDFN,LRSS,LRI,ACNUMB) ; check the TIU External Data file (#8925.91)
 D LABTEMP(PARENTFILE,LRDFN,LRSS,LRI,ACNUMB) ; check the DICOM LAB TEMP LIST file (#2006.5838)
 D NEWSOP(LRSS,LRI,ACNUMB) ;  check the new SOP Class database IMAGE STUDY file (#2005.62)
 Q
 ;
TIU(LRDFN,LRSS,LRI,ACNUMB) ; check for images assocated with the TIU External Data file (#8925.91)
 N MAGIEN,NODE0,TIU892591IEN,TIUIEN
 I '$D(^LR(LRDFN,LRSS,LRI,.05,"C")) Q  ; there is no TIU pointer
 S TIUIEN=0
 F  S TIUIEN=$O(^LR(LRDFN,LRSS,LRI,.05,"C",TIUIEN)) Q:'TIUIEN  D
 . S TIU892591IEN=""
 . F  S TIU892591IEN=$O(^TIU(8925.91,"B",TIUIEN,TIU892591IEN)) Q:TIU892591IEN=""  D
 . . S NODE0=^TIU(8925.91,TIU892591IEN,0)
 . . S MAGIEN=$P(NODE0,"^",2)
 . . S NOUT=NOUT+1,OUT(NOUT)=MAGIEN_"^"_ACNUMB_"^"_$$REVDATE(LRI)_"^"_LRSS_"^"_LRI
 . . Q
 . Q
 Q
 ;
LABTEMP(PARENTFILE,LRDFN,LRSS,LRI,ACNUMB) ; check for images assocated with the DICOM LAB TEMP LIST file (#2006.5838)
 N MAG20065838IEN,MAGIEN,NODE0
 S MAG20065838IEN=0
 S MAG20065838IEN=$O(^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,MAG20065838IEN)) Q:'MAG20065838IEN  D
 . S NODE0=$G(^MAG(2006.5838,MAG20065838IEN,0)) Q:NODE0=""
 . S MAGIEN=$P(NODE0,"^",4)
 . S NOUT=NOUT+1,OUT(NOUT)=MAGIEN_"^"_ACNUMB_"^"_$$REVDATE(LRI)_"^"_LRSS_"^"_LRI
 . Q
 Q
 ;
NEWSOP(LRSS,LRI,ACNUMB) ; check for images in the new SOP Class database IMAGE STUDY file (#2005.62)
 N MAGV200562
 S MAGV200562=0
 S MAGV200562=$O(^MAGV(2005.62,"D",ACNUMB,MAGV200562)) Q:'MAGV200562  D
 . S NOUT=NOUT+1,OUT(NOUT)="New SOP Class DB^"_ACNUMB_"^"_$$REVDATE(LRI)_"^"_LRSS_"^"_LRI
 . Q
 Q
 ;
DATE(OUT,SUBSCRIPTLEVEL,SORTORDER,LRSS,DATE,LRDFN,LRI) ; RPC = MAG DICOM GET LAB BY DATE
 N DIRECTION,LRO
 K OUT
 I '$D(SUBSCRIPTLEVEL) S OUT="-1,SUBSCRIPT LEVEL required" Q
 I '$D(SORTORDER) S OUT="-2,SORTORDER required" Q
 I '$D(LRSS) S OUT="-3,LRSS required" Q
 I '$D(DATE) S OUT="-4,DATE required and may not be null" Q
 I '$D(LRDFN) S OUT="-5,LRDFN required and may not be null" Q
 I '$D(LRI) S OUT="-6,LRI required and may not be null" Q
 ;
 I SUBSCRIPTLEVEL'=1,SUBSCRIPTLEVEL'=2,SUBSCRIPTLEVEL'=3 S OUT="-7,SUBSCRIPT LEVEL must be either 1, 2, or 3, not """_SUBSCRIPTLEVEL_"""" q
 ;
 I SORTORDER="ASCENDING" D
 . S DIRECTION=1
 . Q
 E  I SORTORDER="DESCENDING" D
 . S DIRECTION=-1
 . S:DATE=0 DATE="" S:LRDFN=0 LRDFN="" S:LRI=0 LRI="" ; needed for reverse $O
 . Q
 E  S OUT="-8,SORTORDER must be either ASCENDING or DESCENDING, not """_SORTORDER_"""" Q
 ;
 S LRO="A"_LRSS
 ;
 ; ^LR(LRO,DATE,LRDFN,LRI)=""
 ;
 I SUBSCRIPTLEVEL=1 S OUT=$O(^LR(LRO,DATE),DIRECTION)
 E  I SUBSCRIPTLEVEL=2 S OUT=$O(^LR(LRO,DATE,LRDFN),DIRECTION)
 E  I SUBSCRIPTLEVEL=3 S OUT=$O(^LR(LRO,DATE,LRDFN,LRI),DIRECTION)
 ; I SUBSCRIPTLEVEL=3,LRI W !,"LR(""",LRO,""",",DATE,",",LRDFN,",",LRI,")"
 ; W !,"LR(""",LRO,""",",DATE,",",LRDFN,",",LRI,")"
 Q
 ;
NXTLRDFN(OUT,SORTORDER,LRDFN,LRSSLIST) ; RPC = MAG DICOM GET LAB NEXT LRDFN
 N DIRECTION,HIT,I,LRSS
 I '$D(SORTORDER) S OUT="-1,SORTORDER required" Q
 I $G(LRDFN)="" S OUT="-2,LRDFN required and may not be null" Q
 I LRDFN'?1N.N S OUT="-3,LRDFN must be a numeric value, not ""_LRDFN_""" Q
 I SORTORDER="ASCENDING" D
 . S DIRECTION=1
 . Q
 E  I SORTORDER="DESCENDING" D
 . S DIRECTION=-1
 . I LRDFN=0 S LRDFN=" " ; reverse $O origin
 . Q
 E  S OUT="-4,SORTORDER must be either ASCENDING or DESCENDING, not """_SORTORDER_"""" Q
 ;
 I '$D(LRSSLIST) S OUT="-5,List of LRSS values is required" Q
 K OUT
 S HIT=0 F  S LRDFN=+$O(^LR(LRDFN),DIRECTION) Q:LRDFN=0  D  Q:HIT
 . F I=1:1 Q:'$D(LRSSLIST(I))  S LRSS=LRSSLIST(I) I $D(^LR(LRDFN,LRSS)) S HIT=1 Q
 . Q
 S OUT=+LRDFN
 ;
 Q
 ;
REVDATE(DATE) ; convert a LAB date to a FM date and vice versa
 Q 9999999-DATE ; unlike radiology which uses 9999999.9999
