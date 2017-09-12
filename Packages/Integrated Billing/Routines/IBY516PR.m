IBY516PR ;ALB/WCJ - Pre-Installation for IB patch 516 ;4/14/14
 ;;2.0;INTEGRATED BILLING;**516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; delete all output formatter (O.F.) data elements included in build
 D DELOF,RIT,DEL36,IBCLON
 Q
 ;
IBCLON ; Remove lock from IBCLON option - ICR#6126
 S DA=$$FIND1^DIC(19,,,"IB COPY AND CANCEL")
 I 'DA G IBCLONQ
 N IBFDA S IBFDA(19,DA_",",3)="@"
 D FILE^DIE("","IBFDA")
IBCLONQ ;
 Q
 ;
RIT ; recompile billing screen templates
 N X,Y,DMAX,IBN
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens ...")
 F IBN=1:1:8,"10","102","10H" D
 .S X="IBXS"_$S(IBN=10:"A",IBN="102":"A2",IBN="10H":"AH",1:IBN),Y=$$FIND1^DIC(.402,,"X","IB SCREEN"_IBN,"B"),DMAX=$$ROUSIZE^DILF
 .I Y D EN^DIEZ
 D MES^XPDUTL(" Done.")
 Q
 ;
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;
DEL36 ; This procedure deletes any data from four fields in file #36, Insurance Company.
 ;
 N DA,DIE,DR,IBDATA,IBFIELD,IBINSIEN
 S IBINSIEN=0
 F  S IBINSIEN=$O(^DIC(36,IBINSIEN)) Q:'IBINSIEN  D
 . F IBFIELD=4.07,4.11,4.12,4.13 D
 . . S IBDATA=$$GET1^DIQ(36,IBINSIEN_",",IBFIELD,"I")
 . . I IBDATA'="" D
 . . . S DIE="^DIC(36,"
 . . . S DA=IBINSIEN
 . . . S DR=IBFIELD_"///@"
 . . . D ^DIE
 . . . Q
 . . Q
 . Q
 Q
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
 ; 364.5 entries modified:
ENT5 ; OF entries in file 364.5 to be included
 ;
 ;;^199^200^
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ;
ENT6 ; O.F. entries in file 364.6 to be included
 ;
 ;;^66^127^132^483^810^811^812^958^964^974^975^977^979^
 ;;^1014^1029^1030^1031^1034^1043^
 ;;^1839^1840^1851^
 ;;^2059^2060^
 ;;^2231^2235^2236^2237^2251^2252^
 ;
 ;-----------------------------------------------------------------------
ENT7 ; O.F. entries in file 364.7 to be included
 ;
 ;;^37^69^88^89^110^179^184^192^205^206^207^475^
 ;;^829^840^842^933^939^941^952^953^956^
 ;;^1015^1539^1540^1615^1674^1675^1759^1760^
 ;;^1945^1946^1947^1948^1949^1950^
 ;
 ;-----------------------------------------------------------------------
DEL5    ; remove O.F. entries in file 364.5 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
DEL6    ; remove O.F. entries in file 364.6 (not re-added)
 ;
 ;;^1826^1827^
 ;
 ;-----------------------------------------------------------------------
DEL7    ; remove O.F. entries in file 364.7 (not re-added)
 ;
 ;;
 ;
 ;-----------------------------------------------------------------------
ENT3508 ; Add New IB Error Codes to File 350.8
 ;
 ;;
 ;
