LRLABELE ;DALOI/JMC - Zebra Stripe 2.5x4 10 part label; 6/4/98
 ;;5.2;LAB SERVICE;**218**;Sep 27, 1994
 ;
EN ; Print 2.5x4 10 part label format
 ;
 N J,LRDTXT,LRFONT,LRFMT,LRLPNM,LRTXT,LRTUBE,LRX,LRZ,ETX,STX
 ;
 S LRLPNM=$E(PNM,1,14),LRRB=$G(LRRB)
 ;
 ; Determine collection sample text
 I LRXL,N-I<LRXL S LRTUBE=LRTOP
 E  S LRTUBE=LRPREF_LRTOP
 ;
 D LH
 ;
 ; Set specific symbology.
 S LRFMT=+$G(LRBAR(+$G(LRAA)))
 ;
 ; Setup test list
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,$S(LRFMT<2:25,1:32))
 I LRTXT[";" S LRDTXT=".............."
 E  S LRDTXT=LRTXT
 ;
 I LRFMT<2 D BAR1 Q
 I LRFMT>1 D BAR2
 ;
 Q
 ;
BAR1 ; Print 2.5x4 10 part labels.
 ; Barcode identifier - use Code 39 with check-digit.
 ; Label length = 812 dots (8 dots/mm printhead).
 ;
 W STX
 S LRFONT="^ADN,36,10^FWR"
 ;
 ; Patient name
 D PL^LRLABELD(433,90,$E(PNM,1,21),LRFONT)
 D FONT S LRFONT=LRFONT_"^FWR"
 ;
 ; Print patient identifier.
 D PL^LRLABELD(418,90,SSN,LRFONT)
 ;
 ; Patient location/room-bed number
 D PL^LRLABELD(418,260,$S($L(LRRB):"B:"_LRRB,1:"W:"_LRLLOC),LRFONT)
 ;
 ; Print barcode.
 S LRFONT="^BY2,2"
 I $L(LRBARID)<7 S LRFONT="^BY3,2,"
 S LRFONT=LRFONT_",60^B3N,Y,,N,N^FWR"
 D PL^LRLABELD(355,95,LRBARID,LRFONT)
 ;
 ; Print order number.
 D FONT S LRFONT=LRFONT_"^FWR"
 D PL^LRLABELD(330,90,"Order #"_LRCE,LRFONT)
 ;
 ; Print collection sample.
 D PL^LRLABELD(315,90,$E(LRTUBE,1,$S($G(LRURG0)=1:18,1:24)),LRFONT)
 ;
 ; Accession urgency
 I $G(LRURG0)=1 D
 . ; Set up graphic box.
 . D GB^LRLABELD(320,317,"35,63,35")
 . S LRFONT="^ADN,36,10^FWR^FR"
 . ; Print urgency
 . D PL^LRLABELD(315,322,"STAT",LRFONT)
 ;
 ; Print test list
 S LRFONT="^ADN,36,10^FWR"
 D PL^LRLABELD(280,90,LRTXT,LRFONT)
 ;
 ; Print accession.
 S LRFONT="^ADN,36,10"
 D PL^LRLABELD(280,0,$$CJ^XLFSTR(LRACC,16),LRFONT),FONT
 ;
 ; Print accession date.
 D PL^LRLABELD(280,40,$$CJ^XLFSTR(LRDAT,16),LRFONT)
 ;
 ; Print accession - 2nd 1x2.
 S LRFONT="^ADN,36,10^FWR"
 D PL^LRLABELD(433,406,LRACC,LRFONT)
 ;
 ; Print accession date - 2nd 1x2..
 D FONT S LRFONT=LRFONT_"^FWR"
 D PL^LRLABELD(418,406,LRDAT,LRFONT)
 ;
 ; Print collection sample - 2nd 1x2.
 D PL^LRLABELD(400,406,$E(LRTUBE,1,$S($G(LRURG0)=1:21,1:30)),LRFONT)
 ;
 ; Accession urgency - 2nd 1x2.
 I $G(LRURG0)=1 D
 . ; Set up graphic box.
 . D GB^LRLABELD(410,666,"35,63,35")
 . S LRFONT="^ADN,36,10^FWR^FR"
 . ; Print urgency
 . D PL^LRLABELD(405,671,"STAT",LRFONT),FONT
 ;
 ; Patient name - 2nd 1x2.
 S LRFONT="^ADN,36,10^FWR"
 D PL^LRLABELD(360,444,$E(PNM,1,21),LRFONT),FONT
 ;
 ; Print patient identifier - 2nd 1x2.
 S LRFONT=LRFONT_"^FWR"
 D PL^LRLABELD(345,444,SSN,LRFONT)
 ;
 ; Print order number - 2nd 1x2.
 D PL^LRLABELD(325,406,"Order #"_LRCE,LRFONT)
 ;
 ; Print test list - 2nd 1x2, redo test list for wider area on 2nd label
 S LRFONT="^ADN,36,10^FWR"
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,32)
 I LRTXT[";" S LRDTXT=".............."
 E  S LRDTXT=LRTXT
 D PL^LRLABELD(280,406,LRTXT,LRFONT)
 ;
 D FONT,COMMON
 W ETX
 Q
 ;
BAR2 ; Print 2.5x4 10 part labels.
 ; Barcode identifier using specified symbology for accession area.
 ; Label length = 812 dots (8 dots/mm printhead).
 ;
 W STX
 S LRFONT="^ADN,36,10^FWR"
 ;
 ; Patient name
 F LRY=0,406 D PL^LRLABELD(433,LRY,$E(PNM,1,21),LRFONT)
 ;
 ; Accession urgency
 I $P(LRURGA,"^",2) D
 . S LRFONT="^ADN,36,10^FWR"
 . I $P(LRURGA,"^",2)=2 D
 . . ; Set up graphic box.
 . . F LRY=295,699 D GB^LRLABELD(437,LRY,"35,"_(15+($L($P(LRURGA,"^"))*12))_",35")
 . . ; Field reverse.
 . . S LRFONT=LRFONT_"^FR"
 . ; Print urgency
 . F LRY=300,704 D PL^LRLABELD(433,LRY,$P(LRURGA,"^"),LRFONT)
 ;
 ; Print patient identifier.
 D FONT S LRFONT=LRFONT_"^FWR"
 F LRY=0,406 D PL^LRLABELD(418,LRY,SSN,LRFONT)
 ;
 ; Patient location/room-bed number
 F LRY=170,576 D PL^LRLABELD(418,LRY,"W:"_LRLLOC_$S($L(LRRB):"/"_LRRB,1:""),LRFONT)
 ;
 ; Print barcode.
 S LRFONT="^BY"_$S($L(LRBARID)>10:1,1:2)_","_$S($L(LRBARID)<7:3,1:2)_",60^"
 S LRFONT=LRFONT_$S(LRFMT=2:"B3N,N,,N,N",LRFMT=3:"B3N,Y,,N,N",LRFMT=4:"BCN,,N,N",1:"BCN,,N,N")
 S LRFONT=LRFONT_"^FWR"
 F LRZ=10,416 D
 . S LRY=LRZ+$S($L(LRBARID)<7:55,LRFMT=3:5,LRFMT=4:15,1:0)
 . D PL^LRLABELD(358,LRY,LRBARID,LRFONT)
 ;
 ; Print human-readable ID.
 D FONT S LRFONT=LRFONT_"^FWR"
 F LRY=0,406 D PL^LRLABELD(335,LRY,LRBARID,LRFONT)
 ;
 ; Print infection warning if present.
 I $L(LRINFW) D
 . ; Set up graphic box.
 . F LRY=140,544 D GB^LRLABELD(337,LRY,"16,"_(10+($L(LRINFW)*12))_",16,")
 . D FONT S LRFONT=LRFONT_"^FWR^FR"
 . ; Print infection warning.
 . F LRY=145,549 D PL^LRLABELD(335,LRY,LRINFW,LRFONT)
 . D FONT S LRFONT=LRFONT_"^FWR"
 ;
 ; Print accession date.
 F LRY=0,406 D PL^LRLABELD(316,LRY,$P(LRDAT," "),LRFONT)
 ;
 ; Print accession.
 F LRY=120,526 D PL^LRLABELD(316,LRY,LRACC,LRFONT)
 ;
 ; Print order number.
 F LRY=0,406 D PL^LRLABELD(298,LRY,"Order #"_LRCE,LRFONT)
 ;
 ; Print collection sample.
 F LRY=180,586 D PL^LRLABELD(298,LRY,$E(LRTUBE,1,17),LRFONT)
 ;
 ; Print test list
 F LRY=0,406 D PL^LRLABELD(280,LRY,LRTXT,LRFONT)
 D FONT,COMMON
 ;
 W ETX
 Q
 ;
COMMON ; Print lower 8 sections of label - common to both formats.
 ;
 N LRJ
 ;
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,200)
 ;
 F LRY=0,203,406,609 D
 . ; Print accession
 . S LRX=220,LRFONT="^ADN,36,10^FWR"
 . D PL^LRLABELD(LRX,LRY,LRACC,LRFONT)
 . ;
 . ; Print collection sample
 . S LRX=190 D FONT S LRFONT=LRFONT_"^FWR"
 . D PL^LRLABELD(LRX,LRY,$E(LRTUBE,1,15),LRFONT)
 . ;
 . ; Print accession
 . S LRX=130,LRFONT="^ADN,36,10^FWR"
 . D PL^LRLABELD(LRX,LRY,LRACC,LRFONT)
 . ;
 . ; Print patient name
 . S LRX=95
 . D PL^LRLABELD(LRX,LRY,LRLPNM,LRFONT)
 . ;
 . ; Print patient identifier.
 . S LRX=75 D FONT S LRFONT=LRFONT_"^FWR"
 . D PL^LRLABELD(LRX,LRY,SSN,LRFONT)
 . ;
 . ; Print collection date/time
 . S LRX=50
 . D PL^LRLABELD(LRX,LRY,LRDAT,LRFONT)
 . ;
 . ; Print test list
 . S LRX=0,LRFONT="^ADN,36,10^FWR"
 . S LRJ=$S(LRY=203:2,LRY=406:3,LRY=609:4,1:1)
 . S LRZ=$S($P(LRTXT,";",LRJ)'="":$E($P(LRTXT,";",LRJ),1,14),1:$E(LRDTXT,1,14))
 . D PL^LRLABELD(LRX,LRY,LRZ,LRFONT)
 Q
 ;
 ;
LH ; Set Label Home ("LH") parameters.
 ;
 S STX=$C(2),ETX=$C(3)
 ;
 ; Set Print Orientation ("PO") to Inverted, and Label Home ("LH") parameters.
 W STX,"^POI^LH360,13",ETX
 ;
FONT ;
 ; Default font.
 S LRFONT="^ADN"
 Q
