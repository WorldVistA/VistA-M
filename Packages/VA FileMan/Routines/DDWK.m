DDWK ;SFISC/MKO-SCREEN EDITOR MAIN ROUTINE ;11:32 AM  25 Aug 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**18**
 ;
GETKEY ;Get key sequences and defaults
 N AU,AD,AR,AL,F1,F2,F3,F4
 N FIND,SELECT,INSERT,REMOVE,PREVSC,NEXTSC
 N A1,A2,A3,I,K,N,T
 S AU=$P(DDGLKEY,U,2)
 S AD=$P(DDGLKEY,U,3)
 S AR=$P(DDGLKEY,U,4)
 S AL=$P(DDGLKEY,U,5)
 S F1=$P(DDGLKEY,U,6)
 S F2=$P(DDGLKEY,U,7)
 S F3=$P(DDGLKEY,U,8)
 S F4=$P(DDGLKEY,U,9)
 S FIND=$P(DDGLKEY,U,10)
 S SELECT=$P(DDGLKEY,U,11)
 S INSERT=$P(DDGLKEY,U,12)
 S REMOVE=$P(DDGLKEY,U,13)
 S PREVSC=$P(DDGLKEY,U,14)
 S NEXTSC=$P(DDGLKEY,U,15)
 ;
 S A1="DDW(""IN"")",A2="DDW(""OT"")",A3=0
 S (DDW("IN"),DDW("OT"))=""
 F I=1:1 S T=$P($T(MAP+I),";;",2,999) Q:T=""  D
 . S @("K="_$P(T,";",2)),T=$P(T,";")
 . I K]"",@A1'[(U_K) D
 .. I $L(@A1)+$L(K)+2>255!($L(@A2)+$L(T)+1>255) D
 ... S @A1=@A1_U,$E(@A2,$L(@A2))=""
 ... S A3=A3+1,A1=$NA(@A1@(A3)),A2=$NA(@A2@(A3))
 ... S (@A1,@A2)=""
 .. S @A1=@A1_U_K
 .. S @A2=@A2_T_U
 S @A1=@A1_U,$E(@A2,$L(@A2))=""
 Q
 ;
MAP ;Keys for main screen
 ;;UP;AU
 ;;DN;AD
 ;;RT;AR
 ;;LT;AL
 ;;TAB;$C(9)
 ;;PUP;F1_AU
 ;;PUP;PREVSC
 ;;PDN;F1_AD
 ;;PDN;NEXTSC
 ;;JLT;F1_AL
 ;;JRT;F1_AR
 ;;LB;FIND
 ;;LB;F1_F1_AL
 ;;LE;SELECT
 ;;LE;F1_F1_AR
 ;;TOP;F1_"T"
 ;;BOT;F1_"B"
 ;;WRT;F1_" "
 ;;WRT;$C(12)
 ;;WLT;$C(10)
 ;;RUB;$C(127)
 ;;RUB;$C(8)
 ;;DEL;REMOVE
 ;;DEL;F4
 ;;DEOL;F1_F2
 ;;BRK;$C(13)
 ;;JN;F1_"J"
 ;;RFT;F1_"R"
 ;;ST;F1_"?"
 ;;XLN;F1_"D"
 ;;TST;F1_$C(9)
 ;;TSALL;F1_F1_$C(9)
 ;;LST;F1_","
 ;;RST;F1_"."
 ;;WRM;F2
 ;;RPM;INSERT
 ;;RPM;F3
 ;;SV;F1_"S"
 ;;SW;F1_"A"
 ;;EX;F1_"E"
 ;;QT;F1_"Q"
 ;;QT;$C(5)
 ;;HLP;F1_"H"
 ;;DLW;$C(23)
 ;;MRK;F1_"M"
 ;;UMK;F1_F1_"M"
 ;;CUT;F1_"X"
 ;;CPY;F1_"C"
 ;;PST;F1_"V"
 ;;FND;F1_"F"
 ;;NXT;F1_"N"
 ;;GTO;F1_"G"
 ;;CHG;F1_"P"
 ;;AUT;F1_F1_"S"
 ;;';$C(27)_"Q"
 ;;';$C(27)_"R"
 ;;";$C(27)_"S"
 ;;";$C(27)_"T"
 ;;
