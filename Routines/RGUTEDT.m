RGUTEDT ;CAIRO/DKM - Screen-oriented line editor;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Inputs:
 ;   RGDATA  = Data to edit
 ;   RGLEN   = Maximum length of data
 ;   RGX     = Starting column position
 ;   RGY     = Starting row position
 ;   RGVALD  = List of valid inputs (optional)
 ;   RGDISV  = DISV node to save under (optional)
 ;   RGTERM  = Valid input terminators (default=<CR>)
 ;   RGABRT  = Valid input abort characters (default=none)
 ;   RGRM    = Right margin setting (default=IOM or 80)
 ;   RGQUIT  = Exit code (returned)
 ;   RGOPT   = Input options
 ;      C = Mark <CR> with ~
 ;      E = Echo off
 ;      H = Horizontal scroll
 ;      I = No timeout
 ;      L = Lowercase only
 ;      O = Overwrite mode
 ;      Q = Quiet mode
 ;      R = Reverse video
 ;      T = Auto-terminate
 ;      U = Uppercase only
 ;      V = Up/down cursor keys terminate input
 ;      X = Suppress auto-erase
 ; Outputs:
 ;   Return value = Edited data
 ;=================================================================
ENTRY(RGDATA,RGLEN,RGX,RGY,RGVALD,RGOPT,RGDISV,RGTERM,RGABRT,RGRM,RGQUIT) ;
 N RGZ,RGZ1,RGZ2,RGSAVE,RGINS,RGAE,RGBUF,RGTAB,RGPOS,RGEON,RGLEFT,RGBEL,RGMAX,RGRVON,RGRVOFF,RGC,RGW
 S RGVALD=$G(RGVALD),RGOPT=$$UP^XLFSTR($G(RGOPT)),RGBEL=$S(RGOPT'["Q":$C(7),1:""),RGDISV=$G(RGDISV)
 S:$G(RGTERM)="" RGTERM=$C(13)                                         ; Valid line terminators
 S RGABRT=$G(RGABRT)                                                   ; Valid input abort keys
 S RGRVON=$C(27,91,55,109),RGRVOFF=$C(27,91,109)                       ; Reverse video control
 S RGINS=RGOPT'["O"                                                    ; Default mode = insert
 S RGAE=RGOPT'["X"                                                     ; Auto-erase option
 S RGEON=RGOPT'["E"                                                    ; No echo option
 I RGOPT["I"!'$D(DTIME) N DTIME S DTIME=9999999999                                ; Suppress timeout option
 S RGBUF=""
 S RGRM=$G(RGRM,$G(IOM,80))                                            ; Display width
 S RGTAB=$C(9)                                                         ; Tab character
 S RGX=$G(RGX,$X),RGY=$G(RGY,$Y),RGW=RGRM-RGX
 S:RGW'>0 RGW=1
 S:'$G(RGLEN) RGLEN=RGW                                                ; Default field width
 S RGMAX=$S(RGOPT["H":250,1:RGLEN)                                     ; Maximum data length
 S (RGSAVE,RGDATA)=$E($G(RGDATA),1,RGMAX)                              ; Truncate data if too long
 I $$NEWERR^%ZTER N $ET S $ET=""
 S @$$TRAP^RGZOSF("ERROR^RGUTEDT")
 D RM^RGZOSF(0)
 X ^%ZOSF("EOFF")
 F  Q:RGDATA'[RGTAB  S RGZ=$P(RGDATA,RGTAB),RGDATA=RGZ_$J("",8-($L(RGZ)#8))_$P(RGDATA,RGTAB,2,999)
RESTART D RESET
AGAIN F RGQUIT=0:0 Q:RGQUIT  D NXT S RGAE=0
 X ^%ZOSF("EON")
 W $$XY^RGUT(RGX,RGY),$S(RGOPT["R":RGRVOFF,1:"")
 I RGDISV'="" Q:"^^"[RGDATA RGDATA S:RGDATA=" " RGDATA=$G(^DISV(DUZ,RGDISV))
 S:RGDISV'="" ^DISV(DUZ,RGDISV)=RGDATA
 Q RGDATA                                                              ; Return to calling routine
NXT D POSCUR()                                                            ; Position cursor
 R *RGC:DTIME                                                          ; Next character typed
 I RGC=27 D ESC Q:'RGC
 I RGC<1!(RGABRT[$C(RGC)) S RGDATA=U,RGQUIT=1 Q
 I RGTERM[$C(RGC) D TERM Q
 I RGC<28 D:RGC'=27 @("CTL"_$C(RGC+64)) Q
 I RGC=127!(RGC=240) D CTLH Q
 I RGC>64,RGC<91,RGOPT["L" S RGC=RGC+32
 E  I RGC>96,RGC<123,RGOPT["U" S RGC=RGC-32
 I $L(RGVALD),RGVALD'[$C(RGC) D RAISE^RGZOSF()
 D:RGAE CTLK,POSCUR()                                                  ; Erase buffer if auto erase on
 D INSW($C(RGC))
 S RGQUIT=RGPOS=RGLEN&(RGOPT["T")
 Q
CTLA S RGINS='RGINS                                                        ; Toggle insert mode
 Q
CTLB D MOVETO(0)                                                           ; Move cursor to beginning
 Q
CTLX S RGDATA=RGSAVE                                                       ; Restore buffer to original
 G RESET
CTLE D MOVETO($L(RGDATA))                                                  ; Move cursor to end
 Q
CTLI D INSW($J("",8-(RGPOS#8)))                                            ; Insert expanded tab
 Q
CTLJ F RGZ=RGPOS:-1:1 Q:$A(RGDATA,RGZ)'=32                                     ; Find previous nonspace
 F RGZ=RGZ:-1:1 Q:$A(RGDATA,RGZ)=32                                          ; Find previous space
 S RGBUF=$E(RGDATA,RGZ,RGPOS)                                            ; Save deleted portion
 S RGDATA=$E(RGDATA,1,RGZ-1)_$E(RGDATA,RGPOS+1,RGLEN)                    ; Remove word
 D MOVETO(RGZ-1)
 Q
CTLK S RGBUF=RGDATA                                                        ; Save buffer
 S RGDATA=""                                                           ; Erase buffer
 D RESET
 Q
CTLL S RGBUF=$E(RGDATA,RGPOS+1,RGLEN)                                      ; Save deleted portion
 S RGDATA=$E(RGDATA,1,RGPOS)                                           ; Truncate at current position
 D DSPLY(RGPOS)
 Q
CTLM D POSCUR(RGPOS),INSW("~"):RGOPT["C",MOVETO(RGPOS-$X+RGX+RGW)
 Q
CTLR D INSW(RGBUF)                                                         ; Insert at current position
 Q
CTLT D CTLL
 Q
CTLU S RGBUF=$E(RGDATA,1,RGPOS)                                            ; Save deleted portion
 S RGDATA=$E(RGDATA,RGPOS+1,RGLEN)                                     ; Remove to left of cursor
 D RESET
 Q
CTLH I 'RGPOS W RGBEL Q
 D LEFT
CTLD S RGDATA=$E(RGDATA,1,RGPOS)_$E(RGDATA,RGPOS+2,RGMAX)                  ; Delete character to left
 D DSPLY(RGPOS,1)
 Q
TERM S RGQUIT=2
 Q
ESC R *RGZ:1
 R:RGZ>0 *RGZ:1
 S RGC=0
 G UP:RGZ=65,DOWN:RGZ=66,RIGHT:RGZ=67,LEFT:RGZ=68                              ;Execute code
 S RGC=27
 Q
DSPLY(RGP1,RGP2) ;
 Q:'RGEON                                                              ; Refresh buffer display starting at position RGP1
 N RGZ,RGZ1
 S RGP1=+$G(RGP1,RGLEFT),RGZ=$E(RGDATA,RGP1+1,RGLEFT+RGLEN),RGP2=$S($D(RGP2):RGP2+$L(RGZ),1:RGLEN-RGP1+RGLEFT)
 S:RGP2>RGLEN RGP2=RGLEN
 S RGZ=RGZ_$J("",RGP2-$L(RGZ))
 F  D  Q:RGZ=""
 .D POSCUR(RGP1)
 .S RGZ1=RGRM-$X
 .S:RGZ1<1 RGZ1=1
 .W $E(RGZ,1,RGZ1)
 .S RGZ=$E(RGZ,RGZ1+1,999),RGP1=RGP1+RGZ1
 Q
INSW(RGTXT) ;
 S:RGPOS>$L(RGDATA) RGDATA=RGDATA_$J("",RGPOS-$L(RGDATA))              ; Pad if past end of buffer
 S RGDATA=$E($E(RGDATA,1,RGPOS)_RGTXT_$E(RGDATA,RGPOS+2-RGINS,RGMAX),1,RGMAX)
 D DSPLY(RGPOS,0),MOVETO(RGPOS+$L(RGTXT))
 Q
POSCUR(RGP) ;
 N RGZX,RGZY
 S RGP=+$G(RGP,RGPOS),RGZX=RGP-RGLEFT,RGZY=RGZX\RGW+RGY,RGZX=RGZX#RGW+RGX
 W $$XY^RGUT(RGZX,RGZY)
 Q
MOVETO(RGP) ;
 I RGP>RGMAX!(RGP<0) W RGBEL Q
 S RGPOS=RGP,RGP=RGLEFT
 S:RGPOS<RGLEFT RGLEFT=RGPOS-RGW-1
 S:RGLEFT+RGLEN<RGPOS RGLEFT=RGPOS-RGW+1
 S:RGLEFT'<RGMAX RGLEFT=RGMAX-RGW
 S:RGLEFT<0 RGLEFT=0
 D DSPLY():RGLEFT'=RGP,POSCUR()
 Q
UP I RGOPT["V" S RGQUIT=3
 E  D MOVETO(RGPOS-RGW)
 Q
DOWN I RGOPT["V" S RGQUIT=4
 E  D MOVETO(RGPOS+RGW)
 Q
RIGHT D MOVETO(RGPOS+1)
 Q
LEFT D MOVETO(RGPOS-1)
 Q
RESET W $S(RGOPT["R":RGRVON,1:RGRVOFF)
 S (RGPOS,RGLEFT)=0                                                    ; Current edit offset
 D DSPLY()                                                             ; Refresh display
 Q
ERROR W RGBEL                                                               ; Sound bell
 S @$$TRAP^RGZOSF("ERROR^RGUTEDT")
 G AGAIN
