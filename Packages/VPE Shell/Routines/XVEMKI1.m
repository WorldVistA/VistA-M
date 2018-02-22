XVEMKI1 ;DJB/KRN**Indiv Fld DD ;2017-08-15  12:57 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INDIV(DD,FNUM) ;Individual Field Summary
 ;DD   = File number
 ;FNUM = Field number
 ;
 NEW I,NODE,STRING,Z1,ZA,ZB,ZD
 NEW C1,C2,C3,C4,C5,C6,C7
 ;
 D INIT
 D DISPLAY
EX ;Exit
 Q:FLAGQ!$G(FLAGP)
 F I=$Y:1:(XVVSIZE+1) W !
 W !,$E(XVVLINE,1,XVV("IOM"))
 Q
 ;
DISPLAY ;Display data dictionary for individual field
 I '$G(FLAGP) W @XVV("IOF"),!,$E(XVVLINE,1,XVV("IOM"))
 I $G(FLAG)="XREF" D  Q:$$CHECK
 . W !?(XVV("IOM")-32\2),"*** You selected a Xref node ***"
 I $G(FLAG)="WP" D  Q:$$CHECK
 . W !?(XVV("IOM")-43\2),"*** You selected a Word Processing node ***"
 W !?C1,"FIELD NAME:",?C4,$P(NODE(0),U,1) Q:$$CHECK
 W ! Q:$$CHECK
 W !?C1,"FLD NUMBER:",?C4,FNUM
 W ?36,"FLD TITLE:  ",$G(^DD(DD,FNUM,.1))
 Q:$$CHECK
 W !?C1,"NODE;PIECE:"
 W ?C4,$S($P(NODE(0),U,4)=" ; ":"Computed",1:$P(NODE(0),U,4))
 W ?35,"HELP FRAME:  ",$G(^DD(DD,FNUM,22))
 Q:$$CHECK
 W ! Q:$$CHECK
 W !?C1,"    ACCESS:"
 W ?C4,"RD: ",$G(^(8))
 W "   ","DEL: ",$G(^(8.5)),"   "
 W "WR: ",$G(^(9))
 Q:$$CHECK
 ;
DATATYPE S ZD=$P(NODE(0),U,2) D DTYPE^XVEMKI2 Q:FLAGQ
 ;
VERIFY I FNUM=".01" D  Q:FLAGQ
 . NEW FLD,ND,UP
 . S UP=$G(^DD(DD,0,"UP")) Q:'UP
 . S FLD=$O(^DD(UP,"SB",DD,"")) Q:'FLD
 . S ND=$G(^DD(UP,FLD,0)) Q:ND']""
 . I $P(ND,U,2)["A" D  Q:$$CHECK
 .. W !?C4,"Do not ask for verification when entering new subentry"
 . I $P(ND,U,2)["M" D  Q:$$CHECK
 .. W !?C4,"After select/add subentry, ask for another subentry"
 ;
 ;--> Input Transform
 I $P(NODE(0),U,5)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,$S(ZD["C":"CODE CREATING X:",1:"INPUT TRANSFORM:")
 . S STRING=$P(NODE(0),U,5,99) D STRING^XVEMKI3
 ;
 ;--> Output Transform
 I NODE(2)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"OUTPUT TRANSFORM:"
 . S STRING=NODE(2) D STRING^XVEMKI3
 ;
DELETE I $D(^DD(DD,FNUM,"DEL")) D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"DELETE NODE(S):"
 . W ?C4,"If $T is set to 1, no deleting."
 . Q:$$CHECK
 . S ZA=""
 . F  S ZA=$O(^DD(DD,FNUM,"DEL",ZA)) Q:ZA=""  D  Q:FLAGQ
 .. W !?6,"Node: ",ZA
 .. S STRING=^DD(DD,FNUM,"DEL",ZA,0) D STRING^XVEMKI3
 ;
 I $D(^DD(DD,0,"ID",FNUM)) D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"IDENTIFIER:"
 . S STRING=^DD(DD,0,"ID",FNUM) D STRING^XVEMKI3
 ;
PROMPT I NODE(3)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"PROMPT MESSAGE:"
 . S STRING=NODE(3) D WORD^XVEMKI3
 . Q:$$CHECK
 ;
 I $G(NODE(4))]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"EXECUTABLE HELP:"
 . S STRING=NODE(4) D STRING^XVEMKI3
 ;
 I NODE(7.5)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"PRE-LOOKUP TRANS:"
 . S STRING=NODE(7.5) D STRING^XVEMKI3
 ;
 I NODE(9.1)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"COMP. EXPRESSION:"
 . S STRING=NODE(9.1) D STRING^XVEMKI3
 ;
OVERFLOW ;Nodes 9.2 to 9.9, that contain overflow code
 I $D(^DD(DD,FNUM,9.2)) D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"OVERFLOW EXECUTABLE CODE:" Q:$$CHECK
 . S ZA=9.199
 . F  S ZA=$O(^DD(DD,FNUM,ZA)) Q:ZA'?1"9."1N  D  Q:FLAGQ
 .. W !?6,"Node: ",ZA
 .. S STRING=^DD(DD,FNUM,ZA) D STRING^XVEMKI3
 ;
SCREEN I NODE(12)]"" D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"SCREEN: "
 . S STRING=NODE(12) D STRING^XVEMKI3
 ;
 I NODE(12.1)]"" D  Q:FLAGQ
 . W !?C1,"SCREEN CODE:" Q:$$CHECK
 . S STRING=NODE(12.1) D STRING^XVEMKI3
 ;
DESCRIP ;Description
 I $D(^DD(DD,FNUM,21)) D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"DESCRIPTION:"
 . D WORDA^XVEMKI3("^DD("_DD_","_FNUM_",21)",0)
 ;
TECHDESC ;Technical Description
 I $D(^DD(DD,FNUM,23)) D  Q:FLAGQ
 . W ! Q:$$CHECK
 . W !?C1,"TECH DESCRIPTION:"
 . D WORDA^XVEMKI3("^DD("_DD_","_FNUM_",23)",0)
 ;
HELP I $D(^DD(DD,FNUM,22)),^(22)]"" D HELP^XVEMKI2 Q:FLAGQ
 ;
KEY ;Keys
 D KEYS^XVEMKI4 Q:FLAGQ
 ;
NEWINDEX ;New-style indexes
 D INDEX^XVEMKI4 Q:FLAGQ
 ;
OLDINDEX ;Old-style indexes
 I $D(^DD(DD,FNUM,1)) D OLDINDX^XVEMKI2 Q:FLAGQ
 Q
 ;
CHECK() ;Check page length. 0=Ok  1=Quit
 I $Y'>(XVVSIZE+1) Q 0
 D PAGE^XVEMKI3 I FLAGQ Q 1
 Q 0
 ;
INIT ;
 S FLAGQ=0,U="^"
 D REVVID^XVEMKY2
 S C1=2,C2=5,C3=15,C4=20,C5=22,C6=25,C7=38 ;Columns
 F I=0,2,3,4,7.5,9.1,12,12.1 S NODE(I)=$G(^DD(DD,FNUM,I))
 Q
