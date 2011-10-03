XPAREDT3 ;SLC/KCM - Parameter Templates
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
SELTED ; select template then edit
 N DIC,Y
 S DIC=8989.52,DIC(0)="AEMQ" D ^DIC Q:Y<0
 D TED^XPAREDIT(+Y,"BA")
 Q
TED ; come here from TED^XPAREDIT(TLT,SHWFLG,ALLENT)
 ; edit templates - suppress display of dashed header for each value
 N NOHDR S NOHDR=""
TEDH ; come here from TEDH^XPAREDIT(TLT,SHWFLG,ALLENT)
 ; Edits parameters using a template
 ; TLT: name of a template in (or pointer to) PARAMETER TEMPLATE file
 N ALLINST,ENT,SEQ,IEN,PAR,TLTJMP,DIRUT,DTOUT,DUOUT
 I 'TLT S TLT=$O(^XTV(8989.52,"B",TLT,0))
 I 'TLT W !!,$C(7),"Parameter template not found.",! Q
 I '$L($G(ALLENT)) D SELENT(.ALLENT,TLT) Q:$D(DTOUT)!$D(DUOUT)
 D SELINST(.ALLINST,ALLENT,TLT) Q:$D(DTOUT)!$D(DUOUT)
 I $G(SHWFLG)["B" D SHWTLT(ALLENT,ALLINST,TLT)
 ; set up ref array for ^jumping
 S (SEQ,CNT)=0 F  S SEQ=$O(^XTV(8989.52,TLT,10,"B",SEQ)) Q:'SEQ  D
 . S IEN=0 F  S IEN=$O(^XTV(8989.52,TLT,10,"B",SEQ,IEN)) Q:'IEN  D
 . . S PAR=$P(^XTV(8989.52,TLT,10,IEN,0),U,2),X=^XTV(8989.51,PAR,0)
 . . S CNT=CNT+1,TLTJMP(CNT)=PAR_U_$P(X,U,2)_U_$P(X,U,5)
 . . I $L($P(X,U,5)) S TLTJMP("B",$$UP^XLFSTR($P(X,U,5)),CNT)="" I 1
 . . E  I $L($P(X,U,2)) S TLTJMP("B",$$UP^XLFSTR($P(X,U,2)),CNT)=""
 S SEQ=0 F  S SEQ=$O(TLTJMP(SEQ)) Q:'SEQ  D  Q:$D(DTOUT)!$D(DUOUT)
 . S PAR=$P(TLTJMP(SEQ),U,1,2)
 . S ENT=ALLENT
 . I 'ENT D GETENT^XPAREDIT(.ENT,PAR) I 'ENT S DUOUT="" Q
 . I ENT D TEDIT^XPAREDIT(ENT,PAR,ALLINST,.VAL)
 . I $E(VAL)=U D
 . . S X=$$UP^XLFSTR($E(VAL,2,$L(VAL)-1)_$C($A($E(VAL,$L(VAL))-1)))
 . . S X=$O(TLTJMP("B",X)) I $L(X) S SEQ=$O(TLTJMP("B",X,0))-.1
 I $G(SHWFLG)["A" D SHWTLT(ALLENT,ALLINST,TLT,1) S DIR(0)="E" D ^DIR
 Q
SELENT(ENT,TLT) ; Select an entity for use with the template
 ; .ENT: Returns the selected entity or null
 ;  TLT: passed in pointer to the parameter template file
 N FN S FN=$P(^XTV(8989.52,TLT,0),U,3),ENT="" Q:'FN
 ; begin case FN
 I FN=9.4 D  G XC1           ; get package pointer for this template
 . N PKG,NAM
 . S NAM=$P(^XTV(8989.52,TLT,0),U),PKG=NAM
 . F  S PKG=$O(^DIC(9.4,"C",PKG),-1) Q:$E(NAM,1,$L(PKG))=PKG
 . S PKG=$O(^DIC(9.4,"C",PKG,0))
 . I PKG S ENT=PKG_";DIC(9.4,"
 I FN=4.2 D  G XC1           ; get domain pointer
 . I '$D(XPARSYS) S XPARSYS=$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE"))_";DIC(4.2,"
 . S ENT=XPARSYS
 I FN=4   D  G:ENT XC1       ; get division pointer
 . N DIV S DIV=$$KSP^XUPARAM("INST")
 . I $$GET1^DIQ(4,DIV_",",5,"I")'="Y" S ENT=DIV_";DIC(4,"
 D LOOKUP^XPAREDIT(.ENT,FN)  ; otherwise, lookup entity
XC1 ; end case FN
 I 'ENT S DUOUT=""          ; no entity selected, treat as "^"
 Q
SELINST(INST,ENT,TLT) ; Display instances & select from list, or add new
 S INST="" N PAR,INSTLST Q:'ENT
 S PAR=$P(^XTV(8989.52,TLT,0),U,4) Q:'PAR
 D GETLST^XPAR(.INSTLST,ENT,PAR,"E")
 ;D SHWINST^XPAREDT2(ENT,PAR,20,0,.INSTLST)
 D SELINST^XPAREDT2(.INST,ENT,PAR)
 I INST="" S DUOUT=""
 Q
SHWTLT(ENT,INST,TLT,AFT) ; Display all values for a template
 Q:'ENT
 N X,SEQ,CNT,IEN,PAR,LST,LF,I
 S X=$P(^XTV(8989.52,TLT,0),U,2)_$$ENTDISP^XPAREDIT(ENT)
 I $L(INST) S X=X_", "_$P(INST,U,2)
 I $G(AFT) S X=X_" is now:"
 W !!,X,!,$$DASH^XPAREDIT(78),!
 I $E(INST)="`" S INST=$E(INST,2,999)
 S (SEQ,CNT)=0 F  S SEQ=$O(^XTV(8989.52,TLT,10,"B",SEQ)) Q:'SEQ  D
 . S IEN=0 F  S IEN=$O(^XTV(8989.52,TLT,10,"B",SEQ,IEN)) Q:'IEN  D
 . . S PAR=$P(^XTV(8989.52,TLT,10,IEN,0),U,2),X=^XTV(8989.51,PAR,0)
 . . W $P(X,U,2)
 . . I $P(X,U,3) D          ; multi-valued
 . . . D GETLST^XPAR(.LST,ENT,PAR,"B") S LF=0
 . . . S I=0 F  S I=$O(LST(I)) Q:'I  I (LST(I,"N")=INST)!('$L(INST)) D
 . . . . W ?29," ",$P(LST(I,"N"),U,2),?49," ",$P(LST(I,"V"),U,2),!
 . . . . S LF=1
 . . . I 'LF W !
 . . E  D                   ; single-valued
 . . . W ?49," ",$$GET^XPAR(ENT,PAR,1,"E"),!
 W $$DASH^XPAREDIT(78)
 Q
