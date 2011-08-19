XTLKEFOP ; ALB/JLU ISC,IHS/OHPRD/ACC,SFISC/JC - EDIT FREQUENTLY USED OP NARR, SHORTCUT ;03/01/95  15:31
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;
C ;GETS THE CODE FROM THE NECESSARY FILE.
 W ! S DIC("A")="Which code in the "_$P(^DIC(+XTLKY,0),U)_" file?: ",DIC(0)="AEMQ",DIC=^DIC(+XTLKY,0,"GL") D ^DIC I Y<1 K DIC Q
C1 S XTLKCOD=+Y_";"_$P(DIC,U,2),XTLKCOD1=$P(Y,U,2)
 K DIC Q
 ;
QU(XTLKF) ;Deciding on which file proc/diag Etc.
 ;XTLKF=filename (optional)
 W !!
 I $G(XTLKF)="" S DIC("A")=$S($D(XTLKOPP):"Print "_XTLKOPP_" for ",$D(XTLKOP):"Additions/Modifications to ",1:"Lookup on ")_$S($D(XTLKOP):XTLKOP_" in ",1:"")_"which file?: ",DIC(0)="AEMQ",DIC="^XT(8984.4," D ^DIC K DIC Q:Y<1
 I $G(XTLKF)'="" S X=XTLKF,DIC=8984.4,DIC(0)="MQZ" D ^DIC K DIC I Y<1 W "...",XTLKF," not found in local lookup file." Q
 S XTLKY=Y,XTLKPF=+$O(^DD(8984.2,.02,"V","B",+Y,"")) G:'XTLKPF KL
 S XTLKPF=$P(^DD(8984.2,.02,"V",XTLKPF,0),U,4),XTLKUT=1
 Q
 ;
KL ;Exit line.
 K XTLKY,XTLKPF,XTLKGL,XTLKUT,DIC,DIE,DR,JL,DA,DIR,X,Y,XTLKCOD,XTLKCOD1,XTLKOP Q
 ;
 ;Editing synonym file.
SY D QU() I Y<1 D KL Q
SY1 ;
 W ! S (DIC,DIE)="^XT(8984.3,",DIC(0)="AELMQ",DIC("DR")="[XTLK EDIT SYN]",DIC("S")="I $P(^(0),U,2)="_+XTLKY,DLAYGO="8984.3" D ^DIC K DLAYGO,DIC("S") I Y<1 G SY
 I '$P(Y,U,3) S DA=+Y,DR="[XTLK EDIT SYN]" D ^DIE
 K DIC,DIE,DA,DR,Y
 G SY1
 ;
 ;Editing keyword file.
KE D QU() I Y<1 D KL Q
 D C I Y<1 D KL Q
KE1 R !,"Select LOCAL KEYWORD NAME: ",X:DTIME I '$T!(X[U)!(X="") D KL G KE Q
 I X["?" D HL G KE1
 W ! S (DIE,DIC)="^XT(8984.1,",DIC(0)="EILMQ",DIC("DR")="[XTLK EDIT KEY]",DIC("S")="I $P(^(0),U,2)[JL&($P(^(0),U,3)[XTLKCOD1)",JL=$P(^DIC(+XTLKY,0,"GL"),U,2),DLAYGO="8984.1" D ^DIC K DLAYGO,DIC("S") G:Y<1 KE1
 I '$P(Y,U,3) S DA=+Y,DR="[XTLK EDIT KEY]" D ^DIE
 K DIE,DIC
 G KE1
 ;
 ;Editing shortcut file.
SH D QU() I Y<1 D KL Q
SH1 ;
 W ! S (DIE,DIC)="^XT(8984.2,",DIC(0)="AELMQ",DIC("DR")="[XTLK EDIT SHORT]",DIC("S")="I $P(^(0),U,2)[JL",JL=$P(^DIC(+XTLKY,0,"GL"),U,2),DLAYGO="8984.2" D ^DIC K DLAYGO,DIC("S") G:Y<1 SH
 I '$P(Y,U,3) S DA=+Y,DR="[XTLK EDIT SHORT]" D ^DIE
 K DIE,DIC
 G SH1
 ;
LL ;Interactive Entry point to edit Local Lookup File.
 D LL1 Q:$G(Y)=-1!($D(DTOUT))!($D(DUOUT))
 D LL2
 D LL3
 K XTLKPRE,DIC,DIE,DA,Y,DR,JL0,JLY,XTLKLP
 Q
 ;
LL1 ;
 S (DIE,DIC)="^XT(8984.4,",DIC(0)="EALMQZ" D ^DIC K DIC
 Q:Y=-1!($D(DTOUT))!($D(DUOUT))
 ;S X=$P(Y,U,2),(DIE,DIC)="^XT(8984.4,",DIC(0)="ELMQZ",DIC("DR")="[XTLK EDIT LOOKUP]" D ^DIC
 S JL0=Y(0,0),JLY=+Y
 S DIE("NO^")="",DA=+Y,DR="[XTLK EDIT LOOKUP]" D ^DIE
 Q:$D(DTOUT)
 ;I '$P(Y,U,3) S DA=+Y,DR="[XTLK EDIT LOOKUP]" D ^DIE Q
 W !!,"...Ok, will now setup KEYWORD and SHORTCUT file DD's"
 W !,"   to allow terms for '",JL0,"' entries..."
 Q
LL2 ;
 S XTLKPRE=$G(XTLKPRE)
 F XTLKLP=8984.1,8984.2 D
 .S (DIE,DIC)="^DD("_XTLKLP_",.02,""V"",",DIC(0)="L",X=+JLY,DA(1)=.02,DA(2)=XTLKLP D ^DIC K DIC Q:Y=-1  D S,^DIE
 Q
LL3 ;
 ;S ^DD(JLY,0,"DIC")="XTLKDICL"
 W !,"<REMINDER> Using 'Edit File', set the lookup routine, XTLKDICL, in ",JL0," DD."
 K XTLKPRE,DIC,DIE,DA,Y G LL1
 Q
 ;
S S DA=+Y,DR=".02////"_JL0_";.03////"_DA_";.05////n;.06////n;.04"_$S(XTLKPRE="":"",1:"////"_XTLKPRE)_";S XTLKPRE=X"
 Q
 ;Entry point to delete from 8984.4 and the variable pts in 8984.1,8984.2
DD D DD1
 K DIC,DIE,DR,DIR,XTLKY,XTLKLP,DIK,DA,JL0
 Q
 ;
DD1 S DIC="^XT(8984.4,",DIC(0)="AEMQZ" D ^DIC Q:Y<1  W !,$C(7)
 S (XTLKY,DA)=+Y,JL0=Y(0,0),DIR(0)="Y",DIR("A")="Are you sure you want to delete "_Y(0,0) D ^DIR Q:Y<1
 S XTLKJG=$P(^DIC(+XTLKY,0,"GL"),U,2)
 I $D(^XT(8984.2,"AC",XTLKJG))!($D(^XT(8984.3,"AC",XTLKJG)))!($D(^XT(8984.1,"AD",+XTLKY))) W $C(7),!!,"There are still Keywords, Shortcuts and/or Synonyms for this entry.",!,"     <<Nothing Deleted!>>" Q
 W !!,"Deleting from Local Lookup file....."
 S DIK="^XT(8984.4," D ^DIK
 W !,"Deleting variable pointers from Local Keyword and Shortcut files."
 F XTLKLP=8984.1,8984.2 S DIK="^DD("_XTLKLP_",.02,""V"",",DA(1)=.02,DA(2)=XTLKLP,DA=$O(@($NA(^DD(XTLKLP,.02,"V","B",+XTLKY,0)))) D ^DIK
 W !,"<REMINDER> Delete the lookup routine, XTLKDICL, from ",JL0," DD."
 ;K ^DD(XTLKY,0,"DIC")
 Q
 ;HELP ENTRY POINT
HL W !,"ANSWER WITH LOCAL KEYWORD NAME, OR CODE",!,"CHOOSE FROM:"
 S (XTLKC,XTLKF)=0
 F LP=0:0 S LP=$O(^XT(8984.1,"C",XTLKCOD1_" ",LP)) Q:'LP  D WR Q:XTLKF
 K LP,XTLKC,XTLKF Q
WR I XTLKC>(IOSL-4) S DIR(0)="E" D ^DIR I 'Y S XTLKF=1 Q
 Q:'$D(^XT(8984.1,LP,0))  W !,$P(^(0),U),"    ",$P(^(0),U,3)
 Q
