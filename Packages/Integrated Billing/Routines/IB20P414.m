IB20P414 ;ALB/ESG - Pre-Installation for IB patch 414 ;10-Feb-2009
 ;;2.0;INTEGRATED BILLING;**414**;21-MAR-94;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; delete all output formatter data elements included in build
 D DELOF       ; delete all output formatter data elements included in build
 ;
 Q
 ;
 ;
DELOF ; Delete included output formatter entries
 N FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;  
DELOFX ;
 Q
 ;
 ;
 ;----------------------------------------------------------------------
 ; 364.6 entries modified:
ENT6     ; output formatter entries in file 364.6 to be included
 ;
 ;;^174^180^
 ;;
 ;
 ;
 ;----------------------------------------------------------------------
 ; 364.7 entries modified:
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^160^
 ;;
 ;
 ;
 ;----------------------------------------------------------------------
