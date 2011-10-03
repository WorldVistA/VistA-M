LEXILG ; ISL Env/Post for ^LEX and ^GMP           ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
PRE ; Pre-Init
 ; Save User Defaults
 S U="^" W !,"Saving Lexicon v 1.0 User Defaults",! D:$D(^GMPT) SD^LEXILGU
 ; Remove Lexicon from MTLU
 W !,"Removing Lexicon v 1.0 from the Multi-Term Look-up Utility (MTLU)",!
 D EN^LEXILGX
 ; Save Lexicon Pointers
 W !,"Saving Lexicon v 1.0 Pointers",!
 D SP^LEXILGP
 ; Rename Lexicon Options
 W !,"Renaming Lexicon v 1.0 Options",!
 D:$O(^DIC(19,"B","GMPT "))["GMPT" RE^LEXILGO
 ; Delete Lexicon v 1.0 DDs
 W !!,"Deleting Lexicon v 1.0 Data Dictionaries",!
 D:$D(^DD(757)) DD^LEXILGD
 Q
POST ; Post-Init
 ; Restore User Defaults
 W !!,"Restoring Lexicon User Defaults for use with Lexicon v 2.0",!
 S U="^" D RD^LEXILGU,DF^LEXILGU
 ; Repoint to ^LEX
 W !,"Repointing Files/Fields for use with Lexicon v 2.0",!
 D:$D(^TMP("LEXPT")) PL^LEXILGP,DP^LEXILGP
 ; Check for GMPT Package file entry
 W !!,"Checking for GMPT Package file entry (not used in Lexicon v 2.0)",!
 D:$D(^DIC(9.4,"C","GMPT")) DG^LEXILGO
 ; Check for ^GMP or ^GMPT
 W !,"Checking for ^GMP or ^GMPT (not used in Lexicon v 2.0)",!
 D DG^LEXILGD
 I $D(IOST),IOST["C-" N LEXPOST W !,"  Press <Return> to continue   " R LEXPOST:660
 ; Mail
 D EN2^LEXLGM,EN^LEXPL
 Q
