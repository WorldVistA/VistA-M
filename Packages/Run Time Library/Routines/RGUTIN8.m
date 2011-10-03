RGUTIN8 ;CAIRO/DKM - Inits for MSM;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
OPEN(X1,X2) ;
 N Z
 S X2=$G(X2,"R")
 F Z=51:1:55 I '$D(^TMP("HFS",$J,Z)) D  Q
 .ZT:Z=55 "TMOF"
 .O Z:(X1:$S("RrWw"[X2:X2,1:"R")::::$S("Bb"[X2:"",1:$C(13,10)))
 .U Z
 .ZT:$ZA "OPEN"
 .S ^TMP("HFS",$J,Z)=X1,X1=Z
 Q
CLOSE(X) N Z
 S Z=X,X=$G(^TMP("HFS",$J,X))
 K ^(Z)
 C Z
 Q
CLOSEALL N Z
 F Z=0:0 S Z=$O(^TMP("HFS",$J,Z)) Q:'Z  C Z
 K ^TMP("HFS",$J)
 Q
EOF ZT:$ZC "EOF"
 Q
EOFERR() Q $ZE["ZEOF"
READ(X,Y) ;
 U:$G(Y)'="" Y
 R X
 Q $ZC&'$L(X)
DELETE(X) ;
 S X=$ZOS(2,X)
 Q
RENAME(X1,X2) ;
 N Z
 S Z=$ZOS(3,X1,X2)
 Q
DIR(X1,X2,X3) ;
 N Z
 S X1=$ZOS(12,X1,0),X2=+$G(X2),X3=$G(X3,"^UTILITY(""DIR"",$J)")
 K @X3
 F Z=1:1 Q:(X2&(Z>X2))!($P(X1,"^")="")  S @X3@($P(X1,"^"))="",X1=$ZOS(13,X1)
 Q
DEFDIR(X) ;
 S X=$G(X,$P($G(^XTV(8989.3,1,"DEV")),U))
 S:$E(X,$L(X))'="\" X=X_"\"
 Q X
DIRDLM() Q "\\\"
FREE(X) S X=$ZOS(9,$E(X))
 Q X*$P(X,"^",2)*$P(X,"^",3)/1048576
ERR(X1,X2,X3) ;
 S X1=$E($P($ZE,">"),2,99),X2=$P($P($ZE,">",2),":"),X3=X1
 S:X2["*" X2=""
 S:$E(X1)="Z" X3=$E(X1,2,99),X1="ZTRAP"
 Q
FTP(X1,X2,X3,X4,X5,X6,X7) ;
 Q
RAISE(X) ZT $G(X)
TRAP(X) Q $S($D(X):"$ZT="""_X_"""",1:"$ZT")
SIZE(X) N I,Y,Z
 S Z=$ZOS(12,X,0),Z=$P(Z,"^",2,999),Y=0
 I Z'="" F I=30:-1:27 S Y=Y*256+$A(Z,I)
 Q Y
