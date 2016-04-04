DINIT2B1 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B2
Q Q
 ;;^DIC(1.52101,0,"GL")
 ;;=^DMSQ("K",
 ;;^DIC("B","SQLI_KEY_WORD",1.52101)
 ;;=
 ;;^DIC(1.52101,"%D",0)
 ;;=^^3^3^2970806^^^
 ;;^DIC(1.52101,"%D",1,0)
 ;;=SQL identifiers that may not be used for column and table names.
 ;;^DIC(1.52101,"%D",2,0)
 ;;= SQL, ODBC and vendors all have lists of restricted words, which
 ;;^DIC(1.52101,"%D",3,0)
 ;;=should be put in this table before SQLI table generation.
 ;;^DD(1.52101,0)
 ;;=FIELD^^.01^1
 ;;^DD(1.52101,0,"DDA")
 ;;=N
 ;;^DD(1.52101,0,"DT")
 ;;=2970311
 ;;^DD(1.52101,0,"IX","B",1.52101,.01)
 ;;=
 ;;^DD(1.52101,0,"NM","SQLI_KEY_WORD")
 ;;=
 ;;^DD(1.52101,0,"VRPK")
 ;;=DI
 ;;^DD(1.52101,.01,0)
 ;;=KEY_WORD^RF^^0;1^K:$L(X)>30!($L(X)<2)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.52101,.01,.1)
 ;;=Keyword
 ;;^DD(1.52101,.01,1,0)
 ;;=^.1
 ;;^DD(1.52101,.01,1,1,0)
 ;;=1.52101^B
 ;;^DD(1.52101,.01,1,1,1)
 ;;=S ^DMSQ("K","B",$E(X,1,30),DA)=""
 ;;^DD(1.52101,.01,1,1,2)
 ;;=K ^DMSQ("K","B",$E(X,1,30),DA)
 ;;^DD(1.52101,.01,3)
 ;;=Answer must be 2-30 characters in length.
 ;;^DD(1.52101,.01,9)
 ;;=^
 ;;^DD(1.52101,.01,"DT")
 ;;=2970311
