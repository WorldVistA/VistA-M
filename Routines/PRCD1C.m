PRCD1C ;WISC/PLT-FUND ENTER/EDIT ; 02/08/94  12:06 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;enter/edit fund
EN N PRCDD,PRCDR,PRCRI,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 N PRCUQ,PRCK,PRCK01,PRCK2,PRCK3
 F  D EN^DDIOL($TR($J("",78)," ","-")) D  Q:PRCQT=1
 . S PRCDD=420.14,PRCQT=""
 . S (PRCUQ,PRCK01,PRCK2,PRCK3)=""
 . D LKUP Q:PRCQT
 . S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 . I 'Y D EN^DDIOL("File is in use, please try later!") QUIT
 . D:PRCAED'=1 KEY
 . D EDIT
 . D DCLOCK^PRC0B(PRCLOCK)
 . QUIT
 QUIT
 ;
LKUP ;lookup prcdd=420.14
 S DA="" D LOOKUP^PRC0B(.X,.Y,PRCDD,"AEMOQLS","Select Fund: ")
 I Y<0!(X="") S PRCQT=1 QUIT
 S DA=+Y,PRCRI(PRCDD)=+Y,PRCAED=$P(Y,"^",3)
 QUIT
 ;
EDIT ;edit prcdd=420.14
 S PRCDR=".01:99999999",C=PRCDR
ED1 D EDIT^PRC0B(.X,PRCDD_";;"_PRCRI(PRCDD),C) I X=0 S PRCQT=2 QUIT
 I X=-1,PRCAED=1 D  Q:PRCQT
 . D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 . I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 . D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 .QUIT
 ;require fileds check
 S C="1;2;3;4.5;5;"
EDA K A D PIECE^PRC0B(PRCDD_";;"_PRCRI(PRCDD),C,"I","A")
 S C="" F A=2,3,4.5,5 I $G(A(PRCDD,PRCRI(PRCDD),A,"I"))="" S C=C_A_";"
 K A I C]"" D EN^DDIOL(" **** Missing Required Field(s) ****") S C=C_"S Y=0;"_PRCDR G ED1
 QUIT
 ;
DELETE ;delete prcdd=420.14
 D DELETE^PRC0B1(.X,PRCDD_";^PRCD(420.14,;"_PRCRI(PRCDD))
 S:X=1 PRCAED=-1
 QUIT
 ;
KEY ;initial key values
 N A
 S A=$G(^PRCD(420.14,DA,0))
 S PRCK01=$P(A,"^",1),PRCK2=$P(A,"^",3),PRCK3=$P(A,"^",4)
 QUIT
 ;
 ;called from file 420.14 input transform for unique check
UNQCHK(PRCK01,PRCK2,PRCK3) ;check uniqueness from ^dd(420.14)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK2)_""","""_$G(PRCK3)_""","
 I PRCK'[",""""," S @("PRCUQ=$O(^PRCD(420.14,""UNQ"""_PRCK_"0))") I PRCUQ,PRCUQ-DA D UNQMES K X
 QUIT
 ;
UNQCRS ;set unique cross reference called from ^dd(420.14)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK2)_""","""_$G(PRCK3)_""","
 I PRCK'[",""""," S @("^PRCD(420.14,""UNQ"""_PRCK_"DA)=""""")
 QUIT
 ;
UNQCRK ;kill unique cross reference called from ^dd(420.14)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK2)_""","""_$G(PRCK3)_""","
 I PRCK'[",""""," K @("^PRCD(420.14,""UNQ"""_PRCK_"DA)")
 QUIT
 ;
 ;
UNQMES D EN^DDIOL(" NOT UNIQUE for fund, beginning fiscal year, or ending fiscal year!")
 QUIT
 ;
EN1 ;print fund
 N L,DIC,FLDS,BY,FR,TO,DHD,PRCDD
 S PRCDD=420.14
 S L=0,DIC=PRCDD,FLDS="[PRCD FUND]"
 S BY="@.01",FR="@",TO="~"
 D EN1^DIP
 QUIT
 ;
