LBRYALA ;SSI/ALA-DISPLAY GLOBAL ;[ 09/15/94  12:51 PM ]
 ;;2.5;Library;;Mar 11, 1996
ASK ;  Ask to display global or search global or edit fields
 R !!,"(S)earch, (D)isplay, or (E)dit Library globals? ",ANS:DTIME G EXIT:ANS=""
 I '$F("SsDdEe",ANS) G EXIT
 I $F("Ss",ANS) D SRC
 I $F("Dd",ANS) D BEG
 I $F("Ee",ANS) D ^LBRYALA1
 G ASK
 ;  This option is to display library globals only
BEG R !,"Enter Global: ",AGLB:DTIME Q:AGLB=""
 I $E(AGLB,1,3)'="LBR"&($E(AGLB,1,2)'="DD") G BEG
 S SGL=AGLB
 I $E(AGLB,$L(AGLB),$L(AGLB))=":" S AGLB=$E(AGLB,1,$L(AGLB)-1),SGL=""
 I $E(AGLB,$L(AGLB),$L(AGLB))="," S AGLB=$E(AGLB,$L(AGLB)-1,$L(AGLB)-1),SGL=AGLB
 S BGL="^"_AGLB_$S(AGLB'="LBRY"&(AGLB'="LBRL")&(AGLB'="LBRZ"):")",1:"")
 D ^%ZIS Q:POP  S NL=0,QF=0 W @IOF
LP S BGL=$Q(@BGL)
 I SGL="",BGL="" G BEG
 I SGL'="",BGL'[AGLB G BEG
 S NL=NL+1 I IOSL=24,((NL+1)>22) S QF=0 D  G BEG:QF
 . R !,"Press return to continue or '^' to quit: ",NS:DTIME
 . I NS'="^" S NL=1 W @IOF Q
 . S QF=1
 W !,BGL,"  ",@BGL
 G LP
EXIT K BGL,AGLB,SGL,NL,QF,NL,NS,TEX,ANS
 Q
SRC ;  Search for specific text in Library globals
 R !!,"Enter text to search for: ",TEX:DTIME
 I TEX="" Q
 R !,"Enter Global: ",AGLB:DTIME Q:AGLB=""
 I $E(AGLB,1,3)'="LBR" G BEG
 I $E(AGLB,$L(AGLB),$L(AGLB))="," S AGLB=$E(AGLB,$L(AGLB)-1,$L(AGLB)-1)
 S BGL="^"_AGLB_$S(AGLB'="LBRY"&(AGLB'="LBRL"):")",1:""),SGL=BGL
 D ^%ZIS Q:POP  S NL=0,QF=0 W @IOF
 F  S BGL=$Q(@BGL) Q:BGL=""!(BGL'[AGLB)  D  Q:QF
 . I @BGL'[TEX Q
 . S NL=NL+1 I IOSL=24,NL+1>22 S QF=0 D  Q:QF
 .. R !,"Press return to continue or '^' to quit: ",NS:DTIME
 .. I NS'="^" S NL=1 W @IOF Q
 .. S QF=1
 . W !,BGL,"  ",@BGL
 G SRC
