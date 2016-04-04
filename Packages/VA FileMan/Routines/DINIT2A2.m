DINIT2A2 ;SFISC/MKO-KEY AND INDEX FILES ;11:29 AM  19 Nov 2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,167**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2A3
Q Q
 ;;^DD(.11,2.1,9)
 ;;=@
 ;;^DD(.11,2.1,21,0)
 ;;=^^16^16^2990430^
 ;;^DD(.11,2.1,21,1,0)
 ;;=Answer with the M code that FileMan should execute when the values of
 ;;^DD(.11,2.1,21,2,0)
 ;;=fields that make up the cross-reference are changed or deleted. When field
 ;;^DD(.11,2.1,21,3,0)
 ;;=values are changed, FileMan executes first the KILL LOGIC, then the SET
 ;;^DD(.11,2.1,21,4,0)
 ;;=LOGIC.
 ;;^DD(.11,2.1,21,5,0)
 ;;=
 ;;^DD(.11,2.1,21,6,0)
 ;;=Assume the DA array describes the record to be cross-referenced, and that
 ;;^DD(.11,2.1,21,7,0)
 ;;=the X(order#) array contains values after the transform for storage is
 ;;^DD(.11,2.1,21,8,0)
 ;;=applied, but before the truncation to the maximum length.  The variable X
 ;;^DD(.11,2.1,21,9,0)
 ;;=also equals X(order#) of the lowest order number.
 ;;^DD(.11,2.1,21,10,0)
 ;;=
 ;;^DD(.11,2.1,21,11,0)
 ;;=When fields that make up a cross-reference are edited and the kill and set
 ;;^DD(.11,2.1,21,12,0)
 ;;=logic are executed, the X1(order#) array contains the old field values,
 ;;^DD(.11,2.1,21,13,0)
 ;;=and the X2(order#) array contains the new field values. If a record is
 ;;^DD(.11,2.1,21,14,0)
 ;;=being added, and there is an X1(order#) array element that corresponds to
 ;;^DD(.11,2.1,21,15,0)
 ;;=the .01 field, it is set to null. When a record is deleted, all X2(order#)
 ;;^DD(.11,2.1,21,16,0)
 ;;=array elements are null.
 ;;^DD(.11,2.1,"DT")
 ;;=2960116
 ;;^DD(.11,2.2,0)
 ;;=OVERFLOW KILL LOGIC^.112^^2.2;0
 ;;^DD(.11,2.2,"DT")
 ;;=2960124
 ;;^DD(.11,2.3,0)
 ;;=KILL CONDITION^F^^2.3;E1,245^K:$L(X)>245!($L(X)<1) X
 ;;^DD(.11,2.3,3)
 ;;=Answer must be a valid FileMan computed expression. Answer '??' for more help.
 ;;^DD(.11,2.3,21,0)
 ;;=^^5^5^2960124^
 ;;^DD(.11,2.3,21,1,0)
 ;;=Answer with a FileMan computed expression that will evaluate to Boolean
 ;;^DD(.11,2.3,21,2,0)
 ;;=true (according to the M rules for Boolean interpretation). FileMan will
 ;;^DD(.11,2.3,21,3,0)
 ;;=evaluate this expression whenever it would normally execute the
 ;;^DD(.11,2.3,21,4,0)
 ;;=cross-reference's Kill Logic, and will not execute the Kill Logic unless
 ;;^DD(.11,2.3,21,5,0)
 ;;=this condition evaluates to true.
 ;;^DD(.11,2.3,"DT")
 ;;=2960116
 ;;^DD(.11,2.4,0)
 ;;=KILL CONDITION CODE^K^^2.4;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.11,2.4,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.11,2.4,9)
 ;;=@
 ;;^DD(.11,2.4,21,0)
 ;;=^^15^15^2990430^
 ;;^DD(.11,2.4,21,1,0)
 ;;=This is MUMPS code, that sets the variable X. The KILL LOGIC is executed
 ;;^DD(.11,2.4,21,2,0)
 ;;=only if the KILL CONDITION, if present, sets X such the X evaluates to
 ;;^DD(.11,2.4,21,3,0)
 ;;=true,  (according to M rules for Boolean interpretation)
 ;;^DD(.11,2.4,21,4,0)
 ;;= 
 ;;^DD(.11,2.4,21,5,0)
 ;;=Assume the DA array describes the record to be cross-referenced, and that
 ;;^DD(.11,2.4,21,6,0)
 ;;=the X(order#) array contains values after the transform for storage is
 ;;^DD(.11,2.4,21,7,0)
 ;;=applied, but before the truncation to the maximum length.  The variable X
 ;;^DD(.11,2.4,21,8,0)
 ;;=also equals X(order#) of the lowest order number.
 ;;^DD(.11,2.4,21,9,0)
 ;;=
 ;;^DD(.11,2.4,21,10,0)
 ;;=When fields that make up a cross-reference are edited and the kill and set
 ;;^DD(.11,2.4,21,11,0)
 ;;=conditions are executed, the X1(order#) array contains the old field
 ;;^DD(.11,2.4,21,12,0)
 ;;=values, and the X2(order#) array contains the new field values. If a
 ;;^DD(.11,2.4,21,13,0)
 ;;=record is being added, and there is an X1(order#) array element that
 ;;^DD(.11,2.4,21,14,0)
 ;;=corresponds to the .01 field, it is set to null. When a record is deleted,
 ;;^DD(.11,2.4,21,15,0)
 ;;=all X2(order#) array elements are null.
 ;;^DD(.11,2.4,"DT")
 ;;=2970117
 ;;^DD(.11,2.5,0)
 ;;=KILL ENTIRE INDEX CODE^K^^2.5;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.11,2.5,3)
 ;;=This is Standard MUMPS code. Answer '??' for more help.
 ;;^DD(.11,2.5,9)
 ;;=@
 ;;^DD(.11,2.5,21,0)
 ;;=^^4^4^2980911^
 ;;^DD(.11,2.5,21,1,0)
 ;;=This is a kill statement that can be executed to remove an entire index for
 ;;^DD(.11,2.5,21,2,0)
 ;;=all records in a file. When an entire file is reindexed, FileMan executes
 ;;^DD(.11,2.5,21,3,0)
 ;;=this code instead of looping through all the entries in a file and
 ;;^DD(.11,2.5,21,4,0)
 ;;=executing the kill logic once for each entry.
 ;;^DD(.11,666,0)
 ;;=RE-INDEXING^SI^1:NO RE-INDEXING ALLOWED;0:ALLOW REINDEXING^NOREINDEX;1
 ;;^DD(.11,666,3)
 ;;=Should the re-indexing of this cross reference be prohibited?
 ;;^DD(.11,666,21,0)
 ;;=^^5^5
 ;;^DD(.11,666,21,1,0)
 ;;=If you answer '1', this cross reference will not be re-indexed during a
 ;;^DD(.11,666,21,2,0)
 ;;=general re-indexing of this file, whether it's done via API or
 ;;^DD(.11,666,21,3,0)
 ;;=interactively. If you answer '0', which is the default, it will.
 ;;^DD(.11,666,21,4,0)
 ;;=A 'NO RE-INDEXING' cross-reference will ONLY be re-indexed
 ;;^DD(.11,666,21,5,0)
 ;;=if it is specifically named in an API call
 ;;^DD(.11,11.1,0)
 ;;=CROSS-REFERENCE VALUES^.114IA^^11.1;0
 ;;^DD(.11,11.1,"DT")
 ;;=2960221
 ;;^DD(.1101,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.1101,0,"DT")
 ;;=2960116
 ;;^DD(.1101,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.1101,0,"UP")
 ;;=.11
 ;;^DD(.1101,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(.1101,.01,3)
 ;;=Answer '??' for more help.
 ;;^DD(.1101,.01,21,0)
 ;;=^^3^3^2960123^
 ;;^DD(.1101,.01,21,1,0)
 ;;=Answer should describe the purpose of this index, along with any technical
 ;;^DD(.1101,.01,21,2,0)
 ;;=information that might be useful to advanced users, developers,
 ;;^DD(.1101,.01,21,3,0)
 ;;=troubleshooters, or system managers.
 ;;^DD(.1101,.01,"DT")
 ;;=2960116
 ;;^DD(.111,0)
 ;;=OVERFLOW SET LOGIC SUB-FIELD^^1^2
 ;;^DD(.111,0,"DT")
 ;;=2960124
 ;;^DD(.111,0,"NM","OVERFLOW SET LOGIC")
 ;;=
 ;;^DD(.111,0,"UP")
 ;;=.11
 ;;^DD(.111,.01,0)
 ;;=OVERFLOW SET LOGIC NODE^MNJ6,0X^^0;1^K:+X'=X!(X>999999)!(X<1)!(X?.E1"."1N.N) X S:$D(X) DINUM=X
 ;;^DD(.111,.01,3)
 ;;=Type a Number between 1 and 999999, 0 Decimal Digits. Answer '??' for more help.
 ;;^DD(.111,.01,21,0)
 ;;=^^3^3^2980911^
 ;;^DD(.111,.01,21,1,0)
 ;;=Answer must be the number of the node under which the additional line of
 ;;^DD(.111,.01,21,2,0)
 ;;=set logic will be filed. Use the overflow nodes if the set logic is too
 ;;^DD(.111,.01,21,3,0)
 ;;=long to fit in the SET LOGIC field.
 ;;^DD(.111,.01,"DT")
 ;;=2980910
 ;;^DD(.111,1,0)
 ;;=OVERFLOW SET LOGIC^RK^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(.111,1,3)
 ;;=Answer must be Standard M code. Answer '??' for more help.
 ;;^DD(.111,1,9)
 ;;=@
 ;;^DD(.111,1,21,0)
 ;;=^^6^6^2980911^
 ;;^DD(.111,1,21,1,0)
 ;;=Answer with the M code of the additional set logic stored at this node.
 ;;^DD(.111,1,21,2,0)
 ;;=FileMan will not automatically execute this additional code, so the set
 ;;^DD(.111,1,21,3,0)
 ;;=logic must invoke the additional code stored in this overflow node.
 ;;^DD(.111,1,21,4,0)
 ;;=
 ;;^DD(.111,1,21,5,0)
 ;;=The M code can assume that DIXR contains the internal entry number of the
