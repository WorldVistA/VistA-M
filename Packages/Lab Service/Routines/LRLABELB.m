LRLABELB ;DALOI/JMC - 10 PART LABELS FOR THE INTERMEC 3000/4000 PRINTER ;8/29/94 12:36
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
 ;This routine is used in conjunction with the Intermec program routine
 ;LRBARB to print a ten part 2.5X4.0 inch label.
 ;
 N CR,ETX,J,LF,LRFMT,LRLPNM,LRTXT,STX,X
 ;
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,32)
 I LRTXT[";" S LRDTXT=".............."
 E  S LRDTXT=LRTXT
 ;
 S LRLPNM=$P(PNM,",",1),LRLPNM=LRLPNM_$S($L(LRLPNM)<18:","_$E($P(PNM,",",2),1),1:"")
 ;
 S LRFMT=11+$G(LRBAR(+$G(LRAA))) ; Set specific symbology.
 I LRFMT<13 D BAR
 I LRFMT>12 D BAR1
 ;
 D TERM^LRLABELA
 ;
 Q
 ;
BAR ; Barcode label - accession number barcoded (old style).
 ;
 D INIT^LRLABELA(12)
 ;
 W STX,LRACC,CR,LRDAT,CR,LRTOP,CR,$E(PNM,1,27),CR,SSN,CR,ETX
 W STX,"W:",$E(LRLLOC,1,9),CR,ETX
 W STX,LRBARID,CR,ETX
 W STX,"Order #",LRCE,CR,$E(LRTXT,1,20) W:$L(LRTXT)>20 "..." W CR,ETX
 ;
 ; accession urgency
 I $G(LRURG0)=1 W STX,"STAT",CR,ETX
 E  W STX,LF,CR,ETX
 ;
 W STX,LRACC,CR,LRTOP,CR,LRACC,CR,LRLPNM,CR,SSN,CR,LRDAT,CR,$S($P(LRTXT,";",1)'="":$P(LRTXT,";",1),1:LRDTXT),CR,ETX
 W STX,LRACC,CR,LRTOP,CR,LRACC,CR,LRLPNM,CR,SSN,CR,LRDAT,CR,$S($P(LRTXT,";",2)'="":$P(LRTXT,";",2),1:LRDTXT),CR,ETX
 W STX,LRACC,CR,LRDAT,CR,LRTOP,CR,$E(PNM,1,27),CR,SSN,CR,"W:",$E(LRLLOC,1,9),CR,ETX
 W STX,"Order #",LRCE,CR,LRTXT,CR,ETX
 ;
 ; accession urgency
 I $P(LRURGA,"^",2),$L($P(LRURGA,"^")) W STX,$P(LRURGA,"^"),CR,ETX
 E  W STX,LF,CR,ETX
 ;
 W STX,LRACC,CR,LRTOP,CR,LRACC,CR,LRLPNM,CR,SSN,CR,LRDAT,CR,$S($P(LRTXT,";",1)'="":$P(LRTXT,";",1),1:LRDTXT),CR,ETX
 W STX,LRACC,CR,LRTOP,CR,LRACC,CR,LRLPNM,CR,SSN,CR,LRDAT,CR,$S($P(LRTXT,";",2)'="":$P(LRTXT,";",2),1:LRDTXT),CR,ETX
 ;
 Q
 ;
BAR1 ; Barcode label (handles multiple symbologies/ specimen UID).
 ;
 D INIT^LRLABELA(13)
 ;
 W STX,LRACC,CR,LRDAT,CR,LRTOP,CR,$E(PNM,1,21),CR,SSN,CR,ETX
 ;
 ; Patient location/room bed
 W STX,"W:",LRLLOC,$S($L(LRRB):"/"_LRRB,1:""),CR,ETX
 ;
 ; Human-readable ID
 W STX,LRBARID,CR,ETX
 ;
 ; Patient info
 W STX,$S($G(LRINFW)="":LF,1:LRINFW),CR,ETX
 W STX,"Order #",LRCE,CR,LRTXT,CR,ETX
 ;
 D URGENCY^LRLABELA
 ;
 W STX,LRACC,CR,LRDAT,CR,LRACC,CR,$E(PNM,1,14),CR,SSN,CR,LRDAT,CR,ETX
 W STX,$S($P(LRTXT,";",1)'="":$E($P(LRTXT,";",1),1,10),1:$E(LRDTXT,1,10)),CR,ETX
 W STX,LRACC,CR,LRDAT,CR,LRACC,CR,$E(PNM,1,14),CR,SSN,CR,LRDAT,CR,ETX
 W STX,$S($P(LRTXT,";",2)'="":$P(LRTXT,";",2),1:LRDTXT),CR,ETX
 W STX,$E(PNM,1,21),CR,SSN,CR,ETX
 ;
 ; Patient location/room bed
 W STX,"W:",LRLLOC,$S($L(LRRB):"/"_LRRB,1:""),CR,ETX
 ;
 ; Human-readable ID
 W STX,LRBARID,CR,ETX
 ;
 ; Patient info
 W STX,$S($G(LRINFW)="":LF,1:LRINFW),CR,ETX
 ;
 W STX,LRTOP,CR,LRACC,CR,LRDAT,CR,"Order #",LRCE,CR,LRTXT,CR,ETX
 ;
 D URGENCY^LRLABELA
 ;
 W STX,LRACC,CR,LRDAT,CR,LRACC,CR,$E(PNM,1,14),CR,SSN,CR,LRDAT,CR,ETX
 W STX,$S($P(LRTXT,";",3)'="":$P(LRTXT,";",3),1:LRDTXT),CR,ETX
 W STX,LRACC,CR,LRDAT,CR,LRACC,CR,$E(PNM,1,14),CR,SSN,CR,LRDAT,CR,ETX
 W STX,$S($P(LRTXT,";",4)'="":$P(LRTXT,";",4),1:LRDTXT),CR,ETX
 ;
 ; Print appropriate barcode symbology
 W STX
 F J=13:1:15 D
 . ; Skip symbology
 . I J'=LRFMT W LF,CR,LF,CR Q
 . ; specimen identifier to barcode on left label.
 . W LRBARID,CR
 . ; specimen identifier to barcode on right label.
 . W LRBARID,CR
 W ETX
 ;
 Q
