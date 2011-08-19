LRBARA ;DALOI/JMC - INTERMEC 3000/4000 SERIES 1x2 LABEL FORMAT ;8/29/94  12:36
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
 ;
 ; This routine will program the Intermec 3000/4000 for 1X2 label formats
 ; which can be used with LRLABELA routine to print either one normal
 ; label or one with the accesion # barcoded if the BARCODE LABEL field
 ; in file 68 (Accession area) is set to YES. If this field is set to a
 ; specific symbology then a third format is utilized which will bar
 ; code either the accession or UID.
 ;
 Q
 ; Called by LRBARCF
 ;
FMT ;
 U IO
 D INIT^LRBARA
 I LRFMT=3 D NOBAR
 I LRFMT=4 D BAR
 I LRFMT=5 D BAR1
 D TERM^LRBARA
 Q
 ;
NOBAR ;programs format for plain label /no barcoded accession # (old style).
 ;
 ; Test
 W STX,"F",LRFMT,";H0;o150,390;f1;c2;h2;w1;d0,32;",ETX
 ;
 ; Order#
 W STX,"F",LRFMT,";H1;o133,390;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Location
 W STX,"F",LRFMT,";H2;o133,200;f1;c2;h1;w1;d0,12",ETX
 ;
 ; Patient identifier - SSN
 W STX,"F",LRFMT,";H3;o105,350;f1;c2;h1;w1;d0,11;",ETX
 ;
 ; Patient name
 W STX,"F",LRFMT,";H4;o75,350;f1;c2;h2;w1;d0,21;",ETX
 ;
 ; Collection sample - tube top/specimen
 W STX,"F",LRFMT,";H5;o50,390;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Date
 W STX,"F",LRFMT,";H6;o33,390;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Accession
 W STX,"F",LRFMT,";H7;o0,390;f1;c2;h2;w1;d0,21;",ETX
 ;
 ; Urgency
 W STX,"F",LRFMT,";H8;o30,155;f1;c0;h3;w3;b1;d0,4;",ETX
 ;
 Q
 ;
 ;
BAR ; Programs format 1x2 label with the accession # barcoded (old style).
 ;
 ; Tests
 W STX,"F",LRFMT,";H0;o150,310;f1;c2;h2;w1;d0,25;",ETX
 ;
 ; Collection sample - tube top/specimen
 W STX,"F",LRFMT,";H1;o133,310;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Order#
 W STX,"F",LRFMT,";H2;o116,310;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Accession
 W STX,"F",LRFMT,";H3;o160,390;f2;c2;h2;w1;d0,14;",ETX
 ;
 ; Date
 W STX,"F",LRFMT,";H4;o175,350;f2;c2;h1;w1;d0,14;",ETX
 ;
 ; SSN
 W STX,"F",LRFMT,";H5;o30,310;f1;c2;h1;w1;d0,11;",ETX
 ;
 ; Location
 W STX,"F",LRFMT,";H6;o30,150;f1;c2;h1;w1;d0,9;",ETX
 ;
 ; Patient name
 W STX,"F",LRFMT,";H7;o0,310;f1;c2;h2;w1;d0,21;",ETX
 ;
 ; Urgency
 W STX,"F",LRFMT,";H8;o115,140;f1;c0;h3;w3;b1;d0,4;",ETX
 ;
 ; Bar code
 W STX,"F",LRFMT,";B9;o50,300;f1;c0,1;h60;w2;d0,5;",ETX
 ;
 Q
 ;
BAR1 ; Programs format for 1X2 label using multiple barcode symbologies.
 ;
 ; Patient name
 W STX,"F",LRFMT,";H0;o0,380;f1;c2;h2;w1;d0,19;",ETX
 ;
 ; SSN
 W STX,"F",LRFMT,";H1;o31,380;f1;c2;h1;w1;d0,12;",ETX
 ;
 ; Location
 W STX,"F",LRFMT,";H2;o31,230;f1;c2;h1;w1;d0,15;",ETX
 ;
 ; Human-readable ID
 W STX,"F",LRFMT,";H3;o114,380;f1;c2;h1;w1;d0,15;",ETX
 ;
 ; Patient Info (Infection Warning)
 W STX,"F",LRFMT,";H4;o114,240;f1;c2;h1;w1;b1;d0,20;",ETX
 ;
 ; Date
 W STX,"F",LRFMT,";H5;o134,380;f1;c2;h1;w1;d0,8;",ETX
 ;
 ; Accession
 W STX,"F",LRFMT,";H6;o134,270;f1;c2;h1;w1;d0,20;",ETX
 ;
 ; Order #
 W STX,"F",LRFMT,";H7;o151,380;f1;c2;h1;w1;d0,14;",ETX
 ;
 ; Collection sample - tube top/specimen
 W STX,"F",LRFMT,";H8;o151,200;f1;c2;h1;w1;d0,15;",ETX
 ;
 ; Tests
 W STX,"F",LRFMT,";H9;o168,380;f1;c2;h1;w1;d0,35;",ETX
 ;
 ; Urgency - black letters on white background
 W STX,"F",LRFMT,";H10;o0,135;f1;c0;h3;w3;b0;d0,5;",ETX
 ;
 ; Urgency - white letters on black background
 W STX,"F",LRFMT,";H11;o0,135;f1;c0;h3;w3;b1;d0,5;",ETX
 ;
 ; Code 39 bar code
 W STX,"F",LRFMT,";B12;o50,355;f1;c0,3;h60;i0;r2;w2;d0,10;",ETX
 ;
 ; Code 39 with check digit bar code
 W STX,"F",LRFMT,";B13;o50,360;f1;c0,4;h60;i0;r2;w2;d0,10;",ETX
 ;
 ; Code 128 bar code
 W STX,"F",LRFMT,";B14;o50,360;f1;c6,0,0;h60;i0;r2;w2;d0,15;",ETX
 ;
 Q
 ;
INIT ; Put printer into programming mode.
 ; Called by above, LRBARB, LRBARC
 ;
 N X
 S X=0 X ^%ZOSF("RM")
 ;
 S STX=$C(2),ETX=$C(3)
 ;
 ; Put printer in advanced mode.
 W STX,$C(27),"C",ETX
 ;
 ; Set into program mode.
 W STX,$C(27),"P",ETX
 ;
 ; Erase stored format.
 W STX,"E",LRFMT,";F",LRFMT,";",ETX
 ;
 Q
 ;
TERM ; Terminate programming function, return to print mode.
 ; Called by above, LRBARB, LRBARC
 ;
 W STX,"R",ETX
 ;
 K ETX,STX
 ;
 Q
 ;
 ;
CLRFMT ; Clear all existing label formats programmmed in Intermec 4100 printer.
 ; Called by LRBARCF
 ;
 N I
 ;
 U IO
 ;
 D INIT
 ;
 F I=1:1:19 D
 . I '$D(ZTQUEUED) U IO(0) D EN^DDIOL("Erasing format F"_I,"","!")
 . U IO
 . W STX,"E",I,";",ETX ; Erase stored format.
 . H .5
 ;
 D TERM
 ;
 Q
