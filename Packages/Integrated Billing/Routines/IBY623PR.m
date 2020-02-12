IBY623PR ;EDE/JWS - Pre-Installation for IB patch 623 ; 2/28/17 4:33pm
 ;;2.0;INTEGRATED BILLING;**623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN ; entry point
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;
 ;Delete edited entries to insure clean install of new entries
 ;Delete obsolete entries.
DELOF   ; Delete included OF entries
 NEW FILE,DIK,LN,TAG,TAGLN,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," D
 . F TAG="ENT"_FILE,"DEL"_FILE D
 .. F LN=2:1 S TAGLN=TAG_"+"_LN,DATA=$P($T(@TAGLN),";;",2) Q:DATA=""  D
 ... F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ; Example for ENT5, ENT6, ENT7, DEL5, DEL6, and DEL7:
 ;;^195^254^259^269^324^325^
 ; Note:  Must have beginning and ending up-carat
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ;
 ;
ENT5 ; OF entries in file 364.5 to be included
 ;
 ;;^^
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
 ; 1999 - seg 104.2, 2-Rendering Provider qualifier
 ; 1224 - seq 98, 2-Attending Prov Sec ID Qualifier (1)
 ; 2254 - seq 32, 2-Payer Responsibility Sequence
 ; 1973 - seq 52, 5-Attachment Control Number
 ;
ENT6 ; O.F. entries in file 364.6 to be included
 ;
 ;;^1999^1224^2254^1973^
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
 ;   68 - CL1.7 - Release of Information Code
 ;  816 - MIA2.2 - Payer Responsibility Sequence # Code
 ;
ENT7 ; O.F. entries in file 364.7 to be included
 ;
 ;;^68^816^
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 entries deleted:
 ;
DEL5    ; remove O.F. entries in file 364.5 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries deleted:
 ;
 ;
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries deleted:
 ;
 ;
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
