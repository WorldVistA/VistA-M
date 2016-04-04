DINIT00N ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;06:19 PM  21 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9026,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9026,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9027,0)
 ;;=9027^3^^5
 ;;^UTILITY(U,$J,.84,9027,1,0)
 ;;=^^3^3^2931105^
 ;;^UTILITY(U,$J,.84,9027,1,1,0)
 ;;=The DD for the file of files is not completely FileMan compatible.  This
 ;;^UTILITY(U,$J,.84,9027,1,2,0)
 ;;=is the standard help prompt for the CROSS-REFERENCE ROUTINE field on the
 ;;^UTILITY(U,$J,.84,9027,1,3,0)
 ;;=file of files.  Prompt appears when file attributes are being edited.
 ;;^UTILITY(U,$J,.84,9027,2,0)
 ;;=^^5^5^2931109^
 ;;^UTILITY(U,$J,.84,9027,2,1,0)
 ;;=If a NEW routine name is entered, but the cross-references are not
 ;;^UTILITY(U,$J,.84,9027,2,2,0)
 ;;=compiled at this time, the routine name will be automatically deleted.
 ;;^UTILITY(U,$J,.84,9027,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9027,2,4,0)
 ;;=If the routine name is deleted, the cross-references are considered
 ;;^UTILITY(U,$J,.84,9027,2,5,0)
 ;;=uncompiled, and FileMan will not use the routine for re-indexing.
 ;;^UTILITY(U,$J,.84,9027,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9027,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9028,0)
 ;;=9028^3^^5
 ;;^UTILITY(U,$J,.84,9028,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,9028,1,1,0)
 ;;=Help prompt for CROSS-REFERENCE ROUTINE name when editing file attributes.
 ;;^UTILITY(U,$J,.84,9028,1,2,0)
 ;;= If the user does not changes the name of the CROSS-REFERENCE ROUTINE,
 ;;^UTILITY(U,$J,.84,9028,1,3,0)
 ;;=then recompilation is not required, and they will see this help prompt.
 ;;^UTILITY(U,$J,.84,9028,2,0)
 ;;=^^2^2^2931109^
 ;;^UTILITY(U,$J,.84,9028,2,1,0)
 ;;=It is not necessary to recompile the cross-references, since the name of
 ;;^UTILITY(U,$J,.84,9028,2,2,0)
 ;;=the CROSS-REFERENCE ROUTINE was not changed.
 ;;^UTILITY(U,$J,.84,9028,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9028,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9029,0)
 ;;=9029^3^^5
 ;;^UTILITY(U,$J,.84,9029,1,0)
 ;;=^^5^5^2931109^
 ;;^UTILITY(U,$J,.84,9029,1,1,0)
 ;;=Help prompt for CROSS-REFERENCE ROUTINE name when editing file attributes.
 ;;^UTILITY(U,$J,.84,9029,1,2,0)
 ;;= If the user changes the name of the CROSS-REFERENCE ROUTINE, or enters a
 ;;^UTILITY(U,$J,.84,9029,1,3,0)
 ;;=name for the first time, they must also compile the routines at this time.
 ;;^UTILITY(U,$J,.84,9029,1,4,0)
 ;;= If they don't the routine name they just entered will be deleted from the
 ;;^UTILITY(U,$J,.84,9029,1,5,0)
 ;;=DD.
 ;;^UTILITY(U,$J,.84,9029,2,0)
 ;;=^^2^2^2931109^
 ;;^UTILITY(U,$J,.84,9029,2,1,0)
 ;;=If the cross-references are not recompiled at this time, the
 ;;^UTILITY(U,$J,.84,9029,2,2,0)
 ;;=CROSS-REFERENCE ROUTINE name will NOT be saved in the data dictionary.
 ;;^UTILITY(U,$J,.84,9029,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,9029,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9030,0)
 ;;=9030^3^^5
 ;;^UTILITY(U,$J,.84,9030,1,0)
 ;;=^^2^2^2931109^^^^
 ;;^UTILITY(U,$J,.84,9030,1,1,0)
 ;;=Help for prompting for compiled routine name, when compiling templates
 ;;^UTILITY(U,$J,.84,9030,1,2,0)
 ;;=or cross-references.
 ;;^UTILITY(U,$J,.84,9030,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,9030,2,1,0)
 ;;=This will become the namespace of the compiled routine(s).
 ;;^UTILITY(U,$J,.84,9030,5,0)
 ;;=^.841^4^4
 ;;^UTILITY(U,$J,.84,9030,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,9030,5,2,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,9030,5,3,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,9030,5,4,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,9031,0)
 ;;=9031^2^^5
 ;;^UTILITY(U,$J,.84,9031,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9031,1,1,0)
 ;;=Help for the reader: Freetext
 ;;^UTILITY(U,$J,.84,9031,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9031,2,1,0)
 ;;=This response can be free text
 ;;^UTILITY(U,$J,.84,9032,0)
 ;;=9032^2^^5
 ;;^UTILITY(U,$J,.84,9032,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9032,1,1,0)
 ;;=Help for the reader: Set of codes
 ;;^UTILITY(U,$J,.84,9032,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9032,2,1,0)
 ;;=Enter a code from the list.
 ;;^UTILITY(U,$J,.84,9033,0)
 ;;=9033^2^^5
 ;;^UTILITY(U,$J,.84,9033,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9033,1,1,0)
 ;;=Help for the reader: End of page
 ;;^UTILITY(U,$J,.84,9033,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9033,2,1,0)
 ;;=Enter either <Enter> or '^'
 ;;^UTILITY(U,$J,.84,9034,0)
 ;;=9034^2^^5
 ;;^UTILITY(U,$J,.84,9034,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9034,1,1,0)
 ;;=Help for the reader: Numbers
 ;;^UTILITY(U,$J,.84,9034,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9034,2,1,0)
 ;;=This response must be a number
 ;;^UTILITY(U,$J,.84,9035,0)
 ;;=9035^2^^5
 ;;^UTILITY(U,$J,.84,9035,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9035,1,1,0)
 ;;=Help for the reader: dates
 ;;^UTILITY(U,$J,.84,9035,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9035,2,1,0)
 ;;=This response must be a date
 ;;^UTILITY(U,$J,.84,9036,0)
 ;;=9036^2^^5
 ;;^UTILITY(U,$J,.84,9036,1,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9036,1,1,0)
 ;;=Help for the reader: List
 ;;^UTILITY(U,$J,.84,9036,2,0)
 ;;=^^1^1^2940310^
 ;;^UTILITY(U,$J,.84,9036,2,1,0)
 ;;=This response must be a list or range, e.g., 1,3,5 or 2-4,8
 ;;^UTILITY(U,$J,.84,9037,0)
 ;;=9037^3^^5
 ;;^UTILITY(U,$J,.84,9037,1,0)
 ;;=^^1^1^2940316^^
 ;;^UTILITY(U,$J,.84,9037,1,1,0)
 ;;=Help for leaving form
 ;;^UTILITY(U,$J,.84,9037,2,0)
 ;;=^^3^3^2940316^^
 ;;^UTILITY(U,$J,.84,9037,2,1,0)
 ;;=Enter 'Y' to save before exiting.
 ;;^UTILITY(U,$J,.84,9037,2,2,0)
 ;;=Enter 'N' or '^' to exit without saving.
 ;;^UTILITY(U,$J,.84,9037,2,3,0)
 ;;=Press <Enter> to return to form
 ;;^UTILITY(U,$J,.84,9038,0)
 ;;=9038^3^^5
 ;;^UTILITY(U,$J,.84,9038,1,0)
 ;;=^^1^1^2940316^
 ;;^UTILITY(U,$J,.84,9038,1,1,0)
 ;;=Help for (Sub)record delete in forms
 ;;^UTILITY(U,$J,.84,9038,2,0)
 ;;=^^2^2^2940316^
 ;;^UTILITY(U,$J,.84,9038,2,1,0)
 ;;=Enter 'Y' to delete.
 ;;^UTILITY(U,$J,.84,9038,2,2,0)
 ;;=Enter 'N' or <Enter> to return to form.
 ;;^UTILITY(U,$J,.84,9040,0)
 ;;=9040^2^^5
 ;;^UTILITY(U,$J,.84,9040,1,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,9040,1,1,0)
 ;;=Reader Help for Yes/No question
 ;;^UTILITY(U,$J,.84,9040,2,0)
 ;;=^^1^1^2940314^
 ;;^UTILITY(U,$J,.84,9040,2,1,0)
 ;;=Enter either 'Y' or 'N'.
 ;;^UTILITY(U,$J,.84,9041,0)
 ;;=9041^3^^5
 ;;^UTILITY(U,$J,.84,9041,1,0)
 ;;=^^2^2^2940608^^^^
 ;;^UTILITY(U,$J,.84,9041,1,1,0)
 ;;=Help message for why the Compare/Merge options should be run during
 ;;^UTILITY(U,$J,.84,9041,1,2,0)
 ;;=non-peak hours.
 ;;^UTILITY(U,$J,.84,9041,2,0)
 ;;=^^8^8^2940608^
