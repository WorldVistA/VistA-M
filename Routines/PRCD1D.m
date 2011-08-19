PRCD1D ;WISC/PLT-DOCUMENT REQUIRED DATA ELEMENT ; 02/17/94  9:12 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;enter/edit document required data element
EN N PRCDD,PRCDR,PRCDI,PRCRI,PRCAED,PRCQT,PRCU,A,B,X,Y S PRCU="^"
 N PRCUQ,PRCK,PRCK01,PRCK1,PRCK2
 F  D EN^DDIOL("Enter/Edit Budget/Document Required Data"_$TR($J("",10)," ","-")) D  Q:PRCQT=1
 . S PRCQT=""
 . D PTR^PRC0A(.X,.Y,"Select Fund","O^420.14:EMOQS","")
 . I Y=-1!(Y?1"^".E) S PRCQT=1 QUIT
 . S PRCRI(420.14)=+Y,PRCHE=$$NP^PRC0B("^PRCD(420.14,+Y,",0,1)
 . D PTR^PRC0A(.X,.Y,"Select Document Type","O^420.16:EMOQS","")
 . I Y=-1!(Y?1"^".E) QUIT
 . S PRCRI(420.16)=+Y,PRCHE=PRCHE_" / "_$$NP^PRC0B("^PRCD(420.16,+Y,",0,2)
 . F  D EN^DDIOL(PRCHE_$TR($J("",10)," ","-")) D  Q:PRCQT=2
 .. S PRCQT=""
 .. D PTR^PRC0A(.X,.Y,"Select Data Element","O^420.17:EMOQS","")
 .. I Y=-1!(Y?1"^".E) S PRCQT=2 QUIT
 .. S PRCRI(420.17)=+Y
 .. S PRCDD=420.18,PRCQT=""
 .. S (PRCUQ,PRCK01,PRCK1,PRCK2)=""
 .. D LKUP Q:PRCQT
 .. S PRCLOCK=$$DICGL^PRC0B1(PRCDD)_PRCRI(PRCDD)_",",Y=3 D ICLOCK^PRC0B(PRCLOCK,.Y)
 .. I 'Y D EN^DDIOL("File is in use, please try later!") QUIT
 .. D:PRCAED'=1 KEY
 .. D EDIT
 .. D DCLOCK^PRC0B(PRCLOCK)
 .. QUIT
 . QUIT
 QUIT
 ;
LKUP ;lookup prcdd=420.18
 S DA="",Y=$O(^PRCD(420.18,"UNQ",PRCRI(420.14),PRCRI(420.16),PRCRI(420.17),""))
 I 'Y D
 . S X=PRCRI(420.14),X("DR")="1////"_PRCRI(420.16)_";2////"_PRCRI(420.17)
 . D ADD^PRC0B1(.X,.Y,"420.18;^PRCD(420.18,")
 . QUIT
 K X I Y<0 S PRCQT=2 QUIT
 S DA=+Y,PRCRI(PRCDD)=+Y,PRCAED=$P(Y,"^",3)
 QUIT
 ;
EDIT ;edit prcdd=420.18
 S PRCDR=3,C=PRCDR
ED1 D EDIT^PRC0B(.X,PRCDD_";;"_PRCRI(PRCDD),C) I X=0 S PRCQT=3 QUIT
 I X=-1,PRCAED=1 D  Q:PRCQT
 . D YN^PRC0A(.X,.Y,"Delete this NEW entry","","No")
 . I Y=1 D DELETE I PRCAED=-1 D EN^DDIOL(" **** NEW ENTRY DELETED ****") S PRCQT=3 QUIT
 . D EN^DDIOL(" **** NEW ENTRY IS NOT DELETED ****")
 .QUIT
 ;delete entry if nil
 S C=3
EDA K A D PIECE^PRC0B(PRCDD_";;"_PRCRI(PRCDD),C,"I","A")
 I $G(A(PRCDD,PRCRI(PRCDD),3,"I"))="" D DELETE
 QUIT
 ;
DELETE ;delete prcdd=420.18
 D DELETE^PRC0B1(.X,PRCDD_";^PRCD(420.18,;"_PRCRI(PRCDD))
 S:X=1 PRCAED=-1
 QUIT
 ;
KEY ;initial key values
 N A
 S A=$G(^PRCD(420.18,DA,0))
 S PRCK01=$P(A,"^",1),PRCK1=$P(A,"^",2),PRCK2=$P(A,"^",3)
 QUIT
 ;
 ;not in use
UNQCHK(PRCK01,PRCK1,PRCK2) ;check uniqueness from ^dd(420.18)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK1)_""","""_$G(PRCK2)_""","
 I PRCK'[",""""," S @("PRCUQ=$O(^PRCD(420.18,""UNQ"""_PRCK_"0))") I PRCUQ,PRCUQ-DA D UNQMES K X
 QUIT
 ;
UNQCRS ;set unique cross reference called from ^dd(420.18)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK1)_""","""_$G(PRCK2)_""","
 I PRCK'[",""""," S @("^PRCD(420.18,""UNQ"""_PRCK_"DA)=""""")
 QUIT
 ;
UNQCRK ;kill unique cross reference called from ^dd(420.18)
 S PRCK=","""_$G(PRCK01)_""","""_$G(PRCK1)_""","""_$G(PRCK2)_""","
 I PRCK'[",""""," K @("^PRCD(420.18,""UNQ"""_PRCK_"DA)")
 QUIT
 ;
 ;
UNQMES D EN^DDIOL(" NOT UNIQUE for document data element, fund, document type!")
 QUIT
 ;
EN1 ;print document required fields
 N L,DIC,FLDS,BY,FR,TO,DHD,DISTOP,PRCDD,PRCOPT,PRCRI,PRCQT
Q20 D SC^PRC0A(.X,.Y,"Select: ","O^1:ALL;2:SELECT FOR FUND","")
 G EXIT1:Y=""!(Y["^")
 S PRCOPT=+Y,PRCQT=""
Q20A I PRCOPT=2 D  G Q20:PRCQT=1
  . D PTR^PRC0A(.X,.Y,"Select Fund","O^420.14:EMOQS","")
 . I Y=-1!(Y?1"^".E)!(Y="") S PRCQT=1 QUIT
 . S PRCRI(420.14)=+Y
 . QUIT
 D PRINT G EXIT1:PRCOPT=1,Q20A
PRINT S PRCDD=420.18
 S L=0,DIC=PRCDD,FLDS="[PRCD PRINT]",BY="[PRCD BY FUND,DOC TYPE,DATA ELE]",(FR,TO)=""
 I PRCOPT=2 S BY="@INTERNAL(FUND),DOCUMENT TYPE,DATA ELEMENT",FR=PRCRI(420.14),TO=FR,DISTOP=1
 D EN1^DIP
EXIT1 QUIT
 ;
