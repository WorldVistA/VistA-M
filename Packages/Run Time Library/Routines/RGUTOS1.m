RGUTOS ;CAIRO/DKM - Platform-dependent operations;12-Oct-1998 16:40;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Return version # of RTL
VER() Q +$P($T(RGUTOS+1),";",3)
 ; Set right margin
RM(X) X ^%ZOSF("RM")
 Q
 ; Test for routine/tag
TEST(X) N Z
 S:X[U Z=$P(X,U),X=$P(X,U,2)
 X ^%ZOSF("TEST")
 Q $S('$T:0,$G(Z)="":1,Z'?.1"%"1.AN:0,1:$T(@Z^@X)'="")
 ; Raise an exception
RAISE(X) ZT $G(X)
 ; Return code to set error trap
TRAP(X) Q $$SUBST^RGUT(^%ZOSF("TRAP"),"X",""""_X_"""")
 ; Check for $ET capability
ETRAP() Q $$NEWERR^%ZTER
 ; Open a file (extrinsic)
OPENX(X1,X2) ;
 D OPEN(.X1,.X2)
 Q X1
 ; Open a file
OPEN(X1,X2) ;
 N IO,POP,X3
 D PARSE(.X1,.X3),OPEN^%ZISH(X3_X1,X3,X1,$G(X2,"R"),32767)
 I POP ZT "OPEN"
 S ^XTMP("RGHFS",$J,IO)=X3_X1,X1=IO
 Q
 ; Close a file
CLOSE(X) N Y
 S Y=$G(^XTMP("RGHFS",$J,X)),IO=X
 K ^(X)
 D CLOSE^%ZISH(Y)
 Q
 ; Close all open HFS
CLOSEALL N Z
 S Z=""
 F  S Z=$O(^XTMP("RGHFS",$J,Z)) Q:Z=""  D CLOSE(Z)
 Q
 ; Parse out directory from filename
PARSE(X,Y) ;
 N D,Z
 S D=$E($$DIRDLM,3),Z=$L(X,D),Y=$P(X,D,1,Z-1)_$S(Z>1:D,1:""),X=$P(X,D,Z)
 Q
 ; Read a line
READ(X,Y) ;
 N IO,%ZA,%ZB,%ZC,%ZL
 S IO=$G(Y,$I)
 D READNXT^%ZISH(.X)
 U IO
 Q $$STATUS^%ZISH&'$L(X)
 ; Delete a file
DELETE(X) ;
 N Z
 D PARSE(.X,.Z)
 S Z(X)="",Z=$$DEL^%ZISH(Z,"Z")
 Q
 ; Rename a file
RENAME(X1,X2) ;
 N X3,X4
 D PARSE(.X1,.X3),PARSE(.X2,.X4)
 I $$MV^%ZISH(X3,X1,X4,X2)
 Q
 ; List files
DIR(X1,X2,X3) ;
 N Z
 D PARSE(.X1,.Z)
 S Z(X1)="",X3=$G(X3,"^UTILITY(""DIR"",$J)")
 K @X3
 I $$LIST^%ZISH(Z,"Z",X3)
 Q
 ; Force error if at EOF
EOF I $$STATUS^%ZISH ZT "EOF"
 Q
 ; Returns true if current error is EOF
EOFERR() Q $$EC^%ZOSV["EOF"
 ; URL format filename-->HFS format
CVTFN(RGFIL,RGROOT) ;
 N RGZ,RGZ1,RGD
 S RGD=$$DIRDLM,RGROOT=$G(RGROOT)
 S:$E(RGROOT,$L(RGROOT))=$E(RGD,3) RGROOT=$E(RGROOT,1,$L(RGROOT)-1)
 S RGZ=$L(RGFIL,"/"),RGZ1=$P(RGFIL,"/",1,RGZ-1),RGFIL=$P(RGFIL,"/",RGZ)
 S:$L(RGZ1) RGROOT=RGROOT_$E(RGD,$S($L(RGROOT):2,1:1))_$TR(RGZ1,"/.-",$E(RGD,2))
 Q RGROOT_$S($L(RGROOT):$E(RGD,3),1:"")_RGFIL
 ; Return directory delimiters
DIRDLM() N X
 S X=$$PWD^%ZISH
 Q $S(X["[":"[.]",X["\":"\\\",1:"///")
 ; FTP file transfer
FTP(X1,X2,X3,X4,X5,X6,X7) ;
 D:$$VERSION^%ZOSV(1)["DSM" VMS^RGUTFTP(.X1,.X2,.X3,.X4,.X5,.X6,.X7)
 Q
 ; Parse error data
ERR(X1,X2,X3) ;
 N X
 S X=$$EC^%ZOSV,X1=$$VERSION^%ZOSV(1)
 G ERRMSM:X1["MSM",ERRDSM:X1["DSM"
 S (X1,X2,X3)=""
 Q
ERRMSM S X1=$E($P(X,">"),2,99),X2=$P($P(X,">",2),":"),X3=X1
 S:X2["*" X2=""
 S:$E(X1)="Z" X3=$E(X1,2,99),X1="ZTRAP"
 Q
ERRDSM S X1=$P($P(X,", ",2),"-",3),X2=$P($P(X,", "),":"),X3=$$TRIM^RGUT($P(X,", ",$S(X1="ZTRAP":4,1:3)))
 Q
