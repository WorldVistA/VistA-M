LEXDD3 ; ISL Display Defaults - Display List      ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
DSPLY ; Display Defaults contained in LEXD(
 Q:'$D(LEXD(0))
 Q:$G(LEXC)[U
 N LEXI F LEXI=1:1:LEXD(0) D  Q:$G(LEXC)[U
 . W !,LEXD(LEXI) D LF Q:$G(LEXC)[U
 K LEXD,LEXI Q
LF ; Line Feed
 Q:LEXI=LEXD(0)  S LEXLC=LEXLC+1
 I IOST["P-",LEXLC>(IOSL-7) D CONT,HDR
 I IOST'["P-",LEXLC>(IOSL-4) D CONT
 Q
CONT ; Page/Form Feed
 S LEXLC=0 I IOST["P-" W @IOF Q
 W ! S DIR("?")="  Additional information is available"
 S LEXC="" N X,Y S DIR(0)="E" D ^DIR
 S:$D(DTOUT)!(X[U) LEXC=U
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT W ! Q
HDR ; Page Title
 W !,LEXITLE,!! S LEXLC=3 Q
