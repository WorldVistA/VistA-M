LRLABELG ;DALOI/JMC - 1x3 label for Zebra Stripe printer; 6/4/98
 ;;5.2;LAB SERVICE;**218**;Sep 27, 1994
 ; Print Lab labels 25mm X 76mm (1X3) labels.
 ; Label length = 200 dots.
 ;
 N LRFONT,LRZ,ETX,STX
 ;
 D LH
 W STX
 ;
 ; Print urgency
 I $P(LRURGA,"^",2) D
 . I $P(LRURGA,"^",2)=2 D
 . . ; Set up graphic box.
 . . D GB^LRLABELD(340,0,15+($L($P(LRURGA,"^"))*12)_",20,20")
 . . ; Set field reverse.
 . . S LRFONT=LRFONT_"^FR"
 . D PL^LRLABELD(350,3,$P(LRURGA,"^"),LRFONT)
 . D FONT
 ;
 ; Print infection warning if present.
 I $L($G(LRINFW)) D
 . ; Make 'big' box else make 'little' box.
 . I $L(LRINFW)>10 S LRZ=130_",40,40"
 . E  S LRZ=10+($L(LRINFW)*12)_",25,25"
 . D GB^LRLABELD(442,0,LRZ)
 . S LRFONT=LRFONT_"^FR"
 . ; Print infection warning.
 . D PL^LRLABELD(447,3,$E(LRINFW,1,10),LRFONT)
 . ; Print remainder of infection warning.
 . I $L(LRINFW)>10 D PL^LRLABELD(447,21,$E(LRINFW,11,20),LRFONT)
 . D FONT
 ;
 ; Print patient name.
 S LRFONT="^ADN,36,10"
 D PL^LRLABELD(0,0,$E(PNM,1,25),LRFONT)
 D FONT
 ;
 ; Print patient identifier.
 S LRFONT="^ADN,36,10"
 D PL^LRLABELD(0,40,SSN,LRFONT)
 D FONT
 ;
 ; Print patient location.
 D PL^LRLABELD(200,40,"Ward: "_LRLLOC,LRFONT)
 ;
 ; Print room-bed number.
 I $L(LRRB) D PL^LRLABELD(200,60," Bed: "_LRRB,LRFONT)
 ;
 ; Print accession.
 D PL^LRLABELD(0,80,LRACC,LRFONT)
 ;
 ; Print order number.
 D PL^LRLABELD(188,80,"Order #"_LRCE,LRFONT)
 ;
 ; Print Identifier.
 D PL^LRLABELD(0,100,LRUID,LRFONT)
 ;
 ; Print accession date.
 D PL^LRLABELD(188,100,LRDAT,LRFONT)
 ;
 ; Print collection sample.
 I LRXL,N-I<LRXL S X=LRTOP
 E  S X=LRPREF_LRTOP
 D PL^LRLABELD(0,120,$E(X,1,55),LRFONT)
 ;
 ; Print list of tests
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,55)
 D PL^LRLABELD(0,140,LRTXT,LRFONT)
 ;
 W ETX
 ;
 Q
 ;
 ;
LH ; Set Label Home ("LH") parameters.
 ;
 S STX=$C(2),ETX=$C(3)
 ;
 ; Set Print Orientation ("PO") to Inverted, and Label Home ("LH") parameters.
 W STX,"^POI^LH240,5",ETX
 ;
FONT ;
 ; Default font.
 S LRFONT="^ADN"
 Q
