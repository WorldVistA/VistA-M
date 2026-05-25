IBY770PR ;EDE/WCJ - Pre-Installation for IB patch 770 ; 10/12/17 2:12 pm
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 ;
 N IBA
 S IBA(2)="IB*2*770 Pre-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D FIXIT
 ;
 D CLEANUP364P99
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF
 ;
 S IBA(2)="IB*2*770 Pre-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
FIXIT ;
 D MES^XPDUTL("Updating file 364.8 field .08 - Test flag now required")
 N D0 S D0=0 F  S D0=$O(^IBA(364.8,D0)) Q:'+D0  I $P($G(^IBA(364.8,D0,0)),U,8)="" S $P(^IBA(364.8,D0,0),U,8)=0
 D MES^XPDUTL("Finished file 364.8 field .08 updates")
 Q
 ;
CLEANUP364P99 ;  replace the file.  only impacts IOC.
 ;
 Q:'$D(^IBA(364.99))    ; new file is coming with the patch so have it start clean
 ;
 D MES^XPDUTL("Updating file 364.99 - out with the old")
 N TMP
 S TMP=$P($G(^IBA(364.99,0)),U,1,2)
 K ^IBA(364.99)
 S ^IBA(364.99,0)=TMP
 D MES^XPDUTL("Done removing data file 364.99 so we can start fresh")
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x or FILE=8 indicating file 350.8 (IB ERROR)
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
 F FILE=5:1:8 S DIK=$S(FILE=8:"^IBE(350.",1:"^IBA(364.")_FILE_"," D
 . F TAG="ENT"_FILE,"DEL"_FILE D
 .. F LN=2:1 S TAGLN=TAG_"+"_LN,DATA=$P($T(@TAGLN),";;",2) Q:DATA=""  D
 ... F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  D
 .... I FILE=8,$D(^IBE(350.8,DA,0)) D ^DIK
 .... Q:FILE=8
 .... I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 Q
 ;
 ; Example for ENT5, ENT6, ENT7, ENT8, DEL5, DEL6, DEL7, and DEL8:
 ;;^195^254^259^269^324^325^
 ; Note:  Must have beginning and ending up-carat
 ;
 ;-----------------------------------------------------------------------
 ; 364.5 O.F. entries added:
 ;
 ;  
ENT5 ;O.F. entries in file 364.5 to be added
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 O.F. entries added:
 ;
 ;
ENT6 ;O.F. entries in file 364.6 to be added
 ;
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 O.F. entries added:
 ;
 ;
ENT7 ; O.F. entries in file 364.7 to be added
 ;
 ;;^1949^1950^
 ;
 ;
 ;-----------------------------------------------------------------------
 ; 350.8 O.F. entries added:
 ;
 ;
ENT8 ;O.F. entries in file 350.8 to be added
 ;
 ;;
 ;
 ;
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
 ; 350.8 Entries deleted:
 ;
 ;
DEL8    ; remove entries from 350.8 (IB ERROR)
 ;
 ;;
 ;
