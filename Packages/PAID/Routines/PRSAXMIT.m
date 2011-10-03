PRSAXMIT ; HISC/FPT-Transmit 8B Records ;8/17/95  08:45
 ;;4.0;PAID;;Sep 21, 1995
 ;                       VARIABLES USED
 ;                       --------- ----
 ;  EMPCNT  = number of employees processed
 ;  IEN     = employee's internal entry number (file 450)
 ;  LENGTH  = length of 8b record
 ;  LOOP    = for loop variable
 ;  PPE     = pay period
 ;  PPI     = pay period internal entry number
 ;  RECCNT  = number of records per message
 ;  RECORD  = 8b record
 ;  STUB    = characters 1 thru 32 of the 8b record
 ;  SN      = station number
 ;  TLE     = t&l unit number
 ;  TLI     = t&l unit internal entry number (#455.5)
 ;  TRECCNT = total number of records transmitted
 ;
 ;                       ARRAYS USED
 ;                       ------ ----
 ;   ^TMP($J)        = 8b records that will be passed to xmtext
 ;   ^TMP("PRSA",$J) = employee iens (used to change status of record)
 ;
 K DIC S DIC="^PRST(458,",DIC(0)="AEMQZ" S PPI=$P($G(^PRST(458,0)),U,3) I PPI<1 D KILL Q
 S DIC("B")=$P(^PRST(458,PPI,0),U,1) D ^DIC K DIC I +Y<1 D KILL Q
 S PPI=+Y D CHECK G:YN["^" KILL
 S PPE=$P($P(^PRST(458,PPI,0),U),"-",2)
 K DIR S DIR(0)="Y",DIR("A")="Ready to Transmit to Austin",DIR("B")="NO"
 W ! D ^DIR K DIR I $D(DIRUT)!(Y=0) D KILL Q
 W !!,"Transmitting to Austin "
 K ^TMP("PRSA",$J),^TMP($J)
 S (EMPCNT,IEN,RECCNT,TRECCNT)=0
 F  S IEN=$O(^PRST(458,PPI,"E",IEN)) Q:IEN'>0  I $P($G(^PRST(458,PPI,"E",IEN,0)),U,2)="P" D PROCESS D:RECCNT>174 MAIL
 D:RECCNT>0 MAIL
 S X="N",%DT="XT" D ^%DT S NOW=+Y K %DT
 I EMPCNT>0 S $P(^PRST(458,PPI,0),U,2)=DUZ,$P(^PRST(458,PPI,0),U,3)=NOW,$P(^PRST(458,PPI,0),U,4)=$P(^PRST(458,PPI,0),U,4)+EMPCNT,$P(^PRST(458,PPI,0),U,5)=$P(^PRST(458,PPI,0),U,5)+TRECCNT
 ;
 W !!,EMPCNT," Employees Processed",!
KILL K DIR,DIROUT,DIRUT,DTOUT,DUOUT,EMPCNT,IEN,NOW,PPE,PPI,RECCNT,RECORD,SN,TLE,TLI,TRECCNT,X,Y Q
 ;
PROCESS ;
 S RECORD=$G(^PRST(458,PPI,"E",IEN,5))
 I RECORD="" W !,"8B record is missing for ",$P($G(^PRSPC(IEN,0)),U,1) Q
 S TLE=$E(RECORD,22,24)
 S EMPCNT=EMPCNT+1,STUB=$E(RECORD,1,32)
AGAIN I $L(RECORD)<81 S RECCNT=RECCNT+1,^TMP($J,RECCNT)=RECORD_$J("",80-$L(RECORD)) W:RECCNT#100=1 "." S ^TMP("PRSA",$J,IEN)="" K LENGTH,RECORD,STUB Q
 F LENGTH=80:-1:33 Q:$E(RECORD,LENGTH-1,LENGTH)?2U
 S RECCNT=RECCNT+1,^TMP($J,RECCNT)=$E(RECORD,1,LENGTH-2)_$J("",80-(LENGTH-2)),RECORD=STUB_$E(RECORD,LENGTH-1,$L(RECORD)) G AGAIN
 Q
 ;
MAIL ; call MailMan
 S XMDUZ=.5
 S XMY("G.TAB@"_^XMB("NETNAME"))=""
 S XMY("XXX@Q-TAB.VA.GOV")=""
 S SN=$P($G(^XMB(1,1,"XUS")),"^",17),SN=$S(+SN>0:$P($G(^DIC(4,SN,99)),"^",1),1:"")
 S XMSUB=^DD("SITE")_" ("_SN_") Payroll Data (Pay Period "_PPE_")"
 S XMTEXT="^TMP($J,",XMDUZ=.5 D ^XMD
 I XMZ>0 D
 .S LOOP=0 F  S LOOP=$O(^TMP("PRSA",$J,LOOP)) Q:LOOP'>0  S $P(^PRST(458,PPI,"E",LOOP,0),U,2)="X"
 .S:'$D(^PRST(458,PPI,"X",0)) ^PRST(458,PPI,"X",0)="^458.03P^^" K DIC,DD,DO S DIC="^PRST(458,PPI,""X"",",DIC(0)="L",DLAYGO=458,DA(1)=PPI,(X,DINUM)=XMZ D FILE^DICN K DIC,DINUM
 .D NOW^%DTC
 .S $P(^PRST(458,PPI,"X",+Y,0),U,2)=DUZ
 .S $P(^PRST(458,PPI,"X",+Y,0),U,3)=%
 .S TRECCNT=TRECCNT+RECCNT
 S RECCNT=0
 K %,^TMP("PRSA",$J),^TMP($J),DA,DD,DIC,DINUM,DLAYGO,DO,LOOP,X,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y,XMLOC,XMMG Q
CHECK ; Run 8B Edit Check
 W !!,"Edit Checks will now be run ...",!
 D CODES^PRSACED6 S YN="",COUNT=0,HDR=1
 S ATL="ATL00" F  S ATL=$O(^PRSPC(ATL)) Q:ATL'?1"ATL".E  S TL=$E(ATL,4,6),NAM="" F  S NAM=$O(^PRSPC(ATL,NAM)) Q:NAM=""  F DFN=0:0 S DFN=$O(^PRSPC(ATL,NAM,DFN)) Q:DFN<1  D  G:YN["^" AB
 .I '$D(^PRST(458,PPI,"E",DFN,5)) Q
 .I $P(^PRST(458,PPI,"E",DFN,0),"^",2)'="P" Q
 .S COUNT=COUNT+1 D ^PRSACED1 W:COUNT#50=1 "." Q
 Q
AB W !,"Edit Checks aborted. NO Transmission.",! Q
