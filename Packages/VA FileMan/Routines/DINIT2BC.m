DINIT2BC ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2BD
Q Q
 ;;^DIC(1.5219,0,"GL")
 ;;=^DMSQ("F",
 ;;^DIC("B","SQLI_FOREIGN_KEY",1.5219)
 ;;=
 ;;^DIC(1.5219,"%D",0)
 ;;=^^6^6^2970806^^^^
 ;;^DIC(1.5219,"%D",1,0)
 ;;=A set of columns in a table that match the primary key of another table.
 ;;^DIC(1.5219,"%D",2,0)
 ;;= They represent an explicit join of the two tables. Each foreign key
 ;;^DIC(1.5219,"%D",3,0)
 ;;= element points to it's table element (SQLI_TABLE_ELEMENT),
 ;;^DIC(1.5219,"%D",4,0)
 ;;=a column in the local table (SQLI_COLUMN) and a primary key element of a
 ;;^DIC(1.5219,"%D",5,0)
 ;;= foreign table (SQLI_PRIMARY_KEY). The primary key table element of the
 ;;^DIC(1.5219,"%D",6,0)
 ;;=foreign table has the domain of that table, which makes the connection.
 ;;^DD(1.5219,0)
 ;;=FIELD^^2^3
 ;;^DD(1.5219,0,"DDA")
 ;;=N
 ;;^DD(1.5219,0,"DT")
 ;;=2960820
 ;;^DD(1.5219,0,"IX","B",1.5219,.01)
 ;;=
 ;;^DD(1.5219,0,"NM","SQLI_FOREIGN_KEY")
 ;;=
 ;;^DD(1.5219,0,"VRPK")
 ;;=DI
 ;;^DD(1.5219,.01,0)
 ;;=F_TBL_ELEMENT^RP1.5216'^DMSQ("E",^0;1^Q
 ;;^DD(1.5219,.01,.1)
 ;;=Foreign Key
 ;;^DD(1.5219,.01,1,0)
 ;;=^.1
 ;;^DD(1.5219,.01,1,1,0)
 ;;=1.5219^B
 ;;^DD(1.5219,.01,1,1,1)
 ;;=S ^DMSQ("F","B",$E(X,1,30),DA)=""
 ;;^DD(1.5219,.01,1,1,2)
 ;;=K ^DMSQ("F","B",$E(X,1,30),DA)
 ;;^DD(1.5219,.01,3)
 ;;=
 ;;^DD(1.5219,.01,9)
 ;;=^
 ;;^DD(1.5219,.01,21,0)
 ;;=^^1^1^2960926^^^^
 ;;^DD(1.5219,.01,21,1,0)
 ;;=IEN of foreign key table element in SQLI_TABLE_ELEMENT
 ;;^DD(1.5219,.01,"DT")
 ;;=2960828
 ;;^DD(1.5219,1,0)
 ;;=F_PK_ELEMENT^RP1.5218'^DMSQ("P",^0;2^Q
 ;;^DD(1.5219,1,.1)
 ;;=Primary Key
 ;;^DD(1.5219,1,9)
 ;;=^
 ;;^DD(1.5219,1,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5219,1,21,1,0)
 ;;=IEN of primary key element in SQLI_PRIMARY_KEY of foreign table
 ;;^DD(1.5219,1,"DT")
 ;;=2960926
 ;;^DD(1.5219,2,0)
 ;;=F_CLM_ELEMENT^RP1.5217'^DMSQ("C",^0;3^Q
 ;;^DD(1.5219,2,.1)
 ;;=Column
 ;;^DD(1.5219,2,9)
 ;;=^
 ;;^DD(1.5219,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5219,2,21,1,0)
 ;;=IEN of column of this table in SQLI_COLUMN which matches foreign PK
 ;;^DD(1.5219,2,"DT")
 ;;=2960926
