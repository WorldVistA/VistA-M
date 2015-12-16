MAGDRPC4 ;WOIFO/EdM - Imaging RPCs ; 18 Nov 2014 9:26 AM
 ;;3.0;IMAGING;**11,30,51,50,54,49,138,156**;Mar 19, 2002;Build 10;Nov 18, 2014
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
LOOKUP(OUT,NUMBER) ; RPC = MAG DICOM LOOKUP STUDY
 ; Look Up for both Radiology and Consults
 N ACCNUM ;--- Accession Number
 N CPTCODE ;-- CPT code for the procedure
 N CPTNAME ;-- CPT name for the procedure
 N DFN ;------ Patient pointer
 N EXAMSTS ;-- Exam status (don't post images to CANCELLED exams)
 N EXAMTYPE ;- Type of exam (Rad,Con, or Lab)
 N GMRCIEN ;-- Pointer for GMRC
 N INFO ;----- return array from $$ACCRPT^RAAPI()
 N PROCDESC ;- Procedure description
 N PROCIEN ;-- Radiology procedure IEN in ^RAMIS(71)
 N RAA ;------ Radiology array (for $$ACCFIND)
 N RAIX ;----- cross reference subscript for case number lookup
 N RADFN ;---- first level subscript in ^RADPT
 N RADTI ;---- second level subscript in ^RADPT (after "DT")
 N RACNI ;---- third level subscript in ^RADPT (after "P")
 N RARPT ;---- Radiology Report pointer
 N I,LIST,NOUT,X,Y,Z
 ;
 K OUT S NOUT=1
 I $G(NUMBER)="" S OUT(1)="-1,No Case or Consult Number Specified" Q
 I $E(NUMBER,2)="`" D  Q
 . ; lookup the image by the IEN
 . D IENLOOK^MAGDRPC9
 . Q
 ;
 S EXAMTYPE=$E(NUMBER,1)
 I "RCL"[EXAMTYPE S NUMBER=$E(NUMBER,2,$L(NUMBER))
 E  S EXAMTYPE=""
 K DFN
 D RADLKUP ; First try Radiology candidates
 I '$D(OUT(1)) D CONLKUP ; Then try CPRS consult/procedure
 I '$D(OUT(1)) D LABLKUP ; Finally try Lab
 I '$D(OUT(1)) S OUT(1)=NOUT-1 ; allow error messages to be passed back in OUT(1)
 Q
 ;
RADLKUP ; Radiology lookup
 I EXAMTYPE'="",EXAMTYPE'="R" Q
 S RACNI=0 ; must get this value to find study
 I NUMBER?1N.N D  Q:'RACNI
 . ; Look for the patient/study in ^RADPT using the Radiology Case Number
 . N RAIX ;----- cross reference subscript for case number lookup 
 . S RAIX=$S($D(^RADPT("C")):"C",1:"AE") ; for Radiology Patch RA*5*7
 . S RAIX=$S(NUMBER["-":"ADC",1:RAIX) ; select the cross-reference
 . S RADFN=$O(^RADPT(RAIX,NUMBER,"")) Q:'RADFN
 . S RADTI=$O(^RADPT(RAIX,NUMBER,RADFN,""))
 . S RACNI=$O(^RADPT(RAIX,NUMBER,RADFN,RADTI,""))
 . Q
 E  D  Q:'RACNI  ; lookup using Radiololgy Package API 
 . S X=$$ACCFIND^RAAPI(NUMBER,.RAA)
 . I X<0 Q
 . S Y=RAA(1)
 . S RADFN=$P(Y,"^",1),RADTI=$P(Y,"^",2),RACNI=$P(Y,"^",3)
 . Q
 Q:'$D(^RADPT(RADFN,0))  ; No patient demographics file pointer
 S DFN=$P(^RADPT(RADFN,0),"^",1)
 Q:'$G(DFN)
 Q:'$D(^RADPT(DFN,"DT",RADTI,0))
 S RARPT=$P($G(^RADPT(DFN,"DT",RADTI,"P",RACNI,0)),"^",17) Q:'RARPT
 S X=$$ACCRPT^RAAPI(RARPT,.INFO)
 I X<0 S OUT(1)="-11,Radiology Problem: "_X Q
 S ACCNUM=INFO(1)
 S I=0 F  S I=$O(^RARPT(RARPT,2005,I)) Q:'I  D
 . S X="74^"_RARPT_"^"_$P($G(^RARPT(RARPT,2005,I,0)),"^",1)_"^"_ACCNUM
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 Q
 ;
CONLKUP ; CPRS Consult/Procedure study lookup
 N ACCNUM,MAGIEN,MAGPTR,REPORTF,REPORTI,TIUIEN,TIUPTR,TIUXIEN,X
 I EXAMTYPE'="",EXAMTYPE'="C" Q
 S X=$$GMRCIEN^MAGDFCNV(NUMBER) S GMRCIEN=$S(X:X,1:NUMBER)
 S ACCNUM=$$GMRCACN^MAGDFCNV(GMRCIEN)
 D
 . N D0,Z
 . S D0=GMRCIEN
 . S DFN=$$GET1^DIQ(123,D0,.02,"I") Q:'DFN
 . S EXAMSTS=$$GET1^DIQ(123,D0,8) ; check for cancelled exam
 . I EXAMSTS="CANCELLED" S OUT(1)="-4,Consult is cancelled" Q
 . S PROCDESC=$$GET1^DIQ(123,D0,1)
 . S Z=$$GET1^DIQ(123,D0,13,"I") ; request type
 . Q
 I '$G(DFN) S OUT(1)="-5,Consult/procedure not on file" Q
 ; Find the images - they can be linked to TIU or imaging file 2006.5839
 S MAGPTR=$O(^MAG(2006.5839,"C",123,GMRCIEN,0))
 I MAGPTR D  Q  ; Found it in ^MAG(2006.5839) - not in ^TIU yet
 . S X=^MAG(2006.5839,MAGPTR,0)
 . S X=$P(X,"^",1)_"^"_$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_ACCNUM
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 D  ; Otherwise find images in ^TIU
 . N I,RESULT,X
 . D TIUALL^MAGDGMRC(GMRCIEN,.RESULT)
 . S I="" F  S I=$O(RESULT(I)) Q:I=""  D
 . . S X="8925^"_$P(RESULT(I),"^",1)_"^"_$P(RESULT(I),"^",3)_"^"_$P(RESULT(I),"^",2)
 . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . Q
 . Q
 Q
 ;
LABLKUP ; Lab (Anatomic Pathology) study lookup
 N ACNUMB,FILEDATA,LRDFN,LRI,LRSS,MAGIEN,MAGPTR,PARENTFILE,PROCDESC,TIUIEN,TIUXIEN,X
 I EXAMTYPE'="",EXAMTYPE'="L" Q
 S ACNUMB=NUMBER D LABLKUP^MAGDIR8A
 I '$G(DFN) S OUT(1)="-6,Anatomic Pathology case not on file" Q
 D SUBFILES^MAGDIR9F(LRSS)
 ; Find the images - they can be linked to TIU or imaging file 2006.5838
 S MAGPTR=$O(^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,0))
 I MAGPTR D  Q  ; Found it in ^MAG(2006.5838) - not in ^TIU yet
 . S X=^MAG(2006.5838,MAGPTR,0)
 . ; separate the two subscripts that point to the study with a comma
 . S X=$P(X,"^",1)_"^"_$P(X,"^",2)_","_$P(X,"^",3)_"^"_$P(X,"^",4)_"^"_ACNUMB
 . S NOUT=NOUT+1,OUT(NOUT)=X
 . Q
 D  ; Otherwise find images in ^TIU
 . S TIUIEN=$$TIUIEN^MAGT7MA(LRSS,LRDFN,LRI)
 . I TIUIEN D
 . . S TIUXIEN=$O(^TIU(8925.91,"B",TIUIEN,""))
 . . I TIUXIEN D
 . . . S MAGIEN=$$GET1^DIQ(8925.91,TIUXIEN,.02,"I")
 . . . S X="8925^"_TIUIEN_"^"_MAGIEN_"^"_ACNUMB
 . . . S NOUT=NOUT+1,OUT(NOUT)=X
 . . . Q
 . . Q
 . Q
 Q
 ;
NEXTIMG(OUT,FROMS,SENT,CHECK) ; RPC = MAG DICOM GET NEXT QUEUE ENTRY
 ; Get next file to be DICOM transmitted
 N H,F1,F2,F3,FROM,I,JBTOHD,LOC,N,PRI,S0,S1,STS,TYPE,X
 S X=$G(FROMS) S:X FROM(X)=1
 S I="" F  S I=$O(FROMS(I)) Q:I=""  S X=$G(FROMS(I)) S:X FROM(X)=1
 I '$O(FROM("")) S OUT(1)="-1,No Origin Specified" Q
 ; First clean up transmitted queue entries
 S I="" F  S I=$O(SENT(I)) Q:I=""  D CLEAN^MAGDRPC9
 S H=$$SECOND($H)
 L +^MAGDOUTP(2006.574,"STS"):1E9 ; Background process MUST wait
 I '$G(CHECK) D  ; do only when called from a transmission process
 . S FROM="" F  S FROM=$O(FROM(FROM)) Q:FROM=""  D
 . . S PRI="" F  S PRI=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI)) Q:PRI=""  D
 . . . S S0="" F  S S0=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI,"XMIT",S0)) Q:S0=""  D
 . . . . S S1="" F  S S1=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI,"XMIT",S0,S1)) Q:S1=""  D
 . . . . . S X=$$SECOND($P($G(^MAGDOUTP(2006.574,S0,1,S1,0),"^^"_$H),"^",3))
 . . . . . Q:H-X<300
 . . . . . S $P(^MAGDOUTP(2006.574,S0,1,S1,0),"^",2)="WAITING"
 . . . . . K ^MAGDOUTP(2006.574,"STS",FROM,PRI,"XMIT",S0,S1)
 . . . . . S ^MAGDOUTP(2006.574,"STS",FROM,PRI,"WAITING",S0,S1)=""
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ; Find the highest priority among the selected FROM locations
 S FROM="" F  S FROM=$O(FROM(FROM)) Q:FROM=""  D
 . S PRI="" F  S PRI=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI)) Q:PRI=""  D
 . . S X=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI,"WAITING","")) S:X PRI(PRI,FROM)=""
 . . Q
 . Q
 S OUT(1)="",PRI=$O(PRI(""),-1) D:PRI'=""
 . S FROM=$O(PRI(PRI,""))
 . S S0="" F  S S0=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI,"WAITING",S0)) Q:S0=""  D  Q:OUT(1)'=""
 . . S S1="" F  S S1=$O(^MAGDOUTP(2006.574,"STS",FROM,PRI,"WAITING",S0,S1)) Q:S1=""  D  Q:OUT(1)'=""
 . . . I '$G(CHECK) D  ; do only when called from a transmission process
 . . . . S $P(^MAGDOUTP(2006.574,S0,1,S1,0),"^",2,3)="XMIT^"_$H
 . . . . K ^MAGDOUTP(2006.574,"STS",FROM,PRI,"WAITING",S0,S1)
 . . . . S ^MAGDOUTP(2006.574,"STS",FROM,PRI,"XMIT",S0,S1)=""
 . . . . Q
 . . . S OUT(1)=1
 . . . S OUT(2)=S0
 . . . S OUT(3)=S1
 . . . S X=$G(^MAGDOUTP(2006.574,S0,0))
 . . . S OUT(4)=$P(X,"^",1) ; Application
 . . . S OUT(5)=$P(X,"^",2) ; Group
 . . . S OUT(6)=$P(X,"^",3) ; Accession Number
 . . . S JBTOHD=+$P(X,"^",6)
 . . . S OUT(7)=+$G(^MAGDOUTP(2006.574,S0,1,S1,0)) ; Image
 . . . S OUT(8)=$P($G(^MAG(2005,+OUT(7),0)),"^",6)
 . . . S TYPE=$S($G(^MAG(2005,+OUT(7),"FBIG"))'="":"BIG",1:"FULL")
 . . . ; 3rd parameter set to 1 to allow retrieval from jukebox
 . . . D FILEFIND^MAGDFB(+OUT(7),TYPE,1,0,.F1,.F2)
 . . . S OUT(9)=F1
 . . . S OUT(10)=F2
 . . . S OUT(11)=$P($G(^MAG(2005,+OUT(7),0)),"^",7) ; P156 DAC - get DFN from image (not group)
 . . . ; get path for *.TXT, always the same as the FULL file
 . . . D FILEFIND^MAGDFB(+OUT(7),"FULL",JBTOHD,0,.F1,.F3)
 . . . S OUT(12)=F3
 . . . S X=$G(^MAGDOUTP(2006.574,S0,1,0))
 . . . S OUT(13)=$P(X,"^",4) ; Object count
 . . . Q
 . . Q
 . Q
 L -^MAGDOUTP(2006.574,"STS")
 I OUT(1)="" D
 . S OUT(1)="-2,Nothing to be transmitted."
 . D CLEANUP
 . Q
 Q
 ;
CLEANUP ; remove old studies
 N I,REQUESTDATETIME,S0,S1,SENT
 S REQUESTDATETIME=$$FMADD^XLFDT($$NOW^XLFDT,-15,0,0,0) ; delete anything 15 days older or older
 F  S REQUESTDATETIME=$O(^MAGDOUTP(2006.574,"C",REQUESTDATETIME),-1) Q:REQUESTDATETIME=""  D
 . S S0="" F  S S0=$O(^MAGDOUTP(2006.574,"C",REQUESTDATETIME,S0)) Q:S0=""  D
 . . S S1=0 F  S S1=$O(^MAGDOUTP(2006.574,S0,1,S1)) Q:S1=""  D
 . . . S I=1,SENT(1)=S0_"^"_S1_"^" D CLEAN^MAGDRPC9 ; STATUS=<null>
 . . . Q
 . . Q
 . Q
 Q
 ;
FIND(DATE,CASE,NUM) ;
 ; Use the ADC x-reference in the radiology patient file
 N NDATE
 S NDATE=$$FMADD^XLFDT(DATE,NUM) Q:NDATE<1 0
 Q $O(^RADPT("ADC",$$MMDDYY(NDATE)_"-"_CASE,""))
 ;
MMDDYY(DAY) ; Convert Fileman date to mmddyy
 I DAY'?7N Q 0
 Q $E(DAY,4,7)_$E(DAY,2,3)
 ;
INIT(OUT,LOCATION) ; RPC = MAG DICOM QUEUE INIT
 N D0,N,PRI,REQUESTDATETIME,STS,STUID,X
 I '$G(LOCATION) S OUT="-3,No origin specified." Q
 I '$D(^MAGDOUTP(2006.574,0)) S OUT="-1,No entries at all in queue." Q
 ;
 S N=0
 S PRI="" F  S PRI=$O(^MAGDOUTP(2006.574,"STS",LOCATION,PRI)) Q:PRI=""  D
 . S STS="" F  S STS=$O(^MAGDOUTP(2006.574,"STS",LOCATION,PRI,STS)) Q:STS=""  D
 . . S D0="" F  S D0=$O(^MAGDOUTP(2006.574,"STS",LOCATION,PRI,STS,D0)) Q:D0=""  D
 . . . S X=$G(^MAGDOUTP(2006.574,D0,0)),REQUESTDATETIME=$P(X,"^",7)
 . . . S STUID=$G(^MAGDOUTP(2006.574,D0,2))
 . . . K ^MAGDOUTP(2006.574,D0)
 . . . K:REQUESTDATETIME'="" ^MAGDOUTP(2006.574,"C",REQUESTDATETIME,D0)
 . . . K:STUID'="" ^MAGDOUTP(2006.574,"STUDY",STUID,D0)
 . . . K ^MAGDOUTP(2006.574,"STS",LOCATION,PRI,STS,D0)
 . . . S N=N+1
 . . . Q
 . . Q
 . Q
 ;
 I 'N S OUT="-2,No entries present for "_$$GET1^DIQ(4,LOCATION,.01)_"." Q
 ;
 S $P(^MAGDOUTP(2006.574,0),"^",4)=$P(^MAGDOUTP(2006.574,0),"^",4)-N
 S OUT=N_" entr"_$S(N=1:"y",1:"ies")_" removed from Image Transmission Queue."
 Q
 ;
SECOND(H) Q H*86400+$P(H,",",2)
 ;
