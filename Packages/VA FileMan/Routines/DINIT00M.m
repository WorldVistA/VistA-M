DINIT00M ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8096,1,2,0)
 ;;=instead of an open global root, and the DA array is not defined.
 ;;^UTILITY(U,$J,.84,8096,2,0)
 ;;=^^1^1^2971001^
 ;;^UTILITY(U,$J,.84,8096,2,1,0)
 ;;=If DIC contains a subfile number, DA array must be defined.
 ;;^UTILITY(U,$J,.84,8096,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8096,5,1,0)
 ;;=DIC0^GETFILE
 ;;^UTILITY(U,$J,.84,8097,0)
 ;;=8097^2^y^5
 ;;^UTILITY(U,$J,.84,8097,1,0)
 ;;=^^1^1^2980304^^^
 ;;^UTILITY(U,$J,.84,8097,1,1,0)
 ;;=Variable Pointer Lookup
 ;;^UTILITY(U,$J,.84,8097,2,0)
 ;;=^^1^1^2980304^
 ;;^UTILITY(U,$J,.84,8097,2,1,0)
 ;;=     Searching for a |1|, (pointed-to by |2|)
 ;;^UTILITY(U,$J,.84,8097,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8097,3,1,0)
 ;;=1^Pointed-to Filename
 ;;^UTILITY(U,$J,.84,8097,3,2,0)
 ;;=2^Pointing field name
 ;;^UTILITY(U,$J,.84,8098,0)
 ;;=8098^2^^5
 ;;^UTILITY(U,$J,.84,8098,2,0)
 ;;=^^1^1^2980603^^^^
 ;;^UTILITY(U,$J,.84,8098,2,1,0)
 ;;=file^File^subfile^Subfile
 ;;^UTILITY(U,$J,.84,9002,0)
 ;;=9002^3^y^5
 ;;^UTILITY(U,$J,.84,9002,1,0)
 ;;=^^1^1^2930617^^
 ;;^UTILITY(U,$J,.84,9002,1,1,0)
 ;;=Help for entering maximum routine size for compiled routines.
 ;;^UTILITY(U,$J,.84,9002,2,0)
 ;;=^^4^4^2930629^^^^
 ;;^UTILITY(U,$J,.84,9002,2,1,0)
 ;;=This number will be used to determine how large to make the generated
 ;;^UTILITY(U,$J,.84,9002,2,2,0)
 ;;=compiled |1| routines.  The size must be a number greater
 ;;^UTILITY(U,$J,.84,9002,2,3,0)
 ;;=than 2400, the larger the better, up to the maximum routine size for
 ;;^UTILITY(U,$J,.84,9002,2,4,0)
 ;;=your operating system.
 ;;^UTILITY(U,$J,.84,9002,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9002,3,1,0)
 ;;=1^Will be the word 'TEMPLATE' when compiling templates, or 'cross-reference' when compiling CROSS-REFERENCES.
 ;;^UTILITY(U,$J,.84,9002,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,9002,5,1,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,9002,5,2,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,9002,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,9004,0)
 ;;=9004^3^y^5
 ;;^UTILITY(U,$J,.84,9004,1,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,9004,1,1,0)
 ;;=Help asking the user whether they wish to UNCOMPILE previously compiled
 ;;^UTILITY(U,$J,.84,9004,1,2,0)
 ;;=templates or cross-references.
 ;;^UTILITY(U,$J,.84,9004,2,0)
 ;;=^^4^4^2931110^^
 ;;^UTILITY(U,$J,.84,9004,2,1,0)
 ;;=  Answer YES to UNCOMPILE the |1|.
 ;;^UTILITY(U,$J,.84,9004,2,2,0)
 ;;=The compiled routine will no longer be used.
 ;;^UTILITY(U,$J,.84,9004,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9004,2,4,0)
 ;;=  Answer NO to recompile the |1| at this time.
 ;;^UTILITY(U,$J,.84,9004,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9004,3,1,0)
 ;;=1^Will contain either the word 'TEMPLATE' or 'CROSS-REFERENCES.
 ;;^UTILITY(U,$J,.84,9004,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,9004,5,1,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,9004,5,2,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,9004,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,9006,0)
 ;;=9006^3^y^5
 ;;^UTILITY(U,$J,.84,9006,1,0)
 ;;=^^2^2^2931105^^^^
 ;;^UTILITY(U,$J,.84,9006,1,1,0)
 ;;=Help for prompting for compiled routine name, when compiling templates
 ;;^UTILITY(U,$J,.84,9006,1,2,0)
 ;;=or cross-references.
 ;;^UTILITY(U,$J,.84,9006,2,0)
 ;;=^^2^2^2931109^
 ;;^UTILITY(U,$J,.84,9006,2,1,0)
 ;;=Enter a valid MUMPS routine name of from 3 to |1| characters.  This must
 ;;^UTILITY(U,$J,.84,9006,2,2,0)
 ;;=be entered without a leading up-arrow, and cannot begin with "DI".
 ;;^UTILITY(U,$J,.84,9006,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,9006,3,1,0)
 ;;=1^Internal parameter indicating the maximum number of characters allowed for routine namespace.
 ;;^UTILITY(U,$J,.84,9006,5,0)
 ;;=^.841^4^4
 ;;^UTILITY(U,$J,.84,9006,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9006,5,2,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,9006,5,3,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,9006,5,4,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,9014,0)
 ;;=9014^3^^5
 ;;^UTILITY(U,$J,.84,9014,1,0)
 ;;=^^1^1^2930706^^^^
 ;;^UTILITY(U,$J,.84,9014,1,1,0)
 ;;=Help prompt for compiling sort templates.
 ;;^UTILITY(U,$J,.84,9014,2,0)
 ;;=^^3^3^2931110^
 ;;^UTILITY(U,$J,.84,9014,2,1,0)
 ;;=If YES is entered,
 ;;^UTILITY(U,$J,.84,9014,2,2,0)
 ;;=the Sort logic will be compiled into a routine at the
 ;;^UTILITY(U,$J,.84,9014,2,3,0)
 ;;=time the template is used in a FileMan Sort/Print.
 ;;^UTILITY(U,$J,.84,9014,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9014,5,1,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,9019,0)
 ;;=9019^3^^5
 ;;^UTILITY(U,$J,.84,9019,1,0)
 ;;=^^1^1^2931110^^^^
 ;;^UTILITY(U,$J,.84,9019,1,1,0)
 ;;=Help prompt for Uncompiling sort templates.
 ;;^UTILITY(U,$J,.84,9019,2,0)
 ;;=^^3^3^2931110^
 ;;^UTILITY(U,$J,.84,9019,2,1,0)
 ;;=If YES is entered,
 ;;^UTILITY(U,$J,.84,9019,2,2,0)
 ;;=the Sort logic for this template will NOT be compiled into a
 ;;^UTILITY(U,$J,.84,9019,2,3,0)
 ;;=routine during the time it is used by a FileMan sort/print.
 ;;^UTILITY(U,$J,.84,9019,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9019,5,1,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,9024,0)
 ;;=9024^3^^5
 ;;^UTILITY(U,$J,.84,9024,1,0)
 ;;=^^2^2^2931105^
 ;;^UTILITY(U,$J,.84,9024,1,1,0)
 ;;=Help for the POST-SELECTION ACTION field for a file.  This entry is put
 ;;^UTILITY(U,$J,.84,9024,1,2,0)
 ;;=in from the Utility option to edit a file.
 ;;^UTILITY(U,$J,.84,9024,2,0)
 ;;=^^1^1^2931105^^^
 ;;^UTILITY(U,$J,.84,9024,2,1,0)
 ;;=This code will be executed whenever an entry is selected from the file.
 ;;^UTILITY(U,$J,.84,9024,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9024,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9025,0)
 ;;=9025^3^^5
 ;;^UTILITY(U,$J,.84,9025,1,0)
 ;;=^^1^1^2931105^^
 ;;^UTILITY(U,$J,.84,9025,1,1,0)
 ;;=General help for MUMPS type fields.
 ;;^UTILITY(U,$J,.84,9025,2,0)
 ;;=^^1^1^2931105^
 ;;^UTILITY(U,$J,.84,9025,2,1,0)
 ;;=Enter a line of standard MUMPS code.
 ;;^UTILITY(U,$J,.84,9025,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9025,5,1,0)
 ;;=DIOU^6
 ;;^UTILITY(U,$J,.84,9026,0)
 ;;=9026^3^^5
 ;;^UTILITY(U,$J,.84,9026,1,0)
 ;;=^^3^3^2931105^^
 ;;^UTILITY(U,$J,.84,9026,1,1,0)
 ;;=The DD for the file of files is not completely FileMan compatible.  This
 ;;^UTILITY(U,$J,.84,9026,1,2,0)
 ;;=is the standard help prompt for the LOOK-UP PROGRAM field on the file of
 ;;^UTILITY(U,$J,.84,9026,1,3,0)
 ;;=files.  Prompt appears when file attributes are being edited.
 ;;^UTILITY(U,$J,.84,9026,2,0)
 ;;=^^2^2^2931105^^
 ;;^UTILITY(U,$J,.84,9026,2,1,0)
 ;;=This special lookup routine will be executed instead of the standard
 ;;^UTILITY(U,$J,.84,9026,2,2,0)
 ;;=FileMan lookup logic, whenever a call is made to ^DIC.
