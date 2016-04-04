DINIT2B0 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B1
Q Q
 ;;^DIC(1.521,0,"GL")
 ;;=^DMSQ("S",
 ;;^DIC("B","SQLI_SCHEMA",1.521)
 ;;=
 ;;^DIC(1.521,"%D",0)
 ;;=^^1^1^2970806^^^
 ;;^DIC(1.521,"%D",1,0)
 ;;=A set of tables and domains. A subset of catalog and environment
 ;;^DD(1.521,0)
 ;;=FIELD^^2^3
 ;;^DD(1.521,0,"DDA")
 ;;=N
 ;;^DD(1.521,0,"DT")
 ;;=2960820
 ;;^DD(1.521,0,"IX","B",1.521,.01)
 ;;=
 ;;^DD(1.521,0,"NM","SQLI_SCHEMA")
 ;;=
 ;;^DD(1.521,0,"PT",1.5215,1)
 ;;=
 ;;^DD(1.521,0,"VRPK")
 ;;=DI
 ;;^DD(1.521,.01,0)
 ;;=S_NAME^RF^^0;1^K:$L(X)>30!($L(X)<1)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.521,.01,.1)
 ;;=Schema
 ;;^DD(1.521,.01,1,0)
 ;;=^.1
 ;;^DD(1.521,.01,1,1,0)
 ;;=1.521^B
 ;;^DD(1.521,.01,1,1,1)
 ;;=S ^DMSQ("S","B",$E(X,1,30),DA)=""
 ;;^DD(1.521,.01,1,1,2)
 ;;=K ^DMSQ("S","B",$E(X,1,30),DA)
 ;;^DD(1.521,.01,3)
 ;;=SQL identifier start with upper case letter, only letters, numbers and _.
 ;;^DD(1.521,.01,9)
 ;;=^
 ;;^DD(1.521,.01,21,0)
 ;;=^^2^2^2960926^^
 ;;^DD(1.521,.01,21,1,0)
 ;;=In FileMan, application groups are assigned SQL schema names
 ;;^DD(1.521,.01,21,2,0)
 ;;=Names are valid SQL identifiers, and are unique by site
 ;;^DD(1.521,.01,"DT")
 ;;=2960820
 ;;^DD(1.521,1,0)
 ;;=S_SECURITY^F^^1;1^K:$L(X)>12!($L(X)<4) X
 ;;^DD(1.521,1,.1)
 ;;=Security
 ;;^DD(1.521,1,3)
 ;;=Answer must be 4-12 characters in length.
 ;;^DD(1.521,1,4)
 ;;=W ?5,"Routine to check access to schema"
 ;;^DD(1.521,1,9)
 ;;=^
 ;;^DD(1.521,1,21,0)
 ;;=^^1^1^2970311^^^^
 ;;^DD(1.521,1,21,1,0)
 ;;=A routine to check security by application group.
 ;;^DD(1.521,1,"DT")
 ;;=2960926
 ;;^DD(1.521,2,0)
 ;;=S_DESCRIPTION^F^^0;2^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.521,2,.1)
 ;;=Description
 ;;^DD(1.521,2,3)
 ;;=Describe schema. Answer must be 3-60 characters in length.
 ;;^DD(1.521,2,9)
 ;;=^
 ;;^DD(1.521,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.521,2,21,1,0)
 ;;=A short description of the schema
 ;;^DD(1.521,2,"DT")
 ;;=2960820
