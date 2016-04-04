DINIT2B4 ;SFISC/MKO-SQLI FILES ;10:51 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
 G ^DINIT2B5
Q Q
 ;;^DD(1.5212,10,21,1,0)
 ;;=Code which when executed returns the base value of X
 ;;^DD(1.5212,10,"DT")
 ;;=2960820
 ;;^DD(1.5212,11,0)
 ;;=DM_FILEMAN_FIELD_TYPE^S^F:FREE TEXT;N:NUMERIC;P:POINTER;D:DATE;W:WORD-PROCESSING;K:MUMPS;B:BOOLEAN;S:SET-OF-CODES;V:VARIABLE POINTER;^0;8^Q
 ;;^DD(1.5212,11,.1)
 ;;=FT
 ;;^DD(1.5212,11,1,0)
 ;;=^.1
 ;;^DD(1.5212,11,1,1,0)
 ;;=1.5212^D
 ;;^DD(1.5212,11,1,1,1)
 ;;=S ^DMSQ("DM","D",$E(X,1,30),DA)=""
 ;;^DD(1.5212,11,1,1,2)
 ;;=K ^DMSQ("DM","D",$E(X,1,30),DA)
 ;;^DD(1.5212,11,1,1,"%D",0)
 ;;=^^1^1^2960828^
 ;;^DD(1.5212,11,1,1,"%D",1,0)
 ;;=Domain by FileMan type
 ;;^DD(1.5212,11,1,1,"DT")
 ;;=2960828
 ;;^DD(1.5212,11,9)
 ;;=^
 ;;^DD(1.5212,11,21,0)
 ;;=^^1^1^2970225^^^^
 ;;^DD(1.5212,11,21,1,0)
 ;;=FileMan field type (F, N, D, DT, K, ...)
 ;;^DD(1.5212,11,23,0)
 ;;=^^3^3^2970225^^^^
 ;;^DD(1.5212,11,23,1,0)
 ;;=A value in this field indicates that the domain is derived from a
 ;;^DD(1.5212,11,23,2,0)
 ;;=FileMan-specific field type. It is intended to signal vendors that a
 ;;^DD(1.5212,11,23,3,0)
 ;;=proprietary function may be required to implement the domain.
 ;;^DD(1.5212,11,"DT")
 ;;=2970225
