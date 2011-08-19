LRBARC ;DALISC/JMC - INTERMEC 4100 1x3 LABEL FORMAT ;8/29/94  12:36
 ;;5.2;LAB SERVICE;**161**;Sep 27, 1994
 ;Designed for a Intermec 4100 printer.
 ;
 Q
 ; Called by LRBARCF
 ;
FMT ;
 U IO
 D INIT^LRBARA
 I LRFMT=7 D NOBAR
 I LRFMT=8 D BAR
 I LRFMT=9 D BAR1
 D TERM^LRBARA
 Q
 ;
NOBAR ; Regular labels no bar code (old style)
 W STX,"F",LRFMT,";H0;o0,570;f1;c2;d0,50;h2;w1;",ETX ; Patient name/SSN
 W STX,"F",LRFMT,";H1;o35,570;f1;c2;d0,50;h2;w1;",ETX ; Infection warning/order #
 W STX,"F",LRFMT,";H2;o70,570;f1;c2;d0,50;h2;w1;",ETX ; Test
 W STX,"F",LRFMT,";H3;o105,570;f1;c2;d0,50;h2;w1;",ETX ; Accession/urgency/location
 W STX,"F",LRFMT,";H4;o140,570;f1;c2;d0,50;h2;w1;",ETX ; Tube volume
 Q
 ;
BAR ; Bar code 39 (old style)
 W STX,"F",LRFMT,";H0;o0,570;f1;c0;d0,50;h2;w1;",ETX ; Patient/SSN
 W STX,"F",LRFMT,";H1;o30,570;f1;c0;d0,50;h2;w1;",ETX ; Infection warning
 W STX,"F",LRFMT,";H2;o60,570;f1;c0;d0,50;h2;w1;",ETX ;Test
 W STX,"F",LRFMT,";H3;o90,570;f1;c0;d0,50;h2;w1;",ETX ; Accession/urgency/location
 W STX,"F",LRFMT,";H4;o60,160;f2;c2;d0,50;h1;w2;",ETX ;Accession
 W STX,"F",LRFMT,";B5;o120,570;f1;c0,1;h40;w1;i0;d0,20;p@",ETX ; Barcode
 Q
 ;
BAR1 ; Bar code labels (multiple symbologies)
 W STX,"F",LRFMT,";H0;o0,570;f1;c2;h2;w1;d0,25;",ETX ; Patient name
 W STX,"F",LRFMT,";H1;o31,570;f1;c2;h1;w1;d0,12;",ETX ; SSN
 W STX,"F",LRFMT,";H2;o31,400;f1;c2;h1;w1;d0,15;",ETX ; Location
 W STX,"F",LRFMT,";H3;o114,555;f1;c2;h1;w1;d0,15;",ETX ; Human-readable ID
 W STX,"F",LRFMT,";H4;o133,570;f1;c2;h1;w1;d0,8;",ETX ; Date
 W STX,"F",LRFMT,";H5;o133,450;f1;c2;h1;w1;d0,20;",ETX ; Accession
 W STX,"F",LRFMT,";H6;o31,190;f1;c2;h1;w1;d0,14;",ETX ; Order #
 W STX,"F",LRFMT,";H7;o133,210;f1;c2;h1;w1;d0,15;",ETX ; Top/specimen
 W STX,"F",LRFMT,";H8;o154,570;f1;c2;h1;w1;d0,35;",ETX ; Test
 W STX,"F",LRFMT,";H9;o0,135;f1;c0;h3;w3;b0;d0,5;",ETX ; Urgency
 W STX,"F",LRFMT,";H10;o0,135;f1;c0;h3;w3;b1;d0,5;",ETX ; Urgency (reverse field)
 W STX,"F",LRFMT,";B11;o50,550;f1;c0,3;h60;i0;r2;w2;d0,10;",ETX ; Code 39
 W STX,"F",LRFMT,";B12;o50,550;f1;c0,4;h60;i0;r2;w2;d0,10;",ETX ; Code 39/check
 W STX,"F",LRFMT,";B13;o50,550;f1;c6,0,0;h60;i0;r2;w2;d0,15;",ETX ; Code 128
 Q
