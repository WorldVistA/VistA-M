DDS2 ;SFISC/MLH-UP ARROW JUMP, BRANCH ;10:46 AM  17 Jun 1997
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
UPA ;Up-arrow jump
 Q:$E(X)'=U
 I X?1"^"1.E,X'="^^",$G(DDSDN) D MSG^DDSMSG("No jumping allowed.",1) Q
 I X?1"^"1.E,X'="^^" D JMP Q
 ;
 ;Up-arrow only
 I 'DDO D E^DDS3 Q
 I $D(DDSREP),DA D POSTACT D:$D(DDSBR)[0 END^DDSM Q
 I $G(DDSDN)=1 D MSG^DDSMSG("No exit allowed, since navigation for the block is disabled.",1) Q
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
 I 'DDH D MSG^DDSMSG($P(DDS2X,U,2)_" not found.",1) G KILL
 S DDS2O=DDO
 I DDH=1 S DDO=$O(DDH(DDH,""))
 E  S DDD="J" D SC^DDSU
 ;
 S DDS2B=$P(DDO,",",2),DDS2P=$P(DDO,",",3),DDO=+DDO
 G:'DDS2B KILL
 ;
 S DDS2DA=DDSDA
 I DDS2P'=DDSPG D
 . D:'$D(@DDSREFT@(DDS2P,DDS2B)) ^DDS1(DDS2P)
 . S DDS2DA=@DDSREFT@(DDS2P,DDS2B)
 . I DDS2DA="" D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR),";;",2))
 .. S DDO=DDS2O
 . E  D CKUNED D:'$G(DDS2UNED)
 .. D POSTACT
 .. S:$D(DDSBR)[0 DDACT="NP",DDSPG=DDS2P,DDSBK=DDS2B,DDSBR=""
 ;
 E  I DDS2B'=DDSBK D
 . S DDS2DA=@DDSREFT@(DDS2P,DDS2B)
 . I DDS2DA="" D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR),";;",2))
 .. S DDO=DDS2O
 . E  I $P($G(@DDSREFS@(DDS2P,DDS2B)),U,4) D
 .. D MSG^DDSMSG($C(7)_$P($T(ERR1),";;",2))
 .. S DDO=DDS2O
 . E  D CKUNED D:'$G(DDS2UNED)
 .. D POSTACT
 .. S:$D(DDSBR)[0 DDACT="NB",DDSBK=DDS2B,DDSBR=""
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
 ;
 S DDS2ATT=$P($G(@DDSREFT@("F"_DDP,DDS2DA,DDSFLD,"A")),U,4)
 ;
 I DDO,$S(DDS2ATT="":$P($G(^DIST(.404,DDS2B,40,+DDO,4)),U,4)=1,1:DDS2ATT=1),'$P(@DDSREFS@(DDS2P,DDS2B,+DDO,"N"),U,11) D
 . D MSG^DDSMSG($P(^DIST(.404,DDS2B,40,+DDO,0),U,2)_" is uneditable.",1)
 . S DDS2UNED=1,DDO=DDS2O
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
 N B,B1,F,F1,P,P1,E,X Q:$D(DDSBR)[0
 S P=$P($G(DDSOPB),U),B=$P($G(DDSOPB),U,2),F=$G(DDO),E=1
 S:'B B=+$P(@DDSREFS@(+P,"FIRST"),",",2)
 S P1=$P(DDSBR,U,3),B1=$P(DDSBR,U,2),F1=$P(DDSBR,U)
 ;
 D @$S(P1]"":"PG",B1]"":"BK",1:"FD")
 S:'E DDACT=$S(P'=+DDSOPB:"NP",B'=$P(DDSOPB,U,2):"NB",1:"N"),DDSPG=P,DDSBK=B,DDO=F
 K:E DDSBR
 Q
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
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
ERR ;;Unable to jump to that field.  The block on which that field is located has no record associated with it.
 ;
ERR1 ;;Unable to jump to that field.  The block on which that field is located has navigation disabled.
