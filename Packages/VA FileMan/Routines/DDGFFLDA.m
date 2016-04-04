DDGFFLDA ;SFISC/MKO-ADD A FIELD ;2:22 PM  13 Sep 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ADD ;Add a field
 I '$O(^DIST(.403,+DDGFFM,40,DDGFPG,40,0)) D  Q
 . D MSG^DDGF($C(7)_"There are no blocks defined on this page.  To add a block, press <PF2>B.")
 . H 2 D MSG^DDGF()
 S DDGFDY=DY,DDGFDX=DX
 ;
 ;Invoke form to select block, field order, field type
 K DDGFBLCK,DDGFFORD,DDGFTYPE
 S DDSFILE=.404,DDSFILE(1)=.4044
 S DR="[DDGF FIELD ADD]",DDSPARM="KTW"
 D ^DDS K DDSFILE,DA,DR,DDSPARM
 ;
 I '$D(DDGFBLCK)!'$D(DDGFFORD)!'$D(DDGFTYPE) G ADDQ
 ;
 ;Get relative field coordinates
 S (DDGFCAP,DDGFCAP0)=""
 S (DDGFSUP,DDGFSUP0)=""
 S (DDGFCC,DDGFCC0)=""
 ;
 S DDGFB2=@DDGFREF@("F",DDGFPG,DDGFBLCK)
 S DDGFB1=$P(DDGFB2,U),DDGFB2=$P(DDGFB2,U,2)
 ;
 I DDGFTYPE=1 D
 . S DDGFCC0=DDGFDY-DDGFB1+1_","_(DDGFDX-DDGFB2+1)
 E  D
 . S DDGFD1=DDGFDY-DDGFB1+1,DDGFD2=DDGFDX-DDGFB2+1
 . S (DDGFDC,DDGFDC0)=DDGFD1_","_DDGFD2
 . S (DDGFDL,DDGFDL0)=1
 ;
 I DDGFTYPE'=1,DDGFD1<1!(DDGFD2<1) D  G ADDQ
 . D MSG^DDGF($C(7)_"Unable to add a field above or to the left of the block.")
 . H 2 D MSG^DDGF()
 ;
 K DDGFD1,DDGFD2
 ;
 ;Add field order to block file
 S DIC="^DIST(.404,"_DDGFBLCK_",40,",DIC(0)="L"
 S DIC("P")=$P(^DD(.404,40,0),U,2)
 S DA(1)=DDGFBLCK,X=DDGFFORD
 K DD,DO D FILE^DICN
 I Y=-1 K DIC,DA,Y D MSG^DDGF($C(7)_"Unable to add field.") H 2 D MSG^DDGF() G ADDQ
 ;
 ;Stuff values for field type, data coordinate, and data length
 ;If form-only field, also stuff in default read type
 S DIE=DIC,DA(1)=DDGFBLCK,DA=+Y
 S DR="2////"_DDGFTYPE
 S:DDGFTYPE'=1 DR=DR_";4.1////"_DDGFDC_";4.2////1"
 S:DDGFTYPE=2 DR=DR_";20.1////F"
 D ^DIE K DIC,DIE,DR,Y
 ;
 ;Invoke appropriate form
 S DDSFILE=.404,DDSFILE(1)=.4044,DDSPARM="CKTW"
 S DDGFDD=$P(^DIST(.404,DDGFBLCK,0),U,2)
 S DR="[DDGF FIELD "_$P("CAPTION ONLY^FORM ONLY^DD^COMPUTED",U,DDGFTYPE)_"]"
 D ^DDS K DDSFILE,DR,DDSPARM,DDGFDD
 ;
 I $D(DA)#2,DDGFTYPE'=1,$G(DDSCHANG)'=1 D
 . S DIK="^DIST(.404,"_DA(1)_",40,"
 . D ^DIK K DIK
 E  I $D(DA)#2 D
 . D SAVE
 . D LOADF
 ;
ADDQ ;Refresh and cleanup
 D REFRESH^DDGF
 D RC(DDGFDY,DDGFDX)
 ;
 K DA,DDSCHANG
 K DDGFB1,DDGFB2,DDGFD1,DDGFD2
 K DDGFSUP,DDGFSUP0,DDGFCAP,DDGFCAP0,DDGFCC,DDGFCC0
 K DDGFDL,DDGFDL0,DDGFDC,DDGFDC0
 K DDGFDY,DDGFDX,DDGFBLCK,DDGFFORD,DDGFTYPE
 Q
 ;
SAVE ;Save changes to caption, coordinates, data length, and suppress
 ;colon flag
 S:DDGFCAP="" (DDGFSUP,DDGFCC)=""
 S DR=""
 ;
 S:DDGFCAP]"" DR=DR_"1////"_DDGFCAP_";"
 S:DDGFCC]"" DR=DR_"5.1////"_DDGFCC_";"
 S:DDGFSUP DR=DR_"5.2////1;"
 ;
 I DDGFTYPE'=1 D
 . S:DDGFDC'=DDGFDC0 DR=DR_"4.1////"_DDGFDC_";"
 . S:DDGFDL'=DDGFDL0 DR=DR_"4.2////"_DDGFDL_";"
 I DR="" K DR Q
 ;
 S DIE="^DIST(.404,"_DA(1)_",40,"
 S DR=$E(DR,1,$L(DR)-1)
 D ^DIE K DIE,DR,Y
 Q
 ;
LOADF ;Set DDGFREF and window buffer
 N C,C1,C2,C3,D,D1,D2,D3,L
 ;
 I DDGFCAP="" D
 . S (C,C1,C2,C3)=""
 . K @DDGFREF@("F",DDGFPG,DDGFBLCK,DA)
 E  D
 . S C=DDGFCAP_$S(DDGFTYPE'=1&'DDGFSUP:":",1:"")
 . S C1=$P(DDGFCC,",")-1+DDGFB1
 . S C2=$P(DDGFCC,",",2)-1+DDGFB2
 . S C3=C2+$L(C)-1
 . ;
 . S @DDGFREF@("F",DDGFPG,DDGFBLCK,DA)=C1_U_C2_U_C3_U_C
 . S @DDGFREF@("RC",DDGFWID,C1,C2,C3,DDGFBLCK,DA,"C")=""
 . D WRITE^DDGLIBW(DDGFWID,C,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"",1)
 ;
 I DDGFTYPE'=1 D
 . S D1=$P(DDGFDC,",")-1+DDGFB1
 . S D2=$P(DDGFDC,",",2)-1+DDGFB2
 . S D3=D2+DDGFDL-1
 . ;
 . S $P(@DDGFREF@("F",DDGFPG,DDGFBLCK,DA),U,5,8)=D1_U_D2_U_D3_U_DDGFDL
 . I D1]"",D2]"" S @DDGFREF@("RC",DDGFWID,D1,D2,D3,DDGFBLCK,DA,"D")=""
 . D:DDGFDL WRITE^DDGLIBW(DDGFWID,$TR($J("",DDGFDL)," ","_"),D1-$P(DDGFLIM,U),D2-$P(DDGFLIM,U,2),"",1)
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
