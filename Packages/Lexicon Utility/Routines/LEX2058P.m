LEX2058P ;ISL/FJF - Pre/Post Install ; 16 Sep 2011  11:45 AM
 ;;2.0;LEXICON UTILITY;**58**;Sep 23, 1996;Build 53
 ;
 ; External References
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA  2052  $$GET1^DID
 ;   DBIA  2055  PRD^DILFD
 ;   DBIA 10014  EN^DIU2
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                      
 Q
 ;
POST ; LEX*2.0*58 Post-Install
 ;
 ;-----------------------------
 ;   Rebuild indices
 D IND
 ;
 ;-----------------------------
 ;   Send a Install Message
 D MSG
 ;
 Q
 ;-----------------------------
 ;
 ;
IND ; Rebuild indices
 ; Rebuild indices for 757.33
 N DIK
 D BMES^XPDUTL("Rebuilding indices")
 D BMES^XPDUTL("")
 S DIK="^LEX(757.33," D IXALL2^DIK,IXALL^DIK
 D BMES^XPDUTL("Index rebuild complete")
 Q
MSG ; Send Installation Message to G.LEXICON
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2058($G(DUZ)))
 D HOME^%ZIS
 N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXSHORT
 S LEXSHORT=1
 D IMP^LEX2058,POST^LEXXFI
 Q
