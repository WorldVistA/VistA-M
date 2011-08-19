PRCRIA ;GAI/CES/WASH IRMFO - DIRECTIVE 7127/MULT SIGNING OF P.O. ;8/27/96  15:36
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;  
EN ;
 S U="^",PAGE=1,(OUT,ZXX)=""
 N TXT
 S TXT(1)="For proper format, this report MUST be printed"
 S TXT(2)="in LANDSCAPE mode (16 or 17 cpi)"
 D HDRBOX^PRCRIA10(.TXT)
 S ZXX=$$DATERNG^PRCRIA1
 D DEV
 Q
DEV ;
 Q:$G(ZXX)=""
 S %IS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTSAVE("*")="",ZTDESC="DIRECTIVE 7127/MULT SIGNING OF P.O.",ZTRTN="LOOP^PRCRIA" D ^%ZTLOAD I $D(ZTSK) W !,"Task #",ZTSK," queued to print." G EXIT
 U IO
LOOP ;
 ;-------------------------------------------------------------
 ;This loops through the Date of P.O. x-ref for p.o.'s within
 ; the date range specified.  Saves only thos p.o.'s with
 ; at match in at least 2 of the 3 questioned fields.
 ;-------------------------------------------------------------
 K ^TMP("PRCRIA")
 S (IEN,APOFF,PAGNT,WHPER,PONUM,REFNUM,PODT,FCP,RCV,PRTDT)="",FLAG=0
 F  S PODT=$O(^PRC(442,"AB",PODT)) Q:PODT=""  D
 .F  S IEN=$O(^PRC(442,"AB",+PODT,IEN)) Q:IEN=""  D
 ..I PODT>($P(ZXX,U)-1),PODT<$P(ZXX,U,2)  D
 ...S PONUM=$$GET1^DIQ(442,+IEN_",",.01)
 ...S FCP=$P($G(^PRC(442,+IEN,0)),U,3)
 ...S PAGNT=$P($G(^PRC(442,+IEN,1)),U,10)
 ...F  S RCV=$O(^PRC(442,+IEN,11,RCV)) Q:RCV=""  D:RCV>0
 ....S WHPER=$P($G(^PRC(442,+IEN,11,+RCV,0)),U,7)
 ....S PRTDT=$P($G(^PRC(442,+IEN,11,+RCV,0)),U)
 ....F  S REFNUM=$O(^PRC(442,+IEN,13,REFNUM)) Q:REFNUM=""  D:REFNUM>0
 .....S APOFF=$P($G(^PRCS(410,+REFNUM,7)),U,3)
 .....I APOFF=PAGNT S FLAG=1
 .....I APOFF=WHPER S FLAG=1
 .....I PAGNT=WHPER S FLAG=1
 .....I FLAG=1 S ^TMP("PRCRIA",$J,FCP,IEN,RCV)=PONUM_U_FCP_U_REFNUM_U_PODT_U_APOFF_U_PAGNT_U_WHPER_U_PRTDT S FLAG=0
 D PRINT
EXIT ;
 D ^%ZISC
 K ^TMP("PRCRIA"),ZXX,FCP,IEN,RCV,PONUM,REFNUM,PODT,APOFF,PAGNT,WHPER
 K PRTDT,FLAG,PAGE,TXT,NODE
 Q
PRINT ;
 D HEADER
 S (FCP,IEN,APOFF,PAGNT,WHPER,PRTDT)=""
 F  S FCP=$O(^TMP("PRCRIA",$J,FCP)) Q:'FCP  D
 .F  S IEN=$O(^TMP("PRCRIA",$J,FCP,IEN)) Q:IEN=""  D
 ..F  S RCV=$O(^TMP("PRCRIA",$J,FCP,IEN,RCV)) Q:RCV=""  D
 ...I $E(IOST)="C",$Y+5>IOSL D
 ....K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W !! D ^DIR
 ...D:$Y+5>IOSL HEADER
 ...S NODE=^TMP("PRCRIA",$J,FCP,IEN,RCV)
 ...S APOFF=$P(NODE,U,5)
 ...S PAGNT=$P(NODE,U,6)
 ...S WHPER=$P(NODE,U,7)
 ...S PRTDT=$P(NODE,U,8)
 ...W !,$P(NODE,U),?17,$P(NODE,U,2),?48,$P($G(^VA(200,+APOFF,0)),U),?82,$P($G(^VA(200,+PAGNT,0)),U),?120,$P($G(^VA(200,+WHPER,0)),U),?158,$P($$FMTE^XLFDT(PRTDT),"@",1)
 Q
HEADER ;
 I PAGE>1,($E(IOST,1,2))="C-"
 W @IOF
 I $E(IOST)="C" D HDRBOX^PRCRIA10(.TXT)
 I $E(IOST)="P" W !,"REPORT FOR VA DIRECTIVE 7127.1",?50,$$FMTE^XLFDT($$DT^XLFDT),?68,"PAGE:  ",PAGE,!!
 W !,"P.O.#",?17,"FCP",?48,"APPROVING OFFICIAL",?82,"PURCHASING AGENT",?120,"RECEIVING OFFICIAL",?158,"PARTIAL DATE",! W $$REPEAT^XLFSTR("-",IOM)
 S PAGE=PAGE+1
 W !
 Q
 ;PRCRIA
