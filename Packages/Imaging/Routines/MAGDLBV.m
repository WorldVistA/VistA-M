MAGDLBV ;WOIFO/EdM - Validate Table with failed DICOM entries ; 12/16/2004  06:59
 ;;3.0;IMAGING;**51**;26-August-2005
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
MENU ; This entry is called from the VistA menu
 W !!,"Starting Validation of data in DICOM Failed Images Table.",!
 D VALIDATE(.OUT,1)
 W !!,OUT," entr",$S(OUT=1:"y",1:"ies")," currently in database.",!
 Q
 ;
VALIDATE(OUT,MENU) ; RPC = MAG DICOM CORRECT VALIDATE
 N D0,D1,FIXED,L0,L1,LOC,N0,N1,TP,V,X
 L +^MAGD(2006.575):1E9
 S MENU=+$G(MENU)
 F X="AD","AFX","B","D","F" K ^MAGD(2006.575,X)
 S (L0,N0)=0
 S D0=0 F  S D0=$O(^MAGD(2006.575,D0)) Q:'D0  D
 . S X=$G(^MAGD(2006.575,D0,0)) I X="" K ^MAGD(2006.575,D0) Q
 . S L0=D0,N0=N0+1,(L1,N1)=0
 . S FIXED=+$G(^MAGD(2006.575,D0,"FIXD"))
 . S TYPE=$P($G(^MAGD(2006.575,D0,"TYPE")),"^",1)
 . S V=$P(X,"^",1) S:V'="" ^MAGD(2006.575,"B",V,D0)=""
 . S V=$P(X,"^",3) I V'="",'FIXED,TYPE="CON" S ^MAGD(2006.575,"D",V,D0)=""
 . S X=$G(^MAGD(2006.575,D0,1)),LOC=$P(X,"^",5)
 . S V=$P(X,"^",3) I V'="",'FIXED,TYPE="CON" S ^MAGD(2006.575,"AD",V,D0)=""
 . S FIXED=+$G(^MAGD(2006.575,D0,"FIXD"))
 . S V=$P(X,"^",4) I FIXED,LOC'="",V'="" S ^MAGD(2006.575,"AFX",LOC,V,D0)=""
 . S V=$P($G(^MAGD(2006.575,D0,"ASUID")),"^",1)
 . I LOC'="",V'="" S ^MAGD(2006.575,"F",LOC,V,D0)=""
 . S D1=0 F  S D1=$O(^MAGD(2006.575,D0,"RLATE",D1)) Q:'D1  D
 . . S X=+$G(^MAGD(2006.575,D0,"RLATE",D1,0))
 . . I 'X D  Q
 . . . W:MENU !,"Invalid pointer to related entry: """_X_"""."
 . . . K ^MAGD(2006.575,D0,"RLATE",D1)
 . . . Q
 . . I '$D(^MAGD(2006.575,X)) D  Q
 . . . W:MENU !,"Pointer to non-existent related entry: """_X_"""."
 . . . K ^MAGD(2006.575,D0,"RLATE",D1)
 . . . K ^MAGD(2006.575,D0,"RLATE","B",X,D1)
 . . . Q
 . . S L1=D1,N1=N1+1
 . . Q
 . I 'N1 K ^MAGD(2006.575,D0,"RLATE") Q
 . S ^MAGD(2006.575,D0,"RLATE",0)="^2006.57526PA^"_L1_"^"_N1
 . ;
 . S X="" F  S X=$O(^MAGD(2006.575,D0,"RLATE","B",X)) Q:X=""  D
 . . I '$D(^MAGD(2006.575,X)) D  Q
 . . . W:MENU !,"Cross-reference for non-existent related entry: """_X_"""."
 . . . K ^MAGD(2006.575,D0,"RLATE","B",X)
 . . . Q
 . . S D1="" F  S D1=$O(^MAGD(2006.575,D0,"RLATE","B",X,D1)) Q:D1=""  D
 . . . I '$D(^MAGD(2006.575,D0,"RLATE",D1)) D  Q
 . . . . W:MENU !,"Cross-reference for invalid related entry: """_D1_"""."
 . . . . K ^MAGD(2006.575,D0,"RLATE","B",X,D1)
 . . . . Q
 . . Q
 . Q
 S LOC="" F  S LOC=$O(^MAGD(2006.575,"F",LOC)) Q:LOC=""  D
 . S V="" F  S V=$O(^MAGD(2006.575,"F",LOC,V)) Q:V=""  D
 . . N I,N,R
 . . S N=0,D0="" F  S D0=$O(^MAGD(2006.575,"F",LOC,V,D0)) Q:D0=""  D
 . . . S N=N+1,N(''$D(^MAGD(2006.575,D0,"RLATE")),D0)=""
 . . . Q
 . . Q:N<2
 . . I '$O(N(1,"")) S R=$O(N(0,"")) K N(0,R) S N(1,R)=""
 . . S D0=$O(N(1,"")),(L1,N1)=0
 . . S D1=0 F  S D1=$O(^MAGD(2006.575,D0,"RLATE",D1)) Q:'D1  S L1=D1,N1=N1+1
 . . F I=0,1 S N="" F  S N=$O(N(I,N)) Q:N=""  D:D0'=N
 . . . K ^MAGD(2006.575,"F",LOC,V,N)
 . . . Q:$D(^MAGD(2006.575,D0,"RLATE","B",N))
 . . . S L1=L1+1,N1=N1+1
 . . . S ^MAGD(2006.575,D0,"RLATE",L1,0)=N
 . . . S ^MAGD(2006.575,D0,"RLATE","B",N,L1)=""
 . . . Q
 . . S ^MAGD(2006.575,D0,"RLATE",0)="^2006.57526PA^"_L1_"^"_N1
 . . Q
 . Q
 S ^MAGD(2006.575,0)="DICOM FAILED IMAGES^2006.575^"_L0_"^"_N0
 L -^MAGD(2006.575)
 S OUT=N0
 Q
 ;
