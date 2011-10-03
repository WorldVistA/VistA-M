MAGBRTE3 ;WOIFO/EdM - Find value of variable ; 08/26/2005  07:46
 ;;3.0;IMAGING;**11,51**;26-August-2005
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
 ; The subroutines in this routine calculate the values for
 ; certain variables that may be needed for the "routing rule processor"
 ;
 ; Entry DICOM is the generic value finder that looks for values
 ; in the data structure that describes an image file.
 ; The other entries deal with other (computed) values.
 ;
 ; The value is always returned in output parameter VAL.
 ; Note that this variable needs to be an output parameter,
 ; because in some cases an "undefined value" needs to be returned,
 ; and in some cases, multiple values may need to be returned.
 ;
DICOM(NAME,TYPE,VAL) N C,I,N,X
 ;
 ; Arbitrary decision: the routine stops when the first occurrence
 ; of a value is found.
 ; Should we continue until we find all codes that have values?
 ;
 S C="" F  S C=$O(KEYWORD("CONDITION",NAME,C)) Q:C=""  D  Q:$D(VAL)
 . Q:'$D(^TMP("MAG",$J,"DICOM",TYPE,C))
 . S (I,N)=0 F  S N=$O(^TMP("MAG",$J,"DICOM",TYPE,C,N)) Q:N=""  D
 . . S X=$G(^TMP("MAG",$J,"DICOM",TYPE,C,N,1),"<unknown>") Q:X="<unknown>"
 . . S I=I+1,N(I)=X
 . . Q
 . Q:'I
 . I I=1 S VAL=N(1) Q
 . F N=1:1:I S VAL(N)=N(N)
 . Q
 Q
 ;
NOW(VAL) N %,DISYS,X
 D DT^DICRW
 S VAL=$P("THU FRI SAT SUN MON TUE WED"," ",$H#7+1)_" "_%
 Q
 ;
SOURCE(IMAGE,VAL) N X
 S X=$P($G(^MAG(2005,IMAGE,100)),"^",3)
 S:'X X=$G(DUZ(2))
 S:'X X=$$KSP^XUPARAM("INST")
 S VAL=$$GET1^DIQ(4,+X,.01)
 Q
 ;
MAG(IMAGE,TYPE,NODE,PIECE,VAL) N D0,D1,PARENT,X
 ; First look in the image itself,
 ; then in its parent (if any)
 ; then in any siblings.
 ; Return the first value found.
 ;
 K VAL
 S X=$P($G(^MAG(2005,IMAGE,NODE)),"^",PIECE) I X'="" S VAL=X D:$D(VAL) MAGX Q
 ;
 S PARENT=$P($G(^MAG(2005,IMAGE,0)),"^",10) Q:PARENT=""
 S X=$P($G(^MAG(2005,PARENT,NODE)),"^",PIECE) I X'="" S VAL=X D:$D(VAL) MAGX Q
 ;
 S D1=0 F  S D1=$O(^MAG(2005,IMAGE,1,D1)) Q:'D1  D  Q:$D(VAL)
 . S D0=$G(^MAG(2005,IMAGE,1,D1,1)) Q:'D0
 . S X=$P($G(^MAG(2005,D0,NODE)),"^",PIECE) I X'="" S VAL=X Q
 . Q
 D:$D(VAL) MAGX
 Q
 ;
MAGX I TYPE=0 Q
 I (TYPE=2005.02)!(TYPE=2005.03)!(TYPE=2005.81)!(TYPE=2005.2) D  Q
 . S X=$P($G(^MAG(TYPE,+VAL,0)),"^",1) K VAL S:X'="" VAL=X
 . Q
 I TYPE=2 D  Q
 . S X=$P($G(^DPT(+VAL,0)),"^",1) K VAL S:X'="" VAL=X ; IA 10035
 . Q
 I TYPE=200 D  Q
 . S X=$$GET1^DIQ(200,+VAL,.01) K VAL S:X'="" VAL=X ; IA 10060
 . Q
 I TYPE=44 D  Q
 . S X=$P($G(^SC(+VAL,0)),"^",1) K VAL S:X'="" VAL=X ; IA 10040
 . Q
 I TYPE=71 D  Q
 . S X=$P($G(^RAMIS(71,+VAL,0)),"^",1) K VAL S:X'="" VAL=X ; IA 1174
 . Q
 I TYPE=74 D  Q
 . S X=$P($G(^RARPT(+VAL,0)),"^",1) K VAL S:X'="" VAL=X ; IA 1171
 . Q
 Q
 ;
DATE(IMAGE,TYPE,NODE,PIECE,WHEN,VAL) N D0,D1,FIRST,LAST,PARENT,X
 ; First look in the image itself,
 ; then in its parent (if any)
 ; then in any siblings.
 ; Return the first value found.
 ;
 K VAL
 I WHEN=0 D MAG(IMAGE,TYPE,NODE,PIECE,.VAL) Q
 ;
 S X=$P($G(^MAG(2005,IMAGE,NODE)),"^",PIECE) I X'="" S X(X)=""
 ;
 S PARENT=$P($G(^MAG(2005,IMAGE,0)),"^",10) Q:PARENT=""
 S X=$P($G(^MAG(2005,PARENT,NODE)),"^",PIECE) I X'="" S X(X)=""
 ;
 S D1=0 F  S D1=$O(^MAG(2005,IMAGE,1,D1)) Q:'D1  D
 . S D0=$G(^MAG(2005,IMAGE,1,D1,1)) Q:'D0
 . S X=$P($G(^MAG(2005,D0,NODE)),"^",PIECE) I X'="" S X(X)=""
 . Q
 ;
 I WHEN=1 S VAL=$O(X(""),+1)
 I WHEN=2 S VAL=$O(X(""),-1)
 K:VAL="" VAL
 Q
 ;
URGENCY(IMAGE,VAL) N P
 S P=$$PRI^MAGBRTE4("NORMAL",IMAGE)
 S VAL=$S(P=500:"ROUTINE",P=510:"URGENT",P=520:"STAT",1:P)
 Q
 ;
