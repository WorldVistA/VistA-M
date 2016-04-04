DICL3 ;SF/TKW-VA FileMan: Lookup: Lister, Part 4 ;1/26/99  08:32
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**3**
 ;
FOLLOW(DIFILE,DIF,DIDEF,DICHNNO,DILVL,DIFRFILE,DIFIELD,DIDXFILE,DIVPTR,DISUB,DISCREEN) ;
 ;
 ; follow pointer/vp chains to end, building stack along the way
 ;
F1 ; increment stack level, loop increments at top
 ; if pointing file lacks B index, store that in stack
 ;
 S DILVL=DILVL+1
 I DILVL=1 S DIF(1,DIFILE)=U_DIDXFILE
 I DILVL>1 D
 . S DIF(DILVL,DIFILE)=DIFRFILE_U_DIVPTR
 . I '$D(@DIFILE(DIFILE)@("B")) S DIFILE(DIFILE,"NO B")=""
 . S DIFILE(DIFILE,"O")=$$OREF^DIQGU(DIFILE(DIFILE))
 . Q
F2 ; Find data type of .01 field of pointed-to file, process
 ; end of pointer chain.
 N T S T=$P(DIDEF,U,2)
 I T'["P",T'["V" D  Q
 . S DIFILE("STACKEND",DICHNNO)=DILVL_U_DIFILE
 . N L,F F L=DILVL:-1:1 D
 . . S DIFILE("STACK",DICHNNO,L,DIFILE)=DIFRFILE_U_DIVPTR
 . . Q:L=1
 . . S DIFILE=+DIF(L,DIFILE)
 . . S F=DIF(L-1,DIFILE),DIFRFILE=$P(F,U),DIVPTR=$P(F,U,2)
 . S DICHNNO=DICHNNO+1
 . Q
F3 ; Advance file number, Process regular pointers within pointer chain.
 N DIFRFILE S DIFRFILE=DIFILE
 I T["P" D  Q
 . S DIFILE=+$P($P(DIDEF,U,2),"P",2)
 . S DIFILE(DIFILE)=$$CREF^DIQGU(U_$P(DIDEF,U,3))
 . S DIDEF=$G(^DD(DIFILE,.01,0))
 . D FOLLOW(.DIFILE,.DIF,DIDEF,.DICHNNO,.DILVL,DIFRFILE,"","",0)
 . Q
F4 ; Process variable pointers within the pointer chain.
 N DIVP,G
 S:'$G(DIFIELD) DIFIELD=.01
 F DIVP=0:0 S DIVP=$O(^DD(DIFILE,DIFIELD,"V",DIVP)) Q:'DIVP  S G=$G(^(DIVP,0)) D
 . Q:'G
 . S DIFILE=+G,G=$G(^DIC(DIFILE,0,"GL")) I G="" S DIFILE=DIFRFILE Q
 . I DILVL=1,$D(DISCREEN("V",DISUB)),'$D(DINDEX(DISUB,"VP",G)) S DIFILE=DIFRFILE Q
 . S DIFILE(DIFILE)=$$CREF^DIQGU(G)
 . S DIDEF=$G(^DD(DIFILE,.01,0))
 . N DISAVL S DISAVL=DILVL
 . D FOLLOW(.DIFILE,.DIF,DIDEF,.DICHNNO,.DILVL,DIFRFILE,"","",1)
 . S DILVL=DISAVL,DIFILE=DIFRFILE
 Q
 ;
BACKTRAK(DIFLAGS,DIFILE,DISTACK,DIEN,DIFIEN,DINDEX0,DINDEX,DIDENT,DISCREEN,DILIST) ;
 ;
 ; Back up on pointer stack until we get back to home file.
 ;
B1 ; back up one level on stack, recover file #, root, and index file,
 ; and set value to match equal to the previous level's ien value
 ;
 N F,DIVPTR S F=DIFILE("STACK",+DISTACK,+$P(DISTACK,U,2),+$P(DISTACK,U,3))
 S DIVPTR=$P(F,U,2),F=+F
 N DIVALUE D
 . I 'DIVPTR S DIVALUE=DIEN Q
 . S DIVALUE=DIEN_";"_$P(DIFILE(+$P(DISTACK,U,3),"O"),U,2)
 . Q
 S DISTACK=(+DISTACK)_U_($P(DISTACK,U,2)-1)_U_F
 I $P(DISTACK,U,2)=1 D  Q
 . N DIROOT1 S DIROOT1=$S($D(DIFILE(F,"NO B")):DIFILE(F,"NO B"),1:DIFILE(F,"O")_"DINDEX0")_")"
 . I $O(@DIROOT1@(DIVALUE,""))="" S DIEN="" Q
 . S DINDEX0(1)=DIVALUE,DIEN=""
 . S DIFILE=+F
 . S F=$TR(DIFLAGS,"vp")
 . D WALK^DICLIX(F,.DINDEX0,.DIDENT,.DIFILE,.DIEN,.DIFIEN,.DISCREEN,.DILIST,.DINDEX,"",.DIC)
 . S DIFILE=+$P(DIFILE("STACK"),U,3)
 . Q
 ;
B2 ; loop through matches on pointer index,
 ; quit when no matches, if not back to root of pointer chain yet,
 ; make another recursive call to BACKTRAK to unwind to pointing
 ; file's matches
 ;
 S DIEN="" F  D  Q:DIEN=""!($G(DIERR))
 . N DIROOT1 S DIROOT1=$S($D(DIFILE(F,"NO B")):DIFILE(F,"NO B"),1:DIFILE(F,"O")_"""B""")_")"
 . S DIEN=$O(@DIROOT1@(DIVALUE,DIEN))
 . Q:DIEN=""
 . D BACKTRAK(.DIFLAGS,.DIFILE,DISTACK,DIEN,DIFIEN,.DINDEX0,.DINDEX,.DIDENT,.DISCREEN,.DILIST)
 . Q
 Q
 ;
SETB ; Set temporary "B" index on pointed-to files.
 Q:'$O(DIFILE("STACK",0))
 N I,J,DIFL,DITEMP
 F I=0:0 S I=$O(DIFILE("STACK",I)) Q:'I  F J=0:0 S J=$O(DIFILE("STACK",I,J)) Q:'J  F DIFL=0:0 S DIFL=$O(DIFILE("STACK",I,J,DIFL)) Q:'DIFL  I $D(DIFILE(DIFL,"NO B")) D
 . D TMPB^DICUIX1(.DITEMP,DIFL)
 . S DIFILE(DIFL,"NO B")=DITEMP
 . D BLDB^DICUIX1(DIFILE(DIFL),DITEMP)
 . Q
 Q
 ;
