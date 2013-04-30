LA7VLCM ;DALOI/JDB - LAB CODE MAPPING FILE UTILITIES ;03/07/12  09:46
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
PS ;
 ; Called from OPTION LA7V 62.47 PRINT SUSC
 ; Print #62.47 Susc
 D E1^LA7VLCM6
 Q
 ;
PL ;
 ; Called from OPTION LA7V 62.47 PRINT LOCAL
 ; Print #62.47 local codes
 D E2^LA7VLCM6
 Q
 ;
PMC ;
 ; Called from OPTION LA7V 62.47 PRINT BY MSG CONFIG
 ; Print by Msg Config
 D E1^LA7VLCM2
 Q
 ;
CMC ;
 ; Called from OPTION LA7V 62.47 CLONE MSG CONFIG
 ; Clone a Message Configuration
 D CLONE^LA7VLCM3
 Q
 ;
CSM ;
 ; Called from OPTION LA7V 62.47 PRINT CS MISMATCHES
 ; Code Set Mismatches
 D E2^LA7VLCM2
 Q
 ;
FI ;
 ; Called from OPTION LA7V 62.47 FIND IDENTIFIER
 ; Find Identifier
 D E1^LA7VLCM4
 Q
 ;
DOD6247 ;
 ; Called from option LA7V 62.47 ADD DOD
 D DOD6247^LA7VLCM7
 Q
 ;
MAPABS ;
 ; Called from option LA7V 62.47 MAP SUSCS
 D MAPABS^LA7VLCM7
 Q
 ;
ES ;
 ; Called from OPTION LA7V 62.47 EDIT SUSC
 ; Edit Susceptibility
 ; Allow user to select either BACT or MYCO Susceptibility concept.
 ; Within identifier multiple allow selection of identifiers that
 ; are:
 ;  LOINC or (Non LOINC and local (national standard=no))
 ;    and Purpose is RESULT CODE.
 ;  Allow editing of field #2.1 Related entry - must be selectable
 ;    only from file #62.06 (ANTIMICROBIAL SUSCEPTIBILITY)
 ;  If local code then field #2.2 for specific related message
 ;    configuration (local codes are interface specific).
 ;
 N DIC,LROUT,D,DA,DIE,DR,LOCK,I,LALOCK
 S LROUT=0
 F  D  Q:LROUT  ;
 . K DIC,Y
 . S LROUT=0
 . S DIC=62.47
 . S DIC(0)="AEMQ"
 . S DIC("S")="I +Y=7!(+Y=21)"
 . D ^DIC
 . K DIC
 . S:Y'>0 LROUT=1
 . Q:LROUT
 . N LROUT
 . K DA,DIC,DIE,DR,LOCK,I,D
 . S LROUT=0
 . S DA(1)=+Y
 . F  D  Q:LROUT  W ! ;
 . . S DIC="^LAB(62.47,"_DA(1)_",1,"
 . . S DIC(0)="AEQBCV"
 . . S DIC("S")="N LRZ,LRCS,LRP,LRSTD S LRZ=$G(^LAB(62.47,DA(1),1,+Y,0)) S LRCS=$P(LRZ,""^"",2) S LRP=$P(LRZ,""^"",3) S LRSTD=$P(LRZ,""^"",5) I LRP=1 I LRCS=""LN""!(LRCS'=""LN""&(LRSTD=0))"
 . . S D="B"
 . . D MIX^DIC1
 . . K DIC
 . . S:Y'>0 LROUT=1
 . . Q:LROUT
 . . S DA=+Y
 . . S LOCK=0
 . . S LALOCK=$NA(^LAB(62.47,DA(1),1,DA))
 . . S LOCK=$$GETLOCK^LRUTIL(LALOCK,10,1)
 . . I 'LOCK D  Q  ;
 . . . W !,"Could not lock File #62.47 subfile's entry."
 . . K DIC,Y
 . . S DIE="^LAB(62.47,"_DA(1)_",1,"
 . . K DIC("V")
 . . S DIE("NO^")="OUTOK"
 . . S DR="S DIC(""V"")=""I +Y(0)=62.06"";W ""  "",$$LNFSN^LA7VLCM(DA(1),DA);2.1;K DIC(""V"");I $P($G(^LAB(62.47,DA(1),1,DA,0)),""^"",5)=0 S Y=2.2;"
 . . D ^DIE
 . . L -@LALOCK
 . ;
 Q
 ;
AEL ;
 ; Called from OPTION LA7V 62.47 LOCAL IDENTIFIER
 ; Add/Edit Local Codes
 ; Allow selection of any concept.
 ; Local entries to be added at an internal entry number >1000000
 ;   with the IDENTIFIER multiple.
 ; Within identifier multiple allow selection and/or addition of
 ;   non-standard code.
 ; When adding entry field .05 NATIONAL STANDARD will be set to NO
 ; Edit fields:
 ;   .01 -- IDENTIFIER
 ;   .02 -- CODING SYSTEM (only allow selection of "L" and "99xxx"
 ;          when non-standard)
 ;   .03 -- PURPOSE
 ;   2.1 -- RELATED ENTRY
 ;   2.2 -- RELATED MESSAGE CONFIGURATION
 ;
 N I,DIC,DIE,X,D,DR,DA,DINUM,DLAYGO,DIDEL,NEXTID,LOCK
 N LROUT,R6247,LALOCK
 ; Ask concept
 F  D  Q:LROUT  ;
 . S LROUT=0
 . K DIC,Y
 . S DIC=62.47
 . S DIC(0)="AEMQ"
 . D ^DIC
 . S:Y'>0 LROUT=1
 . Q:LROUT
 . N LROUT
 . K DIC,DIE,X,D,DR,DA,DINUM,DLAYGO,DIDEL,NEXTID,LOCK
 . S LOCK=0
 . S R6247=+Y
 . S LALOCK=$NA(^LAB(62.47,R6247))
 . S LOCK=$$GETLOCK^LRUTIL(LALOCK,10,1)
 . I 'LOCK D  Q  ;
 . . W !,"Could not lock #62.47 file."
 . F  D  Q:LROUT  ;
 . . K D,DIC,Y,DIE,DINUM,DIDEL,DLAYGO
 . . S DA(1)=R6247
 . . S LROUT=0
 . . ;; Find or add new entry
 . . S DIC="^LAB(62.47,"_DA(1)_",1,"
 . . S DIC(0)="ABELQV"
 . . S DIC("S")="I $P($G(^LAB(62.47,DA(1),1,+Y,0)),""^"",5)'=1"
 . . S DLAYGO=62.4701
 . . S D="B^"
 . . D MIX^DIC1
 . . K DIC
 . . I Y'>0 D  Q  ;
 . . . L -@LALOCK ;^LAB(62.47,DA(1))
 . . . S LROUT=1
 . . S DA=+Y
 . . K DIE,Y,DINUM
 . . S DIE="^LAB(62.47,"_DA(1)_",1,"
 . . S DIE("NO^")="OUTOK"
 . . S DIDEL=62.4701
 . . S DR=".01;.05////0;.02;.03;.04;2.1;2.2"
 . . D ^DIE
 . . W !
 . L -@LALOCK ;-^LAB(62.47,DA(1))
 . W !
 Q
 ;
LNFSN(R6247,R624701) ;
 ; Returns the LOINC FSN for specified entry
 ; Inputs
 ;   R6247 : File #62.47 IEN
 ; R624701 : Subfile #62.4701 IEN
 ; Output
 ;  Null or the LOINC code's Fully Specified Name (FSN)
 N X,CODE,SYS,FSN
 S FSN=""
 S X=$G(^LAB(62.47,R6247,1,R624701,0))
 S CODE=$P(X,"^",1)
 S SYS=$P(X,"^",2)
 I SYS="LN" D  ;
 . S FSN=$$LOINCFSN^LA7VLCM1(CODE)
 Q FSN
