DIALOGZ ;GFT/GFT - CREATE AND USE FOREIGN-LANGUAGE ADDITIONS TO THE DATA DICTIONARY ; 16NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;FOREIGN-LANGUAGE UTILITES
 ;
 D LANG($G(DUZ("LANG"),1)) Q
 ;
ENGLISH ;
 N LANG D LANG(1) Q
GERMAN ;
 N LANG D LANG(2) Q
SPANISH ;
 N LANG D LANG(3) Q
FINNISH ;
 N LANG D LANG(5) Q
PORTUG ;
 N LANG D LANG(7) Q
ARABIC ;
 N LANG D LANG(10) Q
 ;
LANG(LANG) ;
 N DIC,DIR,DIAL,Y,DLAYGO,DIF,DIE,DSTART,DIALFILE,DA,DR,DIALDD,DUOUT
 S U="^",DIAL=$P(^DI(.85,LANG,0),U)
 D D^DICRW Q:Y<1
FILE S (DIALFILE,DSTART)=+Y,DIF=$P(Y,U,2) I $D(^DIC(DIALFILE,"ALANG",LANG,0)) S DIR("B")=^(0)
 D DIR(60) I X="@"!'$D(DUOUT)  D
 .I $D(DIR("B")) K ^DIC("ALANG"_LANG,DIR("B"),DIALFILE)
 .I Y="" K ^DIC(DIALFILE,"ALANG",LANG) W "  <DELETED!>" Q
 .S ^DIC("ALANG"_LANG,Y,DIALFILE)="",^DIC(DIALFILE,"ALANG",LANG,0)=Y
 K DIR
FIELDS F  D  Q:'$D(DSTART)
 .S DIC="^DD(DIALFILE,",DIC(0)="AEQM"
 .D DICW(DIALFILE)
 .W !! D ^DIC I Y<0 D  Q
 ..I DIALFILE=DSTART K DSTART Q
 ..S DIALFILE=DSTART
 .K DIR,DUOUT S DIALDD=+Y,DIF=$P(Y,U,2)
 .I $D(^DD(DIALFILE,DIALDD,.008,LANG,0)) S DIR("B")=^(0)
 .D DIR(60) K DIR I X="@"!'$D(DUOUT) D
 ..S ^DD(DIALFILE,DIALDD,.008,LANG,0)=Y
 ..I Y="" K ^(0) W "  <DELETED!>"
 .S Y=+$P(^DD(DIALFILE,DIALDD,0),U,2) I Y,$D(^DD(Y,.01,0)),$P(^(0),U,2)'["W" S DIALFILE=Y Q  ;GO DOWN INTO MULTIPLE
HLP .D:$G(^DD(DIALFILE,DIALDD,3))]""  Q:$D(DUOUT)
 ..W !!,"Current ",DIF," Field Help " S DIF="Prompt" W DIF,": "
 ..W:$X+$L(^(3))>75 !?2 W ^(3) D
 ...N DUZ S DUZ("LANG")=LANG I $D(^(.009,LANG,0)) S DIR("B")=^(0)
 ..D DIR(240) Q:X'="@"&$D(DUOUT)
 ..K DIR S ^DD(DIALFILE,DIALDD,.009,LANG,0)=Y
 ..I Y="" K ^(0) W "  <DELETED!>"
SET .D:$P(^DD(DIALFILE,DIALDD,0),U,2)["S"
 ..N SET
 ..S SET=$$SL($P(^(0),U,3)),DIF="SET values"
 ..W !!,"Current ",DIF,": " W:$X+$L(SET)>75 !?2 W SET
 ..I $D(^(.007,LANG,0)) S DIR("B")=^(0)
 ..S DIR("?")="YOU MUST ENTER "_$L($$SL(SET),";")_" EXTERNAL VALUES, SEPARATED BY SEMICOLONS(;)"
 ..D DIR("240^S X=$$SL^DIALOGZ(X) K:$L(X,"";"")-$L(SET,"";"")!(X["":"") X") Q:X'="@"&$D(DUOUT)
 ..K DIR S ^DD(DIALFILE,DIALDD,.007,LANG,0)=Y
 ..I Y="" K ^(0) W "  <DELETED!>"
 W !!! Q
 ;
SL(S) ;
 I S?.E1";" S S=$E(S,1,$L(S)-1)
 Q S
 ;
 ;
DIR(LN) S DIR("A")=DIAL_" translation of "_DIF,DIR(0)="FO^2:"_LN
 K DUOUT G ^DIR
 ;
FILENAME(FILE) ;
 N N,F
 I 'FILE Q "FIELD"
 I $D(^DIC(FILE,0))#2 D  Q F
 .S F=$P(^(0),"^")
 .I $G(DUZ("LANG")),$D(^("ALANG",DUZ("LANG"),0))#2 S F=^(0)
 S N=$G(^DD(FILE,0,"UP")) I N S F=$O(^DD(N,"SB",FILE,0)) I F Q $$LABEL(N,F)
 Q ""
 ;
 ;
LABEL(FILE,FIELD) ;Called many places to return the foreign-language FIELD NAME
 N N
 S N=$P($G(^DD(FILE,FIELD,0)),"^") I N="" Q N
 I $P(^(0),"^",2)["W",$G(^DD(FILE,0,"UP")) Q $$LABEL(^("UP"),$O(^DD(^("UP"),"SB",FILE,0)))
 I $G(DUZ("LANG")),$D(^(.008,DUZ("LANG"),0))#2 Q ^(0)
 Q N
 ;
HELP(FILE,FIELD) ;
 G 3:FILE<2!'$G(DUZ("LANG")),3:$G(^DD(FILE,FIELD,3))'?.P&(DUZ("LANG")'>1)
 I $D(^DD(FILE,FIELD,.009,DUZ("LANG"),0))#2 Q ^(0)
 N Y,DICATT5,DICATT2,P
 S DICATT2=$P(^DD(FILE,FIELD,0),U,2),DICATT5=$P(^(0),U,5,999)
 I DICATT2["D" D
 .D EARLY^DICATTD1 S:$D(Y) P(1)=Y D LATEST^DICATTD1 S:$D(Y) P(2)=Y
 .K Y I $D(P(1)) S Y=$$EZBLD^DIALOG($S($D(P(2)):9114,1:9114.01),.P)
 I DICATT2["N" D
 .S P(1)=+$P(DICATT5,"X<",2)
 .S P(2)=+$P(DICATT5,"X>",2)
 .S P(3)=$P(DICATT5,"1"".""",2)-1 I P(3)<0 S P(3)=0 S:DICATT5["""$""" P(3)=2
 .S Y=$$EZBLD^DIALOG($S(DICATT5["""$""":9118.1,1:9118),.P)
 I DICATT2["F" D
 .S P(1)=+$P(DICATT5,"$L(X)<",2) I P(1) S P(2)=+$P(DICATT5,"$L(X)>",2) I P(2) S Y=$$EZBLD^DIALOG($S(P(1)=P(2):9119.1,1:9119),.P)
 I $D(Y) S ^DD(FILE,FIELD,.009,DUZ("LANG"),0)=Y
 I $G(Y)]"" Q Y
3 Q $G(^DD(FILE,FIELD,3))
 ;
DICW(FILE) ;
 S DIC("W")="N % S %=$P(^(0),U,2)" ;**CCO/NI + NEXT 2 LINES  WRITE OUT FIELD NAME IN 2 LANGUAGES
 I $G(DUZ("LANG"))>1 S DIC("W")=DIC("W")_" W:$D(^(.008,DUZ(""LANG""),0)) ?37,$$LABEL^DIALOGZ("_FILE_",+Y)"
 S DIC("W")=DIC("W")_" W:% $P(""  (multiple)^  (word-processing)"",U,$P($G(^DD(+%,.01,0)),U,2)[""W""+1)"
 Q
 ;
 ;
SETIN() ;NAKED REFERENCE  Builds the SET STRING user sees, with  1,2,3...
 N C,P
 S C=$P(^(0),U,3)
 I $D(^(.007,DUZ("LANG"),0)) D
 .S C=^(0) F P=1:1:$L(C,";") S $P(C,";",P)=P_":"_$P(C,";",P)
 E  D
 .N TRY,OUT,O
 .S TRY="" F P=1:1 Q:$P(C,";",P)=""  S O=$P($P(C,";",P),":",2),OUT=$$YESORNO(O),TRY=TRY_P_":"_OUT_";" I OUT=O K TRY Q
 .I $D(TRY) S C=TRY
 Q C
 ;
SETOUT() ;NAKED REFERENCE    Builds the SET STRING that converts INTERNAL to user's EXTERNAL
 N P,V,C
 S C=$P(^(0),U,3)
 I $D(^(.007,DUZ("LANG"),0)) D
 .F P=1:1:$L(^(0),";") S V=$P(C,";",P),$P(V,":",2)=$P(^(0),";",P),$P(C,";",P)=V
 E  F P=1:1:$L(C,";") S V=$P(C,";",P),$P(V,":",2)=$$YESORNO($P(V,":",2)),$P(C,";",P)=V
 Q C
 ;
YESORNO(Y) ;TRY TO TURN YES OR NO INTO 'SI', WHATEVER
 Q:'$G(DUZ("LANG")) Y
 I $$UP^DILIBF(Y)="YES",$D(^DI(.84,7001,4,DUZ("LANG"),1,1,0)) Q $P(^(0),U)
 I $$UP^DILIBF(Y)="NO",$D(^DI(.84,7001,4,DUZ("LANG"),1,1,0)) Q $P(^(0),U,2)
 Q Y
 ;
