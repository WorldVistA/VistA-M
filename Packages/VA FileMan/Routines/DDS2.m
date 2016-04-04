DDS2 ;SFISC/MLH-UP ARROW JUMP, BRANCH ;2015-01-02  4:52 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1006,1011,1013,1028**
 ;
 ;
MOUSE ;Mouse has clicked: DDSMX=$X,DDSMY=$Y
 N DDSBO,P,DDS2O,%
 S DDACT="N",DDSMOUSY=1,DDS2O=DDO,DDSBO=DDSBK
 S X="" F  S X=$O(DDSMOUSE(DDSMY,X)) Q:X=""!(X>DDSMX)  S P=$O(DDSMOUSE(DDSMY,X,"")) I P'<DDSMX S X=$G(DDSMOUSE(DDSMY,X,P)) Q:X=""  D  S:X'[U X=X_"^DDS01" G @X
 .;If they've clicked "+" on a different block, just go to that block
 .I X="NP"!(X="PP") N B S P=$$FINDXY(DDSMY,DDSMX+1),B=$P(P,",",2) I B,B-DDSBO S DDSMX=DDSMX+1,X="F^DDS2"
 I DDSMY+1=IOSL G OUT ;They clicked on COMMAND LINE
F S X=$$FINDXY(DDSMY,DDSMX) Q:'X
 I $L(X,",")<4 S DDO=X,DDS2X="" D DDO S:DDSBK-DDSBO DDACT="NB" Q  ;Going to single-valued field might mean leaving this block
 N D,B,DDSCL,DDSDDO,DDSNR,DDSPDA,DDSSN,DDSSTL ;Going to a multiple...
 S DDSCL=$P(X,",",4)
 I $P(X,",",2)=DDSBK,$D(DDSREP),$P(DDSREP,U,3)=DDSCL S DDO=$P(X,",",1,3),DDS2X="" D DDO Q  ;We clicked on a Field in the current multiple
 S P=$P(X,",",3),B=$P(X,",",2),DDSDDO=+X
 I B'=DDSBK S D=@DDSREFT@(P,B),DDSREP=$P(^(B,D),U,2,99),DDSBK=B
 S DDSPDA=$P(DDSREP,U),DDSSTL=$P(DDSREP,U,2),DDSSN=DDSSTL-1+DDSCL
 S X=DDSDA M %=DA N DDSDA,DA S DDSDA=X M DA=% ;We want the current DA & DDSDA to come back after we leave the multiple we're gonna enter!
 D MDA^DDSM S DDACT="NB",DDSBR="" ;Fake out 1^DDS
 Q
 ;
FINDXY(DY,DX) ;Find Field that is at mouseclick position
 N F,B,Z,CAP,HITE,REP,TOP,D,ABOVE,PYX,PY
 S PYX=$P($G(^DIST(.403,+DDS,40,DDSPG,0)),U,3) Q:'PYX  ;Page co-ords --must be added to Block's!
 F B=0:0 S B=$O(@DDSREFS@(DDSPG,B)) Q:'B  D  Q:$G(Z)
 .Q:'$D(^DIST(.403,+DDS,40,DDSPG,40,B,0))
 .S REP=$G(^(2)),TOP=$P($G(^(0)),U,3)+PYX-1 I DY+1<TOP!($P(^(0),U,4)'="e") Q  ;Click is above this Block, or Block's not editable
 .I REP<2 D DX(DY) Q  ;NON-REPEATING BLOCK  May return Z
 .S HITE=$$HITE^DDSR(B),D=$G(@DDSREFT@(DDSPG,B)) Q:D=""!'HITE
 .S ABOVE=$P($G(^(B,D)),U,3)-1 Q:ABOVE<0
 .S PY=$P(PYX,",",2)-1
 .F F=0:0 S F=$O(^DIST(.404,B,40,F)) Q:'F  D  I $D(Z) S Z=F_","_B_","_DDSPG_","_Z Q
 ..S S=$P($P($G(^(F,2)),U),",",2) Q:'S  S S=S+PY Q:S+$P(^(2),U,2)-2<DX  ;Click is to the right of data
 ..I DX+1<S S CAP=$P($P(^(2),U,3),",",2) Q:'CAP  S CAP=CAP+PY Q:CAP-1>DX  ;Click is to the left of Caption
 ..S S=^(2)+TOP-2 ;$Y OF THE FIRST MULTIPLE for this Field
 ..S S=DY-S+HITE/HITE Q:S<1!(S[".")!(S>REP)  ;Can't click above or below the window
 ..I $D(@DDSREFT@(DDSPG,B,D,S+ABOVE)) S Z=S Q  ;Z IS THE LINE   MUST BE OFFSET BY NUMBER OF ONES ABOVE!
 ..I $P(@DDSREFS@(DDSPG,B),U,9)'=F Q  ;Must go to 1st field of new multiple
 ..I S=1!$D(@DDSREFT@(DDSPG,B,D,S-1+ABOVE)) S Z=S
 Q $G(Z) ;Returns FIELD,BLOCK,PAGE,DDSCL
 ;
DX(DY) F F=0:0 S F=$O(@DDSREFS@(DDSPG,B,F)) Q:'F  I $D(^(F,"N")),+$G(^("D"))=DY D  Q:$G(Z)
 .I $P(@DDSREFS@(DDSPG,B,F,"D"),U,2)+$P(^("D"),U,3)'>DX Q  ;Click is to the right of data
 .I DX<$P(^("D"),U,2) Q:'$G(^DIST(.404,B,40,F,2))  S CAP=$P($P(^(2),U,3),",",2) Q:'CAP  Q:CAP-1>DX  ;Click is to the left of Caption
 .S Z=F_","_B_","_DDSPG
 Q
 ;
NP ;from indirect GO in MOUSE+3, above
 S DDACT="NP" G NP^DDS01
 ;
 ;
UPA ;Up-arrow jump
 Q:$E(X)'=U
 I X?1"^"1.E,X'="^^",$G(DDSDN) D MSG^DDSMSG($$EZBLD^DIALOG(3096),1) Q  ;**
 I X?1"^"1.E,X'="^^" D JMP Q
 ;
 ;Up-arrow only
OUT I 'DDO D E^DDS3 Q
 I $D(DDSREP),DA D POSTACT D:$D(DDSBR)[0 END^DDSM Q
 I $G(DDSDN)=1 D MSG^DDSMSG($$EZBLD^DIALOG(3095),1) Q  ;**
 D POSTACT S:$D(DDSBR)[0 DDSOSV=DDO,DDO=0 Q
 Q
 ;
POSTACT ;Execute post action
 Q:$G(DDSO(12))?." "
 N X
 S X=$G(DDSOLD) X DDSO(12)
 D:$D(DDSBR)#2 BR
 Q
 ;
JMP ;Up-arrow jump
 S DDS2X=X,X=$P(X,U,2) I X="" W $C(7) G KILL
 K DDH,DDQ S DDH=0
 S (X,DDSX)=$$UPCASE($E(X,1,63))
 ;
 ;Find exact matches
 D:$D(@DDSREFS@("CAP",X)) CAP
 D:$D(@DDSREFT@("XCAP",DDSPG,X)) XCAP
 ;
 ;Find partial matches
 S:X="?" (X,DDSX)=""
 F  S DDSX=$O(@DDSREFS@("CAP",DDSX)) Q:DDSX=""!($P(DDSX,X)]"")  D CAP
 S DDSX=X F  S DDSX=$O(@DDSREFT@("XCAP",DDSPG,DDSX)) Q:DDSX=""!($P(DDSX,X)]"")  D XCAP
 ;
NO I 'DDH D MSG^DDSMSG($$EZBLD^DIALOG(3098,$P(DDS2X,U,2)),1) G KILL ;**
 S DDS2O=DDO
 I DDH=1 S DDO=$O(DDH(DDH,""))
 E  S DDD="J" D SC^DDSU
DDO ;DDO=FIELD,BLOCK,PAGE
 S DDS2B=$P(DDO,",",2),DDS2P=$P(DDO,",",3),DDO=+DDO
 G:'DDS2B KILL
 ;
 S DDS2DA=DDSDA
 I DDS2P'=DDSPG D  ;Different Page
 . D:'$D(@DDSREFT@(DDS2P,DDS2B)) EN^DDS1(DDS2P)
 . S DDS2DA=@DDSREFT@(DDS2P,DDS2B)
 . I DDS2DA="" D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR),";;",2))
 .. S DDO=DDS2O
 . E  D CKUNED D:'$G(DDS2UNED)
 .. D POSTACT
 .. S:$D(DDSBR)[0 DDACT="NP",DDSPG=DDS2P,DDSBK=DDS2B,DDSBR="" ;Set the new page
 ;
 E  I DDS2B'=DDSBK D  ;Different Block
 . S DDS2DA=@DDSREFT@(DDS2P,DDS2B)
 . I DDS2DA="" D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR),";;",2))
 .. S DDO=DDS2O
 . E  I $P($G(@DDSREFS@(DDS2P,DDS2B)),U,4) D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR1),";;",2))
 .. S DDO=DDS2O
 . E  D CKUNED D:'$G(DDS2UNED)
 .. D POSTACT
 .. S:$D(DDSBR)[0 DDACT="NB",DDSBK=DDS2B,DDSBR="" ;Set the new Block
 ;
 E  D CKUNED D:'$G(DDS2UNED)
 . D POSTACT
 . S:$D(DDSBR)[0 DDACT="N"
 ;
KILL S X=DDS2X
 K DDH,DDSI,DDSPGRP,DDSX
 K DDS2ATT,DDS2B,DDS2DA,DDS2F,DDS2O,DDS2P,DDS2UNED,DDS2X
 Q
 ;
CKUNED ;Check uneditable status
 N DDP,DDSFLD
 ;
 I $P($G(^DIST(.404,DDS2B,40,+DDO,0)),U,3)=2 D
 . S DDP=0
 . S DDSFLD=+DDO_","_DDS2B
 E  D
 . S DDP=$P($G(@DDSREFS@(DDS2P,DDS2B)),U,3)
 . S DDSFLD=$P($G(^DIST(.404,DDS2B,40,+DDO,1)),U)
 I 'DDSFLD S DDS2UNED=1,DDO=DDS2O Q
 S DDS2ATT=$P($G(@DDSREFT@("F"_DDP,DDS2DA,DDSFLD,"A")),U,4)
 ;
 I DDO,$S(DDS2ATT="":$P($G(^DIST(.404,DDS2B,40,+DDO,4)),U,4)=1,1:DDS2ATT=1),'$P(@DDSREFS@(DDS2P,DDS2B,+DDO,"N"),U,11) D
UNED .S DDS2UNED=$P(^DIST(.404,DDS2B,40,+DDO,0),U,2) I DDS2UNED="" S DDS2UNED=$P(^(0),U,5) I DDS2UNED="",$G(^(1)),$D(^DD(DDP,^(1),0)) S DDS2UNED=$P(^(0),U)
 .D MSG^DDSMSG($$EZBLD^DIALOG(3090,DDS2UNED),1) ;**FIELD is UNEDITABLE!
 .S DDS2UNED=1,DDO=DDS2O
 Q
 ;
CAP ;Find all captions that match DDSX
 S DDSPGRP="" F  S DDSPGRP=$O(@DDSREFS@("CAP",DDSX,DDSPGRP)) Q:DDSPGRP=""  D
 . Q:U_DDSPGRP_U'[(U_DDSPG_U)
 . S DDS2P="" F  S DDS2P=$O(@DDSREFS@("CAP",DDSX,DDSPGRP,DDS2P)) Q:'DDS2P  D
 .. S DDS2B="" F  S DDS2B=$O(@DDSREFS@("CAP",DDSX,DDSPGRP,DDS2P,DDS2B)) Q:'DDS2B  D
 ... S DDS2F="" F  S DDS2F=$O(@DDSREFS@("CAP",DDSX,DDSPGRP,DDS2P,DDS2B,DDS2F)) Q:'DDS2F  D FILL
 Q
 ;
XCAP ;Find all xecutable captions that match DDSX
 S DDS2P=DDSPG
 S DDS2B=0 F  S DDS2B=$O(@DDSREFT@("XCAP",DDSPG,DDSX,DDS2B)) Q:'DDS2B  D
 . S DDS2F=0 F  S DDS2F=+$O(@DDSREFT@("XCAP",DDSPG,DDSX,DDS2B,DDS2F)) Q:'DDS2F  D
 .. I $D(^DIST(.404,DDS2B,40,DDS2F,0))#2,$P(^(0),U,3)'=1 D FILL
 Q
 ;
FILL ;Fill DDH array with possible choices
 S DDS2V=DDSX_$S($P(^DIST(.404,DDS2B,40,DDS2F,0),U,4)]"":" ("_$P(^(0),U,4)_")",1:"")
 S:DDS2P'=DDSPG DDS2V=DDS2V_" ("_$S($P($G(^DIST(.403,+DDS,40,DDS2P,1)),U)]"":$P(^(1),U),1:"Page "_$P(^(0),U))_")"
 S DDH=DDH+1,DDH(DDH,DDS2F_","_DDS2B_","_DDS2P)=DDS2V
 K DDS2V
 Q
 ;
BR ;Evaluate DDSBR
 N B,B1,F,F1,P,P1,E,X Q:$D(DDSBR)[0  I DDSBR="QUIT" S DDACT="Q" Q  ;**
 S P=$P($G(DDSOPB),U),B=$P($G(DDSOPB),U,2),F=$G(DDO),E=1
 S:'B B=+$P(@DDSREFS@(+P,"FIRST"),",",2)
 S P1=$P(DDSBR,U,3),B1=$P(DDSBR,U,2),F1=$P(DDSBR,U)
 ;
 D @$S(P1]"":"PG",B1]"":"BK",1:"FD")
 S:'E DDACT=$S(P'=+DDSOPB:"NP",B'=$P(DDSOPB,U,2):"NB",1:"N"),DDSPG=P,DDSBK=B,DDO=F
 K:E DDSBR
 Q
 ;
PG ;
 I P1=+$P(P1,"E") S P=$O(^DIST(.403,+DDS,40,"B",P1,""))
 E  S P=$O(^DIST(.403,+DDS,40,"C",$$UPCASE(P1),""))
 Q:'P
 S:B1="" B1=$O(^DIST(.403,+DDS,40,P,40,"AC","")) Q:B1=""
BK ;
 I B1=+$P(B1,"E") D
 . S B=$O(^DIST(.403,+DDS,40,P,40,"AC",B1,""))
 E  D
 . S B=$O(^DIST(.404,"B",B1,"")) Q:B=""
 . S B=$O(^DIST(.403,+DDS,40,P,40,"B",B,""))
 Q:'B
 S:F1="" F1=$O(^DIST(.404,B,40,"B",""))
FD ;
 Q:F1=""
 I F1="COM" S (E,F)=0 Q
 I F1=+$P(F1,"E") S X="B"
 E  S F1=$$UPCASE(F1),X=$S($D(^DIST(.404,B,40,"D",F1)):"D",1:"C")
 S F=$O(^DIST(.404,B,40,X,F1,""))
 S:F E=0
 Q
 ;
UPCASE(X) ;
 ;Return X in uppercase
 Q $$UP^DILIBF(X)  ;**
 ;
ERR ;;Unable to jump to that field.  The block on which that field is located has no record associated with it.
 ;
ERR1 ;;Unable to jump to that field.  The block on which that field is located has navigation disabled.
