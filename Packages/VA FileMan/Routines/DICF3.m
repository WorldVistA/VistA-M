DICF3 ;VEN/TOAD,SF/TKW - Lookup: Finder, Part 3 (One Index) ; 1/24/13 3:53pm
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4**
 ;
 ;
 ; Contents
 ;
 ; CHKONE: Check One Index for All Possible Matches
 ;
 ;
CHKONE(DIFLAGS,DIVALUE,DINDEX,DIDENT,DIFILE,DIEN,DIFIEN,DISCREEN,DILIST,DIC,DIY,DIYX) ;
 ; Called from CHKALL--check one index for possible matches
 ;
 N I,DISUB F DISUB=1:1:DINDEX("#") D
 . F I=0:0 S I=$O(DINDEX(DISUB,I)) Q:'I  K DINDEX(DISUB,I)
 ;
C1 ; Set up then find eXact matches.
 ;
 I DIFLAGS["X" D  Q
 . ;
 . F DISUB=1:1:DINDEX("#") D  ; loop through lookup values
 . . S (DINDEX(DISUB),DINDEX(DISUB,1))=$G(DINDEX(DISUB,"FROM"))
 . . S DINDEX(DISUB,"USE")=$S(DIFLAGS["Q":1,"VP"[DINDEX(DISUB,"TYPE"):0,1:1)
 . . ;
 . . I DISUB>1!("VP"'[DINDEX(1,"TYPE")) M DINDEX(DISUB)=DIVALUE(DISUB)
 . . ;
 . . Q:DIFLAGS["Q"
 . . ;
 . . I "VP"[DINDEX(DISUB,"TYPE") D  Q:DISUB=1
 . . . S DINDEX(DISUB)=""
 . . . Q:DISUB'=1
 . . . S DINDEX(1,1)="" F I=1:0 S I=$O(DINDEX(1,I)) Q:'I  K DINDEX(1,I)
 . . S I=4 F  S I=$O(DIVALUE(DISUB,I)) Q:'I  S DINDEX(DISUB,I)=DIVALUE(DISUB,I)
 . ;
 . S DIDENT(-4)=1
 . N DIF S DIF=$TR(DIFLAGS,"X")_"X"
 . S DINDEX("TOTAL")=DIDENT(-1)
 . ;
 . D WALK^DICFIX(DIF,.DINDEX,.DIDENT,.DIFILE,.DIEN,.DIFIEN,.DISCREEN,.DILIST,.DIC,.DIY,.DIYX)
 ;
 Q:$G(DIERR)!($G(DINDEX("DONE")))
 ;
C2 ; Find partial matches
 ;
 F DISUB=1:1:DINDEX("#") D  ; loop through lookup values
 . S (DINDEX(DISUB),DINDEX(DISUB,1))=$G(DINDEX(DISUB,"FROM"))
 . S DINDEX(DISUB,"USE")=$S(DIFLAGS["Q"!(DINDEX("#")>1):1,DIFLAGS["O":0,1:1)
 . ;
 . I DISUB>1!("VP"'[DINDEX(1,"TYPE")) D
 . . I DINDEX(DISUB,"WAY")=1 D  ; forward traversal, traverse from
 . . . M DINDEX(DISUB)=DIVALUE(DISUB) ; start of partial matches
 . . I DINDEX(DISUB,"WAY")=-1 D  ; backward traversal, traverse from
 . . . M DINDEX(DISUB)=DIVALUE("BACK",DISUB) ; end of partial matches
 . ;
 . I "VP"[DINDEX(DISUB,"TYPE"),DIFLAGS'["Q" D  Q:DISUB=1
 . . S DINDEX(DISUB)="",DINDEX(DISUB,"USE")=0
 . . Q:DISUB'=1
 . . S DINDEX(1,1)="" F I=1:0 S I=$O(DINDEX(1,I)) Q:'I  K DINDEX(1,I)
 . I DIFLAGS["O" F I=0:0 S I=$O(DISCREEN(DISUB,I)) Q:'I  D
 . . I $D(DISCREEN(DISUB,I,2)) S DISCREEN(DISUB,I)=DISCREEN(DISUB,I,2)
 ;
 S DIDENT(-4)=1
 S DINDEX("TOTAL")=DIDENT(-1)
 ;
 D WALK^DICFIX(.DIFLAGS,.DINDEX,.DIDENT,.DIFILE,.DIEN,DIFIEN,.DISCREEN,.DILIST,.DIC,.DIY,.DIYX)
 ;
 QUIT  ; end of CHKONE
 ;
 ;
EOR ; end of routine DICF3
