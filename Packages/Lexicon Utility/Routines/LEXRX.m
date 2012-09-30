LEXRX ;ISL/KER - Re-Index Lexicon ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(               SACC 1.3
 ;    ^LEXT(              SACC 1.3
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;               
 ; Callable Entry Points in this Routine
 ;               
 ;   EN^LEXRX     Task the Repair/Re-Index of one or more Files
 ;   CHECK^LEXRX  Check if a Repair/Re-Index Task is Running
 ;   MON^LEXRX    Monitor Progress of a Running Task
 ;               
EN ; Main Entry Point
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,LEXAC,LEXAMSO,LEXENV
 N LEXFI,LEXFN,LEXMON,LEXOK,LEXRUN,LEXSTA,LEXT,LEXTY,X,Y
 K LEXMON S LEXENV=$$ENV^LEXRXXM Q:'LEXENV
 W !," Repair/Re-Index Lexicon cross-references"
 S LEXRUN=$$CHECK^LEXRXXM2 I +LEXRUN>0 D  Q
 . W "     Try again later",!
 N LEXAMSO,LEXFI,LEXOK S LEXOK=0,LEXAMSO=$$AMSO^LEXRXXA
 I "^A^M^S^O^"'[("^"_LEXAMSO_"^") D  Q
 . W !!,?3,"Lexicon index Repair/Re-Index method not selected, aborting"
 D:"^A^"[("^"_LEXAMSO_"^") ALL D:"^M^"[("^"_LEXAMSO_"^") MAJ
 D:"^S^"[("^"_LEXAMSO_"^") SUP  D:"^O^"[("^"_LEXAMSO_"^") ONE
 Q
 ;               
ALL ;   All Files
 N LEXOK,LEXTY,LEXAMSO K LEXFI S LEXOK=0,LEXAMSO="A"
 W !!," ",$$BOLD^LEXRXXM,"Repair/Re-Index the Cross-References for all Lexicon Files",$$NORM^LEXRXXM,!
 W !,"   The cross-references for the larger files will be repaired and the "
 W !,"   smaller files will be re-indexed.",!
 W !,"   Users may be on the system since the cross-references of the larger"
 W !,"   files are not deleted and the re-indexing of the smaller files does"
 W !,"   not involve the Lexicon look-up."
 S LEXTY=3 S LEXOK=$$CO^LEXRXXA W ! I +LEXOK>0 K LEXFI D ALL^LEXRXXT
 Q
MAJ ;   Major Files
 N LEXOK,LEXTY,LEXAMSO K LEXFI S LEXOK=0,LEXAMSO="M"
 W !!," ",$$BOLD^LEXRXXM,"Repair the Cross-References for the Major Lexicon Files",$$NORM^LEXRXXM,!
 W !,"   The cross-references of the larger files will be repaired by "
 W !,"   verifying the individual subscripts in the cross-reference.  Only"
 W !,"   the entries that fail verification will be deleted.",!
 W !,"   Users may be on the system since the cross-references are not"
 W !,"   deleted."
 S LEXTY=1 S LEXOK=$$CO^LEXRXXA W ! I +LEXOK>0 K LEXFI D MAJ^LEXRXXT
 Q
SUP ;   Supporting Files
 N LEXOK,LEXTY,LEXAMSO K LEXFI S LEXOK=0,LEXAMSO="S"
 W !!," ",$$BOLD^LEXRXXM,"Re-Index the Cross-References for the Supporting Lexicon Files",$$NORM^LEXRXXM,!
 W !,"   The cross-references for the smaller files will be re-indexed.",!
 W !,"   Users may be on the system since the cross-references of the smaller"
 W !,"   files are not involve the Lexicon look-up."
 S LEXTY=3 S LEXOK=$$CO^LEXRXXA W ! I +LEXOK>0 K LEXFI D SUP^LEXRXXT
 Q
ONE ;   One File
 N LEXOK,LEXFI,LEXFN,LEXT,LEXTY,LEXAMSO S LEXAMSO="O",LEXFI=$$FI^LEXRXXA I '$L(LEXFI)!(LEXFI["^") W !!,"   Lexicon file not selected, aborting" Q
 I +($$FV^LEXRXXM(($G(LEXFI))))'>0 W !!,"   Invalid file selected, aborting" Q
 S LEXOK=0,LEXFN=$$FN^LEXRXXM(LEXFI) Q:'$L(LEXFN)
 S LEXT=LEXFI,LEXT=LEXT_$J(" ",(8-$L(LEXT)))_LEXFN S LEXT=LEXFI_" ("_LEXFN_")" W !
 I "^757^757.001^757.01^757.02^757.1^757.21^"[("^"_LEXFI_"^") D
 . S LEXTY=1 W !," ",$$BOLD^LEXRXXM,"Repair Cross-References for file ",LEXT,$$NORM^LEXRXXM,! D
 . . W !,"   The cross-references of file "_+LEXFI_" will be repaired by verifying"
 . . W !,"   the individual subscripts in the cross-reference.  Only the entries"
 . . W !,"   that fail verification will be deleted.  Users may be on the system"
 . . W !,"   since the cross-references are not deleted."
 I "^757^757.001^757.01^757.02^757.1^757.21^"'[("^"_LEXFI_"^") D
 . S LEXTY=2 W !," ",$$BOLD^LEXRXXM,"Re-Index Cross-References for file ",LEXT,$$NORM^LEXRXXM,! D
 . . W !,"   The cross-references of file "_+LEXFI_" will be re-indexed.  Users may"
 . . W !,"   be on the system since this file is not involved in the Lexicon "
 . . W !,"   look-up."
 S LEXOK=$$CO^LEXRXXA W ! I +LEXOK>0,$L($G(LEXFI)) D ONE^LEXRXXT
 Q
 ;
CHECK ; Check if a Repair/Re-Index Task is Running
 N LEXSTA K LEXMON S LEXSTA=$$CHECK^LEXRXXM2
 I +($G(LEXSTA))'>0 W !!,"   Lexicon cross-reference repair is not running",!
 Q
 ;
MON ; Monitor Progress of a Running Task
 N LEXMON S LEXMON="" D MON^LEXRXXM2
 Q
 ;              
 ; Miscellaneous
FORCE ;   Forced Repair/Re-Index
 K ^TMP("LEXRX",$J),^XTMP("LEXRXALL"),^XTMP("LEXRXMAJ"),^XTMP("LEXRXSUP"),^XTMP("LEXRXONE"),^XTMP("LEXRXSET"),^XTMP("LEXRXFIX")
 D CLR,EN
 Q
CLR ;   Clear
 N LEXID K LEXFIX,LEXSET,LEXTEST
 Q
