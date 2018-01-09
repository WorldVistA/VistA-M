GMTSPT12 ; SLC/JER - Post-install for Health Summary patch 12
 ;;2.7;Health Summary;**12**;Feb 28, 1996
HSCFILE ; Install Health Summary components
 N DIC,DLAYGO,DINUM,X,Y,INCLUDE
 I +$O(^GMT(142.1,"B","PROGRESS NOTES SELECTED",0)) D  Q
 . D BMES^XPDUTL("SELECTED PROGRESS NOTES COMPONENT ALREADY INSTALLED.")
 D BMES^XPDUTL("Filing SELECTED PN component in HEALTH SUMMARY COMPONENT FILE.")
 S (DIC,DLAYGO)=142.1,DIC(0)="NXL",X="PROGRESS NOTES SELECTED"
 S DINUM=$$GETNUM
 I +DINUM'>1 D  Q
 . D BMES^XPDUTL("Could not install SELECTED PROGRESS NOTE component.")
 D ^DIC
 I +Y'>0 D  Q
 . D BMES^XPDUTL("Could not install SELECTED PROGRESS NOTE component.")
 S DIE=DIC,DA=+Y
 S DR="1///^S X=""MAIN""_$C(59)_""GMTSPNSL"";2///Y;3///SPN;4///Y"
 S DR=DR_";9///Selected Prog Notes"
 D ^DIE
 S ^GMT(142.1,+DA,1,0)="^142.17P^1^1"
 S ^GMT(142.1,+DA,1,1,0)="8925.1"
 S ^GMT(142.1,+DA,1,"B",8925.1,1)=""
 S ^GMT(142.1,+DA,3.5,0)="^^1^1^"_DT_U
 S ^GMT(142.1,+DA,3.5,1,0)="Allows selection of progress notes titles."
 S DIK=DIE D IX^DIK ; Reindex file for new entry
 S INCLUDE=0 D ENPOST^GMTSLOAD
 Q
GETNUM() ; Get next available component record number <1000
 Q +$O(^GMT(142.1,1000),-1)+1
