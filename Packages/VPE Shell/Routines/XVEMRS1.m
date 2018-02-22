XVEMRS1 ;DJB/VRR**Set Scroll Array ;2017-08-15  4:26 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
SETGLB ;Put routine into global
 NEW I,TXT
 KILL ^TMP("XVV","VRR",$J,VRRS)
 KILL ^TMP("XVV","IR"_VRRS,$J)
 KILL ^TMP("XVV",$J)
 S ^TMP("XVV","VRR",$J,VRRS,"NAME")=VRRPGM
 I $G(XVVSHL)="RUN" D CLHSET^XVEMSCL("VRR",VRRPGM) ;Cmnd Ln History
 I '$$EXIST^XVEMKU(VRRPGM) S VRRHIGH=0 Q
 X "F I=1:1 S TXT=$T(+I^"_VRRPGM_") Q:TXT=""""  S TXT=$P(TXT,"" "")_$C(9)_$P(TXT,"" "",2,999),^TMP(""XVV"",$J,I)=TXT"
 D SET
 KILL ^TMP("XVV",$J)
 Q
SET ;
 NEW CODE,CNT,END,END1,LINE,LN,TG,X
 S CNT=1,X=0
 F  S X=$O(^TMP("XVV",$J,X)) Q:X'>0  S CODE=^(X) D SET1
 S ^TMP("XVV","IR"_VRRS,$J,CNT)=" <> <> <>"
 Q
SET1 ;Set scroll array
 S VRRHIGH=X
 S TG=$P(CODE,$C(9)),LN=$P(CODE,$C(9),2,999)
 S (END,END1)=XVV("IOM")-11
 I $L(TG)>8 S END1=END1-($L(TG)-8)
 S TXT=$S(TG]"":$J("",8-$L(TG))_TG,1:X_$J("",8-$L(X))) ;Ln number
 S TXT=TXT_" "_$C(30)_$E(LN,1,END1)
 S ^TMP("XVV","IR"_VRRS,$J,CNT)=TXT,CNT=CNT+1
 S LN=$E(LN,(END1+1),999) Q:LN']""  F  D  Q:LN=""
 . S TXT=$J("",9)_$E(LN,1,END)
 . S LN=$E(LN,(END+1),999)
 . S ^TMP("XVV","IR"_VRRS,$J,CNT)=TXT,CNT=CNT+1
 Q
