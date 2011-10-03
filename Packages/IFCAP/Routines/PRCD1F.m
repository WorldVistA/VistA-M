PRCD1F ;WISC/PLT-SUBSTATION ENTER/EDIT ; 08/03/95  2:33 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;enter/edit substation
EN N PRCDD,PRCDR,PRCRI,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 N PRCUQ
 F  D EN^DDIOL($TR($J("",78)," ","-")) D  Q:PRCQT=1
 . S PRCDD=411,PRCQT=""
 . S PRCUQ=""
 . D LKUP Q:PRCQT
 . S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 . I 'Y D EN^DDIOL("File is in use, please try later!") QUIT
 . D EDIT
 . D DCLOCK^PRC0B(PRCLOCK)
 . QUIT
 QUIT
 ;
LKUP ;lookup prcdd=411
 S DA="",X("S")="I +Y>1000000"
 S DA="" D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQLS","Select SUBSTATION: ")
 I Y<0!(X="") S PRCQT=1 QUIT
 S DA=+Y,PRCRI(PRCDD)=+Y,PRCAED=$P(Y,"^",3)
 I PRCAED=1,DA<1000000!($P(Y,"^",2)?3N) D EN^DDIOL("Use option 'Site Parameters' to add new station.") D DELETE S PRCQT=2
 I PRCAED=1,'$D(^PRC(411,$E($P(Y,"^",2),1,3),0)) D EN^DDIOL("Use option 'Site Parameters' to set up the parent station first.") D DELETE S PRCQT=2
 QUIT
 ;
EDIT ;edit prcdd=411
 S PRCDR="[PRCD SUBSTATION]",C=PRCDR
ED1 D EDIT^PRC0B(.X,PRCDD_";;"_PRCRI(PRCDD),C) I X=0 S PRCQT=2 QUIT
 I X=-1,PRCAED=1 D  Q:PRCQT
 . D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 . I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 . D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 .QUIT
 ;require fileds check
 S C="101;"
EDA K A D PIECE^PRC0B(PRCDD_";;"_PRCRI(PRCDD),C,"I","A")
 S C="" F A=101 I $G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" S C=C_A_";"
 K A I C]"" D EN^DDIOL(" **** Missing Required Field(s) ****") S C=C_"S Y=0;"_PRCDR G ED1
 QUIT
 ;
DELETE ;delete prcdd=411
 D DELETE^PRC0B1(.X,PRCDD_";^PRC(411,;"_PRCRI(PRCDD))
 S:X=1 PRCAED=-1
 QUIT
 ;
EN1 ;print file 411
 N L,DIC,FLDS,BY,FR,TO,DHD,PRCDD
 S PRCDD=411
 S L=0,DIC=PRCDD,FLDS=".01,.1,.5,19.2"
 S BY="@.01",FR="@",TO="~"
 D EN1^DIP
 QUIT
 ;
