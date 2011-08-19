RGRSUTL2 ;ALB/RJS-UTILITIES FOR CIRN ;1/2/97
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;
SSN(SSN,ARRAY) ;RETURNS DFN'S OF ALL SSN'S OR PSUEDO'S THAT MATCH 
 ;        THE SSN PASSED
 ;        CALLING ROUTINE MUST KILL ARRAY BEFORE CALLING THIS
 ;        FUNCTION
 Q:$G(SSN)=""!($G(ARRAY)="")
 N RGDFN S RGDFN=0
 F  S RGDFN=$O(^DPT("SSN",SSN,RGDFN)) Q:RGDFN'>0  D SET(RGDFN)
 I $D(@ARRAY) Q 1
 Q 0
SET(DFN) ;
 Q:'$D(^DPT(DFN,0))
 S @ARRAY@(DFN)=$P(^DPT(DFN,0),"^",1)
 Q
 ; This function determines if a word is singular or plural and also
 ; determines if "no" or a numeric value is placed in front of
 ; the word (ie no exception(s)).
SNGPLR(RGNUM,RGSNG,RGPLR) ;
 N RGZ
 S RGZ=RGSNG?.E1L.E,RGPLR=$G(RGPLR,RGSNG_$S(RGZ:"s",1:"S"))
 Q $S('RGNUM:$S(RGZ:"no ",1:"NO ")_RGPLR,RGNUM=1:"1 "_RGSNG,1:RGNUM_" "_RGPLR)
 ; Display formatted title
TITLE(RGTTL,RGVER,RGFN) ;
 I '$D(IOM) N IOM,IOF S IOM=80,IOF="#"
 S RGVER=$G(RGVER,"1.0")
 S:RGVER RGVER="Version "_RGVER
 U $G(IO,$I)
 W @IOF,$S(IO=IO(0):$C(27,91,55,109),1:""),$C(13)
 S Y=$$DT^XLFDT X ^DD("DD")
 W Y,?(IOM-$L(RGTTL)\2),RGTTL,?(IOM-$L(RGVER)),RGVER,!,$S(IO=IO(0):$C(27,91,109),1:$$UND),!
 W:$D(RGFN) ?(IOM-$L(RGFN)\2),RGFN,!
 Q
 ; Pause for user response
PAUSE(RGP,RGX,RGY) ;
 Q $$GETCH($G(RGP,"Press RETURN or ENTER to continue..."),U,.RGX,.RGY)
 ; Single character read
GETCH(RGP,RGV,RGX,RGY,RGT,RGD) ;
 N RGZ,RGC
 W:$D(RGX)!$D(RGY) $$XY($G(RGX,$X),$G(RGY,$Y))
 W $G(RGP)
 S RGT=$G(RGT,$G(DTIME,999999999999)),RGD=$G(RGD,U),RGC=""
 S:$D(RGV) RGV=$$UP^XLFSTR(RGV)_U
 F  D  Q:'$L(RGZ)
 .S RGZ=$$READ^XGF(1,RGT)
 .E  S RGC=RGD Q
 .W $C(8)
 .Q:'$L(RGZ)
 .S RGZ=$$UP^XLFSTR(RGZ)
 .I $D(RGV) D
 ..I RGV[RGZ S RGC=RGZ
 ..E  W $C(7,32,8) S RGC=""
 .E  S RGC=RGZ
 W !
 Q RGC
 ; Convert X to base Y padded to length L
BASE(X,Y,L) ;
 Q:(Y<2)!(Y>62) ""
 N RGZ,RGZ1
 S RGZ1="",X=$S(X<0:-X,1:X)
 F  S RGZ=X#Y,X=X\Y,RGZ1=$C($S(RGZ<10:RGZ+48,RGZ<36:RGZ+55,1:RGZ+61))_RGZ1 Q:'X
 Q $S('$G(L):RGZ1,1:$$REPEAT^XLFSTR(0,L-$L(RGZ1))_$E(RGZ1,1,L))
 ;
 ; Output an underline X bytes long
UND(X) Q $$REPEAT^XLFSTR("-",$G(X,$G(IOM,80)))
 ;
 ; Position cursor
XY(DX,DY) ;
 D:$G(IOXY)="" HOME^%ZIS
 S DX=$S(+$G(DX)>0:+DX,1:0),DY=$S(+$G(DY)>0:+DY,1:0),$X=0
 X IOXY
 S $X=DX,$Y=DY
 ; Send an alert.
 ;    XQAMSG = Message to send
 ;    RGUSR  = A semicolon-delimited list of users to receive alert.
ALERT(XQAMSG,RGUSR) ;
 N XQA,XQAOPT,XQAFLG,XQAROU,XQADATA,XQAID
 S @$$TRAP^RGZOSF("EXIT^RGRSUTL2"),RGUSR=$G(RGUSR,"*"),XQAMSG=$TR(XQAMSG,U,"~")
 D ENTRY(RGUSR,.XQA),SETUP^XQALERT:$D(XQA)
EXIT Q
 ; Takes a list of receipients as input and produces an array of
 ; DUZ's as output.
 ; Inputs:
 ;     RGUSR = Semicolon-delimited list of recipients
 ;     RGLST = Special token list
 ; Outputs:
 ;     RGOUT = Local array to receive DUZ list
ENTRY(RGUSR,RGOUT,RGLST) ;
 N RGZ,RGZ1,RGZ2
 K RGOUT
 F RGZ=1:1:$L(RGUSR,";") S RGZ1=$P(RGUSR,";",RGZ) D:RGZ1'=""  S:RGZ1 RGOUT(+RGZ1)=""
 .S:$D(RGLST(RGZ1)) RGZ1=RGLST(RGZ1)
 .Q:RGZ1?.N
 .I RGZ1?1"-"1.N D MGRP(-RGZ1) S RGZ1=0 Q
 .S RGZ2=$E(RGZ1,1,2)
 .I RGZ2="G." D MGRP($E(RGZ1,3,999)) Q
 .I RGZ2="L." D LIST($E(RGZ1,3,999)) Q
 .S RGZ1=$$LKP(RGZ1)
 Q
LKP(RGNAME) ;
 N RGZ,RGZ1
 I $D(^VA(200,"B",RGNAME)) S RGZ=RGNAME G L1
 S RGZ=$O(^(RGNAME)),RGZ1=$O(^(RGZ))
 Q:(RGZ="")!(RGNAME'=$E(RGZ,1,$L(RGNAME))) 0
 Q:(RGZ1'="")&(RGNAME=$E(RGZ1,1,$L(RGNAME))) 0
L1 S RGZ1=$O(^(RGZ,0)),RGZ=$O(^(RGZ1))
 Q:'RGZ1!RGZ 0
 Q RGZ1
 ; Send a mail message.
MAIL(RGMSG,XMY,XMSUB,XMDUZ) ;
 N XMTEXT
 S:$D(RGMSG)=1 RGMSG(1)=RGMSG
 S XMTEXT="RGMSG(",@$$TRAP^RGZOSF("EXIT^RGRSUTL2"),XMY=$G(XMY)
 S:$G(XMSUB)="" XMSUB=RGMSG
 S:$G(XMDUZ)="" XMDUZ=$G(DUZ)
 F  Q:'$L(XMY)  S X=$P(XMY,";"),XMY=$P(XMY,";",2,999) S:$L(X) XMY(X)=""
 D ^XMD:$D(XMY)>9
 Q
LIST(RGLIST) ;
 Q:RGLIST=""
 S:RGLIST'=+RGLIST RGLIST=+$O(^RGCDSS(993.6,"B",RGLIST,0))
 S @$$TRAP^RGZOSF("LERR^RGUTUSR")
 X:$D(^RGCDSS(993.6,RGLIST,1)) ^(1)
LERR Q
MGRP(RGMGRP) ;
 N RGX
 S RGX(0)=""
 D MGRP2(RGMGRP)
 Q
MGRP2(RGMGRP) ;
 N RGZ,RGZ1
 Q:RGMGRP=""
 S:RGMGRP'=+RGMGRP RGMGRP=+$O(^XMB(3.8,"B",RGMGRP,0))
 Q:$D(RGX(RGMGRP))
 S RGX(RGMGRP)=""
 F RGZ=0:0 S RGZ=+$O(^XMB(3.8,RGMGRP,1,RGZ)) Q:'RGZ  S RGOUT(+^(RGZ,0))=""
 F RGZ=0:0 S RGZ=+$O(^XMB(3.8,RGMGRP,5,RGZ)) Q:'RGZ  D MGRP2(^(RGZ,0))
 Q
