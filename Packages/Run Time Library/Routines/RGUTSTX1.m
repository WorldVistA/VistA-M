RGUTSTX1 ;CAIRO/DKM - Continuation of RGUTSTX;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Parse an expression
EXP(RGEX) ;
 N RGF,RGC,RGPN
 S (RGF,RGPN)=0,RGEX=$G(RGEX)
 F  D  Q:RGF<0!RGERR
 .S RGC=$E(RGM,RGPSN),RGPSN=RGPSN+1
 .D @("OP"_RGF)
 I 'RGERR,RGPN S RGERR=3
 S RGEX=$S($G(RGPN(RGPN,"@")):"@",1:"")_RGEX
 Q
 ; Operands
OP0 I RGC'=".",RGEX["." S RGEX=$TR(RGEX,".")
 G:RGC'="" COLON2:RGC=":",GLBL:RGC=U,DOT:RGC=".",INDIR:RGC="@",FCN:RGC="$",UNARY:"'+-"[RGC,QT:RGC=RGQT,NUM:RGC?1N,OPNPAR:RGC="(",VAR:RGC?1A,VAR:RGC="%"
 S RGERR=6
 Q
 ; Operators
OP1 G END:RGC="",INDIR2:RGC="@",DONE:RGEX["="&'RGPN!(RGC=" ")
 K RGPN(RGPN,"@")
 G COLON:RGC=":",CLSPAR:RGC=")",RBRKT:RGC="]",BINARY:"!#&*-_+=\/<>["[RGC,NOT:RGC="'",PTRN:RGC="?"
DONE S RGPSN=RGPSN-1
END S RGF=-1
 Q
 ; Negated operator
NOT S:'$$NEXT("=<>[]?&!",0) RGERR=2
 Q
 ; Parse a global reference
GLBL D:$$NEXT("[") PLIST(";1-2","]")
 Q:RGERR
 S:'$$NEXT("(",0) RGPSN=$$NAME^RGUTSTX0(RGPSN,"$%")
 I 'RGERR,$$NEXT("(") D PLIST(";1-999")
 S RGF=1
 Q
 ; Indirection (prefix)
INDIR S RGPN(RGPN,"@")=$G(RGPN(RGPN,"@"))+1
 Q
 ; Indirection (suffix)
INDIR2 I +$G(RGPN(RGPN,"@"))'>0 S RGERR=2
 E  I '$$NEXT("(") S RGERR=2
 E  D
 .S RGPN(RGPN,"@")=-(RGPN(RGPN,"@")>1)
 .D PLIST()
 Q
 ; Intrinsic function/system variable
FCN G:$$NEXT("$") EXT
INT N RGZ,RGZ1
 S RGZ1=$E(RGM,RGPSN),RGZ=$$INT^RGUTSTX0(.RGPSN),RGF=1
 I 'RGERR,$$NEXT("(") D PLIST(RGZ)
 Q
 ; Extrinsic function
EXT S:'$$NEXT(U,0) RGPSN=$$LABEL^RGUTSTX0
 Q:RGERR
 S:$$NEXT(U) RGPSN=$$LABEL^RGUTSTX0
 Q:RGERR
 D:$$NEXT("(") PLIST(".;0-999")
 S RGF=1
 Q
 ; Unary operator
UNARY Q
 ; String literal
QT D QT2
 S RGF=1
 Q
 ; Find matching quote
QT2 F RGPSN=RGPSN:1:RGLEN I $$NEXT(RGQT),'$$NEXT(RGQT,0) Q
 S:$E(RGM,RGPSN-1)'=RGQT RGERR=9
 Q
 ; Numeric constant
NUM N RGZ,RGZ1
 S RGZ=0,RGF=1
 F RGPSN=RGPSN-1:1 S RGZ1=$E(RGM,RGPSN) D @("NUM"_RGZ) Q:RGZ<0
 S:RGZ=-2 RGERR=2
 Q
NUM0 S RGZ=$S(RGZ1?1N:1,RGZ1=".":2,1:-2)
 Q
NUM1 S RGZ=$S(RGZ1?1N:1,RGZ1=".":3,1:-1)
 Q
NUM2 S RGZ=$S(RGZ1?1N:3,1:-2)
 Q
NUM3 S RGZ=$S(RGZ1?1N:3,RGZ1="E":4,1:-1)
 Q
NUM4 S RGZ=$S(RGZ1="+":5,RGZ1="-":5,RGZ1=".":7,RGZ1?1N:6,1:-2)
 Q
NUM5 S RGZ=$S(RGZ1?1N:6,RGZ1=".":7,1:-2)
 Q
NUM6 S RGZ=$S(RGZ1?1N:6,RGZ1=".":8,1:-1)
 Q
NUM7 S RGZ=$S(RGZ1?1N:8,1:-2)
 Q
NUM8 S RGZ=$S(RGZ1?1N:8,1:-1)
 Q
 ; Open parenthesis
OPNPAR S RGPN=RGPN+1
 K RGPN(RGPN)
 Q
 ; Period (variable by reference or FP number)
DOT I RGEX[".",$E(RGM,RGPSN)'?1N D
 .I '$$NEXT("@") S RGPSN=$$NAME^RGUTSTX0(RGPSN,"%"),RGF=-1
 .E  D INDIR
 E  D NUM
 Q
 ; Variable name
VAR S RGPSN=$$NAME^RGUTSTX0(RGPSN-1,"%"),RGF=1
 D:$$NEXT("(") PLIST()
 Q
 ; Closing parenthesis
CLSPAR I 'RGPN,RGEX[")" G DONE
 I RGPN S RGPN=RGPN-1
 E  S RGERR=3
 Q
 ; Right bracket (] or ]])
RBRKT I 'RGPN,RGEX["]" G DONE
 I $$NEXT(RGC)
 ; Binary operator
BINARY S RGF=0
 Q
 ; Colon operand
COLON2 S:RGEX'["M" RGERR=6
 Q
 ; Colon operator
COLON G:RGEX'[":" DONE
 S RGF=0
 S:RGEX'["M" RGEX=$TR(RGEX,":")
 Q
 ; Pattern match
PTRN N RGZ,RGZ1
 I $$NEXT("@") S RGF=0 Q
 S RGZ=RGPSN,@$$TRAP^RGZOSF("PERR^RGUTSTX1"),RGZ1=0
 F  D  Q:RGZ1<0!RGERR
 .D QT2:$$NEXT(RGQT),PTRN1:$$NEXT("("),PTRN2:$$NEXT(")")
 .I RGZ1,$$NEXT(",")
 .S:'$$NEXT("ACELNPU.0123456789") RGZ1=-1
 S:'RGERR RGZ=RGZ?@$E(RGM,RGZ,RGPSN-1)
 Q
PTRN1 S RGZ1=RGZ1+1
 Q
PTRN2 S RGZ1=RGZ1-1
 S:RGZ1<0 RGPSN=RGPSN-1
 Q
PERR S RGERR=10
 Q
 ; Process a parameter list
PLIST(RGP,RGT) ;
 N RGC,RGP1,RGP2,RGZ
 S RGT=$G(RGT,")"),RGP=$G(RGP,";0-999"),RGP2=$P(RGP,";",2),RGP1=+RGP2,RGP2=+$P(RGP2,"-",2),RGC=0,RGZ=$P(RGP,";")
 I '$$NEXT(RGT,0) D
 .F RGC=1:1 D  Q:RGERR!'$$NEXT(",")
 ..D @("PL"_$P(RGP,";",RGC+2))
 I 'RGERR,RGC<RGP1!(RGC>RGP2) S RGERR=8
 I 'RGERR,'$$NEXT(RGT) S RGERR=3
 Q
PL N RGEX
 I RGZ=".",$$NEXT(",",0) Q
 S RGEX=RGT_RGZ
 D EXP(.RGEX)
 I RGZ[":",RGEX[":" S RGERR=2
 Q
PLV D LVAL^RGUTSTX0("LG")
 Q
PLL D LBL1^RGUTSTX0()
 Q
 ; Get next character
NEXT(RGC,RGI) ;
 Q $$NEXT^RGUTSTX0(RGC,.RGI)
