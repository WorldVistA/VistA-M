DINIT2B2 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B3
Q Q
 ;;^DIC(1.5211,0,"GL")
 ;;=^DMSQ("DT",
 ;;^DIC("B","SQLI_DATA_TYPE",1.5211)
 ;;=
 ;;^DIC(1.5211,"%D",0)
 ;;=^^10^10^2970806^^^
 ;;^DIC(1.5211,"%D",1,0)
 ;;=A set of values from which all domains of that type may be drawn.
 ;;^DIC(1.5211,"%D",2,0)
 ;;=PRIMARY_KEY - the set of all primary keys (in SQLI_TABLE_ELEMENT, type P)
 ;;^DIC(1.5211,"%D",3,0)
 ;;=CHARACTER - the set of all character strings of length less than 256
 ;;^DIC(1.5211,"%D",4,0)
 ;;=INTEGER - the set of all cardinal numbers
 ;;^DIC(1.5211,"%D",5,0)
 ;;=NUMERIC - the set of all real numbers
 ;;^DIC(1.5211,"%D",6,0)
 ;;=DATE - the set of all date valued tokens
 ;;^DIC(1.5211,"%D",7,0)
 ;;=TIME - the set of all time valued tokens
 ;;^DIC(1.5211,"%D",8,0)
 ;;=MOMENT - the set of all tokens which have both a date and a time value
 ;;^DIC(1.5211,"%D",9,0)
 ;;=BOOLEAN - the set of all tokens which evaluate to true or false only
 ;;^DIC(1.5211,"%D",10,0)
 ;;=MEMO - the set of all character strings of length > 255
 ;;^DD(1.5211,0)
 ;;=FIELD^^3^4
 ;;^DD(1.5211,0,"DDA")
 ;;=N
 ;;^DD(1.5211,0,"DT")
 ;;=2960917
 ;;^DD(1.5211,0,"IX","B",1.5211,.01)
 ;;=
 ;;^DD(1.5211,0,"NM","SQLI_DATA_TYPE")
 ;;=
 ;;^DD(1.5211,0,"PT",1.5212,1)
 ;;=
 ;;^DD(1.5211,0,"PT",1.5213,1)
 ;;=
 ;;^DD(1.5211,0,"PT",1.5214,1)
 ;;=
 ;;^DD(1.5211,0,"VRPK")
 ;;=DI
 ;;^DD(1.5211,.01,0)
 ;;=D_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5211,.01,.1)
 ;;=Data Type
 ;;^DD(1.5211,.01,1,0)
 ;;=^.1
 ;;^DD(1.5211,.01,1,1,0)
 ;;=1.5211^B
 ;;^DD(1.5211,.01,1,1,1)
 ;;=S ^DMSQ("DT","B",$E(X,1,30),DA)=""
 ;;^DD(1.5211,.01,1,1,2)
 ;;=K ^DMSQ("DT","B",$E(X,1,30),DA)
 ;;^DD(1.5211,.01,3)
 ;;=Answer must be an SQL identifier 3-30 characters in length.
 ;;^DD(1.5211,.01,4)
 ;;=W ?5,"Must be a valid SQL identifier"
 ;;^DD(1.5211,.01,9)
 ;;=^
 ;;^DD(1.5211,.01,21,0)
 ;;=^^1^1^2970311^^^^
 ;;^DD(1.5211,.01,21,1,0)
 ;;=ODBC Standard data type corresponding to FileMan domains
 ;;^DD(1.5211,.01,"DT")
 ;;=2960820
 ;;^DD(1.5211,1,0)
 ;;=D_COMMENT^F^^0;2^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.5211,1,.1)
 ;;=Comment
 ;;^DD(1.5211,1,3)
 ;;=Answer must be 3-60 characters in length.
 ;;^DD(1.5211,1,9)
 ;;=^
 ;;^DD(1.5211,1,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5211,1,21,1,0)
 ;;=Short description of the data type
 ;;^DD(1.5211,1,"DT")
 ;;=2960926
 ;;^DD(1.5211,2,0)
 ;;=D_OUTPUT_STRATEGY^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5211,2,.1)
 ;;=Output Strategy
 ;;^DD(1.5211,2,3)
 ;;=This is Standard MUMPS code to format output.
 ;;^DD(1.5211,2,9)
 ;;=^
 ;;^DD(1.5211,2,21,0)
 ;;=^^1^1^2960926^^^^
 ;;^DD(1.5211,2,21,1,0)
 ;;=M code which returns external value, {E} of base value, {B}.
 ;;^DD(1.5211,2,"DT")
 ;;=2960926
 ;;^DD(1.5211,3,0)
 ;;=D_OUTPUT_FORMAT^P1.5214'^DMSQ("OF",^0;3^Q
 ;;^DD(1.5211,3,.1)
 ;;=Output Format
 ;;^DD(1.5211,3,9)
 ;;=^
 ;;^DD(1.5211,3,21,0)
 ;;=^^1^1^2960926^^^^
 ;;^DD(1.5211,3,21,1,0)
 ;;=IEN of default output format in SQLI_OUTPUT_FORMAT
 ;;^DD(1.5211,3,"DT")
 ;;=2960926
