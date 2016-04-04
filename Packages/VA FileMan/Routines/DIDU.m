DIDU ;SEA/TOAD-VA FileMan: DD Tools, External Format ;21AUG2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**31,48,999,1004,1036**
 ;
EXTERNAL(DIFILE,DIFIELD,DIFLAGS,DINTERNL,DIMSGA) ;
 ;
 ; convert a value from internal to external format
 ; used all over lookup routines
 ;
XTRNLX ;
 ;
 ; support for documented entry point $$EXTERNAL^DILFD
 ; branch from DILFD or DIQGU
 ;
E1 ; set up DBS environment variables
 ;
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 N DICLERR S DICLERR=$G(DIERR) K DIERR
 ;
E2 ; handle bad input variables
 ;
 I $G(DINTERNL)="" Q ""
 S DIMSGA=$G(DIMSGA)
 S DIFLAGS=$G(DIFLAGS)
 I DIFLAGS'?.1(1"F",1"L",1"U",1"i",1"h",1"A") D ERR(DIMSGA,301,"","","",DIFLAGS) Q ""
 I $G(DIFIELD)'>0 D ERR(DIMSGA,202,"","","","FIELD") Q ""
 ;
E3 ; get field definition and type, handle bad file or field
 ;
 I $G(DIFILE)<0 D ERR(DIMSGA,202,"","","","FILE") Q ""
 N DINODE S DINODE=$G(^DD(DIFILE,DIFIELD,0))
 I DINODE="" D  Q ""
 . I '$D(^DD(DIFILE)) D ERR(DIMSGA,401,DIFILE)
 . E  D ERR(DIMSGA,501,DIFILE,"",DIFIELD,DIFIELD)
 N DITYPE S DITYPE=$P(DINODE,U,2)
 ;
E4 ; initialize loop control, transform code, pointer chain window,
 ; pointer file info, and resolved value variables
 ;
 N DICHAIN,DIDONE,DIOUT S (DICHAIN,DIDONE,DIOUT)=0
 N DIXFORM S DIXFORM=""
 N DINEXT,DIPREV,DIPREVF S (DINEXT,DIPREV,DIPREVF)=""
 N DIEN,DIHEAD,DIROOT S DIEN=""
 N DIEXTRNL S DIEXTRNL=""
 ;
E5 ; handle output transforms (see docs for effects of flags)
 ; under right conditions, execute output transform on value & quit
 ;
 F  D  I DIDONE!$G(DIERR)!DIOUT Q
 . I DIFLAGS["U",DIXFORM'="",DITYPE'["P",DITYPE'["V" S DITYPE=DITYPE_"O"
 . I DITYPE["O",DIFLAGS'["i",DIFLAGS'["h" D  I DIDONE!$G(DIERR) Q
 . . I DIFLAGS["F",DICHAIN Q
 . . I DIFLAGS["L",DITYPE["P"!(DITYPE["V") Q
 . . I DIXFORM=""!(DIFLAGS'["U") S DIXFORM=$G(^DD(DIFILE,DIFIELD,2))
 . . I DIXFORM="" Q
 . . I DIFLAGS["U",DITYPE["P"!(DITYPE["V") Q
 . . N Y S Y=DINTERNL X DIXFORM
 . . I $G(DIERR) D ERR^DICF4(120,DIFILE,DIEN,"","Output Transform") Q
 . . S DIEXTRNL=Y,DIDONE=1
 .
E6 . ; continue with loop only for pointers or variable pointers
 .
 . I DITYPE S DIOUT=1 Q
 . I DITYPE'["P",DITYPE'["V" S DIOUT=1 Q
 .
E7 . ; if the value's not numeric, it's not valid; note that throughout
 . ; module we return two different errors depending on whether the
 . ; value passed in is bad, or one found in the pointer chain is
 .
 . I 'DINTERNL D  Q
 . . I 'DICHAIN D ERR(DIMSGA,330,"","","",DINTERNL,"pointer") Q
 . . D ERR(DIMSGA,630,DIFILE,"",DIFIELD,DIEN,DINTERNL,"pointer")
 .
E8 . ; get pointed to file's root and #
 .
 . I DITYPE["P" S DIROOT=$P(DINODE,U,3),DINEXT=+$P($P(DINODE,U,2),"P",2) D  Q:$G(DIERR)
 . . I DIROOT="DIC(.2," S DINEXT=.2
 . . I 'DINEXT!(DIROOT="") D ERR(DIMSGA,537,DIFILE,,DIFIELD)
 . . Q
 . I DITYPE["V" S DIROOT=$P(DINTERNL,";",2),DINEXT="" D  Q:$G(DIERR)
 . . I DIROOT="" D ERR(DIMSGA,348,,,,DINTERNL) Q
 . . S DIHEAD=$G(@(U_DIROOT_"0)"))
 . . I DIHEAD="" D  Q
 . . . D HEADER(DIFILE,DIEN,DIFIELD,DITYPE,DICHAIN,DINTERNL,DINEXT)
 . . S DINEXT=+$P(DIHEAD,U,2) I 'DINEXT D  Q
 . . . D ERR(DIMSGA,404,"","","",$$CREF^DILF(U_DIROOT))
 .
E9 . ; ensure pointed to data file exists, and advance file #s
 .
 . I '$D(@(U_DIROOT_"+DINTERNL)")) D  Q
 . . N DI S DI="pointer to File #"
 . . I 'DICHAIN D ERR(DIMSGA,330,"","","",DINTERNL,DI_DINEXT) Q
 . . D ERR(DIMSGA,630,DIFILE,DIFIELD,"",DIEN,DINTERNL,DI_DINEXT)
 . S DIPREV=DIFILE,DIFILE=DINEXT
 .
E10 . ; advance pointer value, file characteristics, & pointer window
 . ; ensure pointed to record exists, & its .01 has a DD
 . ; set flag that we are now in the pointer chain
 .
 . S DIEN=+DINTERNL
 . S DINTERNL=$P($G(^(DIEN,0)),U) ;***** Naked *****
 . I DINTERNL="" D ERR(DIMSGA,603,DIFILE,"",.01,DIEN) Q
 . S DINODE=$G(^DD(DIFILE,.01,0))
 . S DITYPE=$P(DINODE,U,2)
 . I DITYPE="" D ERR(DIMSGA,510,DIFILE,"",.01) Q
 . S DIPREVF=DIFIELD,DIFIELD=.01
 . S DICHAIN=1
 . S:DIFILE=.2 DIDONE=1 Q
 ;
E11 ; exit if we executed an output transform or ran into an error
 ;
 ; Special "i" flag returns internal value at end of pointer chain
 I DIFLAGS["i" Q DINTERNL
 I DIFILE=.2 Q DINTERNL
 I DIDONE Q DIEXTRNL
 I $G(DIERR) Q ""
 ;
E12 ; handle illegal data types (pointers, word processings, and multiples)
 ;
 I DITYPE["C" D ERRPTR("Computed") Q ""
 I DITYPE["W" D ERRPTR("Word Processing") Q ""
 I DITYPE S DITYPE=$P($G(^DD(+DITYPE,.01,0)),U,2) D  Q ""
 . I DITYPE["W" D ERRPTR("Word Processing") Q
 . D ERRPTR("Multiple") Q
 ;
E13 ; handle sets of codes
 ;
 I DITYPE["S" D  Q DIEXTRNL
 . N DICODES S DICODES=$P(DINODE,U,3)
 . N DISTART S DISTART=$F(";"_DICODES,";"_DINTERNL_":")
 . I 'DISTART S DIEXTRNL="" D  Q
 . . I 'DICHAIN D ERR(DIMSGA,730,DIFILE,"",DIFIELD,DINTERNL,"code") Q
 . . D ERR(DIMSGA,630,DIFILE,DIFIELD,"",DIEN,DINTERNL,"code")
SET . S DISTART=DINTERNL D PARSET^DIQ(DICODES,.DISTART) S DIEXTRNL=DISTART
 ;
E14 ; handle dates, and return all others as they are
 ;
 I DITYPE["D",DINTERNL D  Q DIEXTRNL
 . S DIEXTRNL=$$DATE^DIUTL(DINTERNL) ;**CCO/NI
 . I DIEXTRNL'="" Q
 . I 'DICHAIN D ERR(DIMSGA,330,"","","",DINTERNL,"date") Q
 . D ERR(DIMSGA,630,DIFILE,"",DIFIELD,DIEN,DINTERNL,"date")
 I DICLERR'=""!$G(DIERR) D
 . S DIERR=$G(DIERR)+DICLERR_U_($P($G(DIERR),U,2)+$P(DICLERR,U,2))
 Q DINTERNL
 ;
HEADER(DIFILE,DIEN,DIFIELD,DITYPE,DICHAIN,DINTERNL,DINEXT) ;
 ;
 ; pick a header error and log it
 ; EXTERNAL
 ;
 I DITYPE["P" D  ; pointer
 . I 'DINEXT!'$D(^DD(DINEXT)) D ERR(DIMSGA,537,DIFILE,"",DIFIELD) Q
 . D ERR(DIMSGA,403,DINEXT)
 ;
 E  D            ; variable pointer
 . I DICHAIN D ERR(DIMSGA,648,DIFILE,"",DIFIELD,DIEN,DINTERNL) Q
 . D ERR(DIMSGA,348,"","","",DINTERNL)
 Q
 ;
ERR(DIMSGA,DIERN,DIFILE,DIIENS,DIFIELD,DI1,DI2,DI3) ;
 ;
 ; error logging procedure
 ; EXTERNAL
 ;
 I $G(DIFLAGS)["A",$$ALLOW(DIERN) S DIDONE=1 Q
 N DIPE,DI F DI="FILE","IENS","FIELD",1:1:3 S DIPE(DI)=$G(@("DI"_DI))
 D BLD^DIALOG(DIERN,.DIPE,.DIPE,DIMSGA,"F")
 S DIERR=$G(DIERR)+DICLERR_U_($P($G(DIERR),U,2)+$P(DICLERR,U,2))
 Q
 ;
ERRPTR(DITYPE) ;
 ;
 ; error logging shell for errors 520 & 537
 ; EXTERNAL
 ;
 I DICHAIN D ERR(DIMSGA,537,DIPREV,"",DIPREVF) Q
 D ERR(DIMSGA,520,DIFILE,"",DIFIELD,DITYPE)
 Q
 ;
ALLOW(X) ;If ALLOW appears, do not call erroneous data an error
 N I,T F I=3:1 S T=$T(ALLOW+I) Q:T?.P  I T[X Q:T'["ALLOW"  K T Q
 Q '$D(T)
 ; 202    The input parameter that identifies the |1
 ; 301    The passed flag(s) '|1|' are unknown or in
 ; 330    The value '|1|' is not a valid |2|.           ALLOW
 ; 348    The passed value '|1|' points to a file th
 ; 401    File #|FILE| does not exist.
 ; 403    File #|FILE| lacks a Header Node.
 ; 404    The File Header node of the file stored at
 ; 501    File #|FILE| does not contain a field |1|.
 ; 510    The data type for Field #|FIELD| in File #
 ; 520    A |1| field cannot be processed by this ut
 ; 537    Field #|FIELD| in File #|FILE| has a corru
 ; 603    Entry #|1| in File #|FILE| lacks the requi
 ; 630    In Entry #|1| of File #|FILE|, the value '    ALLOW
 ; 648    In Entry #|1| of File #|FILE|, the value '
 ; 730    The value '|1|' is not a valid |2| accordi    ALLOW
 ;
