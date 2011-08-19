PRCD1B ;WISC/PLT-LOAD STANDARD DICTIONARY ; 02/16/94  2:12 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN N PRCDD,PRCDR,PRCRI,PRCAED,PRCQT,PRCA,PRCU,PRCX,A,B,X,Y S PRCU="^"
 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . S PRCDD=420.19,PRCQT=""
 . S X("S")="I $$STATUS^PRC0B=""A"""
 . S DA="" D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQS","Select Standard Dictionary: ")
 . I Y<0!(X="") S PRCQT=1 QUIT
 . K X
 . S PRCRI(420.19)=+Y
 . D PIECE^PRC0B("420.19;;"_PRCRI(420.19),"1;3;5","I","A")
 . S PRCDD=$G(A(420.19,PRCRI(420.19),3,"I")),PRCA=$G(A(420.19,PRCRI(420.19),1,"I"))
 . S PRCX=$G(A(420.19,PRCRI(420.19),5,"I")) K A
 . Q:PRCDD=""
 . F  D EN^DDIOL(" ") D  Q:PRCQT=1
 .. S PRCQT=""
 .. D LKUP Q:PRCQT
 .. S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 .. I 'Y D EN^DDIOL("File is in use, please try later!") QUIT
 .. D EDIT
 .. D DCLOCK^PRC0B(PRCLOCK)
 .. QUIT
 . QUIT
 QUIT
 ;
LKUP ;lookup prcdd
 S X("W")="W:$X<30 ?30,$P(^(0),U,2)"
 S DA="" D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQLS","Select "_PRCA_": ")
 I Y<0!(X="") S PRCQT=1 QUIT
 S PRCRI(PRCDD)=+Y,PRCAED=$P(Y,"^",3) K X
 QUIT
 ;
EDIT ;edit prcdd
 S PRCDR=".01;1;2;" S:$P(PRCX,PRCU)="Y" PRCDR=PRCDR_"3;" S PRCDR=PRCDR_"4:9999",C=PRCDR
ED1 D EDIT^PRC0B(.X,PRCDD_";;"_PRCRI(PRCDD),C) I X=0 S PRCQT=2 QUIT
 I X=-1,PRCAED=1 D  Q:PRCQT
 . D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 . I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 . D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 .QUIT
 ;require fileds check
 S C="1;2;"
EDA D PIECE^PRC0B(PRCDD_";;"_PRCRI(PRCDD),C,"I","A")
 S C="" F A=1,2 I $G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" S C=C_A_";"
 K A I C]"" D EN^DDIOL(" **** Missing Required Field(s) ****") S C=C_"S Y=0;"_PRCDR G ED1
 QUIT
 ;
DELETE ;delete prcdd
 D DELETE^PRC0B1(.X,PRCDD_";^PRCD("_PRCDD_",;"_PRCRI(PRCDD))
 S:X=1 PRCAED=-1
 QUIT
 ;
EN1 ;standard dictionary list
 N PRCDD,PRCRI,PRCAED,PRCQT,PRCA,PRCU,PRCX,A,B,X,Y
 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . S PRCDD=420.19,PRCQT=""
 . D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQS","Select Standard Dictionary: ")
 . I Y<0!(X="") S PRCQT=1 QUIT
 . S PRCRI(420.19)=+Y
 . D PIECE^PRC0B("420.19;;"_PRCRI(420.19),".01;1;3","I","A")
 . S PRCDD=$G(A(420.19,PRCRI(420.19),3,"I")),PRCA=$G(A(420.19,PRCRI(420.19),.01,"I"))_"-"_$G(A(420.19,PRCRI(420.19),1,"I"))
 . K A
 . Q:PRCDD=""
 . D EN1A(PRCDD,PRCA)
 . QUIT
 QUIT
 ;
 ;start printing
EN1A(PRCDD,PRCA) N L,DIC,FLDS,BY,FR,TO,DHD
 S DIC=PRCDD,DHD=$G(PRCA)_" List" K:DHD="" DHD
 S L=0,FLDS="[PRC SD PRINT]"
 S BY="@.01",FR="@",TO="~"
 D EN1^DIP
 QUIT
 ;
