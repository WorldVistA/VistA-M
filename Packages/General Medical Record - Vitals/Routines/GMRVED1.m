GMRVED1 ;HIRMFO/RM,YH-VITAL SIGNS EDIT SHORT FORM (cont.) ;3/14/99  15:11
 ;;4.0;Vitals/Measurements;**1,6,7,11**;Apr 25, 1997
EN2 ; ENTRY FROM GMRVED0 TO ENTER THE DATA FOR A PATIENT DEFINED BY DFN
 D DSPOV^GMRVED4 I GMRSTR(0)=";" W:GMRENTY<5 !,$C(7) Q
CHANGE S (GMRHELP,GMRPRMT,GMRHELP(1),GREASON)="" F GMRX=2:1:$L(GMRSTR(0),";")-1 D SETPRMT^GMRVED2
 S GMRPRMT=GMRPRMT_": ",GMRSTAR=0
ASK ;
 Q:GMROUT  S GLINE=0 W:$L(GMRSTR,";")>2 !,"To omit entering a vital/measurement reading:",!,"Enter 'N' or 'n' for the value when NOT documenting a reason for omission." S GLINE=$G(GLINE)+1 D CHECK^GMRVUT1
 W !,"Enter an * for the specific value when documenting the reason for omission.",! S GLINE=GLINE+1 D CHECK^GMRVUT1
 W "Enter a single * to document that all measurements were omitted and the",!,"reason for omission." S GLINE=GLINE+2 D CHECK^GMRVUT1 W !!,GMRPRMT  S GLINE=GLINE+1 R GMRDAT:DTIME
 S:'$T GMRTO=1 I GMRDAT="^"!'$T S GMROUT=1 Q
 K GMRSITE
 I GMRDAT="" W !!,$C(7),"NO DATA ENTERED",! S GMROUT=1 Q
 I GMRDAT["*" S GREASON=$$EN2^GMRVED6(GREASON)
 Q:GMROUT  I GMRDAT="*" G STAR
 I GMRENTY'=21,($E(GMRDAT,1)["-")!(GMRDAT?.E1"--") W !!,$C(7),"ERRONEOUS ENTRY",! G ASK
 F GMRX=2:1:$L(GMRSTR(0),";")-1 D CHKSTR Q:GMROUT
 I GMROUT S GMROUT=0 G ASK
 F GMRX=2:1:$L(GMRSTR(0),";")-1 D CHKDAT Q:GMROUT
STAR Q:GMROUT!(+$G(GMROUT(1)))
 W ! S GMRDAT(0)=0 F GMRY=2:1:$L(GMRSTR(0),";")-1 S GMRX=$P(GMRSTR(0),";",GMRY) D
 . I GMRDAT="*" S GMRDAT(GMRX)=GREASON
 . I $D(GMRDAT(GMRX)),GMRDAT(GMRX)'="" S GMRDAT(0)=1 D WOK
ASK1 ;
 I 'GMRDAT(0) W !,$C(7),"NO DATA ENTERED",! S GMROUT=1 Q
 W !,"Is this correct? YES// " R GMRX:DTIME
 S:'$T GMRTO=1 I GMRX="^"!'$T S GMROUT=1 W !,$C(7),"DATA DELETED",! Q
 I GMRX?1"N".E!(GMRX?1"n".E) K:$D(GMRSITE("BP"))&($D(GMRQUAL("BP"))) GBP(GMRSITE("BP")_"/"_GMRQUAL("BP")) W ! G ASK
 I GMRX=""!(GMRX?1"Y".E)!(GMRX?1"y".E) G AR1
 W !,"ANSWER YES OR NO",*7 G ASK1
AR1 W !
 Q
CHKSTR ; CHECK THE INPUT STRING TO SEE IF IT IS VALID
 S GMRY=$P(GMRSTR(0),";",GMRX)
 S GMRY(1)=$S(GMRY="T":1,GMRY="P"!(GMRY="R"):2,GMRY="BP":3,GMRY="HT":4,GMRY="WT":5,GMRY="CG":6,GMRY="CVP":7,GMRY="PO2":8,GMRY="PN":9,1:0) Q:GMRY(1)'>0
 I GMRENTY=21,GMRDAT="*" S GMRDAT=GREASON Q
 I $P(GMRDAT,"-",GMRX-1)="*" S $P(GMRDAT,"-",GMRX-1)=GREASON Q
 I GMRENTY=21,GMRDAT="" Q
 I $P(GMRDAT,"-",GMRX-1)="" Q
 S GMRSCR=$S(GMRENTY=21:"GMRDAT'?",1:"$P(GMRDAT,""-"",GMRX-1)'?")
 N GMRVOK S GMRVOK=$S(GMRENTY=21:$E(GMRDAT,1),1:$E($P(GMRDAT,"-",GMRX-1),1)) I GMRVOK'="N",(GMRVOK'="n"),(GMRVOK'?1N),(GMRVOK'="?"),(GMRVOK'="*") D WRT S GMROUT=1 Q
 I GMRY="PN" D  Q
 . S GMRSCR=GMRSCR_"0.2N0.1A!(GMRDAT?1""?"".E)"
 . I @GMRSCR D WRT S GMROUT=1
 S GMRSCR=GMRSCR_$P("0.3N0.1"".""0.2N0.NA^0.3N0.NA^0.3N0.1""/""0.3N0.1""/""0.3N0.1A^0.3N0.3AP0.3N0.1"".""0.2N0.3AP0.1"";""0.NA^0.3N0.1"".""0.2N1.NA^0.3N0.1"".""0.2N0.1A^0.1""-""0.3N0.1"".""0.1N0.1A^0.3N0.1A","^",GMRY(1))_"!(GMRDAT?1""?"".E)"
 I @GMRSCR D WRT S GMROUT=1 Q
 Q
WRT ;
 W @IOF D @GMRHELP(1) W !,$C(7),$S(GMRDAT'?1"?".E:"Invalid data format, t",1:"T")_"he entry should be in the following format:",!,?5,GMRHELP
 Q
WOK ;
 I (GMRX'="CVP"&(GMRX'="PN")&(GMRDAT(GMRX)'>0)) D  Q
 . W !,?2,$S(GMRX="BP":"B/P",GMRX="P":"Pulse",GMRX="R":"Resp.",GMRX="T":"Temp.",GMRX="HT":"Ht.",GMRX="CG":"Circumference/Girth",GMRX="WT":"Wt.",GMRX="PO2":"Pulse Ox.",GMRX="PN":"Pain",1:GMRX)_": "_GMRDAT(GMRX)
 . I $G(GMRSITE(GMRX))["DORSALIS PEDIS",(GMRDAT(GMRX)'>0) W "*"
 . W $S($G(GMRSITE(GMRX))'="":" "_$P($G(GMRSITE(GMRX)),"^"),1:"")
 . I $D(GMRINF(GMRX)) S I=0 F  S I=$O(GMRINF(GMRX,I)) Q:I'>0  S I(1)="" F  S I(1)=$O(GMRINF(GMRX,I,I(1))) Q:I(1)=""  W "  "_I(1)
 . Q
 I GMRX="CVP",'(GMRDAT(GMRX)>0!(GMRDAT(GMRX)<0)!($E(GMRDAT(GMRX))="0")) W !,?2,GMRX_": "_GMRDAT(GMRX) Q
 S GMRVX=GMRX S GMRVX(0)=$S(GMRX="B"!(GMRX="BP"):$P(GMRDAT(GMRX),"^"),1:+$P(GMRDAT(GMRX),"^")) D EN1^GMRVSAS0
 I GMRX="P",$G(GMRSITE(GMRX))["DORSALIS PEDIS",GMRDAT(GMRX)=1 S GMRVX(1)=""
 W !,?2,$S(GMRX="BP":"B/P",GMRX="P":"Pulse",GMRX="R":"Resp.",GMRX="T":"Temp.",GMRX="HT":"Ht.",GMRX="CG":"Circumference/Girth",GMRX="WT":"Wt.",GMRX="PO2":"Pulse Ox.",GMRX="PN":"Pain",1:GMRX)_": "
 W $S(GMRX="BP"!(GMRX="P")!(GMRX="R"):GMRDAT(GMRX),1:"")
 I GMRX="PN" D
 . I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(GMRDAT(GMRX)) W GMRDAT(GMRX) Q
 . I GMRDAT(GMRX)=0 W GMRDAT(GMRX)_" No pain" Q
 . I GMRDAT(GMRX)=99 W GMRDAT(GMRX)_" Unable to respond" Q
 . I GMRDAT(GMRX)=10 W GMRDAT(GMRX)_" - Worst imaginable pain" Q
 . W GMRDAT(GMRX) Q
 I GMRX="T" W GMRVX(0)_" F  ("_$J(+GMRVX(0)-32*5/9,0,1)_" C)"
 I GMRX="WT" W GMRVX(0)_" LB  ("_$J(GMRVX(0)/2.2,0,2)_" KG)"
 I GMRX="HT" W $S(GMRVX(0)\12:GMRVX(0)\12_" FT ",1:"")_$S(GMRVX(0)#12:GMRVX(0)#12_" IN",1:"")_" ("_$J(GMRVX(0)*2.54,0,2)_" CM)"
 I GMRX="CG" W GMRVX(0)_" IN ("_$J(+GMRVX(0)/.3937,0,2)_" CM)"
 I GMRX="CVP" W GMRVX(0)_" cmH2O ("_$J(GMRVX(0)/1.36,0,1)_" mmHg)"
 I GMRX="PO2" W GMRVX(0)_"%"_$S(GMRO2(GMRX)'="":" with supplemental O2 "_$S(GMRO2(GMRX)["l/min":$P(GMRO2(GMRX)," l/min")_"L/min",1:"")_$S(GMRO2(GMRX)["l/min":$P(GMRO2(GMRX)," l/min",2),1:GMRO2(GMRX)),1:"")
 W $S('$D(GMRVX(1)):"",'GMRVX(1):"",1:"*") K GMRVX S GTXT=""
 W:$G(GMRSITE(GMRX))'=""&(GMRX="PO2") !,?20," via" W " "_$P($G(GMRSITE(GMRX)),"^")
 I $D(GMRINF(GMRX)) S I=0 F  S I=$O(GMRINF(GMRX,I)) Q:I'>0  S I(1)="" F  S I(1)=$O(GMRINF(GMRX,I,I(1))) Q:I(1)=""  W "  "_I(1)
 Q
CHKDAT ;
 D CHKDAT^GMRVED3
 Q
