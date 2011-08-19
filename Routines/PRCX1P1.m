PRCX1P1 ;WISC/PLT-FIX FILE 442 BBFY AND APPROPRIATION ; 10/17/95  3:10 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;QUIT  ; invalid entry
 ;
EN ;start fix file 410/442
 N PRCRI,PRCSITE,PRCYEAR,PRCYE,PRCQTR,PRCFCP,PRCDATE
 N PRCA,PRCB,PRCC
 S PRCYEAR=1996,PRCYE=96,PRCDATE=2950630
 S PRCRI(420)=0 F  S PRCRI(420)=$O(^PRC(420,PRCRI(420))) QUIT:'PRCRI(420)  S PRCC="" D  QUIT:PRCC=-1
 . D EN^DDIOL("STATION # "_PRCRI(420)_" starts:")
 . S PRCSITE=PRCRI(420)
 . D @("AUTO"_PRCDD)
 . QUIT
 QUIT
 ;
 ;
AUTO410 ;auto select file 410 for 1996
 S PRCA=PRCSITE_"-"_PRCYE
 S PRCB=PRCA F  S PRCB=$O(^PRCS(410,"B",PRCB)) QUIT:PRCA-PRCB  S PRCRI(410)=$O(^(PRCB,"")) D:PRCRI(410)
 . N A,B,C,D,PRC,PRCX,PRCACC,PRCBBFY
 . S PRC=$G(^PRCS(410,PRCRI(410),3)),PRCX=$G(^(0))
 . S A=$$BBFY^PRCSUT($P(PRCX,"-"),$P(PRCX,"-",2),$P(PRCX,"-",4),1)
 . S PRCACC=$$ACC^PRC0C($P(PRCX,"-"),$P(PRCX,"-",4)_"^"_$P(PRCX,"-",2)_"^"_A)
 . S PRCBBFY=$P($$DATE^PRC0C(PRC("BBFY"),"E"),"^",7)
 . S:$P(PRC,"^",11)'=PRCBBFY $P(PRC,"^",11)=PRCBBFY
 . S:$P(PRC,"^",2)'=$P(PRCACC,"^",11) $P(PRC,"^",2)=$P(PRCACC,"^",11)
 . S:$P(PRC,"^",12)'=$P(PRCACC,"^",3) $P(PRC,"^",12)=$P(PRCACC,"^",3)
 . ;W !,"***",$P(PRCX,"^"),!,"***",$G(^PRCS(410,PRCRI(410),3)),!,"***",PRC
 . I $G(^PRCS(410,PRCRI(410),3))'=PRC W !,$P(PRCX,"^"),!,"OLD: ",$G(^(3)),!,"NEW: ",PRC S ^(3)=PRC
 . QUIT
 QUIT
 ;
AUTO442 ;auto select file 442 for 1996
 S PRCA=PRCDATE
 S PRCB=PRCA F  S PRCB=$O(^PRC(442,"AB",PRCB)) QUIT:'PRCB  D  QUIT:PRCC=-1
 . S PRCRI(442)=0 F  S PRCRI(442)=$O(^PRC(442,"AB",PRCB,PRCRI(442))) QUIT:'PRCRI(442)  D:^PRC(442,PRCRI(442),0)-PRCSITE=0 442 QUIT:PRCC=-1
 . QUIT
 QUIT
 ;
410 ;display/edit substation
 W ! D  ;display
 . N DIC,DA,DR,WIQ
 . S DIC="^PRCS(410,",DA=PRCRI(410),DR="0;3;4;RM" D EN^DIQ
 . QUIT
 S PRC("SITE")=+^PRCS(410,PRCRI(410),0)
 D EDIT^PRC0B(.X,"410;;"_PRCRI(410),"28.5;28;28.1","")
 S PRCC=X
 D EN^DDIOL(" "),EN^DDIOL($TR($J("",78)," ","-"))
 QUIT
 ;
442 ;display/edit substation
 W ! D  ;display
 . N DIC,DA,DR,WIQ
 . S DIC="^PRC(442,",DA=PRCRI(442),DR="0;12;4" D EN^DIQ
 . W "    PURCHASE ORDER DATE: ",$E(PRCB,4,5),"/",$E(PRCB,6,7),"/",$E(PRCB,2,3)
 . QUIT
 S PRC("SITE")=+^PRC(442,PRCRI(442),0)
 D EDIT^PRC0B(.X,"442;;"_PRCRI(442),"26;1.4","")
 S PRCC=X
 D EN^DDIOL(" "),EN^DDIOL($TR($J("",78)," ","-"))
 QUIT
 ;
EN1 D @("MAN"_PRCDD)
 QUIT
 ;
 ;
 ;
 ;
MAN410 ;manual select 410 for 1996
 S X("S")="I $P($G(^(0)),""-"",2)>95"
 D LOOKUP^PRC0B(.X,.Y,"410","AEMOQS","Select 2237/1358 Request: ")
 I X=""!(X["^") QUIT
 I Y>0 S PRCRI(410)=+Y D 410
 G MAN410
 QUIT
 ;
MAN442 ;MANUAL SELECT 442 for 1996
 S X("S")="I $P($G(^(1)),""^"",15)>2950630"
 D LOOKUP^PRC0B(.X,.Y,"442","AEMOQS","Select Purchase Order: ")
 I X=""!(X["^") QUIT
 I Y>0 S PRCRI(442)=+Y,PRCB=$P($G(^PRC(442,PRCRI(442),1)),"^",15) D 442
 G MAN442
 ;
GECS ;rebuild rejected mo/so doc for obligation after 9/30/95
 N PRCRI,PRCA,PRCB,PRCA
 S PRCRI(2100.1)=0 F  S PRCRI(2100.1)=$O(^GECS(2100.1,"AS","R",PRCRI(2100.1))) QUIT:'PRCRI(2100.1)  D GECS1:$G(^GECS(2100.1,PRCRI(2100.1),0))?1"MO".E!($G(^(0))?1"SO".E)
 W !,"ALL DONE!    ALL DONE!"
 QUIT
 ;
GECS1 ;rebuild mo/so record
 N PRCA,PRCB,PRC
 N A,B,C
 S A=^GECS(2100.1,PRCRI(2100.1),0),B=$G(^(26))
 QUIT
