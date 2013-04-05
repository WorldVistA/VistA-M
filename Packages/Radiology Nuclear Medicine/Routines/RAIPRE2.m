RAIPRE2 ;HIRMFO/GJC- Pre-init routine ;10/23/97  09:30
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
EN1 ; Delete the Allow 'VA' Patient Entry field from the Rad/Nuc Med
 ; Division data dictionary.  Delete Allow 'VA' Patient Entry data
 ; from the Rad/Nuc Med Division file.
 Q:'($D(^DD(79,.13,0))#2)  ; deleted in the past.
 N %,DA,DIC,DIK,RALL,RAD0,RADD,RAFLD,RATXT,X,Y
 S RATXT(1)=" ",RAD0=0,RADD=79,RAFLD=.13
 S RATXT(2)="Deleting obsolete Allow 'VA' Patient Entry field from Rad/"
 S RATXT(3)="Nuc Med Division data dictionary.  Deleting Allow 'VA'"
 S RATXT(4)="Patient Entry data from the Rad/Nuc Med Division file."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RA(79,RAD0)) Q:RAD0'>0  D
 . S RALL=$P($G(^RA(79,RAD0,.1)),"^",3)
 . D:RALL]"" ENKILL^RAXREF(RADD,RAFLD,RALL,.RAD0)
 . S:RALL]"" $P(^RA(79,RAD0,.1),"^",3)=""
 . Q
 S DIK="^DD(79,",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field from DD!
 Q
EN2 ; Delete the Allow 'NON-VA' Patient Entry field from the Rad/Nuc Med
 ; Division data dictionary.  Delete Allow 'NON-VA' Patient Entry data
 ; from the Rad/Nuc Med Division file.
 Q:'($D(^DD(79,.14,0))#2)  ; deleted in the past.
 N %,DA,DIC,DIK,RALLN,RAD0,RADD,RAFLD,RATXT,X,Y
 S RATXT(1)=" ",RAD0=0,RADD=79,RAFLD=.14
 S RATXT(2)="Deleting obsolete Allow 'NON-VA' Patient Entry field from"
 S RATXT(3)="Rad/Nuc Med Division data dictionary.  Deleting Allow 'NON-"
 S RATXT(4)="VA' Patient Entry data from the Rad/Nuc Med Division file."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RA(79,RAD0)) Q:RAD0'>0  D
 . S RALLN=$P($G(^RA(79,RAD0,.1)),"^",4)
 . D:RALLN]"" ENKILL^RAXREF(RADD,RAFLD,RALLN,.RAD0)
 . S:RALLN]"" $P(^RA(79,RAD0,.1),"^",4)=""
 . Q
 S DIK="^DD(79,",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field from DD!
 Q
EN3 ; Delete the Ask 'Requesting Physician' field from the Rad/Nuc Med
 ; Division data dictionary.  Delete Ask 'Requesting Physician' data
 ; from the Rad/Nuc Med Division file.
 Q:'($D(^DD(79,.15,0))#2)  ; deleted in the past.
 N %,DA,DIC,DIK,RAD0,RADD,RAFLD,RAREQ,RATXT,X,Y
 S RATXT(1)=" ",RAD0=0,RADD=79,RAFLD=.15
 S RATXT(2)="Deleting obsolete Ask 'Requesting Physician' field from"
 S RATXT(3)="Rad/Nuc Med Division data dictionary.  Deleting Ask 'Requ-"
 S RATXT(4)="esting Physician' data from the Rad/Nuc Med Division file."
 D BMES^XPDUTL(.RATXT)
 F  S RAD0=$O(^RA(79,RAD0)) Q:RAD0'>0  D
 . S RAREQ=$P($G(^RA(79,RAD0,.1)),"^",5)
 . D:RAREQ]"" ENKILL^RAXREF(RADD,RAFLD,RAREQ,.RAD0)
 . S:RAREQ]"" $P(^RA(79,RAD0,.1),"^",5)=""
 . Q
 S DIK="^DD(79,",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field from DD!
 Q
EN4 ; Delete the following fields from the Rad/Nuc Med Division
 ; data dictionary: Last DFN Converted (75.1), Conversion Start
 ; Time (75.1), Conversion Stop Time (75.1), Last DFN Converted
 ; (70), Conversion Start Time (70) & Conversion Stop Time (70).
 ; All data associated with these fields will be deleted.
 N RADD,RAXIST S RADD=79,RAXIST=0
 F RAFLD=2300.1:.1:2300.6 S:$D(^DD(RADD,RAFLD,0)) RAXIST=1
 Q:'RAXIST  ; fields have already been deleted!
 N %,DA,DIC,DIK,RAD0,RADATA,RAFILE,RAFLD,RAFLDTXT,RATXT,X,Y S RAD0=0
 S RAFILE=$S($D(^DIC(RADD,0))#2:$P(^(0),"^"),1:"Unknown")
 F  S RAD0=$O(^RA(RADD,RAD0)) Q:RAD0'>0  D
 . F RAFLD=2300.1:.1:2300.6 D
 .. S RAFLDTXT=$S($D(^DD(RADD,RAFLD,0))#2:$P(^(0),"^"),1:"Unknown")
 .. Q:RAFLDTXT="Unknown"  ; unidentified field
 .. S RADATA=$P($G(^RA(RADD,RAD0,"PATCH23")),"^",$P(RAFLD,".",2))
 .. D:RADATA]"" ENKILL^RAXREF(RADD,RAFLD,RADATA,.RAD0)
 .. S:RADATA]"" $P(^RA(RADD,RAD0,"PATCH23"),"^",$P(RAFLD,".",2))=""
 .. S RATXT(1)=" ",RATXT(2)="Deleting obsolete "_RAFLDTXT_" field from"
 .. S RATXT(3)=RAFILE_" data dictionary."
 .. S RATXT(4)="Deleting "_RAFLDTXT_" data from the"
 .. S RATXT(5)=RAFILE_" file.  Division: "_$$GET1^DIQ(4,RAD0_",",.01)
 .. D BMES^XPDUTL(.RATXT)
 .. S DIK="^DD("_RADD_",",DA(1)=RADD,DA=RAFLD D ^DIK ; delete field!
 .. Q
 . K %,DA,DIC,DIK,X,Y K ^RA(RADD,RAD0,"PATCH23") ; kill off data node
 . Q
 Q
EN5 ; Change the name of 'Radiology Location' in the Label Print Fields
 ; file (78.7) to 'Imaging Location'.
 Q:+$O(^RA(78.7,"B","IMAGING LOCATION",0))  ; 'Imaging Location' exists
 N RADLOC,RAFDA,RATXT S RATXT(1)=""
 S RATXT(2)="Changing name of Label Print Field (file: 78.7)"
 S RATXT(3)="from: 'RADIOLOGY LOCATION' to 'IMAGING LOCATION'"
 S RADLOC=+$O(^RA(78.7,"B","RADIOLOGY LOCATION",0))
 Q:'RADLOC  D MES^XPDUTL(.RATXT)
 S RAFDA(78.7,RADLOC_",",.01)="IMAGING LOCATION"
 D FILE^DIE("","RAFDA","")
 Q
EN7 ; Un-compile the 'RA STATUS CHANGE' & 'RA EXAM EDIT' input templates
 ; on the Rad/Nuc Med Patient file.
 ; Variable Definition:
 ; RAEXED -> ien of the RA EXAM EDIT template
 ; RASTCH -> ien of the RA STATUS CHANGE template
 ; RATXT  -> array which contains the message displayed to the user
 ;
 N RAEXED,RASTCH,RATXT
 S RASTCH=$$FIND1^DIC(.402,"","X","RA STATUS CHANGE")
 I RASTCH D  ; the input template exists
 . D TMPMSG("RA STATUS CHANGE"),MES^XPDUTL(.RATXT),UNC^DIEZ(RASTCH,"D")
 . Q
 S RAEXED=$$FIND1^DIC(.402,"","X","RA EXAM EDIT")
 I RAEXED K RATXT D  ; the input template exists
 . D TMPMSG("RA EXAM EDIT"),MES^XPDUTL(.RATXT),UNC^DIEZ(RAEXED,"D")
 . Q
 Q
TMPMSG(X) ; Build the text array for each specific compiled input
 ; template.
 ; Input: X-the name of the input template
 S RATXT(1)=""
 S RATXT(2)="Un-compiling the `"_X_"' input template on the"
 S RATXT(3)="Rad/Nuc Med Patient file.  All the compiled templates"
 S RATXT(4)="associated with `"_X_"' will be deleted."
 Q
