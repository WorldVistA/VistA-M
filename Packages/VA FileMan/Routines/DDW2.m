DDW2 ;SFISC/MKO-SETTINGS, MODES ;11:32 AM  25 Aug 2000
 ;;22.0;VA FileMan;**18**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TSET N DDWX
 S DDWX=$E(DDWRUL,DDWC)
 S DDWX=$S(DDWX="T":"=",DDWX="=":"T",1:DDWX)
 S $E(DDWRUL,DDWC)=DDWX
 I DDWC'=DDWLMAR,DDWC'=DDWRMAR D
 . D CUP(DDWMR+1,DDWC-DDWOFS) W DDWX
 . D POS(DDWRW,DDWC)
 Q
 ;
TSALL ;Prompt for tab stops
 N DDWHLP,DDWANS,DDWCOD
 S DDWHLP(1)="  Specify in which column(s) you want to set tab stops. To set individual"
 S DDWHLP(2)="  tab stops, type a series of numbers separated by commas, for example:"
 S DDWHLP(3)="  4,7,15,20. To set tab stops at repeated intervals after the last stop,"
 S DDWHLP(4)="  or column 1, type the interval as +n, for example: 10,20,+5."
 D ASK^DDWG(5,"Columns in which to set tab stops: ",30,$G(DDWTAB),"D TSALLVAL^DDW2",.DDWHLP,.DDWANS,.DDWCOD)
 ;
 Q:DDWCOD="TO"!(DDWANS=U)!(DDWANS=DDWTAB)
 S DDWTAB=DDWANS
 S DDWRUL=$$RULER(DDWTAB)
 D RULER^DDW3,POS(DDWRW,DDWC)
 Q
 ;
TSALLVAL ;Validate tab stops
 K DDWERR
 S:DDWX="@" DDWX=""
 I DDWX?1."^"!($P($G(DDWCOD),U)="TO") S DDWX=U Q
 I $TR(DDWX,"+,")?.E1.APC.E D
 . S DDWERR="  Response can contain only commas (,), plus signs (+), and numbers."
 Q
 ;
RULER(TAB) ;Return the ruler with tab stops
 N C,INT,LAST,POS,RUL
 S RUL=$TR($J("",255)," ","=")
 ;
 ;Process each comma piece in tab
 S LAST=1
 F C=1:1:$L(TAB,",") D
 . S POS=$P(TAB,",",C) Q:POS'?.1"+"1.3N
 . I $E(POS)="+" D
 .. S INT=+$E(POS,2,999)
 .. F POS=LAST+INT:INT:255 S $E(RUL,POS)="T"
 . E  S:POS<256 $E(RUL,POS)="T",LAST=POS
 Q RUL
 ;
LSET I 'DDWRAP D ERR("Margins cannot be set when wrap is off") Q
 I DDWC>231 D ERR("Left margin cannot be set beyond column 231") Q
 I DDWC'<DDWRMAR D ERR("Left margin must be left of right margin") Q
 I DDWLMAR-DDWOFS'<1,DDWLMAR-DDWOFS'>IOM D
 . D CUP(DDWMR+1,DDWLMAR-DDWOFS) W $E(DDWRUL,DDWLMAR)
 D CUP(DDWMR+1,DDWC-DDWOFS) W "<" D POS(DDWRW,DDWC)
 S DDWLMAR=DDWC
 Q
 ;
RSET I 'DDWRAP D ERR("Margins cannot be set when wrap is off") Q
 I DDWC>245 D ERR("Right margin cannot be set beyond column 245") Q
 I DDWC'>DDWLMAR D ERR("Right margin must be right of left margin") Q
 I DDWRMAR-DDWOFS'<1,DDWRMAR-DDWOFS'>IOM D
 . D CUP(DDWMR+1,DDWRMAR-DDWOFS) W $E(DDWRUL,DDWRMAR)
 D CUP(DDWMR+1,DDWC-DDWOFS) W ">" D POS(DDWRW,DDWC)
 S DDWRMAR=DDWC
 Q
 ;
WRAPM S DDWRAP=DDWRAP+1#2
 D CUP(0,3) W $S(DDWRAP:"[ WRAP ]",1:"========")
 I 'DDWRAP D
 . S DDWLMAR(1)=DDWLMAR,DDWLMAR=1
 . S DDWRMAR(1)=DDWRMAR,DDWRMAR=245
 E  D
 . S DDWLMAR=DDWLMAR(1) K DDWLMAR(1)
 . S DDWRMAR=DDWRMAR(1) K DDWRMAR(1)
 D RULER^DDW3,POS(DDWRW,DDWC)
 Q
 ;
REPLM S DDWREP=DDWREP+1#2
 D CUP(0,13) W $S(DDWREP:"[ REPLACE ]",1:"[ INSERT ]=")
 D POS(DDWRW,DDWC)
 Q
 ;
STAT S DDWSTAT=DDWSTAT+1#2
 I DDWSTAT S DDWTO=1
 E  D
 . D CUP(DDWMR+2,1)
 . W $P(DDGLCLR,DDGLDEL) D POS(DDWRW,DDWC)
 . S DDWTO=DTIME
 . K DDWTC
 Q
 ;
CUP(Y,X) ;Cursor positioning
 S DY=IOTM+Y-2,DX=X-1 X IOXY
 Q
 ;
POS(R,C,F) ;Pos cursor based on char pos C
 N DDWX
 S:$G(C)="E" C=$L($G(DDWL(R)))+1
 S:$G(F)["N" DDWN=$G(DDWL(R))
 S:$G(F)["R" DDWRW=R,DDWC=C
 ;
 S DDWX=C-DDWOFS
 I DDWX>IOM!(DDWX<1) D SHIFT^DDW3(C,.DDWOFS)
 S DY=IOTM+R-2,DX=C-DDWOFS-1 X IOXY
 Q
 ;
SCR(C) ;Return screen number
 Q C-$P(DDWOFS,U,2)-1\$P(DDWOFS,U,3)+1
 ;
ERR(DDWX) ;Error
 W $C(7)
 D MSG^DDW(DDWX) H 2 D MSG^DDW()
 F  R *DDWX:0 E  Q
 D POS(DDWRW,DDWC)
 Q
