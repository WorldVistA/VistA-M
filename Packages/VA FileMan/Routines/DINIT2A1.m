DINIT2A1 ;SFISC/MKO-KEY AND INDEX FILES ;8:42 AM  4 Jun 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A2
Q Q
 ;;^DD(.11,.42,21,5,0)
 ;;=the FileMan Sort and Print (EN1^DIP).
 ;;^DD(.11,.42,21,6,0)
 ;;= 
 ;;^DD(.11,.42,21,7,0)
 ;;=SORTING ONLY - The index name starts with "A". Calls to Classic FileMan
 ;;^DD(.11,.42,21,8,0)
 ;;=lookup (^DIC) or the Finder (FIND^DIC or $$FIND1^DIC) will not use this
 ;;^DD(.11,.42,21,9,0)
 ;;=index unless it is specified in the input parameters. The index will be
 ;;^DD(.11,.42,21,10,0)
 ;;=available for use by the FileMan Sort and Print (EN1^DIP).
 ;;^DD(.11,.42,21,11,0)
 ;;= 
 ;;^DD(.11,.42,21,12,0)
 ;;=ACTION - The index name starts with "A". This is used for M code that
 ;;^DD(.11,.42,21,13,0)
 ;;=performs some actions and does NOT build an index. Therefore, it is not
 ;;^DD(.11,.42,21,14,0)
 ;;=available for use by either the Classic FileMan lookup (^DIC), the Finder
 ;;^DD(.11,.42,21,15,0)
 ;;=(FIND^DIC or $$FIND1^DIC) or the Sort and Print (EN1^DIP).
 ;;^DD(.11,.42,"DT")
 ;;=2980416
 ;;^DD(.11,.5,0)
 ;;=ROOT TYPE^S^I:INDEX FILE;W:WHOLE FILE;^0;8^Q
 ;;^DD(.11,.5,3)
 ;;=Answer '??' for more help.
 ;;^DD(.11,.5,21,0)
 ;;=^^6^6^2980911^
 ;;^DD(.11,.5,21,1,0)
 ;;=Answer 'I' if the fields that make up the file are defined at the same
 ;;^DD(.11,.5,21,2,0)
 ;;=level at which the index is located.
 ;;^DD(.11,.5,21,3,0)
 ;;= 
 ;;^DD(.11,.5,21,4,0)
 ;;=Answer 'W' if this is a whole file cross-reference in which the fields
 ;;^DD(.11,.5,21,5,0)
 ;;=that make up the index are defined in a subfile, but the index is
 ;;^DD(.11,.5,21,6,0)
 ;;=physically located at a parent file level.
 ;;^DD(.11,.5,"DT")
 ;;=2980908
 ;;^DD(.11,.51,0)
 ;;=ROOT FILE^RNJ20,7^^0;9^K:+X'=X!(X>999999999999)!(X<0)!(X?.E1"."8N.N) X
 ;;^DD(.11,.51,1,0)
 ;;=^.1
 ;;^DD(.11,.51,1,1,0)
 ;;=.11^AC
 ;;^DD(.11,.51,1,1,1)
 ;;=S ^DD("IX","AC",$E(X,1,30),DA)=""
 ;;^DD(.11,.51,1,1,2)
 ;;=K ^DD("IX","AC",$E(X,1,30),DA)
 ;;^DD(.11,.51,1,1,3)
 ;;=Lets FileMan find indexes defined on fields from a particular file
 ;;^DD(.11,.51,1,1,"DT")
 ;;=2980929
 ;;^DD(.11,.51,3)
 ;;=Type a Number between 0 and 999999999999, 7 Decimal Digits. Answer '??' for more help.
 ;;^DD(.11,.51,21,0)
 ;;=^^3^3^2980910^
 ;;^DD(.11,.51,21,1,0)
 ;;=Answer with the number of the file or subfile where this index is defined.
 ;;^DD(.11,.51,21,2,0)
 ;;=For whole file indexes, answer with the subfile number, not the number of
 ;;^DD(.11,.51,21,3,0)
 ;;=the file where the index physically resides.
 ;;^DD(.11,.51,"DT")
 ;;=2980929
 ;;^DD(.11,1.1,0)
 ;;=SET LOGIC^RK^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.11,1.1,3)
 ;;=Answer must be Standard M code. Answer '??' for more help.
 ;;^DD(.11,1.1,9)
 ;;=@
 ;;^DD(.11,1.1,21,0)
 ;;=^^16^16^2990430^^
 ;;^DD(.11,1.1,21,1,0)
 ;;=Answer with the M code that FileMan should execute when the values of
 ;;^DD(.11,1.1,21,2,0)
 ;;=fields that make up the cross-reference are set or changed. When field
 ;;^DD(.11,1.1,21,3,0)
 ;;=values are changed, FileMan executes first the KILL LOGIC, then the SET
 ;;^DD(.11,1.1,21,4,0)
 ;;=LOGIC.
 ;;^DD(.11,1.1,21,5,0)
 ;;= 
 ;;^DD(.11,1.1,21,6,0)
 ;;=Assume the DA array describes the record to be cross-referenced, and that
 ;;^DD(.11,1.1,21,7,0)
 ;;=the X(order#) array contains values after the transform for storage is
 ;;^DD(.11,1.1,21,8,0)
 ;;=applied, but before the truncation to the maximum length.  The variable X
 ;;^DD(.11,1.1,21,9,0)
 ;;=also equals X(order#) of the lowest order number.
 ;;^DD(.11,1.1,21,10,0)
 ;;= 
 ;;^DD(.11,1.1,21,11,0)
 ;;=When fields that make up a cross-reference are edited and the kill and set
 ;;^DD(.11,1.1,21,12,0)
 ;;=logic are executed, the X1(order#) array contains the old field values,
 ;;^DD(.11,1.1,21,13,0)
 ;;=and the X2(order#) array contains the new field values. If a record is
 ;;^DD(.11,1.1,21,14,0)
 ;;=being added, and there is an X1(order#) array element that corresponds to
 ;;^DD(.11,1.1,21,15,0)
 ;;=the .01 field, it is set to null. When a record is deleted, all X2(order#)
 ;;^DD(.11,1.1,21,16,0)
 ;;=array elements are null.
 ;;^DD(.11,1.1,"DT")
 ;;=2960116
 ;;^DD(.11,1.2,0)
 ;;=OVERFLOW SET LOGIC^.111^^1.2;0
 ;;^DD(.11,1.2,"DT")
 ;;=2960124
 ;;^DD(.11,1.3,0)
 ;;=SET CONDITION^F^^1.3;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.11,1.3,3)
 ;;=Answer must be a valid FileMan computed expression. Answer '??' for more help.
 ;;^DD(.11,1.3,21,0)
 ;;=^^5^5^2960124^
 ;;^DD(.11,1.3,21,1,0)
 ;;=Answer with a FileMan computed expression that will evaluate to Boolean
 ;;^DD(.11,1.3,21,2,0)
 ;;=true (according to the M rules for Boolean interpretation). FileMan will
 ;;^DD(.11,1.3,21,3,0)
 ;;=evaluate this expression whenever it would normally execute the
 ;;^DD(.11,1.3,21,4,0)
 ;;=cross-reference's Set Logic, and will not execute the Set Logic unless
 ;;^DD(.11,1.3,21,5,0)
 ;;=this condition evaluates to true.
 ;;^DD(.11,1.3,"DT")
 ;;=2960116
 ;;^DD(.11,1.4,0)
 ;;=SET CONDITION CODE^K^^1.4;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.11,1.4,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.11,1.4,9)
 ;;=@
 ;;^DD(.11,1.4,21,0)
 ;;=^^15^15^2990430^
 ;;^DD(.11,1.4,21,1,0)
 ;;=This is MUMPS code that sets the variable X. The SET LOGIC is executed
 ;;^DD(.11,1.4,21,2,0)
 ;;=only if the SET CONDTION, if present, sets X to Boolean true (according to
 ;;^DD(.11,1.4,21,3,0)
 ;;=M rules for Boolean interpretation).
 ;;^DD(.11,1.4,21,4,0)
 ;;= 
 ;;^DD(.11,1.4,21,5,0)
 ;;=Assume the DA array describes the record to be cross-referenced, and that
 ;;^DD(.11,1.4,21,6,0)
 ;;=the X(order#) array contains values after the transform for storage is
 ;;^DD(.11,1.4,21,7,0)
 ;;=applied, but before the truncation to the maximum length.  The variable X
 ;;^DD(.11,1.4,21,8,0)
 ;;=also equals X(order#) of the lowest order number.
 ;;^DD(.11,1.4,21,9,0)
 ;;= 
 ;;^DD(.11,1.4,21,10,0)
 ;;=When fields that make up a cross-reference are edited and the kill and set
 ;;^DD(.11,1.4,21,11,0)
 ;;=conditions are executed, the X1(order#) array contains the old field
 ;;^DD(.11,1.4,21,12,0)
 ;;=values, and the X2(order#) array contains the new field values. If a
 ;;^DD(.11,1.4,21,13,0)
 ;;=record is being added, and there is an X1(order#) array element that
 ;;^DD(.11,1.4,21,14,0)
 ;;=corresponds to the .01 field, it is set to null. When a record is deleted,
 ;;^DD(.11,1.4,21,15,0)
 ;;=all X2(order#) array elements are null.
 ;;^DD(.11,1.4,"DT")
 ;;=2970117
 ;;^DD(.11,2.1,0)
 ;;=KILL LOGIC^RK^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.11,2.1,3)
 ;;=Answer must be Standard M code. Answer '??' for more help.
