DINIT122 ;SFISC/MKO-SORT TEMPLATE FILE ;1:13 PM  13 Nov 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT123
Q Q
 ;;^DD(.4011624,3.1,21,3,0)
 ;;=the sort qualifiers for page breaks (#) or rankings (!).  
 ;;^DD(.4011624,3.1,21,4,0)
 ;;= 
 ;;^DD(.4011624,3.1,21,5,0)
 ;;=The # and/or ! are the only qualifiers that can be used.  Others,
 ;;^DD(.4011624,3.1,21,6,0)
 ;;=such as + for subtotals, cannot be used.
 ;;^DD(.4011624,3.1,23,0)
 ;;=^^1^1^2960910^^
 ;;^DD(.4011624,3.1,23,1,0)
 ;;=Equivalent to the 1st piece of DISPAR(0,n) in the EN1^DIP call.
 ;;^DD(.4011624,3.1,"DT")
 ;;=2960910
 ;;^DD(.4011624,3.2,0)
 ;;=DISPAR(0,n) PIECE TWO^FX^^1;2^K:$L(X)>50!($L(X)<1)!'((X[";""")!(X[";L")!(X[";C")!(X[";S")) X
 ;;^DD(.4011624,3.2,3)
 ;;=Answer with qualifiers like ;"" or ;S2;C10;L30;"VALUE: "
 ;;^DD(.4011624,3.2,21,0)
 ;;=^^12^12^2960910^^^
 ;;^DD(.4011624,3.2,21,1,0)
 ;;=As when defining the second piece of DISPAR(0,n) in a programmer
 ;;^DD(.4011624,3.2,21,2,0)
 ;;=call that includes BY(0) when calling EN1^DIP, this field can hold
 ;;^DD(.4011624,3.2,21,3,0)
 ;;=the sort qualifiers that normally appear after a sort-by field in
 ;;^DD(.4011624,3.2,21,4,0)
 ;;=interactive mode.  The ones that can be used are as follows:
 ;;^DD(.4011624,3.2,21,5,0)
 ;;= 
 ;;^DD(.4011624,3.2,21,6,0)
 ;;= ;""         to have the subheader appear
 ;;^DD(.4011624,3.2,21,7,0)
 ;;= ;"caption"  to give the subheader a caption
 ;;^DD(.4011624,3.2,21,8,0)
 ;;= ;Ln         to left-justify the subheader to n characters
 ;;^DD(.4011624,3.2,21,9,0)
 ;;= ;Cn         to start the display in the nth column
 ;;^DD(.4011624,3.2,21,10,0)
 ;;= ;Sn         to skip n lines before each subheader
 ;;^DD(.4011624,3.2,21,11,0)
 ;;= 
 ;;^DD(.4011624,3.2,21,12,0)
 ;;=If this field is null, subheaders are supressed (@ is assumed).
 ;;^DD(.4011624,3.2,23,0)
 ;;=^^3^3^2960910^^^
 ;;^DD(.4011624,3.2,23,1,0)
 ;;=Equivalent to the 2nd piece of DISPAR(0,n) in the EN1^DIP call.
 ;;^DD(.4011624,3.2,23,2,0)
 ;;=Note that if DISPAR(0,n) is defined, subheaders will appear even if
 ;;^DD(.4011624,3.2,23,3,0)
 ;;=used with a print template that normally suppresses subheaders.
 ;;^DD(.4011624,3.2,"DT")
 ;;=2960911
 ;;^DD(.4011624,4,0)
 ;;=DISPAR(0,n,OUT)^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.4011624,4,3)
 ;;=Enter code to transform subscript.  This is Standard M code.
 ;;^DD(.4011624,4,9)
 ;;=@
 ;;^DD(.4011624,4,21,0)
 ;;=^^7^7^2960829^^^^
 ;;^DD(.4011624,4,21,1,0)
 ;;=As when defining DISPAR(0,n,"OUT") for a call to EN1^DIP that includes
 ;;^DD(.4011624,4,21,2,0)
 ;;=BY(0), enter M code that will transform the sort-by value for this 
 ;;^DD(.4011624,4,21,3,0)
 ;;=subscript (n) when it is output (e.g. printed).  At the time
 ;;^DD(.4011624,4,21,4,0)
 ;;=the code is executed the untransformed value of the subscript will be in
 ;;^DD(.4011624,4,21,5,0)
 ;;=Y.  The code should put the transformed value back into Y.
 ;;^DD(.4011624,4,21,6,0)
 ;;= 
 ;;^DD(.4011624,4,21,7,0)
 ;;=For example, for an inverse date, S:Y Y=99999999-Y S Y=$$FMTE^XLFDT(Y)"
 ;;^DD(.4011624,4,23,0)
 ;;=^^2^2^2960829^^^^
 ;;^DD(.4011624,4,23,1,0)
 ;;=Equivalent to the DISPAR(0,n,"OUT") input variable to the programmer call
 ;;^DD(.4011624,4,23,2,0)
 ;;=EN1^DIP.
 ;;^DD(.4011624,4,"DT")
 ;;=2960829
 ;;^DD(.4012,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.4012,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.4012,0,"UP")
 ;;=.401
 ;;^DD(.4012,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.4014,0)
 ;;=SORT FIELD DATA SUB-FIELD^^21^27
 ;;^DD(.4014,0,"DT")
 ;;=2931221
 ;;^DD(.4014,0,"IX","B",.4014,.01)
 ;;=
 ;;^DD(.4014,0,"NM","SORT FIELD DATA")
 ;;=
 ;;^DD(.4014,0,"UP")
 ;;=.401
 ;;^DD(.4014,.01,0)
 ;;=FILE OR SUBFILE NO.^MRNJ13,5^^0;1^K:+X'=X!(X>9999999.99999)!(X<0)!(X?.E1"."6N.N) X
 ;;^DD(.4014,.01,1,0)
 ;;=^.1
 ;;^DD(.4014,.01,1,1,0)
 ;;=.4014^B
 ;;^DD(.4014,.01,1,1,1)
 ;;=S ^DIBT(DA(1),2,"B",$E(X,1,30),DA)=""
 ;;^DD(.4014,.01,1,1,2)
 ;;=K ^DIBT(DA(1),2,"B",$E(X,1,30),DA)
 ;;^DD(.4014,.01,3)
 ;;=Type a Number between 0 and 9999999.99999, 5 Decimal Digits.  File or subfile number on which sort field resides.
 ;;^DD(.4014,.01,21,0)
 ;;=^^3^3^2930125^^
 ;;^DD(.4014,.01,21,1,0)
 ;;=This is the number of the file or subfile on which the sort field
 ;;^DD(.4014,.01,21,2,0)
 ;;=resides.  It is created automatically during the SORT FIELDS dialogue
 ;;^DD(.4014,.01,21,3,0)
 ;;=with the user in the sort/print option.
 ;;^DD(.4014,.01,23,0)
 ;;=^^1^1^2930125^^
 ;;^DD(.4014,.01,23,1,0)
 ;;=This number is automatically assigned by the print routine DIP.
 ;;^DD(.4014,.01,"DT")
 ;;=2930125
 ;;^DD(.4014,2,0)
 ;;=FIELD NO.^NJ13,5^^0;2^K:+X'=X!(X>9999999.99999)!(X<0)!(X?.E1"."6N.N) X
 ;;^DD(.4014,2,3)
 ;;=Type a Number between 0 and 9999999.99999, 5 Decimal Digits.  Sort field number, except for pointers, variable pointers and computed fields.
 ;;^DD(.4014,2,21,0)
 ;;=^^4^4^2930125^
 ;;^DD(.4014,2,21,1,0)
 ;;=On most sort fields, this piece will contain the field number.  If sorting
 ;;^DD(.4014,2,21,2,0)
 ;;=on a pointer, variable pointer or computed field, the piece will be null.
 ;;^DD(.4014,2,21,3,0)
 ;;=If sorting on the record number (NUMBER or .001), the piece will contain
 ;;^DD(.4014,2,21,4,0)
 ;;=a 0.
 ;;^DD(.4014,2,23,0)
 ;;=^^1^1^2930125^
 ;;^DD(.4014,2,23,1,0)
 ;;=Created by FileMan during the print option (in the DIP* routines).
 ;;^DD(.4014,2,"DT")
 ;;=2930125
 ;;^DD(.4014,3,0)
 ;;=FIELD NAME^F^^0;3^K:$L(X)>100!($L(X)<1) X
 ;;^DD(.4014,3,3)
 ;;=Answer must be 1-100 characters in length.
 ;;^DD(.4014,3,21,0)
 ;;=^^2^2^2930125^
 ;;^DD(.4014,3,21,1,0)
 ;;=This piece contains the sort field name, or the user entry if sorting by
 ;;^DD(.4014,3,21,2,0)
 ;;=an on-the-fly computed field.
 ;;^DD(.4014,3,23,0)
 ;;=^^1^1^2930125^
 ;;^DD(.4014,3,23,1,0)
 ;;=Created by FileMan during the print option (DIP* routines).
 ;;^DD(.4014,3,"DT")
 ;;=2930125
 ;;^DD(.4014,4,0)
 ;;=SORT QUALIFIERS BEFORE FIELD^F^^0;4^K:$L(X)>20!($L(X)<1) X
 ;;^DD(.4014,4,3)
 ;;=Answer must be 1-20 characters in length.  Sort qualifiers that normally precede the field number in the user dialogue (like !,@,#,+)
 ;;^DD(.4014,4,21,0)
 ;;=^^5^5^2930125^^^
 ;;^DD(.4014,4,21,1,0)
 ;;=This contains all of the sort qualifiers that normally precede the field
 ;;^DD(.4014,4,21,2,0)
 ;;=number in the user dialogue during the sort option.  It includes things
 ;;^DD(.4014,4,21,3,0)
 ;;=like # (Page break when sort value changes), @ (suppress printing of
 ;;^DD(.4014,4,21,4,0)
 ;;=subheader).  These qualifiers are listed out with no delimiters, as they
 ;;^DD(.4014,4,21,5,0)
 ;;=are found during the user dialogue.  (So you might see something like #@).
