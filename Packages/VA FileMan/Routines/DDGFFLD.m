DDGFFLD ;SFISC/MKO-EDIT A FIELD ;01:47 PM  22 Nov 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EDIT ;
 Q:$D(^DIST(.404,B,40,F,0))[0
 I T="D" Q:C]""  K @DDGFREF@("F",DDGFPG,B,F)
 ;
 S DDGFDY=DY,DDGFDX=DX
 S DDGFTYPE=$P(^DIST(.404,B,40,F,0),U,3)
 I 'DDGFTYPE D
 . I $G(^DIST(.404,B,40,F,20))'?."^" S DDGFTYPE=2 Q
 . I $P($G(^DIST(.404,B,0)),U,2),$G(^DIST(.404,B,40,F,1)) S DDGFTYPE=3
 G:'DDGFTYPE EDITQ
 ;
 S DDGFB2=@DDGFREF@("F",DDGFPG,B)
 S DDGFB1=$P(DDGFB2,U),DDGFB2=$P(DDGFB2,U,2)
 S DDGFDD=$P(^DIST(.404,B,0),U,2)
 S (DDGFSUP,DDGFSUP0)=$S(C]""&(DDGFTYPE'=1):$E(C,$L(C))'=":",1:"")
 S (DDGFCAP,DDGFCAP0)=$S(DDGFTYPE=1!DDGFSUP0:C,1:$E(C,1,$L(C)-1))
 S (DDGFCC,DDGFCC0)=$S(C]"":C1-DDGFB1+1_","_(C2-DDGFB2+1),1:"")
 I $D(D) D
 . S (DDGFDL,DDGFDL0)=L
 . S (DDGFDC,DDGFDC0)=D1-DDGFB1+1_","_(D2-DDGFB2+1)
 K DDGFB1,DDGFB2
 ;
 S DDSFILE=.404,DDSFILE(1)=.4044,DDSPARM="KSTW"
 S DR="[DDGF FIELD "_$P("CAPTION ONLY^FORM ONLY^DD^COMPUTED",U,DDGFTYPE)_"]"
 S DA=F,DA(1)=B
 D
 . N B,F,T,C,C1,C2,D,D1,D2,L,P1,P2
 . D ^DDS K DDSFILE,DDSPARM,DR,DDGFDD
 ;
 ;If caption, caption coords, data length, data coords, or suppress
 ;colon flag changed we need to update some local variables
 I $D(DA)#2,$G(DDSSAVE) D
 . S DDGFNDB=$G(@DDGFREF@("F",DDGFPG,B))
 . S:DDGFCAP="" (DDGFSUP,DDGFCC)=""
 . S DR=""
 . ;
 . I DDGFCAP'=DDGFCAP0!(DDGFSUP'=DDGFSUP0) D
 .. S C=DDGFCAP_$S(DDGFCAP]""&(DDGFTYPE'=1)&'DDGFSUP:":",1:"")
 .. S:DDGFCAP'=DDGFCAP0 DR=DR_"1////"_$S(DDGFCAP]"":DDGFCAP,1:"@")_";"
 .. S:DDGFSUP'=DDGFSUP0 DR=DR_"5.2////"_$S(DDGFSUP:1,1:"@")_";"
 . ;
 . D:DDGFCC'=DDGFCC0
 .. S C1=$S(DDGFCAP]"":$P(DDGFCC,",")-1+$P(DDGFNDB,U),1:"")
 .. S C2=$S(DDGFCAP]"":$P(DDGFCC,",",2)-1+$P(DDGFNDB,U,2),1:"")
 .. S DR=DR_"5.1////"_$S(DDGFCC]"":DDGFCC,1:"@")_";"
 . ;
 . D:$D(D)
 .. D:DDGFDC'=DDGFDC0
 ... S D1=$P(DDGFDC,",")-1+$P(DDGFNDB,U)
 ... S D2=$P(DDGFDC,",",2)-1+$P(DDGFNDB,U,2)
 ... S DR=DR_"4.1////"_DDGFDC_";"
 .. D:DDGFDL'=DDGFDL0
 ... S L=DDGFDL
 ... S D=$TR($J("",L)," ","_")
 ... S DR=DR_"4.2////"_DDGFDL_";"
 . ;
 . I T="D",C]"" D
 .. D WRITE^DDGLIBW(DDGFWID,C,C1-P1,C2-P2,"",1)
 .. S @DDGFREF@("RC",DDGFWID,C1,C2,C2+$L(C)-1,B,F,"C")=""
 . ;
 . I DR]"" D
 .. N B,F,T,C,C1,C2,D,D1,D2,L,P1,P2
 .. S DIE="^DIST(.404,"_DA(1)_",40,"
 .. S DR=$E(DR,1,$L(DR)-1)
 .. D ^DIE
 ;
 K DA,DDGFNDB
 K DDGFSUP,DDGFSUP0,DDGFCAP,DDGFCAP0,DDGFCC,DDGFCC0
 K DDGFDL,DDGFDL0,DDGFDC,DDGFDC0,DDSSAVE
 K DIE,DR
 ;
 D REFRESH^DDGF,RC(DDGFDY,DDGFDX)
EDITQ S DDGFE=1
 K DDGFDY,DDGFDX,DDGFTYPE
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
