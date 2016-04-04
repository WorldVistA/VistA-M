DINIT2AC ;SFISC/MKO-DATA FOR KEY AND INDEX FILES ;10:50 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT2B0 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DD("KEY",.1101,0)
 ;;=.11^A^P^.1101^^
 ;;^DD("KEY",.1101,2,0)
 ;;=^.312I^2^2
 ;;^DD("KEY",.1101,2,1,0)
 ;;=.01^.11^1
 ;;^DD("KEY",.1101,2,2,0)
 ;;=.02^.11^2
 ;;^DD("KEY",.11401,0)
 ;;=.114^A^P^.11401^^
 ;;^DD("KEY",.11401,2,0)
 ;;=^.312I^1^1
 ;;^DD("KEY",.11401,2,1,0)
 ;;=.01^.114^1
 ;;^DD("KEY",.3101,0)
 ;;=.31^A^P^.3101^^
 ;;^DD("KEY",.3101,2,0)
 ;;=^.312I^2^2
 ;;^DD("KEY",.3101,2,1,0)
 ;;=.01^.31^1
 ;;^DD("KEY",.3101,2,2,0)
 ;;=.02^.31^2
 ;;^DD("KEY",.31201,0)
 ;;=.312^A^P^.31201^^
 ;;^DD("KEY",.31201,2,0)
 ;;=^.312I^2^2
 ;;^DD("KEY",.31201,2,1,0)
 ;;=.01^.312^1
 ;;^DD("KEY",.31201,2,2,0)
 ;;=.02^.312^2
