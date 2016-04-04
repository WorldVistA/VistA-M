DIP31 ;SFISC/TKW-ASK USER QUESTIONS ABOUT HEADING ;7:19 AM  27 May 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2**
 ;
HQ N DISAVX,Y,DA,DIZ S DISAVX=X K DIR,DTOUT,DUOUT,DIRUT
 G:$D(DISUPNO)!($D(DIPCRIT)) HQ1 S DISUPNO=0,DIPCRIT=0
 I $D(DIS)>9 S DIZ(1)=$$EZBLD^DIALOG(8006),DIZ(2)=$$EZBLD^DIALOG(8038)
 E  S DIZ(1)=$$EZBLD^DIALOG(8007),DIZ(2)=$$EZBLD^DIALOG(8037)
 S DIR("A")=$$EZBLD^DIALOG(8008) D BLD^DIALOG(8005,.DIZ,"","DIR(""?"")")
 S DIR("B")=X,DIR(0)="FOU" D ^DIR K DIR G Q:$D(DIRUT)
 Q:X=""  I "SC"'[X,"CS"'[X Q
 W ! I X["S" S DISUPNO=1 D BLD^DIALOG(8010,.DIZ,"","DIR") W !,"  ",DIR
 I X["C" S DIPCRIT=1,DIZ=DIZ(2) D BLD^DIALOG(8011,DIZ,"","DIR") W !,"  ",DIR
 W !!
HQ1 D BLD^DIALOG(8009,"","","DIR(""?"")")
 S DIR("A")=$$EZBLD^DIALOG(8012),DIR("B")=DISAVX,DIR(0)="FOU^^K:X]""""&(""SC""[X!(""CS""[X)) X" D ^DIR K DIR G Q
 ;
Q S:$D(DUOUT)!($D(DTOUT)) X="^" Q
 ;DIALOG #8005  'There are two different options:'
 ;       #8006  'Number of Matches from the search'
 ;       #8007  'heading when there are no records to print'
 ;       #8008  'Heading/S/C'
 ;       #8009  'Accept default heading or enter a custom heading...'
 ;       #8010  '** Suppress the...'
 ;       #8011  '** Print...criteria in heading.'
 ;       #8012  'Heading'
 ;       #8037 'sort'
 ;       #8038  'search'
