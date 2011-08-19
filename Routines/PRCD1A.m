PRCD1A ;WISC/PLT-DEFINE/PRINT DEFINED STANDARD DICTIONARY ; 02/16/94  11:30 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;define standard dictionary
EN N PRCDD,PRCDR,PRCRI,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . S PRCDD=420.19,PRCQT=""
 . D LKUP Q:PRCQT
 . S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 . I 'Y D EN^DDIOL("File is in use, please try later!") QUIT
 . D EDIT
 . D DCLOCK^PRC0B(PRCLOCK)
 . QUIT
 QUIT
 ;
LKUP ;lookup prcdd=420.19
 S DA="" D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQLS","Select Standard Dictionary: ")
 I Y<0!(X="") S PRCQT=1 QUIT
 S PRCRI(PRCDD)=+Y,PRCAED=$P(Y,"^",3)
 QUIT
 ;
EDIT ;edit prcdd=420.19
 S PRCDR=".01:99999999",C=PRCDR
ED1 D EDIT^PRC0B(.X,PRCDD_";;"_PRCRI(PRCDD),C) I X=0 S PRCQT=2 QUIT
 I X=-1,PRCAED=1 D  Q:PRCQT
 . D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 . I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 . D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 .QUIT
 ;require fileds check
 S C="2;3;4;5;"
EDA D PIECE^PRC0B(PRCDD_";;"_PRCRI(PRCDD),C,"I","A")
 S C="" F A=2,3,4,5 I $G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" S C=C_A_";"
 K A I C]"" D EN^DDIOL(" **** Missing Required Field(s) ****") S C=C_"S Y=0;"_PRCDR G ED1
 QUIT
 ;
DELETE ;delete prcdd=420.19
 D DELETE^PRC0B1(.X,PRCDD_";^PRCD(420.19,;"_PRCRI(PRCDD))
 S:X=1 PRCAED=-1
 QUIT
 ;
EN1 ;print defined standard dictionary
 N L,DIC,FLDS,BY,FR,TO,DHD,PRCDD
 S PRCDD=420.19
 S L=0,DIC=PRCDD,FLDS="[PRCD LIST]"
 S BY="@.01",FR="@",TO="~"
 D EN1^DIP
 QUIT
 ;
INIDIC ;initial dictionary files
 N X,Y
 S (X,Y)=""
 D YN^PRC0A(.X,.Y,"Initial Standard Dic","No")
 Q:Y=0
 F I=420.13,420.131,420.14,420.15,420.16,420.17,420.19 D
 . S X=^PRCD(I,0) K ^PRCD(I) S $P(X,"^",3,4)="",^PRCD(I,0)=X
 . QUIT
  W !,"ALL DONE!"
 QUIT
 ;
