MAGVCHK ;WOIFO/EdM - Checksums of Imaging Routines ; 01/08/2007 10:39
 ;;3.0;IMAGING;**51,54**;03-July-2009;;Build 1424
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
 ; The entry below is called from ET-Phone-Home
 ;
GATEWAY(ZTSK,MAGDBB) ; RPC = MAG VISTA CHECKSUMS
 N D0,X,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 S ZTSK=0,D0=$O(^MAG(2006.1,0)) Q:'D0
 Q:$G(MAGDBB)'["@"  ; Must be valid e-mail address
 L +^MAG(2006.1,"CHECKSUM"):10 Q:'$T  ; Don't hold up other processing...
 D:$G(^MAG(2006.1,D0,"LAST CHECKSUM"))<DT
 . ;
 . S ZTRTN="CHECK^"_$T(+0)
 . S ZTDESC="Imaging Checksum Collection"
 . S ZTDTH=$H ; Now!
 . S ZTSAVE("MAGDBB")=MAGDBB
 . D ^%ZTLOAD,HOME^%ZIS
 . I '$D(ZTSK) S ZTSK=0 Q  ; TaskMan did not Accept Request
 . ; No matter how many sub-sites in the consolidated site,
 . ; run this program only once per day:
 . S D0=0 F  S D0=$O(^MAG(2006.1,D0)) Q:'D0  S ^MAG(2006.1,D0,"LAST CHECKSUM")=DT
 . Q
 L -^MAG(2006.1,"CHECKSUM")
 Q
 ;
CHECK ; Collect checksums for Imaging Routines
 N CUR,I,MAGFM,R,SITE,X,XMERR,XMID,XMSUB,XMY,XMZ
 Q:$G(MAGDBB)'["@"  ; Must be valid e-mail address
 D DT^DICRW
 D
 . N D1,D2,DATE,I,MAGDATA,MSG,N,PKG,PKT,PV
 . S CUR=$$VERSION^XPDUTL("IMAGING")
 . D LIST^DIC(9.7,,".01;2I;51I","K","*","MAG","MAG*","B",,,"MAGDATA","MSG")
 . S I="" F  S I=$O(MAGDATA("DILIST",2,I)) Q:I=""  D
 . . S I(+$G(MAGDATA("DILIST","ID",I,2)),I)=""
 . . S X=$G(MAGDATA("DILIST","ID",I,.01)) Q:X=""
 . . S D1=$G(MAGDATA("DILIST","ID",I,51)) Q:D1=""
 . . S D2=$G(MAGDATA("DILIST","ID",I,2))
 . . S CUR(X)=D1_"^"_D2
 . . Q
 . S N=0,DATE="" F  S DATE=$O(I(DATE)) Q:DATE=""  D
 . . S I="" F  S I=$O(I(DATE,I)) Q:I=""  D
 . . . S X=$G(MAGDATA("DILIST","ID",I,.01)) Q:$P(X,"*",2)'=CUR
 . . . S PATCH=+$P(X,"*",3) Q:'PATCH
 . . . K:$G(N(1,PATCH)) N(2,N(1,PATCH))
 . . . S N=N+1,N(1,PATCH)=N,N(2,N)=PATCH
 . . . S N(3,N)=$G(MAGDATA("DILIST","ID",I,51))
 . . . Q
 . . Q
 . S CUR=CUR_";IMAGING;",I="**",X=""
 . S N="" F  S N=$O(N(2,N)) Q:N=""  S CUR=CUR_I_N(2,N),X=N(3,N),I=","
 . S:I'="**" CUR=CUR_"**"
 . S:X'="" CUR=CUR_";"_$$FMDATE(X)
 . Q
 S SITE=0 S:$T(INST^XUPARAM)'="" SITE=$$KSP^XUPARAM("INST")
 D:SITE FIND^DIC(4,"",.01,"A",SITE,"*",,,,"MAGFM")
 S SITE=$G(MAGFM("DILIST",1,1)) S:SITE'="" SITE=SITE_" "
 S SITE=SITE_"VistA System"
 K ^TMP("MAG",$J,"CHECKSUM"),MAGFM
 S I=0
 K X D DOMAIN^MAGDRPC1(.X)
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="SID="_X
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="DT="_DT
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="IP=VistA"
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="BLD="_CUR
 S CUR="" F  S CUR=$O(CUR(CUR)) Q:CUR=""  D
 . S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="PAT="_CUR_"^"_CUR(CUR)
 . Q
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="TTL="_SITE
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="PHY=VistA"
 S R="MAG" F  S R=$O(^$R(R)) Q:$E(R,1,3)'="MAG"  D
 . S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="RTN="_R
 . S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)="CHK="_$$CHK1(R)_"^"_$$CHK2(R)
 . Q
 S I=I+1,^TMP("MAG",$J,"CHECKSUM",I)=""
 S XMSUB="Daily Report"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY(MAGDBB)=""
 D SENDMSG^XMXAPI(XMID,XMSUB,$NAME(^TMP("MAG",$J,"CHECKSUM")),.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 K ^TMP("MAG",$J,"CHECKSUM")
 Q
 ;
CHK1(R) N K,X,Y
 S Y=0
 F K=1:1 S X=$T(+K^@R) Q:X=""  S:K'=2 Y=Y+$$C1(X)
 Q Y
 ;
C1(X) N F,I,Y
 S Y=0
 S F=$F(X," "),F=$S($E(X,F)'=";":$L(X),$E(X,F+1)=";":$L(X),1:F-2)
 F I=1:1:F S Y=$A(X,I)*I+Y
 Q Y
 ;
CHK2(R) N K,X,Y
 S Y=0
 F K=1:1 S X=$T(+K^@R) Q:X=""  S:K'=2 Y=Y+$$C2(X,K)
 Q Y
 ;
C2(X,K) N F,I,Y
 S Y=0
 S F=$F(X," "),F=$S($E(X,F)'=";":$L(X),$E(X,F+1)=";":$L(X),1:F-2)
 F I=1:1:F S Y=$A(X,I)*(I+K)+Y
 Q Y
 ;
FMDATE(X) N D,M,Y
 S X=X\1,D=X#100,M=X\100#100,Y=X\10000+1700
 Q D_"-"_$P("January February March April May June July August September October November December"," ",M)_"-"_Y
 ;
