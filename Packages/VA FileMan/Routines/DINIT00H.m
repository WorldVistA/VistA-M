DINIT00H ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8019,2,0)
 ;;=^^1^1^2931105^
 ;;^UTILITY(U,$J,.84,8019,2,1,0)
 ;;=CROSS-REFERENCE ROUTINE
 ;;^UTILITY(U,$J,.84,8019,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8019,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,8020,0)
 ;;=8020^2^^5
 ;;^UTILITY(U,$J,.84,8020,1,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,8020,1,1,0)
 ;;=This prompt asks the user whether they are ready to compile, when
 ;;^UTILITY(U,$J,.84,8020,1,2,0)
 ;;=compiling TEMPLATES or CROSS-REFERENCES.
 ;;^UTILITY(U,$J,.84,8020,2,0)
 ;;=^^1^1^2931110^^
 ;;^UTILITY(U,$J,.84,8020,2,1,0)
 ;;=Should the compilation run now
 ;;^UTILITY(U,$J,.84,8020,5,0)
 ;;=^.841^4^4
 ;;^UTILITY(U,$J,.84,8020,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,8020,5,2,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8020,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8020,5,4,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8021,0)
 ;;=8021^2^^5
 ;;^UTILITY(U,$J,.84,8021,1,0)
 ;;=^^3^3^2931109^
 ;;^UTILITY(U,$J,.84,8021,1,1,0)
 ;;=Message from editing the CROSS-REFERENCE ROUTINE.  If this field is
 ;;^UTILITY(U,$J,.84,8021,1,2,0)
 ;;=deleted, the message notifies the user that the compiled routines will no
 ;;^UTILITY(U,$J,.84,8021,1,3,0)
 ;;=longer be used for re-indexing.
 ;;^UTILITY(U,$J,.84,8021,2,0)
 ;;=^^1^1^2931109^
 ;;^UTILITY(U,$J,.84,8021,2,1,0)
 ;;=The compiled routines will no longer be used for re-indexing.
 ;;^UTILITY(U,$J,.84,8021,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8021,5,1,0)
 ;;=DIU0^6
 ;;^UTILITY(U,$J,.84,8022,0)
 ;;=8022^2^^5
 ;;^UTILITY(U,$J,.84,8022,1,0)
 ;;=^^2^2^2931110^^^
 ;;^UTILITY(U,$J,.84,8022,1,1,0)
 ;;=Used when compiling PRINT templates, this is the prompt for the margin
 ;;^UTILITY(U,$J,.84,8022,1,2,0)
 ;;=width to be used for the printed report.
 ;;^UTILITY(U,$J,.84,8022,2,0)
 ;;=^^1^1^2931112^
 ;;^UTILITY(U,$J,.84,8022,2,1,0)
 ;;=Margin Width for output
 ;;^UTILITY(U,$J,.84,8022,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8022,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8023,0)
 ;;=8023^2^^5
 ;;^UTILITY(U,$J,.84,8023,1,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,8023,1,1,0)
 ;;=This is the help prompt for MARGIN WIDTH FOR OUTPUT, used when compiling
 ;;^UTILITY(U,$J,.84,8023,1,2,0)
 ;;=PRINT templates.
 ;;^UTILITY(U,$J,.84,8023,2,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,8023,2,1,0)
 ;;=Type a number from 19 to 255.  This is the number of columns
 ;;^UTILITY(U,$J,.84,8023,2,2,0)
 ;;=on the report
 ;;^UTILITY(U,$J,.84,8023,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8023,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8024,0)
 ;;=8024^2^y^5
 ;;^UTILITY(U,$J,.84,8024,1,0)
 ;;=^^1^1^2931110^^^^
 ;;^UTILITY(U,$J,.84,8024,1,1,0)
 ;;=This is the text that tells the user they are now compiling routines.
 ;;^UTILITY(U,$J,.84,8024,2,0)
 ;;=^^1^1^2931110^^^^
 ;;^UTILITY(U,$J,.84,8024,2,1,0)
 ;;=Compiling |1| |2| of File |3|.
 ;;^UTILITY(U,$J,.84,8024,3,0)
 ;;=^.845^3^3
 ;;^UTILITY(U,$J,.84,8024,3,1,0)
 ;;=1^Name of template, if compiling templates.
 ;;^UTILITY(U,$J,.84,8024,3,2,0)
 ;;=2^The words "print template", "cross-references", etc. (i.e., what is being compiled).
 ;;^UTILITY(U,$J,.84,8024,3,3,0)
 ;;=3^File name
 ;;^UTILITY(U,$J,.84,8024,5,0)
 ;;=^.841^6^6
 ;;^UTILITY(U,$J,.84,8024,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8024,5,2,0)
 ;;=DIPZ^EN
 ;;^UTILITY(U,$J,.84,8024,5,3,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8024,5,4,0)
 ;;=DIEZ^EN
 ;;^UTILITY(U,$J,.84,8024,5,5,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8024,5,6,0)
 ;;=DIKZ^EN
 ;;^UTILITY(U,$J,.84,8025,0)
 ;;=8025^2^y^5
 ;;^UTILITY(U,$J,.84,8025,1,0)
 ;;=^^2^2^2931110^^
 ;;^UTILITY(U,$J,.84,8025,1,1,0)
 ;;=Notify user that a routine has been filed.  Used during compilation of
 ;;^UTILITY(U,$J,.84,8025,1,2,0)
 ;;=TEMPLATES and CROSS-REFERENCES.
 ;;^UTILITY(U,$J,.84,8025,2,0)
 ;;=^^1^1^2931110^^^
 ;;^UTILITY(U,$J,.84,8025,2,1,0)
 ;;='|1|' ROUTINE FILED.
 ;;^UTILITY(U,$J,.84,8025,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8025,3,1,0)
 ;;=1^Routine name
 ;;^UTILITY(U,$J,.84,8025,5,0)
 ;;=^.841^8^7
 ;;^UTILITY(U,$J,.84,8025,5,1,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8025,5,2,0)
 ;;=DIKZ^EN
 ;;^UTILITY(U,$J,.84,8025,5,3,0)
 ;;=DIOZ^ENCU
 ;;^UTILITY(U,$J,.84,8025,5,5,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8025,5,6,0)
 ;;=DIPZ^EN
 ;;^UTILITY(U,$J,.84,8025,5,7,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8025,5,8,0)
 ;;=DIEZ^EN
 ;;^UTILITY(U,$J,.84,8026,0)
 ;;=8026^2^y^5
 ;;^UTILITY(U,$J,.84,8026,1,0)
 ;;=^^2^2^2931110^^^
 ;;^UTILITY(U,$J,.84,8026,1,1,0)
 ;;=Used to notify the user that templates or cross-references have been
 ;;^UTILITY(U,$J,.84,8026,1,2,0)
 ;;=UNCOMPILED.
 ;;^UTILITY(U,$J,.84,8026,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8026,2,1,0)
 ;;=|1| now uncompiled.
 ;;^UTILITY(U,$J,.84,8026,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8026,3,1,0)
 ;;=1^Contains the word 'TEMPLATE' or 'CROSS-REFERENCES'
 ;;^UTILITY(U,$J,.84,8026,5,0)
 ;;=^.841^6^6
 ;;^UTILITY(U,$J,.84,8026,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8026,5,2,0)
 ;;=DIPZ^EN
 ;;^UTILITY(U,$J,.84,8026,5,3,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8026,5,4,0)
 ;;=DIEZ^EN
 ;;^UTILITY(U,$J,.84,8026,5,5,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8026,5,6,0)
 ;;=DIKZ^EN
 ;;^UTILITY(U,$J,.84,8027,0)
 ;;=8027^2^^5
 ;;^UTILITY(U,$J,.84,8027,1,0)
 ;;=^^2^2^2931110^^^
 ;;^UTILITY(U,$J,.84,8027,1,1,0)
 ;;=Prompt for maximum routine size, used when compiling templates or
 ;;^UTILITY(U,$J,.84,8027,1,2,0)
 ;;=cross-references.
 ;;^UTILITY(U,$J,.84,8027,2,0)
 ;;=^^1^1^2931110^
 ;;^UTILITY(U,$J,.84,8027,2,1,0)
 ;;=Maximum routine size on this computer (in bytes).
 ;;^UTILITY(U,$J,.84,8027,5,0)
 ;;=^.841^3^3
 ;;^UTILITY(U,$J,.84,8027,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8027,5,2,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8027,5,3,0)
 ;;=DIKZ^ 
 ;;^UTILITY(U,$J,.84,8028,0)
 ;;=8028^2^y^5
 ;;^UTILITY(U,$J,.84,8028,1,0)
 ;;=^^2^2^2931110^^^^
 ;;^UTILITY(U,$J,.84,8028,1,1,0)
 ;;=Extended dialogue for asking user whether they wish to UNCOMPILE
 ;;^UTILITY(U,$J,.84,8028,1,2,0)
 ;;=a previously compiled template or cross-references.
 ;;^UTILITY(U,$J,.84,8028,2,0)
 ;;=^^2^2^2931110^
 ;;^UTILITY(U,$J,.84,8028,2,1,0)
 ;;= |1| currently compiled under namespace |2|.
 ;;^UTILITY(U,$J,.84,8028,2,2,0)
 ;;=UNCOMPILE the |1|
 ;;^UTILITY(U,$J,.84,8028,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,8028,3,1,0)
 ;;=1^Contains the word 'TEMPLATE' or 'CROSS-REFERENCES'
 ;;^UTILITY(U,$J,.84,8028,3,2,0)
 ;;=2^Routine name under which templates were previously compiled.
 ;;^UTILITY(U,$J,.84,8028,5,0)
 ;;=^.841^4^4
 ;;^UTILITY(U,$J,.84,8028,5,1,0)
 ;;=DIPZ^ 
 ;;^UTILITY(U,$J,.84,8028,5,2,0)
 ;;=DIEZ^ 
 ;;^UTILITY(U,$J,.84,8028,5,3,0)
 ;;=DIKZ^ 
