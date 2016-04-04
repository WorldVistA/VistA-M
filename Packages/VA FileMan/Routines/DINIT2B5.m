DINIT2B5 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B6
Q Q
 ;;^DIC(1.5213,0,"GL")
 ;;=^DMSQ("KF",
 ;;^DIC("B","SQLI_KEY_FORMAT",1.5213)
 ;;=
 ;;^DIC(1.5213,"%D",0)
 ;;=^^5^5^2970806^^^
 ;;^DIC(1.5213,"%D",1,0)
 ;;=Strategies for converting base values into key values.
 ;;^DIC(1.5213,"%D",2,0)
 ;;=Soundex and upper case conversion are common examples. This implies that
 ;;^DIC(1.5213,"%D",3,0)
 ;;=comparisons of key values with base values must be preceded by conversion
 ;;^DIC(1.5213,"%D",4,0)
 ;;=of the base value to key value. Key formats are frequently lossy; they
 ;;^DIC(1.5213,"%D",5,0)
 ;;=can't be converted uniquely back to base format.
 ;;^DD(1.5213,0)
 ;;=FIELD^^4^5
 ;;^DD(1.5213,0,"DDA")
 ;;=N
 ;;^DD(1.5213,0,"DT")
 ;;=2960820
 ;;^DD(1.5213,0,"IX","B",1.5213,.01)
 ;;=
 ;;^DD(1.5213,0,"IX","C",1.5213,1)
 ;;=
 ;;^DD(1.5213,0,"NM","SQLI_KEY_FORMAT")
 ;;=
 ;;^DD(1.5213,0,"PT",1.5218,7)
 ;;=
 ;;^DD(1.5213,0,"VRPK")
 ;;=DI
 ;;^DD(1.5213,.01,0)
 ;;=KF_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5213,.01,.1)
 ;;=Key Format
 ;;^DD(1.5213,.01,1,0)
 ;;=^.1
 ;;^DD(1.5213,.01,1,1,0)
 ;;=1.5213^B
 ;;^DD(1.5213,.01,1,1,1)
 ;;=S ^DMSQ("KF","B",$E(X,1,30),DA)=""
 ;;^DD(1.5213,.01,1,1,2)
 ;;=K ^DMSQ("KF","B",$E(X,1,30),DA)
 ;;^DD(1.5213,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(1.5213,.01,9)
 ;;=^
 ;;^DD(1.5213,.01,"DT")
 ;;=2960820
 ;;^DD(1.5213,1,0)
 ;;=KF_DATA_TYPE^RP1.5211'^DMSQ("DT",^0;2^Q
 ;;^DD(1.5213,1,1,0)
 ;;=^.1
 ;;^DD(1.5213,1,1,1,0)
 ;;=1.5213^C
 ;;^DD(1.5213,1,1,1,1)
 ;;=S ^DMSQ("KF","C",$E(X,1,30),DA)=""
 ;;^DD(1.5213,1,1,1,2)
 ;;=K ^DMSQ("KF","C",$E(X,1,30),DA)
 ;;^DD(1.5213,1,1,1,"%D",0)
 ;;=^^1^1^2960823^
 ;;^DD(1.5213,1,1,1,"%D",1,0)
 ;;=KEY FORMAT BY DATA TYPE
 ;;^DD(1.5213,1,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5213,1,3)
 ;;=Enter the ODBC data type of this key
 ;;^DD(1.5213,1,9)
 ;;=^
 ;;^DD(1.5213,1,"DT")
 ;;=2960823
 ;;^DD(1.5213,2,0)
 ;;=KF_COMMENT^F^^0;3^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.5213,2,3)
 ;;=Answer must be 3-60 characters in length.
 ;;^DD(1.5213,2,9)
 ;;=^
 ;;^DD(1.5213,2,"DT")
 ;;=2960820
 ;;^DD(1.5213,3,0)
 ;;=KF_INT_EXPR^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5213,3,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5213,3,9)
 ;;=^
 ;;^DD(1.5213,3,21,0)
 ;;=^^1^1^2960820^
 ;;^DD(1.5213,3,21,1,0)
 ;;=An M expression which converts X to it's key format
 ;;^DD(1.5213,3,"DT")
 ;;=2960820
 ;;^DD(1.5213,4,0)
 ;;=KF_INT_EXEC^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5213,4,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5213,4,9)
 ;;=^
 ;;^DD(1.5213,4,21,0)
 ;;=^^1^1^2960820^
 ;;^DD(1.5213,4,21,1,0)
 ;;=A line of M code which converts X to its key format
 ;;^DD(1.5213,4,"DT")
 ;;=2960820
