RGUTIN18 ;CAIRO/DKM - Inits for Open-M;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
OPEN(X1,X2) ;
 O X1:$S("Rr"[$G(X2):"RS","Ww"[X2:"WNS","Bb"[X2:"RF",1:""):0
 E  ZT "NOPEN"
 U X1
 S ^TMP("HFS",$J,X1)=""
 Q
CLOSE(X) C X
 K ^TMP("HFS",$J,X)
 Q
CLOSEALL N Z
 S Z=""
 F  S Z=$O(^TMP("HFS",$J,Z)) Q:Z=""  C Z
 K ^TMP("HFS",$J)
 Q
EOF ZT:$ZA=-1 "ENDOFFILE"
 Q
EOFERR() Q:$ZE["ENDOFFILE"
READ(X,Y) ;
 S $ZT="READX"
 U $G(Y,$I)
 R X
 Q 0
READX Q 1
DELETE(X) ;
 S X=$ZF(-1,"del """_X_"""")
 Q
RENAME(X1,X2) ;
 S X1=$ZF(-1,"ren """_X1_""" """_X2_"""")
 Q
DIR(X1,X2,X3) ;
 N Z,Z1
 S X3=$G(X3,$NA(^UTILITY("DIR",$J)))
 K @X3
 S:'$G(X2) X2=9999999999
 F Z=1:1:X2 S Z1=$ZSEARCH(X1),X1="" Q:Z1=""  D
 .S Z1=$P(Z1,"\",$L(Z1,"\"))
 .S:$TR(Z1,".")'="" @X3@(Z1)=""
 Q
DIRDLM() Q "\\\"
DEFDIR(X) ;
 S X=$G(X,$P($G(^XTV(8989.3,1,"DEV")),U))
 S:$E(X,$L(X))'="\" X=X_"\"
 Q X
ERR(X1,X2,X3) ;
 S X1=$E($P($ZE,">"),2,99),X2=$P($P($ZE,">",2),":"),X3=X1
 S:X2["*" X2=""
 S:$E(X1)="Z" X3=$E(X1,2,99),X1="ZTRAP"
 Q
FTP(X1,X2,X3,X4,X5,X6,X7) ;
 Q
RAISE(X) ZT $G(X)
TRAP(X) Q $S($D(X):"$ZT="""_X_"""",1:"$ZT")
SIZE(X) Q 0
FREE(X) Q 0
