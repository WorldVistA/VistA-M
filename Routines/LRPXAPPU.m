LRPXAPPU ;SLC/STAFF - Test Lab APIs Utilities ;1/29/04  14:35
 ;;5.2;LAB SERVICE;**295**;Sep 27, 1994
 ;
 ; This routine is used along with LRPXAPP for testing Lab APIs.
 ;
DISPLAY ; from LRPXAPP
 ; displays results stored in a TMP global
 N NUM,NUM1
 W ! S NUM=""
 F  S NUM=$O(^TMP("LRPXAPP",$J,NUM)) Q:NUM=""  D
 . I $D(^TMP("LRPXAPP",$J,NUM))#2 W !,^(NUM) Q
 . S NUM1=""
 . F  S NUM1=$O(^TMP("LRPXAPP",$J,NUM,NUM1)) Q:NUM1=""  W !,NUM,",",NUM1
 K ^TMP("LRPXAPP",$J)
 Q
 ;
GETTYPE(TYPE,ERR) ; from LRPXAPP
 ; asks for type of data (C, M, A), returned as TYPE
 N DIR,DIRUT,DTOUT,X,Y K DIR
 S ERR=0,TYPE=""
 S DIR(0)="SAO^C:CHEMISTRY;M:MICROBIOLOGY;A:ANATOMIC PATHOLOGY"
 S DIR("A")="Type of data -- C M A : "
 S DIR("B")="C"
 D ^DIR K DIR
 I Y[U!$D(DTOUT) S ERR=1 Q
 S TYPE=Y
 W !
 Q
 ;
GETPT(DFN,ERR) ; from LRPXAPP
 ; asks for a patient, returns DFN
 N DIC,X,Y K DIC,Y
 S ERR=0
 S DIC=2,DIC(0)="AEMOQZ"
 D ^DIC I Y<1 S ERR=-1
 S DFN=+Y
 W !
 Q
 ;
GETCOND(COND,TYPE,ERR) ; from LRPXAPI6,LRPXAPP
 ; asks for a conditional expression, returned as COND
 N DIR,DIRUT,DTOUT,X,Y K DIR
 S TYPE=$G(TYPE,"C")
 S ERR=0,COND=""
 S DIR(0)="FAO^^I '$$CONDOK^LRPXAPIU(X,TYPE) K X"
 S DIR("A")="Condition: "
 D ^DIR K DIR
 I Y[U!$D(DTOUT) S ERR=1 Q
 S COND=Y
 W !
 Q
 ;
GETDATE(FROM,TO,ERR) ; from LRPXAPP
 ; asks for a date range
 ; FROM return as oldest date selection, TO as most recent
 N DIR,DIRUT,DTOUT,X,Y K DIR
 S (FROM,TO,ERR)=0
 S DIR(0)="DAO^2900101:DT:EX"
 S DIR("A")="From: "
 D ^DIR K DIR
 I Y[U!$D(DTOUT) S ERR=1 Q
 I '$L(Y) S (FROM,TO)="" Q
 S FROM=Y
 ;
 N DIR,X,Y K DIR
 S DIR(0)="DAO^2900101:DT:EX"
 S DIR("A")="To: "
 D ^DIR K DIR
 I $D(DIRUT) S FROM=0,ERR=-1 Q
 S TO=Y D DATES^LRPXAPIU(.FROM,.TO)
 W !
 Q
 ;
GETTEST(TEST,TYPE,ERR) ; from LRPXAPP
 ; asks for a lab test, returned as TEST
 N DIC,X,Y K DIC
 S ERR=0
 S DIC=60,DIC(0)="AEMOQ"
 S TYPE=$G(TYPE,"C") D
 . I TYPE="C" S DIC("S")="I $P(^(0),U,4)=""CH"""
 . I TYPE="M" S DIC("S")="I $P(^(0),U,4)=""MI"""
 . I TYPE="A" S DIC("S")="I ""CYEMSPAU""[$P(^(0),U,4),$L($P(^(0),U,4))"
 D ^DIC I Y<1 S ERR=-1
 S TEST=+Y
 W !
 Q
 ;
GETAP(CODE,ERR) ; from LRPXAPP
 ; asks for an AP item, returned as CODE
 N FILE,DIC,DIR,DIRUT,DTOUT,X,Y K DIC,DIR
 S ERR=0,CODE=""
 S DIR(0)="SA^S:SPEC;T:TEST;O:ORGAN;D:DISEASE;M:MORPH;E:ETIOLOGY;F:FUNC;P:PROC;I:ICD"
 S DIR("A")="Type of code -- S T O D M E F P I: "
 D ^DIR K DIR
 I Y[U!$D(DTOUT) S ERR=1 Q
 S FILE=Y
 I FILE="S" D  Q  ; specimen is free text
 . N DIR,DIRUT,DTOUT,X,Y K DIR
 . S DIR(0)="FAO^^"
 . S DIR("A")="Specimen (free text): "
 . D ^DIR K DIR
 . I Y[U!$D(DTOUT) S ERR=1 Q
 . S CODE="A;S;1."_$$UP^XLFSTR(Y)
 D  I Y<1!$D(DTOUT) S ERR=1 Q
 . S DIC(0)="AEMOQ"
 . I FILE="T" D GETTEST(.Y,"A",.ERR) Q
 . I FILE="O" S DIC=61 D ^DIC Q
 . I FILE="D" S DIC=61.4 D ^DIC Q
 . I FILE="M" S DIC=61.1 D ^DIC Q
 . I FILE="E" S DIC=61.2 D ^DIC Q
 . I FILE="F" S DIC=61.3 D ^DIC Q
 . I FILE="P" S DIC=61.5 D ^DIC Q
 . I FILE="I" S DIC=80 D ^DIC Q
 S CODE="A;"_FILE_";"_+Y
 W !
 Q
 ;
GETMICRO(CODE,ERR) ; from LRPXAPP
 ; asks for a Micro item, returned as CODE
 N FILE,DIC,DIR,DIRUT,DTOUT,X,Y K DIC,DIR
 S ERR=0,CODE=""
 S DIR(0)="SA^S:SPEC;T:TEST;O:ORGANISM;A:ANTIMICROBIAL;M:MYCOBACTERIA DRUG"
 S DIR("A")="Type of code -- S T O A M : "
 D ^DIR K DIR
 I Y[U!$D(DTOUT) S ERR=1 Q
 S FILE=Y
 S DIC(0)="AEMOQ"
 D  I Y<1!$D(DTOUT) S ERR=1 Q
 . I FILE="T" D GETTEST(.Y,"M",.ERR) Q
 . I FILE="S" S DIC=61 D ^DIC Q
 . I FILE="O" S DIC=61.2 D ^DIC Q
 . I FILE="A" S DIC=62.06 D ^DIC Q
 . I FILE="M" D  Q
 .. S DIC="^DD(63.39," D ^DIC ; dbia 999
 .. I '$$TBDN^LRPXAPIU(+Y) S Y=-1 Q
 S CODE="M;"_FILE_";"_+Y
 W !
 Q
