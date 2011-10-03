RGUTSTX0 ;CAIRO/DKM - Continuation of RGUTSTX;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
CMD(RGLBL) ;
 D:RGLBL'="" @RGLBL
 Q
 ; Postconditional
PC D:$$NEXT(":") EXP()
 Q:RGERR
 I " "'[$E(RGM,RGPSN) S RGERR=2
 E  S RGPSN=RGPSN+1
 Q
 ; No postconditional
NPC I $$NEXT(":") S RGERR=5
 E  I " "'[$E(RGM,RGPSN) S RGERR=2
 E  S RGPSN=RGPSN+1
 Q
 ; Arguments optional
OPT S:" "[$E(RGM,RGPSN) RGRN=0
 Q
 ; Multiple arguments
ARGS(RGEX) ;
 S RGEX=$G(RGEX)
 F  D EXP(RGEX) Q:RGERR!'$$NEXT(",")
 Q
 ; Expression
EXP(RGEX) ;
 D EXP^RGUTSTX1(.RGEX)
 Q
 ; Label reference
LBL(RGA) F  D LBL1(.RGA) Q:RGERR!'$$NEXT(",")
 Q
LBL1(RGA) ;
 S RGA=+$G(RGA)
 D LBL2
 Q:RGERR
 D:$$NEXT("+") EXP(")")
 Q:RGERR
 D:$$NEXT(U) LBL2
 I 'RGERR,RGA=2 D PARAMS(".;0-999")
 I 'RGERR,RGA D EXP(")"):$$NEXT(":")
 Q
LBL2 I $$NEXT("@") D
 .D EXP("=")
 E  S:$E(RGM,RGPSN)?.1AN.1"%" RGPSN=$$LABEL
 Q
 ; Write command
WRITE F  D  Q:RGERR!'$$NEXT(",")
 .I $$NEXT("!#") D  Q:'$$NEXT("?",0)
 ..F  Q:'$$NEXT("!#")
 .I $$NEXT("?*")
 .D EXP()
 Q
 ; Read command
READ N RGZ
 F  D  Q:RGERR!'$$NEXT(",")
 .I $$NEXT("!#") D  Q:'$$NEXT("?",0)
 ..F  Q:'$$NEXT("!#")
 .I $$NEXT("?") D EXP() Q
 .I $$NEXT(RGQT) D QT2^RGUTSTX1 Q
 .S RGZ=$$NEXT("*")
 .D LVAL("LGS")
 .I 'RGERR,'RGZ,$$NEXT("#") D EXP()
 .I 'RGERR,$$NEXT(":") D EXP()
 Q
 ; Lock command
LOCK D LIST("LG+:","LG")
 Q
 ; Set command
SET D LIST("LGS=","LGS")
 Q
 ; New command
NEW D LIST("N","")
 Q
 ; Kill command
KILL D LIST("KGL","")
 Q
 ; Merge command
MERGE D LIST("LG=")
 Q
 ; For command
FOR D LVAL("LGS")
 I '$$NEXT("=") S RGERR=2 Q
 F  D  Q:" "[$E(RGM,RGPSN)  I '$$NEXT(",") S RGERR=2 Q
 .D EXP(),EXP():$$NEXT(":"),EXP():$$NEXT(":")
 Q
 ; Evaluate L-value
 ; RGL: Allowed types:
 ;     L=Local array
 ;     G=Global arrays
 ;     S=Settable intrinsics/system variables
 ;     N=Newable system variables
 ;     K=Killable system variables
LVAL(RGL) ;
 I $$NEXT("@",0) D  Q
 .S RGL="="
 .D EXP(.RGL)
 S RGL=$G(RGL)
 I RGL["G",$$NEXT(U) D  Q
 .N RGF
 .D GLBL^RGUTSTX1
 I $TR(RGL,"SNK")'=RGL,$$NEXT("$") D  Q
 .N RGZ
 .S RGZ=$$INT(.RGPSN,RGL)
 .D:'RGERR PARAMS(RGZ)
 S RGPSN=$$NAME(RGPSN,"%")
 I 'RGERR,RGL["L" D PARAMS()
 Q
 ; Evaluate parameters/subscripts
PARAMS(RGX) ;
 D:$$NEXT("(") PLIST^RGUTSTX1(.RGX)
 Q
 ; New/Kill/Set/Lock argument list
LIST(RGL1,RGL2) ;
 N RGP,RGI
 S RGP=0
 F  D  Q:RGERR!'$$NEXT(",")
 .I 'RGP,RGL1["+",$$NEXT("+-")
 .I $D(RGL2),$$NEXT("(") D  Q:RGERR
 ..I RGP S RGERR=2 Q
 ..E  S RGP=1
 .S RGI=$S(RGP:RGL2,1:RGL1)
 .D LVAL(.RGI)
 .Q:RGERR
 .I $$NEXT(")") D  Q:RGERR
 ..I RGP S RGP=0
 ..E  S RGERR=2
 .I 'RGP,RGL1[":",$$NEXT(":") D EXP()
 .I 'RGP,RGL1["=" D
 ..I '$$NEXT("=") S:RGI'["@" RGERR=2
 ..E  D EXP():$D(RGL2),LVAL(RGL1):'$D(RGL2)
 I 'RGERR,RGP S RGERR=3
 Q
 ; Check for validity of label name
LABEL(RGP) ;
 Q $$NAME(.RGP,"L%")
 ; Check for validity of variable/label name
NAME(RGP,RGF) ;
 N RGP1
 S (RGP,RGP1)=$G(RGP,RGPSN),RGF=$G(RGF)
 I RGF["$",$E(RGM,RGP)="$" S RGP=RGP+1
 I RGF["%",$E(RGM,RGP)="%" S RGP=RGP+1
 F RGP=RGP:1 Q:$E(RGM,RGP)'?@$S(RGF["L":"1AN",RGP=RGP1:"1A",1:"1AN")
 S:RGP=RGP1 RGERR=$S(RGF["L":11,1:1)
 Q RGP
 ; Instrinsic function/system variable
INT(RGP,RGL) ;
 N RGP2,RGINT,RGNM
 S RGP=$G(RGP,RGPSN),RGP2=$$NAME(RGP),RGL=$G(RGL)
 Q:RGERR ""
 S RGNM=$E(RGM,RGP,RGP2-1)
 I $E(RGM,RGP2)="(" S:$D(^TMP(RGPID,"FCN",RGNM)) RGINT=^(RGNM)
 E  S:$D(^TMP(RGPID,"SYS",RGNM)) RGINT=^(RGNM)
 I '$D(RGINT),RGO["Z" S RGINT=";0-999"
 I '$D(RGINT) S RGERR=7
 E  I RGL'="",$TR(RGL,$P(RGINT,";"))=RGL S RGERR=2,RGINT=""
 E  S RGP=RGP2
 Q $G(RGINT)
 ; Check next character
NEXT(RGC,RGI) ;
 I RGPSN'>RGLEN,RGC[$E(RGM,RGPSN) S RGPSN=RGPSN+$G(RGI,1)
 Q $T
