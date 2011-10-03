ACKQHLP1 ;BIR/PTD HCIOFO/AG - QUASAR Help Text - CONTINUED ; 02/26/96 14:00
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
ACTION ;Extended help - select action to take. (ACKQFIL)
 W !?5,"You can activate and inactivate file entries.",!?5,"You can also add to or edit file entries."
 W !?5,"Enter 1 to use the activate/inactivate feature.",!?5,"Enter 2 to add/edit file entries.",!?5,"Press return to exit the option."
 Q
 ;
CHANGE ;Extended help - entry is inactive, do you want to make it active? (ACKQFIL)
 W !?5,"Do you want to change this INACTIVE entry back to ACTIVE?",!?5,"Enter YES to change the entry to ACTIVE.",!?5,"Enter NO or press return to leave the entry as INACTIVE."
 Q
 ;
CHOOSE ;Extended help - select action to take. (ACKQAS3)
 W !?5,"You can edit the cost of CPT-4 procedure codes.  Enter 1",!?5,"to select the code to edit.  If you enter 2, the codes",!?5,"are displayed consecutively for cost entry.  Press return",!?5,"to exit the option."
 Q
 ;
FILE ;Extended help - select file to update or exit. (ACKQFIL)
 W !?5,"Enter 1 to update the CDR ACCOUNT file."
 W !?5,"Enter 2 to update the A&SP DIAGNOSTIC CONDITION file."
 W !?5,"Enter 3 to update the A&SP PROCEDURE CODE file."
 W !?5,"Press <Return> to Quit."
 Q
 ;
HRLOS ;Extended help - is this ICD9 code a hearing loss code which requires audiology questions? (ACKQFIL1)
 W !?5,"In addition to C&P exams, audiometric fields must be answered",!?5,"for some ICD-9CM codes which are designated as hearing loss codes."
 W !?5,"Enter YES to indicate that this code requires audiometric fields",!?5,"to be answered.  Enter NO if the code is not a hearing loss code."
 Q
 ;
MOD ;Extended help - does this code have modifiers? (ACKQFIL1)
 W !?5,"Some codes may not adequately describe the scope or variety of",!?5,"problems or procedures seen by audiologists and speech pathologists."
 W !?5,"Recognizing this deficiency, modifiers have been developed for",!?5,"certain codes for clarification.  Enter YES to add code modifiers.",!?5,"Enter NO if the code does not have modifiers."
 Q
 ;
PRINT ;Extended help - select file to print. (ACKQFILP)
 W !?5,"Enter 1 to print data from the CDR ACCOUNT file."
 W !?5,"Enter 2 to print data from the A&SP DIAGNOSTIC CONDITION file."
 W !?5,"Enter 3 to print data from the A&SP PROCEDURE CODE file."
 W !?5,"Press <Return> to exit the option."
 Q
 ;
REGEN ;Extended help - delete CDR and regenerate? (ACKQCD2)
 W !?5,"You can delete the ""saved"" CDR and regenerate the data."
 W !?5,"Enter YES to delete the existing CDR data, regenerate, and resave",!?5,"the current data."
 W !?5,"Enter NO if you do not want to delete the ""saved"" CDR.",!?5,"You can still print the current CDR report."
 Q
 ;
SURE ;Extended help - sure you should continue? (ACKQFIL)
 W !?5,"You can add to or edit the A&SP CDR ACCOUNT file,",!?5,"the DIAGNOSTIC CONDITION file, or the PROCEDURE CODE file.",!?5,"This is to be done by directive from the Director, A&SP VACO."
 W !?5,"Enter YES to add or edit these files.",!?5,"Enter NO or press return to exit the option."
 Q
 ;
UPDATE ;Extended help - update diagnostic history? (ACKQNQ)
 W !?5,"The patient's Problem List or diagnostic history is stored in the",!?5,"A&SP PATIENT file (#509850.2). Visit data are stored in the A&SP",!?5,"CLINIC VISIT file (#509850.6). These two files become asynchronous"
 W !?5,"when diagnoses are deleted or changed in the A&SP CLINIC VISIT file.",!?5,"The Problem List is recompiled using this logic:  All clinic visits"
 W !?5,"for the patient are examined. Unique diagnostic codes and the earliest"
 W !?5,"date for each code are determined. The A&SP PATIENT file is updated",!?5,"with these codes and dates. Also, the earliest diagnostic date found",!?5,"becomes the INITIAL VISIT DATE."
 W !!?5,"If you wish to recompile the Problem List, enter YES.",!?5,"If you do not wish to recompile, press RETURN or enter NO."
 Q
 ;
