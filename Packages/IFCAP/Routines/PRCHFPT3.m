PRCHFPT3 ;WISC/RSD/RHD-CONT. OF PRINT ;7/21/99  13:19
V ;;5.1;IFCAP;**221**;Oct 20, 2000;Build 14
 ;Per VA Directive 6204, this routine should not be modified.
 ;PRC*5.1*221 Modify an item description display to skip '|' logic
 ;            if description contains a undefined display command
 ;            like '| IN '
 ;
ITEM N PURPIPE,PRCHDIW,PRCHI,PRCHJ   ;PRC*5.1*221
 S DIWL=1,DIWR=33,DIWF="" K ^UTILITY($J,"W")
 S PURPIPE=0 D PIPECK S PRCHD=0   ;PRC*5.1*221
 F PRCHJJ=0:0 S PRCHD=$O(^PRC(442,D0,2,PRCH,1,PRCHD)) Q:PRCHD=""  S X=$G(^(PRCHD,0)) S:PURPIPE DIWF=$G(DIWF)_"|" D DIWP^PRCUTL($G(DA))   ;PRC*5.1*221
 K ^TMP($J,"W") S %X="^UTILITY($J,""W"",1,",%Y="^TMP($J,""W"",1," D %XY^%RCR
 K PRCHJJ S PRCHCNT=$G(^UTILITY($J,"W",1)),PRCHL=PRCHL+PRCHCNT+1 W !?2,$J(+$P(PRCHI0,U,1),3),?7,$G(^(1,1,0))
 I PRCHTYPE'="S" W ?42,$J($P(PRCHI0,U,2),7),?52,$P($G(^PRCD(420.5,+$P(PRCHI0,U,3),0)),U,1) D
 .  S X=$P($P(PRCHI0,U,9),".",2) W ?55,$S($L(X)>3:$J($P(PRCHI0,U,9),8,4),$L(X)>2:$J($P(PRCHI0,U,9),8,3),$P(PRCHI0,U,9)="N/C":"    N/C",1:$J($P(PRCHI0,U,9),8,2))
 D AMT
 I PRCHCNT>1 F K=2:1:$P(^TMP($J,"P",P,PRCH),U,2) W:$D(^TMP($J,"W",1,K,0)) !?8,^(0)
 W ! S PRCHL=PRCHL+1 I $P(PRCHI0,U,6)]"" W ?8,"STK#: ",$P(PRCHI0,U,6),! S PRCHL=PRCHL+1
 I $P(PRCHI0,U,13)]"" W ?8,"NSN:  ",$P(PRCHI0,U,13) D:$D(PRCHNRQ) PSNO^PRCHFPNT W ! S PRCHL=PRCHL+1
 I $P($G(^PRC(442,D0,2,PRCH,4)),U,12)]"" W ?8,"FOOD GROUP: ",$P(^(4),U,12),! S PRCHL=PRCHL+1
 D EDISTAT^PRCHUTL(D0,PRCH,.PRCHL)
 I PRCHDES="R",$P(PRCHI0,U,5)]"" W ?8,"IMF#: ",$P(PRCHI0,U,5)_"    "
 I $P(PRCHI0,U,12),PRCHTYPE'="S" W:$P(PRCHI0,U,5)']""!($P(PRCHI0,U,5)]""&(PRCHDES'="R")) ?8 W "Items per ",$P($G(^PRCD(420.5,+$P(PRCHI0,U,3),0)),U,1),": ",$P(PRCHI0,U,12),! S PRCHL=PRCHL+1
 W ?8,"BOC: ",$P($P(PRCHI0,U,4)," ",1) S FMSLN=$O(^PRC(442,D0,22,"B",+$P(PRCHI0,U,4),0)) S PRCHL=PRCHL+1
 I FMSLN>0,PRCHTYPE'="S" S FMSLN="00"_$P($G(^PRC(442,D0,22,FMSLN,0)),U,3),FMSLN=$E(FMSLN,$L(FMSLN)-2,99) W ?22,"FMS LINE: ",FMSLN
 W:$P(PRCHI2,U,2)]"" ?40,"CONTRACT: ",$P(PRCHI2,U,2)
 W ! S PRCHL=PRCHL+1
 Q
 ;
AMT W ?66,$J($P(PRCHI2,U,1),8,2) S PRCHC=0,PRCHPT=PRCHPT+$P(PRCHI2,U,1),X=$O(^PRC(442,D0,2,PRCH,3,"AC",PRCHFPT,0))
 I PRCHDES="R",X,$D(^PRC(442,D0,2,PRCH,3,X,0)) W ?76,$J($P(^(0),U,2),7),?86,$J($P(^(0),U,3),8,2)
 Q
 ;
AUTH W !,"AUTHORITY FOR PURCHASE",?28,$S($D(PRCHNRQ):"REQ.",1:"P.O.")_" NO.",?42,$S($D(PRCHNRQ):"REQ.",1:"PO ")_"DATE" S Y=$P($G(^PRC(442,D0,7)),U,3) W:Y="Y" ?54,"EST." W ?59,"TOTAL: ",?66,$J($P(PRCH0,U,15),8,2)
 I PRCHDES="R",PRCHDA W ?76,"DSCNT AMT:  ",$J(PRCHDA,8,2) S PRCHDTA=PRCHDTA-PRCHDA
 W !?2 S Y=0 F I=1:1 S Y=$O(^PRC(442,D0,14,Y)) Q:'Y  W:I>1 "," W $P($G(^PRC(442.4,+^(Y,0),0)),U,2)
 I $D(PRCHNRQ) W ?8,"P.O.# "_$P(PRCH0,U,1),?28 W:$D(^PRC(442,D0,18)) $P(^(18),U,10)
 W:'$D(PRCHNRQ) ?28,$P(PRCH0,U,1) W ?42 S Y=$P(PRCH1,U,15) D DT
 W:PRCHDES="R"&PRCHDTA ?76,"TOTAL AMT:",$J(PRCHDTA,10,2)
 D FAXEMAIL(+$P($G(PRCH1),U,10),.PRCFAX,.PRCEMAIL)
 W !,$S(PRCHTYPE'="":"AUTHORIZED BUYER",1:"CONTRACTING OFFICER"),?35,"DATE SIGNED",?52,"PHONE" W:PRCFAX'="" ?70,"FAX"
 I PRCHDES="R",$D(^PRC(442,D0,11,PRCHFPT,0)) S X=$P(^(0),U,3)+$P(^(0),U,5) W:PRCHDTA-X ?76,"TERM DSCNT: ",$J(PRCHDTA-X,8,2) S PRCHDA=X
 S P=+$P(PRCH1,U,10),Y=$P($G(^PRC(442,D0,12)),U,3) W !,"/ES/"_$$DECODE^PRCHES5(D0)
 W ?35 D DT,DT1 W:$D(^VA(200,P,.13)) ?52,$P(^(.13),U,5),?70,PRCFAX
 I (PRCEMAIL'="")!(PRCHDES="R"&(PRCHDTA-PRCHDA)) D
 . W ! W:PRCEMAIL'="" "E-MAIL: ",PRCEMAIL
 . W:PRCHDES="R"&(PRCHDTA-PRCHDA) ?76,"NET AMT:  ",$J(PRCHDA,10,2)
 K PRCFAX,PRCEMAIL W !,PRCHULN
 ;
APP W !,?7,"FUND CERTIFICATION: The supplies/services listed on this request are properly",!?5,"chargeable to the following allotments, the available balances of which are"
 W !?5,"sufficient to cover the cost thereof, and funds have been obligated."
 W !,"APPROPRIATION: ",$P(PRCH0,U,4),"-",$P($P(PRCH0,U,3)," ",1),?40,"OBLIGATED BY: " S (X,Y)="",P=0 I $D(^PRC(442,D0,10,1,0)) S Y=$P(^(0),U,6),P=+$P(^(0),U,2),X=$P(^(0),U,5)
 I X]"" W "/ES/"_$$DECODE^PRCHES4(D0,1),?75,"DATE: " D:Y]"" DT
 I X="",$D(^VA(200,+P,0)) S X=$P(^(0),"^",1) W $P(X,",",2)," ",$P(X,",",1),?75,"DATE: " D:Y]"" DT
 K BOC S CHGSHP=$P($G(^PRC(442,D0,0)),U,13),BOC=0,CNT=1,BOCCT=$G(^PRC(442,D0,22,0)),BOCCT=$P(BOCCT,U,4) S:CHGSHP'>0 BOCCT=BOCCT-1 I BOCCT'>0 G APP1
 F  Q:CNT>2  S BOC=$O(^PRC(442,D0,22,BOC)) Q:BOC'>0  S BOC22=$G(^(BOC,0)) I $P(BOC22,U,3)'=991 S BOC(CNT)=BOC22,CNT=CNT+1
 S PZZBOC=BOC_"^"_CNT
APP1 W !,"COST CENTER: ",$P(PRCH0,U,5)
 I $D(BOC(1)) W ?41,"BOC1:",?48,$P(BOC(1),U),?56,"AMOUNT1:",?66,$J($P(BOC(1),U,2),12,2),?80 S FMSLN="00"_$P(BOC(1),U,3),FMSLN=$E(FMSLN,$L(FMSLN)-2,99) W "FMS LINE: ",FMSLN
 S Y=$G(^PRCD(420.8,+$P(PRCH1,U,7),0))
 W !,"SOURCE CODE: " S X=$P(Y,U,1) W "SUPPLY-"_$S(X="B":"COMB.2,4,6",1:X_" ") S X=$P(Y,U,3) W " FISCAL-" W:X X
 I $D(BOC(2)) W ?41,"BOC2:",?48,$P(BOC(2),U),?56,"AMOUNT2:",?66,$J($P(BOC(2),U,2),12,2),?80 S FMSLN="00"_$P(BOC(2),U,3),FMSLN=$E(FMSLN,$L(FMSLN)-2,99) W "FMS LINE: ",FMSLN
 I CHGSHP>0&('$D(BOC(2))) W ?41,"BOC2:",?48,+$P($G(^PRC(442,D0,23)),U),?56,"AMOUNT2:",?66,$J(CHGSHP,12,2),?80,"FMS LINE: 991" S PRCHL=PRCHL+1
 D SETUP^PRCHFPT4
 W !,"FCP/PRJ: ",PRCHPRJ,?41,$S(P>1&(BOCCT>2):"**ADDITIONAL BOCs WILL BE FOUND AFTER ALL THE ITEMS.**",BOCCT>2:"**ADDITIONAL BOCs WILL BE FOUND ON THE NEXT PAGE.**",1:"")
 K PRCHZ0,PRCHZ1,PRCHSTN,PRCHFCP,PRC("BBFY"),PODATE,MO,PRCHB,PRCHPRJ
 W !
 Q
 ;
DT W:Y Y\100#100,"/",Y#100\1,"/",Y\10000+1700
 Q
 ;
DT1 Q:'Y  S Y=$P(Y,".",2),Y=Y_$E("0000",1,(4-$L(Y))) Q:'Y  W "@",$E(Y,1,2),":",$E(Y,3,4)
 Q
 ;1st argument is passed internal entry number of person
 ;2nd argument is returned Fax Number
 ;3rd argument is returned e-mail address
FAXEMAIL(PRCA,PRCB,PRCC) ;
 I PRCA'>0 S PRCB="",PRCC="" Q
 I '$D(^VA(200,PRCA)) S PRCB="",PRCC="" Q
 N PRCX,DIC,DR,DA,DIQ,D0 K ^UTILITY("DIQ1",$J)
 S DIC=200,DR=".136;.151",DA=PRCA,DIQ="PRCX",DIQ(0)="I" D EN^DIQ1
 S PRCB=PRCX(200,DA,.136,"I"),PRCC=PRCX(200,DA,.151,"I") K ^UTILITY("DIQ1",$J)
 Q
PIPECK ;check for invalid pipe '|IN ' command in item description   ;PRC*5.1*221
 N PRCHWD,PRCHX S PRCHWD=0
 F  S PRCHWD=$O(^PRC(442,D0,2,PRCH,1,PRCHWD)) Q:PRCHWD'>0  D  Q:PURPIPE
 . S PRCHX=$S($D(^(PRCHWD,0)):^(0),1:"")
 . I PRCHX["| IN " S PURPIPE=1
 Q
