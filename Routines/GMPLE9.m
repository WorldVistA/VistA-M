GMPLE9 ; ISL - Problem List Env Chk for GMPL*2*9  ;10/10/96  11:01
 ;;2.0;Problem List;**9**;Aug 25,1994
 ;
 ;
E9 N Y S Y=$$VERSION^XPDUTL("LEX") W !!,"Patch GMPL*2*9 corrects Problem List routine GMPLUTL1 exported with the",!,"Lexicon Utility v 2.0"
 I +Y'>1 W !!,"    Could not find Lexicon Utility v 2.0.  This patch should only be ",!,"    installed at sites using version 2.0 of the Lexicon Utility",! S XPDQUIT=1 Q
 I +Y>1,'$D(^LEX(757.01,0)) W !!,"    Lexicon Utility v 2.0 installed without data global.  Please install",!,"    the Lexicon data global exported in HF LEX_2_0.GBL then restart ",!,"    this installation.",! S XPDQUIT=2 Q
 I +Y>1 W !!,"    Lexicon Utility v ",Y," installed --> Ok",!
 Q
