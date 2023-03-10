VPRHST1 ;SLC/KCM,MKB - Display XML object ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8,25,27**;Sep 01, 2011;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
XML(OBJ) ; -- display XML OBJect in hierarchy, returns DONE if ^
 N XSTRING,ORSTK,ORNXT,ORCNT K DONE,QUIT
 S XSTRING=$G(OBJ) Q:'$L(XSTRING)
 S ORSTK=-1,ORCNT=0 D OPEN
 ;
 F  S ORNXT=$E(XSTRING,1,2) D @$S(ORNXT="</":"CLOSE",ORNXT?1"<"1.A.E:"OPEN",1:"XDATA") Q:XSTRING=""  Q:$G(DONE)
 Q
 ;
OPEN ; -- opening tag
 N TAG S TAG=$P(XSTRING,">")_">",XSTRING=$E(XSTRING,$L(TAG)+1,999999999)
 S ORCNT=ORCNT+1 I ORCNT>(IOSL-4) D READ Q:$G(DONE)  S ORCNT=1
 S ORSTK=ORSTK+1 W !,?((ORSTK*2)),TAG
 Q
 ;
XDATA ; -- data + closing tag
 N DATA,TAG
 S DATA=$P(XSTRING,"</") W DATA
 S XSTRING=$E(XSTRING,$L(DATA)+1,999999999)
 S TAG=$P(XSTRING,">")_">" W TAG
 S XSTRING=$E(XSTRING,$L(TAG)+1,999999999),ORSTK=ORSTK-1
 Q
 ;
CLOSE ; -- closing tag, pop stack
 N TAG S TAG=$P(XSTRING,">")_">",XSTRING=$E(XSTRING,$L(TAG)+1,999999999)
 S ORCNT=ORCNT+1 I ORCNT>(IOSL-4) D READ Q:$G(DONE)  S ORCNT=1
 W !,?((ORSTK*2)),TAG S ORSTK=ORSTK-1
 Q
 ;
READ ; -- continue?
 N X K DONE,QUIT
R1 W !!,"Press <return> to continue or ^ to exit item ..." R X:DTIME
 I X["?" W !,"Enter ^ to skip the rest of this item, or ^^ to exit the option." G R1
 S:X["^" DONE=1 S:X["^^" QUIT=1
 Q
 ;
JSON(OBJ) ; -- display JSON OBJect in hierarchy, returns DONE if ^
 N XSTRING,ORSTK,ORNXT,ORCNT
 S XSTRING=$G(OBJ) Q:'$L(XSTRING)
 S ORSTK=-1,ORCNT=0
 ;
 F  D TAG S ORNXT=$E(XSTRING) D @$S(ORNXT="{":"BRACE",ORNXT="[":"LIST",1:"JDATA") Q:XSTRING=""  Q:$G(DONE)
 Q
 ;
TAG ; -- display tag
 N TAG S TAG=$P(XSTRING,":")_":",XSTRING=$E(XSTRING,$L(TAG)+1,999999999)
 S ORCNT=ORCNT+1 I ORCNT>(IOSL-4) D READ Q:$G(DONE)  S ORCNT=1
 S ORSTK=ORSTK+1 W !,?((ORSTK*2)),TAG
 Q
 ;
BRACE ; -- braces
 W "{"
 S XSTRING=$E(XSTRING,2,999999999)
 Q
 ;
LIST ; -- list
 W "["
 S XSTRING=$E(XSTRING,2,999999999)
 ; ??
 Q
 ;
JDATA ; -- display value, pop stack
 N X,I S X=$P(XSTRING,", ")
 S:$E(XSTRING,$L(X)+1,$L(X)+2)=", " X=X_", "
 S XSTRING=$E(XSTRING,$L(X)+1,999999999)
 W X S ORSTK=ORSTK-1
 ; pop stack one more time for every closing brace
 F I=1:1:$L(X) I $E(X,I)="}" S ORSTK=ORSTK-1
 Q
