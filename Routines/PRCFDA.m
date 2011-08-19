PRCFDA ;WISC@ALTOONA/CTB-PROCESS PAYMENT IN ACCTG ;2/9/96  15:58 [2/1/99 2:26pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRCFCIDA,PRCFFLG K ^TMP("PRCFDA",$J,"LIQ")
 Q:$D(PRCFA("ERROR PROCESSING"))  S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S DIC("S")="S ZX=^(0),ZX2=$G(^(2)) I $P(ZX2,U)=15,$P(ZX,U,15)]"""""
 S DIC=421.5,DIC(0)="AEMNZ" D ^DIC K DIC,ZX2,ZX
 I Y<1!$D(DTOUT)!$D(DUOUT) K PRC,C,PRCRI,X,Y,% G:$$NUMSTA>1&'$D(DTOUT)&'$D(DUOUT) PRCFDA K DTOUT,DUOUT Q
EN S (PRCF("CIDA"),PRCFDICA)=+Y,PRC("SITE")=$P(^PRCF(421.5,PRCF("CIDA"),1),U,2)
 G:$D(PRCFA("ERROR PROCESSING")) B
 L +^PRCF(421.5,PRCF("CIDA")):5 E  W !,"This invoice is being edited by someone else, please try later!" G EX^PRCFDA2
 S:$P($G(^PRCF(421.5,PRCF("CIDA"),1)),U,7)]"" PRCFA("ERROR PROCESSING")=2
 I '$D(PRCFA("ERROR PROCESSING")),$$CLSD1358^PRCFDE2($P(Y(0),U,7),1) D  G:%'=1 EX^PRCFDA2
 . W ! S %A="Do you wish to continue processing this invoice now"
 . S %B="",%=2 D ^PRCFYN
 S DIR(0)="YA",DIR("A")="Do you wish to view current information for this invoice? "
 S DIR("B")="NO" D ^DIR K DIR I $D(DIRUT)!$D(DIROUT)!$D(DUOUT) G EX^PRCFDA2
 I Y=1 D  I Y'=1!$D(DIRUT)!$D(DIROUT)!$D(DUOUT) G EX^PRCFDA2
 . N PRCRI,RECORD,RECORD1,DR,DIQ,DA,DIC,DIR
 . S DA=PRCF("CIDA"),DIC="^PRCF(421.5,",DIQ(0)="C",PRCF("VIEW")="" W @IOF
 . D EN^DIQ K PRCF("VIEW")
 . S DIR(0)="YA",DIR("A")="Is this the correct invoice? ",DIR("B")="YES" D ^DIR
B I $P(^PRCF(421.5,PRCF("CIDA"),0),U,6)="X" D  G:Y<0 EX^PRCFDA2
 . S %A="This invoice is flagged as MONEY MANAGEMENT EXEMPT.  Return to Voucher Audit for review/correction"
 . S %B="",%=1 D ^PRCFYN Q:%=2
 . I %=1 S X=0 D STATUS^PRCFDE1
 . S Y=-1 Q
 ;GET AMOUNT CERTIFIED
 S PRCFD("CAMT")=$P(^PRCF(421.5,PRCF("CIDA"),0),U,15)
 S PRCF("PODA")=$P(^PRCF(421.5,PRCF("CIDA"),0),U,7)
 I PRCF("PODA")]"" D
 . S PRCFD("PAYMENT")="",PRCFA("PODA")=PRCF("PODA")
 . S PRCFA("REF")=$P($G(^PRCF(421.5,PRCF("CIDA"),2)),U,2)
 . S PRCFA("LIQAMT")=PRCFD("CAMT")/100
 . S PRCFX("SITE")=PRC("SITE"),PRCFX("PER")=PRC("PER")
 . S PRCFX("FY")=PRC("FY"),PRCFX("PARAM")=PRC("PARAM")
 . D:'$D(PRCFA("ERROR PROCESSING")) ^PRCEFIS4 I '$D(PRC("SITE")) D
 . . S PRC("SITE")=PRCFX("SITE"),PRC("PER")=PRCFX("PER")
 . . S PRC("FY")=PRCFX("FY"),PRC("PARAM")=PRCFX("PARAM")
 . . Q
 . K PO,PODA,PRCFD("PAYMENT"),PRCFA("PODA"),PRCFA("REF"),PRCFA("LIQAMT")
 . ; Build table of FMS Line Nos. & Obligation Amts. by BOCs:
 . K PRCFX N BOC,FMSLN,IEN S BOC=""
 . F  S BOC=$O(^PRC(442,PRCF("PODA"),22,"B",BOC)) Q:BOC=""  S IEN="" D
 . . I BOC>0 F  S IEN=$O(^PRC(442,PRCF("PODA"),22,"B",BOC,IEN)) Q:IEN=""  D
 . . . S FMSLN=$P($G(^PRC(442,PRCF("PODA"),22,IEN,0)),U,2,3)
 . . . S PRCFX("SA",BOC,IEN)=FMSLN
 . . . Q
 . . Q
 . S PRCFX("SHBOC")=+$G(^PRC(442,PRCF("PODA"),23))
 . S PRCFX("SHAMT")=+$P(^PRC(442,PRCF("PODA"),0),U,13)
 . I PRCFX("SHBOC") S I="" F  S I=$O(PRCFX("SA",PRCFX("SHBOC"),I)) Q:I=""  I $P(PRCFX("SA",PRCFX("SHBOC"),I),U,2)=991 S $P(PRCFX("SA",PRCFX("SHBOC"),I),U,3)=PRCFX("SHAMT")
 . Q
 S PRCF("CAMT")=$P(^PRCF(421.5,PRCF("CIDA"),0),U,15)
 D SUMM
BOC ; Ask for BOC
 N CNT,CNT1,PRCFEEE,PRCFEX,PRCFEXIT,PRCFN,PRCFNO
 S PRCFNO="",CNT1=0
 F  S PRCFNO=$O(PRCFX("SA",PRCFNO)) Q:PRCFNO=""  S CNT1=CNT1+1,BOC=PRCFNO
 I CNT1=1 D ASK2^PRCFDA2 Q:$D(DIRUT)  S DA=$G(PRCFNUM) G:$G(PRCFEXIT)&($G(PRCFFLG)) DOC G:'$G(PRCFFLG) EXIT
 I CNT1<1 W !!?5,"There are no BOCs on this obligation, processing terminated." G EX^PRCFDA2
 I CNT1>1 D ASK^PRCFDA2 Q:$D(DIRUT)  S DA=$G(PRCFNUM) G:$G(PRCFEX)&($G(PRCFFLG)) DOC G:'$G(PRCFFLG) EXIT
 I $G(PRCFCIDA)']"",($G(PRCF("CIDA"))']"") W !!?15,"Exiting." Q
 I $G(PRCF("CIDA"))']"" S PRCF("CIDA")=PRCFCIDA
 I '$D(^PRCF(421.5,PRCF("CIDA"),5,0)) S ^PRCF(421.5,PRCF("CIDA"),5,0)="^"_$P(^DD(421.5,41,0),U,2)
 I '$D(^PRCF(421.5,PRCF("CIDA"),5,$G(PRCFNUM),0)) D
 . S ^PRCF(421.5,PRCF("CIDA"),5,"B",BOC,PRCFNUM)=""
 . S $P(^PRCF(421.5,PRCF("CIDA"),5,0),U,3)=PRCFNUM
 . S $P(^PRCF(421.5,PRCF("CIDA"),5,0),U,4)=$P(^PRCF(421.5,PRCF("CIDA"),5,0),U,4)+1
 . S ^PRCF(421.5,PRCF("CIDA"),5,PRCFNUM,0)=BOC
 S DA(1)=PRCF("CIDA")
 S DIE="^PRCF(421.5,"_DA(1)_",5,"
 S DR=".01///^S X=BOC;4///^S X=$P(PRCFX(""SA"",BOC,PRCFNUM),U,2)"
 ; if one BOC has goods/serv and shipping, stuff corrected amt in
 ; accouting line amount
 I CNT1=1 D
 . S PRCFEEE=0 S PRCFEEE=$O(PRCFX("SA",BOC,PRCFEEE)) I PRCFEEE]"",($O(PRCFX("SA",BOC,PRCFEEE))]"") D
 . . I $P(PRCFX("SA",BOC,PRCFNUM),U,2)'=991 S PRCFN=PRCF("CAMT")-$P(^PRCF(421.5,PRCF("CIDA"),0),U,14)
 . . I $P(PRCFX("SA",BOC,PRCFNUM),U,2)=991 S PRCFN=$P(^PRCF(421.5,PRCF("CIDA"),0),U,14)
 . . S DR=DR_";1///^S X=$G(PRCFN)/100"
 . . Q
 . Q
 D ^DIE I $D(Y)!$D(DTOUT) G OT
 K DA,DIE,DR
EDIT ; edit the FMS line entry in 421.5
 S DA=PRCFNUM
 S DA(1)=PRCF("CIDA")
 S DIE="^PRCF(421.5,"_DA(1)_",5,"
 S PRCFA("LNO")=+$P(PRCFX("SA",BOC,PRCFNUM),U,2)
 W !,"FMS Line # ",PRCFA("LNO")
 S PRCFA("AMT")=$FN($P(PRCFX("SA",BOC,PRCFNUM),U),"",2)
 W !,"OBLIGATION AMOUNT: ",PRCFA("AMT")
 S DR="1//^S X=$S($G(PRCF(""CAMT""))/100>PRCFA(""AMT""):PRCFA(""AMT""),1:$G(PRCF(""CAMT""))/100)"
 D ^DIE K DR I $D(Y)!$D(DTOUT) G OT
 S X=$FN(X,"",2)
 S PRCFA("LAMT")=X
 D DISC^PRCFDT
 I PRCFA("LIQ")>PRCFA("AMT") W !,"Warning - Computed Liquidation amt of $",$FN(PRCFA("LIQ"),"",2)," exceeds",!?5,"total obligated amt of $",$FN(PRCFA("AMT"),"",2)," for BOC ",BOC," on ",$P($G(^PRCF(421.5,PRCF("CIDA"),1)),U,3),"."
 I PRCFA("LIQ")'=PRCFA("AMT") S DR="2////@" D ^DIE K DR
 S DR="2//^S X=$G(PRCFA(""LIQ""))" D ^DIE K DR I $D(Y)!$D(DTOUT) G OT
 S PRCFA("LIQ")=X,PRCFA("PF")=""
 I +PRCFA("AMT")=+PRCFA("LIQ") S PRCFA("PF")="F"
 I +PRCFA("AMT")>+PRCFA("LIQ") S PRCFA("PF")="P"
 S DR="3//^S X=$G(PRCFA(""PF""))" D ^DIE K DR I $D(Y)!$D(DTOUT) G OT
 D SUM^PRCFDT I '$G(OK) W !!?2,"****WARNING**** - Certified Invoice total $",$FN(PRCF("CAMT")/100,"",2)," does not match sum of",!,"Line Amounts: $",$FN(PRCF("TAMT"),"",2)
 I '$G(OK) W !?7,"If you believe that the Total Invoice Amount Certified for",!,"payment is incorrect, the invoice should be returned to voucher audit",!,"for review." G BOC
 I +PRCF("TAMT")=0 W !?2,"There are no Line Amounts - FMS will not accept this!"
 G DOC
DOC ;PROCESS FMS DOC
 I '$$OBLIG^PRCFDT(.PRC10DA) D  G EX^PRCFDA2
 . I '$D(PRCF("PO")) S PRCF("PO")=$P($G(^PRC(442,PRCF("PODA"),0)),U,1)
 . S X="  An original FMS SO or MO document could not be found for "
 . S X=X_PRCF("PO")_".*" D MSG^PRCFQ
 . S X="  Please review obligation history for this Purchase Order.*"
 . D MSG^PRCFQ,PAUSE^PRCFDPVU
 . Q
 ;D AUTOACCR^PRCFDA4 G:$D(Y)!$D(DTOUT) EX^PRCFDA2 ;per Lyford SOAR
 K %A,%B S %A="OK to process this payment to FMS",%B="",%=2
 D ^PRCFYN G OT:%<1
 I %=2,($G(PRCFFLG)=2) G OT
 I %=2 G BOC
 G ^PRCFDA2
SUMM ; Display Accounting Summary - Entry Point from Input Template
 D:$D(PRCFX("SA"))
 . N BOC,I,J,SHIP,SUBTOT
 . W !,"Unliquidated obligation amounts and BOCs on this order are:"
 . I $G(PRCUNLIQ)]"" D
 . . S SUBTOT=PRCUNLIQ
 . . S BOC=$O(PRCFX("SA",0)) S BOC=$P($G(^PRCD(420.2,+BOC,0)),U)
 . . W:$G(SUBTOT)]"" !,$J("$"_$FN(SUBTOT,",",2),10) S SUBTOT=0
 . . W:$G(BOC)]"" ?12,BOC
 . . Q
 . I $G(PRCUNLIQ)']"" S I="",SUBTOT=0 F  S I=$O(PRCFX("SA",I)) Q:I=""  D
 . . S J="" F  S J=$O(PRCFX("SA",I,J)) Q:J=""  D
 . . . S SUBTOT=SUBTOT+$P(PRCFX("SA",I,J),U)
 . . . S BOC=$P($G(^PRCD(420.2,+I,0)),U),SHIP=$P(PRCFX("SA",I,J),U,3)
 . . W:I !,$J("$"_$FN(SUBTOT,",",2),10) S SUBTOT=0
 . . S:SHIP BOC=$E(BOC,1,30) W ?12,BOC
 . . W:SHIP ?40,"  **(Includes $",$FN(PRCFX("SHAMT"),",",2)
 . . W:SHIP " shipping.)"
 . . Q
 . K PRCUNLIQ
 . W !,"Total Invoice Amount Certified for Payment=$"
 . W $J(PRCF("CAMT")/100,0,2)
 . Q
 Q
OT D UNP K ^TMP("PRCFDA",$J,"LIQ")
 S X="  <Option Terminated.>*" D MSG^PRCFQ G EX^PRCFDA2
NUMSTA() ;Determine number of unique stations in IFCAP system
 N X,I S X="",I=0
 F  S X=$O(^PRC(411,"B",X)) Q:X'?1.N  S I=I+1
 Q I
EXIT ; IF NO fms line BOC chosen,display message and exit
 W ! D  G EX^PRCFDA2
 . S X="  Edit exited abnormally.  Action terminated.*" D MSG^PRCFQ
 . S %A="Do you want to return this invoice to Voucher Audit"
 . S %B="",%=2 D ^PRCFYN I %=1 S X=10 D STATUS^PRCFDE1
 . Q
 Q
UNP ; Check for posted liquidation amounts and unpost
 S X=$G(^TMP("PRCFDA",$J,"LIQ"))
 Q:X=""  N DA,DIK,LAMT,PO,PRCFA,ZX1
 S LAMT=$P(X,U,1),PRCFA("PODA")=$P(X,U,2),ZX1=$P(X,U,3),DA=$P(X,U,4)
 S DIK="^PRC(424," D ^DIK
 D POST^PRCH58LQ(.PRCFA,.LAMT,.PO)
 W !!,"Liquidation # ",ZX1," for ",$FN(LAMT,",",2)," has been deleted and unposted."
 Q
