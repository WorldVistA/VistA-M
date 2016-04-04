DINIT2AB ;SFISC/MKO-DATA FOR KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT2AC S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DD("IX",.31203,0)
 ;;=.312^S^Lets FileMan step through Key fields in sequence^R^^R^IR^I^.312^^^^^LS
 ;;^DD("IX",.31203,.1,0)
 ;;=^^4^4^2980911^
 ;;^DD("IX",.31203,.1,1,0)
 ;;=The S index, a compound index on all fields of the Fields multiple of the
 ;;^DD("IX",.31203,.1,2,0)
 ;;=Key file, lets FileMan step through the key fields in sequence. This is
 ;;^DD("IX",.31203,.1,3,0)
 ;;=essential for prompting, returning values, as well as for the generation
 ;;^DD("IX",.31203,.1,4,0)
 ;;=of each key's uniqueness index.
 ;;^DD("IX",.31203,1)
 ;;=S ^DD("KEY",DA(1),2,"S",X(1),X(2),X(3),DA)=""
 ;;^DD("IX",.31203,2)
 ;;=K ^DD("KEY",DA(1),2,"S",X(1),X(2),X(3),DA)
 ;;^DD("IX",.31203,2.5)
 ;;=K ^DD("KEY",DA(1),2,"S")
 ;;^DD("IX",.31203,11.1,0)
 ;;=^.114^3^3
 ;;^DD("IX",.31203,11.1,1,0)
 ;;=1^F^.312^1^^1
 ;;^DD("IX",.31203,11.1,2,0)
 ;;=2^F^.312^.01^^2
 ;;^DD("IX",.31203,11.1,3,0)
 ;;=3^F^.312^.02^^3
