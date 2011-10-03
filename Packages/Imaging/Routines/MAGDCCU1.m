MAGDCCU1 ;WOIFO/EdM - Failed Images Maintenance ; 01/03/2007 10:54
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
REMOFAIL ; Remove all entries for a specific retired DICOM Gateway
 N ACT,D0,LO,M,N,OLD,P1,P2,P3,UP,X,X0,X1
 S OLD=$$GETGW(1,1) Q:OLD=""
 Q:'$$WARN(OLD)
 S (D0,N)=0 F  S D0=$O(^MAGD(2006.575,D0)) Q:'D0  D
 . S X1=$G(^MAGD(2006.575,D0,1)),ACT=$P(X1,"^",4) Q:$TR(ACT,LO,UP)'=OLD
 . S N=N+1
 . S X0=$G(^MAGD(2006.575,D0,0))
 . S P1=$P(X0,"^",1) K:P1'="" ^MAGD(2006.575,"B",P1,D0)
 . S P1=$P(X1,"^",3) K:P1'="" ^MAGD(2006.575,"AD",P1,D0)
 . S P1=$P(X1,"^",5) K:P1'="" ^MAGD(2006.575,"AFX",P1,ACT,D0)
 . S P2=$P($G(^MAGD(2006.575,D0,"ASUID")),"^",1)
 . I P1'="",P2'="" K ^MAGD(2006.575,"F",P1,P2,D0)
 . S P1=$P(X0,"^",3) K:P1'="" ^MAGD(2006.575,"D",P1,D0)
 . K ^MAGD(2006.575,D0)
 . Q
 L +^MAGD(2006.575,0):1E9
 S X=$G(^MAGD(2006.575,0))
 S $P(X,"^",1,2)="DICOM FAILED IMAGES^2006.575"
 S M=$P(X,"^",4)-N S:M<1 M=0
 S $P(X,"^",4)=M
 S ^MAGD(2006.575,0)=X
 L -^MAGD(2006.575,0)
 W !!,N," Entr",$S(N=1:"y",1:"ies")," removed.",!
 Q
 ;
REMOXMIT ; Remove all entries for a specific retired DICOM Gateway
 N ACT,D0,LO,M,N,OLD,P1,P2,P3,UP,X,X0,X1
 S OLD=$$GETGW(1,2) Q:OLD=""
 Q:'$$WARN(OLD)
 S (D0,N)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X0=$G(^MAG(2006.587,D0,0)),ACT=$P(X0,"^",5) Q:$TR(ACT,LO,UP)'=OLD
 . S N=N+1
 . S P1=$P(X0,"^",1),P2=$P(X0,"^",7)
 . K:P1'="" ^MAG(2006.587,"B",P1,D0)
 . I P1'="",P2'="" K ^MAG(2006.587,"C",P1,P2,ACT,D0)
 . I P2'="" K ^MAG(2006.587,"D",ACT,P2,D0)
 . K ^MAG(2006.587,D0)
 . Q
 L +^MAG(2006.587,0):1E9
 S X=$G(^MAG(2006.587,0))
 S $P(X,"^",1,2)="DICOM TRANSMIT DESTINATION^2006.587"
 S M=$P(X,"^",4)-N S:M<1 M=0
 S $P(X,"^",4)=M
 S ^MAG(2006.587,0)=X
 L -^MAG(2006.587,0)
 W !!,N," Entr",$S(N=1:"y",1:"ies")," removed.",!
 Q
 ;
RENAFAIL ; Rename all entries for a specific replaced DICOM Gateway
 N ACT,D0,LO,N,NEW,OLD,P1,P2,P3,UP,X,X0,X1
 S OLD=$$GETGW(1,1) Q:OLD=""
 S NEW=$$GETGW(0,1) Q:NEW=""
 I OLD=NEW D  Q
 . W !,"Old and new names should be different..."
 . Q
 S (D0,N)=0 F  S D0=$O(^MAGD(2006.575,D0)) Q:'D0  D
 . S X1=$G(^MAGD(2006.575,D0,1)),ACT=$P(X1,"^",4) Q:$TR(ACT,LO,UP)'=OLD
 . S N=N+1
 . S P1=$P(X1,"^",5) D:P1'=""
 . . S:$D(^MAGD(2006.575,"AFX",P1,ACT,D0)) ^MAGD(2006.575,"AFX",P1,NEW,D0)=""
 . . K ^MAGD(2006.575,"AFX",P1,ACT,D0)
 . . Q
 . S $P(^MAGD(2006.575,D0,1),"^",4)=NEW
 . Q
 W !!,N," Entr",$S(N=1:"y",1:"ies")," renamed.",!
 Q
 ;
RENAXMIT ; Rename all entries for a specific replaced DICOM Gateway
 N ACT,D0,LO,N,NEW,OLD,P1,P2,P3,UP,X,X0,X1
 S OLD=$$GETGW(1,2) Q:OLD=""
 S NEW=$$GETGW(0,2) Q:NEW=""
 I OLD=NEW D  Q
 . W !,"Old and new names should be different..."
 . Q
 S (D0,N)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X0=$G(^MAG(2006.587,D0,0)),ACT=$P(X0,"^",5) Q:$TR(ACT,LO,UP)'=OLD
 . S N=N+1
 . S P1=$P(X0,"^",1),P2=$P(X0,"^",7)
 . I P1'="",P2'="" K ^MAG(2006.587,"C",P1,P2,ACT,D0)
 . I P2'="" K ^MAG(2006.587,"D",ACT,P2,D0)
 . I P1'="",P2'="" S ^MAG(2006.587,"C",P1,P2,NEW,D0)=""
 . I P2'="" S ^MAG(2006.587,"D",NEW,P2,D0)=""
 . S $P(^MAG(2006.587,D0,0),"^",5)=NEW
 . Q
 W !!,N," Entr",$S(N=1:"y",1:"ies")," renamed.",!
 Q
 ;
GETGW(EXIST,WHERE) ; Get the name of a DICOM Gateway
 N OK,TBL,TYPE,X
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S LO="abcdefghijklmnopqrstuvwxyz"
 S WHERE=+$G(WHERE),TBL=$S(WHERE=1:"Host Name",WHERE=2:"System Title",1:"?")
 Q:TBL="?"
 S TYPE=$S($G(EXIST):"current",1:"new")
 S OK=0 F  D  Q:OK
 . W !,"Enter the ",TYPE," ",TBL," of the DICOM Gateway: "
 . R X:$G(DTIME,300) E  S X="^"
 . S X=$TR(X,LO,UP)
 . I X["^" S X="",OK=1
 . I X'["?",X'="" S OK=1 Q
 . W !,"Enter the appropriate name for the DICOM Gateway."
 . W !,"The ""Host Name"" is the name of the computer that is assigned"
 . W !,"by the site's IRM and that follows official naming rules."
 . W !,"The ""System Title"" is the name that is assigned by the staff"
 . W !,"who operates the DICOM Gateway."
 . W !
 . Q
 Q X
 ;
WARN(NAME) N X
 W !!,"WARNING: this operation will irrevocably remove all entries"
 W !,"for the DICOM Gateway named """,NAME,"""."
 W !!,"Are you certain you wish to remove these entries? No//"
 R X:$G(DTIME,300) E  Q 0
 Q "Yy"[$E(X_"N",1)
 ;
