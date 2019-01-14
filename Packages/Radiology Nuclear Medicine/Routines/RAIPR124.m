RAIPR124 ;HISC/GJC pre-install routine ;12 Apr 2018 4:02 PM
 ;;5.0;Radiology/Nuclear Medicine;**124**;Mar 16, 1998;Build 4
 ;
 ;Routine              IA          Type
 ;-------------------------------------
 ; ^DIK                10013        (S)
 ;
 N RACHX1,RACHX2
 S RACHX1=$$NEWCP^XPDUTL("PRE1","EN1^RAIPR124")
 Q
 ;
EN1 ;Delete the EXAM STATUS field (70.03;3) from
 ;the RAD/NUC MED PATIENT (#70) data dictionary.
 ;
 N %,DA,DIK,Y,X
 S DIK="^DD(70.03,",DA=3,DA(1)=70.03
 D ^DIK
 Q
 ;
