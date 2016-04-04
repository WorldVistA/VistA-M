DICL2 ;SEA/TOAD,SF/TKW-VA FileMan: Lookup: Lister, Part 3 ;11JUNE2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20,1032**
 ;
 ;.
SCREEN(DIFILE,DIEN,DIFLAGS,DIFIEN,DISCREEN,DINDEX,DI0NODE) ;
 ;
 ; return 1 if entry should be screened out
 ;
S1 ; entries tagged for archiving, or missing the .01 or already on
 ; the list should be screened out.
 ;
 I DIFILE'<2,'$$VMINUS9^DIEFU(DIFILE,","_DIEN_DIFIEN) Q 1
 I $P(DI0NODE,U)="" Q 1
 I DIFLAGS[4 N DIREC D  I 'DIREC Q 1
 . S DIREC=DIEN I DIFLAGS["v" S DIREC=DIREC_";"_$P(DIFILE(DIFILE,"O"),U,2)
 . I $D(@DILIST@("B",($E($P(DI0NODE,U),1,DINDEX("MAXSUB"))_"^"_DIREC))) S DIREC=0
 . Q
 ;
S2 ; execute any screen on transformed lookup values
 ;
 N DISKIP S DISKIP=0
 I DIFLAGS[4 N DISUB F DISUB=1:1:DINDEX("#") D  Q:DISKIP
 . N DISCR2 S DISCR2=+$G(DINDEX(DISUB,"FOUND"))
 . Q:'$D(DISCREEN(DISUB,DISCR2))
 . N DIVAL,D S @DINDEX(DISUB,"GET"),D=DINDEX
 . X DISCREEN(DISUB,DISCR2) S DISKIP='$T
 . Q
 I DISKIP Q DISKIP
 N DISCR
S3 ; Additional screening for using an alternate index for loop through file.
 I $D(DISCREEN("X")) F DISCR=0:0 S DISCR=$O(DISCREEN("X",DISCR)) Q:'DISCR  D  Q:DISKIP
 . N D,DIPART,DISUB,DIVAL,X
 . X DISCREEN("X",DISCR,"GET") I DIVAL="" S DISKIP=1 Q
 . F DISUB=0:0 S DISUB=$O(DISCREEN("VAL",DISCR,DISUB)) Q:'DISUB  D  Q:'DISKIP
 . . S D="",DISKIP=1
 . . S DIPART=DISCREEN("VAL",DISCR,DISUB) Q:$P(DIVAL,DIPART)'=""
 . . S X=$G(DISCREEN("X",DISCR,DISUB)) I X]"" X X Q:'$T
 . . S DISKIP=0 Q
 . Q
 I DISKIP Q DISKIP
S4 ; Execute Screen parameter, whole file screen.
 F DISCR="F","S" I $G(DISCREEN(DISCR))'="" D  Q:DISKIP
 . N %,D S D=$G(DINDEX)
 . N DIC S DIC=DIFILE(DIFILE,"O")
 . I DIFLAGS[4 S DIC(0)=$TR(DIFLAGS,"2^fqlpqtuv4PQU")
 . E  S DIC(0)=$TR(DIFLAGS,"2^fpq3BIMPQ")
 . N Y M Y=DIEN
 . N Y1 S Y1=DIEN_DIFIEN
 . N X S X=$G(@DIFILE(DIFILE)@(DIEN,0)),X=$P(X,U)
 . I DIFLAGS[4,DIFLAGS["p" N I S I=DIEN
 . D
 . . N DIFILE,DIXV,DIY,DIYX
 . . I 1 X DISCREEN(DISCR) S DISKIP='$T
 .
S5 . ; if the screen returned DIERR, id the error's source with a second
 . ; error and exit
 .
 . I $G(DIERR) D
 . . S DISKIP=1
 . . N DICONTXT
 . . S DICONTXT=$S(DISCR["F":"Whole File Screen",1:"Screen Parameter")
 . . D ERR^DICF4(120,DIFILE,DIEN,"",DICONTXT)
 Q DISKIP
 ;
ACCEPT(DIFILE,DIEN,DIFLAGS,DIFIEN,DINDEX,DIDENT,DILIST,DI0NODE) ;
 ; accept an entry into the output list
 ;
A1 ; if we're doing the final pass (just looking to see if there are any
 ; more entries), we don't actually add it to the list, just note what
 ; we found and quit
 ;
 I DIDENT(-1,"JUST LOOKING") D  Q
 . S DIDENT(-1,"JUST LOOKING")=0
 . S DIDENT(-1,"MORE?")=1
 . Q:DIFLAGS[4
 . N DISAME,I S DISAME=0
 . F I=1:1 Q:I>DINDEX("#")  D  Q:DISAME<I
 . . I DIDENT(-1,"LAST",I,"I")'=DINDEX(I) Q
 . . S DISAME=I Q
 . F I=1:1:(DINDEX("#")+1) K DIDENT(-1,"LAST",I,"I")
 . Q:DISAME=DINDEX("#")
 . F I=(DISAME+2):1:(DINDEX("#")+1) S DIDENT(-1,"LAST",I)=""
 . S DIDENT(-1,"LAST","IEN")="" Q
 ;
A2 ; increment the number found; if it's the max, we flag to make the
 ; next pass a final just looking pass
 ;
 S DIDENT(-1)=DIDENT(-1)+1
 I DIDENT(-1)=DIDENT(-1,"MAX") D
 . S DIDENT(-1,"JUST LOOKING")=1
 . Q:DIFLAGS[4
 . N I F I=1:1:(DINDEX("#")+1) D
 . . S (DIDENT(-1,"LAST",I),DIDENT(-1,"LAST",I,"I"))=DINDEX(I)
 . . I I=1,"VP"[DINDEX(I,"TYPE"),'$D(DINDEX("ROOTCNG",1)) S DIDENT(-1,"LAST",I)=DINDEX0(1)
 . . Q
 . S DIDENT(-1,"LAST")=DIDENT(-1,"LAST",1)
 . S DIDENT(-1,"LAST","IEN")=DIEN
 . Q
 ;
A3 ; increment (or decrement) the output list subscript
 ;
 S DILIST("ORDER")=$S(DIFLAGS[4:DIDENT(-1),1:DILIST("ORDER")+DINDEX("WAY"))
 N DA M DA=DIEN I '$D(DA(1)) N D0 S D0=DA ;***
 ;
A4 ; output the specified values of the record
 ;
 I DIFLAGS'["f" D
 . D IDS^DICU2(.DIFILE,DIEN_DIFIEN,.DIFLAGS,.DINDEX,DILIST("ORDER"),.DIDENT,DILIST,.DI0NODE)
 . Q
 Q:DIFLAGS'[4
 N DIREC S DIREC=DIEN I DIFLAGS["v" S DIREC=DIREC_";"_$P(DIFILE(DIFILE,"O"),U,2)
 I DIFLAGS["f",DIFLAGS'["p" S @DILIST@(DIDENT(-1))=DIREC
 S @DILIST@("B",($E($P(DI0NODE,U),1,DINDEX("MAXSUB"))_U_DIREC))=""
 Q
 ;
 ; Possible output messages
 ; 202    The input parameter that identifies the |1
 ;
