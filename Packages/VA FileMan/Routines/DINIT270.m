DINIT270 ;SFISC/DPC-LOAD OF FOREIGN FORMAT DD (CONT) ;1/4/94  13:37
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT271:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DD(.44,7,21,5,0)
 ;;=If 0 is entered, the user will be prompted for maximum length when
 ;;^DD(.44,7,21,6,0)
 ;;=creating the EXPORT template.  If nothing is entered, the default will be
 ;;^DD(.44,7,21,7,0)
 ;;=80.
 ;;^DD(.44,7,"DT")
 ;;=2921026
 ;;^DD(.44,8,0)
 ;;=QUOTE NON-NUMERIC FIELDS?^S^1:YES;0:NO;^0;10^Q
 ;;^DD(.44,8,3)
 ;;=Enter '1' for YES or '0' for NO.
 ;;^DD(.44,8,21,0)
 ;;=^^7^7^2921013^
 ;;^DD(.44,8,21,1,0)
 ;;=If you want the values of fields that have a data type other than numeric
 ;;^DD(.44,8,21,2,0)
 ;;=to be surrounded by quotation marks ("), set this field to YES.
 ;;^DD(.44,8,21,3,0)
 ;;= 
 ;;^DD(.44,8,21,4,0)
 ;;=NOTE:  Only numeric fields in the home file (including multiples) are
 ;;^DD(.44,8,21,5,0)
 ;;=automatically considered to have a numeric data type.  If you want the
 ;;^DD(.44,8,21,6,0)
 ;;=user to indicate which fields should be numeric, answer YES to the PROMPT
 ;;^DD(.44,8,21,7,0)
 ;;=FOR DATA TYPE? field.
 ;;^DD(.44,8,"DT")
 ;;=2921013
 ;;^DD(.44,9,0)
 ;;=PROMPT FOR DATA TYPE?^S^1:YES;0:NO;^0;11^Q
 ;;^DD(.44,9,3)
 ;;=Enter '1' for YES, '0' for NO.
 ;;^DD(.44,9,21,0)
 ;;=^^3^3^2921013^
 ;;^DD(.44,9,21,1,0)
 ;;=Answer YES if you want the user to be prompted for the data type of the
 ;;^DD(.44,9,21,2,0)
 ;;=various fields at the time that an export template is being created.
 ;;^DD(.44,9,21,3,0)
 ;;=Otherwise, the data types will be automatically  derived.
 ;;^DD(.44,9,"DT")
 ;;=2921013
 ;;^DD(.44,10,0)
 ;;=SEND LAST FIELD DELIMITER?^S^0:NO;1:YES;^0;12^Q
 ;;^DD(.44,10,3)
 ;;=Enter '1' for YES, '0' for NO.
 ;;^DD(.44,10,21,0)
 ;;=^^3^3^2921028^
 ;;^DD(.44,10,21,1,0)
 ;;=Enter NO if you do not want a field delimiter to be output after the last
 ;;^DD(.44,10,21,2,0)
 ;;=field in a record.  Enter YES if you do want a final field delimiter
 ;;^DD(.44,10,21,3,0)
 ;;=output.
 ;;^DD(.44,10,"DT")
 ;;=2921028
 ;;^DD(.44,20,0)
 ;;=FILE HEADER^FX^^1;E1,245^K:$L(X)>245!($L(X)<1) X I $E($G(X))'="""" K:DUZ(0)'="@" X D:$D(X) ^DIM
 ;;^DD(.44,20,3)
 ;;=Answer must be standard MUMPS code or a literal string in quotes.
 ;;^DD(.44,20,21,0)
 ;;=^^7^7^2921001^
 ;;^DD(.44,20,21,1,0)
 ;;=Use this field to produce output preceding the exported records.  This
 ;;^DD(.44,20,21,2,0)
 ;;=will become part of your exported data.
 ;;^DD(.44,20,21,3,0)
 ;;= 
 ;;^DD(.44,20,21,4,0)
 ;;=Enter either a literal string enclosed in quotation marks ("like this") or
 ;;^DD(.44,20,21,5,0)
 ;;=MUMPS code that will WRITE the desired output when XECUTED.  For example:
 ;;^DD(.44,20,21,6,0)
 ;;= 
 ;;^DD(.44,20,21,7,0)
 ;;=       W "EXPORT CREATED BY USER NUMBER: "_$G(DUZ)
 ;;^DD(.44,20,"DT")
 ;;=2921028
 ;;^DD(.44,25,0)
 ;;=FILE TRAILER^FX^^2;E1,245^K:$L(X)>245!($L(X)<1) X I $E($G(X))'="""" K:DUZ(0)'="@" X D:$D(X) ^DIM
 ;;^DD(.44,25,3)
 ;;=Answer must be standard MUMPS code or a literal string in quotes.
 ;;^DD(.44,25,21,0)
 ;;=^^7^7^2921001^
 ;;^DD(.44,25,21,1,0)
 ;;=Use this field to produce output following the the exported records.  This
 ;;^DD(.44,25,21,2,0)
 ;;=will become part of your exported data.
 ;;^DD(.44,25,21,3,0)
 ;;= 
 ;;^DD(.44,25,21,4,0)
 ;;=Enter either a literal string enclosed in quotation marks ("like this") or
 ;;^DD(.44,25,21,5,0)
 ;;=MUMPS code that will WRITE the desired output when XECUTED.  For example:
 ;;^DD(.44,25,21,6,0)
 ;;= 
 ;;^DD(.44,25,21,7,0)
 ;;=       W "EXPORT CREATED BY USER NUMBER: "_$G(DUZ)
 ;;^DD(.44,25,"DT")
 ;;=2921028
 ;;^DD(.44,27,0)
 ;;=DATE FORMAT^K^^6;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.44,27,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(.44,27,9)
 ;;=@
 ;;^DD(.44,27,21,0)
 ;;=^^6^6^2920923^
 ;;^DD(.44,27,21,1,0)
 ;;=If you want dates output in VA FileMan's standard external date/time
 ;;^DD(.44,27,21,2,0)
 ;;=format, make NO entry in this field.
 ;;^DD(.44,27,21,3,0)
 ;;= 
 ;;^DD(.44,27,21,4,0)
 ;;=If you want another format, enter MUMPS code here. The variable X will
 ;;^DD(.44,27,21,5,0)
 ;;=contain the date/time in VA FileMan's internal format.  The MUMPS code
 ;;^DD(.44,27,21,6,0)
 ;;=should SET Y to the date/time in the format you desire.
 ;;^DD(.44,27,"DT")
 ;;=2920923
 ;;^DD(.44,30,0)
 ;;=DESCRIPTION^.447^^3;0
 ;;^DD(.44,30,21,0)
 ;;=^^1^1^2920917^
 ;;^DD(.44,30,21,1,0)
 ;;=A description of the foreign format.
 ;;^DD(.44,31,0)
 ;;=USAGE NOTES^.448^^4;0
 ;;^DD(.44,31,21,0)
 ;;=^^2^2^2920917^
 ;;^DD(.44,31,21,1,0)
 ;;=Information about the use of the format; for example, which commands on
 ;;^DD(.44,31,21,2,0)
 ;;=the foreign system should be used to load the file.
