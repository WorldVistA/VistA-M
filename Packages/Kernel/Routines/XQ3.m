XQ3 ;LL/THM,SF/GJL,SEA/JLI - CLEANUP DANGLING POINTERS IN OPTION OR HELP FRAME FILES ;12/08/09
 ;;8.0;KERNEL;**80,501,538**;Jul 10, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
ENASK ;Ask to fix up dirty OPTION/HELP FRAME File
 N IX,XUT,J,K,XQFL,X
 I '$D(%) W !,$C(7),"ENTRY MUST BE WITH THE VARIABLE '%' SET TO INDICATE DESIRED FILE.",$C(7),! Q
 S XQFL=$S(%=1:"OPTION",%=2:"PROTOCOL",1:"HELP FRAME")
 W !,"Do you want to remove any 'Dangling Pointers' from your ",XQFL," File?  Y// " R X:$S($D(DTIME):DTIME,1:300) I '$T Q
 W ! I X="" S X="Y"
 I X["?" G SYNTAX
 I X["^" S X="^" Q
STRIP I X'="",X'?1A.E S X=$E(X,2,256) G STRIP
 S X=$E(X,1) I X="" G SYNTAX
 I "Nn"[X S X="N" Q
 I "Yy"[X W !,"PLEASE WAIT while I check this out . . . " G REMOVE
SYNTAX W ! I X'["?" W ?11,"I'm sorry, but I don't understand your answer. Please"
 W !,"Enter: YES (or press the RETURN key) if you want me to remove from"
 W !,?11,"your ",XQFL," File any pointers left over from incompletely"
 W !,?11,"deleted ",XQFL,". If such pointers do exist and are not"
 W !,?11,"removed, the ",XQFL," File (i.e. the menus) could become"
 W !,?11,"messed up by an INIT."
 W !!,"Enter:  NO or ^ to continue on without effecting the ",XQFL," File."
 W ! G ENASK
REMOVE D:%=1 OPFIX D:%=2 PFIX D:'% HFFIX W !,"Your ",XQFL," File is OK " I 'XUT W "(no bad pointers)."
 E  W "now (",XUT," pointer" W:XUT>1 "s" W " fixed)."
 W ! S X="Y"
 Q
OPFIX ;Kill any dangling pointers in the OPTION File (#19)
 N %,IX,J,XQ3
 S (IX,XUT)=0 ;XUT=Total Deletions
 F  S IX=$O(^DIC(19,IX)) Q:'IX  W:'(IX#100) ". " S (XQ3,J)=0 D L2 ;Loop through Options
 D NPF
 Q
L2 ;One Option
 I '$D(^DIC(19,IX,10,0)) Q  ;Not a Menu
 K ^DIC(19,IX,10,"B") ;Rebuild "B" X-ref
 F  S J=$O(^DIC(19,IX,10,J)) Q:'J  D ITEM ;Loop through menu items
 S (K,J)=0 F  S J=$O(^DIC(19,IX,10,J)) Q:J'>0  S K=J ;K=Last item
 S J=^DIC(19,IX,10,0),^(0)=$P(J,"^",1,2)_"^"_K_"^"_XQ3 ;fix counters
 Q
 ;
ITEM ;One Menu item
 N DA,DIK
 S K=+^DIC(19,IX,10,J,0)
 I $D(^DIC(19,K,0)) S XQ3=XQ3+1,^DIC(19,IX,10,"B",K,J)="" Q  ;Y=No. of items
 W !,"Option ",$P(^DIC(19,IX,0),U,1)," points to missing option ",K
 ;S XUT=XUT+1 K ^DIC(19,IX,10,J) ;Kill invalid menu item
 S XUT=XUT+1,DIK="^DIC(19,DA(1),10,",DA=J,DA(1)=IX D ^DIK ;Trigger Menu-rebuild
 Q
 ;
NPF ;Fix the New Person File Option Pointers
 N IX,I2,J,P,DIK,DIE,DR,DA,XUT
 S (XUT,IX)=0
 F  S IX=$O(^VA(200,IX)) Q:'IX  D
 . S P=+$G(^VA(200,IX,201))
 . I P,'$D(^DIC(19,P,0)) D
 . . W !,"User: ",$P(^VA(200,IX,0),U),", Primary Menu points to missing option ",P
 . . S XUT=XUT+1,DIE="^VA(200,",DA=IX,DR="201///@" D ^DIE
 . . Q
 . S I2=0
 . F  S I2=$O(^VA(200,IX,203,I2)) Q:'I2  D
 . . S P=+$G(^VA(200,IX,203,I2,0))
 . . I P,'$D(^DIC(19,P,0)) D
 . . . W !,"User: ",$P(^VA(200,IX,0),U),", Secondary Menu points to missing option ",P
 . . . S XUT=XUT+1,DIK="^VA(200,DA(1),203,",DA=I2,DA(1)=IX D ^DIK
 . . . Q
 . . Q
 . S I2=0
 . F  S I2=$O(^VA(200,IX,19.5,I2)) Q:'I2  D
 . . S P=+$G(^VA(200,IX,19.5,I2,0))
 . . I P,'$D(^DIC(19,P,0)) D
 . . . W !,"User: ",$P(^VA(200,IX,0),U),", Delegated option points to missing option ",P
 . . . S XUT=XUT+1,DIK="^VA(200,DA(1),19.5,",DA=I2,DA(1)=IX D ^DIK
 . . . Q
 . . Q
 . Q
 I XUT W !,"Menu pointers fixed."
 Q
HFFIX ; Fix dangling pointers on help frame file
 N %
 S (XUT,IX)=0 F  S IX=$O(^DIC(9.2,IX)) Q:IX'>0  I $D(^(IX,2)) D HF1,HF2,HF3
 Q
HF1 S (Y,J)=0 F  S J=$O(^DIC(9.2,IX,2,J)) Q:J'>0  I $D(^(J,0)) S K=$P(^(0),U,2),Y=Y+1 I $L(K),'$D(^DIC(9.2,K)) S Y=Y-1,XUT=XUT+1 K ^DIC(9.2,IX,2,J,0)
 Q
HF2 S (K,J)=0 F  S J=$O(^DIC(9.2,IX,2,J)) Q:J'>0  S K=J
 S J=^DIC(9.2,IX,2,0),^(0)=$P(J,U,1,2)_U_K_U_Y
 Q
HF3 S K=":" F  S K=$O(^DIC(9.2,IX,2,K)) Q:K=""  S J=-1 F  S J=$O(^DIC(9.2,IX,2,K,J)) Q:J=""  D HF4
 Q
HF4 S JJ=0 F  S JJ=$O(^DIC(9.2,IX,2,K,J,JJ)) Q:JJ'>0  I '$D(^DIC(9.2,IX,2,JJ,0)) K ^DIC(9.2,IX,2,K,J,JJ)
 Q
PFIX ;Kill any dangling pointers in the PROTOCOL File (#101)
 N %
 S (IX,XUT)=0 ;XUT=Total Deletions
P1 S IX=$O(^ORD(101,IX)) I IX>0 S (Y,J)=0 G P2 ;Loop through protocols
 Q
P2 S J=$O(^ORD(101,IX,10,J)) I J>0 G PITEM ;Loop through items
 I '$D(^ORD(101,IX,10,0)) G P1
 S (K,J)=0 F L=1:1 S J=$O(^ORD(101,IX,10,J)) Q:J'>0  S K=J ;K=Last item
 S J=^ORD(101,IX,10,0),^(0)=$P(J,"^",1,2)_"^"_K_"^"_Y ;fix counters
 G PXREFS
PITEM S K=+^ORD(101,IX,10,J,0) I $D(^ORD(101,K,0)) S Y=Y+1 G P2 ;Y=No. of items
 W !,"Protocol ",$P(^ORD(101,IX,0),U,1)," points to missing protocol ",K
 ;S XUT=XUT+1 K ^ORD(101,IX,10,J) ;Kill invalid menu item
 S XUT=XUT+1,DIK="^ORD(101,IX,10,",DA=J,DA(1)=IX D ^DIK ;Delete invalid menu item
 G P2
PXREFS S K=":"
P3 S K=$O(^ORD(101,IX,10,K)) I K="" G P1 ;Loop through cross references
 S L=-1
P4 S L=$O(^ORD(101,IX,10,K,L)) I L="" G P3
 S J=0
P5 S J=$O(^ORD(101,IX,10,K,L,J)) I J'>0 G P4
 I '$D(^ORD(101,IX,10,J,0)) G PKILLXR ;kill xref to invalid item
P6 S M=^ORD(101,IX,10,J,0) I (M=L)!(M[L_"^") G P5
PKILLXR K ^ORD(101,IX,10,K,L,J) I $O(^ORD(101,IX,10,K,L,-1))="" K ^ORD(101,IX,10,K,L)
 G P5
