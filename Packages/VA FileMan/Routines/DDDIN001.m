DDDIN001 ;SFISC/TKW-META DATA DICTIONARY INIT ;14MAR2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(.9)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(.9,0,"GL")
 ;;=^DDD(
 ;;^DIC("B","META DATA DICTIONARY",.9)
 ;;=
 ;;^DD(.9,0)
 ;;=FIELD^^25^6
 ;;^DD(.9,0,"DT")
 ;;=3021101
 ;;^DD(.9,0,"ID","WDI.03")
 ;;=W "    ",$P(^(0),U,3)_",",$P(^(0),U,4)
 ;;^DD(.9,0,"IX","AFF",.9,.03)
 ;;=
 ;;^DD(.9,0,"IX","AFF2",.9,.04)
 ;;=
 ;;^DD(.9,0,"IX","C",.9,.02)
 ;;=
 ;;^DD(.9,0,"NM","META DATA DICTIONARY")
 ;;=
 ;;^DD(.9,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>60!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(.9,.01,1,0)
 ;;=^.1
 ;;^DD(.9,.01,3)
 ;;=Answer must be 3-60 characters in length
 ;;^DD(.9,.01,"DT")
 ;;=3021101
 ;;^DD(.9,.02,0)
 ;;=LOOKUP TERM^F^^0;2^K:$L(X)>30!($L(X)<2) X
 ;;^DD(.9,.02,1,0)
 ;;=^.1
 ;;^DD(.9,.02,1,1,0)
 ;;=.9^C
 ;;^DD(.9,.02,1,1,1)
 ;;=S ^DDD("C",$E(X,1,30),DA)=""
 ;;^DD(.9,.02,1,1,2)
 ;;=K ^DDD("C",$E(X,1,30),DA)
 ;;^DD(.9,.02,1,1,"DT")
 ;;=3021101
 ;;^DD(.9,.02,3)
 ;;=Answer must be 2-30 characters in length
 ;;^DD(.9,.02,"DT")
 ;;=3021101
 ;;^DD(.9,.03,0)
 ;;=DATA DICTIONARY NUMBER^NJ22,6^^0;3^K:+X'=X!(X>999999999999999)!(X<0)!(X?.E1"."7.N) X
 ;;^DD(.9,.03,1,0)
 ;;=^.1
 ;;^DD(.9,.03,1,1,0)
 ;;=.9^AFF^MUMPS
 ;;^DD(.9,.03,1,1,1)
 ;;=N Y S Y=$P(^DDD(DA,0),U,4) S:Y ^DDD("AFF",$E(X,1,30),Y,DA)=""
 ;;^DD(.9,.03,1,1,2)
 ;;=N Y S Y=$P(^DDD(DA,0),U,4) K:Y ^DDD("AFF",$E(X,1,30),Y,DA)
 ;;^DD(.9,.03,1,1,3)
 ;;=MULTIPLE CROSS-REF OF FILE,FIELD
 ;;^DD(.9,.03,1,1,"DT")
 ;;=3021101
 ;;^DD(.9,.03,3)
 ;;=Type a number between 0 and 999999999999999
 ;;^DD(.9,.03,"DT")
 ;;=3021101
 ;;^DD(.9,.04,0)
 ;;=FIELD NUMBER^NJ18,6^^0;4^K:+X'=X!(X>99999999999)!(X<.001)!(X?.E1"."7.N) X
 ;;^DD(.9,.04,1,0)
 ;;=^.1
 ;;^DD(.9,.04,1,1,0)
 ;;=.9^AFF2^MUMPS
 ;;^DD(.9,.04,1,1,1)
 ;;=N Y S Y=$P(^DDD(DA,0),U,3) S:Y ^DDD("AFF",Y,$E(X,1,30),DA)=""
 ;;^DD(.9,.04,1,1,2)
 ;;=N Y S Y=$P(^DDD(DA,0),U,3) K:Y ^DDD("AFF",Y,$E(X,1,30),DA)
 ;;^DD(.9,.04,1,1,3)
 ;;=FILE-FIELD XREF
 ;;^DD(.9,.04,1,1,"DT")
 ;;=3021102
 ;;^DD(.9,.04,3)
 ;;=Type a number between .001 and 99999999999
 ;;^DD(.9,.04,"DT")
 ;;=3021102
 ;;^DD(.9,.05,0)
 ;;=DATA^S^1:YES^0;5
 ;;^DD(.9,1,0)
 ;;=DESCRIPTION^.901^^1;0
 ;;^DD(.9,9.6,0)
 ;;=BUILD(S)^Cm^^ ; ^S %=^DDD(D0,0),X="" D BUILDS^DDD($P(%,U,3),$P(%,U,4))
 ;;^DD(.9,25,0)
 ;;=DATA^S^1:YES^0;4
 ;;^DD(.9,25,0)
 ;;=TYPE^CJ20^^ ; ^S %=^DDD(D0,0),X="" I $P(%,U,3) N D0,DCC S DCC="^DD("_$P(%,U,3)_",",D0=$P(%,U,4) X:D0 $P(^DD(0,.25,0),U,5,99)
 ;;^DD(.9,25,9.01)
 ;;=
 ;;^DD(.9,25,9.1)
 ;;=S %=^DDD(D0,0),X="" I $P(%,U,3) N D0,DCC S DCC="^DD("_$P(%,U,3)_",",D0=$P(%,U,4) X:D0 $P(^DD(0,.25,0),U,5,99)
 ;;^DD(.9,25,"DT")
 ;;=3021101
 ;;^DD(.901,0)
 ;;=DESCRIPTION SUB-FIELD^^.01^1
 ;;^DD(.901,0,"DT")
 ;;=3021101
 ;;^DD(.901,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(.901,0,"UP")
 ;;=.9
 ;;^DD(.901,.01,0)
 ;;=DESCRIPTION^W^^0;1
 ;;^DD(.901,.01,"DT")
 ;;=3021101
 ;;^UTILITY(U,$J,"SBF",.9,.9)
 ;;=
 ;;^UTILITY(U,$J,"SBF",.9,.901)
 ;;=
