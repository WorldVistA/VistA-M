DIKKP ;SFISC/MKO-PRINT KEYS ;9:52 AM  3 Mar 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;==============================
 ; PRINT(File,Field,Flag,.Page)
 ;==============================
 ;Print Keys defined a file
 ;In:
 ; FIL     = File #
 ; FLD     = Field # (optional) (ignored if FLAG [ M)
 ; FLAG    [ Cn : column tab stop from left margin
 ;         [ Ln : left margin (def=0)
 ;         [ M  : include subfiles (multiples) under File
 ;         [ S  : suppress line feed before listing
 ; PAGE("H") = Header text or M code that begins with a write statement
 ; PAGE("B") = Bottom margin
 ;Out:
 ; PAGE(U)   = Returns as 1, if timeout or ^ at eop
 ;
PRINT(FIL,FLD,FLAG,PAGE) ;Print keys
 Q:'$G(FIL)
 N FILETXT,LM,SB,SUB,TS,WID
 ;
 ;Initialize variables
 D INIT
 ;
 ;M flag, get and print keys for file and subfiles
 I FLAG["M" D
 . D SUBFILES^DIKCU(FIL,.SB)
 . S SUB=""
 . F  D  Q:PAGE(U)  S:SUB="" SUB="SUB",FIL=0 S FIL=$O(SB(FIL)) Q:'FIL
 .. Q:'$D(^DD("KEY","B",FIL))
 .. S FILETXT=SUB_"FILE #"_FIL
 .. I SUB]""!(FLAG'["S") D WRLN("",0,.PAGE) Q:PAGE(U)
 .. D WRLN(FILETXT,LM,.PAGE,2) Q:PAGE(U)
 .. D WRLN($TR($J("",$L(FILETXT))," ","-"),LM,.PAGE) Q:PAGE(U)
 .. D PRFILE(FIL,"",FLAG,.PAGE) Q:PAGE(U)
 ;
 ;Otherwise, print keys for one file
 E  D
 . I FLAG'["S" D WRLN("",0,.PAGE) Q:PAGE(U)
 . D PRFILE(FIL,$G(FLD),FLAG,.PAGE)
 Q
 ;
PRFILE(FIL,FLD,FLAG,PAGE) ;Print keys for a file
 Q:'$G(FIL)
 N KEY,NAM,SP
 I $G(FLAG)'["i" N LM,TS,WID D INIT
 ;
 I $G(FLD)="" D
 . S NAM="" F  S NAM=$O(^DD("KEY","BB",FIL,NAM)) Q:NAM=""  D  Q:PAGE(U)
 .. S KEY=0 F  S KEY=$O(^DD("KEY","BB",FIL,NAM,KEY)) Q:'KEY  D  Q:PAGE(U)
 ... I $G(SP) D WRLN("",0,.PAGE) Q:PAGE(U)
 ... D PRKEY(KEY,FLAG,.PAGE)
 ... S SP=1
 ;
 E  S KEY=0 F  S KEY=$O(^DD("KEY","F",FIL,FLD,KEY)) Q:'KEY  D  Q:PAGE(U)
 . I $G(SP) D WRLN("",0,.PAGE) Q:PAGE(U)
 . D PRKEY(KEY,FLAG,.PAGE)
 . S SP=1
 Q
 ;
PRKEY(KEY,FLAG,PAGE) ;Print one key
 Q:'$G(KEY)
 N FIL,FLD,FLDN,LN,LUI,LUIN,NAM,PRI,SEQ,TAB1,TXT,UI,UI0
 I $G(FLAG)'["i" N LM,TS,WID D INIT
 ;
 ;Print Priority, Key Name and Number
 Q:$G(^DD("KEY",KEY,0))?."^"
 S NAM=$P(^DD("KEY",KEY,0),U,2),PRI=$P(^(0),U,3),UI=$P(^(0),U,4)
 S:PRI]"" PRI=$$EXTERNAL^DILFD(.31,1,"",PRI)
 S TXT=PRI_" KEY: "
 S TXT=TXT_$J("",TS-$L(TXT))_NAM_" (#"_KEY_")"
 D WRLN(TXT,LM,.PAGE) Q:PAGE(U)
 ;
 ;Print Uniqueness Index
 I UI D
 . S UI0=$G(^DD("IX",UI,0))
 . K TXT S TXT=0,TXT(0)=$P(UI0,U,2)_" (#"_UI_")"
 . D:$P(UI0,U)'=$P(UI0,U,9) ADDSTR("  WHOLE FILE (#"_$P(UI0,U)_")",.TXT)
 . D WRAP^DIKCU2(.TXT,WID)
 . D WRLN("Uniqueness Index: "_TXT(0),LM+TS-18,.PAGE) Q:PAGE(U)
 . F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),LM+TS,.PAGE) Q:PAGE(U)
 ;
 ;Print Lookup Indexes
 K TXT S TXT=0,TXT(0)=""
 S LUIN=0 F  S LUIN=$O(^DD("KEY",KEY,3.1,LUIN)) Q:'LUIN  D
 . S LUI=$P($G(^DD("KEY",KEY,3.1,LUIN,0)),U) Q:'LUI
 . S:TXT(TXT)]"" TXT(TXT)=TXT(TXT)_", "
 . D ADDSTR($P($G(^DD("IX",LUI,0)),U,2)_" (#"_LUI_")",.TXT)
 I TXT(0)]"" D  Q:PAGE(U)
 . D WRAP^DIKCU2(.TXT,WID)
 . D WRLN("Lookup Index(es): "_TXT(0),LM+TS-18,.PAGE) Q:PAGE(U)
 . F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),LM+TS,.PAGE) Q:PAGE(U)
 ;
 ;Print Fields
 K TXT S TXT=0,TXT(0)=""
 S SEQ=0 F  S SEQ=$O(^DD("KEY",KEY,2,"S",SEQ)) Q:'SEQ  D  Q:PAGE(U)
 . S FLD=0 F  S FLD=$O(^DD("KEY",KEY,2,"S",SEQ,FLD)) Q:'FLD  D  Q:PAGE(U)
 .. S FIL=0 F  S FIL=$O(^DD("KEY",KEY,2,"S",SEQ,FLD,FIL)) Q:'FIL  D  Q:PAGE(U)
 ... S FLDN=0 F  S FLDN=$O(^DD("KEY",KEY,2,"S",SEQ,FLD,FIL,FLDN)) Q:'FLDN  D  Q:PAGE(U)
 .... Q:$G(^DD("KEY",KEY,2,FLDN,0))?."^"
 .... S:TXT(TXT)]"" TXT(TXT)=TXT(TXT)_"  "
 .... D ADDSTR(SEQ_")"_$C(0)_$P($G(^DD(FIL,FLD,0)),U)_" ("_FIL_","_FLD_")",.TXT)
 I TXT(0)]"" D  Q:PAGE(U)
 . D WRAP^DIKCU2(.TXT,WID)
 . D WRLN("File, Field: "_TXT(0),LM+TS-13,.PAGE) Q:PAGE(U)
 . F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),LM+TS,.PAGE) Q:PAGE(U)
 Q
 ;
ADDSTR(X,TXT) ;Add string X to the TXT array
 I $L(TXT(TXT))+$L(X)>200 S TXT=TXT+1,TXT(TXT)=""
 S TXT(TXT)=TXT(TXT)_X
 Q
 ;
INIT ;Initialize module-wide variables
 Q:$G(FLAG)["i"
 S FLAG=$G(FLAG)_"i"
 S LM=$P(FLAG,"L",2)\1
 S TS=$P(FLAG,"C",2)\1 S:'TS TS=20
 S WID=$G(IOM,80)-1-LM-TS S:WID<1 WID=1
 S PAGE(U)=""
 Q
 ;
 ;===================================
 ; WRLN(Text,Tab,.Page,KeepWithNext)
 ;===================================
 ;Write a single line of text, precede with a !, do paging if necessary
 ;In:
 ; TXT       = Text to write; $C(0) replaced with spaces.
 ; TAB       = ?Tab before writing text (def=0)
 ; PAGE("H") = Header text or M code that begins with a write statement
 ;             If not passed in, no paging.
 ; PAGE("B") = Bottom margin
 ; KWN       = Additional padding on bottom margin ("keep with next")
 ;Out:
 ; PAGE(U)   = Returns as 1, if timeout or ^ at eop
 ;
WRLN(TXT,TAB,PAGE,KWN) ;Write a line of text
 N X
 S PAGE(U)=""
 ;
 ;Do paging, if necessary
 I $D(PAGE("H"))#2,$G(IOSL,24)-2-$G(PAGE("B"))-$G(KWN)'>$Y D  Q:PAGE(U)
 . I PAGE("H")?1"W ".E X PAGE("H") Q
 . I $E($G(IOST,"C"))="C" D  Q:PAGE(U)
 .. W $C(7) R X:$G(DTIME,300) I X=U!'$T S PAGE(U)=1
 . W @$G(IOF,"#"),PAGE("H")
 ;
 ;Write text
 W !?$G(TAB),$TR($G(TXT),$C(0)," ")
 Q
