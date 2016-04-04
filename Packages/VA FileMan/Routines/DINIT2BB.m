DINIT2BB ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2BC
Q Q
 ;;^DIC(1.5218,0,"GL")
 ;;=^DMSQ("P",
 ;;^DIC("B","SQLI_PRIMARY_KEY",1.5218)
 ;;=
 ;;^DIC(1.5218,"%D",0)
 ;;=^^9^9^2970806^^^
 ;;^DIC(1.5218,"%D",1,0)
 ;;=A chosen set of columns which uniquely identify a table.
 ;;^DIC(1.5218,"%D",2,0)
 ;;=In the relational model (as in set theory) the columns of a primary key
 ;;^DIC(1.5218,"%D",3,0)
 ;;=are not ordered. In SQLI they must be, in order to map to the quasi-
 ;;^DIC(1.5218,"%D",4,0)
 ;;=hierarchical model of M globals.
 ;;^DIC(1.5218,"%D",5,0)
 ;;= 
 ;;^DIC(1.5218,"%D",6,0)
 ;;=FileMan subfiles (multiples) have a primary key element for each parent
 ;;^DIC(1.5218,"%D",7,0)
 ;;=plus one for the subfile. Each contains a pointer to its primary key table
 ;;^DIC(1.5218,"%D",8,0)
 ;;=element (SQLI_TABLE-ELEMENT), a sequence and a column in the local base
 ;;^DIC(1.5218,"%D",9,0)
 ;;= table (SQL_COLUMN).
 ;;^DD(1.5218,0)
 ;;=FIELD^^7^8
 ;;^DD(1.5218,0,"DDA")
 ;;=N
 ;;^DD(1.5218,0,"DT")
 ;;=2961014
 ;;^DD(1.5218,0,"IX","B",1.5218,.01)
 ;;=
 ;;^DD(1.5218,0,"IX","C",1.5218,2)
 ;;=
 ;;^DD(1.5218,0,"IX","D",1.5218,1)
 ;;=
 ;;^DD(1.5218,0,"NM","SQLI_PRIMARY_KEY")
 ;;=
 ;;^DD(1.5218,0,"PT",1.5219,1)
 ;;=
 ;;^DD(1.5218,0,"VRPK")
 ;;=DI
 ;;^DD(1.5218,.01,0)
 ;;=P_TBL_ELEMENT^RP1.5216'^DMSQ("E",^0;1^Q
 ;;^DD(1.5218,.01,.1)
 ;;=Key Element
 ;;^DD(1.5218,.01,1,0)
 ;;=^.1
 ;;^DD(1.5218,.01,1,1,0)
 ;;=1.5218^B
 ;;^DD(1.5218,.01,1,1,1)
 ;;=S ^DMSQ("P","B",$E(X,1,30),DA)=""
 ;;^DD(1.5218,.01,1,1,2)
 ;;=K ^DMSQ("P","B",$E(X,1,30),DA)
 ;;^DD(1.5218,.01,3)
 ;;=
 ;;^DD(1.5218,.01,9)
 ;;=^
 ;;^DD(1.5218,.01,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5218,.01,21,1,0)
 ;;=IEN of table element in SQLI_TABLE_ELEMENT
 ;;^DD(1.5218,.01,"DT")
 ;;=2960823
 ;;^DD(1.5218,1,0)
 ;;=P_COLUMN^RP1.5217'^DMSQ("C",^0;2^Q
 ;;^DD(1.5218,1,.1)
 ;;=Column
 ;;^DD(1.5218,1,1,0)
 ;;=^.1
 ;;^DD(1.5218,1,1,1,0)
 ;;=1.5218^D
 ;;^DD(1.5218,1,1,1,1)
 ;;=S ^DMSQ("P","D",$E(X,1,30),DA)=""
 ;;^DD(1.5218,1,1,1,2)
 ;;=K ^DMSQ("P","D",$E(X,1,30),DA)
 ;;^DD(1.5218,1,1,1,"DT")
 ;;=2960830
 ;;^DD(1.5218,1,9)
 ;;=^
 ;;^DD(1.5218,1,21,0)
 ;;=^^1^1^2960926^^^
 ;;^DD(1.5218,1,21,1,0)
 ;;=IEN of column in SQLI_COLUMN corresponding to this primary key
 ;;^DD(1.5218,1,"DT")
 ;;=2960830
 ;;^DD(1.5218,2,0)
 ;;=P_SEQUENCE^RNJ1,0^^0;3^K:+X'=X!(X>9)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.5218,2,.1)
 ;;=Seq
 ;;^DD(1.5218,2,1,0)
 ;;=^.1
 ;;^DD(1.5218,2,1,1,0)
 ;;=1.5218^C^MUMPS
 ;;^DD(1.5218,2,1,1,1)
 ;;=S ^DMSQ("P","C",$P(^DMSQ("P",DA,0),U),X,DA)=""
 ;;^DD(1.5218,2,1,1,2)
 ;;=K ^DMSQ("P","C",$P(^DMSQ("P",DA,0),U),X,DA)
 ;;^DD(1.5218,2,1,1,"%D",0)
 ;;=^^1^1^2960827^^
 ;;^DD(1.5218,2,1,1,"%D",1,0)
 ;;=Primary key by table by sequence
 ;;^DD(1.5218,2,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5218,2,3)
 ;;=Type a Number between 1 and 9, 0 Decimal Digits
 ;;^DD(1.5218,2,9)
 ;;=^
 ;;^DD(1.5218,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5218,2,21,1,0)
 ;;=Sequence number of primary key
 ;;^DD(1.5218,2,23,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5218,2,23,1,0)
 ;;=Sequence is automatically generated and must not be changed.
 ;;^DD(1.5218,2,"DT")
 ;;=2960926
 ;;^DD(1.5218,3,0)
 ;;=P_START_AT^F^^0;4^K:$L(X)>30!($L(X)<1) X
 ;;^DD(1.5218,3,.1)
 ;;=Start
 ;;^DD(1.5218,3,3)
 ;;=Answer must be 1-30 characters in length.
 ;;^DD(1.5218,3,9)
 ;;=^
 ;;^DD(1.5218,3,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5218,3,21,1,0)
 ;;=Initial value of key before a $ORDER loop
 ;;^DD(1.5218,3,"DT")
 ;;=2960820
 ;;^DD(1.5218,4,0)
 ;;=P_END_IF^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5218,4,.1)
 ;;=End If
 ;;^DD(1.5218,4,3)
 ;;=This is a Standard M expression returning False at end
 ;;^DD(1.5218,4,9)
 ;;=^
 ;;^DD(1.5218,4,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5218,4,21,1,0)
 ;;=M expression in key value, {K}, which, if false, ends the $ORDER loop
 ;;^DD(1.5218,4,"DT")
 ;;=2960926
 ;;^DD(1.5218,5,0)
 ;;=P_ROW_COUNT^NJ10,2^^0;5^K:+X'=X!(X>9999999)!(X<1)!(X?.E1"."3N.N) X
 ;;^DD(1.5218,5,.1)
 ;;=Rows
 ;;^DD(1.5218,5,3)
 ;;=Type a Number between 1 and 9999999, 2 Decimal Digits
 ;;^DD(1.5218,5,9)
 ;;=^
 ;;^DD(1.5218,5,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5218,5,21,1,0)
 ;;=Estimated number of rows per record set at this level
 ;;^DD(1.5218,5,"DT")
 ;;=2960926
 ;;^DD(1.5218,6,0)
 ;;=P_PRESELECT^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5218,6,.1)
 ;;=Preselect M Code
 ;;^DD(1.5218,6,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5218,6,9)
 ;;=^
 ;;^DD(1.5218,6,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5218,6,21,1,0)
 ;;=Code to be executed before selecting this key, before optimization.
 ;;^DD(1.5218,6,"DT")
 ;;=2960926
 ;;^DD(1.5218,7,0)
 ;;=P_KEY_FORMAT^P1.5213'^DMSQ("KF",^0;6^Q
 ;;^DD(1.5218,7,9)
 ;;=^
 ;;^DD(1.5218,7,21,0)
 ;;=^^4^4^2961014^
 ;;^DD(1.5218,7,21,1,0)
 ;;=Key formats map internal storage values to their value when used as keys.
 ;;^DD(1.5218,7,21,2,0)
 ;;=In general, information is lost in the process; they can't be converted
 ;;^DD(1.5218,7,21,3,0)
 ;;=back. This means data must be converted to key format before it can be
 ;;^DD(1.5218,7,21,4,0)
 ;;=compared to such a key.
 ;;^DD(1.5218,7,"DT")
 ;;=2961014
