XPAREDT2 ; SLC/KCM - Supporting Calls - Instances, Values ;04/08/2003  11:22
 ;;7.3;TOOLKIT;**26,35,52,74**;Apr 25, 1995
 ;
EDIT1 ; called only from EDIT, expects ENT,PAR,INST to be defined
 N VALTYPE,X S VALTYPE=$E($G(^XTV(8989.51,+PAR,1)))
 I VALTYPE="W" D  I ERR W $$ERR Q
 . D GETWP^XPAR(.X,ENT,+PAR,$P(INST,U),.ERR) S:'ERR $P(X,U,2)=$G(X)
 I VALTYPE'="W" D
 . S X=$$GET^XPAR(ENT,+PAR,$P(INST,U),"B")
 . I $L(X),$E(^XTV(8989.51,+PAR,1))="P" S X="`"_X
 S Y="" D EDITVAL(.Y,+PAR,"V",.X) Q:(Y="")!($E(Y)=U)
 I Y="@" D DEL^XPAR(ENT,+PAR,$P(INST,U),.ERR) D  Q
 . I ERR W $$ERR Q
 . W "  ...deleted"
 ; I VALTYPE'="W" W "   ",$P(Y,U,2)
 S Y=$P(Y,U)
 D EN^XPAR(ENT,+PAR,$P(INST,U),.Y,.ERR) I ERR W $$ERR Q
 Q
EDITVAL(DTA,PAR,TYP,DFLT) ; edit the value for an instance or a value
 ;  .DTA=internal value^external value returned, wp in DTA(n,0) nodes
 ;   PAR=parameter which describes the data being edited
 ;   TYP=edit type - I:instance, V:value, S:select instance
 ; .DFLT=internal default value^external default value
 ;       internal values are preceded by "`" if they are pointers
 N DIR,SUB,TERM,WP,X
 S SUB=$S(TYP="V":0,1:5),Y=""
 S DIR(0)=$P($G(^XTV(8989.51,+PAR,SUB+1)),U,1,2)
 S $P(DIR(0),U,1)=$P(DIR(0),U,1)_"OA"
 I "P"=$E(DIR(0)) S $P(DIR(0),":",2)="AEMQZ"
 I $L($G(^XTV(8989.51,+PAR,SUB+2))) S $P(DIR(0),U,3)=^(SUB+2)
 I $L($G(^XTV(8989.51,+PAR,SUB+3))) S DIR("S")=^(SUB+3)
 I (TYP="I")!(TYP="S") S TERM=$P($G(^XTV(8989.51,+PAR,0)),U,4)
 I TYP="V" S TERM=$P($G(^XTV(8989.51,+PAR,0)),U,5)
 I '$L(TERM) S TERM=$S(TYP="V":"Value",1:"Instance")
 S DIR("A")=$S(TYP="S":"Select ",1:"")_TERM_": "
 I $L($G(DFLT)) S DIR("B")=$P(DFLT,U,2)
 I $L($P($G(^XTV(8989.51,+PAR,SUB+1)),U,3)) S DIR("?")=$P(^(SUB+1),U,3)
 I TYP="S" S DIR("?")="^D SHWINST^XPAREDT2(ENT,PAR,20,1)"
 S DIR("??")="^D SHWDESC^XPAREDT2(PAR)"
 I $E(DIR(0))="W" D
 . S $P(DIR(0),U,1)="FOA",WP=1
 . K ^TMP($J,"XPARWP") M ^TMP($J,"XPARWP")=DFLT
 I $E(DIR(0))="S" S $P(DIR(0),U,1)=$P(DIR(0),U,1)_"M"
 ; PDIR simulates call to DIR, returning X & Y
 D PDIR S DTA("X")=X,DTA=Y S:$D(DTOUT)!$D(DUOUT) DTA=""
 I $D(DTOUT)!$D(DUOUT)!("@"[DTA) Q
 I $E(DIR(0))="P" S DTA="`"_+Y_U_$P(Y(0),U,1)
 I "SDY"[$E(DIR(0)) S DTA=Y_U_$P(Y(0),U,1)
 I '$L($P(DTA,U,2)) S $P(DTA,U,2)=$P(DTA,U)
 I '$D(DIRUT),$G(WP) D  ; edit the word processing field
 . N DIWESUB,DIC,Y
 . S DIWESUB=$P(DTA,U,2),DIC="^TMP($J,""XPARWP"","
 . D EN^DIWE
 . S I=0 F  S I=$O(^TMP($J,"XPARWP",I)) Q:'I  S DTA(I,0)=^(I,0)
 Q
PDIR ; call DIR if not pointer type, otherwise call DIC
 N DIC S X=""
 I $E(DIR(0))'="P" D ^DIR S:X="@" Y="@" Q
 F  D  I $D(DTOUT)!$D(DUOUT)!($L(Y))!('$L(X)) Q
 . S DIC=+$P(DIR(0),U,2),DIC(0)="EMQZ"
 . S:$D(DIR("S")) DIC("S")=DIR("S")
 . W !,DIR("A")_$S($D(DIR("B")):DIR("B")_"// ",1:"")
 . R X:DTIME S:'$T DTOUT="" S:$E(X)=U DUOUT="" S:X="@" Y="@"
 . I '$L(X),$L($G(DFLT)) S X=$P(DFLT,U) ;"`"_+DFLT
 . I X="?",$L($P($G(DIR("?")),U,2)) X $P(DIR("?"),U,2,999)
 . I $D(INSTLST),$L(X),($E(X)'="`") D  ; match existing instance
 . . N I S I=0
 . . F  S I=$O(INSTLST(I)) Q:'I  I $E($P(INSTLST(I),U),1,$L(X))=X D  Q
 . . . W $E($P(INSTLST(I),U),$L(X)+1,999)
 . . . S X=$P(INSTLST(I),U)
 . Q:$D(DTOUT)!$D(DUOUT)!(Y="@")!('$L(X))
 . D ^DIC K DIC("S") I Y<0 S Y=""
 Q
SHWINST(ENT,PAR,CNT,SCR,LST) ; list CNT instances of an entity/parameter
 N I,TERM,ERR,DIR,DIRUT,DUOUT,DTOUT,X,Y,LC,RC,RCPOS
 S TERM=$P($G(^XTV(8989.51,+PAR,0)),U,4) I '$L(TERM) S TERM="Instance"
 D GETLST^XPAR(.LST,ENT,PAR,"E",.ERR) I ERR W $$ERR Q
 I 'LST W !!,"There are currently no entries for ",TERM,".",! Q
 I LST>CNT,'$G(SCR) W !!,LST," entries for ",TERM," currently exist.",! Q
 S LC=$L(TERM),RC=$L("Value")
 S I=0
 F  S I=$O(LST(I)) Q:'I  D
 . I $L($P(LST(I),U,1))>LC S LC=$L($P(LST(I),U,1))
 . I $L($P(LST(I),U,2))>RC S RC=$L($P(LST(I),U,2))
 I LC+RC>77 D
 . I LC>38,RC<38 S LC=77-RC Q
 . I LC<38,RC>38 S RC=77-LC Q
 . S LC=38,RC=39
 S RCPOS=LC+2
 W !!,TERM,?RCPOS,"Value",!,$$DASH^XPAREDIT($L(TERM)),?RCPOS,"-----",!
 S I=0 F  S I=$O(LST(I)) Q:'I  D  Q:$D(DUOUT)
 . W $E($P(LST(I),U,1),1,LC),?RCPOS,$E($P(LST(I),U,2),1,RC),!
 . I I#CNT=0,$O(LST(I)) S DIR(0)="E" D ^DIR W !
 Q
SELINST(INST,ENT,PAR) ; select a specific instance from multiple parameter
 ; .INST=external value of instance
 N TERM,ERR,DIR
 S TERM=$P($G(^XTV(8989.51,+PAR,0)),U,4) S:'$L(TERM) TERM="Instance"
 S INST="" D EDITVAL(.INST,+PAR,"S") Q:'$L(INST)!($E(INST)=U)
 I $P(INST,U)=" " D
 . S INST=$G(^DISV(DUZ,"XPAR01",+PAR,ENT)) S:INST="" INST=" "
 I '$L($$GET^XPAR(ENT,PAR,$P(INST,U))) D  ; if instance does not exist
 . S DIR(0)="Y",DIR("B")="Yes"            ; verify adding new one
 . S DIR("A")="Are you adding "_$P(INST,U,2)_" as a new "_TERM
 . D ^DIR I $D(DIRUT)!('Y) S INST="" Q
 . ; D ADD^XPAR(ENT,+PAR,INST,"",.ERR) I ERR W $$ERR S INST=""
 ; DIR doesn't return space, so spacebar recall only works with Free
 I $L(INST),$E($G(^XTV(8989.51,+PAR,6)))="F" D
 . S ^DISV(DUZ,"XPAR01",+PAR,ENT)=$P(INST,U,2)
 Q
SHWDESC(PAR) ; show description of parameter
 Q:'PAR  S I=0 F  S I=$O(^XTV(8989.51,PAR,20,I)) Q:'I  W !,^(I,0)
 Q
ERR() ; function - displays error message, expects ERR to be present
 W !!,">>>  ",$P($G(ERR),U,2),!!
 Q ""
