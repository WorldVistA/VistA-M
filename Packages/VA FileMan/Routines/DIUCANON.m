DIUCANON ;GFT/GFT-UTILITIES RELATED TO CANONIC TEMPLATES ;2015-01-03  8:57 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1050**
 ;
 ;
FIND(DI,FILE) ;Looks at e.g., ^DIE("CANONIC",9.6,1)="" or ^DIPT("CANONIC",9.6,1)=""
 N T
 S DI=$S(DI=.4:"PT",DI=.401:"BT",DI=.402:"E",1:U) I DI=U Q ""
 S DI="^DI"_DI,T=$O(@DI@("CANONIC",FILE,"")) I T,$P($G(@DI@(T,0)),U,4)=FILE Q T_U_$P(^(0),U) ;GET THE FAVORED INPUT, SORT OR PRINT TEMPLATE
 Q ""
 ;
HELP ;
 W !,"Answer YES only if you want to make this Template name appear in user dialogs",!?9,"as the default for this File."
 I $G(DA),$G(DIE)?1"^DI".E1"(" D
 .N D,F S D=$P(DIE,"("),F=$P($G(@D@(DA,0)),U,4) I F M D=@D@("CANONIC",F) K D(DA) F I=0:0 S I=$O(D(I)) Q:'I  D
 ..I $D(@D@(I,0)) W !,"Note that the Template named '",$P(^(0),U),"' is already canonic for this File!"
 W !
 Q
