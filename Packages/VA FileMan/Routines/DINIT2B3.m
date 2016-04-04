DINIT2B3 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B4
Q Q
 ;;^DIC(1.5212,0,"GL")
 ;;=^DMSQ("DM",
 ;;^DIC("B","SQLI_DOMAIN",1.5212)
 ;;=
 ;;^DIC(1.5212,"%D",0)
 ;;=^^11^11^2970806^^
 ;;^DIC(1.5212,"%D",1,0)
 ;;=The set from which all objects of that domain must be drawn.
 ;;^DIC(1.5212,"%D",2,0)
 ;;=In SQLI, all table elements (SQLI_TABLE_ELEMENT) have a domain which
 ;;^DIC(1.5212,"%D",3,0)
 ;;=restricts them to their domain set. For each data type there is a domain
 ;;^DIC(1.5212,"%D",4,0)
 ;;=of the same name, representing the same set. Other domains have different
 ;;^DIC(1.5212,"%D",5,0)
 ;;=set membership restrictions. 
 ;;^DIC(1.5212,"%D",6,0)
 ;;= 
 ;;^DIC(1.5212,"%D",7,0)
 ;;=Each domain has a data type, which determines the rules for comparing
 ;;^DIC(1.5212,"%D",8,0)
 ;;=values from different domains, and the operators which may be used on them.
 ;;^DIC(1.5212,"%D",9,0)
 ;;= 
 ;;^DIC(1.5212,"%D",10,0)
 ;;=The PRIMARY_KEY data type and domain is unique to SQLI. It is used to
 ;;^DIC(1.5212,"%D",11,0)
 ;;=relate primary keys to foreign keys unambiguously (see SQLI_TABLE_ELEMENT)
 ;;^DD(1.5212,0)
 ;;=FIELD^^11^12
 ;;^DD(1.5212,0,"DDA")
 ;;=N
 ;;^DD(1.5212,0,"DT")
 ;;=2970225
 ;;^DD(1.5212,0,"IX","B",1.5212,.01)
 ;;=
 ;;^DD(1.5212,0,"IX","C",1.5212,3)
 ;;=
 ;;^DD(1.5212,0,"IX","D",1.5212,11)
 ;;=
 ;;^DD(1.5212,0,"IX","E",1.5212,1)
 ;;=
 ;;^DD(1.5212,0,"NM","SQLI_DOMAIN")
 ;;=
 ;;^DD(1.5212,0,"PT",1.5216,1)
 ;;=
 ;;^DD(1.5212,0,"VRPK")
 ;;=DI
 ;;^DD(1.5212,.01,0)
 ;;=DM_NAME^RF^^0;1^K:$L(X)>30!($L(X)<3)!'($TR(X,"_")?1U.UN) X
 ;;^DD(1.5212,.01,.1)
 ;;=Domain
 ;;^DD(1.5212,.01,1,0)
 ;;=^.1
 ;;^DD(1.5212,.01,1,1,0)
 ;;=1.5212^B
 ;;^DD(1.5212,.01,1,1,1)
 ;;=S ^DMSQ("DM","B",$E(X,1,30),DA)=""
 ;;^DD(1.5212,.01,1,1,2)
 ;;=K ^DMSQ("DM","B",$E(X,1,30),DA)
 ;;^DD(1.5212,.01,3)
 ;;=Answer must be an SQL identifier 3-30 characters in length.
 ;;^DD(1.5212,.01,4)
 ;;=W ?5,"Must be a valid SQL identifier"
 ;;^DD(1.5212,.01,9)
 ;;=^
 ;;^DD(1.5212,.01,21,0)
 ;;=^^2^2^2970311^^^^
 ;;^DD(1.5212,.01,21,1,0)
 ;;=Name of FileMan domain
 ;;^DD(1.5212,.01,21,2,0)
 ;;=Includes names of standard SQL data types. Must not be a keyword.
 ;;^DD(1.5212,.01,"DT")
 ;;=2960820
 ;;^DD(1.5212,1,0)
 ;;=DM_DATA_TYPE^RP1.5211'^DMSQ("DT",^0;2^Q
 ;;^DD(1.5212,1,.1)
 ;;=Data Type
 ;;^DD(1.5212,1,1,0)
 ;;=^.1
 ;;^DD(1.5212,1,1,1,0)
 ;;=1.5212^E
 ;;^DD(1.5212,1,1,1,1)
 ;;=S ^DMSQ("DM","E",$E(X,1,30),DA)=""
 ;;^DD(1.5212,1,1,1,2)
 ;;=K ^DMSQ("DM","E",$E(X,1,30),DA)
 ;;^DD(1.5212,1,1,1,"%D",0)
 ;;=^^1^1^2960909^
 ;;^DD(1.5212,1,1,1,"%D",1,0)
 ;;=Domain by data type. 
 ;;^DD(1.5212,1,1,1,"DT")
 ;;=2960909
 ;;^DD(1.5212,1,3)
 ;;=
 ;;^DD(1.5212,1,9)
 ;;=^
 ;;^DD(1.5212,1,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5212,1,21,1,0)
 ;;=IEN of a standard data type in SQLI_DATA_TYPE. Required.
 ;;^DD(1.5212,1,"DT")
 ;;=2960909
 ;;^DD(1.5212,2,0)
 ;;=DM_COMMENT^F^^0;3^K:$L(X)>60!($L(X)<3) X
 ;;^DD(1.5212,2,.1)
 ;;=Comment
 ;;^DD(1.5212,2,3)
 ;;=Answer must be 3-60 characters in length.
 ;;^DD(1.5212,2,9)
 ;;=^
 ;;^DD(1.5212,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5212,2,21,1,0)
 ;;=A short comment which describes the data type set
 ;;^DD(1.5212,2,"DT")
 ;;=2960926
 ;;^DD(1.5212,3,0)
 ;;=DM_TABLE^P1.5215'^DMSQ("T",^0;4^Q
 ;;^DD(1.5212,3,.1)
 ;;=Table
 ;;^DD(1.5212,3,1,0)
 ;;=^.1
 ;;^DD(1.5212,3,1,1,0)
 ;;=1.5212^C
 ;;^DD(1.5212,3,1,1,1)
 ;;=S ^DMSQ("DM","C",$E(X,1,30),DA)=""
 ;;^DD(1.5212,3,1,1,2)
 ;;=K ^DMSQ("DM","C",$E(X,1,30),DA)
 ;;^DD(1.5212,3,1,1,"%D",0)
 ;;=^^1^1^2960823^
 ;;^DD(1.5212,3,1,1,"%D",1,0)
 ;;=Domain by table id
 ;;^DD(1.5212,3,1,1,"DT")
 ;;=2960823
 ;;^DD(1.5212,3,3)
 ;;=Enter only if domain is a table-id
 ;;^DD(1.5212,3,9)
 ;;=^
 ;;^DD(1.5212,3,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5212,3,21,1,0)
 ;;=IEN of table in SQLI_TABLE if domain is of type PRIMARY_KEY
 ;;^DD(1.5212,3,21,2,0)
 ;;=Only primary and foreign keys have such domains.
 ;;^DD(1.5212,3,"DT")
 ;;=2960926
 ;;^DD(1.5212,4,0)
 ;;=DM_WIDTH^NJ3,0^^0;5^K:+X'=X!(X>255)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.5212,4,.1)
 ;;=Width
 ;;^DD(1.5212,4,3)
 ;;=Type a Number between 1 and 255, 0 Decimal Digits
 ;;^DD(1.5212,4,9)
 ;;=^
 ;;^DD(1.5212,4,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5212,4,21,1,0)
 ;;=Default display width. Overrides data type display width.
 ;;^DD(1.5212,4,"DT")
 ;;=2960926
 ;;^DD(1.5212,5,0)
 ;;=DM_SCALE^NJ1,0^^0;6^K:+X'=X!(X>9)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(1.5212,5,.1)
 ;;=Scale
 ;;^DD(1.5212,5,3)
 ;;=Type a Number between 0 and 9, 0 Decimal Digits
 ;;^DD(1.5212,5,9)
 ;;=^
 ;;^DD(1.5212,5,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5212,5,21,1,0)
 ;;=Default number of decimal places displayed for numbers.
 ;;^DD(1.5212,5,"DT")
 ;;=2960926
 ;;^DD(1.5212,6,0)
 ;;=DM_OUTPUT_FORMAT^P1.5214'^DMSQ("OF",^0;7^Q
 ;;^DD(1.5212,6,.1)
 ;;=Output Format
 ;;^DD(1.5212,6,3)
 ;;=
 ;;^DD(1.5212,6,9)
 ;;=^
 ;;^DD(1.5212,6,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5212,6,21,1,0)
 ;;=Default output format for elements of this domain.
 ;;^DD(1.5212,6,21,2,0)
 ;;=Used to provide text value of pointer chains, etc.
 ;;^DD(1.5212,6,"DT")
 ;;=2960820
 ;;^DD(1.5212,7,0)
 ;;=DM_INT_EXPR^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5212,7,.1)
 ;;=Base to Internal Expression
 ;;^DD(1.5212,7,3)
 ;;=This is a Standard M expression to format X for output
 ;;^DD(1.5212,7,9)
 ;;=^
 ;;^DD(1.5212,7,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5212,7,21,1,0)
 ;;=An M expression which returns the internal value of a base value.
 ;;^DD(1.5212,7,21,2,0)
 ;;=Expression uses placeholder {B} to represent the base value
 ;;^DD(1.5212,7,"DT")
 ;;=2960926
 ;;^DD(1.5212,8,0)
 ;;=DM_INT_EXEC^K^^2;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5212,8,.1)
 ;;=Base to Internal Execute
 ;;^DD(1.5212,8,3)
 ;;=This is Standard MUMPS code to format X for input
 ;;^DD(1.5212,8,9)
 ;;=^
 ;;^DD(1.5212,8,21,0)
 ;;=^^2^2^2960926^
 ;;^DD(1.5212,8,21,1,0)
 ;;=M code line which sets internal value, {I}, to some function of base
 ;;^DD(1.5212,8,21,2,0)
 ;;=value, {B}.
 ;;^DD(1.5212,8,"DT")
 ;;=2960926
 ;;^DD(1.5212,9,0)
 ;;=DM_BASE_EXPR^K^^3;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5212,9,.1)
 ;;=Internal to Base Expression
 ;;^DD(1.5212,9,3)
 ;;=This is a Standard M expression to format X in internal form.
 ;;^DD(1.5212,9,9)
 ;;=^
 ;;^DD(1.5212,9,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.5212,9,21,1,0)
 ;;=An M expression which returns the internal value of base value, {B}.
 ;;^DD(1.5212,9,"DT")
 ;;=2960926
 ;;^DD(1.5212,10,0)
 ;;=DM_BASE_EXEC^K^^4;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(1.5212,10,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(1.5212,10,9)
 ;;=^
 ;;^DD(1.5212,10,21,0)
 ;;=^^1^1^2960820^
