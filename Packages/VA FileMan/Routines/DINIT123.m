DINIT123 ;SFISC/MKO-SORT TEMPLATE FILE ;19AR2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1048**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT124
Q Q
 ;;^DD(.4014,4,23,0)
 ;;=^^2^2^2930125^^
 ;;^DD(.4014,4,23,1,0)
 ;;=This information is parsed from the user dialogue or from the BY
 ;;^DD(.4014,4,23,2,0)
 ;;=input variable, by the FileMan print routines DIP*.
 ;;^DD(.4014,4,"DT")
 ;;=2930125
 ;;^DD(.4014,4.1,0)
 ;;=SORT QUALIFIERS AFTER FIELD^F^^0;5^K:$L(X)>70!($L(X)<1) X
 ;;^DD(.4014,4.1,3)
 ;;=Answer must be 1-70 characters in length.  Sort qualifiers that normally come after the field in the user dialogue (such as ;Cn, ;Ln, ;"Literal Subheader")
 ;;^DD(.4014,4.1,21,0)
 ;;=^^6^6^2930125^
 ;;^DD(.4014,4.1,21,1,0)
 ;;=This contains all of the sort qualifiers that normally come after the
 ;;^DD(.4014,4.1,21,2,0)
 ;;=field number in the user dialogue for the sort options.  It includes
 ;;^DD(.4014,4.1,21,3,0)
 ;;=things like ;Cn (specify position of subheader) and ;"literal" to
 ;;^DD(.4014,4.1,21,4,0)
 ;;=replace the caption of the subheader.  These qualifiers are listed with
 ;;^DD(.4014,4.1,21,5,0)
 ;;=no delimiters, as they are found in the user dialogue.  (So you might see
 ;;^DD(.4014,4.1,21,6,0)
 ;;=something like ;C10;"My Subheader").
 ;;^DD(.4014,4.1,23,0)
 ;;=^^2^2^2930125^
 ;;^DD(.4014,4.1,23,1,0)
 ;;=This information is parsed from the user dialogue or from the BY
 ;;^DD(.4014,4.1,23,2,0)
 ;;=input variable, by the FileMan print routines DIP*.
 ;;^DD(.4014,4.1,"DT")
 ;;=2930125
 ;;^DD(.4014,4.2,0)
 ;;=COMPUTED FIELD TYPE^F^^0;7^K:$L(X)>10!($L(X)<1) X
 ;;^DD(.4014,4.2,3)
 ;;=Answer must be 1-10 characters in length.  Set by the print routine to something that looks like second piece of 0 node of DD (data type information) for on-the-fly computed fields or .001 field.
 ;;^DD(.4014,4.2,21,0)
 ;;=^^4^4^2931022^
 ;;^DD(.4014,4.2,21,1,0)
 ;;=This piece will contain a "D" if on-the-fly computed field results in a
 ;;^DD(.4014,4.2,21,2,0)
 ;;=date.  It will be set to something like NJ6,0 if sorting by the .001
 ;;^DD(.4014,4.2,21,3,0)
 ;;=field. (These are the only values I have been able to find for this
 ;;^DD(.4014,4.2,21,4,0)
 ;;=field.)
 ;;^DD(.4014,4.2,23,0)
 ;;=^^3^3^2931022^
 ;;^DD(.4014,4.2,23,1,0)
 ;;=Set in C^DIP0 if DICOMP tells us that an on-the-fly computed field will
 ;;^DD(.4014,4.2,23,2,0)
 ;;=result in a date, and in ^DIP is sorting by the .001 field on a file that
 ;;^DD(.4014,4.2,23,3,0)
 ;;=has one.
 ;;^DD(.4014,4.2,"DT")
 ;;=2931022
 ;;^DD(.4014,4.3,0)
 ;;=ASK FOR FROM AND TO^S^1:YES;^ASK;1^Q
 ;;^DD(.4014,4.3,3)
 ;;=Enter 1 (YES) if user is to be prompted for FROM/TO values for this SORT FIELD.
 ;;^DD(.4014,4.3,21,0)
 ;;=^^3^3^2930201^
 ;;^DD(.4014,4.3,21,1,0)
 ;;=If this node is defined: then when the PRINT Option is run, or during
 ;;^DD(.4014,4.3,21,2,0)
 ;;=a call to the programmer print EN1^DIP, the user will be prompted
 ;;^DD(.4014,4.3,21,3,0)
 ;;=for FROM and TO VALUES for this sort field.
 ;;^DD(.4014,4.3,23,0)
 ;;=^^4^4^2930201^
 ;;^DD(.4014,4.3,23,1,0)
 ;;=This field is created automatically when a template is being created or
 ;;^DD(.4014,4.3,23,2,0)
 ;;=edited, if the developer enters FROM/TO values, AND if the developer
 ;;^DD(.4014,4.3,23,3,0)
 ;;=then answers YES to the question "SHOULD TEMPLATE USER BE ASKED
 ;;^DD(.4014,4.3,23,4,0)
 ;;='FROM'-'TO' RANGE FOR field?"
 ;;^DD(.4014,4.3,"DT")
 ;;=2930201
 ;;^DD(.4014,5,0)
 ;;=FROM VALUE INTERNAL^F^^F;1^K:$L(X)>63!($L(X)<1) X
 ;;^DD(.4014,5,3)
 ;;=Answer must be 1-63 characters in length.  The starting point for the sort, derived by FileMan.
 ;;^DD(.4014,5,21,0)
 ;;=^^3^3^2930119^^
 ;;^DD(.4014,5,21,1,0)
 ;;=FileMan takes the FROM value entered by the user, and finds the first
 ;;^DD(.4014,5,21,2,0)
 ;;=value that will sort just before this value in order to derive the
 ;;^DD(.4014,5,21,3,0)
 ;;=starting point for the sort.
 ;;^DD(.4014,5,23,0)
 ;;=^^1^1^2930119^^
 ;;^DD(.4014,5,23,1,0)
 ;;=Calculated by the sort routine FRV^DIP1.
 ;;^DD(.4014,5,"DT")
 ;;=2930119
 ;;^DD(.4014,6,0)
 ;;=FROM VALUE EXTERNAL^F^^F;2^K:$L(X)>63!($L(X)<1) X
 ;;^DD(.4014,6,3)
 ;;=Answer must be 1-63 characters in length.  The starting point for the sort, as entered by the user.
 ;;^DD(.4014,6,21,0)
 ;;=^^1^1^2930115^
 ;;^DD(.4014,6,21,1,0)
 ;;=The FROM value for the sort, as it was entered by the user.
 ;;^DD(.4014,6,"DT")
 ;;=2930119
 ;;^DD(.4014,6.5,0)
 ;;=FROM VALUE PRINTABLE^F^^F;3^K:$L(X)>40!($L(X)<1) X
 ;;^DD(.4014,6.5,3)
 ;;=Answer must be 1-40 characters in length.  Used for storing printable form of date or set values.
 ;;^DD(.4014,6.5,21,0)
 ;;=^^3^3^2930216^^
 ;;^DD(.4014,6.5,21,1,0)
 ;;=This field is used to store a printable representation of the FROM value
 ;;^DD(.4014,6.5,21,2,0)
 ;;=entered by the user during the sort/print dialogue.  Used for date and
 ;;^DD(.4014,6.5,21,3,0)
 ;;=set-of-code data types.
 ;;^DD(.4014,6.5,23,0)
 ;;=^^1^1^2930216^
 ;;^DD(.4014,6.5,23,1,0)
 ;;=Built in CK^DIP12.
 ;;^DD(.4014,21401,0)
 ;;=FROM VALUE COMPUTATION^F^^FCOMPUTED;E1,245^D ^DIM
 ;;^DD(.4014,7,0)
 ;;=TO VALUE INTERNAL^F^^T;1^K:$L(X)>63!($L(X)<1) X
 ;;^DD(.4014,7,3)
 ;;=Answer must be 1-63 characters in length.  The ending point for the sort, derived by FileMan.
 ;;^DD(.4014,7,21,0)
 ;;=^^3^3^2930115^
 ;;^DD(.4014,7,21,1,0)
 ;;=FileMan usually uses the TO value as entered by the user, but in the
 ;;^DD(.4014,7,21,2,0)
 ;;=case of dates and sets of codes, the internal value is used.  This field
 ;;^DD(.4014,7,21,3,0)
 ;;=tells FileMan the ending point for the sort.
 ;;^DD(.4014,7,"DT")
 ;;=2930119
 ;;^DD(.4014,8,0)
 ;;=TO VALUE EXTERNAL^F^^T;2^K:$L(X)>63!($L(X)<1) X
 ;;^DD(.4014,8,3)
 ;;=Answer must be 1-63 characters in length.  The ending point for the sort, as entered by the user.
 ;;^DD(.4014,8,21,0)
 ;;=^^1^1^2930115^
 ;;^DD(.4014,8,21,1,0)
 ;;=The ending value for the sort, as entered by the user.
 ;;^DD(.4014,8,"DT")
 ;;=2930119
 ;;^DD(.4014,8.5,0)
 ;;=TO VALUE PRINTABLE^F^^T;3^K:$L(X)>40!($L(X)<1) X
 ;;^DD(.4014,8.5,3)
 ;;=Answer must be 1-40 characters in length.  Used for storing printable form of date and set values.
 ;;^DD(.4014,8.5,21,0)
 ;;=^^3^3^2930216^
 ;;^DD(.4014,8.5,21,1,0)
 ;;=This field is used to store a printable representation of the TO value
 ;;^DD(.4014,8.5,21,2,0)
 ;;=entered by the user during the sort/print dialogue.  Used for date and
 ;;^DD(.4014,8.5,21,3,0)
 ;;=set-of-code data types.
 ;;^DD(.4014,8.5,23,0)
 ;;=^^1^1^2930216^
 ;;^DD(.4014,8.5,23,1,0)
 ;;=Created in CK^DIP12.
 ;;^DD(.4014,21402,0)
 ;;=TO VALUE COMPUTATION^F^^TCOMPUTED;E1,245^D ^DIM
 ;;^DD(.4014,9,0)
 ;;=CROSS REFERENCE DATA^F^^IX;E1,245^K:$L(X)>245!($L(X)<1) X
