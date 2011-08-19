XUSG1 ;SF-ISC/STAFF - SIGNON from GUI screen ;9/28/94  14:54
 ;;8.0;KERNEL;;Jul 10, 1995
 Q
USERG ;Call from in OK Callback
 K XUTEXT N WIN,FOCUS
 I '$L($P(XUSER(1),U,2)) G CHVC
 I +$P(XOPT,U,15),(XUSER(1)+$P(XOPT,U,15)'>+$H) G CHVC
 S XUM=$$USER^XUS1A() G:XUM NO^XUSG
 D GET^XGCLOAD("XU XUS W2","WIN(""XUS2"")") ;Build XUTEXT message into window
 F J=0:0 S J=$O(XUTEXT(J)) Q:J'>0  D
 . S N="LAB"_J M WIN("XUS2","G",N)=WIN("XUS2","G","LAB1")
 . S WIN("XUS2","G",N,"TITLE")=$E(XUTEXT(J),2,255)
 . S $P(WIN("XUS2","G",N,"POS"),",",2)=(J-1*20+10)
 . Q
 D DIVSET
 D S^XG("XUS","ACTIVE",0),M^XG("XUS2",$NA(WIN("XUS2")))
 D SD^XG($PD,"FOCUS",FOCUS)
 D ESTA^XG(),K^XG("XUS2"),DUZ^XUS1A
 Q
DIVSET ;Setup the DIV list box
 S WIN("XUS2","G","DIV","VISIBLE")=0,FOCUS="XUS2,OK" K WIN("XUS2","G","DIV","CHOICE")
 S Y=$O(^VA(200,DUZ,2,0)),X=$O(^(Y)) I X>0,$D(^DIC(4,0)) D
 . S WIN("XUS2","G","DIV","VISIBLE")=1,FOCUS="XUS2,DIV"
 . S J=0 F  S J=$O(^VA(200,DUZ,2,J)) Q:J'>0  D
 . . S WIN("XUS2","G","DIV","CHOICE","A"_J)=$P($G(^DIC(4,J,0)),U)
 . . Q
 . S DUZ(2)=Y,WIN("XUS2","G","DIV","VALUE","A"_Y)=""
 . Q
 Q
OK2 ;OK button from welcome
 D ESTO^XG
 Q
DIV ;Select a div
 N WNM,G S WNM="XUS2",G="G"
 Q:'@XGWIN@(WNM,G,"DIV","CHANGED")
 S X=$O(@XGWIN@(WNM,G,"DIV","VALUE","")),DUZ(2)=+$E(X,2,9)
 Q
CHVC ;The Verify code needs changing
 N XUJ
 S XUJ(1)="SORRY you can not use this device right now.",XUJ(2)="Your VERIFY CODE needs to be changed.",XUJ(3)="Please sign on from a regular terminal to do this."
 S XUM=$$OK^XGLMSG("I",.XUJ,60),XUM=4,DUZ=0 G NO^XUSG
 ;D CVC^XUS2 G:$D(DUOUT) H^XUS S XUSER(1)=^VA(200,DUZ,.1)
 Q
NEXT ;
 G NEXT^XUS1
 ;
 ;
DD(Y) Q $S($E(Y,4,5):$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)
 Q
