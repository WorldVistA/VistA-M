QAPXFER ;557/THM-EXPORT A SURVEY [ 06/22/95  2:25 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 ;
 S IOP="HOME" D ^%ZIS,SCREEN^QAPUTIL S QAPHDR="Export a Survey"
ENTR W @IOF,! X QAPBAR
 S DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))"
 W !! S DIC="^QA(748,",DIC(0)="QEAM",DIC("A")="Enter the survey to export: " D ^DIC G:X=""!(X[U) K S SURVEY=+Y
 W !!,"Is this the correct survey" S %=2 D YN^DICN G:$D(DTOUT) K
 I $D(%Y),%Y["?" W !!,"Enter Y if it is the correct survey or N if not.  " H 2 G ENTR
 I %<1 G K
 I %=2 G ENTR
 ;
XFR K DIC,%,^TMP($J,"QAP")
 S SVYNAME=$P(^QA(748,SURVEY,0),U),SVYSITE=^DD("SITE")
 S %X="^QA(748,"_SURVEY_",",%Y="^TMP($J,""QAP"",999998," D %XY^%RCR
 S %X="^QA(748.25,"_SURVEY_",",%Y="^TMP($J,""QAP"",999999," D %XY^%RCR
 S ^TMP($J,"QAP",.5)=SVYNAME_U_SVYSITE
 S XMSUB="Import of Survey: "_SVYNAME,XMTEXT="^TMP($J,""QAP""," W !! S XMMG=$P(^VA(200,DUZ,0),U)
 ;all calls are supported APIs
 D XMZ^XMA2 W !!,"Loading survey . . .  " H 1 D ENT^XMPG
 S XMDUZ=DUZ,XMDUN=$P(^VA(200,DUZ,0),U) D DEST^XMA21
 D ENT1^XMD
 W !!,"Sent as message #",XMZ,!!!,"Press RETURN  " R ANS:DTIME
 K XMDUZ,XMDUN,XMY,XMZ,XMMG,XMSUB,XMTEXT,XCN,XMA,XMAP0R,XMDISPI,XMGAPI1,XMQF,XMXUSEC,ER
 ;
K G EXIT^QAPUTIL
