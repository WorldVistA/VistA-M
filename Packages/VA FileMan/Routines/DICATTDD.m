DICATTDD ;GFT/GFT - Multiple Fields;12:02 PM  8 Apr 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,76**
 ;
 ;
MULMAKE(DICATTD,TYPE) ;DICATTD=sub-dictionary number, TYPE 1-9
 ;only called from DICATTDE
 N F,DA,DIK,I,J,DIC
 S F=$$G(1),^DD(DICATTD,0)=F_" SUB-FIELD^^.01^1"
 S ^(0,"UP")=DICATTA,^("NM",F)=""
 S ^DD(DICATTD,.01,0)=F_"^^^0;1"
 I TYPE-5 D  ;build a "B" x-ref unless this is a W-P multiple
 .S ^DD(DICATTD,.01,1,0)="^.1",^(1,0)=DICATTD_"^B"
 .S:+DICATT4S'=DICATT4S DICATT4S=""""_DICATT4S_""""
 .S DIK=DICATT4S_",""B"",$E(X,1,30),DA)"
 .D IJ^DIUTL(DICATTA) S I=$O(I(""),-1)
 .F DA=I:-1:0 S DIK=I(DA)_$E(",",''DA)_"DA("_(I+1-DA)_"),"_DIK
 .S ^DD(DICATTD,.01,1,1,1)="S "_DIK_"=""""",^(2)="K "_DIK
 .I TYPE=8 S ^(3)="Required for Variable Pointer"
 S DA=.01,DA(1)=DICATTD,(DIC,DIK)="^DD("_DICATTD_","
 D IX1^DIK
 S $P(^DD(DICATTA,DICATTF,0),U,2)=DICATTD ;K DICATT2N
 S ^DD(DICATTA,"SB",DICATTD,DICATTF)=""
 Q
 ;
MULEDIT S G=$$G(1) I G="" G ^DICATTDK:$D(DICATTDK) S DDSBR=1,DDSERROR=1 Q
 S $P(^DD(+DICATT2,0),U)=G_" SUB-FIELD" K ^(0,"NM") S ^("NM",G)=""
 S DR=".01////"_G F X=5,7,8 D 0
DIE S DICATTED=1,DA=DICATTF,DA(1)=DICATTA,(DIC,DIE)="^DD(DICATTA,"
 D ^DIE
 D FILEWORD^DICATTD0 Q
 ;
0 S T=$T(@X),G=$TR($$G(X),";") Q:G="@"  S:G="" G="@" S DR=DR_$P(T,";",2,3)_"////"_G Q
5 ;;8
7 ;;9
8 ;;10
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT MUL",10,"I","")
