DINIT2A4 ;SFISC/MKO-KEY AND INDEX FILES ;3:01 PM  10 Jan 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,20**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A5
Q Q
 ;;^DD(.114,5.3,0)
 ;;=TRANSFORM FOR LOOKUP^K^^4;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.114,5.3,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.114,5.3,9)
 ;;=@
 ;;^DD(.114,5.3,21,0)
 ;;=^^10^10^3000106^
 ;;^DD(.114,5.3,21,1,0)
 ;;=Used only during lookup.
 ;;^DD(.114,5.3,21,2,0)
 ;;= 
 ;;^DD(.114,5.3,21,3,0)
 ;;=Answer should be M code that sets the variable X to a new value. X is the
 ;;^DD(.114,5.3,21,4,0)
 ;;=only input variable that is guaranteed to be defined and is equal to the
 ;;^DD(.114,5.3,21,5,0)
 ;;=lookup value entered by the user.
 ;;^DD(.114,5.3,21,6,0)
 ;;= 
 ;;^DD(.114,5.3,21,7,0)
 ;;=During lookup, if the lookup value is not found in the index, FileMan will
 ;;^DD(.114,5.3,21,8,0)
 ;;=execute the TRANSFORM FOR LOOKUP code to transform the lookup value X. It
 ;;^DD(.114,5.3,21,9,0)
 ;;=will then search this index looking for a match to the transformed lookup
 ;;^DD(.114,5.3,21,10,0)
 ;;=value.
 ;;^DD(.114,5.3,"DT")
 ;;=3000105
 ;;^DD(.114,5.5,0)
 ;;=TRANSFORM FOR DISPLAY^K^^3;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.114,5.5,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.114,5.5,9)
 ;;=@
 ;;^DD(.114,5.5,21,0)
 ;;=^^16^16^3000106^
 ;;^DD(.114,5.5,21,1,0)
 ;;=Used only during lookup.
 ;;^DD(.114,5.5,21,2,0)
 ;;= 
 ;;^DD(.114,5.5,21,3,0)
 ;;=Answer should be M code that sets the variable X to a new value. X is the
 ;;^DD(.114,5.5,21,4,0)
 ;;=only variable that is guaranteed to be defined and is equal to the value
 ;;^DD(.114,5.5,21,5,0)
 ;;=of the subscript from the index.
 ;;^DD(.114,5.5,21,6,0)
 ;;= 
 ;;^DD(.114,5.5,21,7,0)
 ;;=TRANSFORM FOR DISPLAY should be set only for an index value that has been
 ;;^DD(.114,5.5,21,8,0)
 ;;=transformed using the code in the TRANSFORM FOR STORAGE prior to storing
 ;;^DD(.114,5.5,21,9,0)
 ;;=the value in the index.
 ;;^DD(.114,5.5,21,10,0)
 ;;= 
 ;;^DD(.114,5.5,21,11,0)
 ;;=The code should take the internal value from the index subscript X, and
 ;;^DD(.114,5.5,21,12,0)
 ;;=convert it back to a format that can be displayed to an end user.  During
 ;;^DD(.114,5.5,21,13,0)
 ;;=lookup, if a match or matches are made to a lookup value that was
 ;;^DD(.114,5.5,21,14,0)
 ;;=transformed using the TRANSFORM FOR LOOKUP code on this index, then
 ;;^DD(.114,5.5,21,15,0)
 ;;=FileMan will execute the TRANSFORM FOR DISPLAY code before displaying the
 ;;^DD(.114,5.5,21,16,0)
 ;;=index value(s) to the end user.
 ;;^DD(.114,5.5,"DT")
 ;;=2980731
 ;;^DD(.114,6,0)
 ;;=MAXIMUM LENGTH^NJ3,0^^0;5^K:+X'=X!(X>240)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.114,6,3)
 ;;=Answer must be between 1 and 240, with no decimal digits. Answer '??' for more help.
 ;;^DD(.114,6,21,0)
 ;;=^^7^7^2980911^
 ;;^DD(.114,6,21,1,0)
 ;;=Answer must be the maximum length this cross-reference value should have
 ;;^DD(.114,6,21,2,0)
 ;;=when stored as a subscript in the index. FileMan's lookup utilties
 ;;^DD(.114,6,21,3,0)
 ;;=account for lookup values longer than the maximum length.
 ;;^DD(.114,6,21,4,0)
 ;;= 
 ;;^DD(.114,6,21,5,0)
 ;;=Specify a MAXIMUM LENGTH when an untruncated subscript may cause the
 ;;^DD(.114,6,21,6,0)
 ;;=length of a global reference in the index to exceed the M Portability
 ;;^DD(.114,6,21,7,0)
 ;;=Requirements.
 ;;^DD(.114,6,"DT")
 ;;=2960219
 ;;^DD(.114,7,0)
 ;;=COLLATION^S^F:forwards;B:backwards;^0;7^Q
 ;;^DD(.114,7,3)
 ;;=Answer '??' for more help.
 ;;^DD(.114,7,21,0)
 ;;=^^7^7^2980911^
 ;;^DD(.114,7,21,1,0)
 ;;=Answer with the direction FileMan's lookup utilities should $ORDER through
 ;;^DD(.114,7,21,2,0)
 ;;=this subscript when entries are returned or displayed to the user. If for
 ;;^DD(.114,7,21,3,0)
 ;;=example, you have a compound index on a Date of Birth field and a Name
 ;;^DD(.114,7,21,4,0)
 ;;=field, and you specify a COLLATION of 'backwards' on the Date of Birth
 ;;^DD(.114,7,21,5,0)
 ;;=value, the Lister and the Finder will return entries in reverse-date
 ;;^DD(.114,7,21,6,0)
 ;;=order. Likewise, question mark (?) help and partial matches in interactive
 ;;^DD(.114,7,21,7,0)
 ;;=^DIC lookups will display entries in reverse-date order.
 ;;^DD(.114,7,"DT")
 ;;=2970213
 ;;^DD(.114,8,0)
 ;;=LOOKUP PROMPT^F^^0;8^K:$L(X)>30!($L(X)<1) X
 ;;^DD(.114,8,3)
 ;;=Answer must be 1-30 characters in length. Answer '??' for more help.
 ;;^DD(.114,8,21,0)
 ;;=^^3^3^2980911^
 ;;^DD(.114,8,21,1,0)
 ;;=The text entered here will become a prompt for the user when this index is
 ;;^DD(.114,8,21,2,0)
 ;;=used for lookup (i.e., in the Classic FileMan calls to ^DIC.)  If the text
 ;;^DD(.114,8,21,3,0)
 ;;=is missing, then the FIELD LABEL will be used as a default.
 ;;^DD(.114,8,"DT")
 ;;=2970506
