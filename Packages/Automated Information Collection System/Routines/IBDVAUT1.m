IBDVAUT1 ;ALB/CS/SS - ICD-9 LOOKUP UTILITY ; 06/18/2012
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
EN1(IBDUTVB,IBDAUTNI,IBDUTSTR,IBDUTNALL) ;
FIRST ;
 S DIC(0)="EQMNZI",DIC("A")="Select "_IBDUTSTR_": " K @IBDUTVB S (@IBDUTVB,Y)=0
REDO W !,DIC("A") W:'$D(IBDUTNALL) "ALL// " R X:DTIME G ERR:(X="^")!'$T D:X["?" QQ I X="" G:$D(IBDUTNALL) ERR S @IBDUTVB=1 G QUIT
 S DIC("A")="Select another "_IBDUTSTR_": " D ^DIC G:Y'>0 FIRST D SET
 F IBDAI=1:0:19 W !,DIC("A") R X:DTIME G ERR:(X="^")!'$T K Y Q:X=""  D QQ:X["?" S:$E(X)="-" IBDUTX=X,X=$E(IBDUTX,2,999) D ^DIC I Y>0 D SET G:IBDAX REDO S:'IBDAERR IBDAI=IBDAI+1
 G QUIT
SET ;
 S IBDAX=0
 I $D(IBDUTX) S J=$S(IBDAUTNI=2:+Y,1:$P(Y(0),"^")) K IBDUTX S IBDAERR=$S($D(@IBDUTVB@(J)):0,1:1) D  Q:IBDAERR  S IBDAI=IBDAI-1 K @IBDUTVB@(J) S:$O(@IBDUTVB@(0))']"" IBDAX=1 Q
 . W $S('IBDAERR:"...removed from list...",1:"...not on list...can't remove")
 S IBDAERR=0 I $S($D(@IBDUTVB@($P(Y(0),U))):1,$D(@IBDUTVB@(+Y)):1,1:0) W !?3,*7,"You have already selected that ",IBDUTSTR,".  Try again." S IBDAERR=1
 I IBDAUTNI=1 S @IBDUTVB@($P(Y(0),U))=+Y Q
 I IBDAUTNI=3 S @IBDUTVB@($P(Y(0,0),U))=+Y Q
 S @IBDUTVB@(+Y)=$P(Y(0),U) Q
QQ W !,"ENTER:" W:($D(@(IBDUTVB))=1&'$D(IBDUTNALL)) !?5,"- Return for all ",IBDUTSTR,"s, or" W !?5,"- A ",IBDUTSTR," and return when all ",IBDUTSTR,"s have been selected--limit 20"
 W !?5,"Imprecise selections will yield an additional prompt."
 W !?5,"(e.g. When a user enters 'A', all items beginning with 'A' are displayed.)"
 I $O(@IBDUTVB@(0))]"" W !?5,"- An entry preceded by a minus [-] sign to remove entry from list."
 I $O(@IBDUTVB@(0))]"" W !,"NOTE, you have already selected:" S IBDAJ=0 F IBDAJ1=0:0 S IBDAJ=$O(@IBDUTVB@(IBDAJ)) Q:IBDAJ=""  W !?8,$S(IBDAUTNI=1:IBDAJ,1:@IBDUTVB@(IBDAJ))
 Q
ERR S Y=-1
QUIT S:'$D(Y) Y=1 K DIC,J,IBDAERR,IBDAI,IBDAJ,IBDAJ1,IBDAX,IBDUTNALL,IBDAUTNI,IBDUTSTR,IBDUTVB,X Q
