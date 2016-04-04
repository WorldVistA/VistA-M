DITMU3 ;SFISC/EDE(OHPRD)-GET XREFS FOR ONE FIELD IN ONE FILE/SUBFILE ;2015-01-03  10:14 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; Given a file/subfile number, a field number, and a variable
 ; from which to assign subscripted values, this routine will
 ; return the xrefs for the specified field.
 ;
 ; The returned xrefs will be subscripted from the ROOT as follows:
 ;
 ;  ROOT(FIELD,n)     = file/subfile^xref (e.g. 9000010^AC)
 ;  ROOT(FIELD,n,"K") = executable kill logic
 ;  ROOT(FIELD,n,"S") = executable set logic
 ;
 ; Formal list:
 ;
 ; 1)  FILE   = file or subfile number (call by value)
 ; 2)  FIELD  = field number (call by value)
 ; 3)  ROOT   = array root (call by reference)
 ;
EN(FILE,FIELD,ROOT) ;
START ;
 NEW Y
 F Y=0:0 S Y=$O(^DD(FILE,FIELD,1,Y)) Q:Y'=+Y  S ROOT(FIELD,Y)=^(Y,0),ROOT(FIELD,Y,"S")=^(1),ROOT(FIELD,Y,"K")=^(2)
 Q
