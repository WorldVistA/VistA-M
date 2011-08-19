PSXCMOP1 ;BIR/WRT-Complete review NDF (LOOP) matches for CMOP ;[ 10/15/98  10:55 AM ]
 ;;2.0;CMOP;**18,19,23**;11 Apr 97
 ;Reference to ^PSDRUG(  supported by DBIA #1983, #2367
 ;Reference to PSNTRAN(  supported by DBIA #2527
COMPLETE I '$D(DUOUT),'$D(DTOUT) W:'$D(^TMP($J,"PSXCMOP")) !!,"You've completed marking everything that is possible.",!! S:'$D(^TMP($J,"PSXCMOP")) PSXFL=1
 Q
BLD D WR F PSXB=0:0  S PSXB=$O(^PSDRUG(PSXB)) Q:'PSXB  D WR1,BLD0,NO
 Q
BLD0 I PSXNO=0,'$D(^PSDRUG(PSXB,3)),'$D(^PSDRUG(PSXB,"I")),$D(^PSDRUG(PSXB,2)),$P(^PSDRUG(PSXB,2),"^",3)["O",$D(^PSDRUG(PSXB,"ND")),$P(^PSDRUG(PSXB,"ND"),"^",2)]"" D BLD1^PSXCMOP
 Q
WR W !!,"I have to build a table before you can begin ""looping"" so let me put you on",!,"""hold"" for a moment.",!
 Q
WR1 U IO(0) W:'(PSXB#100) "."
 Q
NO1 S PSXNO=0,PSXBT=0
 W !,"Do you wish to loop through the whole file?",!,"(If you answer ""NO"", you will loop through ONLY the ones previously marked as",!,"""Do not transmit to CMOP""). " K DIR S DIR(0)="Y" D ^DIR D OUT1,OUT^PSXCMOP I "Nn"[X S PSXNO=1
 Q:PSXBT
 I "YyNn"[X D BLD
 I "^"[X S PSXBT=1 Q:PSXBT
 Q
NO I PSXNO=1,$D(^PSDRUG(PSXB,3)),$P(^PSDRUG(PSXB,3),"^",1)=0,'$D(^PSDRUG(PSXB,"I")),$D(^PSDRUG(PSXB,2)),$P(^PSDRUG(PSXB,2),"^",3)["O",$D(^PSDRUG(PSXB,"ND")),$P(^PSDRUG(PSXB,"ND"),"^",2)]"" D BLD1^PSXCMOP
 Q
TRAN D OLDNM I $D(^PSNTRAN(WAS,"END")) S $P(^PSNTRAN(WAS,"END"),"^",3)=PSXM,$P(^PSNTRAN("END"),"^",3)=PSXM
 Q
PR I $P(^TMP($J,"PSXANS",WAS),"^",1)="YES",$P(^TMP($J,"PSXANS",WAS),"^",6)]"" S DIE="^PSDRUG(",DA=WAS,DR="13///^S X=PRICE" D ^DIE S DIE="^PSDRUG(",DA=WAS,DR="15///^S X=PSXDUOU" D ^DIE
 Q
IDENT S PSXNDF=$P(^PSDRUG(WAS,"ND"),"^",1),PSXVAPN=$P(^PSDRUG(WAS,"ND"),"^",3)
 S ZX=$$PROD2^PSNAPIS(PSXNDF,PSXVAPN) I $P($G(ZX),"^",3)']"" W !,"This drug is not marked for CMOP in the National Drug File!" S $P(^PSDRUG(WAS,"ND"),"^",10)="" K ^PSXDRUG("AQ1",PSXIDENT,WAS) Q
 S PSXIDENT=$P(ZX,"^",2),$P(^PSDRUG(WAS,"ND"),"^",10)=PSXIDENT,^PSDRUG("AQ1",PSXIDENT,WAS)="" K ZX
 Q
OUT1 I $D(DUOUT),DUOUT=1 S PSXFL=1,PSXBT=1 Q
 Q
DU I $D(^PSDRUG(PSXDA,660)),$P(^PSDRUG(PSXDA,660),"^",8)'=PSXDU W !!,"Your old Dispense Unit  ",$P(^PSDRUG(PSXDA,660),"^",8),"  does not match the new one  ",PSXDU,"." D DU1
 Q
DU1 W !,"You may wish to edit the Price Per Order Unit and/or the Dispense",!,"Units Per Order Unit.",! D QUEST
 Q
QUEST W !,"PRICE PER ORDER UNIT: ",$P(^PSDRUG(PSXDA,660),"^",3),"// " R PRICE:DTIME
 I PRICE="^" W !?4,"EXIT NOT ALLOWED ??" K PRICE G QUEST
 S:PRICE']"" PRICE=$P(^PSDRUG(PSXDA,660),"^",3)
 I PRICE]"" S:PRICE["$" PRICE=$P(PRICE,"$",2) I +PRICE'=PRICE&(PRICE'?.N1"."2N)!(PRICE>9999)!(PRICE<0) K PRICE W !,"Type a Dollar Amount between 0 and 9999, 2 Decimal Digits." G QUEST
 S $P(^TMP($J,"PSXANS",PSXDA),"^",6)=PRICE
QUEST1 W !,"DISPENSE UNITS PER ORDER UNIT: ",$P(^PSDRUG(PSXDA,660),"^",5),"// " R PSXDUOU:DTIME
 I PSXDUOU="^" W !?4,"EXIT NOT ALLOWED ??" K PSXDUOU G QUEST1
 S:PSXDUOU']"" PSXDUOU=$P(^PSDRUG(PSXDA,660),"^",5)
 I PSXDUOU]"" I +PSXDUOU'=PSXDUOU!(PSXDUOU>9999)!(PSXDUOU<1)!(PSXDUOU?.E1"."4N.N) K PSXDUOU W !,"Type a Number between 1 and 9999, 3 Decimal Digits." G QUEST1
 S $P(^TMP($J,"PSXANS",PSXDA),"^",7)=PSXDUOU
 Q
PRC I $P(^TMP($J,"PSXANS",NDA),"^",6)]"" W !?7,"Price Per Order Unit = ",$P(^TMP($J,"PSXANS",NDA),"^",6),!?7,"Dispense Units Per Order Unit = ",$P(^TMP($J,"PSXANS",NDA),"^",7)
 Q
OLDNM D OLD I $D(ONCE) D OLD1
 Q
OLD D NOW^%DTC I $D(^PSDRUG(WAS,900,1,0)) S ONCE=0,PSXLAST=0 F RTC=0:0 S RTC=$O(^PSDRUG(WAS,900,RTC)) Q:'RTC  S PSXLAST=PSXLAST+1,PSXNEXT=PSXLAST+1
 I '$D(^PSDRUG(WAS,900,1,0)) S ^PSDRUG(WAS,900,1,0)=PSXLM_"^"_X
 Q
OLD1 I ONCE=0 S ^PSDRUG(WAS,900,PSXNEXT,0)=PSXLM_"^"_X,ONCE=1
 Q
