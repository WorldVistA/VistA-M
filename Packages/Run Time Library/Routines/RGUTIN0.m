RGUTIN0 ;CAIRO/DKM - Platform-dependent operations;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
VER() Q $P($T(+2),";",3)
CVTFN(RGFIL,RGROOT) ;
 N RGZ,RGZ1,RGD
 S RGD=$$DIRDLM,RGROOT=$G(RGROOT)
 S:$E(RGROOT,$L(RGROOT))=$E(RGD,3) RGROOT=$E(RGROOT,1,$L(RGROOT)-1)
 S RGZ=$L(RGFIL,"/"),RGZ1=$P(RGFIL,"/",1,RGZ-1),RGFIL=$P(RGFIL,"/",RGZ)
 S:$L(RGZ1) RGROOT=RGROOT_$E(RGD,$S($L(RGROOT):2,1:1))_$TR(RGZ1,"/.-",$E(RGD,2))
 Q RGROOT_$S($L(RGROOT):$E(RGD,3),1:"")_RGFIL
RM(X) X ^%ZOSF("RM")
 Q
TEST(X) N Z
 S:X[U Z=$P(X,U),X=$P(X,U,2)
 X ^%ZOSF("TEST")
 Q $S('$T:0,$G(Z)="":1,Z'?.1"%"1.AN:0,1:$T(@Z^@X)'="")
ETRAP() Q $$NEWERR^%ZTER
OPENX(X1,X2) ;
 D OPEN(.X1,.X2)
 Q X1
