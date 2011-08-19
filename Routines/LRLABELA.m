LRLABELA ;DALOI/JMC - INTERMEC 4100 1X2 LABEL PRINT BARCODE/PLAIN ;10/20/93  10:16
 ;;5.2;LAB SERVICE;**161,218**;Sep 27, 1994
 ;This routine is used in conjunction with the Intermec program routine
 ;LRBARA to print a two label accession label for accession areas which
 ;have their BAR CODE PRINT field set to YES
 ;
EN ;
 N CR,ETX,J,LRFMT,LRTXT,STX,X
 S LRRB=$G(LRRB)
 ;
 ; Set specific symbology.
 S LRFMT=3+$G(LRBAR(+$G(LRAA)))
 ;
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,$S(LRFMT=4:25,1:32))
 ;
 I LRFMT=3 D PRT
 I LRFMT=4 D BAR
 I LRFMT>4 D BAR1
 ;
 D TERM
 Q
 ;
PRT ;plain label..no barcode
 ;
 D INIT(LRFMT)
 ;
 W STX,LRTXT,CR,ETX
 W STX,"Order #",LRCE,CR,"W:"_$E(LRLLOC,1,9)_" B:"_LRRB,CR,ETX
 W STX,SSN,CR,PNM,CR,LRTOP,CR,LRDAT,CR,LRACC,CR,ETX
 ;
 ; Determine if accession urgency printed normally or in reverse letters
 I $P(LRURGA,"^",2),$L($P(LRURGA,"^")) W STX,$P(LRURGA,"^"),CR,ETX
 E  W STX,$C(10),CR,ETX
 ;
 Q
 ;
BAR ;barcode label..accession number barcoded (old style)
 ;
 D INIT(LRFMT)
 ;
 W STX,LRTXT,CR,ETX
 W STX,LRTOP,CR,"Order #",LRCE,CR,LRACC,CR,LRDAT,CR,SSN,CR,ETX
 W STX,$S($L(LRRB):"B:"_LRRB,1:"W:"_$E(LRLLOC,1,9)),CR,ETX
 W STX,$E(PNM,1,27),CR,ETX
 ;
 ; Determine if accession urgency printed normally or in reverse letters
 I $G(LRURG0)=1 W STX,"STAT",CR,ETX
 E  W STX,LF,CR,ETX
 ;
 W STX,LRBARID,CR,ETX
 ;
 Q
 ;
 ;
BAR1 ; Barcode label (handles multiple barcode symbologies).
 ;
 D INIT(5)
 ;
 W STX,PNM,CR,SSN,CR,"W:"_LRLLOC,$S($L(LRRB):"/"_LRRB,1:""),CR,ETX
 ;
 ; Human-readable ID
 W STX,LRBARID,CR,ETX
 ;
 ; Patient info
 W STX,$S($G(LRINFW)="":LF,1:LRINFW),CR,ETX
 ;
 ; Order date/accession
 W STX,LRDAT,CR,LRACC,CR,ETX
 ;
 ; Order #/specimen top
 W STX,"Order #",LRCE,CR,LRTOP,CR,ETX
 ;
 ; Test list
 W STX,LRTXT,CR,ETX
 ;
 D URGENCY
 ;
 ; Bar code specimen identifier
 W STX
 F J=5:1:7 D
 . I J'=LRFMT W LF,CR Q  ; Skip symbology.
 . W LRBARID,CR
 W ETX
 ;
 Q
 ;
INIT(LRFMT) ; Initialize label
 ; Call with LRFMT = format to access on printer
 ; Called above, LRLABELB, LRLABELC, LRBLJLA1
 ;
 S STX=$C(2),ETX=$C(3),LF=$C(10),CR=$C(13)
 S X=0 X ^%ZOSF("RM")
 ;
 ; Put printer in advanced mode.
 W STX,$C(27),"C",ETX
 W STX,"R",ETX
 W STX,$C(27),"E",LRFMT,$C(24),ETX
 ;
 Q
 ;
TERM ; Terminate and print label
 ; Called above, LRLABELB, LRLABELC, LRBLJLA1
 ;
 W STX,$C(23,15),"S30",$C(12),ETX
 ;
 Q
 ;
URGENCY ; Print urgency based on settings.
 ; Called above, LRLABELB, LRLABELC
 ;
 I $P(LRURGA,"^",2),$L($P(LRURGA,"^")) D  Q
 . ; Reverse field
 . I $P(LRURGA,"^",2)=2 W STX,LF,CR,$P(LRURGA,"^"),CR,ETX Q
 . ; Normal field
 . W STX,$P(LRURGA,"^"),CR,LF,CR,ETX
 ;
 ; No urgency
 W STX,LF,CR,LF,CR,ETX
 ;
 Q
