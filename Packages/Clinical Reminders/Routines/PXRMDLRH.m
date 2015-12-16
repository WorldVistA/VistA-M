PXRMDLRH ; SLC/AGP - Dialog Report Help Routine; 01/13/2015
 ;;2.0;CLINICAL REMINDERS;**53**;Feb 04, 2005;Build 225
 ; 
 ; Called from PXRM PATIENT LIST CREATE protocol
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 ;
 I CALL=6 D
 .S HTEXT(1)="Enter 'Y' to build a list of coding systems. "
 .S HTEXT(2)="This list will be used to find taxonomies with at least one code from the selected coding system marked to be used in a dialog. "
 .S HTEXT(3)="Enter 'N' to not search for coding systems."
 ;
 I CALL=7 D
 .S HTEXT(1)="Select a list of coding systems to search for taxonomies containing code marked to be used in a dialog for the selected coding system."
 ;
 I CALL=8 D
 .S HTEXT(1)="Enter 'Y' to build a list of Finding Items for which to search. "
 .S HTEXT(2)="This list of items will be used to find dialogs in which they are contained in either the Finding Item, Additional Finding Items or a Result Group MH Test field. "
 .S HTEXT(3)="Enter 'N' to not search for finding items."
 ;
 I CALL=9 D
 .S HTEXT(1)="Enter 'Y' to build a list of dialog items (Element, Group, Prompt, Forced Value, Result Group, Result Element) for which to search. "
 .S HTEXT(2)="This list will be used to find parent dialog(s) in which they are contained. Enter 'N' to not look for dialog items."
 ;
 I CALL=10 D
 .S HTEXT(1)="Enter 'Y' to search for dialogs used on a CPRS CoverSheet by User(s) and dialogs assigned as a TIU Template. Enter 'N' to search all dialog."
 ;
 I CALL=11 D
 .S HTEXT(1)="Enter 'Y' to search for specific CPRS CoverSheet List."
 ;
 I CALL=12 D
 .S HTEXT(1)="Enter 'Y' to search for a specific CPRS CoverSheet Location for each requested parameter(s). Enter 'N' to not restrict the CPRS CoverSheet to a location."
 ;
 I CALL=13 D
 .S HTEXT(1)="Enter 'Y' to display which search criteria was found in the dialog. This information will be displayed with the dialog name in report output under the Match Criteria heading. Enter 'N' to display the dialog name only."
 ;
 I CALL=14 D
 .S HTEXT(1)="Enter 'Y' to add all prompts and forced values of the same type as the selected Prompt/Forced Value to the search criteria list. Enter 'N' to only search for the specific selected Prompt/Forced Value."
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
