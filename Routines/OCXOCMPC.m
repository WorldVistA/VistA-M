OCXOCMPC ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Optimize a Boolean Expression) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 Q
 ;
OPTMIZ(OCXD0,OCXEXP) ;
 ;
 Q 0
 N OCXRES,OCXSTAK,OCXPTR,OCXFLST,OCXTKN,OCXERR,OCXTEXP,OCXDASH,OCXBOOL,OCXPTKN,OCXX
 ;
 S OCXEXP=$$PARCNT(OCXEXP) Q:'$L(OCXEXP) OCXWARN Q:OCXWARN OCXWARN
 ;
 S OCXEXP=$TR(OCXEXP,"~","")
 ;
 S OCXEXP=$$STRIP(OCXEXP)
 ;
 I 0 W ! S OCXOP="" F OCXPTR=1:1:$L(OCXEXP," ") D
 .F  Q:'(+$$TOP)  Q:'($$TOP=$$TOP(2))  S OCXX=$$POP,OCXX=$$POP D DISP
 .;
 .I (+$P(OCXEXP," ",OCXPTR)) D PUSH(+$P(OCXEXP," ",OCXPTR)) D DISP Q
 .;
 .I ($P(OCXEXP," ",OCXPTR)="(") D PUSH("(") S OCXOP="" D DISP Q
 .;
 .I ($P(OCXEXP," ",OCXPTR)=")") D  S OCXOP="" D DISP Q
 ..N SUB,POP S SUB="" F  S POP=$$POP Q:'$L(POP)  Q:(POP="(")  S:$L(SUB) SUB=" "_SUB S SUB=POP_SUB
 ..D PUSH($$TOKEN(SUB))
 .;
 .I '$L(OCXOP) S OCXOP=$P(OCXEXP," ",OCXPTR) D PUSH(OCXOP) D DISP Q
 .;
 .I '(OCXOP=$P(OCXEXP," ",OCXPTR)) D  D DISP Q
 ..N SUB,POP S SUB="" F  S POP=$$POP Q:'$L(POP)  Q:(POP="(")  S:$L(SUB) SUB=" "_SUB S SUB=POP_SUB
 ..D PUSH("(")
 ..D PUSH($$TOKEN(SUB))
 ..S OCXOP=$P(OCXEXP," ",OCXPTR)
 ..D PUSH(OCXOP)
 .;
 .D PUSH($P(OCXEXP," ",OCXPTR)) D DISP Q
 ;
 S OCXEXP=$$EXPAND(OCXEXP)
 ;
 Q 0_U_$TR(OCXEXP," ","")
 ;
DISP ;
 Q:$G(OCXAUTO)
 W !,$P(OCXEXP," ",1,OCXPTR),!
 Q
TOKEN(VAL) ;
 ;
 Q:($L(VAL," ")=1) VAL
 N ORD,OPER,PTR
 S OPER=$P(VAL," ",2)
 F PTR=1:2:$L(VAL," ") S ORD($P(VAL," ",PTR))=""
 S VAL="",PTR=0 F  S PTR=$O(ORD(PTR)) Q:'PTR  S:$L(VAL) VAL=VAL_" "_OPER_" " S VAL=VAL_PTR
 ;
 S PTR=+$G(^TMP("OCXCMP",$J,"B TOKEN","B",VAL)) Q:PTR PTR
 ;
 F PTR=$O(^OCXS(860.3,999999),-1)+1:1 Q:'$D(^TMP("OCXCMP",$J,"B TOKEN",+PTR))
 S ^TMP("OCXCMP",$J,"B TOKEN",+PTR)=VAL
 S ^TMP("OCXCMP",$J,"B TOKEN","B",VAL)=+PTR
 Q +PTR
 ;
PUSH(V) S OCXSTAK($O(OCXSTAK(99999),-1)+1)=V Q
 ;
POP() N L,V S L=$O(OCXSTAK(99999),-1) Q:'L "" S V=OCXSTAK(L) K OCXSTAK(L) Q V
 ;
TOP(C) ;
 Q:'$D(OCXSTAK) "" Q:'$D(C) OCXSTAK($O(OCXSTAK(999999),-1))
 N L,X S L=$O(OCXSTAK(99999),-1) Q:'L "" F X=1:1:C S L=$O(OCXSTAK(L),-1) Q:'L
 Q:'L "" Q OCXSTAK(L)
 K C
 ;
STRIP(EXP) ;
 ;
 N QUIT,PTR
 F  S QUIT=1 D  Q:QUIT
 .F PTR=1:1:($L(EXP," ")-2) I ($P(EXP," ",PTR)="("),(+$P(EXP," ",PTR+1)),($P(EXP," ",PTR+2)=")") S QUIT=0 D  Q
 ..I (PTR>1) S EXP=$P(EXP," ",1,PTR-1)_" "_(+$P(EXP," ",PTR+1))_" "_$P(EXP," ",PTR+3,99999) Q
 ..S EXP=(+$P(EXP," ",PTR+1))_" "_$P(EXP," ",PTR+3,99999)
 Q EXP
 ;
PARCNT(EXP) ;
 N CNT,PTR,TEMP
 S CNT=0,TEMP="" F PTR=1:1:$L(EXP) D
 .N CHAR S CHAR=$E(EXP,PTR)
 .I (CHAR="(") S CNT=CNT+1,TEMP=TEMP_" ( "
 .E  I (CHAR=")") S CNT=CNT-1,TEMP=TEMP_" ) "
 .E  I '(CHAR=" "),'(CHAR="~"),(CHAR?1P) S TEMP=TEMP_" "_CHAR_" "
 .E  S TEMP=TEMP_CHAR
 I CNT D  Q ""
 .N MSG
 .S MSG(1)=" "_EXP,MSG(2)=" "
 .I (CNT>0) S MSG(3)=" "_(CNT)_" Unmatched LEFT '(' parenthesis in expression"
 .I (CNT<0) S MSG(3)=" "_(CNT*(-1))_" Unmatched RIGHT ')' parenthesis in expression"
 .D WARN^OCXOCMPV(.MSG,2,OCXD0,$P($T(+1)," ",1)) Q
 ;
 F  Q:'(TEMP["  ")  S TEMP=$P(TEMP,"  ",1)_" "_$P(TEMP,"  ",2,999)
 F  Q:'($E(TEMP,1)=" ")  S TEMP=$E(TEMP,2,$L(TEMP))
 Q TEMP
 ;
EXPAND(EXP) ;
 ;
 N QUIT,PTR
 F PTR=1:1:$L(EXP," ") S:+$P(EXP," ",PTR) $P(EXP," ",PTR)="~"_$P(EXP," ",PTR)_"~"
 F  Q:'(EXP["~")  S EXP=$P(EXP,"~",1)_$G(^TMP("OCXCMP",$J,"B TOKEN",+$P(EXP,"~",2)))_$P(EXP,"~",3,999)
 Q EXP
 ;
