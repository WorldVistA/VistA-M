LRLABELD ;DALOI/JMC - ZEBRA STRIPE 1X2 label printer ; 6/4/98
 ;;5.2;LAB SERVICE;**218**;Sep 27, 1994
 ;
EN ; Print 1x2 label formats
 ;
 N ETX,LRFONT,LRFMT,LRTXT,LRX,LRZ,STX
 ;
 S LRRB=$G(LRRB)
 ;
 ; Set specific symbology.
 S LRFMT=+$G(LRBAR(+$G(LRAA)))
 ;
 ; Set up list of tests
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,30)
 ;
 D LH
 ;
 I 'LRFMT D NOBAR Q
 I LRFMT=1 D BAR1 Q
 I LRFMT>1 D BAR2
 Q
 ;
NOBAR ; Print Lab 25mm X 50mm (1 X 2) labels.
 ; Plain label, no barcode identifier.
 ; Label length = 200 dots (8 dots/mm printhead).
 ;
 W STX
 S LRFONT="^ADN,36,10"
 ;
 ; Print accession.
 D PL(0,5,LRACC,LRFONT)
 D FONT
 ;
 ; Print accession date.
 D PL(0,40,LRDAT,LRFONT)
 ;
 ; Print collection sample.
 I LRXL,N-I<LRXL S LRZ=LRTOP
 E  S LRZ=LRPREF_LRTOP
 D PL(0,60,$E(LRZ,1,17),LRFONT)
 ;
 ; Accession urgency
 I $P(LRURGA,"^",2) D
 . S LRFONT="^ADN,36,10"
 . I $P(LRURGA,"^",2)=2 D
 . . ; Set up graphic box.
 . . D GB(285,40,15+($L($P(LRURGA,"^"))*12)_",35,35")
 . . S LRFONT=LRFONT_"^FR" ; Field reverse.
 . D PL(295,45,$P(LRURGA,"^"),LRFONT)
 . D FONT
 ;
 ; Patient name
 S LRFONT="^ADN,36,10"
 D PL(40,80,$E(PNM,1,21),LRFONT),FONT
 ;
 ; Print patient identifier.
 D PL(40,115,SSN,LRFONT)
 ;
 ; Print order number.
 D PL(0,143,"Order #"_LRCE,LRFONT)
 ;
 ; Patient location/room-bed number
 D PL(200,143,"W:"_LRLLOC_$S($L(LRRB):" B:"_LRRB,1:""),LRFONT)
 ;
 ; Print test list
 S LRFONT="^ADN,36,10"
 D PL(0,161,LRTXT,LRFONT)
 D FONT
 ;
 W ETX
 Q
 ;
BAR1 ; Print Lab 25mm X 50mm (1 X 2) labels.
 ; Barcode identifier - use Code 39 with check-digit.
 ; Label length = 200 dots (8 dots/mm printhead).
 ;
 W STX
 S LRFONT="^ADN,36,10"
 ;
 ; Patient name
 D PL(75,5,$E(PNM,1,18),LRFONT)
 D FONT
 ;
 ; Accession urgency
 I $P(LRURGA,"^",2) D
 . S LRFONT="^ADN,36,10"
 . ; Set up graphic box.
 . I $P(LRURGA,"^",2)=2 D
 . . D GB(295,0,15+($L($P(LRURGA,"^"))*12)_",35,35")
 . . S LRFONT=LRFONT_"^FR" ; Field reverse.
 . D PL(305,5,$P(LRURGA,"^"),LRFONT)
 . D FONT
 ;
 ; Print patient identifier.
 D PL(75,40,SSN,LRFONT)
 ;
 ; Patient location/room-bed number
 D PL(230,40,$S($L(LRRB):"B:"_LRRB,1:"W:"_LRLLOC),LRFONT)
 ;
 ; Print barcode.
 S LRX=$S($L(LRBARID)<7:75,$L(LRBARID)>10:80,1:85)
 S LRFONT="^BY2,"_$S($L(LRBARID)<7:3,1:2)_",60^"
 S LRFONT=LRFONT_"B3N,Y,,N,N"
 D PL(LRX,60,LRBARID,LRFONT)
 ;
 ; Print order number.
 D FONT
 D PL(75,125,"Order #"_LRCE,LRFONT)
 ;
 ; Print collection sample.
 I LRXL,N-I<LRXL S LRZ=LRTOP
 E  S LRZ=LRPREF_LRTOP
 D PL(75,143,$E(LRZ,1,16),LRFONT)
 ;
 ; Print test list
 S LRFONT="^ADN,36,10"
 D PL(75,161,LRTXT,LRFONT)
 ;
 ; Print accession.
 D FONT S LRFONT="^ADN,36,10^FWB"
 D PL(0,0,$$CJ^XLFSTR(LRACC,16),LRFONT)
 ;
 ; Print accession date.
 D FONT S LRFONT=LRFONT_"^FWB"
 D PL(40,0,$$CJ^XLFSTR(LRDAT,16),LRFONT)
 ;
 W ETX
 Q
 ;
BAR2 ; Print Lab 25mm X 50mm (1 X 2) labels.
 ; Barcode identifier using specified symbology for accession area.
 ; Label length = 200 dots (8 dots/mm printhead).
 ;
 W STX
 S LRFONT="^ADN,36,10"
 ;
 ; Patient name
 D PL(0,5,$E(PNM,1,22),LRFONT),FONT
 ;
 ; Accession urgency
 I $P(LRURGA,"^",2) D
 . S LRFONT="^ADN,36,10"
 . ; Set up graphic box.
 . I $P(LRURGA,"^",2)=2 D
 . . D GB(275,0,15+($L($P(LRURGA,"^"))*12)_",35,35")
 . . S LRFONT=LRFONT_"^FR" ; Field reverse.
 . D PL(285,5,$P(LRURGA,"^"),LRFONT),FONT
 ;
 ; Print patient identifier.
 D PL(0,40,SSN,LRFONT)
 ;
 ; Patient location/room-bed number
 D PL(150,40,"W:"_LRLLOC_$S($L(LRRB):"/"_LRRB,1:""),LRFONT)
 ;
 ; Print barcode.
 S LRX=$S($L(LRBARID)<7:75,LRFMT=4:35,1:20)
 S LRFONT="^BY"_$S($L(LRBARID)>10:1,1:2)_","_$S($L(LRBARID)<7:3,1:2)_",60^"
 S LRFONT=LRFONT_$S(LRFMT=2:"B3N,N,,N,N",LRFMT=3:"B3N,Y,,N,N",LRFMT=4:"BCN,,N,N",LRFMT=5:"B4N,,N,A",1:"BCN,,N,N")
 D PL(LRX,60,LRBARID,LRFONT),FONT
 ;
 ; Print human-readable ID.
 D PL(0,125,LRBARID,LRFONT)
 ;
 ; Print infection warning if present.
 I $L(LRINFW) D
 . D GB(135,123,10+($L(LRINFW)*12)_",16,16") ; make box
 . S LRFONT=LRFONT_"^FR"
 . D PL(140,124,LRINFW,LRFONT)
 ;
 ; Print accession date.
 D PL(0,143,$P(LRDAT," "),LRFONT)
 ;
 ; Print accession.
 D PL(120,143,LRACC,LRFONT)
 ;
 ; Print order number.
 D PL(0,161,"Order #"_LRCE,LRFONT)
 ;
 ; Print collection sample.
 I LRXL,N-I<LRXL S LRZ=LRTOP
 E  S LRZ=LRPREF_LRTOP
 D PL(180,161,$E(LRZ,1,16),LRFONT)
 ;
 ; Print test list
 D PL(0,179,LRTXT,LRFONT)
 ;
 W ETX
 ;
 Q
 ;
 ;
PL(LRX,LRY,LRZ,LRFONT) ; Send print command to printer.
 ; Call with  LRX = column position (in dots).
 ;            LRY = row position (in dots).
 ;            LRZ = text to print.
 ;         LRFONT = font to use.
 ;
 W "^FO",+$G(LRX),",",+$G(LRY),$G(LRFONT),"^FD",$G(LRZ),"^FS"
 Q
 ;
 ;
GB(LRGBX,LRGBY,LRGBZ) ; Send print command to printer for graphic box.
 ; Call with LRGBX = column position (in dots).
 ;           LRGBY = row position (in dots).
 ;           LRGBZ = graphic box to print.
 ;
 W "^FO",+$G(LRGBX),",",+$G(LRGBY),"^GB",$G(LRGBZ),"^FS"
 Q
 ;
 ;
LH ; Set Label Home ("LH") parameters.
 ;
 S STX=$C(2),ETX=$C(3)
 ;
 ; Set Print Orientation ("PO") to Inverted and Label Home ("LH") parameters.
 W STX,"^POI^LH450,0",ETX
 ;
FONT ; Default font
 S LRFONT="^ADN"
 Q
