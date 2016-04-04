DDGF0 ;SFISC/MKO-SETUP, CLEANUP ;09:58 AM  9 Sep 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**160**
 ;
 D INIT^DDGLIB0() Q:$G(DIERR)
 D SET,GETKEY
 Q
 ;
SET ;Setup variables
 D:$D(DT)[0 DT^DICRW
 S (DIOVRD,DDGFR)=1,DDGFREF="^TMP(""DDGF"",$J)",DDGFCHG=0
 K @DDGFREF,DDGFFM
 Q
 ;
END ;Clear screen, clean up variables
 I $D(DDGFFM)#2 D RECOMP
KILL ;
 D:$G(DIERR) MSG^DIALOG("BW")
 X:$D(DDGLZOSF) DDGLZOSF("EON"),DDGLZOSF("TRMOFF")
 D KILL^DDGLIB0()
 K:$D(DDGFREF) @DDGFREF,DDGFREF
 K ^TMP("DDGFH",$J)
 K DDGF,DDGFBV,DDGFCHG,DDGFE,DDGFFILE,DDGFFM,DDGFLIM,DDGFMSG
 K DDGFPG,DDGFR,DDGFWID,DDGFWIDB
 K DDH
 Q
 ;
RECOMP ;Recompile form
 N DDGFLIST
 S DDGFLIST=$NA(^TMP("DDGFOF",$J))
 D MSG^DDGF("Recompiling ...")
 ;
 D GETBLKS(+DDGFFM,DDGFLIST)
 S DDSQUIET=1 D EN^DDSZ(DDGFFM) K DDSQUIET
 I $D(@DDGFLIST) D
 . N DDGFI
 . S DDGFI=""
 . F  S DDGFI=$O(@DDGFLIST@(DDGFI)) Q:'DDGFI  D EN^DDSZ(DDGFI)
 . K @DDGFLIST
 ;
 D MSG^DDGF("")
 S DX=0,DY=IOSL-1 X IOXY
 Q
 ;
GETBLKS(F,L) ;
 ;Determine if any of the blocks loaded are
 ;used on other forms.
 ; L(Form#)=""        Other forms that need recompiling
 ;
 N P,B
 S P=0 F  S P=$O(@DDGFREF@("F",P)) Q:'P  D
 . S B=0
 . F  S B=$O(@DDGFREF@("F",P,B)) Q:'B  D:'$D(@L@("B",B))
 .. S @L@("B",B)=""
 .. D OTHER(B,F,L)
 K @L@("B")
 Q
 ;
OTHER(B,F,L) ;
 ;Return list L of forms other than F that use block B
 ; L(Form#)=""
 N F1
 S F1=""
 F  S F1=$O(^DIST(.403,"AB",B,F1)) Q:F1=""  I F1'=F S @L@(F1)=""
 S F1="" F  S F1=$O(^DIST(.403,"AC",B,F1)) Q:F1=""  I F1'=F S @L@(F1)=""
 Q
 ;
GETKEY ;Get key sequences and defaults
 N AU,AD,AR,AL,F1,F2,F3,F4,I,K,N,T
 S AU=$P(DDGLKEY,U,2)
 S AD=$P(DDGLKEY,U,3)
 S AR=$P(DDGLKEY,U,4)
 S AL=$P(DDGLKEY,U,5)
 S F1=$P(DDGLKEY,U,6)
 S F2=$P(DDGLKEY,U,7)
 S F3=$P(DDGLKEY,U,8)
 S F4=$P(DDGLKEY,U,9)
 ;
 F N="","S","D" D
 . S DDGF(N_"IN")="",DDGF(N_"OUT")=""
 . F I=1:1 S T=$P($T(@(N_"MAP")+I),";;",2,999) Q:T=""  D
 .. S @("K="_$P(T,";",2))
 .. I DDGF(N_"IN")'[(U_K) D
 ... S DDGF(N_"IN")=DDGF(N_"IN")_U_K
 ... S DDGF(N_"OUT")=DDGF(N_"OUT")_$P(T,";")_U
 . S DDGF(N_"IN")=DDGF(N_"IN")_U
 . S DDGF(N_"OUT")=$E(DDGF(N_"OUT"),1,$L(DDGF(N_"OUT"))-1)
 Q
 ;
MAP ;Keys for main screen
 ;;LNU;AU;          line up
 ;;LND;AD;          line down
 ;;CHR;AR;          char right
 ;;CHL;AL;          char left
 ;;ELR;$C(9);       element right
 ;;ELL;"Q";         element left
 ;;TBR;"S";         tab right
 ;;TBL;"A";         tab left
 ;;EXIT;F1_"E";     exit
 ;;QUIT;F1_"Q";     quit
 ;;ROWCOL;"R";      row/col indicator toggle
 ;;SCT;F1_AU;       top of screen
 ;;SCB;F1_AD;       bottom of screen
 ;;SCR;F1_AR;       right edge of screen
 ;;SCL;F1_AL;       left edge of screen
 ;;SAVE;F1_"S";     save changes
 ;;SELECT;" ";      select an element
 ;;SELECT;$C(13);   select an element
 ;;SELFILE;F1_1;    select file
 ;;VIEW;F1_"V";     view toggle
 ;;EDIT;F3;         edit caption or data length
 ;;FLDADD;F2_"F";   add a new field
 ;;BKADD;F2_"B";    add a new block
 ;;NXTPG;F1_F1_AD;  go to next page
 ;;PRVPG;F1_F1_AU;  go to previous page
 ;;CLSPG;F1_"C";    close popup page
 ;;PGSEL;F1_"P";    select another page
 ;;PGADD;F2_"P";    add a new page
 ;;PGEDIT;F4_"P";   edit page attributes
 ;;FMSEL;F1_"M";    select another form
 ;;FMADD;F2_"M";    add a new form
 ;;FMEDIT;F4_"M";   edit form attributes
 ;;HELP;F1_"H"
 ;;
SMAP ;Keys for moving selected gadgets
 ;;LNU;AU;          line up
 ;;LND;AD;          line down
 ;;CHR;AR;          char right
 ;;CHL;AL;          char left
 ;;TBR;$C(9);       tab right
 ;;TBR;"S";          "   "
 ;;TBL;"Q";         tab left
 ;;TBL;"A";          "   "
 ;;ROWCOL;"R";      row/col indicator toggle
 ;;SCT;F1_AU;       top of screen
 ;;SCB;F1_AD;       bottom of screen
 ;;SCR;F1_AR;       right edge of screen
 ;;SCL;F1_AL;       left edge of screen
 ;;SUBPG;F1_"D";    go into a multiples pop-up page
 ;;DESELECT;" ";    deselect an element
 ;;DESELECT;$C(13); deselect an element
 ;;EDIT;F4;         edit properties
 ;;REORDER;F1_"O";  reorder fields in block
 ;;
DMAP ;Keys for changing data length
 ;;CHR;AR;          char right
 ;;CHL;AL;          char left
 ;;DONE;$C(13);     done
 ;;DONE;" ";        done
 ;;DONE;F3;         done
 ;;
