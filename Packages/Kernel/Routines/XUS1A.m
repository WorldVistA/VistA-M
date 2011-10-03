XUS1A ;SF-ISC/STAFF - SIGNON overflow from XUS1 ;01/28/2004  08:09
 ;;8.0;KERNEL;**153,149,183,258,265**;Jul 10, 1995
 Q
USER() ;
 N %B,%E,%T,I1,X1,X2
 S XUTEXT=0,DUZ(2)=$G(DUZ(2),0)
 F I=0:0 S I=$O(^XTV(8989.3,1,"POST",I)) Q:I'>0  D SET("!"_$G(^(I,0)))
 D SET("!"),XOPT
 S %H=$P($H,",",2)
 D SET("!Good "_$S(%H<43200:"morning ",%H<61200:"afternoon ",1:"evening ")_$S($P(XUSER(1),U,4)]"":$P(XUSER(1),U,4),1:$P(XUSER(0),U,1)))
 S I1=$G(^VA(200,DUZ,1.1)),X=(+I1_"0000")
 I X D SET("!     You last signed on "_$S(X\1=DT:"today",X\1+1=DT:"yesterday",1:$$FMTE^XLFDT(X,"1D"))_" at "_$E(X,9,10)_":"_$E(X,11,12))
 I $P(I1,"^",2) S I=$P(I1,"^",2) D SET("!There "_$S(I>1:"were ",1:"was ")_I_" unsuccessful attempt"_$S(I>1:"s",1:"")_" since you last signed on.")
 I $P(XUSER(0),U,12),$$PH(%H,$P(XUSER(0),U,12)) Q 17 ;Time frame
 I +$P(XOPT,U,15) S %=$P(XOPT,U,15)-($H-XUSER(1)) I %<6,%>0 D SET("!     Your Verify code will expire in "_%_" days")
 ;Report new Mail
 N XUXM S %=$$NU^XMGAPI4(1,1,"XUXM") I $G(XUXM) F %=0:0 S %=$O(XUXM(%)) Q:%'>0  D SET("!"_XUXM(%))
 S:$P(XOPT,"^",5) XUTT=1 S DTIME=$P(XOPT,U,10)
 ;Check Multiple Sign-on allowed, X1 signed on flag, X2 0=No,1=Yes,2=1IP
 S X1=$P($G(^VA(200,DUZ,1.1)),U,3),X2=$P(XOPT,U,4)
 I 'X2,X1 Q 9 ;Multi Sign-on not allowed
 I X2=2 D  Q:%B>0 %B ;Only from one IP
 . S %B=0 I '$D(IO("IP")) S:X1 %B=9 Q  ;Can't tell IP, 
 . S X1=$$COUNT(DUZ,IO("IP")),%B=$S(X1<0:9,(X1+1)>$P(XOPT,U,19):9,1:0)
USX S $P(^VA(200,DUZ,1.1),U,3)=1
 ;Call XQOR to handle SIGN-ON protocall.
 N XUSER,XUSQUIT ;Protect ourself.
 S DIC="^DIC(19,",X="XU USER SIGN-ON",XUSQUIT=0
 D EN^XQOR
 K X,DIC
 Q XUSQUIT ;If protocol set XUSQUIT will stop sign-on.
 ;
SET(V) ;Set into XUTEXT(XUTEXT), Called from XU USER SIGN-ON protocol.
 S XUTEXT=$G(XUTEXT)+1,XUTEXT(XUTEXT)=V
 Q
 ;
DUZ ;setup duz, also see XUS5
 ;Called from XUSRB, XUESSO1
 S:'$D(XUSER(0)) XUSER(0)=^VA(200,DUZ,0) D:$D(XOPT)[0 XOPT
 S DUZ(0)=$P(XUSER(0),U,4),DUZ(1)="",DUZ("AUTO")=$P(XOPT,"^",6)
 S DUZ(2)=$S($G(DUZ(2))>0:DUZ(2),1:+$P(XOPT,U,17))
 S X=$P($G(^DIC(4,DUZ(2),99)),U,5),DUZ("AG")=$S(X]"":X,1:$P(^XTV(8989.3,1,0),U,8))
 S DUZ("BUF")=($P(XOPT,U,9)="Y"),DUZ("LANG")=$P(XOPT,U,7)
 Q
XOPT ;Build the XOPT string
 N X,I
 S:'$D(XOPT) XOPT=$G(^XTV(8989.3,1,"XUS"))
 S X=$G(^VA(200,DUZ,200))
 F I=4:1:7,9,10,19 I $P(X,U,I)]"" S $P(XOPT,"^",I)=$P(X,U,I)
 Q
 ;
COUNT(IEN,IP) ;Count sign-on log active connect from this IP
 N CNT,IX
 S CNT="",IX=0
 I '$D(^XUSEC(0,"AS3",IEN)) Q 0 ;First sign-on
 I $O(^XUSEC(0,"AS3",IEN,""))'=IP Q -1 ;Diff IP
 I $O(^XUSEC(0,"AS3",IEN,""),-1)'=IP Q -1 ;Diff IP
 F  S IX=$O(^XUSEC(0,"AS3",IEN,IP,IX)) Q:'IX  S CNT=CNT+1
 Q CNT ;Return Count
 ;
INTRO(WNM) ;
 Q:'$D(^XTV(8989.3,1,"INTRO",0))
 F I=0:0 S I=$O(^XTV(8989.3,1,"INTRO",I)) Q:I'>0  S X=^(I,0) D
 . I $D(WNM) S @WNM@(I)=X
 . I '$D(WNM) W X,!
 . Q
 Q
 ;
DD(Y) Q $$FMTE^XLFDT(X,"1D")
 ;
PH(%T,%R) ;Check Prohibited time for R/S
 N MSG S MSG=$$PROHIBIT(%T,%R)
 I MSG S XUM(0)=$P(MSG,U,2) Q 1
 D SET("!"),SET("! "_$$EZBLD^DIALOG(30810.62)_" "_$P(MSG,U,2))
 Q 0
 ;
PROHIBIT(%T,%R) ;See if a prohibited time, (Time from $H, restrict range)
 N XMSG,%B,%E
 S %T=%T\60#60+(%T\3600*100),%B=$P(%R,"-",1),%E=$P(%R,"-",2)
 S XMSG=$P($$FMTE^XLFDT(DT_"."_%B,"2P")," ",2,3)_" "_$$EZBLD^DIALOG(30810.61)_" "_$P($$FMTE^XLFDT(DT_"."_%E,"2P")," ",2,3)
 I $S(%E'<%B:%T'>%E&(%T'<%B),1:%T>%B!(%T<%E)) Q "1^"_XMSG ;No
 Q "0^"_XMSG
