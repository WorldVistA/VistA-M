DINIT21 ;SFISC/GFT-INITIALIZE VA FILEMAN ; 08MAR2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**110,160,165,1035,1040,1041**
 ;
DINITOSX G DD:'$O(^DD("OS",0)),DD:'$D(^DD("OS",19,"RM")) ; RM node introduced in 22.2; must re-install file if not there.
 W !!,"Do you want to change the MUMPS OPERATING SYSTEM File? NO//" R Y:60 Q:Y["^"!("Nn"[$E(Y))!('$T)
 I "Yy"'[$E(Y) W !,"Answer YES to overwrite MAXIMUM ROUTINE SIZE" G DINITOSX
 ; Variable DINITOSX used in Routine DINIT6. TODO: See if we can move that logic here. VEN/SMH 3121128
DD S DINITOSX=1 F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) Q:X?.P  S D="^DD(""OS"","_$E($P(X," ",2),3,99)_")" S @D=Y
 ;;0 MUMPS OPERATING SYSTEM^.7
 ;;8,0 MSM^^127^5000^^1^63
 ;;8,1 B X
 ;;8,8 X ^DD("$O")
 ;;8,18 I $D(^ (X))
 ;;8,"DEL" X "ZR  ZS @X" K ^UTILITY("%RD",X)
 ;;8,"EOFF" U $I:(::::1)
 ;;8,"EON" U $I:(:::::1)
 ;;8,"LOAD" S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;8,"NO-TYPE-AHEAD" U $I:(::::100663296)
 ;;8,"RM" U:IOT["TRM" $I:X
 ;;8,"RSEL" K ^UTILITY($J) G ^%RSEL
 ;;8,"SDP" O @("DIO:"_DLP) F %=0:0 U DIO R % Q:$ZA=X&($ZB>Y)!($ZA>X)  U IO W:$A(%)'=12 ! W %
 ;;8,"SDPEND" S X=$ZA,Y=$ZB
 ;;8,"TRMOFF" U $I:(::::::::$C(13,27))
 ;;8,"TRMON" U $I:(::::::::$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))
 ;;8,"TRMRD" S Y=$ZB
 ;;8,"TYPE-AHEAD" U $I:(::::67108864:33554432)
 ;;8,"UCICHECK" S Y=$$UCICHECK^DINVMSM(X)
 ;;8,"XY" S $X=IOX,$Y=IOY
 ;;8,"ZS" ZR  X "S %Y=0 F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y=""""  Q:'$D(^(%Y))  ZI ^(%Y)" ZS @X
 ;;9,0 DTM-PC^^127^5000^^1^115
 ;;9,1 B X
 ;;9,8 D:$P($ZVER,"/",2)<4 ^%VARLOG X:$P($ZVER,"/",2)'<4 ^DD("$O")
 ;;9,18 I $ZRSTATUS(X)'=""
 ;;9,"SDP" O @("DIO:"_"(""R"":"_$P(DLP,":",2,9)) F %=0:0 U DIO R % Q:$ZIOS=3  U IO W:$A(%)'=12 ! W %
 ;;9,"SDPEND" Q
 ;;9,"XY" S $X=IOX,$Y=IOY
 ;;9,"ZS" S %X="" X "S %Y=0 F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y=""""  Q:'$D(^(%Y))  S %X=%X_$C(10)_^(%Y)" ZS @X:$E(%X,2,999999)
 ;;16,0 DSM for OpenVMS^^108^5000^^1^63
 ;;16,1 U @("$I:"_$P("NO",1,'X)_"CENABLE")
 ;;16,8 D DOLRO^%ZOSV
 ;;16,18 I $T(^@X)]""
 ;;16,"SDP" O DIO U DIO:DISCONNECT F %=0:0 U DIO R % Q:%="#$#"  U IO W:$A(%)'=12 ! W %
 ;;16,"SDPEND" W !,"#$#",! C IO
 ;;16,"XY" S $X=IOX,$Y=IOY
 ;;16,"ZS" ZR  X "S %Y=0 F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y=""""  Q:'$D(^(%Y))  ZI ^(%Y)" ZS @X
 ;;17,0 GT.M(VAX)^^250^15000^^1^250
 ;;17,1 U @("$I:"_$P("NO",1,'X)_"CENABLE")
 ;;17,8 X ^DD("$O") ;D DOLRO^%ZOSV
 ;;17,18 I $L($T(^@X))
 ;;17,"DEL" D DEL^DINVGTM(X)
 ;;17,"EOFF" U $I:(NOECHO)
 ;;17,"EON" U $I:(ECHO)
 ;;17,"LOAD" N %,%N S %N=0 F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N^@X) Q:$L(%)=0  S @(DIF_XCNP_",0)")=%
 ;;17,"NO-TYPE-AHEAD" U $I:(NOTYPEAHEAD)
 ;;17,"RM" U $I:(WIDTH=$S(X<256:X,1:0):FILTER="ESCAPE")
 ;;17,"RSEL" N %ZR,X K ^UTILITY($J) D ^%RSEL S X="" X "F  S X=$O(%ZR(X)) Q:X=""""  S ^UTILITY($J,X)="""""
 ;;17,"SDP" O DIO F  U DIO R % Q:%="#$#"  U IO W:$A(%)'=12 ! W %
 ;;17,"SDPEND" W !,"#$#",! C IO
 ;;17,"TRMOFF" U $I:(TERMINATOR="")
 ;;17,"TRMON" U $I:(TERMINATOR=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))
 ;;17,"TRMRD" S Y=$A($ZB)
 ;;17,"TYPE-AHEAD" U $I:(TYPEAHEAD)
 ;;17,"UCICHECK" S Y=1
 ;;17,"XY" S $X=IOX,$Y=IOY
 ;;17,"ZS" N %,%I,%F,%S S %I=$I,%F=$P($ZRO,",")_X_".m" O %F:(NEWVERSION) U %F X "S %S=0 F  S %S=$O(^UTILITY($J,0,%S)) Q:%S=""""  Q:'$D(^(%S))  S %=^UTILITY($J,0,%S) I $E(%)'="";"" W %,!" C %F U %I
 ;;18,0 CACHE/OpenM^^250^15000^^1^250
 ;;18,1 B X
 ;;18,8 X ^DD("$O")
 ;;18,18 I $T(^@X)]""
 ;;18,"DEL" X "ZR  ZS @X"
 ;;18,"EOFF" U $I:("":"+S")
 ;;18,"EON" U $I:("":"-S")
 ;;18,"HIGHESTCHAR" N DIUTF8 S DIUTF8=$L($C(256))>0 S Y=$C($S(DIUTF8:65533,1:255))
 ;;18,"LOAD" N %,%N S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;18,"NO-TYPE-AHEAD" U $I:("":"+F":$C(13,27))
 ;;18,"RM" I $G(IOT)["TRM" U $I:X
 ;;18,"RSEL" K ^UTILITY($J) D KERNEL^%RSET K %ST
 ;;18,"SDP" C DIO O DIO F %=0:0 U DIO R % Q:%="#$#"  U IO W %
 ;;18,"SDPEND" W !,"#$#",! C IO
 ;;18,"TRMOFF" U $I:("":"-I-T":$C(13,27))
 ;;18,"TRMON" U $I:("":"+I+T")
 ;;18,"TRMRD" S Y=$A($ZB),Y=$S(Y<32:Y,Y=127:Y,1:0)
 ;;18,"TYPE-AHEAD" U $I:("":"-F":$C(13,27))
 ;;18,"UCICHECK" X "N % S %=$P(X,"","",1),Y=0 I $ZU(90,10,%) S Y=%"
 ;;18,"XY" S $Y=IOY,$X=IOX
 ;;18,"ZS" ZR  X "S %Y=0 F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y=""""  Q:'$D(^(%Y))  ZI ^(%Y)" ZS @X
 ;;19,0 GT.M(UNIX)^^250^15000^^1^250
 ;;19,1 U @("$I:"_$P("NO",1,'X)_"CENABLE")
 ;;19,8 X ^DD("$O") ;D DOLRO^%ZOSV
 ;;19,18 I $L($T(^@X))
 ;;19,"DEL" D DEL^DINVGUX(X)
 ;;19,"EOFF" U $I:(NOECHO)
 ;;19,"EON" U $I:(ECHO)
 ;;19,"HIGHESTCHAR" N DIUTF8 S DIUTF8=$L($C(256))>0 S Y=$C($S(DIUTF8:983037,1:255))
 ;;19,"LOAD" N %,%N S %N=0 F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N^@X) Q:$L(%)=0  S @(DIF_XCNP_",0)")=%
 ;;19,"NO-TYPE-AHEAD" U $I:(NOTYPEAHEAD)
 ;;19,"RM" U $I:(WIDTH=$S(X<256:X,1:0):FILTER="ESCAPE")
 ;;19,"RSEL" K ^UTILITY($J) D ^%RSEL S X="" X "F  S X=$O(%ZR(X)) Q:X=""""  S ^UTILITY($J,X)=""""" K %ZR
 ;;19,"SDP" O DIO F  U DIO R % Q:%="#$#"  U IO W:$A(%)'=12 ! W %
 ;;19,"SDPEND" W !,"#$#",! C IO
 ;;19,"TRMOFF" U $I:(TERMINATOR="")
 ;;19,"TRMON" U $I:(TERMINATOR=$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127))
 ;;19,"TRMRD" S Y=$A($ZB)
 ;;19,"TYPE-AHEAD" U $I:(TYPEAHEAD)
 ;;19,"UCICHECK" S Y=1
 ;;19,"XY" S $X=IOX,$Y=IOY
 ;;19,"ZS" N %,%I,%F,%S S %I=$I,%F=$P($P($P($ZRO,")"),"(",2)," ")_"/"_X_".m" O %F:(NEWVERSION) U %F X "S %S=0 F  S %S=$O(^UTILITY($J,0,%S)) Q:%S=""""  Q:'$D(^(%S))  S %=^UTILITY($J,0,%S) I $E(%)'="";"" W %,!" C %F U %I ZLINK X
 ;;100,0 OTHER^^40^5000
 ;;100,1 Q
