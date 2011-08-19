GMRCSLM4 ;SLC/DCM - List Manager routine - Activity Log Detailed Display ;1/28/99 10:30
 ;;3.0;CONSULT/REQUEST TRACKING;**4,12,15,22,50,64**;DEC 27,1997;Build 20
 ;
 ; This routine invokes IA #3138
 ;
ACTLOG(GMRCO) ;Print activity log
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Facility",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=" Activity"_$E(TAB,1,16)_"Date/Time/Zone"_$E(TAB,1,6)_"Responsible Person"_$E(TAB,1,2)_"Entered By",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$$REPEAT^XLFSTR("-",79),GMRCCT=GMRCCT+1
 N GMRCD,GMRCDA
 S GMRCD=0 F  S GMRCD=$O(^GMR(123,+GMRCO,40,"B",GMRCD)) Q:'GMRCD  S GMRCDA="" F  S GMRCDA=$O(^GMR(123,+GMRCO,40,"B",GMRCD,GMRCDA)) Q:'GMRCDA  D BLDALN(GMRCO,GMRCDA)
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Note: TIME ZONE is local if not indicated",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
 ;
BLDALN(GMRCO,GMRCDA) ;Build Activity Log Lines for an activity
 ; GMRCO=  consult internal entry number
 ; GMRCDA= activity internal entry number
 N GMRCACT,GMRCSLN,XDT1,XDT2,FLG,LN,LINE,DASH,X,GMRCX,GMRCDEV,GMRCISIT,GMRC3LN
 S GMRCDA(0)=^GMR(123,+GMRCO,40,GMRCDA,0)
 S GMRCACT=$P(GMRCDA(0),"^",2)
 S GMRCDA(2)=$G(^GMR(123,+GMRCO,40,GMRCDA,2))
 S GMRCDA(3)=$G(^GMR(123,+GMRCO,40,GMRCDA,3))
 I $D(^GMR(123,GMRCO,40,GMRCDA,2)) D
 . S GMRCISIT=$P(^GMR(123,GMRCO,0),U,23) Q:'GMRCISIT
 . S GMRCISIT=$$GET1^DIQ(4,GMRCISIT,.01)
 D BLDLN1
 D BLDLN2
 D BLDCMTS
 Q
 ;
BLDLN1 ;Build the first line for the activity
 ;GMRCX is scratch pad variable
 I $L($G(GMRCISIT)) D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCISIT
 . S GMRCCT=GMRCCT+1
 S GMRCX=$P($G(^GMR(123.1,+GMRCACT,0)),"^",1)
 S:'$L(GMRCX) GMRCX=GMRCACT_" action?"
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=" "_GMRCX
 ;
 ;Add to line for Printed to (action 22) when device name <13 characters
 I GMRCACT=22 D
 . S GMRCDEV=$$GET1^DIQ(3.5,+$P(GMRCDA(0),"^",8),.01)
 . I '$L(GMRCDEV) S GMRCDEV=$P(GMRCDA(0),"^",8)
 . I $L(GMRCDEV)<13 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_" "_GMRCDEV K GMRCDEV
 ;
 ;Add on generic fields that apply to every activity
 ;Date/time of Actual Activity, Who's Responsible for Activity,
 ;and Who entered activity
 S X=$P(GMRCDA(0),"^",3) D REGDTM^GMRCU S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$S($D(^TMP("GMRCR",$J,"DT",GMRCCT,0)):^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,25-$L(^(0)))_X,1:X)_$E(TAB)_$S($P(GMRCDA(2),"^",3)]"":$P(GMRCDA(2),"^",3),1:$E(TAB,1,3))
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,45-$L(^(0)))_$S($P(GMRCDA(2),"^",2)]"":$E($P(GMRCDA(2),"^",2),1,17),$P(GMRCDA(0),"^",4):$E($P($G(^VA(200,$P(GMRCDA(0),"^",4),0)),"^"),1,17),1:$E(TAB,1,18))
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,65-$L(^(0)))_$S($P(GMRCDA(2),"^")]"":$E($P(GMRCDA(2),"^"),1,17),$P(GMRCDA(0),"^",5):$E($P($G(^VA(200,$P(GMRCDA(0),"^",5),0)),"^"),1,17),1:$E(TAB,1,17))
 S GMRCCT=GMRCCT+1
 Q
 ;
BLDLN2 ;SECOND line for activity
 N GMRCSLN S GMRCSLN="" ;saved SECOND line
 ;
 ; Check if the entry date and specified actual date are different
 S XDT1=$P(GMRCDA(0),"^",1),XDT2=$P(GMRCDA(0),"^",3),GMRCX=0
 S:XDT2>XDT1 X=XDT1,XDT1=XDT2,XDT2=X
 S GMRCDIF=$$FMDIFF^XLFDT(XDT1,XDT2,3)
 I $L(GMRCDIF) D
 . I +$P(GMRCDIF," ",1)>0 S GMRCX=1 Q  ;Check Days
 . S GMRCDIF=$P(GMRCDIF," ",2)
 . I +$P(GMRCDIF,":",1)>0 S GMRCX=1 Q  ;Check Hours
 . I +$P(GMRCDIF,":",2)>1 S GMRCX=1 Q  ;Check Minutes
 . Q
 I GMRCX D
 . S X=$P(GMRCDA(0),"^",1) D REGDTM^GMRCU
 . ;S GMRCSLN=$E(GMRCSLN_TAB,1,15)_"(entered) "_X_$E(TAB)_$S($P(GMRCDA(2),"^",3)]"":$P(GMRCDA(2),"^",3),1:$E(TAB,1,3))
 . S GMRCSLN=$E(GMRCSLN_TAB,1,15)_"(entered) "_X_$E(TAB,1,4)
 . Q
 ;
 I $G(GMRCSLN) D  S GMRCSLN=""
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCSLN
 . S GMRCCT=GMRCCT+1
 . Q
 ;
 ;Get local Incomplete Report and Complete result # for second line of action
 I +$P(GMRCDA(0),"^",9) D
 . I $P($P(GMRCDA(0),"^",9),";",2)["TIU" D  Q
 .. S GMRCSLN=$E(TAB,1,5)_"Note# "_+$P(GMRCDA(0),"^",9)
 . I $P($P(GMRCDA(0),"^",9),";",2)["MCAR" D  Q
 .. N MCFILE S MCFILE=+$P($P(GMRCDA(0),"^",9),"MCAR(",2) Q:'MCFILE
 .. N MCPRDT S MCPRDT=$$GET1^DIQ(MCFILE,+$P(GMRCDA(0),"^",9),.01)
 .. Q:'$L(MCPRDT)
 .. S GMRCSLN=$E(TAB,1,5)_"Medicine Procedure performed: "_MCPRDT
 ;
 ;Get remote Incomplete Report and Complete result # for second line of action
 I +$P(GMRCDA(2),"^",4) D
 . N GMRCRR S GMRCRR=$P(GMRCDA(2),"^",4)
 . S GMRCSLN=$E(TAB,1,5)_"Remote "_$P(GMRCRR,";",3)_" #"_+$P(GMRCRR,";")_" from "_$P($G(^DIC(4,+$P(GMRCRR,";",4),0)),"^")
 ;
 ;If GMRCDEV is defined, then print the device name on the second line
 I GMRCACT=22,$D(GMRCDEV) D
 . S GMRCSLN=$E(TAB,1,5)_$E(GMRCDEV,1,17) K GMRCDEV
 ;
 ;Build line for forwarded to (action 17)
 I GMRCACT=17 D
 . S GMRCX=$S(+$P(GMRCDA(0),"^",6):$P($G(^GMR(123.5,+$P(GMRCDA(0),"^",6),0)),"^"),$P(GMRCDA(3),"^")]"":$P(GMRCDA(3),"^"),1:" ??")
 . S GMRCSLN=$E(TAB,1,5)_GMRCX
 . I $P(GMRCDA(0),"^",7)'="" S GMRC3LN="Previous Attention:  "_$P($G(^VA(200,$P(GMRCDA(0),"^",7),0)),"^")
 I GMRCACT=25 D
 . S GMRCX=""
 . I $P(^GMR(123,+GMRCO,12),U,5)="F" D
 .. S GMRCX="Previous remote service name: "
 . S GMRCX=GMRCX_$S(+$P(GMRCDA(0),"^",6):$P($G(^GMR(123.5,+$P(GMRCDA(0),"^",6),0)),"^"),$P(GMRCDA(3),"^")]"":$P(GMRCDA(3),"^"),1:" ??")
 . S GMRCSLN=$E(TAB,1,5)_GMRCX
 . I $P(GMRCDA(0),"^",7)'="" S GMRC3LN="Previous Attention:  "_$P($G(^VA(200,$P(GMRCDA(0),"^",7),0)),"^")
 I $G(GMRCSLN) D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCSLN
 . S GMRCCT=GMRCCT+1
 . Q
 I $D(GMRC3LN) D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRC3LN
 . S GMRCCT=GMRCCT+1
 . Q
 ;
 Q
 ;
BLDCMTS ;Build lines for Comment activity.
 I GMRCACT=11 D BLDCMT Q
 ;
 ;Build lines for general comments on any activity
 I $D(^GMR(123,+GMRCO,40,+GMRCDA,1)) D  Q
 . S LN=$O(^GMR(123,+GMRCO,40,+GMRCDA,1,0)) Q:'+LN
 . ;Check for edited fields generated text with lines <75 characters
 . I $G(^GMR(123,+GMRCO,40,+GMRCDA,1,LN,0))["EDITED FIELDS" D BLDCMT Q
 . D BLDCMT
 . Q
 . I $L($G(^GMR(123,+GMRCO,40,+GMRCDA,1,LN,0)))'>75 D BLDCMT Q
 . ;Use utilities for long line formating
 . S FLG=1,LINE="     "
 . D WPSET^GMRCUTIL("^GMR(123,+GMRCO,40,GMRCDA,1)","^TMP(""GMRCR"",$J,""DT"")",LINE,.GMRCCT,TAB,FLG)
 . D BLDASH
 . Q
 Q
 ;
BLDCMT ;Build comment lines
 ;DASH is 1 or "" for print dash line after comment
 S LN=0
 F  S LN=$O(^GMR(123,+GMRCO,40,+GMRCDA,1,LN)) Q:'+LN  D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^GMR(123,+GMRCO,40,GMRCDA,1,LN,0) ;$P(^GMR(123,+GMRCO,40,GMRCDA,1,LN,0),"^",1)
 . S GMRCCT=GMRCCT+1
 . Q
 ;D BLDASH
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
 ;
BLDASH ;Build separater line with dashes
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",$P(^(0),"-",80)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
