DDGFBK ;SFISC/MKO-ADD, EDIT, DELETE BLOCK ;2:11 PM  13 Sep 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ADD ;Add a new block
 N B,C1,C2,C3
 S DDGFDY=DY,DDGFDX=DX
 ;
 ;Invoke form to enter block name
 K DDGFBNUM,DDGFBNAM
 D DDS(.404,"[DDGF BLOCK ADD]")
 G:'$D(DDGFBNUM) ADDQ
 ;
 ;Ask whether block should be added or indicate duplicate block
 K DDGFANS
 S DDSPAGE=$S($P(^DIST(.403,+DDGFFM,40,DDGFPG,0),U,2)=DDGFBNUM!$D(^(40,"B",DDGFBNUM)):21,1:11)
 D DDS(.404,"[DDGF BLOCK ADD]","",DDSPAGE)
 G:DDSPAGE=21 ADDQ
 I '$G(DDGFANS) D  G ADDQ
 . I $D(^DIST(.404,DDGFBNUM,0))#2,'$P(^(0),U,2) D
 .. N DIK,DA
 .. S DIK="^DIST(.404,",DA=DDGFBNUM
 .. D ^DIK
 K DDSPAGE,DDGFANS
 ;
 ;Add block to page
 S DIC="^DIST(.403,+DDGFFM,40,DDGFPG,40,",DIC(0)="L"
 S DA(2)=+DDGFFM,DA(1)=DDGFPG
 S DIC("P")=$P(^DD(.4031,40,0),U,2)
 S (DINUM,X)=DDGFBNUM
 K DO,DD D FILE^DICN K DINUM,X
 G:Y=-1 ADDQ
 ;
 ;Stuff in values for block order, coordinates, and type
 S DIE=DIC,DA=+Y
 S DDGFC=DDGFDY-$P(DDGFLIM,U)+1_","_(DDGFDX-$P(DDGFLIM,U,2)+1)
 S DR="1////"_($O(^DIST(.403,+DDGFFM,40,DDGFPG,40,"AC",""),-1)+1\1)_";2////"_DDGFC_";3////e"
 D ^DIE K DA,DIC,DIE,DR,X,Y,DDGFC
 ;
 ;If this looks like a brand new block, stuff in DD number
 I $L(^DIST(.404,DDGFBNUM,0),U)=1,'$O(^(0)) D
 . S DIE="^DIST(.404,",DA=DDGFBNUM
 . S DR="1////"_$P(^DIST(.403,+DDGFFM,0),U,8)
 . D ^DIE K DA,DIE,DR
 ;
 D BK^DDGFLOAD(DDGFPG,DDGFBNUM,$P(DDGFLIM,U),$P(DDGFLIM,U,2),DDGFDY,DDGFDX,0,1)
 ;
 S DY=DDGFDY,DX=DDGFDX
 S B=DDGFBNUM,C=$P(@DDGFREF@("F",DDGFPG,B),U,4)
 S C1=DY,C2=DX,C3=C2+$L(DDGFBNAM)-1
 S DDGFADD=1
 K DDGFBNUM,DDGFBNAM
 S:$G(DDGFBV) DDGFORIG(B)=DY_U_DX
 G EDIT
 ;
ADDQ ;Adding aborted
 D REFRESH^DDGF,RC(DDGFDY,DDGFDX)
 K DDGFANS,DDGFBNAM,DDGFBNUM,DDGFDX,DDGFDY,DDSPAGE,DA,DIC,Y
 Q
 ;
EDIT ;Edit block
 ;In: B,C1,C2,C3,C
 S DDGFDY=DY,DDGFDX=DX
 S DDGFBK=B,DDGFC1=C1,DDGFC2=C2,DDGFC3=C3
 S DDGFBKCO=C1-$P(DDGFLIM,U)+1_","_(C2-$P(DDGFLIM,U,2)+1)
 S DDGFBKNO=C
 ;
 ;Invoke form to edit block
 S DDSFILE=.403,DDSFILE(1)=.4032
 S DA(2)=+DDGFFM,DA(1)=DDGFPG,DA=B
 S DR="[DDGF BLOCK EDIT]",DDSPARM="KTW"
 D ^DDS K DDSFILE,DA,DR,DDSPARM
 ;
 ;If block was deleted, remove data from DDGFREF
 I $D(^DIST(.403,+DDGFFM,40,DDGFPG,40,DDGFBK,0))[0 D DELETE(DDGFBK) G EDITQ
 ;
 S:$D(DDGFBKCN)[0 DDGFBKCN=DDGFBKCO
 S:$D(DDGFBKNN)[0 DDGFBKNN=DDGFBKNO
 ;
 S C=DDGFBKNN
 S C1=$P(DDGFBKCN,",")-1+$P(DDGFLIM,U)
 S C2=$P(DDGFBKCN,",",2)-1+$P(DDGFLIM,U,2)
 S C3=C2+$L(C)-1
 ;
 ;Update TMP if coordinates or name changed, or new block
 I DDGFBKCN'=DDGFBKCO!(DDGFBKNN'=DDGFBKNO)!$G(DDGFADD) D
 . D WRITE^DDGLIBW(DDGFWIDB,$J("",$L(DDGFBKNO)),DDGFC1-$P(DDGFLIM,U),DDGFC2-$P(DDGFLIM,U,2),"",1)
 . D WRITE^DDGLIBW(DDGFWIDB,C,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"",1)
 ;
EDITQ D REFRESH^DDGF,RC(DDGFDY,DDGFDX)
 S:'$G(DDGFADD) DDGFE=1
 K DDGFADD,DDGFBK,DDGFBKCO,DDGFBKNO,DDGFBKCN,DDGFBKNN
 K DDGFC1,DDGFC2,DDGFC3,DDGFDX,DDGFDY
 Q
 ;
DELETE(B,E) ;Remove block from DDGFREF
 ;E : means don't set DDGFEBV or DDGFBDEL
 ;    (used by EDIT^DDGFHBK when a different header block is chosen)
 N F,N
 ;Remove from TMP
 S F="" F  S F=$O(@DDGFREF@("F",DDGFPG,B,F)) Q:F=""  D
 . S N=@DDGFREF@("F",DDGFPG,B,F)
 . K:$P(N,U,4)]"" @DDGFREF@("RC",DDGFWID,$P(N,U),$P(N,U,2),$P(N,U,3),B)
 . K:$P(N,U,8)>0 @DDGFREF@("RC",DDGFWID,$P(N,U,5),$P(N,U,6),$P(N,U,7),B)
 K @DDGFREF@("F",DDGFPG,B)
 ;
 ;If no blocks on page, set DDGFEBV to exit Block Viewer
 ;DDGFBDEL indicates block name should not be painted
 I $G(DDGFBV) D:'$G(E)
 . I '$P(^DIST(.403,+DDGFFM,40,DDGFPG,0),U,2),'$O(^(40,0)) S DDGFEBV=1
 . S DDGFBDEL=1
 E  D PG^DDGFLOAD(+DDGFFM,+DDGFPG,1,1)
 ;
 ;If used on no other forms, ask whether to delete from block file
 I '$O(^DIST(.403,"AB",B,"")),'$O(^DIST(.403,"AC",B,"")) D
 . K DDGFANS S DDGFBK=B
 . D DDS(.404,"[DDGF BLOCK DELETE]")
 . I $G(DDGFANS) S DIK="^DIST(.404,",DA=DDGFBK D ^DIK K DIK,DA
 . K DDGFANS,DDGFBK
 Q
 ;
DDS(DDSFILE,DR,DA,DDSPAGE) ;
 ;Call DDS
 S DDSPARM="KTW" D ^DDS K DDSPARM
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
