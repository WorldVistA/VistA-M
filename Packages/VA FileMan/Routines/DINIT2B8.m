DINIT2B8 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B9
Q Q
 ;;^DIC(1.5216,0,"GL")
 ;;=^DMSQ("E",
 ;;^DIC("B","SQLI_TABLE_ELEMENT",1.5216)
 ;;=
 ;;^DIC(1.5216,"%D",0)
 ;;=^^5^5^2970806^^^
 ;;^DIC(1.5216,"%D",1,0)
 ;;=Names and domains of primary keys, columns and foreign keys.
 ;;^DIC(1.5216,"%D",2,0)
 ;;=Each represents the relational concept of an attribute, whose essential
 ;;^DIC(1.5216,"%D",3,0)
 ;;=charactaristics are a name (unique by relation) and a domain.
 ;;^DIC(1.5216,"%D",4,0)
 ;;= 
 ;;^DIC(1.5216,"%D",5,0)
 ;;=See SQLI_PRIMARY_KEY, SQLI_COLUMN and SQLI_FOREIGN key for more.
 ;;^DD(1.5216,0)
 ;;=FIELD^^4^5
 ;;^DD(1.5216,0,"DDA")
 ;;=N
 ;;^DD(1.5216,0,"DT")
 ;;=2960820
 ;;^DD(1.5216,0,"IX","B",1.5216,.01)
 ;;=
 ;;^DD(1.5216,0,"IX","C",1.5216,1)
 ;;=
 ;;^DD(1.5216,0,"IX","D",1.5216,2)
 ;;=
 ;;^DD(1.5216,0,"IX","E",1.5216,3)
 ;;=
 ;;^DD(1.5216,0,"IX","F",1.5216,3)
 ;;=
 ;;^DD(1.5216,0,"IX","G",1.5216,2)
 ;;=
 ;;^DD(1.5216,0,"NM","SQLI_TABLE_ELEMENT")
 ;;=
 ;;^DD(1.5216,0,"PT",1.5217,.01)
 ;;=
 ;;^DD(1.5216,0,"PT",1.5218,.01)
 ;;=
 ;;^DD(1.5216,0,"PT",1.5219,.01)
 ;;=
 ;;^DD(1.5216,0,"VRPK")
 ;;=DI
 ;;^DD(1.5216,.01,0)
 ;;=E_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5216,.01,.1)
 ;;=Table Element
 ;;^DD(1.5216,.01,1,0)
 ;;=^.1
 ;;^DD(1.5216,.01,1,1,0)
 ;;=1.5216^B
 ;;^DD(1.5216,.01,1,1,1)
 ;;=S ^DMSQ("E","B",$E(X,1,30),DA)=""
 ;;^DD(1.5216,.01,1,1,2)
 ;;=K ^DMSQ("E","B",$E(X,1,30),DA)
 ;;^DD(1.5216,.01,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(1.5216,.01,9)
 ;;=^
 ;;^DD(1.5216,.01,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5216,.01,21,1,0)
 ;;=Name of table element.
 ;;^DD(1.5216,.01,21,2,0)
 ;;=Foreign keys are suffixed _FK or PFK. Primary keys are suffixed _PK.
 ;;^DD(1.5216,.01,"DT")
 ;;=2960820
 ;;^DD(1.5216,1,0)
 ;;=E_DOMAIN^RP1.5212'^DMSQ("DM",^0;2^Q
 ;;^DD(1.5216,1,.1)
 ;;=Domain
 ;;^DD(1.5216,1,1,0)
 ;;=^.1
 ;;^DD(1.5216,1,1,1,0)
 ;;=1.5216^C
 ;;^DD(1.5216,1,1,1,1)
 ;;=S ^DMSQ("E","C",$E(X,1,30),DA)=""
 ;;^DD(1.5216,1,1,1,2)
 ;;=K ^DMSQ("E","C",$E(X,1,30),DA)
 ;;^DD(1.5216,1,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5216,1,9)
 ;;=^
 ;;^DD(1.5216,1,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5216,1,21,1,0)
 ;;=IEN of domain in SQLI_DOMAIN
 ;;^DD(1.5216,1,"DT")
 ;;=2960926
 ;;^DD(1.5216,2,0)
 ;;=E_TABLE^RP1.5215'^DMSQ("T",^0;3^Q
 ;;^DD(1.5216,2,.1)
 ;;=Table
 ;;^DD(1.5216,2,1,0)
 ;;=^.1
 ;;^DD(1.5216,2,1,1,0)
 ;;=1.5216^D
 ;;^DD(1.5216,2,1,1,1)
 ;;=S ^DMSQ("E","D",$E(X,1,30),DA)=""
 ;;^DD(1.5216,2,1,1,2)
 ;;=K ^DMSQ("E","D",$E(X,1,30),DA)
 ;;^DD(1.5216,2,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5216,2,1,2,0)
 ;;=1.5216^G^MUMPS
 ;;^DD(1.5216,2,1,2,1)
 ;;=S ^DMSQ("E","G",X,$P(^DMSQ("E",DA,0),U),DA)=""
 ;;^DD(1.5216,2,1,2,2)
 ;;=K ^DMSQ("E","G",X,$P(^DMSQ("E",DA,0),U),DA)
 ;;^DD(1.5216,2,1,2,"%D",0)
 ;;=^^1^1^2960903^
 ;;^DD(1.5216,2,1,2,"%D",1,0)
 ;;=Table element by table by name
 ;;^DD(1.5216,2,1,2,"DT")
 ;;=2960903
 ;;^DD(1.5216,2,9)
 ;;=^
 ;;^DD(1.5216,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5216,2,21,1,0)
 ;;=IEN of table in SQLI_TABLE. Required.
 ;;^DD(1.5216,2,"DT")
 ;;=2960926
 ;;^DD(1.5216,3,0)
 ;;=E_TYPE^RS^C:Column;P:Primary key;F:Foreign key;^0;4^Q
 ;;^DD(1.5216,3,.1)
 ;;=Type
 ;;^DD(1.5216,3,1,0)
 ;;=^.1
 ;;^DD(1.5216,3,1,1,0)
 ;;=1.5216^E
 ;;^DD(1.5216,3,1,1,1)
 ;;=S ^DMSQ("E","E",$E(X,1,30),DA)=""
 ;;^DD(1.5216,3,1,1,2)
 ;;=K ^DMSQ("E","E",$E(X,1,30),DA)
 ;;^DD(1.5216,3,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5216,3,1,2,0)
 ;;=1.5216^F^MUMPS
 ;;^DD(1.5216,3,1,2,1)
 ;;=S ^DMSQ("E","F",$P(^DMSQ("E",DA,0),U,3),X,DA)=""
 ;;^DD(1.5216,3,1,2,2)
 ;;=K ^DMSQ("E","F",$P(^DMSQ("E",DA,0),U,3),X,DA)
 ;;^DD(1.5216,3,1,2,"%D",0)
 ;;=^^1^1^2960827^^^^
 ;;^DD(1.5216,3,1,2,"%D",1,0)
 ;;=Table element by table by type
 ;;^DD(1.5216,3,1,2,"DT")
 ;;=2960827
 ;;^DD(1.5216,3,9)
 ;;=^
 ;;^DD(1.5216,3,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5216,3,21,1,0)
 ;;=C for column, P for primary key, or F for foreign key
 ;;^DD(1.5216,3,"DT")
 ;;=2960926
 ;;^DD(1.5216,4,0)
 ;;=E_COMMENT^F^^0;5^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.5216,4,.1)
 ;;=Comment
 ;;^DD(1.5216,4,3)
 ;;=Answer must be 3-60 characters in length.
 ;;^DD(1.5216,4,9)
 ;;=^
 ;;^DD(1.5216,4,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5216,4,21,1,0)
 ;;=A short description of the element
 ;;^DD(1.5216,4,"DT")
 ;;=2960926
