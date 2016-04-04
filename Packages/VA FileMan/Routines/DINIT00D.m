DINIT00D ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,1846,0)
 ;;=1846^1^y
 ;;^UTILITY(U,$J,.84,1846,1,0)
 ;;=^^1^1^2950317^^
 ;;^UTILITY(U,$J,.84,1846,1,1,0)
 ;;=A file or subfile must have only one string of fields associated with it.
 ;;^UTILITY(U,$J,.84,1846,2,0)
 ;;=^^1^1^2950317^^
 ;;^UTILITY(U,$J,.84,1846,2,1,0)
 ;;=File #|FILE| appears more than once in the import with different fields.
 ;;^UTILITY(U,$J,.84,1846,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1846,3,1,0)
 ;;=FILE^File or subfile number.
 ;;^UTILITY(U,$J,.84,1850,0)
 ;;=1850^1^^5
 ;;^UTILITY(U,$J,.84,1850,1,0)
 ;;=^^4^4^2960718^^
 ;;^UTILITY(U,$J,.84,1850,1,1,0)
 ;;=The device for printing the Import report was not properly specified.
 ;;^UTILITY(U,$J,.84,1850,1,2,0)
 ;;=This could be caused either by a user's response or by the  
 ;;^UTILITY(U,$J,.84,1850,1,3,0)
 ;;=device specifications passed to the FILE^DDMP call.  The problem
 ;;^UTILITY(U,$J,.84,1850,1,4,0)
 ;;=could involve either device or queuing instructions.
 ;;^UTILITY(U,$J,.84,1850,2,0)
 ;;=^^1^1^2960718^^
 ;;^UTILITY(U,$J,.84,1850,2,1,0)
 ;;=There is an error in device selection or queuing setup.
 ;;^UTILITY(U,$J,.84,1860,0)
 ;;=1860^1^^5
 ;;^UTILITY(U,$J,.84,1860,1,0)
 ;;=^^1^1^2960906^
 ;;^UTILITY(U,$J,.84,1860,1,1,0)
 ;;=The record being imported has no data.
 ;;^UTILITY(U,$J,.84,1860,2,0)
 ;;=^^1^1^2960906^
 ;;^UTILITY(U,$J,.84,1860,2,1,0)
 ;;=The record being imported has no data.
 ;;^UTILITY(U,$J,.84,1862,0)
 ;;=1862^1^^5
 ;;^UTILITY(U,$J,.84,1862,1,0)
 ;;=^^4^4^2960906^^
 ;;^UTILITY(U,$J,.84,1862,1,1,0)
 ;;=When parsing the imported record, more fields were found than expected.
 ;;^UTILITY(U,$J,.84,1862,1,2,0)
 ;;=There were either more delimiter-pieces than expected or the length of a
 ;;^UTILITY(U,$J,.84,1862,1,3,0)
 ;;=fixed length import was too long.  This probably means that the incoming
 ;;^UTILITY(U,$J,.84,1862,1,4,0)
 ;;=file is corrupted.
 ;;^UTILITY(U,$J,.84,1862,2,0)
 ;;=^^1^1^2960906^^
 ;;^UTILITY(U,$J,.84,1862,2,1,0)
 ;;=There are more fields in the incoming record than expected.
 ;;^UTILITY(U,$J,.84,1870,0)
 ;;=1870^1^y^5
 ;;^UTILITY(U,$J,.84,1870,1,0)
 ;;=^^2^2^2960913^
 ;;^UTILITY(U,$J,.84,1870,1,1,0)
 ;;=A requested import template does not exist in the Import Template file
 ;;^UTILITY(U,$J,.84,1870,1,2,0)
 ;;=for the file being imported into.
 ;;^UTILITY(U,$J,.84,1870,2,0)
 ;;=^^1^1^2961002^^^
 ;;^UTILITY(U,$J,.84,1870,2,1,0)
 ;;=Import template |1| does not exist for File #|FILE|.
 ;;^UTILITY(U,$J,.84,1870,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,1870,3,1,0)
 ;;=1^Template name.
 ;;^UTILITY(U,$J,.84,1870,3,2,0)
 ;;=FILE^File number.
 ;;^UTILITY(U,$J,.84,3000,0)
 ;;=3000^1^^5
 ;;^UTILITY(U,$J,.84,3000,1,0)
 ;;=^^1^1^2930721^
 ;;^UTILITY(U,$J,.84,3000,1,1,0)
 ;;=Initial call to ^DDS failed.
 ;;^UTILITY(U,$J,.84,3000,2,0)
 ;;=^^1^1^2931202^
 ;;^UTILITY(U,$J,.84,3000,2,1,0)
 ;;=THE FORM COULD NOT BE INVOKED.
 ;;^UTILITY(U,$J,.84,3002,0)
 ;;=3002^1^y^5
 ;;^UTILITY(U,$J,.84,3002,1,0)
 ;;=^^1^1^2931202^
 ;;^UTILITY(U,$J,.84,3002,1,1,0)
 ;;=An error was encountered during Form compilation.
 ;;^UTILITY(U,$J,.84,3002,2,0)
 ;;=^^1^1^2931202^^
 ;;^UTILITY(U,$J,.84,3002,2,1,0)
 ;;=THE FORM "|1|" COULD NOT BE COMPILED.
 ;;^UTILITY(U,$J,.84,3002,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3002,3,1,0)
 ;;=1^Form name
 ;;^UTILITY(U,$J,.84,3011,0)
 ;;=3011^1^y^5
 ;;^UTILITY(U,$J,.84,3011,1,0)
 ;;=^^1^1^2931201^
 ;;^UTILITY(U,$J,.84,3011,1,1,0)
 ;;=The specified field is missing or invalid.
 ;;^UTILITY(U,$J,.84,3011,2,0)
 ;;=^^1^1^2931201^
 ;;^UTILITY(U,$J,.84,3011,2,1,0)
 ;;=The |1| field of the |2| file is missing or invalid.
 ;;^UTILITY(U,$J,.84,3011,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,3011,3,1,0)
 ;;=1^Field or subfield name
 ;;^UTILITY(U,$J,.84,3011,3,2,0)
 ;;=2^File name
 ;;^UTILITY(U,$J,.84,3012,0)
 ;;=3012^1^y^5
 ;;^UTILITY(U,$J,.84,3012,1,0)
 ;;=^^2^2^2931201^
 ;;^UTILITY(U,$J,.84,3012,1,1,0)
 ;;=The specified file or subfile does not exist; it is not present in the
 ;;^UTILITY(U,$J,.84,3012,1,2,0)
 ;;=data dictionary.
 ;;^UTILITY(U,$J,.84,3012,2,0)
 ;;=^^1^1^2931201^
 ;;^UTILITY(U,$J,.84,3012,2,1,0)
 ;;=File |1| does not exist.
 ;;^UTILITY(U,$J,.84,3012,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3012,3,1,0)
 ;;=1^File number or name
 ;;^UTILITY(U,$J,.84,3021,0)
 ;;=3021^1^y^5
 ;;^UTILITY(U,$J,.84,3021,1,0)
 ;;=^^1^1^2940811^^^
 ;;^UTILITY(U,$J,.84,3021,1,1,0)
 ;;=A lookup in to the Form file for the given form failed.
 ;;^UTILITY(U,$J,.84,3021,2,0)
 ;;=^^2^2^2940811^
 ;;^UTILITY(U,$J,.84,3021,2,1,0)
 ;;=Form |1| does not exist in the Form file, or DDSFILE is not the Primary
 ;;^UTILITY(U,$J,.84,3021,2,2,0)
 ;;=File of the form.
 ;;^UTILITY(U,$J,.84,3021,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3021,3,1,0)
 ;;=1^Form name
 ;;^UTILITY(U,$J,.84,3022,0)
 ;;=3022^1^y^5
 ;;^UTILITY(U,$J,.84,3022,1,0)
 ;;=^^1^1^2931130^^
 ;;^UTILITY(U,$J,.84,3022,1,1,0)
 ;;=There are no pages defined in the Page multiple of the given form.
 ;;^UTILITY(U,$J,.84,3022,2,0)
 ;;=^^1^1^2931130^^
 ;;^UTILITY(U,$J,.84,3022,2,1,0)
 ;;=Form |1| contains no pages.
 ;;^UTILITY(U,$J,.84,3022,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3022,3,1,0)
 ;;=1^Form name
 ;;^UTILITY(U,$J,.84,3023,0)
 ;;=3023^1^y^5
 ;;^UTILITY(U,$J,.84,3023,1,0)
 ;;=^^1^1^2931129^^
 ;;^UTILITY(U,$J,.84,3023,1,1,0)
 ;;=The given page was not found on the form.
 ;;^UTILITY(U,$J,.84,3023,2,0)
 ;;=^^1^1^2931129^^^
 ;;^UTILITY(U,$J,.84,3023,2,1,0)
 ;;=The form does not contain a page |1|.
 ;;^UTILITY(U,$J,.84,3023,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3023,3,1,0)
 ;;=1^Page name or number
 ;;^UTILITY(U,$J,.84,3031,0)
 ;;=3031^1^y^5
 ;;^UTILITY(U,$J,.84,3031,1,0)
 ;;=^^1^1^2931124^
 ;;^UTILITY(U,$J,.84,3031,1,1,0)
 ;;=The call to the specified ScreenMan utility failed.
 ;;^UTILITY(U,$J,.84,3031,2,0)
 ;;=^^1^1^2931124^
 ;;^UTILITY(U,$J,.84,3031,2,1,0)
 ;;=NOTE: The programmer call to the |1| ScreenMan utility failed.
 ;;^UTILITY(U,$J,.84,3031,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,3031,3,1,0)
 ;;=1^ScreenMan utility entry point.
 ;;^UTILITY(U,$J,.84,3041,0)
 ;;=3041^1^y^5
 ;;^UTILITY(U,$J,.84,3041,1,0)
 ;;=^^1^1^2931130^^
 ;;^UTILITY(U,$J,.84,3041,1,1,0)
 ;;=Errors were encountered while attempting to load the page.
 ;;^UTILITY(U,$J,.84,3041,2,0)
 ;;=^^1^1^2931130^
 ;;^UTILITY(U,$J,.84,3041,2,1,0)
 ;;=Page |1| (|2|) could not be loaded.
 ;;^UTILITY(U,$J,.84,3041,3,0)
 ;;=^.845^2^2
 ;;^UTILITY(U,$J,.84,3041,3,1,0)
 ;;=1^Page number
 ;;^UTILITY(U,$J,.84,3041,3,2,0)
 ;;=2^Page name
 ;;^UTILITY(U,$J,.84,3051,0)
 ;;=3051^1^y^5
