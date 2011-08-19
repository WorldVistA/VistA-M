YSPROB4 ;SLC/DKG-PROBLEM LIST CHANGE ROUTINES ;1/16/90  08:59 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ENIN ; Called from MENU option YSIPROB
 ;
 D ^YSLRP G:YSDFN<1 FIN D H S M1="IN" G CS
 ;
ENRA ; Called from MENU option YSRAPROB
 D ^YSLRP G:YSDFN<1 FIN D H S M1="RA" G CS
 ;
ENRS ; Called from MENU option YSRSPROB
 D ^YSLRP G:YSDFN<1 FIN D H S M1="RS" G CS
 ;
ENRF ; Called from MENU option YSRFPROB
 D ^YSLRP G:YSDFN<1 FIN D H
 ;
ENRF1 ;
 S M1="RF" G CS
H ;
 K Y D ENDTM^YSUTL S P4="PL",YSTOUT=0 S YSEND=$O(^YS(615,YSDFN,P4,0)) K:'YSEND ^YS(615,YSDFN,P4)
 Q
CS ;
 I '$D(^YS(615,YSDFN,P4)) W !!?3,"No 'Problem List' entries exist for this patient.",!,$C(7) G FIN
 D A1 I YSTOUT!YSUOUT G FIN
 K YSPTD,%DT,X,Y S DA(1)=YSDFN,DIC="^YS(615,YSDFN,P4,",DIC(0)="AEQMNZ" W ! D ^DIC G:Y'>0 FIN D CK G:A2 FIN
 S DIC("NO^")=1,DA(1)=YSDFN,(DA,N5)=+Y,X=M1,DIE("NO^")=1,DIE="^YS(615,YSDFN,P4,",DR="8///"_YSDTM
 S DR(2,615.03)=".01///"_YSDTM_";1///"_X_";I X]""RF"" S Y=4;2;S R=X;4///^S X=""`""_DUZ" L +^YS(615,YSDFN) D ^DIE L -^YS(615,YSDFN) S YSTOUT=$D(DTOUT)
 K DIE("NO^") Q:YSTOUT  D:$D(R) ^YSPROB3
 S N6=$P(^DIC(620,N5,0),U),S6=$S(M1="IN":"INACTIVATED",M1="RA":"REACTIVATED",M1="RS":"RESOLVED",M1="RF":"REFORMULATED",1:"")
 W !!?3,N6," has been ",S6,!
FIN ;
 D KVAR^VADPT G FIN^YSPROB1
A1 ;
 R !!?3,"Do you want to see problems already on the list? N// ",A4:DTIME S YSTOUT='$T,YSUOUT=A4["^" Q:YSTOUT!YSUOUT  S:A4="" A4="N"
 I "YyNn"'[$E(A4) W !?3,$C(7),"Type 'Y' or 'N'." G A1
 Q:"Yy"'[A4  S N2=0 W !
 ;
LS ; Called by routine YSPROB, YSPROB3
 F  S N2=$O(^YS(615,YSDFN,P4,N2)) Q:'N2  W !?3,N2,?7,$P(^DIC(620,N2,0),U) D FS W ?50,S5 K L3,S5
 Q
 ;
FS ;
 S L3=$P(^($P(^YS(615,YSDFN,P4,N2,2,0),U,3),0),U,2),S5=$S(L3="AC":"   ACTIVE",L3="IN":"  INACTIVE",L3="RA":"REACTIVATED",L3="RF":"REFORMULATED",L3="RS":"  RESOLVED",1:"")
 Q
CK ;
 S N2=+Y,N3=$P(^DIC(620,N2,0),U),A2="" D FS
 I L3=M1 W $C(7),!!?2,N3," is already ",$S(L3="IN":"INACTIVE! ",L3="RA":"REACTIVATED! ",L3="RS":"RESOLVED! ",L3="RF":"REFORMULATED! ",1:"CHANGED! ") S A2=1 Q
 I L3="RF",M1="IN" W $C(7),!!?2,N3," has been REFORMULATED!",!!?2,"It is not necessary to INACTIVATE a REFORMULATED problem!" S A2=1 Q
 I L3="RS",M1="IN" W $C(7),!!?2,N3," has been RESOLVED!",!!?2,"It is not necessary to INACTIVATE a RESOLVED problem! " S A2=1 Q
 I L3="RF",M1'="RF" W $C(7),!!?2,N3," has been REFORMULATED!"
CK1 ;
 I L3="RF",M1'="RF" D MSG W $S(M1="RA":"REACTIVATE ",M1="RS":"RESOLVE ",1:"CHANGE "),"it? " R " NO// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" S:A="" A="N" S:YSTOUT!YSUOUT!("Nn^"[A) A2=1 Q:"Yy"[A!A2  W:A'["?" " ?",$C(7) G CK1
 I M1="RA",L3="AC" W $C(7),!!?2,N3," is already active! " S A2=1 Q
 I L3="RS",M1'="RS" W $C(7),!!?2,N3," has been RESOLVED!"
CK2 ;
 I L3="RS",M1'="RS" D MSG W $S(M1="RA":"REACTIVATE ",M1="RF":"REFORMULATE ",1:"CHANGE "),"it? " R "N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" S:A="" A="N" S:YSTOUT!YSUOUT!("Nn^"[A) A2=1 Q:"Yy"[A!A2  W:A'["?" " ?",$C(7) G CK2
 I L3="IN",M1="RS"!(M1="RF") W $C(7),!!?2,N3," is INACTIVE!"
CK3 ;
 I L3="IN",M1="RS"!(M1="RF") D MSG W $S(M1="RS":"RESOLVE ",M1="RF":"REFORMULATE ",1:"CHANGE "),"it? " R " N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" S:A="" A="N" S:YSTOUT!YSUOUT!("Nn^"[A) A2=1 Q:"Yy"[A!A2  W:A'["?" " ?",$C(7) G CK3
 Q
MSG W !!?2,"Are you sure you want to "
 Q
