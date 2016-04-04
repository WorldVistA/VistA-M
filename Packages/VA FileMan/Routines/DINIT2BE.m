DINIT2BE ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2C0
Q Q
 ;;^DIC(1.52192,0,"GL")
 ;;=^DMSQ("EX",
 ;;^DIC("B","SQLI_ERROR_LOG",1.52192)
 ;;=
 ;;^DIC(1.52192,"%D",0)
 ;;=^^4^4^2970806^^^^
 ;;^DIC(1.52192,"%D",1,0)
 ;;=Log of all errors encountered while compiling SQLI.
 ;;^DIC(1.52192,"%D",2,0)
 ;;=It generates the error text table (SQLI_ERROR_TEXT) on a laygo basis;
 ;;^DIC(1.52192,"%D",3,0)
 ;;=errors are added only when they occur. If DBS errors triggered the
 ;;^DIC(1.52192,"%D",4,0)
 ;;=error, the DIALOG file reference is also saved.
 ;;^DD(1.52192,0)
 ;;=FIELD^^4^5
 ;;^DD(1.52192,0,"DDA")
 ;;=N
 ;;^DD(1.52192,0,"DT")
 ;;=2960829
 ;;^DD(1.52192,0,"IX","B",1.52192,.01)
 ;;=
 ;;^DD(1.52192,0,"IX","C",1.52192,2)
 ;;=
 ;;^DD(1.52192,0,"IX","D",1.52192,3)
 ;;=
 ;;^DD(1.52192,0,"IX","E",1.52192,4)
 ;;=
 ;;^DD(1.52192,0,"NM","SQLI_ERROR_LOG")
 ;;=
 ;;^DD(1.52192,0,"VRPK")
 ;;=DI
 ;;^DD(1.52192,.01,0)
 ;;=FILEMAN_FILE^RNJ15,6^^0;1^K:+X'=X!(X>99999999.999999)!(X<1)!(X?.E1"."7N.N) X
 ;;^DD(1.52192,.01,.1)
 ;;=File
 ;;^DD(1.52192,.01,1,0)
 ;;=^.1
 ;;^DD(1.52192,.01,1,1,0)
 ;;=1.52192^B
 ;;^DD(1.52192,.01,1,1,1)
 ;;=S ^DMSQ("EX","B",$E(X,1,30),DA)=""
 ;;^DD(1.52192,.01,1,1,2)
 ;;=K ^DMSQ("EX","B",$E(X,1,30),DA)
 ;;^DD(1.52192,.01,3)
 ;;=Type a Number between 1 and 99999999.999999, 6 Decimal Digits
 ;;^DD(1.52192,.01,9)
 ;;=^
 ;;^DD(1.52192,.01,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.52192,.01,21,1,0)
 ;;=FileMan source file of error in table build
 ;;^DD(1.52192,.01,"DT")
 ;;=2960828
 ;;^DD(1.52192,1,0)
 ;;=FILEMAN_FIELD^NJ15,6^^0;2^K:+X'=X!(X>99999999.999999)!(X<.001)!(X?.E1"."7N.N) X
 ;;^DD(1.52192,1,3)
 ;;=Type a Number between .001 and 99999999.999999, 6 Decimal Digits
 ;;^DD(1.52192,1,9)
 ;;=^
 ;;^DD(1.52192,1,21,0)
 ;;=^^1^1^2960926^^
 ;;^DD(1.52192,1,21,1,0)
 ;;=FileMan field number of error source
 ;;^DD(1.52192,1,23,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.52192,1,23,1,0)
 ;;=May be other information. This is a bit loose.
 ;;^DD(1.52192,1,"DT")
 ;;=2960828
 ;;^DD(1.52192,2,0)
 ;;=ERROR^RP1.52191^DMSQ("ET",^0;3^Q
 ;;^DD(1.52192,2,.1)
 ;;=Error
 ;;^DD(1.52192,2,1,0)
 ;;=^.1
 ;;^DD(1.52192,2,1,1,0)
 ;;=1.52192^C
 ;;^DD(1.52192,2,1,1,1)
 ;;=S ^DMSQ("EX","C",$E(X,1,30),DA)=""
 ;;^DD(1.52192,2,1,1,2)
 ;;=K ^DMSQ("EX","C",$E(X,1,30),DA)
 ;;^DD(1.52192,2,1,1,"%D",0)
 ;;=^^1^1^2960829^
 ;;^DD(1.52192,2,1,1,"%D",1,0)
 ;;=Error by error number
 ;;^DD(1.52192,2,1,1,"DT")
 ;;=2960829
 ;;^DD(1.52192,2,9)
 ;;=^
 ;;^DD(1.52192,2,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.52192,2,21,1,0)
 ;;=IEN of error text from SQLI_ERROR_TEXT
 ;;^DD(1.52192,2,"DT")
 ;;=2960926
 ;;^DD(1.52192,3,0)
 ;;=ERROR_DATE^RD^^0;4^S %DT="EX" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.52192,3,.1)
 ;;=Run Date
 ;;^DD(1.52192,3,1,0)
 ;;=^.1
 ;;^DD(1.52192,3,1,1,0)
 ;;=1.52192^D
 ;;^DD(1.52192,3,1,1,1)
 ;;=S ^DMSQ("EX","D",$E(X,1,30),DA)=""
 ;;^DD(1.52192,3,1,1,2)
 ;;=K ^DMSQ("EX","D",$E(X,1,30),DA)
 ;;^DD(1.52192,3,1,1,"%D",0)
 ;;=^^1^1^2960829^
 ;;^DD(1.52192,3,1,1,"%D",1,0)
 ;;=Error by date
 ;;^DD(1.52192,3,1,1,"DT")
 ;;=2960829
 ;;^DD(1.52192,3,9)
 ;;=^
 ;;^DD(1.52192,3,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.52192,3,21,1,0)
 ;;=Date of run
 ;;^DD(1.52192,3,"DT")
 ;;=2960926
 ;;^DD(1.52192,4,0)
 ;;=FILEMAN_ERROR^P.84'^DI(.84,^0;5^Q
 ;;^DD(1.52192,4,.1)
 ;;=FileMan Error
 ;;^DD(1.52192,4,1,0)
 ;;=^.1
 ;;^DD(1.52192,4,1,1,0)
 ;;=1.52192^E
 ;;^DD(1.52192,4,1,1,1)
 ;;=S ^DMSQ("EX","E",$E(X,1,30),DA)=""
 ;;^DD(1.52192,4,1,1,2)
 ;;=K ^DMSQ("EX","E",$E(X,1,30),DA)
 ;;^DD(1.52192,4,1,1,"%D",0)
 ;;=^^1^1^2960829^
 ;;^DD(1.52192,4,1,1,"%D",1,0)
 ;;=Error by FileMan Dialog error number
 ;;^DD(1.52192,4,1,1,"DT")
 ;;=2960829
 ;;^DD(1.52192,4,9)
 ;;=^
 ;;^DD(1.52192,4,21,0)
 ;;=^^1^1^2960926^
 ;;^DD(1.52192,4,21,1,0)
 ;;=IEN of FileMan error in DIALOG file
 ;;^DD(1.52192,4,"DT")
 ;;=2960926
