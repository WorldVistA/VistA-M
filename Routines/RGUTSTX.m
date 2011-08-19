RGUTSTX ;CAIRO/DKM - M syntax analyzer;22-Oct-1998 10:39;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Perform syntactic analysis of a line of M code.
 ; Inputs:
 ;   RGM = M statement(s)
 ;   RGO = Options:
 ;      L = Line label allowed
 ;      . = Dotted syntax allowed
 ;      N = Do not init parsing tables
 ;      D = Do not delete parsing tables
 ;      Z = Process all Z-extensions as valid
 ; Outputs:
 ;   Returns 0 if successfully parsed.  Otherwise returns E^P^M
 ;   where E is an error code (see ERRORS label), P is the
 ;   character position where the error occurred, and M is the
 ;   error message.
 ;=================================================================
ENTRY(RGM,RGO) ;
 N RGPSN,RGLEN,RGERR,RGRN,RGQT,RGF,RGPID,RGCMD
 S RGM=$$UP^XLFSTR(RGM),RGO=$$UP^XLFSTR($G(RGO)),RGPSN=1,RGLEN=$L(RGM),RGERR=0,RGQT="""",RGF=0,RGPID="RGUTSTX"_$J,U="^"
 D LOAD:RGO'["N",PARSE:RGLEN
 K:RGO'["D" ^TMP(RGPID)
 Q $S(RGERR:RGERR_U_$S(RGPSN>RGLEN:RGLEN,1:RGPSN)_U_$S(RGERR<0:$$EC^%ZOSV,1:$P($T(ERRORS+RGERR),";;",2)),1:0)
PARSE N RGZ,RGZ1
 S @$$TRAP^RGZOSF("ERROR^RGUTSTX")
 I RGO["L" D  Q:RGERR
 .S:$E(RGM)'=" " RGPSN=$$LABEL^RGUTSTX0
 .I $$NEXT^RGUTSTX0("("),'$$NEXT^RGUTSTX0(")") D
 ..F RGPSN=RGPSN:1 D  Q:$E(RGM,RGPSN)'=","!RGERR
 ...S RGPSN=$$NAME^RGUTSTX0(RGPSN,"L%")
 ..Q:RGERR
 ..S:'$$NEXT^RGUTSTX0(")") RGERR=3
 .S:" "'[$E(RGM,RGPSN) RGERR=2
 I RGO["." F RGPSN=RGPSN:1:RGLEN+1 Q:". "'[$E(RGM,RGPSN)
 F  Q:RGERR  D SKPSPC Q:";"[$E(RGM,RGPSN)  D
 .S RGCMD=""
 .F RGPSN=RGPSN:1 S RGZ=$E(RGM,RGPSN) Q:RGZ'?1A  S RGCMD=RGCMD_RGZ
 .I RGCMD="" S RGERR=4 Q
 .I $D(^TMP(RGPID,"CMD",RGCMD)) S RGCMD=^(RGCMD)
 .E  I RGO["Z" S RGCMD="PC;OPT;ARGS("":M"")"
 .E  S RGERR=4 Q
 .F RGRN=1:1:$L(RGCMD,";") D CMD^RGUTSTX0($P(RGCMD,";",RGRN)) Q:RGERR!'RGRN
 .I 'RGERR," "'[$E(RGM,RGPSN) S RGERR=2
 .E  S RGPSN=RGPSN+1
 Q
 ; Skip over blanks
SKPSPC F  Q:'$$NEXT^RGUTSTX0(" ")
 Q
 ; Load tables
LOAD N RGZ,RGZ1,RGZ2,RGL
 K ^TMP(RGPID)
 F RGL="CMD","FCN","SYS" D
 .F RGZ=1:1 S RGZ1=$P($T(@RGL+RGZ),";;",2,999) Q:RGZ1=""  D
 ..S RGZ2=$P(RGZ1,";"),RGZ1=$P(RGZ1,";",2,999)
 ..F  Q:RGZ2=""  D
 ...S ^TMP(RGPID,RGL,$P(RGZ2,","))=RGZ1,RGZ2=$P(RGZ2,",",2,999)
 Q
ERROR S RGERR=-1
 Q
CMD ;;*Commands*
 ;;B,BREAK;PC;OPT;ARGS()
 ;;C,CLOSE;PC;ARGS(":M")
 ;;D,DO;PC;OPT;LBL(2)
 ;;E,ELSE;NPC;OPT;ARGS()
 ;;F,FOR;NPC;OPT;FOR
 ;;G,GOTO;PC;LBL(1)
 ;;H,HALT,HANG;PC;OPT;EXP()
 ;;I,IF;NPC;OPT;ARGS()
 ;;J,JOB;PC;LBL(2)
 ;;K,KILL;PC;OPT;KILL
 ;;L,LOCK;PC;OPT;LOCK
 ;;M,MERGE;PC;MERGE
 ;;N,NEW;PC;OPT;NEW
 ;;O,OPEN;PC;ARGS(":M")
 ;;Q,QUIT;PC;OPT;EXP()
 ;;R,READ;PC;READ
 ;;S,SET;PC;SET
 ;;U,USE;PC;ARGS(":M")
 ;;V,VIEW;PC;ARGS(":M")
 ;;W,WRITE;PC;WRITE
 ;;X,XECUTE;PC;ARGS(":")
 ;;ZT,ZTRAP;PC;OPT;EXP()
 ;;ZS,ZSAVE;PC;OPT;EXP()
 ;;ZR,ZREMOVE;PC;OPT;LBL(1)
 ;;ZP,ZPRINT
 ;;
FCN ;;*Intrinsic functions*
 ;;A,ASCII;;1-2
 ;;C,CHAR;;1-999
 ;;D,DATA;;1-1;V
 ;;E,EXTRACT;S;1-3
 ;;F,FIND;;2-3
 ;;FN,FNUMBER;;2-3
 ;;G,GET;;1-2;V
 ;;J,JUSTIFY;;1-3
 ;;L,LENGTH;;1-2
 ;;N,NEXT;;1-2
 ;;NA,NAME;;1-2;V
 ;;O,ORDER;;1-2;V
 ;;P,PIECE;S;2-4
 ;;Q,QUERY;;1-2;V
 ;;R,RANDOM;;1-1
 ;;S,SELECT;:;1-999
 ;;T,TEXT;;1-1;L
 ;;TR,TRANSLATE;;2-3
 ;;V,VIEW;;1-999
 ;;
SYS ;;*System variables*
 ;;D,DEVICE
 ;;ET,ETRAP;SN
 ;;H,HOROLOG
 ;;I,IO
 ;;J,JOB
 ;;K,KEY
 ;;P,PRINCIPAL
 ;;S,STORAGE
 ;;SY,SYSTEM
 ;;T,TEST
 ;;TL,TLEVEL
 ;;TR,TRESTART
 ;;X;S
 ;;Y;S
 ;;ZT,ZTRAP;S
 ;;ZE,ZERROR;S
 ;;
ERRORS ;;*Error messages*
 ;;Bad variable name
 ;;Syntax error
 ;;Unbalanced parentheses
 ;;Unrecognized command
 ;;Postconditional not allowed
 ;;Missing operand
 ;;Unrecognized intrinsic function/variable
 ;;Incorrect number of arguments
 ;;Missing closing quote
 ;;Illegal pattern
 ;;Bad label name
 ;;12
