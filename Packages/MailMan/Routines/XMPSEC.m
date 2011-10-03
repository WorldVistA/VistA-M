XMPSEC ;ISC-SF/GMB-PackMan Security ;04/17/2002  11:13
 ;;8.0;MailMan;;Jun 28, 2002
 ; Code rewritten.  Originally (ISC-WASH/GM/CAP)
 ; Includes the former ^XMASEC (ISC-WASH/GM)
 N I,XMTVAL,XMSTR
 W !,"This message has been secured!"
 S XMPASS=1
 I '$D(XMSECURE),'$$KEYOK^XMJMCODE(XMZ,$P(XMA0,U,10)) S XMPASS=0 Q
 W !,"Checking the package's integrity... (This may take some time.)",!
 S I=$O(^XMB(3.9,XMZ,2,.999))
 I $P(^(I,0),U,3,9999)'=$$ENCSTR^XMJMCODE("$SEC^3") S XMPASS=0 D FAIL Q
 S I=1,XMTVAL=0
P0 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:'I  D
 . Q:'$D(^(I,0))  ; naked reference to line above
 . S XMSTR=^(0)   ; naked reference to line above
 . I $E(XMSTR)="$" D CSCRAM(XMSTR) Q
 . I 'XMB0 W:$X>75 ! W "." Q
 . D VAL(XMSTR,.XMTVAL)
 W !,"<<< DONE >>>",!
 D:'XMPASS FAIL
 Q
VAL(XMSTR,XMTVAL) ;
 N XMLVAL,I
 S XMLVAL=0
 F I=1:1:$L(XMSTR) S XMLVAL=$A(XMSTR,I)*I+XMLVAL
 S XMTVAL=XMTVAL+XMLVAL+$L(XMSTR)
 Q
CSCRAM(XMSTR) ;
 S XMB0=$S(XMSTR'["TXT":1,1:0)
 I XMSTR["ROU",$P(XMSTR," ",2)?1"^".AN1"NTEG" D CNTEG Q
 I XMSTR'["$END"!($E(XMSTR,1,8)="$END TXT"&'XMB0) S XMTVAL=0,XMA0=$P(XMSTR," ",2) Q
 W "." I $P(XMSTR," ",2)="MESSAGE" Q
 S XMA0=$S(XMSTR["$GLB":$P(XMSTR,U,2),XMSTR["$GLO":$P(XMSTR,U,2),1:$P($P(XMSTR,U)," ",3))
 I XMSTR["ROU" W:$X>70 ! W $J($E(XMA0,1,9),10)
 E  W !,$P($E(XMSTR,5,99),U)
 ;CHECK SUM EVALUTAION
 Q:$P(XMSTR,U,2,999)=$$ENCSTR^XMJMCODE("$SEC"_U_(XMTVAL+XMPAKMAN("XMRW")))
 W !!,"******** ",$J(XMA0,10)," has failed !!!!!!!!!!!",!!
 S (XMTVAL,XMPASS)=0
 Q
FAIL ;
 N XMTEXT,XMTO,XMFROM
 S:'$D(XMPASS) XMPASS=0
 S XMTEXT(1,0)="A package with the subject: "_$P(^XMB(3.9,XMZ,0),U)
 S XMTEXT(2,0)="failed the security check during installation"_$S($D(XMPASS):".",1:", but was installed anyway.")
 S XMFROM=$P(^XMB(3.9,XMZ,0),U,2)
 I $G(XMFROM)["<" S XMTO(P($P(XMFROM,"<",2),">"))=""
 S XMTO(XMDUZ)=""
 D SENDMSG^XMXSEND(XMDUZ,"Failed Security","XMTEXT",.XMTO)
 Q
CHECK ;FROM XMP2
 Q:XCF'=2
 I "$DDD$RTN$DIE$DIB$DIP$ROU$GLB$GLO$OPT$HEL$BUL$KEY$PKG$FUN"[$E(X,1,4),X[U D  Q
 . D:'$D(XMPASS) FAIL
 . S X=$P(X,U)_$P(X,U,2)
 . S:$P(X," ",2)?.EU1"INIT"&($E(X,1,4)="$ROU") XMINIT=U_$P(X," ",2)
 I $E(X,1,12)="$END MESSAGE",'$D(XMPASS) D FAIL
 Q
CNTEG ; Skip processing XXXINTEG program
 S XMINTEG=$P(X," ",2)
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:'I  Q:"$END"[$E(^(I,0),1,4)
 Q
PSECURE(XMZ,XMABORT) ; Secure the PackMan message
 N XMKEY,XMHINT,XMNO,XMSECURE
 S XMABORT=0
 D PQSEC(.XMNO,.XMABORT) Q:XMNO!XMABORT
 D CRE8KEY^XMJMCODE(.XMKEY,.XMHINT,.XMABORT) Q:XMABORT
 W !!,"Securing the message now.  This may take a while.",!
 D LOADCODE^XMJMCODE
 D ADJUST^XMJMCODE(.XMKEY)
 D PSTORE(XMZ,XMKEY,XMHINT)
 D PSECIT(XMZ)
 Q
PQSEC(XMOK,XMABORT) ;
 N DIR,Y,X
 S DIR(0)="Y"
 S DIR("A")="Do you wish to secure this message"
 S DIR("B")="NO"
 S DIR("?",1)="If you answer yes, this message will be secured"
 S DIR("?")="to ensure that what you send is what is actually received."
 D ^DIR
 I $D(DIRUT) S XMABORT=1
 S XMNO='Y
 Q
PSTORE(XMZ,XMKEY,XMHINT) ;
 N XMFDA,XMIENS
 S XMIENS=XMZ_","
 S XMFDA(3.9,XMIENS,1.8)=$S($G(XMHINT)="":" ",1:XMHINT)
 S XMFDA(3.9,XMIENS,1.85)="1"_$$ENCSTR^XMJMCODE(XMKEY)
 D FILE^DIE("","XMFDA")
 Q
PSECIT(XMZ) ;
 N XMSTR,I,XMTVAL
 S I=$O(^XMB(3.9,XMZ,2,.999))
 S XMSTR=^XMB(3.9,XMZ,2,I,0)
 S XMSTR=$P(XMSTR,"on")_"at "_$P(XMSTR," at ",3)_" on"_$P($P(XMSTR,"on",2)," at",1)
 S ^XMB(3.9,XMZ,2,I,0)=XMSTR_U_$$ENCSTR^XMJMCODE("$SEC^3")
 S I=0
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:'I  D
 . Q:'$D(^(I,0))   ; naked reference to line above
 . S XMSTR=^(0)    ; naked reference to line above
 . I $E(XMSTR)="$" D PSCRAM(XMZ,.I,XMSTR,.XMTVAL) Q
 . D VAL(XMSTR,.XMTVAL)
 S XMSTR(1)="$END MESSAGE"
 D MOVEBODY^XMXSEND(XMZ,"XMSTR","A")
 Q
PSCRAM(XMZ,I,XMSTR,XMTVAL) ;
 I $E(XMSTR,1,4)="$END" S $P(^XMB(3.9,XMZ,2,I,0),U,2)=$$ENCSTR^XMJMCODE("$SEC"_U_(XMTVAL+XMPAKMAN("XMRW"))) Q
 I $E(XMSTR,1,4)="$ROU" D  I $P(XMSTR," ",2)?.AN1"NTEG" D PNTEG(XMZ,.I,XMSTR) Q
 . W:$X>70 !
 . W $J($P(XMSTR," ",2),10)
 S XMTVAL=0
 S $P(^XMB(3.9,XMZ,2,I,0)," ",2)=$S($E(XMSTR,1,4)'="$KID":U,1:"")_$P(XMSTR," ",2)
 Q
PNTEG(XMZ,I,XMSTR) ;
 S $P(^XMB(3.9,XMZ,2,I,0)," ",2)=U_$P(XMSTR," ",2)
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:'I  S XMSTR=^(I,0) Q:"$END"[$E(XMSTR_" ",1,4)  D
 . S:XMSTR?.UN1" ;;".N $P(^XMB(3.9,XMZ,2,I,0),";",3)=$$ENCSTR^XMJMCODE($P(XMSTR,";",3)+XMPAKMAN("XMRW"))
 Q
