MAGDQR04 ;WOIFO/EdM/JSL/SAF - Imaging RPCs for Query/Retrieve ; 08 Aug 2008 9:26 AM
 ;;3.0;IMAGING;**51,54,66,123**;Mar 19, 2002;Build 67;Jul 24, 2012
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
STUDY(OUT,UID,PRMUID) ; RPC = MAG STUDY UID QUERY
 N D1,F1,F2,F3,F4,F5,F6,IMAGE,N,NET,PASS,PAT,PAT0,SERIES,USER,X
 I $G(UID)="" S OUT(1)="-1,No UID specified." Q
 I UID'?1.64(1N,1".") S OUT(1)="-2,Invalid UID format: """_UID_"""." Q
 S PRMUID=$G(PRMUID) S:($L(PRMUID)'=1)!(123'[PRMUID) PRMUID=0
 S N=1,PAT=""
 S SERIES="" F  S SERIES=$O(^MAG(2005,"P",UID,SERIES)) Q:SERIES=""  D
 . S X=$G(^MAG(2005,SERIES,0))
 . S PAT0=$P(X,"^",7) D:PAT0
 . . I PAT="" S PAT=PAT0 Q
 . . Q:PRMUID=1
 . . S:PAT'=PAT0 PAT=-1
 . . Q
 . I $P(X,"^",10) D VALID(SERIES) Q
 . S D1=0 F  S D1=$O(^MAG(2005,SERIES,1,D1)) Q:'D1  D
 . . S IMAGE=+$G(^MAG(2005,SERIES,1,D1,0)) D:IMAGE VALID(IMAGE)
 . . Q
 . Q
 I PAT<0 S OUT(1)="-13,Duplicate Study UID" Q
 S SERIES="" F  S SERIES=$O(^MAG(2005,"SERIESUID",UID,SERIES)) Q:SERIES=""  D
 . I $P($G(^MAG(2005,SERIES,0)),"^",10) D VALID(SERIES) Q
 . S D1=0 F  S D1=$O(^MAG(2005,SERIES,1,D1)) Q:'D1  D
 . . S IMAGE=+$G(^MAG(2005,SERIES,1,D1,0)) D:IMAGE VALID(IMAGE)
 . . Q
 . Q
 S X=" image" S:N'=2 X=X_"s" S X=X_" found"
 S OUT(1)=(N-1)_X
 Q
 ;
VALID(IMAGE) N T,UID,UNIQ
 N DATE,Q,T1,T2,T3
 D CHK^MAGGSQI(.X,IMAGE) I +$G(X(0))'=1 D  Q
 . S N=N+1,OUT(N)=IMAGE_"^-13,Questionable Integrity"
 . Q
 S UNIQ=0,UID=$P($G(^MAG(2005,IMAGE,"PACS")),"^",1) D:UID'=""
 . S T="" F  S T=$O(^MAG(2005,"P",UID,T)) Q:T=""  D
 . . S UNIQ=UNIQ+1
 . . S DATE($G(^MAG(2005,T,2))\1_" ",T)=""
 . . Q
 . Q
 S Q=0 I UNIQ>1 D  Q:Q
 . Q:PRMUID=1
 . I PRMUID=0 S Q=1,N=N+1,OUT(N)=IMAGE_"^-14,Multiple images with UID="""_UID_"""." Q
 . S DATE=$O(DATE(""),-PRMUID*2+5) S:DATE="" DATE="?"
 . S:'$D(DATE(DATE,IMAGE)) Q=1
 . Q
 S NET=$P($G(^MAG(2005,IMAGE,0)),"^",3),(USER,PASS)=""
 I NET S X=$G(^MAG(2005.2,NET,2)),USER=$P(X,"^",1),PASS=$P(X,"^",2)
 D FILEFIND^MAGDFB(IMAGE,"FULL",0,0,.F1,.F2,.F3)
 D FILEFIND^MAGDFB(IMAGE,"BIG",0,0,.T1,.T2,.T3)
 S:T2'<0 F2=T2
 D FILEFIND^MAGDFB(IMAGE,"TEXT",0,0,.F4,.F5,.F6)
 S N=N+1,OUT(N)=IMAGE_"^"_F2_"^"_USER_"^"_PASS_"^"_F5
 Q
 ;
INFO(OUT,IMAGE) ; RPC = MAG IMAGE CURRENT INFO
 ;
 ; 0008,0018  SOP Instance UID (Create new one, if needed)
 ; 0008,0020  Study Date
 ; 0008,0050  Accession Number
 ; 0008,0060  Modality
 ; 0008,0090  Referring Physician's Name
 ; 0008,1030  Study Description (may be VA procedure name)
 ; 0008,1050  Performing (attending) Physician
 ; 0010,0010  Patient Name
 ; 0010,0020  Patient ID
 ; 0010,0030  Patient's Birth Date
 ; 0010,0040  Patient's Sex
 ; 0010,1000  Other Patient IDs (= ICN, Integration Control Number)
 ; 0010,1040  Address
 ; 0010,2160  Ethnic Group
 ; 0010,2000  Medical Alerts
 ; 0020,000D  Study Instance UID
 ; 0020,000E  Series Instance UID
 ; 0020,000D  Study Instance UID
 ; 0032,1032  Requesting Physician
 ; 0032,1033  Requesting Service
 ; 0032,1060  Requested Procedure Description (CPT name)
 ; 0032,1064  Requested Procedure Code Sequence
 ; 0008,0100  > Code Value (CPT code)
 ; 0008,0102  > Coding Scheme Designator ("C4")
 ; 0008,0104  > Code Meaning (CPT name)
 ; 0038,0300  Current Patient Location (ward)
 ; 0032,1020  Scheduled Study Location
 ;
 N ACN,ATP,CPT,D0,D1,D2,D3,DFN,ERR,I,IT,MO,N,P,PDT,PP,REQP,RFP,RQL,T,TAG,UID,V,WRD,X
 I '$G(IMAGE) S OUT(1)="-1,No Image Specified." Q
 I '$D(^MAG(2005,IMAGE)) S OUT(1)="-2,No Such Image ("_IMAGE_")." Q
 ;
 S X=$G(^MAG(2005,IMAGE,0)),P=$P(X,"^",10)
 S TAG("0008,1030")=$$STYDESC^MAGUE001(IMAGE,.ERR) ; Study Description
 S DFN=$P(X,"^",7) D:DFN
 . N VA,VADM,VAPA,VAERR,DOB,TOB ; return arrays from VADPT
 . N I ; scratch loop array
 . D DEM^VADPT ; populate standard patient data array VADM()
 . S TAG("0010,0010")=$G(VADM(1)) ; Patient Name
 . S TAG("0010,0020")=$S($$ISIHS^MAGSPID():$G(VA("PID")),1:VADM(2)) ; Patient ID (HRN or SSN) - P123
 . S DOB=$G(VADM(3))\1+17000000 ; Patient's Birth Date
 . ; make sure month and year are DICOM valid
 . S TAG("0010,0030")=$S($E(DOB,5,6)="00":"",$E(DOB,7,8)="00":"",1:DOB)
 . ; Patient's Birth Time [probably always blank]
 . S TAG("0010,0032")=$S(VADM(3)[".":$TR($J("."_$P($G(VADM(3)),".",2)*1E6,6)," ",0),1:"")
 . S TAG("0010,2160")=$G(VADM(8)) ; Patient's Race
 . S TAG("0010,0040")=$P($G(VADM(5)),"^",1) ; Patient's Sex
 . S X=$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(DFN),1:"-1^NO MPI")  ;P123
 . S TAG("0010,1000")=$S(X<0:$E(TAG("0010,0010"),1)_$E(TAG("0010,0020"),6,99),1:X) ; Other Patient ID
 . D ADD^VADPT ; populate patient address array
 . F I=1,2,3,4,6 S $P(TAG("0010,1040"),"^",I)=$G(VAPA(I))
 . S $P(TAG("0010,1040"),"^",5)=$P($G(VAPA(5)),"^",2)
 . Q
 ;
 S:P TAG("0008,0018")=$$QRNEWUID^MAGDRPC9(IMAGE)
 ;
 S TAG("0020,000D")=$P($G(^MAG(2005,$S(P:+P,1:IMAGE),"PACS")),"^",1)
 S X=$P($G(^MAG(2005,IMAGE,"SERIESUID")),"^",1)
 S:X'="" TAG("0020,000E")=X
 ;
 ; The following references to ^RADPT are allowed according to IA # 1172
 S X=$G(^MAG(2005,IMAGE,2)),ACN="" D:$P(X,"^",6)=74
 . N P5,P7
 . S P5=$P(X,"^",5),P7=$P(X,"^",7),X=$G(^RARPT(+P7,0))
 . S D0=$P(X,"^",2),D1=9999999.9999=$P(X,"^",3),ACN=$P(X,"^",1)
 . Q
 S IT=0
 I ACN'="" S D0="" F  S D0=$O(^RADPT("ADC",ACN,D0)) Q:D0=""  D
 . S D1="" F  S D1=$O(^RADPT("ADC",ACN,D0,D1)) Q:D1=""  D
 . . N M1,VAIN,VAINDT
 . . S IT=IT+1,TAG("0008,0020",IT)=9999999.9999-D1\1+17000000 ; Study Date
 . . S VAINDT=9999999.9999-D1 D INP^VADPT ; Supported reference
 . . S:$G(VAIN(2))'="" RFP(VAIN(2))="" ; Referring Physician's Name
 . . S:$G(VAIN(4))'="" RFP(VAIN(4))="" ; Current Ward
 . . S:$G(VAIN(11))'="" ATP(VAIN(11))="" ; Performing (attending) Physician
 . . S D2="" F  S D2=$O(^RADPT("ADC",ACN,D0,D1,D2)) Q:D2=""  D
 . . . S X=$G(^RADPT(D0,"DT",D1,"P",D2,0))
 . . . S P=$P(X,"^",2) D:P
 . . . . S M1=0 F  S M1=$O(^RAMIS(71,+P,"MDL",M1)) Q:'M1  D  ; IA # 1174
 . . . . . S V=$P($G(^RAMIS(71,+P,"MDL",M1,0)),"^",1) Q:'V  ; IA # 1174
 . . . . . S V=$P($G(^RAMIS(73.1,+V,0)),"^",1) S:V'="" MO(V)="" ; IA # 1174
 . . . . . Q
 . . . . S V=$P($G(^RAMIS(71,+P,0)),"^",9) S:V CPT(+V)="" ; IA # 1174
 . . . . Q
 . . . S P=$P(X,"^",14) D:P
 . . . . S V=$P($G(^VA(200,+P,0)),"^",1)
 . . . . S:V'="" REQP(V)=""
 . . . . Q
 . . . S P=$P(X,"^",17) D:P
 . . . . S X=$G(^RARPT(+P,0)) Q:X=""  ; IA # 1171
 . . . . S V=$P(X,"^",1) S:V'="" ACN(V)=""
 . . . . Q
 . . . S P=$P(X,"^",22) D:P
 . . . . S X=$G(^SC(+P,0)) Q:X=""  ; IA # 10040
 . . . . S V=$P(X,"^",1) S:V'="" RQL(V)=""
 . . . . Q
 . . . S P=0,D3=0 F  S D3=$O(^RADPT(D0,"P",D1,"DT",D2,"H",D3)) Q:'D3  D
 . . . . S X=$G(^RADPT(D0,"P",D1,"DT",D2,"H",D3,0)) Q:X=""
 . . . . S P=P+1,TAG("0010,2000  "_$J(P,5))=X
 . . . . Q
 . . . Q
 . . Q
 . Q
 S V="" F  S V=$O(ACN(V)) Q:V=""  D
 . S IT=IT+1,TAG("0008,0050",IT)=V ; Accession Number
 . Q
 S V="" F  S V=$O(WRD(V)) Q:V=""  D
 . S IT=IT+1,TAG("0038,0300",IT)=$P(V,"^",2) ; Current Patient Location
 . Q
 S V="" F  S V=$O(RFP(V)) Q:V=""  D
 . S IT=IT+1,TAG("0008,0090",IT)=$P(V,"^",2) ; Referring Physician's Name
 . Q
 S V="" F  S V=$O(ATP(V)) Q:V=""  D
 . S IT=IT+1,TAG("0008,1050",IT)=$P(V,"^",2) ; Performing (attending) Physician
 . Q
 S V="" F  S V=$O(RQL(V)) Q:V=""  D
 . S IT=IT+1,TAG("0032,1033",IT)=V ; Requesting Service
 . Q
 S V="" F  S V=$O(MO(V)) Q:V=""  D
 . S IT=IT+1,TAG("0008,0060",IT)=V ; Modality
 . Q
 S V="" F  S V=$O(REQP(V)) Q:V=""  D
 . S IT=IT+1,TAG("0032,1032",IT)=V ; Requesting Physician
 . Q
 S V="" F  S V=$O(CPT(V)) Q:V=""  D
 . S X=$$CPT^ICPTCOD(V) ; IA # 1995, supported reference
 . Q:$P(X,"^",2)=""
 . S IT=IT+1
 . S TAG("0032,1064 0008,0100",IT)=$P(X,"^",2) ; CPT Code
 . S TAG("0032,1064 0008,0104",IT)=$P(X,"^",3) ; Code Meaning
 . S TAG("0032,1060",IT)=$P(X,"^",3) ; Requested Procedure Description
 . S TAG("0032,1064 0008,0102",IT)="C4" ; Coding Scheme Designator
 . Q
 ;
 S V=$P($G(^MAG(2005,IMAGE,100)),"^",3) D:V=""
 . ; Find Acquisition site when not filled in in Image File
 . N D0,LOC,N
 . S (N,D0,LOC)=0 F  S D0=$O(^MAG(2006.1,D0)) Q:'D0  D
 . . S N=N+1,LOC=$P($G(^MAG(2006.1,D0,0)),"^",1)
 . . Q
 . Q:N>2  ; Too many to choose from...
 . S:LOC V=LOC
 . Q
 S:V'="" TAG("0032,1020")=V ; Acquisition Site
 ;
 ; return names in DICOM format
 S:$G(TAG("0010,0010"))'="" TAG("0010,0010")=$$VA2DCM^MAGDQR01(TAG("0010,0010"))
 F I="0008,0090","0008,1050","0032,1032" D
 . N J S J=""
 . F  S J=$O(TAG(I,J)) Q:'J  D
 . . S:$G(TAG(I,J))'="" TAG(I,J)=$$VA2DCM^MAGDQR01(TAG(I,J))
 . . Q
 . Q
 ;
 S N=1,T="" F  S T=$O(TAG(T)) Q:T=""  D
 . S V=""
 . S:$D(TAG(T))#2 V=TAG(T)
 . S I="" F  S I=$O(TAG(T,I)) Q:I=""  S:V'="" V=V_"\" S V=V_TAG(T,I)
 . S:V'="" N=N+1,OUT(N)=T_"^"_V
 . Q
 ;
 S OUT(1)=(N-1)_" data fields returned."
 Q
 ;
CLEAN(OUT) ; RPC = MAG DICOM QUERY CLEANUP
 N D0,H,N,STAMP
 L +^MAGDQR(2006.5732,0):1E6 ; Background task MUST wait
 S D0=0 F  S D0=$O(^MAGDQR(2006.5732,D0)) Q:'D0  D
 . S X=$G(^MAGDQR(2006.5732,D0,0)),STAMP=$P(X,"^",3)
 . Q:$$FMDIFF^XLFDT(DT,STAMP,1)<5
 . K ^MAGDQR(2006.5732,D0)
 . K ^MAGDQR(2006.5732,"B",D0)
 . Q
 S (D0,N,H)=0 F  S D0=$O(^MAGDQR(2006.5732,D0)) Q:'D0  S N=N+1,H=D0
 S X="DICOM QUERY RETRIEVE RESULT^2006.5732^"_H_"^"_N
 S ^MAGDQR(2006.5732,0)=X
 L -^MAGDQR(2006.5732,0)
 Q
 ;
