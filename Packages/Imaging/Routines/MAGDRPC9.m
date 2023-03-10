MAGDRPC9 ;WOIFO/EDM/MLH/JSL/SAF/DAC/PMK/JSJ - Imaging RPCs ; Jun 23, 2022@15:30:40
 ;;3.0;IMAGING;**50,54,53,49,123,118,138,180,190,239,280,305,307**;Mar 19, 2002;Build 28
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
 ; Reference to FIND1^DIC in ICR #2051
 ; Reference to GET1^DIQ in ICR #2056
 ; Reference to ^RA(74 in ICR #1171
 ; Reference to ^RA(70 in ICR #1172
 ; Reference to ACCFIND^RAAPI in ICR #5020
 ; Reference to HDIFF^XLFDT in ICR #10103
 ; Reference to HTFM^XLFDT in ICR #10103
 ; Reference to GETICN^MPIF001 in ICR #2701
 ;
 Q
 ;
UIDROOT(OUT) ; RPC = MAG DICOM GET UID ROOT
 S OUT=$G(^MAGD(2006.15,1,"UID ROOT"))
 Q
 ;
NEWUID(OUT,OLD,NEW,IMAGE,DBTYPE) ; RPC = MAG NEW SOP INSTANCE UID
 N D0,L,X,SOPREC,ORIGSOP
 S DBTYPE=$G(DBTYPE,"OLD")
 S IMAGE=+$G(IMAGE),OLD=$G(OLD)
 S:$G(NEW)="" NEW=OLD
 D:DBTYPE="OLD"
 . S D0=IMAGE
 . I 'D0 S OUT="-2,Cannot find image with UID "_OLD Q
 . S OUT=$P($G(^MAG(2005,D0,"SOP")),"^",2) Q:OUT'=""
 . S L=$L(NEW,".")-1,X=$P(NEW,".",L+1),L=$P(NEW,".",1,L)_"."
 . L +^MAG(2005,"P"):1E9 ; Background process MUST wait
 . S OUT="" F  D  Q:OUT'=""
 . . S OUT=L_X
 . . I $L(OUT)>64 S OUT="-3,Cannot use "_NEW_" to create valid UID" Q
 . . I $D(^MAG(2005,"P",OUT)) S OUT="",X=X+1 Q
 . . S $P(^MAG(2005,D0,"SOP"),"^",2)=OUT
 . . S ^MAG(2005,"P",OUT,D0)=1
 . . Q
 . L -^MAG(2005,"P")
 . Q
 D:DBTYPE="NEW"
 . S D0=0 S:OLD'="" D0=$O(^MAGV(2005.64,"B",OLD,""))
 . I IMAGE,D0,IMAGE'=D0 S OUT="-1,UID cannot belong to multiple images ("_IMAGE_"/"_D0_")" Q
 . I IMAGE,'D0 S D0=IMAGE
 . S SOPREC=$G(^MAGV(2005.64,D0,0))
 . I SOPREC="" S OUT="-2,IMAGE SOP INSTANCE record not found ("_D0_")" Q
 . S ORIGSOP=$P(SOPREC,"^",2)
 . I ORIGSOP'="" D  Q
 . . I OLD=ORIGSOP S OUT=$P(SOPREC,"^",1) Q
 . . S OUT="-3,ORIGINAL SOP INSTANCE UID for image ("_ORIGSOP
 . . S OUT=OUT_") does not match value sent ("_OLD
 . . Q
 . ; need to verify and store the new SOP
 . S L=$L(NEW,".")-1,X=$P(NEW,".",L+1),L=$P(NEW,".",1,L)_"."
 . L +^MAGV(2005.64,"B"):1E9 ; Background process MUST wait
 . S OUT="" F  D  Q:OUT'=""
 . . S OUT=L_X
 . . I $L(OUT)>64 S OUT="-3,Cannot use "_NEW_" to create valid UID" Q
 . . I $D(^MAGV(2005.64,"B",OUT)) S OUT="",X=X+1 Q
 . . S $P(SOPREC,"^",2)=$P(SOPREC,"^",1) K ^MAGV(2005.64,"B",$P(SOPREC,"^",1),D0)
 . . S $P(SOPREC,"^",1)=OUT,^MAGV(2005.64,"B",OUT,D0)=""
 . . S ^MAGV(2005.64,D0,0)=SOPREC
 . . Q
 . L -^MAGV(2005.64,"B")
 . Q
 Q
 ;
QRNEWUID(IDX,DBTYPE) ; Get updated UID for Query/Retrieve - P280 DAC - Modified to reflect that index can be Image or SOP
 N DATE,DH,FAIL,I,OLD,OUT,NEW,LASTUID,NEXTUID,TIME,X,Y
 S DBTYPE=$G(DBTYPE,"OLD")
 ; P280 DAC - Modified to set the indexes based on the type of data base referenced 
 I DBTYPE="OLD" S IMAGE=+$G(IDX)
 I DBTYPE="NEW" S SOPIX=+$G(IDX)
 D:DBTYPE="OLD"  ; find new UID, if any, in legacy DB
 . S NEW=$P($G(^MAG(2005,IMAGE,"PACS")),"^",1) ; P239 DAC - Modified to pull from PACS node (not SOP)
 . Q
 D:DBTYPE="NEW"  ; find new UID, if any, in P34 DB
 . ; P280 DAC - Modified to use the SOP index instead of the Image index
 . S NEW="" S:$P($G(^MAGV(2005.64,SOPIX,0)),"^",2)'="" NEW=$P(^(0),"^",1)
 . Q
 Q:NEW'="" NEW
 ; Generate the next UID using date/time and counter
 L +^MAGDICOM(2006.563,1,"MACHINE ID"):1E9 ; Background process must wait
 S LASTUID=$G(^MAGDICOM(2006.563,1,"LAST UID"))
 ; Can't use D NOW^XLFDT to set DH because it is incorrect at midnight
 S DH=$H,X=$$HTFM^XLFDT(DH,1),DATE=X+17000000
 S X=$P(DH,",",2) D
 . N H,M,S
 . S H=X\3600,M=X\60#60,S=X#60
 . S TIME=H*100+M*100+S
 . Q
 S NEXTUID=$G(^MAGD(2006.15,1,"UID ROOT"))
 I NEXTUID="" S $EC=",13:No UID Root defined - Run INIT^MAGDRUID," ; Fatal Error
 ; UID type = 7, Machine ID = 0
 S NEXTUID=NEXTUID_".1.7."_(+$G(DUZ(2)))_".0."_DATE_"."_TIME_".0"
 ; Remove leading 0s from UID components
 F I=1:1:$L(NEXTUID,".") S $P(NEXTUID,".",I)=+$P(NEXTUID,".",I)
 I $P(NEXTUID,".",1,10)=$P(LASTUID,".",1,10) D
 . S NEXTUID=LASTUID
 . S $P(NEXTUID,".",11)=$P(NEXTUID,".",11)+1
 . Q
 S ^MAGDICOM(2006.563,1,"LAST UID")=NEXTUID
 L -^MAGDICOM(2006.563,1,"MACHINE ID")
 ; P280 DAC - Modified new data structure to use the SOP index instead of the Image index
 S OLD=$S(DBTYPE="OLD":$P($G(^MAG(2005,IMAGE,"PACS")),"^",1),1:$P($G(^MAGV(2005.64,SOPIX,0)),"^",1))
 ; P280 DAC - Modifed to send the correct index type for each both DB types
 D NEWUID(.OUT,OLD,NEXTUID,IDX,DBTYPE) ; Store the new UID with the image
 Q OUT
 ;
NEXT(OUT,SEED,DIR) ; RPC = MAG RAD GET NEXT RPT BY DATE
 N D2,DFN,EXAMDATE,NAME
 ;
 ; ^RADPT(DFN,"DT",D1,"P",D2,0) = Data, $P(17) = pointer to report
 ; ^RADPT("AR",9999999.9999-D1,DFN,D1)="" ; IA # 65
 ;
 ; OUT = report_pointer ^ ExamDate ^ Patient ^ D2
 ;
 S SEED=$G(SEED),DIR=$S($G(DIR)<0:-1,1:1) ; default is ascending order
 S EXAMDATE=$P(SEED,"^",1),DFN=$P(SEED,"^",2),D2=$P(SEED,"^",3)
 S OUT=0 F  D  Q:OUT
 . I EXAMDATE="" S EXAMDATE=$O(^RADPT("AR",""),DIR),DFN="" ; IA # 65
 . I EXAMDATE="" S OUT=-1 Q
 . I DFN="" S DFN=$O(^RADPT("AR",EXAMDATE,""),DIR) ; IA # 65
 . I DFN="" S EXAMDATE=$O(^RADPT("AR",EXAMDATE),DIR),D2="" Q  ; IA # 65
 . S:'D2 D2=$S(DIR>0:0,1:" ")
 . S D2=$O(^RADPT(DFN,"DT",9999999.9999-EXAMDATE,"P",D2),DIR) ; IA # 1172
 . I 'D2 D  Q
 . . S DFN=$O(^RADPT("AR",EXAMDATE,DFN),DIR),D2="" ; IA # 65
 . . I 'DFN D
 . . . S EXAMDATE=$O(^RADPT("AR",EXAMDATE),DIR),DFN="" ; IA # 65
 . . . I EXAMDATE="" S OUT=-1
 . . . Q
 . . Q
 . S OUT=$P($G(^RADPT(DFN,"DT",9999999.9999-EXAMDATE,"P",D2,0)),"^",17) ; IA # 1172
 . S:OUT OUT=OUT_"^"_EXAMDATE_"^"_DFN_"^"_D2
 . Q
 Q
 ;
NXTPTRPT(OUT,DFN,RARPT1,DIR) ; RPC = MAG RAD GET NEXT RPT BY PT
 S DFN=$G(DFN)
 I 'DFN S OUT="-1,Patient DFN not passed" Q
 I '$D(^RARPT("C",DFN)) S OUT="-2,Patient does not have any radiology reports" Q  ; IA # 2442
 S RARPT1=$G(RARPT1),DIR=$S($G(DIR)<0:-1,1:1) ; default is ascending order
 S OUT=$O(^RARPT("C",DFN,RARPT1),DIR) ; IA # 2442
 Q
 ;
GETICN(OUT,DFN) ; RPC = MAG DICOM GET ICN
 S OUT=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI")
 Q
 ;
INIT(OUT,LOCATION,COUNTONLY) ; RPC = MAG DICOM QUEUE INIT (moved from ^MAGDRPC4)
 N ACNUMB,COUNT,D0,D1,IMAGEDB,N,PRIORITY,REQUESTDATETIME,STATE,STUDYUID,X,Y ; P305 PMK 05/12/2021
 I $G(LOCATION)="" S OUT="-3,No origin specified." Q
 I '$D(^MAGDOUTP(2006.574,0)) S OUT="-1,No entries at all in queue." Q
 S COUNTONLY=$G(COUNTONLY,0) ; P305 PMK 11/17/2021
 ;
 ; check for deleting the entire DICOM OBJECT EXPORT file - P305 PMK 01/07/2022
 I LOCATION="ALL" D  Q
 . S N=$P($G(^MAGDOUTP(2006.574,0)),"^",4)
 . I COUNTONLY D
 . . I N D
 . . . S OUT=$S(N=1:"One entry is",1:N_" entries are")
 . . . S OUT=OUT_" present in the Image Transmission Queues for all locations."
 . . . Q
 . . E  S OUT="-2,No entries are present in the Image Transmission Queue."
 . . Q
 . E  D
 . . L +^MAGDOUTP(2006.574):1E9
 . . K ^MAGDOUTP(2006.574)
 . . S ^MAGDOUTP(2006.574,0)="DICOM OBJECT EXPORT^2006.574^0^0"
 . . L -^MAGDOUTP(2006.574)
 . . S OUT="Image Transmission Queue completely initialized, "
 . . S OUT=OUT_$S(N=1:"one entry was",1:N_" entries were")_" deleted."
 . . Q
 . Q
 ;
 ; deleting only a single location
 S N=0,OUT="-2,No entries are present in"
 L +^MAGDOUTP(2006.574):1E9 ; P180 DAC - Lock entire global, background process MUST wait
 S D0=0 F  S D0=$O(^MAGDOUTP(2006.574,D0)) Q:'D0  S X=$G(^(D0,0)) Q:$P(X,"^",4)'=LOCATION  D
 . S N=N+1 Q:COUNTONLY
 . S ACNUMB=$P(X,"^",3),PRIORITY=$P(X,"^",5)
 . S REQUESTDATETIME=$P(X,"^",7),IMAGEDB=$P(X,"^",8)
 . S STUDYUID=$G(^MAGDOUTP(2006.574,D0,2))
 . S D1=0 F  S D1=$O(^MAGDOUTP(2006.574,D0,1,D1)) Q:'D1  S Y=$G(^(D1,0)) D
 . . S STATE=$P(Y,"^",2)
 . . K ^MAGDOUTP(2006.567,D0,1,D1)
 . . K ^MAGDOUTP(2006.574,"STATE",LOCATION,PRIORITY,STATE,D0,D1)
 . . Q
 . K ^MAGDOUTP(2006.574,D0)
 . K:REQUESTDATETIME'="" ^MAGDOUTP(2006.574,"C",REQUESTDATETIME,D0)
 . K:ACNUMB'="" ^MAGDOUTP(2006.574,"D",ACNUMB,D0) ; P305 PMK 05/12/2021
 . I STUDYUID'="",IMAGEDB'="" K ^MAGDOUTP(2006.574,"STUDY",STUDYUID,IMAGEDB,D0)
 . Q
 I N D
 . I COUNTONLY S OUT=$S(N=1:"One entry is",1:N_" entries are")_" present in"
 . E  D
 . . S COUNT=$P(^MAGDOUTP(2006.574,0),"^",4)-N
 . . I COUNT<0 S COUNT=0 ; don't let count become negative
 . . S $P(^MAGDOUTP(2006.574,0),"^",4)=COUNT ; P305 PMK 05/12/2021
 . . S $P(^MAGDOUTP(2006.574,0),"^",3)=0 ; P305 PMK 05/12/2021
 . . S OUT=$S(N=1:"One entry has",1:N_" entries have been")_" deleted from"
 . . Q
 . Q
 S OUT=OUT_" the queue for "_$$GET1^DIQ(4,LOCATION,.01)_"."
 L -^MAGDOUTP(2006.574) ; P180 DAC - Unlock global
 Q
 ;
IENLOOK ; Overflow from MAGDRPC4
 ; lookup image by the IEN
 N ACNUMB,D0,DFN,GROUPIEN,MODIFIER,P,PROCNAME,STUDYDAT,X,Y
 S NUMBER=+$P(NUMBER,"`",2)
 ; patient safety checks
 D CHK^MAGGSQI(.X,NUMBER) I +$G(X(0))'=1 D  Q
 . S OUT(1)="-9,"_$P(X(0),"^",2,999)
 . Q
 S GROUPIEN=$P($G(^MAG(2005,NUMBER,0)),"^",10)
 I GROUPIEN D CHK^MAGGSQI(.X,GROUPIEN) I +$G(X(0))'=1 D  Q
 . S OUT(1)="-10,Group #"_GROUPIEN_": "_$P(X(0),"^",2,999)
 . Q
 ;
 S X=$G(^MAG(2005,NUMBER,2)),P=$P(X,"^",6),D0=$P(X,"^",7)
 I 'P!'D0 D  ; get parent from group
 . S:GROUPIEN X=$G(^MAG(2005,GROUPIEN,2)),P=$P(X,"^",6),D0=$P(X,"^",7)
 . Q
 ;
 S OUT(2)=P_"^"_D0_"^"_NUMBER_"^" ; result w/o Accession Number
 I 'P!'D0 S OUT(1)="-6,Warning - Parent file entry is not present - no Accession Number."
 E  I P=74 D
 . N DATETIME,I,INFO,PROC,RADPT0,RADPT1,RADPT2,RADPT3,RARPT0
 . S X=$$ACCRPT^RAAPI(D0,.INFO)
 . I X<0 S OUT(1)="-11,Radiology Problem: "_X Q
 . S ACNUMB=INFO(1)
 . S RARPT0=$G(^RARPT(D0,0)) ; IA # 1171
 . S RADPT1=$P(RARPT0,"^",2),DATETIME=$P(RARPT0,"^",3)
 . S RADPT2=9999999.9999-DATETIME,RADPT3=1
 . S RADPT0=$G(^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,0))
 . S PROCNAME=$$GET1^DIQ(71,$P(RADPT0,"^",2),.01)
 . S STUDYDAT=17000000+(DATETIME\1)
 . S MODIFIER=""
 . S I=0 F  S I=$O(^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,"M",I)) Q:'I  D
 . . S X=^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,"M",I,0)
 . . S:I>1 MODIFIER=MODIFIER_", " S MODIFIER=MODIFIER_$$GET1^DIQ(71.2,X,.01)
 . . Q
 . S X=P_"^"_D0_"^"_NUMBER_"^"_ACNUMB_"^"_STUDYDAT_"^"_PROCNAME_"^"_MODIFIER
 . S OUT(1)=1,OUT(2)=X
 . Q
 E  I P=8925 D
 . N GMRCIEN,LABINFO
 . ; get pointer from TIU to consult request
 . S X=$$GET1^DIQ(8925,D0,1405,"I") ; IA ???
 . I $P(X,";",2)="GMR(123," D
 . . S GMRCIEN=$P(X,";"),ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN)
 . . S STUDYDAT=17000000+($$GET1^DIQ(123,GMRCIEN,.01,"I")\1)
 . . S PROCNAME=$$GET1^DIQ(123,GMRCIEN,1) ; TO SERVICE
 . . S MODIFIER=$$GET1^DIQ(123,GMRCIEN,4) ; PROCEDURE
 . . S X=P_"^"_D0_"^"_NUMBER_"^"_ACNUMB_"^"_STUDYDAT_"^"_PROCNAME_"^"_MODIFIER
 . . S OUT(1)=1,OUT(2)=X
 . . Q
 . S X=$$GET1^DIQ(8925,D0,.04,"E")
 . I X="LR ANATOMIC PATHOLOGY" D
 . . D GETINFO(.LABINFO,D0)
 . . I $D(LABINFO) D
 . . S X=P_"^"_D0_"^"_NUMBER_"^"_LABINFO("ACNUMB")
 . . S X=X_"^"_LABINFO("DATE")
 . . S X=X_"^"_LABINFO("LAB")_"^"
 . . S OUT(1)=1,OUT(2)=X
 . . Q
 . ; P190 DAC - Next line modified to fix consult look ups that reported errors even though they were succesful
 . I $G(OUT(1))'=1 S OUT(1)="-8,Problem with parent file "_P_", internal entry number "_D0_" - no Accession Number."
 . Q
 E  S OUT(1)="-7,Parent file "_P_" not yet supported - no Accession Number."
 Q
 ;
GETINFO(INFO,TIUIEN) ; scan the TIU document and try to extract the accession number
 N FILE ; ---- LAB DATA subfile numbers and other info
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to repor
 N ABBR,ERROR,I,LRAA,LRSS,IENS,TEXT,X  ;P307
 S IENS=TIUIEN_","
 D GETS^DIQ(8925,IENS,2,"I","TEXT","ERROR")
 F I=1:1 Q:'$D(TEXT(8925,IENS,2,I))  S X=TEXT(8925,IENS,2,I) D
 . I '$D(INFO("ACNUMB")),X["Accession No." D
 . . S INFO("ACNUMB")=$P(X,"Accession No. ",2)
 . . S ABBR=$P(INFO("ACNUMB")," ")  ;P307
 . . S LRAA=$$FIND1^DIC(68,"","BX",ABBR,"","","ERR") ; get lab area index ;P307
 . . S LRSS=$$GET1^DIQ(68,LRAA,.02,"I")  ;P307
 . . S ERRSTAT=$$GETFILE^MAGT7MA(LRSS) I ERRSTAT S INFO("LAB")="" Q
 . . S INFO("LAB")=FILE("NAME")
 . . Q
 . I '$D(INFO("DATE")),X["Date obtained: " S INFO("DATE")=$P(X,"Date obtained: ",2)
 . Q
 Q
 ;
STATS(OUT,SITE) ; RPC = MAG DICOM GET EXPORT QUEUE STS
 N COUNT,D0,D1,NOUT,NOW,PRIORITY,STATE,TIME,WAIT,X,Y
 K OUT
 ;
 I '$G(SITE) S OUT(1)="-1,Location not specified" Q
 ;
 S NOUT=1,OUT(NOUT)=0
 ;
 S NOUT=1,NOW=$H
 S PRIORITY="" F  S PRIORITY=$O(^MAGDOUTP(2006.574,"STATE",SITE,PRIORITY)) Q:PRIORITY=""  D
 . ; Ignore states SUCCESS, NOT ON FILE, IGNORE, and HOLD
 . F STATE="FAIL","WAITING","XMIT" D
 . . S D0=0 F  S D0=$O(^MAGDOUTP(2006.574,"STATE",SITE,PRIORITY,STATE,D0)) Q:'D0  D
 . . . S Y=^MAGDOUTP(2006.574,D0,0)
 . . . S D1=0 F  S D1=$O(^MAGDOUTP(2006.574,"STATE",SITE,PRIORITY,STATE,D0,D1)) Q:'D1  D
 . . . . S X=$G(^MAGDOUTP(2006.574,D0,1,D1,0))
 . . . . S COUNT(D0,STATE)=($G(COUNT(D0,STATE))+1)_"^^"_Y
 . . . . S TIME=$P(X,"^",3)
 . . . . S WAIT=$$TIMEDIFF(NOW,TIME)
 . . . . I $P(COUNT(D0,STATE),"^",2)<WAIT S $P(COUNT(D0,STATE),"^",2)=WAIT
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 ; save output
 S D0=0 F  S D0=$O(COUNT(D0)) Q:D0=""  D
 . S STATE="" F  S STATE=$O(COUNT(D0,STATE)) Q:STATE=""  D
 . . S NOUT=NOUT+1,OUT(1)=NOUT
 . . S OUT(NOUT)=D0_"^"_STATE_"^"_COUNT(D0,STATE)
 . . Q
 . Q
 ;
 Q
 ;
TIMEDIFF(T1,T2) ; formatted time difference
 N RETURN,TIMEDIFF
 S TIMEDIFF=$$HDIFF^XLFDT(T1,T2,2)
 I TIMEDIFF>86400 D  ; greater than a day
 . S RETURN=$$HDIFF^XLFDT(T1,T2,1)_" days"
 . Q
 E  I TIMEDIFF>3600 D   ; greater than an hour
 . S RETURN=(TIMEDIFF+1800)\3600_" hours"
 . Q
 E  I TIMEDIFF>60 D  ; greater than a minute
 . S RETURN=(TIMEDIFF+30)\60_" min."
 . Q
 E  S RETURN=TIMEDIFF_" sec."
 Q RETURN
