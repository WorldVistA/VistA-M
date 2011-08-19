DIR0K ;SFISC/MKO-GET KEYS FOR FIELD EDITOR ;12:16 PM  15 Feb 1995
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
 E  S @("K="_$P(T,";",2))
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
 ;;
