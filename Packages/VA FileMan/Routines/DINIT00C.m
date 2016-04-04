DINIT00C ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ; 3/30/99  10:41:48
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,1701,1,1,0)
 ;;=Transport structure does not contain SPECIFIC ELEMENT.
 ;;^UTILITY(U,$J,.84,1701,2,0)
 ;;=^^1^1^2940912^^^
 ;;^UTILITY(U,$J,.84,1701,2,1,0)
 ;;=Transport structure does not contain |1|.
 ;;^UTILITY(U,$J,.84,1701,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1701,3,1,0)
 ;;=1^Describes missing element in transport structure.
 ;;^UTILITY(U,$J,.84,1805,0)
 ;;=1805^1^
 ;;^UTILITY(U,$J,.84,1805,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,1805,1,1,0)
 ;;=For some reason a record or a field in a record could not be filed.  The cause
 ;;^UTILITY(U,$J,.84,1805,1,2,0)
 ;;=of the error should be present in another message.
 ;;^UTILITY(U,$J,.84,1805,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1805,2,1,0)
 ;;=An error occurred during the actual filing of data into the FileMan database.
 ;;^UTILITY(U,$J,.84,1810,0)
 ;;=1810^1^y
 ;;^UTILITY(U,$J,.84,1810,1,0)
 ;;=^^3^3^2950317^
 ;;^UTILITY(U,$J,.84,1810,1,1,0)
 ;;=The attempt to move data from a host file into the MUMPS environment
 ;;^UTILITY(U,$J,.84,1810,1,2,0)
 ;;=failed.  A possible cause is that the host file does not exist in the 
 ;;^UTILITY(U,$J,.84,1810,1,3,0)
 ;;=path specified.
 ;;^UTILITY(U,$J,.84,1810,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1810,2,1,0)
 ;;=The data from host file '|1|' could not be moved into a FileMan file.
 ;;^UTILITY(U,$J,.84,1810,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1810,3,1,0)
 ;;=1^Host file name.
 ;;^UTILITY(U,$J,.84,1812,0)
 ;;=1812^1^y
 ;;^UTILITY(U,$J,.84,1812,1,0)
 ;;=^^3^3^2950317^
 ;;^UTILITY(U,$J,.84,1812,1,1,0)
 ;;=A host file was located; however, no data was present in it.  This error
 ;;^UTILITY(U,$J,.84,1812,1,2,0)
 ;;=will also occur if the only "data" is the designation of file and fields
 ;;^UTILITY(U,$J,.84,1812,1,3,0)
 ;;=with no actual data present to file.
 ;;^UTILITY(U,$J,.84,1812,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1812,2,1,0)
 ;;=The host file, |1|, contains no data to import.
 ;;^UTILITY(U,$J,.84,1812,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1812,3,1,0)
 ;;=1^Host file name.
 ;;^UTILITY(U,$J,.84,1820,0)
 ;;=1820^1^y^5
 ;;^UTILITY(U,$J,.84,1820,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,1820,1,1,0)
 ;;=The foreign format name that was passed could not be found in the Foreign Format 
 ;;^UTILITY(U,$J,.84,1820,1,2,0)
 ;;=file.
 ;;^UTILITY(U,$J,.84,1820,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1820,2,1,0)
 ;;=There is no Foreign Format named '|1|'.
 ;;^UTILITY(U,$J,.84,1820,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,1820,3,1,0)
 ;;=1^Foreign format.
 ;;^UTILITY(U,$J,.84,1821,0)
 ;;=1821^1^
 ;;^UTILITY(U,$J,.84,1821,1,0)
 ;;=^^3^3^2960913^^^^
 ;;^UTILITY(U,$J,.84,1821,1,1,0)
 ;;=The format of the imported data must either be delimited by a specified 
 ;;^UTILITY(U,$J,.84,1821,1,2,0)
 ;;=character or be fixed length.  Either no format is specified
 ;;^UTILITY(U,$J,.84,1821,1,3,0)
 ;;=or it is both fixed length and delimited or it is neither.
 ;;^UTILITY(U,$J,.84,1821,2,0)
 ;;=^^2^2^2960913^^^^
 ;;^UTILITY(U,$J,.84,1821,2,1,0)
 ;;=The format of imported data must be fixed length or have a delimiter.
 ;;^UTILITY(U,$J,.84,1821,2,2,0)
 ;;=You may also specify a Foreign Format.
 ;;^UTILITY(U,$J,.84,1822,0)
 ;;=1822^1^
 ;;^UTILITY(U,$J,.84,1822,1,0)
 ;;=^^2^2^2960719^^
 ;;^UTILITY(U,$J,.84,1822,1,1,0)
 ;;=For a fixed length import, the length data for a field is impossible.  For
 ;;^UTILITY(U,$J,.84,1822,1,2,0)
 ;;=example, the length is zero or no length is given.
 ;;^UTILITY(U,$J,.84,1822,2,0)
 ;;=^^1^1^2960719^^
 ;;^UTILITY(U,$J,.84,1822,2,1,0)
 ;;=The length of a field is missing or incorrect.
 ;;^UTILITY(U,$J,.84,1831,0)
 ;;=1831^1^^5
 ;;^UTILITY(U,$J,.84,1831,1,0)
 ;;=^^6^6^2960919^
 ;;^UTILITY(U,$J,.84,1831,1,1,0)
 ;;=The Import Tool was expecting to find File and Field specifications
 ;;^UTILITY(U,$J,.84,1831,1,2,0)
 ;;=in the host file containing import data.  However, either the File
 ;;^UTILITY(U,$J,.84,1831,1,3,0)
 ;;=is not specified or the format of the specification is incorrect.
 ;;^UTILITY(U,$J,.84,1831,1,4,0)
 ;;=The first line of the host file should look exactly like this:
 ;;^UTILITY(U,$J,.84,1831,1,5,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,1831,1,6,0)
 ;;=FILE=filename
 ;;^UTILITY(U,$J,.84,1831,2,0)
 ;;=^^1^1^2960919^
 ;;^UTILITY(U,$J,.84,1831,2,1,0)
 ;;=The file name is either missing from the host file or incorrectly specified.
 ;;^UTILITY(U,$J,.84,1833,0)
 ;;=1833^1^
 ;;^UTILITY(U,$J,.84,1833,1,0)
 ;;=^^3^3^2950317^
 ;;^UTILITY(U,$J,.84,1833,1,1,0)
 ;;=The 'F' flag for the Import call means that the file and field information
 ;;^UTILITY(U,$J,.84,1833,1,2,0)
 ;;=is in the host file.  However, the file and/or fields parameter contained
 ;;^UTILITY(U,$J,.84,1833,1,3,0)
 ;;=data.  This conflicts with the 'F' flag.
 ;;^UTILITY(U,$J,.84,1833,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1833,2,1,0)
 ;;=The 'F' flag conflicts with the File or Fields parameter.
 ;;^UTILITY(U,$J,.84,1841,0)
 ;;=1841^1^
 ;;^UTILITY(U,$J,.84,1841,1,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1841,1,1,0)
 ;;=Only multiple fields can be in the path to a field.
 ;;^UTILITY(U,$J,.84,1841,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1841,2,1,0)
 ;;=A field other than a multiple is in the 'path'.
 ;;^UTILITY(U,$J,.84,1842,0)
 ;;=1842^1^
 ;;^UTILITY(U,$J,.84,1842,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,1842,1,1,0)
 ;;=The last field in a string of colon-delimited fields must be a field
 ;;^UTILITY(U,$J,.84,1842,1,2,0)
 ;;=containing data, not a multiple field.
 ;;^UTILITY(U,$J,.84,1842,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1842,2,1,0)
 ;;=A multiple field is shown as the last field is a string of fields.
 ;;^UTILITY(U,$J,.84,1844,0)
 ;;=1844^1^
 ;;^UTILITY(U,$J,.84,1844,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,1844,1,1,0)
 ;;=There must be at least one field in every subfile before moving down
 ;;^UTILITY(U,$J,.84,1844,1,2,0)
 ;;=into a lower level subfile.
 ;;^UTILITY(U,$J,.84,1844,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1844,2,1,0)
 ;;=A subfile level was skipped without specifying any fields in it.
 ;;^UTILITY(U,$J,.84,1845,0)
 ;;=1845^1^
 ;;^UTILITY(U,$J,.84,1845,1,0)
 ;;=^^2^2^2950317^
 ;;^UTILITY(U,$J,.84,1845,1,1,0)
 ;;=A field may only appear once in the designated fields for a particular 
 ;;^UTILITY(U,$J,.84,1845,1,2,0)
 ;;=file or subfile.
 ;;^UTILITY(U,$J,.84,1845,2,0)
 ;;=^^1^1^2950317^
 ;;^UTILITY(U,$J,.84,1845,2,1,0)
 ;;=The same field appears twice in the list of fields for a (sub)file.
