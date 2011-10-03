LRLABELC ;SLC/RAF - INTERMEC 4100 1X3 LABEL PRINT BARCODE/PLAIN ;10/20/93  10:16
 ;;5.2;LAB SERVICE;**161**;Sep 27, 1994
 ;This routine is used in conjunction with the Intermec program routine
 ;LRBARC to print a 1X3 accession label.
 ;
EN ;
 N CR,ETX,J,LF,LRFMT,LRTXT,STX,X
 S LRRB=$G(LRRB)
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,35)
 S LRFMT=7+$G(LRBAR(+$G(LRAA)),0)
 I LRFMT=7 D PRT
 I LRFMT=8 D BAR
 I LRFMT>8 D BAR1
 Q
 ;
PRT ; Plain label..no barcode
 D INIT^LRLABELA(LRFMT)
 W STX,$E(PNM,1,30),"  ",$P(SSN,"-",3),CR,ETX
 W STX,$E(LRINFW,1,20),"  ORD:",$G(LRCE),CR,ETX
 W STX,LRTXT,CR,ETX
 W STX,LRACC
 I $P(LRURGA,"^",2),$L(LRURGA,"^") W "  <",$P(LRURGA,"^"),">  "
 W " LOC:",LRLLOC,CR,ETX
 W STX,LRTOP,"  ",LRPREF,CR,ETX
 D TERM^LRLABELA
 Q
 ;
BAR ; Barcode label (old style)
 D INIT^LRLABELA(LRFMT)
 W STX,$E(PNM,1,30),"  ",$P(SSN,"-",3),CR,ETX
 W STX,$E(LRINFW,1,20),"  ORD:",$G(LRCE),CR,ETX
 W STX,LRTXT,CR,ETX
 W STX,LRACC
 I $P(LRURGA,"^",2),$L(LRURGA,"^") W "  <",$P(LRURGA,"^"),">  "
 W " LOC:",LRLLOC,CR,ETX
 W STX,$E(LRACC,1,2),CR,ETX
 W STX,LRBARID,CR,ETX
 D TERM^LRLABELA
 Q
 ;
BAR1 ; Barcode label (multiple symbologies)
 D INIT^LRLABELA(9)
 W STX,PNM,CR,SSN,CR,ETX ; Patient name/SSN
 W STX,"W:"_$E(LRLLOC,1,9),$S($L(LRRB):" B:"_LRRB,1:""),CR,ETX ; Location
 W STX,LRBARID,CR,ETX ; Human-readable ID.
 W STX,LRDAT,CR,LRACC,CR,ETX ; Date/Accession
 W STX,"Order# ",LRCE,CR,LRTOP,CR,ETX ; Order #/Tube Top
 W STX,LRTXT,CR,ETX ; Tests
 D URGENCY^LRLABELA ; Accession urgency
 W STX
 F J=9:1:11 D
 . I J'=LRFMT W LF,CR Q  ; Skip symbology
 . W LRBARID,CR ; Number to barcode.
 W ETX
 D TERM^LRLABELA
 Q
