DICATTD2 ;SFISC/GFT-NUMERIC FIELD ;1/7/2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,160**
 ;
POST2 ;check NUMERIC
 N L,D,DD,Z,T
 S DD=$$G(34),D=$$G(33),Y=$$G(31) Q:Y=""  S L=$$G(32) Q:L=""
 I L<Y S DDSERROR=1,DDSBR="31^DICATT2^2.2" D HLP^DDSUTL("'MINIMUM' & 'MAXIMUM' ARE IN WRONG ORDER") Q
 S DICATTMN="Type a "_$P("number^dollar amount",U,$$G(33)=1+1)_" between "_Y_" and "_L_", "_DD_" decimal digit"_$E("s",DD'=1)_"."
 S DICATT5N="K:+X'=X",T=DD+1,Z="!(X?.E"_"1""."""_T_".N)"
DOLLAR I D,DICATTF-.001 S DICATT5N="S:X[""$"" X=$P(X,""$"",2) K:X'?"_$P(".""-""",U,Y<0)_".N.1""."".2N"
 S DICATT5N=DICATT5N_"!(X>"_L_")!(X<"_Y_")"_Z_" X",DICATTLN=$L(L\1)+T-(T=1)+(L<0),DICATT2N="NJ"_DICATTLN_","_DD,DICATT3N=""
CHNG I DICATT5N=DICATT5 K DICATTMN ;No DICATTMN means no change
 D:$D(DICATTMN) PUT^DDSVALF(98,"DICATT",1,DICATTMN)
 Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT2",2.2,"I","")
