DINIT00I ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8028,5,4,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,8029,0)
 ;;=8029^2^y^5
 ;;^UTILITY(U,$J,.84,8029,1,0)
 ;;=^^2^2^2931110^
 ;;^UTILITY(U,$J,.84,8029,1,1,0)
 ;;=Extended dialogue for asking user whether they wish to COMPILE a
 ;;^UTILITY(U,$J,.84,8029,1,2,0)
 ;;=template or cross-references.
 ;;^UTILITY(U,$J,.84,8029,2,0)
 ;;=^^2^2^2931110^
 ;;^UTILITY(U,$J,.84,8029,2,1,0)
 ;;= |1| not currently compiled.
 ;;^UTILITY(U,$J,.84,8029,2,2,0)
 ;;=COMPILE the |1|
 ;;^UTILITY(U,$J,.84,8029,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8029,3,1,0)
 ;;=1^Contains the word 'TEMPLATE' or 'CROSS-REFERENCES'
 ;;^UTILITY(U,$J,.84,8029,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8029,5,1,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,8030,0)
 ;;=8030^2^y^5
 ;;^UTILITY(U,$J,.84,8030,1,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,8030,1,1,0)
 ;;=Warning to user that SORT/PRINT templates are uneditable because the PRINT
 ;;^UTILITY(U,$J,.84,8030,1,2,0)
 ;;=TEMPLATE field on the SORT TEMPLATE has linked it with a print template.
 ;;^UTILITY(U,$J,.84,8030,2,0)
 ;;=^^7^7^2931112^
 ;;^UTILITY(U,$J,.84,8030,2,1,0)
 ;;=Because this Sort Template has been linked with the Print Template
 ;;^UTILITY(U,$J,.84,8030,2,2,0)
 ;;=|1|, neither template can be edited from this option.
 ;;^UTILITY(U,$J,.84,8030,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8030,2,4,0)
 ;;=To edit the templates, first use the FileMan TEMPLATE EDIT
 ;;^UTILITY(U,$J,.84,8030,2,5,0)
 ;;=option to edit the Sort Template, and delete the field called
 ;;^UTILITY(U,$J,.84,8030,2,6,0)
 ;;='PRINT TEMPLATE'.  Then, the templates can be edited from
 ;;^UTILITY(U,$J,.84,8030,2,7,0)
 ;;=the PRINT option.
 ;;^UTILITY(U,$J,.84,8030,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8030,3,1,0)
 ;;=1^Name of associated PRINT TEMPLATE.
 ;;^UTILITY(U,$J,.84,8030,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8030,5,1,0)
 ;;=DIP^EN
 ;;^UTILITY(U,$J,.84,8031,0)
 ;;=8031^2^^5
 ;;^UTILITY(U,$J,.84,8031,1,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,8031,1,1,0)
 ;;=Warning that compiled routine names may get too long.
 ;;^UTILITY(U,$J,.84,8031,2,0)
 ;;=^^3^3^2931110^
 ;;^UTILITY(U,$J,.84,8031,2,1,0)
 ;;=WARNING!!  Since the namespace for this routine is so long, use the
 ;;^UTILITY(U,$J,.84,8031,2,2,0)
 ;;=largest possible size to compile these routines.  Otherwise, FileMan may
 ;;^UTILITY(U,$J,.84,8031,2,3,0)
 ;;=run out of routine names.
 ;;^UTILITY(U,$J,.84,8031,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,8031,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8031,5,2,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8031,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8032,0)
 ;;=8032^2^^5
 ;;^UTILITY(U,$J,.84,8032,1,0)
 ;;=^^1^1^2930702^
 ;;^UTILITY(U,$J,.84,8032,1,1,0)
 ;;=Words SEARCH TEMPLATE
 ;;^UTILITY(U,$J,.84,8032,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8032,2,1,0)
 ;;=Search Template
 ;;^UTILITY(U,$J,.84,8033,0)
 ;;=8033^2^^5
 ;;^UTILITY(U,$J,.84,8033,1,0)
 ;;=^^1^1^2930701^^
 ;;^UTILITY(U,$J,.84,8033,1,1,0)
 ;;=the words INPUT TEMPLATE to use in any FileMan dialog.
 ;;^UTILITY(U,$J,.84,8033,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8033,2,1,0)
 ;;=Input Template
 ;;^UTILITY(U,$J,.84,8033,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8033,5,1,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8033,5,2,0)
 ;;=DIEZ^EN
 ;;^UTILITY(U,$J,.84,8034,0)
 ;;=8034^2^^5
 ;;^UTILITY(U,$J,.84,8034,1,0)
 ;;=^^1^1^2930701^^
 ;;^UTILITY(U,$J,.84,8034,1,1,0)
 ;;=The words PRINT TEMPLATE to use in any FileMan dialog.
 ;;^UTILITY(U,$J,.84,8034,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8034,2,1,0)
 ;;=Print Template
 ;;^UTILITY(U,$J,.84,8034,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8034,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8034,5,2,0)
 ;;=DIPZ^EN
 ;;^UTILITY(U,$J,.84,8035,0)
 ;;=8035^2^^5
 ;;^UTILITY(U,$J,.84,8035,1,0)
 ;;=^^1^1^2930701^
 ;;^UTILITY(U,$J,.84,8035,1,1,0)
 ;;=The words SORT TEMPLATE to use in any FileMan dialog.
 ;;^UTILITY(U,$J,.84,8035,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8035,2,1,0)
 ;;=Sort Template
 ;;^UTILITY(U,$J,.84,8035,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8035,5,1,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,8036,0)
 ;;=8036^2^^5
 ;;^UTILITY(U,$J,.84,8036,1,0)
 ;;=^^1^1^2930702^^
 ;;^UTILITY(U,$J,.84,8036,1,1,0)
 ;;=The words CROSS-REFERENCE(S) to use in any FileMan Dialog.
 ;;^UTILITY(U,$J,.84,8036,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8036,2,1,0)
 ;;=Cross-Reference(s)
 ;;^UTILITY(U,$J,.84,8036,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8036,5,1,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8036,5,2,0)
 ;;=DIKZ^EN
 ;;^UTILITY(U,$J,.84,8037,0)
 ;;=8037^2^^5
 ;;^UTILITY(U,$J,.84,8037,1,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8037,1,1,0)
 ;;=The word SORT to use in any FileMan dialog.
 ;;^UTILITY(U,$J,.84,8037,2,0)
 ;;=^^1^1^2940526^
 ;;^UTILITY(U,$J,.84,8037,2,1,0)
 ;;=sort
 ;;^UTILITY(U,$J,.84,8037,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8037,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8038,0)
 ;;=8038^2^^5
 ;;^UTILITY(U,$J,.84,8038,1,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8038,1,1,0)
 ;;=The word SEARCH to use in any FileMan dialog.
 ;;^UTILITY(U,$J,.84,8038,2,0)
 ;;=^^1^1^2940526^
 ;;^UTILITY(U,$J,.84,8038,2,1,0)
 ;;=search
 ;;^UTILITY(U,$J,.84,8038,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8038,5,1,0)
 ;;=DIP^EN1
 ;;^UTILITY(U,$J,.84,8038,5,2,0)
 ;;=DIS^ENS
 ;;^UTILITY(U,$J,.84,8040,0)
 ;;=8040^2^^5
 ;;^UTILITY(U,$J,.84,8040,1,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,8040,1,1,0)
 ;;=Advice for the Yes/No question
 ;;^UTILITY(U,$J,.84,8040,2,0)
 ;;=^^1^1^2940314^^^
 ;;^UTILITY(U,$J,.84,8040,2,1,0)
 ;;=Answer with 'Yes' or 'No'
 ;;^UTILITY(U,$J,.84,8041,0)
 ;;=8041^2^^5
 ;;^UTILITY(U,$J,.84,8041,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,8041,2,1,0)
 ;;=This is a required response. Enter '^' to exit
 ;;^UTILITY(U,$J,.84,8042,0)
 ;;=8042^2^y^5
 ;;^UTILITY(U,$J,.84,8042,1,0)
 ;;=^^2^2^2940315^^^^
 ;;^UTILITY(U,$J,.84,8042,1,1,0)
 ;;=This 'Select' prompt may be used for dialogs with filenames.
 ;;^UTILITY(U,$J,.84,8042,1,2,0)
 ;;=Note: Dialog will be used with $$EZBLD^DIALOG call, only one text line!!
 ;;^UTILITY(U,$J,.84,8042,2,0)
 ;;=1
 ;;^UTILITY(U,$J,.84,8042,2,1,0)
 ;;=Select |1|: 
 ;;^UTILITY(U,$J,.84,8042,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8042,3,1,0)
 ;;=1^Name of the file
 ;;^UTILITY(U,$J,.84,8043,0)
 ;;=8043^2^^5
 ;;^UTILITY(U,$J,.84,8043,1,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8043,1,1,0)
 ;;=Used for date time input to the reader.
 ;;^UTILITY(U,$J,.84,8043,2,0)
 ;;=^^1^1^2940314^^
 ;;^UTILITY(U,$J,.84,8043,2,1,0)
 ;;= and time
 ;;^UTILITY(U,$J,.84,8044,0)
 ;;=8044^2^^5
