DIR0K ;SFISC/MKO-GET KEYS FOR FIELD EDITOR ;29APR2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1004,1042**
 ;
GETKEY ;Get key sequences
 N AU,AD,AR,AL,F1,F2,F3,F4,I,K,T
 N REMOVE,PREVSC,NEXTSC
 S AU=$P(DDGLKEY,U,2)
 S AD=$P(DDGLKEY,U,3)
 S AR=$P(DDGLKEY,U,4)
 S AL=$P(DDGLKEY,U,5)
 S F1=$P(DDGLKEY,U,6)
 S F2=$P(DDGLKEY,U,7)
 S F3=$P(DDGLKEY,U,8)
 S F4=$P(DDGLKEY,U,9)
 S REMOVE=$P(DDGLKEY,U,13)
 S PREVSC=$P(DDGLKEY,U,14)
 S NEXTSC=$P(DDGLKEY,U,15)
 ;
 S DIR0(DIR0P_"IN")="",DIR0(DIR0P_"OUT")=""
 ;
NOMOUSE N NOMOUSE I $G(^XTV(8989.5,0))?1"PARAM".E,$$GET^XPAR("ALL","DI SCREENMAN NO MOUSE") S NOMOUSE=1 ;DISABLE MOUSE CLICKS
 I DIR0P="C" S I="" F  S I=$O(DIR0MAP(I)) Q:I'=+$P(I,"E")  S T=DIR0MAP(I) D INOUT
 F I=1:1 S T=$P($T(GENMAP+I),";;",2,999) Q:T=""  D INOUT
 I DIR0P="" F I=1:1 S T=$P($T(SMMAP+I),";;",2,999) Q:T=""  D INOUT
 ;
 S DIR0(DIR0P_"IN")=DIR0(DIR0P_"IN")_U
 S DIR0(DIR0P_"OUT")=$E(DIR0(DIR0P_"OUT"),1,$L(DIR0(DIR0P_"OUT"))-1)
 Q
 ;
INOUT ;Set DIR0("IN") and DIR0("OUT")
 I $P(T,";",2)="KEYDOWN" Q:$P(T,";")=""  S DIR0KD=$P(T,";"),K="KD"
 E  I $P(T,";",2)="TIMEOUT" Q:$P(T,";")=""  S DIR0TO=$P(T,";"),K="TO"
 E  S @("K="_$P(T,";",2)) I $G(NOMOUSE),T?1"MOUSE".E Q  ;WE MAY NOT ALLOW THE THREE MOUSECLICKS
 I DIR0(DIR0P_"IN")'[(U_K) D
 . S DIR0(DIR0P_"IN")=DIR0(DIR0P_"IN")_U_K
 . S DIR0(DIR0P_"OUT")=DIR0(DIR0P_"OUT")_$P(T,";")_";"
 ;
 Q
GENMAP ;General field editor key sequences
 ;;RIGHT;AR
 ;;LEFT;AL
 ;;JRT;F1_AR
 ;;JLT;F1_AL
 ;;FDE;F1_F1_AR
 ;;FDB;F1_F1_AL
 ;;WRT;F1_" "
 ;;WRT;$C(12)
 ;;WLT;$C(10)
 ;;DEL;REMOVE
 ;;DEL;F2
 ;;CLR;F1_"D"
 ;;CLR;$C(21)
 ;;DEOF;F1_F2
 ;;DLW;$C(23)
 ;;CR;$C(13)
 ;;UP;AU
 ;;DOWN;AD
 ;;TAB;$C(9)
 ;;RPM;F3
 ;;BS;$C(127)
 ;;BS;$C(8)
 ;;MOUSE;$C(27,91,77,35)
 ;;MOUSEDN;$C(27,91,77,32)
 ;;MOUSERT;$C(27,91,77,33)
 ;;
SMMAP ;ScreenMan specific key sequences
 ;;FDL;F4
 ;;NB;F1_F4
 ;;NP;F1_AD
 ;;NP;NEXTSC
 ;;PP;F1_AU
 ;;PP;PREVSC
 ;;HLP;F1_"H"
 ;;SEL;F1_"L"
 ;;EX;F1_"E"
 ;;QT;F1_"Q"
 ;;CL;F1_"C"
 ;;SV;F1_"S"
 ;;RF;F1_"R"
 ;;ZM;F1_"Z"
 ;;PRNT;F1_"P"
 ;;
