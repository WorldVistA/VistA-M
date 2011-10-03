DG681PST ;BAY/ALS;populate new PIVOT FILE DAYS TO RETAIN field ; 10/05/05
 ;;5.3;Registration;**681**;Aug 13,1993
 ;
 ; This is a post-install routine for DG*5.3*681
 ; The purpose is to check the 4th piece of the HL7 node in the
 ; MAS PARAMETERS (#43) file and put the data in the 6th piece
 ; of the HL7 node, the new location for the PIVOT FILE DAYS TO
 ; RETAIN (#391.702) field as follows.
 ;
 ; If it equals 1- leave it as is, it was placed there by the
 ; CREATE MFU FOR RAI MDS (#391.7014) field
 ;
 ; If it is greater than 29, move it to the 6th piece, the 
 ; PIVOT FILE DAYS TO RETAIN (#391.702) field is meant to be
 ; at least 30.
 ;
 ; If it is null leave it as is.
EN ;
 S RAI=""
 S DIC=43,DA=1,DR="391.7014"
 D EN^DIQ1 K DIC,DA,DR
 S RAI=^UTILITY("DIQ1",$J,43,1,391.7014)
 I RAI>29 D
 . S DIE=43,DA=1,DR="391.702///^S X=RAI;391.7014///@"
 . D ^DIE K DIE,DA,DR
 K RAI
 Q
