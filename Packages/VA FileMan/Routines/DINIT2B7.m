DINIT2B7 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B8
Q Q
 ;;^DIC(1.5215,0,"GL")
 ;;=^DMSQ("T",
 ;;^DIC("B","SQLI_TABLE",1.5215)
 ;;=
 ;;^DIC(1.5215,"%D",0)
 ;;=^^6^6^2970806^^^
 ;;^DIC(1.5215,"%D",1,0)
 ;;=Descriptor of a set of table elements: Includes name and file no.
 ;;^DIC(1.5215,"%D",2,0)
 ;;=(See SQLI_TABLE_ELEMENTS). Each ^DD(DA) represents a table in a relational
 ;;^DIC(1.5215,"%D",3,0)
 ;;=model of FileMan. Further, each index represents a table. 
 ;;^DIC(1.5215,"%D",4,0)
 ;;= 
 ;;^DIC(1.5215,"%D",5,0)
 ;;=Each schema contains multiple tables. Each table contains just one primary
 ;;^DIC(1.5215,"%D",6,0)
 ;;=key, but multiple columns, foreign keys and indicies.
 ;;^DD(1.5215,0)
 ;;=FIELD^^8^9
 ;;^DD(1.5215,0,"DDA")
 ;;=N
 ;;^DD(1.5215,0,"DT")
 ;;=2960913
 ;;^DD(1.5215,0,"IX","B",1.5215,.01)
 ;;=
 ;;^DD(1.5215,0,"IX","C",1.5215,6)
 ;;=
 ;;^DD(1.5215,0,"IX","D",1.5215,8)
 ;;=
 ;;^DD(1.5215,0,"IX","E",1.5215,3)
 ;;=
 ;;^DD(1.5215,0,"NM","SQLI_TABLE")
 ;;=
 ;;^DD(1.5215,0,"PT",1.5212,3)
 ;;=
 ;;^DD(1.5215,0,"PT",1.5215,3)
 ;;=
 ;;^DD(1.5215,0,"PT",1.5216,2)
 ;;=
 ;;^DD(1.5215,0,"VRPK")
 ;;=DI
 ;;^DD(1.5215,.01,0)
 ;;=T_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5215,.01,.1)
 ;;=Table
 ;;^DD(1.5215,.01,1,0)
 ;;=^.1
 ;;^DD(1.5215,.01,1,1,0)
 ;;=1.5215^B
 ;;^DD(1.5215,.01,1,1,1)
 ;;=S ^DMSQ("T","B",$E(X,1,30),DA)=""
 ;;^DD(1.5215,.01,1,1,2)
 ;;=K ^DMSQ("T","B",$E(X,1,30),DA)
 ;;^DD(1.5215,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(1.5215,.01,9)
 ;;=^
 ;;^DD(1.5215,.01,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5215,.01,21,1,0)
 ;;=Table name must be a valid SQL identifier, unique by schema
 ;;^DD(1.5215,.01,"DT")
 ;;=2960820
 ;;^DD(1.5215,1,0)
 ;;=T_SCHEMA^RP1.521^DMSQ("S",^0;2^Q
 ;;^DD(1.5215,1,.1)
 ;;=Schema
 ;;^DD(1.5215,1,9)
 ;;=^
 ;;^DD(1.5215,1,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,1,21,1,0)
 ;;=IEN in SQLI_SCHEMA of the schema to which this table belongs.
 ;;^DD(1.5215,1,"DT")
 ;;=2960913
 ;;^DD(1.5215,2,0)
 ;;=T_COMMENT^F^^0;3^K:$L(X)>70!($L(X)<3) X
 ;;^DD(1.5215,2,.1)
 ;;=Description
 ;;^DD(1.5215,2,3)
 ;;=Answer must be 3-70 characters in length.
 ;;^DD(1.5215,2,9)
 ;;=^
 ;;^DD(1.5215,2,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,2,21,1,0)
 ;;=A short description of the table
 ;;^DD(1.5215,2,"DT")
 ;;=2960913
 ;;^DD(1.5215,3,0)
 ;;=T_MASTER_TABLE^P1.5215'^DMSQ("T",^0;4^Q
 ;;^DD(1.5215,3,.1)
 ;;=Master Table
 ;;^DD(1.5215,3,1,0)
 ;;=^.1
 ;;^DD(1.5215,3,1,1,0)
 ;;=1.5215^E
 ;;^DD(1.5215,3,1,1,1)
 ;;=S ^DMSQ("T","E",$E(X,1,30),DA)=""
 ;;^DD(1.5215,3,1,1,2)
 ;;=K ^DMSQ("T","E",$E(X,1,30),DA)
 ;;^DD(1.5215,3,1,1,"%D",0)
 ;;=^^1^1^2960904^
 ;;^DD(1.5215,3,1,1,"%D",1,0)
 ;;=Table by master table
 ;;^DD(1.5215,3,1,1,"DT")
 ;;=2960904
 ;;^DD(1.5215,3,3)
 ;;=Enter only if this table is an index
 ;;^DD(1.5215,3,9)
 ;;=^
 ;;^DD(1.5215,3,21,0)
 ;;=^^1^1^2960926^^^
 ;;^DD(1.5215,3,21,1,0)
 ;;=The table of which this table is an index. (Only index tables)
 ;;^DD(1.5215,3,23,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,3,23,1,0)
 ;;=In SQL, and in the relational model, an index is just a table.
 ;;^DD(1.5215,3,"DT")
 ;;=2960913
 ;;^DD(1.5215,4,0)
 ;;=T_VERSION_FM^NJ9,0^^0;5^K:+X'=X!(X>999999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.5215,4,.1)
 ;;=Version
 ;;^DD(1.5215,4,3)
 ;;=Type a Number between 1 and 999999999, 0 Decimal Digits
 ;;^DD(1.5215,4,9)
 ;;=^
 ;;^DD(1.5215,4,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,4,21,1,0)
 ;;=The version number is updated by FileMan when ^DD or ^DIC changes.
 ;;^DD(1.5215,4,"DT")
 ;;=2960926
 ;;^DD(1.5215,5,0)
 ;;=T_ROW_COUNT^NJ9,0^^0;6^K:+X'=X!(X>999999999)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(1.5215,5,.1)
 ;;=Row Count
 ;;^DD(1.5215,5,3)
 ;;=Type a Number between 0 and 999999999, 0 Decimal Digits
 ;;^DD(1.5215,5,9)
 ;;=^
 ;;^DD(1.5215,5,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,5,21,1,0)
 ;;=This field should contain an estimate of the number of rows in the table
 ;;^DD(1.5215,5,"DT")
 ;;=2960926
 ;;^DD(1.5215,6,0)
 ;;=T_FILE^RNJ19,9O^^0;7^K:+X'=X!(X>999999999)!(X<0)!(X?.E1"."10N.N) X
 ;;^DD(1.5215,6,.1)
 ;;=Source File
 ;;^DD(1.5215,6,1,0)
 ;;=^.1
 ;;^DD(1.5215,6,1,1,0)
 ;;=1.5215^C
 ;;^DD(1.5215,6,1,1,1)
 ;;=S ^DMSQ("T","C",$E(X,1,30),DA)=""
 ;;^DD(1.5215,6,1,1,2)
 ;;=K ^DMSQ("T","C",$E(X,1,30),DA)
 ;;^DD(1.5215,6,1,1,"%D",0)
 ;;=^^1^1^2960902^^
 ;;^DD(1.5215,6,1,1,"%D",1,0)
 ;;=Table by source file index
 ;;^DD(1.5215,6,1,1,"DT")
 ;;=2960822
 ;;^DD(1.5215,6,2)
 ;;=S Y(0)=Y S Y=$S('Y:"",$D(^DIC(+Y)):$P(^(+Y,0),U),1:$O(^DD(+Y,0,"NM","")))
 ;;^DD(1.5215,6,2.1)
 ;;=S Y=$S('Y:"",$D(^DIC(+Y)):$P(^(+Y,0),U),1:$O(^DD(+Y,0,"NM","")))
 ;;^DD(1.5215,6,3)
 ;;=Type a Number between 0 and 999999999, 9 Decimal Digits
 ;;^DD(1.5215,6,9)
 ;;=^
 ;;^DD(1.5215,6,21,0)
 ;;=^^1^1^2960926^^^
 ;;^DD(1.5215,6,21,1,0)
 ;;=FileMan file number from which table is derived.
 ;;^DD(1.5215,6,23,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.5215,6,23,1,0)
 ;;=This may be a subfile number
 ;;^DD(1.5215,6,"DT")
 ;;=2960908
 ;;^DD(1.5215,7,0)
 ;;=T_UPDATE^D^^0;8^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.5215,7,.1)
 ;;=Last Updated
 ;;^DD(1.5215,7,9)
 ;;=^
 ;;^DD(1.5215,7,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5215,7,21,1,0)
 ;;=Date last updated.
 ;;^DD(1.5215,7,"DT")
 ;;=2960821
 ;;^DD(1.5215,8,0)
 ;;=T_GLOBAL^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5215,8,.1)
 ;;=Global Root
 ;;^DD(1.5215,8,1,0)
 ;;=^.1
 ;;^DD(1.5215,8,1,1,0)
 ;;=1.5215^D
 ;;^DD(1.5215,8,1,1,1)
 ;;=S ^DMSQ("T","D",$E(X,1,30),DA)=""
 ;;^DD(1.5215,8,1,1,2)
 ;;=K ^DMSQ("T","D",$E(X,1,30),DA)
 ;;^DD(1.5215,8,1,1,"%D",0)
 ;;=^^1^1^2960822^
 ;;^DD(1.5215,8,1,1,"%D",1,0)
 ;;=Table by global name. Used for structural study.
 ;;^DD(1.5215,8,1,1,"DT")
 ;;=2960822
 ;;^DD(1.5215,8,3)
 ;;=A valid M global variable name using {K} for subscripts
 ;;^DD(1.5215,8,9)
 ;;=^
 ;;^DD(1.5215,8,21,0)
 ;;=^^2^2^2960926^^^^
 ;;^DD(1.5215,8,21,1,0)
 ;;=Global variable name. {K} stands for a subscript
 ;;^DD(1.5215,8,21,2,0)
 ;;=E.g.: ^DIC(9.4,{K},3,{K},4,{K})
 ;;^DD(1.5215,8,23,0)
 ;;=^^1^1^2960926^^^
 ;;^DD(1.5215,8,23,1,0)
 ;;=Used to piece out global fragments for columns
 ;;^DD(1.5215,8,"DT")
 ;;=2960926
