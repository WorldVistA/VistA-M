DDGFSV ;SFISC/MKO- SAVE DATA ;12:41 PM  29 Mar 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SAVE ;Save in form/block files data in DDGFREF
 N P,B,F,P1,B1,F1,N
 ;
 I '$G(DDGFCHG) D MSG^DDGF("Nothing to save.") H 1 D MSG^DDGF() Q
 D MSG^DDGF("Saving data ...")
 ;
 ;Loop through all pages in DDGFREF
 S P="" F  S P=$O(@DDGFREF@("F",P)) Q:P=""  D PG
 ;
 D MSG^DDGF("Data saved.") H 1 D MSG^DDGF()
 S DDGFCHG=0
 Q
 ;
PG ;Save page data
 S P1=@DDGFREF@("F",P)
 I $P(P1,U,7),$D(^DIST(.403,+DDGFFM,40,P,0))#2 D
 . S N=^DIST(.403,+DDGFFM,40,P,0)
 . S $P(N,U,3)=$P(P1,U)+1_","_($P(P1,U,2)+1)
 . S $P(N,U,6,7)=$S($P(P1,U,3)="":U,1:1_U_($P(P1,U,3)+1)_","_($P(P1,U,4)+1))
 . S ^DIST(.403,+DDGFFM,40,P,0)=$$STPU(N)
 . ;
 . S N=$G(^DIST(.403,+DDGFFM,40,P,1))
 . I $P(N,U)'=$P(P1,U,5) D
 .. S DIE="^DIST(.403,"_+DDGFFM_",40,"
 .. S DR="7////"_$P(P1,U,5),DA(1)=+DDGFFM,DA=P
 .. N P D ^DIE K DIE,DR,DA
 ;
 ;Loop through all blocks
 S B="" F  S B=$O(@DDGFREF@("F",P,B)) Q:B=""  D BK
 Q
 ;
BK ;Save block data
 S B1=@DDGFREF@("F",P,B)
 I $P(B1,U,5),$D(^DIST(.403,+DDGFFM,40,P,40,B,0))#2 D
 . S $P(^DIST(.403,+DDGFFM,40,P,40,B,0),U,3)=$P(B1,U)-$P(P1,U)+1_","_($P(B1,U,2)-$P(P1,U,2)+1)
 . I $P(^DIST(.404,B,0),U)'=$P(B1,U,4) D
 .. S DIE="^DIST(.404,",DR=".01////"_$P(B1,U,4),DA=B
 .. N B,P D ^DIE K DIE,DR,DA
 ;
 ;Loop through all fields
 S F="" F  S F=$O(@DDGFREF@("F",P,B,F)) Q:F=""  D FD
 Q
 ;
FD ;Save field data
 S F1=@DDGFREF@("F",P,B,F)
 I $P(F1,U,9),$D(^DIST(.404,B,40,F,0))#2 D
 . S N=""
 . S $P(N,U,1,2)=$S($P(F1,U,8):$S($P(F1,U,5)]""&($P(F1,U,6)]""):$P(F1,U,5)-$P(B1,U)+1_","_($P(F1,U,6)-$P(B1,U,2)+1),1:"")_U_$P(F1,U,8),1:U)
 . S $P(N,U,3,4)=$S($L($P(F1,U,4)):$S($P(F1,U)]""&($P(F1,U,2)]""):$P(F1,U)-$P(B1,U)+1_","_($P(F1,U,2)-$P(B1,U,2)+1),1:"")_U_$S($P(F1,U,4)?.E1":":"",1:1),1:U)
 . S:$P(^DIST(.404,B,40,F,0),U,3)=1 $P(N,U,4)=""
 . S ^DIST(.404,B,40,F,2)=$$STPU(N)
 . ;
 . ;Use DIE to stuff in new caption
 . I $P(^DIST(.404,B,40,F,0),U,2)'=$P(F1,U,4) D
 .. S DIE="^DIST(.404,"_B_",40,"
 .. S DR="1////"_$S($P(F1,U,4)?.1":":"@",$P(F1,U,4)?1.E1":":$E($P(F1,U,4),1,$L($P(F1,U,4))-1),1:$P(F1,U,4))
 .. S DA(1)=B,DA=F
 .. N P,B,F D ^DIE K DIE,DR,DA
 Q
 ;
STPU(X) ;Strip trailing up-arrows from X
 N I
 F I=$L(X):-1:0 Q:$E(X,I)'="^"
 Q $E(X,1,I)
