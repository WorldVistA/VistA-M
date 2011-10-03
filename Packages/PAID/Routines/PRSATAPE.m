PRSATAPE ; HISC/FPT-Load 8B's onto Tape ;8/17/95  08:43
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ; HEADER   = header for tape
 ; IEN      = employee's internal entry number (file 450)
 ; LENGTH   = length of record
 ; LOOP     = 'for' loop variable
 ; MSGCNT   = mail message count
 ; NAME     = employee's name
 ; PPIEN    = pay period internal entry number (file 458)
 ; RECCNT   = number of 8b records
 ; RECORD   = 8b record
 ; STUB     = characters 1-32 of the 8b record
 ; SN       = station number
 ;
 Q
TAPE ; make a tape of 8b records
 S PPIEN=$P($G(^PRST(458,0)),U,3) I PPIEN<1 D KILL Q
 K DIC S DIC="^PRST(458,",DIC(0)="AEMQZ",DIC("B")=$P(^PRST(458,PPIEN,0),U,1) D ^DIC K DIC I +Y<1 D KILL Q
 S PPIEN=+Y
 K %ZIS S %ZIS("A")="Select TAPE Device: ",%ZIS("B")="",%ZIS="M" D ^%ZIS K %ZIS I POP D KILL,HOME^%ZIS Q
 U IO D LOAD D ^%ZISC,KILL Q
LOAD ; load records onto tape
 S SN=$P($G(^XMB(1,1,"XUS")),"^",17),SN=$S(+SN>0:$P($G(^DIC(4,SN,99)),"^",1),1:"")
 S XMSUB=^DD("SITE")_" ("_SN_") PAYROLL DATA (PAY PERIOD "_$P($P(^PRST(458,PPIEN,0),U),"-",2)_")"
 S XMSUB=XMSUB_$J("",80-$L(XMSUB)),XMSUB=$E(XMSUB,1,80) U IO W XMSUB
 S (IEN,RECCNT)=0
 F  S IEN=$O(^PRST(458,PPIEN,"E",IEN)) Q:IEN<1  D PROCESS I RECCNT#100=0 U IO(0) W "."
 U IO W "*** END ***"_$J("",69)
 Q
PROCESS ; write records onto tape
 I '$D(^PRST(458,PPIEN,"E",IEN,5)) S NAME=$P($G(^PRSPC(IEN,0)),U,1) U IO(0) W !,"Missing 8B Record for ",$S(NAME'="":NAME,1:IEN) K NAME Q
 S RECORD=^PRST(458,PPIEN,"E",IEN,5),STUB=$E(RECORD,1,32)
AGAIN I $L(RECORD)<81 S RECCNT=RECCNT+1 U IO W RECORD_$J("",80-$L(RECORD)) K LENGTH,RECORD,STUB Q
 F LENGTH=80:-1:33 Q:$E(RECORD,LENGTH-1,LENGTH)?2U
 U IO W $E(RECORD,1,LENGTH-2)_$J("",80-(LENGTH-2)) S RECCNT=RECCNT+1,RECORD=STUB_$E(RECORD,LENGTH-1,$L(RECORD)) G AGAIN
 Q
 ;
MAIL ; move 8b tape data into mail messages
 K %ZIS S %ZIS("A")="Select TAPE Device: ",%ZIS("B")="",%ZIS="M" D ^%ZIS K %ZIS I POP D KILL,HOME^%ZIS Q
 S (MSGCNT,RECCNT)=0 U IO R HEADER:60 D M1 D ^%ZISC
 W !!,RECCNT," Records / ",MSGCNT," Messages",!
KILL K %ZIS,HEADER,IEN,LOOP,MSGCNT,POP,PPIEN,RECCNT,SN,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
M1 ; move 8b records to mail messages
 K ^TMP($J) U IO F LOOP=1:1:175 R X:60 G:'$T!(X["*** END") M2 S ^TMP($J,LOOP,0)=X,RECCNT=RECCNT+1
 D M3 G M1
M2 I $D(^TMP($J)) D M3 K ^TMP($J)
 Q
M3 U IO(0) S XMY("XXX@Q-TAB.VA.GOV")="" U IO(0) W "."
 S XMSUB=HEADER
 S XMTEXT="^TMP($J,",XMDUZ=.5 D ^XMD S MSGCNT=MSGCNT+1
 Q
