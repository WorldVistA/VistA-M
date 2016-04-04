DINIT2B6 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B7
Q Q
 ;;^DIC(1.5214,0,"GL")
 ;;=^DMSQ("OF",
 ;;^DIC("B","SQLI_OUTPUT_FORMAT",1.5214)
 ;;=
 ;;^DIC(1.5214,"%D",0)
 ;;=^^9^9^2970806^^^
 ;;^DIC(1.5214,"%D",1,0)
 ;;=Strategies for converting base values to external values.
 ;;^DIC(1.5214,"%D",2,0)
 ;;=In FileMan they are used to convert references to pointers to
 ;;^DIC(1.5214,"%D",3,0)
 ;;=their text values. They are also used for the SET OF CODES type.
 ;;^DIC(1.5214,"%D",4,0)
 ;;= 
 ;;^DIC(1.5214,"%D",5,0)
 ;;=SQLI projects pointer and set of codes as calls to $$GET1^DIQ, 
 ;;^DIC(1.5214,"%D",6,0)
 ;;=variable pointer into calls to $$EXTERNAL^DILFD.
 ;;^DIC(1.5214,"%D",7,0)
 ;;= 
 ;;^DIC(1.5214,"%D",8,0)
 ;;=Vendors and other users of SQLI may choose to implement their own 
 ;;^DIC(1.5214,"%D",9,0)
 ;;=conversions to improve performance.
 ;;^DD(1.5214,0)
 ;;=FIELD^^4^5
 ;;^DD(1.5214,0,"DDA")
 ;;=N
 ;;^DD(1.5214,0,"DT")
 ;;=2960820
 ;;^DD(1.5214,0,"IX","B",1.5214,.01)
 ;;=
 ;;^DD(1.5214,0,"NM","SQLI_OUTPUT_FORMAT")
 ;;=
 ;;^DD(1.5214,0,"PT",1.5211,3)
 ;;=
 ;;^DD(1.5214,0,"PT",1.5212,6)
 ;;=
 ;;^DD(1.5214,0,"PT",1.5217,16)
 ;;=
 ;;^DD(1.5214,0,"VRPK")
 ;;=DI
 ;;^DD(1.5214,.01,0)
 ;;=OF_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5214,.01,.1)
 ;;=Output Format
 ;;^DD(1.5214,.01,1,0)
 ;;=^.1
 ;;^DD(1.5214,.01,1,1,0)
 ;;=1.5214^B
 ;;^DD(1.5214,.01,1,1,1)
 ;;=S ^DMSQ("OF","B",$E(X,1,30),DA)=""
 ;;^DD(1.5214,.01,1,1,2)
 ;;=K ^DMSQ("OF","B",$E(X,1,30),DA)
 ;;^DD(1.5214,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(1.5214,.01,9)
 ;;=^
 ;;^DD(1.5214,.01,"DT")
 ;;=2960820
 ;;^DD(1.5214,1,0)
 ;;=OF_DATA_TYPE^RP1.5211'^DMSQ("DT",^0;2^Q
 ;;^DD(1.5214,1,3)
 ;;=Enter the ODBC data type
 ;;^DD(1.5214,1,9)
 ;;=^
 ;;^DD(1.5214,1,"DT")
 ;;=2960820
 ;;^DD(1.5214,2,0)
 ;;=OF_COMMENT^F^^0;3^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.5214,2,3)
 ;;=Answer must be 3-60 characters in length.
 ;;^DD(1.5214,2,9)
 ;;=^
 ;;^DD(1.5214,2,"DT")
 ;;=2960820
 ;;^DD(1.5214,3,0)
 ;;=OF_EXT_EXPR^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5214,3,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5214,3,9)
 ;;=^
 ;;^DD(1.5214,3,21,0)
 ;;=^^1^1^2960820^
 ;;^DD(1.5214,3,21,1,0)
 ;;=An M expression which converts the base value of X to its external value
 ;;^DD(1.5214,3,"DT")
 ;;=2960820
 ;;^DD(1.5214,4,0)
 ;;=OF_EXT_EXEC^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5214,4,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5214,4,9)
 ;;=^
 ;;^DD(1.5214,4,21,0)
 ;;=^^1^1^2960820^
 ;;^DD(1.5214,4,21,1,0)
 ;;=A line of M code which converts the base value of X to external
 ;;^DD(1.5214,4,"DT")
 ;;=2960820
