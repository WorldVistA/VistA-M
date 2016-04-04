DITMU1 ;SFISC/EDE(OHPRD)-SETS DA ARRAY FROM D0,D1 ;
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; This routine sets the DA array from D0,D1 etc. or D0,D1
 ; etc. from the DA array.  If the variable DITMU1=2 it sets
 ; the DA array, otherwise it sets D0,D1 etc.
 ;
 ; The variable DITMU1 will be killed upon exiting this routine.
 ;
 ; The entry point KILL kills D0, D1, etc.
 ;
START ;
 NEW I,J
 I $G(DITMU1)=2 D D0DA
 E  D DAD0
 K DITMU1
 Q
 ;
DAD0 ;
 F I=1:1 Q:'$D(DA(I))  S I(99-I)=DA(I)
 S J=0 F I=0:1 S J=$O(I(J)) Q:J'=+J  S @("D"_I)=I(J)
 S @("D"_I)=DA
 Q
 ;
D0DA ;
 F I=0:1 Q:'$D(@("D"_I))  S J=I
 F I=0:1 S DA(J)=@("D"_I) S J=J-1 Q:J<1
 S DA=@("D"_(I+1))
 Q
 ;
KILL ; EXTERNAL ENTRY POINT - KILL D0, D1, ETC.
 NEW I
 F I=0:1 Q:'$D(@("D"_I))  K @("D"_I)
 Q
