PSBRPCXM ;BIRMINGHAM/EFC-VISTA MAILMAN INTERFACE ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;;Mar 2004
 ;
RPC(RESULTS,PSBCMD,PSBDATA) ; Main RPC point
 S RESULTS=$NA(^TMP("PSBMSG",$J)),^TMP("PSBMSG",$J,0)="-1^Unknown Error"
 I PSBCMD="CREATE" K ^TMP("PSBMAIL",$J) S ^TMP($J,0)="1^Message '"_$J_"' created."
 D:PSBCMD="APPEND"
 .I $G(PSBDATA)]"" S Y=$O(^TMP("PSBMAIL",$J,"TEXT",""),-1)+1,^TMP("PSBMAIL",$J,"TEXT",Y,0)=PSBDATA
 .S X="PSBDATA"
 .F  S X=$Q(@X) Q:X=""  S Y=$O(^TMP("PSBMAIL",$J,"TEXT",""),-1)+1,^TMP("PSBMAIL",$J,"TEXT",Y,0)=@X
 .S Y=+$O(^TMP("PSBMAIL",$J,"TEXT",""),-1)
 .S ^TMP("PSBMAIL",$J,"TEXT",0)="^^"_Y
 .S ^TMP($J,0)="1^Text appended."
 I PSBCMD="SUBJECT" S ^TMP("PSBMAIL",$J,"SUBJECT")=PSBDATA,^TMP($J,0)="1^Message subject set to '"_PSBDATA_"'"
 D:PSBCMD="SENDTO"
 .I $G(PSBDATA)]"" S Y=$O(^TMP("PSBMAIL",$J,"SENDTO",""),-1)+1,^TMP("PSBMAIL",$J,"SENDTO",Y)=PSBDATA
 .S X="PSBDATA"
 .F  S X=$Q(@X) Q:X=""  S Y=$O(^TMP("PSBMAIL",$J,"SENDTO",""),-1)+1,^TMP("PSBMAIL",$J,"SENDTO",Y)=@X
 .S ^TMP($J,0)="1^Recipients Added."
 D:PSBCMD="EXECUTE"
 .S XMSUB=$G(^TMP("PSBMAIL",$J,"SUBJECT"),"No subject")
 .S XMTEXT="^TMP(""PSBMAIL"",$J,""TEXT"","
 .F X=0:0 S X=$O(^TMP("PSBMAIL",$J,"SENDTO",X)) Q:'X  S XMY(^(X))=""
 .D ^XMD
 .S ^TMP($J,0)="1^Message Sent.  ID: "_+$G(XMZ)
 Q
 ;
