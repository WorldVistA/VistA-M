DICF ;VEN/TOAD,SF/TKW - Lookup: Finder, Part 1 (Main) ; 1/24/13 3:51pm
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20,34,165,1042**
 ;
 ;
 ; Contents
 ;
 ; $$FIND/FINDX/INPUT/HOOK75/LOOKUP: Finder Implementation
 ; $$BADVAL: Validate a Lookup Value
 ; CLOSE: Cleanup before Exiting Finder
 ;
 ;
FIND(DIFILE,DIFIEN,DIFIELDS,DIFLAGS,DIVALUE,DINUMBER,DIFORCE,DISCREEN,DIWRITE,DILIST,DIMSGA,DINDEX,DIC,DIY,DIYX) ;
 ; Finder Implementation [internal use only]
 ;
FINDX ; 1. Finder Pre-initialization [from FIND or FIND^DIC]
 ;
 I '$D(DIQUIET),$G(DIC(0))'["E" N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 N DICLERR S DICLERR=$G(DIERR) K DIERR
 N DIDENT S DIDENT(-1)=+$G(DILIST("C"))
 ;
INPUT ; 2. Validate Input Parameters
 ;
 N DIEN M DIEN=DIVALUE N DIVALUE M DIVALUE=DIEN K DIEN
 S DIFLAGS=$G(DIFLAGS) ; Validate Flags (DIFLAGS), part 1 of 3
 I DIFLAGS'["l" N DINDEX S DINDEX("WAY")=1
 ;
 N DIFAIL S DIFAIL=0
 D  I DIFAIL D CLOSE Q
 . ;
I1 . ; 2.1. Validate Flags (DIFLAGS), part 2 of 3
 . ;
 . I DIFLAGS["p" S DIFLAGS=DIFLAGS_"f"
 . I DIFLAGS'["p" D  Q:DIFAIL
 . . I $G(DIFIELDS)["IX",DIFIELDS'["-IX" D
 . . . N D S D=";"_DIFIELDS_";" I D'[";IX;",D'[";IXE",D'[";IXIE" Q
 . . . S DIDENT(-5)=1
 . . S DIFLAGS=DIFLAGS_4
 . . I DIFLAGS["O",DIFLAGS["X" S DIFLAGS=$TR(DIFLAGS,"O")
 . . S DIFLAGS=DIFLAGS_"t"
 . . ;
I2 . . ; 2.2. Validate Value (DIVALUE)
 . . ;
 . . I DIFLAGS'["l" N DIERRM D  I DIFAIL D ERR^DICF4(202,"","","",DIERRM) Q
 . . . S DIERRM="Lookup values"
 . . . I $G(DIVALUE(1))="" S DIVALUE(1)=$G(DIVALUE)
 . . . N I,DIEND S DIFAIL=1,DIEND=$O(DIVALUE(999999),-1)
 . . . F I=1:1:DIEND S DIVALUE(I)=$G(DIVALUE(I)) I DIVALUE(I)]"" S DIFAIL=$$BADVAL(DIVALUE(I)) Q:DIFAIL
 . ;
I3 . ; 2.3. Validate Target_Root (DILIST) & Init Target Array
 . ;
 . S DILIST=$G(DILIST)
 . I DILIST'="",DIFLAGS'["l" D
 . . I DIFLAGS'["p" K @DILIST
 . . I DIFLAGS'["f" S DILIST=$NA(@DILIST@("DILIST"))
 . I DILIST="" S DILIST="^TMP(""DILIST"",$J)" K @DILIST
 . ;
I4 . ; 2.4. Validate File (DIFILE), IENS (DIFIEN), & Screen (DISCREEN)
 . ;
 . D:DIFLAGS'["v"&(DIFLAGS'["l") FILE^DICUF(.DIFILE,.DIFIEN,DIFLAGS)
 . I $G(DIERR) S DIFAIL=1 Q
 . D SCREEN^DICUF(DIFLAGS,.DIFILE,.DISCREEN)
 . D DA^DILF(DIFIEN,.DIEN)
 . ;
I5 . ; 2.5. Validate Fields (DIFIELDS)
 . ;
 . S DIFIELDS=$G(DIFIELDS)
 . ;
I6 . ; 2.6. Validate Flags (DIFLAGS), part 3 of 3
 . ;
 . I DIFLAGS'["p",DIFLAGS'["l" D  Q:DIFAIL
 . . I $TR(DIFLAGS,"ABCKMOPQSUXfglpqtv4E")'="" S DIFAIL=1 D  Q  ;GFT
 . . . D ERR^DICF4(301,"","","",$TR(DIFLAGS,"fglpqtv4"))
 . ;
I7 . ; 2.7. Validate Indexes (DIFORCE), Set Starting Index (DINDEX)
 . ;
 . I DIFLAGS'["l" D  Q:DIFAIL
 . . S DIFORCE=$G(DIFORCE),DIFORCE(1)=1
 . . I "*"[DIFORCE D
 . . . I DIFLAGS["M" S DIFORCE=0,DIFORCE(0)="*" Q
 . . . S DIFORCE(0)=$$DINDEX^DICL(DIFILE,DIFLAGS),DIFORCE=1 Q
 . . E  D  I DIFAIL D ERR^DICF4(202,"","","","Indexes") Q
 . . . I $P(DIFORCE,U)="" S DIFAIL=1 Q
 . . . S DIFORCE(0)=DIFORCE,DIFORCE=1
 . . . I $P(DIFORCE(0),U,2)]"",DIFLAGS'["M" S DIFLAGS=DIFLAGS_"M"
 . . I DIFORCE S DINDEX=$P(DIFORCE(0),U) Q
 . . S DINDEX=$$DINDEX^DICL(DIFILE,DIFLAGS) Q
 . ;
I8 . ; 2.8. Validate Number (DINUMBER) & Identifier (DIWRITE)
 . ;
 . I DIFLAGS'["p",DIFLAGS'["l" D  Q:DIFAIL
 . . S DINUMBER=$S($G(DINUMBER):DINUMBER,1:"*")
 . . I DINUMBER'="*" D  Q:DIFAIL
 . . . I DINUMBER\1=DINUMBER,DINUMBER>0 Q
 . . . S DIFAIL=1 D ERR^DICF4(202,"","","","Number")
 . S DIWRITE=$G(DIWRITE)
 ;
I9 ; 2.9. Init Map (DIDENT(-3)), Window (DIDENT(-1)), & Done (DIOUT)
 ;
 I DIFLAGS["P" S DIDENT(-3)=""
 S DIDENT(-1,"MAX")=DINUMBER
 S DIDENT(-1,"MORE?")=0
 S DIDENT(-1,"JUST LOOKING")=0
 N DIOUT S DIOUT=0
 ;
HOOK75 ; 3. Process Pre-lookup Transform
 ;
 N DIHOOK75
 S DIHOOK75=$G(^DD(DIFILE,.01,7.5))
 I DIHOOK75'="",DIVALUE(1)]"",DIVALUE(1)'?."?",'$O(DIVALUE(1)),DIFLAGS'["l" D  I DIOUT D CLOSE Q
 .N DIC D  ;I DIFLAGS["p" N DIC D
 . . S DIC=DIFILE,DIC(0)=$TR(DIFLAGS,"2^fglpqtv4") Q
 . N %,D,X,Y,Y1
 . S X=DIVALUE(1),D=DINDEX
 . M Y=DIEN S Y="",Y1=DIFIEN
 . X DIHOOK75 I '$D(X)!$G(DIERR) S DIOUT=1 D:$G(DIERR)  Q
 . . S %=$$EZBLD^DIALOG(8090) ;Pre-lookup transform (7.5 node)
 . . D ERR^DICF4(120,DIFILE,"",.01,%)
 . S DIVALUE(1)=X,DIOUT=$$BADVAL(DIVALUE(1)) Q:DIOUT
 . I $G(DIC("S"))'="" S DISCREEN("S")=DIC("S") ;DIHOOK MAY HAVE SET THIS
 . I $G(DIC("V"))'="" S (DISCREEN("V"),DISCREEN("V",1))=DIC("V") ;...OR THIS
 ;
LOOKUP ; 4. Finder Main Lookup Code
 ;
 I DIFLAGS'["l" D  I DIOUT!($G(DIERR)) D CLOSE Q
 . D INDEX^DICUIX(.DIFILE,DIFLAGS,.DINDEX,"",.DIVALUE,DINUMBER,.DISCREEN,DILIST,.DIOUT) Q
 I '$D(DINDEX("MAXSUB")) D
 . S DINDEX("MAXSUB")=$P($G(^DD("OS",+$G(^DD("OS")),0)),U,7)
 . I DINDEX("MAXSUB") S DINDEX("MAXSUB")=DINDEX("MAXSUB")-13 Q
 . S DINDEX("MAXSUB")=50
 I $D(DISCREEN("V")) D VPDATA^DICUF(.DINDEX,.DISCREEN)
 I (DINDEX'="#")!($O(DIVALUE(1))) D CHKVAL1^DIC0(DINDEX("#"),.DIVALUE,DIFLAGS) I $G(DIERR) D CLOSE Q
 I DIFLAGS'["f" D  I $G(DIERR) D CLOSE Q
 . D IDENTS^DICU1(DIFLAGS,.DIFILE,DIFIELDS,DIWRITE,.DIDENT,.DINDEX)
 I DIFLAGS'["p",DIFLAGS'["l" D  I DIOUT!($G(DIERR)) D CLOSE Q
 . N I F I=2:1:DINDEX("#") Q:$G(DIVALUE(I))]""
 . Q:$G(DIVALUE(I))]""
 . D SPECIAL^DICF1(.DIFILE,.DIEN,DIFIEN,DIFLAGS,DIVALUE(1),.DINDEX,.DISCREEN,.DIDENT,.DIOUT,.DILIST)
 I DIFLAGS["t" D XFORM^DICF1(.DIFLAGS,.DIVALUE,.DISCREEN,.DINDEX)
 I DIFLAGS'["X" D  ; unless we are doing exact matches, also load FROM
 . D BACKFROM^DICF1(.DIVALUE,.DINDEX) ; values for backward traversal
 I DINDEX("#")>1,DIVALUE(1)="" N S M S=DISCREEN N DISCREEN M DISCREEN=S K S D
 . I DIFIELDS["IX",DIFIELDS'["-IX" Q
 . N DISAVMAX S DISAVMAX=DINDEX("MAXSUB")
 . D ALTIDX^DICF0(.DINDEX,.DIFILE,.DIVALUE,.DISCREEN,DINUMBER)
 . S DINDEX("MAXSUB")=DISAVMAX
 D CHKALL^DICF2(.DIFILE,.DIEN,DIFIEN,.DIFLAGS,.DIVALUE,.DISCREEN,DINUMBER,.DIFORCE,.DINDEX,.DIDENT,.DILIST,.DIC,.DIY,.DIYX)
 D CLOSE
 ;
 QUIT  ; end of $$FIND/FINDX/INPUT/HOOK75/LOOKUP
 ;
 ;
BADVAL(DIVALUE) ; Validate a Lookup Value
 ;
 I "^"[DIVALUE Q 1
 I DIVALUE'?.ANP D ERR^DICF4(204,"","","",DIVALUE) Q 1
 ;
 QUIT 0 ; end of $$BADVAL
 ;
 ;
CLOSE ; Cleanup before Exiting Finder
 ;
 I $G(DIMSGA)'="" D CALLOUT^DIEFU(DIMSGA)
 I DICLERR'=""!$G(DIERR) D
 . I DIFLAGS["l",+DIERR=1 Q
 . S DIERR=$G(DIERR)+DICLERR_U_($P($G(DIERR),U,2)+$P(DICLERR,U,2))
 I $G(DIERR) D  Q
 . Q:$G(DILIST)=""  K @DILIST@("B") Q
 I DIFLAGS["p" S @DILIST=DIDENT(-1) Q
 Q:DIFLAGS["l"
 S @DILIST@(0)=DIDENT(-1)_U_DIDENT(-1,"MAX")_U_DIDENT(-1,"MORE?")_U_$S(DIFLAGS[2:"H",1:"")
 I DIFLAGS["P" S @DILIST@(0,"MAP")=$G(DIDENT(-3))
 E  D SETMAP^DICL1(.DIDENT,DILIST)
 K @DILIST@("B")
 ;
 QUIT  ; end of CLOSE
 ;
 ;
 ; Error messages:
 ; 120  The previous error occurred when performin
 ; 202  The input parameter that identifies the |1
 ; 204  The input value contains control character
 ; 301  The passed flag(s) '|1|' are unknown or in
 ; 8090 Pre-lookup transform (7.5 node)
 ; 8093 Too many lookup values for this index.
 ; 8094 Not enough lookup values provided for an e
 ; 8095 Only one compound index allowed on a looku
 ;
 ;
EOR ; end of routine DICF
