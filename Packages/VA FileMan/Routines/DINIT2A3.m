DINIT2A3 ;SFISC/MKO-KEY AND INDEX FILES ;3:21 PM  25 Apr 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,20,108**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A4
Q Q
 ;;^DD(.111,1,21,6,0)
 ;;=Index file entry.
 ;;^DD(.111,1,"DT")
 ;;=2960124
 ;;^DD(.112,0)
 ;;=OVERFLOW KILL LOGIC SUB-FIELD^^2^2
 ;;^DD(.112,0,"DT")
 ;;=2960124
 ;;^DD(.112,0,"NM","OVERFLOW KILL LOGIC")
 ;;=
 ;;^DD(.112,0,"UP")
 ;;=.11
 ;;^DD(.112,.01,0)
 ;;=OVERFLOW KILL LOGIC NODE^MNJ6,0X^^0;1^K:+X'=X!(X>999999)!(X<1)!(X?.E1"."1N.N) X S:$D(X) DINUM=X
 ;;^DD(.112,.01,3)
 ;;=Type a Number between 1 and 999999, 0 Decimal Digits. Answer '??' for more help.
 ;;^DD(.112,.01,21,0)
 ;;=^^3^3^2980911^
 ;;^DD(.112,.01,21,1,0)
 ;;=Answer must be the number of the node under which the additional line of
 ;;^DD(.112,.01,21,2,0)
 ;;=Set Logic will be filed. Use the overflow nodes if the kill logic is too
 ;;^DD(.112,.01,21,3,0)
 ;;=long to fit in the KILL LOGIC field.
 ;;^DD(.112,.01,"DT")
 ;;=2980910
 ;;^DD(.112,2,0)
 ;;=OVERFLOW KILL LOGIC^RK^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.112,2,3)
 ;;=Answer must be Standard M code. Answer '??' for more help.
 ;;^DD(.112,2,9)
 ;;=@
 ;;^DD(.112,2,21,0)
 ;;=^^6^6^2980911^
 ;;^DD(.112,2,21,1,0)
 ;;=Answer with the M code of the additional kill logic stored at this node.
 ;;^DD(.112,2,21,2,0)
 ;;=FileMan will not automatically execute this additional code, so the kill
 ;;^DD(.112,2,21,3,0)
 ;;=logic must invoke the additional code stored in this overflow node.
 ;;^DD(.112,2,21,4,0)
 ;;= 
 ;;^DD(.112,2,21,5,0)
 ;;=The M code can assume that DIXR contains the internal entry number of the
 ;;^DD(.112,2,21,6,0)
 ;;=Index file entry.
 ;;^DD(.112,2,"DT")
 ;;=2960124
 ;;^DD(.114,0)
 ;;=CROSS-REFERENCE VALUES SUB-FIELD^^8^12
 ;;^DD(.114,0,"DT")
 ;;=2980723
 ;;^DD(.114,0,"ID",1)
 ;;=W ""
 ;;^DD(.114,0,"IX","B",.114,.01)
 ;;=
 ;;^DD(.114,0,"NM","CROSS-REFERENCE VALUES")
 ;;=
 ;;^DD(.114,0,"UP")
 ;;=.11
 ;;^DD(.114,.01,0)
 ;;=ORDER NUMBER^MNJ3,0^^0;1^K:+X'=X!(X>125)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.114,.01,1,0)
 ;;=^.1
 ;;^DD(.114,.01,1,1,0)
 ;;=.114^B
 ;;^DD(.114,.01,1,1,1)
 ;;=S ^DD("IX",DA(1),11.1,"B",$E(X,1,30),DA)=""
 ;;^DD(.114,.01,1,1,2)
 ;;=K ^DD("IX",DA(1),11.1,"B",$E(X,1,30),DA)
 ;;^DD(.114,.01,1,1,"DT")
 ;;=2970320
 ;;^DD(.114,.01,3)
 ;;=Type a Number between 1 and 125, 0 Decimal Digits. Answer '??' for more help.
 ;;^DD(.114,.01,21,0)
 ;;=^^6^6^2980911^
 ;;^DD(.114,.01,21,1,0)
 ;;=Answer must be the order number of this cross-reference value.
 ;;^DD(.114,.01,21,2,0)
 ;;= 
 ;;^DD(.114,.01,21,3,0)
 ;;=FileMan evaluates cross-reference values by order of "Order Number" and
 ;;^DD(.114,.01,21,4,0)
 ;;=places each value in the X(order#) array. The set and kill logic, for
 ;;^DD(.114,.01,21,5,0)
 ;;=example, can use X(2) to refer to the cross-reference value with order
 ;;^DD(.114,.01,21,6,0)
 ;;=number 2.
 ;;^DD(.114,.01,"DEL",1,0)
 ;;=I $P($G(DDS),U,2)="DIKC EDIT" D BLDLOG^DIKCFORM(DA(1)) S DIKCREB=1 I 0
 ;;^DD(.114,.01,"DT")
 ;;=3020425
 ;;^DD(.114,.5,0)
 ;;=SUBSCRIPT NUMBER^NJ3,0^^0;6^K:+X'=X!(X>125)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(.114,.5,1,0)
 ;;=^.1^^0
 ;;^DD(.114,.5,3)
 ;;=Type a Number between 1 and 125, 0 Decimal Digits. Answer '??' for more help.
 ;;^DD(.114,.5,21,0)
 ;;=^^3^3^2980911^
 ;;^DD(.114,.5,21,1,0)
 ;;=If this cross-reference value is used as a subscript in an index, enter
 ;;^DD(.114,.5,21,2,0)
 ;;=the subscript position number. The first subscript to the right of the
 ;;^DD(.114,.5,21,3,0)
 ;;=index name is subscript number 1.
 ;;^DD(.114,.5,"DT")
 ;;=2980611
 ;;^DD(.114,1,0)
 ;;=TYPE OF VALUE^RS^F:FIELD;C:COMPUTED VALUE;^0;2^Q
 ;;^DD(.114,1,3)
 ;;=Answer '??' for more help.
 ;;^DD(.114,1,21,0)
 ;;=^^4^4^2980911^
 ;;^DD(.114,1,21,1,0)
 ;;=Answer 'F' if this cross-reference value is based on the value of a field.
 ;;^DD(.114,1,21,2,0)
 ;;= 
 ;;^DD(.114,1,21,3,0)
 ;;=Answer 'C' if this cross-reference value should be determined by executing
 ;;^DD(.114,1,21,4,0)
 ;;=the COMPUTED CODE.
 ;;^DD(.114,1,"DT")
 ;;=2960116
 ;;^DD(.114,2,0)
 ;;=FILE^NJ20,7^^0;3^K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.114,2,3)
 ;;=Answer must be between 0 and 999999999999, with up to 7 decimal digits. Answer '??' for more help.
 ;;^DD(.114,2,21,0)
 ;;=^^2^2^2980910^
 ;;^DD(.114,2,21,1,0)
 ;;=If this cross-reference value is a field value, answer with the number of
 ;;^DD(.114,2,21,2,0)
 ;;=the file or subfile in which this field is defined.
 ;;^DD(.114,2,"DT")
 ;;=2960116
 ;;^DD(.114,3,0)
 ;;=FIELD^NJ20,7X^^0;4^D ITFLD^DIKCDD I $D(X) K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.114,3,3)
 ;;=Type a Number between 0 and 999999999999, 7 Decimal Digits. Answer '??' for more help.
 ;;^DD(.114,3,4)
 ;;=D EHFLD^DIKCDD
 ;;^DD(.114,3,21,0)
 ;;=^^1^1^2980910^^
 ;;^DD(.114,3,21,1,0)
 ;;=If this cross-reference value is a field, answer with the field number.
 ;;^DD(.114,3,"DT")
 ;;=2970902
 ;;^DD(.114,4,0)
 ;;=COMPUTED VALUE^F^^1;1^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.114,4,3)
 ;;=Answer must be a valid FileMan computed expression. Answer '??' for more help.
 ;;^DD(.114,4,21,0)
 ;;=^^2^2^2960221^
 ;;^DD(.114,4,21,1,0)
 ;;=If this cross-reference value is computed, answer with the computed
 ;;^DD(.114,4,21,2,0)
 ;;=expression that evaluates to it.
 ;;^DD(.114,4,"DT")
 ;;=2960219
 ;;^DD(.114,4.5,0)
 ;;=COMPUTED CODE^K^^1.5;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.114,4.5,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.114,4.5,9)
 ;;=@
 ;;^DD(.114,4.5,21,0)
 ;;=^^3^3^2990401^
 ;;^DD(.114,4.5,21,1,0)
 ;;=Answer with M code that sets X equal to the cross-reference value. The
 ;;^DD(.114,4.5,21,2,0)
 ;;=X(order#) array is available for those cross-reference values with lower
 ;;^DD(.114,4.5,21,3,0)
 ;;=Order Numbers, and the DA array describes the IEN of the current record.
 ;;^DD(.114,4.5,"DT")
 ;;=2960221
 ;;^DD(.114,5,0)
 ;;=TRANSFORM FOR STORAGE^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.114,5,3)
 ;;=This is Standard M code. Answer '??' for more help.
 ;;^DD(.114,5,9)
 ;;=@
 ;;^DD(.114,5,21,0)
 ;;=^^14^14^3000106^
 ;;^DD(.114,5,21,1,0)
 ;;=Used only when setting or killing an entry in the index.
 ;;^DD(.114,5,21,2,0)
 ;;= 
 ;;^DD(.114,5,21,3,0)
 ;;=Answer should be M code that sets the variable X to a new value. X is the
 ;;^DD(.114,5,21,4,0)
 ;;=only input variable that is guaranteed to be defined and is equal to the
 ;;^DD(.114,5,21,5,0)
 ;;=internal value of the field.
 ;;^DD(.114,5,21,6,0)
 ;;= 
 ;;^DD(.114,5,21,7,0)
 ;;=TRANSFORM FOR STORAGE can be used on field-type cross-reference values to
 ;;^DD(.114,5,21,8,0)
 ;;=transform the internal value of the field before it is stored as a
 ;;^DD(.114,5,21,9,0)
 ;;=subscript in the index.
 ;;^DD(.114,5,21,10,0)
 ;;= 
 ;;^DD(.114,5,21,11,0)
 ;;=If a match is made on this index during a lookup, then in order to
 ;;^DD(.114,5,21,12,0)
 ;;=properly display the resulting index value to the user, the developer may
 ;;^DD(.114,5,21,13,0)
 ;;=need to enter code into the TRANSFORM FOR DISPLAY field to transform the
 ;;^DD(.114,5,21,14,0)
 ;;=index value back to a displayable format.
 ;;^DD(.114,5,"DT")
 ;;=2980731
