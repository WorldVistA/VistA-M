TIUMAP2 ; ISL/JER - TIU/VHA Enterprise Document Type Ontology Mapper ;10/20/06  09:28
 ;;1.0;TEXT INTEGRATION UTILITIES;**211**;Jun 20, 1997;Build 26
STRIP(TEXT) ; Remove punctuation & excess white space
 N TIUTI,TIUX
 ; Strip punctuation
 S TEXT=$TR(TEXT,".,!?/|{}[];:=+*^%$#@~`""><","                              ")
 ; Remove TABS
 F TIUTI=1:1:$L(TEXT) S:$A(TEXT,TIUTI)=9 TEXT=$E(TEXT,1,(TIUTI-1))_" "_$E(TEXT,(TIUTI+1),$L(TEXT))
 ; Remove multiple white space
 S TIUX="" F TIUTI=1:1:$L(TEXT," ") S:$A($P(TEXT," ",TIUTI))>0 TIUX=TIUX_$S(TIUTI=1:"",1:" ")_$P(TEXT," ",TIUTI)
 S TEXT=TIUX S:$P(TEXT," ")']"" TEXT=$P(TEXT," ",2,$L(TEXT," "))
 Q TEXT
PAGE(TIULOCAL) ; Handle pagination
 N TIUY S TIUY=1
 Q:$Y'>(IOSL-4) TIUY
 S TIUY=+$$READ^TIUU("E") S:+$G(DIRUT) TIUOUT=1
 I TIUY W @IOF W:$G(TIULOCAL)]"" "Remember, your LOCAL title is: ",$G(TIULOCAL)
 Q TIUY
INACT(TIUDA) ; Inactivate LOCAL title TIUDA
 N DA,DR,DIE,TIUFPRIV S TIUFPRIV=1
 W !!,"Inactivating ",$P($G(^TIU(8925.1,TIUDA,0)),U)
 S DA=TIUDA,DR=".07///INACTIVE",DIE=8925.1 D ^DIE W ".",!
 Q
DIRECT(TIUDA) ; Direct Title Mapping action
 N RESULT,TIUCONT,TIULOCAL,TIUY
 I '+$G(TIUDA) W !,"You must specify a local title." Q
 S TIUCONT=1,TIULOCAL=$P($G(^TIU(8925.1,TIUDA,0)),U)
 W !!,"Direct Mapping to Enterprise Standard Title..."
 W !,"Your LOCAL Title is: ",TIULOCAL,!!,"  NOTE: Only ACTIVE Titles may be selected...",!
 ; Bid for LOCK
 L +^TIU(8925.1,TIUDA,15):1
 E  D  Q
 . W !,$C(7),"Another user is mapping this title...",!
 . W:$$READ^TIUU("E") "" S:+$G(DIRUT) TIUOUT=1
 ; First, check whether the LOCAL Title is already mapped
 I +$G(^TIU(8925.1,+TIUDA,15)) D  Q:RESULT<0!+$G(DIRUT)
 . N TIUY S TIUY=0
 . W !?5,"The LOCAL Title: ",TIULOCAL,!?7,"is already mapped to",!,"VHA Enterprise Title: ",$$LOINCNM^TIUMAP(+$G(^(15))),!
 . S TIUY=$$READ^TIUU("YA","Do you want to RE-MAP it? ","NO")
 . I +TIUY'>0 W $C(7),!,"... OK, No Harm Done!",! S RESULT=-1 H 2
 . E  S RESULT=1 W !
 F  D  Q:+TIUCONT'>0
 . N DIC S DIC=8926.1,DIC(0)="AEMQ",DIC("A")="Select VHA ENTERPRISE STANDARD TITLE: "
 . S DIC("S")="I '$$SCREEN^XTID(8926.1,"""",+Y_"","")"
 . S TIUY=$$ASK^TIUMAP1("",.DIC) I +TIUY>0 S TIUCONT=0 Q
 . W !!,"You didn't select a VHA Enterprise Standard Title...",!
 . S TIUCONT=$$READ^TIUU("Y","... Try to map "_TIULOCAL_" again","NO") W !
 . D:+TIUCONT'>0 LOG^TIUMAP1(TIULOCAL,TIUDA)
 . S:+$G(DIRUT) TIUOUT=1
 Q:+TIUY'>0!+$G(DIRUT)
 S RESULT=+TIUY,RESULT(1)=TIUY_U_TIULOCAL
 D CONFIRM^TIUMAP1(.RESULT,"Yes")
 I +RESULT'>0!+$G(DIRUT) D LOG^TIUMAP1(TIULOCAL,TIUDA) Q
 D POINT^TIUMAP(TIUDA,.RESULT)
 Q
