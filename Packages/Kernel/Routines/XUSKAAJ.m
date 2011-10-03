XUSKAAJ ;; kec/oak - KAAJEE Utilities ;08/24/2006
 ;;8.0;KERNEL;**329,430**;Jul 10, 1995;Build 1
 ;;
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;   SSO/UC KAAJEE RPCs
 ; ------------------------------------------------------------------------
 ;
USERINFO(RET,CLIENTIP,SERVERNM) ; called by XUS KAAJEE GET USER INFO rpc
 ;
 ; INPUT:
 ; CLIENTIP is IP address of the client workstation, used for logging (signon log) and IP blocking (failed access attempts).
 ; SERVERNM is Identifying name for the calling application or server, used for logging (signon log).
 ; OUTPUT:
 ; Result(0) is the users DUZ.
 ; Result(1) is the user name from the .01 field.
 ; Result(2) is the users full name from the name standard file.
 ; Result(3) is the FAMILY (LAST) NAME
 ; Result(4) is the GIVEN (FIRST) NAME
 ; Result(5) is the MIDDLE NAME
 ; Result(6) is the PREFIX
 ; Result(7) is the SUFFIX
 ; Result(8) is the DEGREE
 ; Result(9) is station # of the division that the user is working in.
 ; Result(10) is the station # of the parent facility for the login division
 ; Result(11) is the station # from the KSP site parameters, the parent "computer system"
 ; Result(12) is the signon log entry IEN
 ; Result(13) = # of permissible divisions
 ; Result(14-n) are the permissible divisions for user login, in the format:
 ;           IEN of file 4^Station Name^Station Number^default? (1 or 0)
 ;
 N XUNC,XUNC1,XUKERR,XUKRET,XUDIVS,XUKI,XULINE,XUPARENT,XUDIVLIN,XUKDEF
 ;
 ; initialize return array
 S RET(0)=DUZ
 F I=1:1:13 S RET(I)=""
 ;
 ; get ptr to Name Components file
 D GETS^DIQ(200,DUZ_",","10.1","I","XUNC","XUKERR")
 I '$D(XUKERR) D
 .S XUNC=XUNC(200,DUZ_",",10.1,"I")
 .; get name components
 .D GETS^DIQ(20,XUNC_",","1:6","","XUNC1","XUKERR")
 .I '$D(XUKERR) D
 ..S RET(3)=XUNC1(20,XUNC_",",1) S:'$L(RET(3)) RET(3)="^"
 ..S RET(4)=XUNC1(20,XUNC_",",2) S:'$L(RET(4)) RET(4)="^"
 ..S RET(5)=XUNC1(20,XUNC_",",3) S:'$L(RET(5)) RET(5)="^"
 ..S RET(6)=XUNC1(20,XUNC_",",4) S:'$L(RET(6)) RET(6)="^"
 ..S RET(7)=XUNC1(20,XUNC_",",5) S:'$L(RET(7)) RET(7)="^"
 ..S RET(8)=XUNC1(20,XUNC_",",6) S:'$L(RET(8)) RET(8)="^"
 ;
 ; get .01 New Person name, Name components name, and login division info
 D USERINFO^XUSRB2(.XUKRET)
 S RET(1)=XUKRET(1) S:'$L(RET(1)) RET(1)="^"
 S RET(2)=XUKRET(2) S:'$L(RET(2)) RET(2)="^"
 S RET(9)=$P(XUKRET(3),U,3) S:'$L(RET(9)) RET(9)="0"
 ;
 ; get parent facility station#
 S XUPARENT=$$PRNT^XUAF4(RET(9))
 S RET(10)=$S(($P(XUPARENT,U)<1):XUPARENT,1:$$STA^XUAF4($P(XUPARENT,U)))
 S:'$L(RET(10)) RET(10)="^"
 ;
 ; get the computer system station#
 S RET(11)=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S:'$L(RET(11)) RET(11)="0"
 ;
 ; make signon log entry, get IEN
 S RET(12)=$$SIGNLOG^XUSKAAJ(CLIENTIP,SERVERNM)
 ;
 ; get permitted divisions
 S XUDIVLIN=13 ; return array subscript counter for division start point
 D DIVGET^XUSRB2(.XUDIVS,DUZ)
 I '+XUDIVS(0) S RET(XUDIVLIN)=1,RET(XUDIVLIN+1)=XUKRET(3)_"^1" ; only 1 division, so use login division.
 I +XUDIVS(0) S RET(XUDIVLIN)=+XUDIVS(0) D
 .S XUKDEF=$O(^VA(200,DUZ,2,"AX1",1,"")) ; default division if any. Should only be 1.
 .S XUKI=0,XULINE=XUDIVLIN F  S XUKI=$O(XUDIVS(XUKI)) Q:XUKI']""  D
 ..S XULINE=XULINE+1,RET(XULINE)=XUDIVS(XUKI)
 ..S $P(RET(XULINE),U,4)=$S($P(XUDIVS(XUKI),U)=XUKDEF:1,1:0)
 ;
 Q
 ;
SIGNOFF(RET,DA) ; kill entry in sign-on log. Called by XUS KAAJEE LOGOUT rpc.
 D LOUT^XUSCLEAN(DA)
 S RET=1 Q
 ;
SIGNLOG(CLIENTIP,SERVERNM) ; make a signon log entry for KAAJEE user
 ; todo: expand size of server name field?
 N XP1,XPIP,XPCLNM,Y
 S:$D(IO("IP")) XPIP=IO("IP") S IO("IP")=CLIENTIP
 S:$D(IO("CLNM")) XPCLNM=IO("CLNM") S IO("CLNM")=$E(SERVERNM,1,20)
 ;
 D GETENV^%ZOSV
 S XP1=$$SLOG^XUS1($P(Y,U,2),,,$P(Y,U),$P(Y,U,3),"KAAJEE","")
 ;
 S:$D(XPIP) IO("IP")=XPIP
 S:$D(XPCLNM) IO("CLNM")=XPCLNM
 Q XP1
 ;
