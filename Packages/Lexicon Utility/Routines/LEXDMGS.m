LEXDMGS ;ISL/KER - Defaults - Manager/Search Threshold ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIE                ICR  10018
 ;               
 Q
EN ;
 W !!," Coding System Search Threshold Edit",!
 W !," This is the default number of records that should be inspected"
 W !," during a search before the user is prompted to either continue"
 W !," or refine the search.  The search threshold is set for a coding"
 W !," system.  The use of this default parameter is optional.",!
 N LEXCS,LEXN,LEXNM,LEXO,X,Y
 S LEXCS=$$CS I +LEXCS'>0 W !!,"   Coding System not selected" Q
 S LEXNM=$P($G(^LEX(757.03,+LEXCS,0)),"^",2)
 S LEXO=$P($G(^LEX(757.03,+LEXCS,2)),"^",2) D ST(LEXCS)
 S LEXN=$P($G(^LEX(757.03,+LEXCS,2)),"^",2)
 I '$L(LEXO),+LEXN>0 W !!,"   Search Threshold added" W:$L(LEXNM) " for ",LEXNM W ! Q
 I +LEXO>0,+LEXN>0,LEXN'=LEXO W !!,"   Search Threshold changed" W:$L(LEXNM) " for ",LEXNM W ! Q
 I $L(LEXO),'$L(LEXN) W !!,"   Search Threshold deleted" W:$L(LEXNM) " for ",LEXNM W ! Q
 I $L(LEXO)=$L(LEXN) W !!,"   Search Threshold no change made" W:$L(LEXNM) " for ",LEXNM W ! Q
 Q
ST(X) ; Edit Search Threshold
 N DIE,DA,DIC,DR
 S DIE="^LEX(757.03,",DA=+($G(X)) Q:'$D(^LEX(757.03,+DA,0))
 S DIE("A")=" SEARCH THRESHOLD: "
 S DR="12//20000" W ! D ^DIE
 Q
CS(X) ; Coding System
 N DIC,DTOUT,DUOUT
 S DIC="^LEX(757.03,",DIC("A")=" Select a Coding System:  ",DIC(0)="AEQM"
 S DIC("W")="W ?29,""  "",$P($G(^LEX(757.03,+Y,0)),""^"",2),?51,$S($L($P($G(^LEX(757.03,+Y,2)),""^"",2)):"" THRESHOLD:"",1:""""),$J($P($G(^LEX(757.03,+Y,2)),""^"",2),7)"
 D ^DIC
 Q Y
 W !,"W ?51,$S($L($P($G(^LEX(757.03,+Y,2)),""^"",2)):"" THRESHOLD:"",1:""""),$J($P($G(^LEX(757.03,+Y,2)),""^"",2),7)"
 W ?51,$S($L($P($G(^LEX(757.03,+Y,2)),"^",2)):" THRESHOLD:",1:""),$J($P($G(^LEX(757.03,+Y,2)),"^",2),7)
 W ?51," THRESHOLD:",$J($P($G(^LEX(757.03,+Y,2)),"^",2),7)
