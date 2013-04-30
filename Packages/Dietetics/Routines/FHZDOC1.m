FHZDOC1 ; HISC/REL - First Line Listing ;8/2/90  15:19 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S X="N",%DT="XT" D ^%DT S DTP=Y D DTP^FH
 W !,"Routine First-line List",!!
GET W ! D ^%ZIS Q:POP  K %UTILITY D ^%RSEL
 S NAM="" G:$O(%UTILITY(NAM))="" DONE
 U IO W @IOF,!?22,"First line list of DIETETIC Programs",!?31,DTP,!!
GO S NAM=$O(%UTILITY(NAM)) G:NAM="" DONE
 X "ZL @NAM S X=$T(+1)" S N=$P(X,"-",2,99),N=$P(N,";",1) W $P(X," ",1),?10,N,! W:$Y>60 @IOF G GO
DONE U IO(0) S IOP="" D ^%ZIS Q
