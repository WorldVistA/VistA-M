GMTSP26 ;SLC/RMP - Imaging HS Comp Post-Install     ; 04/15/1999
 ;;2.7;Health Summary;**26**;Oct 20, 1995
 ;
 Q
P26 ; Install Health Summary component
 N DIE,DIK,DA,DR,DIC,DLAYGO,DINUM,X,Y,INCLUDE
 I +$O(^GMT(142.1,"B","MAG IMAGING",0)) D  Q
 . D BMES^XPDUTL(" MAG Imaging component has already been installed in the.")
 . D MES^XPDUTL(" HEALTH SUMMARY COMMPONET FILE.")
 D BMES^XPDUTL(" Filing MAG Imaging component in HEALTH SUMMARY COMPONENT FILE.")
 S (DIC,DLAYGO)=142.1,DIC(0)="NXL",X="MAG IMAGING"
 S DINUM=235
 I +DINUM'>1 D  Q
 . D BMES^XPDUTL(" Could not install MAG Imaging component.")
 D ^DIC
 I +Y'>0 D  Q
 . D BMES^XPDUTL(" Could not install MAG Imaging component.")
 S DIE=DIC,DA=+Y
 S DR="1///^S X=""MAIN""_$C(59)_""GMTSMAG"";2///Y;3///MAGI;4///Y"
 S:'$D(^MAG(2005,0)) DR=DR_";5///P;8///^S X=""Imaging not installed"""
 S DR=DR_";9///MAG Imaging"
 D ^DIE
 S ^GMT(142.1,+DA,3.5,0)="^^2^2^"_DT_U
 S ^GMT(142.1,+DA,3.5,1,0)="This component lists the available images along with"
 S ^GMT(142.1,+DA,3.5,2,0)="the procedure name and short description."
 S DIK=DIE D IX^DIK ; Reindex file for new entry
 S INCLUDE=0 D ENPOST^GMTSLOAD
 Q
