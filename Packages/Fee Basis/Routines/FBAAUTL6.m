FBAAUTL6 ;WCIOFO/SAB-UTILITY ROUTINE ;9/11/97
 ;;3.5;FEE BASIS;**9,36**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
VGRP(FBDA) ; Validate/Correct Socioeconomic Groups Extrinsic Function
 ; called by input templates FBAA NEW VENDOR, FBAA EDIT VENDOR
 ; input FBDA - ien of vendor in 161.2
 ; returns - True when groups were changed or False when groups were OK
 N FB,FBBT,FBCHG,FBFDA,FBG,FBIENS
 S FBCHG=0
 ; get current business type and groups
 S FBBT=$$GET1^DIQ(161.2,FBDA,24,"I")
 D GETS^DIQ(161.2,FBDA_",","25*","IE","FB")
 ; check groups against type
 S FBIENS="" F  S FBIENS=$O(FB(161.225,FBIENS)) Q:FBIENS=""  D
 . I FBBT]"",$$GET1^DIQ(420.6,FB(161.225,FBIENS,.01,"I"),5)[FBBT Q  ; OK
 . W !,"  Group ",FB(161.225,FBIENS,.01,"E")," inappropriate for Business Type. Deleting..."
 . S FBFDA(161.225,FBIENS,.01)="@"
 . K FB(161.225,FBIENS)
 I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG() S FBCHG=1
 ; check group combinations
 ; first build list by group codes
 S FBIENS="" F  S FBIENS=$O(FB(161.225,FBIENS)) Q:FBIENS=""  D
 . S FBG(FB(161.225,FBIENS,.01,"E"))=FBIENS
 . S FBG=$G(FBG)+1
 ; check use of OO with others
 I $D(FBG("OO")),$G(FBG)>1 D
 . W !,"  Group OO can't be used with other groups. Deleting OO..."
 . S FBFDA(161.225,FBG("OO"),.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG() S FBCHG=1
 ; check S
 I $D(FBG("RV")),'$D(FBG("S")) D
 . W !,"  Group S must be specified with group RV. Adding S..."
 . S FBFDA(161.225,"+1,"_FBDA_",",.01)="S"
 . D UPDATE^DIE("E","FBFDA") D MSG^DIALOG() S FBCHG=1
 Q FBCHG
 ;
GETGRP(FBDA,FBMAX) ; Get Socioeconomic Groups for a Vendor
 ; in  FBDA - vendor ien
 ;     FBMAX - (optional) maximum number of groups to retrieve
 ; out FBSG( array - i.e. FBSG(1)=code, FBSG(2)=code, etc.
 N FB,FBC,FBIENS
 K FBSG
 I '$G(FBMAX) S FBMAX=999
 D GETS^DIQ(161.2,FBDA_",","25*","","FB")
 S FBC=0,FBIENS=""
 F  S FBIENS=$O(FB(161.225,FBIENS)) Q:FBIENS=""  D  Q:(FBC=FBMAX)
 . S FBC=FBC+1,FBSG(FBC)=FB(161.225,FBIENS,.01)
 Q
 ;
GRPDIF(FBDA) ;  Socioeconomic Groups Different Extrinsic Function?
 ; in  FBDA - vendor ien
 ;     FBSG( array of groups
 ; returns  True (when different) or False (when equivalent)
 N FB,FBARRAY,FBFILE,FBG,FBX,FBY
 ; create sorted list of groups from array
 S FBX="" F  S FBX=$O(FBSG(FBX)) Q:FBX=""  D
 . S FBY=FBSG(FBX) Q:FBY=""
 . S FBG(FBY)=""
 S (FBARRAY,FBY)="" F  S FBY=$O(FBG(FBY)) Q:FBY=""  S FBARRAY=FBARRAY_FBY
 ; create sorted list of groups from file
 D GETS^DIQ(161.2,FBDA_",","25*","","FB")
 K FBG
 S FBX="" F  S FBX=$O(FB(161.225,FBX)) Q:FBX=""  D
 . S FBY=FB(161.225,FBX,.01) Q:FBY=""
 . S FBG(FBY)=""
 S (FBFILE,FBY)="" F  S FBY=$O(FBG(FBY)) Q:FBY=""  S FBFILE=FBFILE_FBY
 ; compare
 Q FBFILE'=FBARRAY
 ;
UPDGRP(FBDA) ; Update Socioeconomic Groups of Vendor
 ; in  FBDA - vendor ien
 ;     FBSG( array
 N FB,FBBT,FBFDA,FBI,FBIENS
 ; delete current vendor groups
 D GETS^DIQ(161.2,FBDA_",","25*","","FB")
 S FBIENS="" F  S FBIENS=$O(FB(161.225,FBIENS)) Q:FBIENS=""  D
 . S FBFDA(161.225,FBIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ; store groups from array in vendor
 N FBVNCOD,FBVNDAT,FBVNDBL
 S FBBT=$$GET1^DIQ(161.2,FBDA,24,"I") ;get business type
 S FBI=0 F  S FBI=$O(FBSG(FBI)) Q:'FBI  D
 . Q:FBSG(FBI)=""
 . ; find internal values with correct business type and effective date
 . S FBVNCOD=0
 . F  S FBVNCOD=$O(^PRCD(420.6,"B",FBSG(FBI),FBVNCOD)) Q:+FBVNCOD=0  S FBVNDAT=$G(^PRCD(420.6,FBVNCOD,0)) Q:$P(FBVNDAT,"^",6)[$G(FBBT)&($P(FBVNDAT,"^",3)=1)
 . Q:+FBVNCOD=0
 . ;do not file "Q" for SMALL BUSINESS - file "S" instead
 . S:FBVNCOD=158 FBVNCOD=162
 . ;R->RV for SMALL BUSINESS
 . S:FBVNCOD=159 FBVNCOD=167
 . ; place internal value in FBFDA if it is not already in there
 . D  Q:FBVNDBL'=""  S FBFDA(161.225,"+"_FBI_","_FBDA_",",.01)=FBVNCOD
 . . S FBVNDBL=0 F  S FBVNDBL=$O(FBFDA(161.225,FBVNDBL)) Q:'FBVNDBL  Q:FBFDA(161.225,FBVNDBL,".01")=FBVNCOD
 ; file internal values in file
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 Q
