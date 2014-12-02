MAGDQRUE ;WOIFO/MLH - Imaging RPCs for Query/Retrieve - error utilities ; 30 Dec 2011 2:17 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
ERR(X) S ^TMP("MAG",$J,"ERR",$O(^TMP("MAG",$J,"ERR"," "),-1)+1)=X
 Q
 ;
ERRLOG N I,O,X
 S O=1,I=""
 F  S I=$O(^TMP("MAG",$J,"ERR",I)) Q:I=""  S X=$G(^(I)) D
 . S O=O+1,OUT(O)=X
 . Q
 D LOG^MAGDQRUL("Error","",(-O)_",Errors encountered")
 Q
 ;
ERRSAV N I,O,RESGBL,X
 Q:'$G(RESULT)  S RESGBL=$NA(^MAGDQR(2006.5732,RESULT))
 S $P(@RESGBL@(0),"^",2,3)="OK^"_$$NOW^XLFDT()
 K @RESGBL@(1)
 S O=0,I=""
 F  S I=$O(^TMP("MAG",$J,"ERR",I)) Q:I=""  S X=$G(^(I)) D
 . S O=O+1,@RESGBL@(1,O,0)="0000,0902^"_X
 . Q
 Q
