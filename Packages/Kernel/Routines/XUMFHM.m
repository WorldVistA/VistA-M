XUMFHM ;ISS/RAM - MFS HANDLER ERROR MESSAGE ;11/16/05
 ;;8.0;KERNEL;**416**;Jul 10, 1995;Build 5
 ;
 ;
EM(ERROR,ERR) ; -- error message
 ;
 N X,I,Y,XMTEXT,FLG
 ;
 S FLG=0
 ;
 D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 ;S X(.02)="",X(.03)=$G(ERROR),X(.04)=""
 ;
 S X=.9 F  S X=$O(X(X)) Q:'X  D
 .I X(X)="" K X(X) Q
 .I X(X)["DINUMed field cannot" S FLG=1 K X(X) Q
 .I X(X)["ASSOCIATION" S FLG=1 K X(X) Q
 .I X(X)["INSTITUTION" S FLG=1 K X(X) Q
 .I X(X)["The entry does not exist." S FLG=1 K X(X) Q
 .I X(X)["already exists." S FLG=1 K X(X) Q
 ;
 I FLG Q:'$O(X(.9))
 ;
 S ERRCNT=ERRCNT+1
 ;
 S ^TMP("XUMF ERROR",$J,ERRCNT_".01")=""
 S ^TMP("XUMF ERROR",$J,ERRCNT_".02")=""
 S ^TMP("XUMF ERROR",$J,ERRCNT_".03")=$G(ERROR)
 S ^TMP("XUMF ERROR",$J,ERRCNT_".04")=""
 S ^TMP("XUMF ERROR",$J,ERRCNT_".05")="KEY: "_$G(KEY)_"   IFN: "_$G(IFN)_"   IEN: "_$G(IEN)
 S ^TMP("XUMF ERROR",$J,ERRCNT_".06")=""
 S X=.9 F  S X=$O(X(X)) Q:'X  D
 .S ^TMP("XUMF ERROR",$J,ERRCNT_"."_X)=X(X)
 ;
 Q
 ;
EM1 ;
 ;
 N XMY,XMSUB
 ;
 S ^TMP("XUMF ERROR",$J,.1)="HL7 message ID: "_$G(HL("MID"))
 S XMY("G.XUMF ERROR")="",XMSUB="MFS ERROR"
 S XMTEXT="^TMP(""XUMF ERROR"",$J,"
 ;
 D ^XMD
 ;
 Q
 ;
