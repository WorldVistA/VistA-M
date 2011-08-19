ENFACTT ;(WCIOFO)/SAB-FAP CAPITALIZATION THRESHOLD TASK ;5/29/2002
 ;;7.0;ENGINEERING;**63,71**;August 17, 1993
 Q
 ;
TASK ; One-time task to expense capitalized equipment that does not meet the
 ; new capitalization threshold
 ; input ENIO - output device for summary report
 ;
 K ^TMP($J,"BAD")
 K ^XTMP("ENFACTT")
 ;
 S ^XTMP("ENFACTT",0)=$$FMADD^XLFDT(DT,21)_U_DT
 S ^XTMP("ENFACTT",1)=0
 ;
RESTART N ENDA,ENFUND,ENEQ,ENSGL,ENSN,ENVAL,ENT,ENX
 ;  
 ; 1. Restore values in ENT array if compile needs to be restarted.
 ; 2. ^XTMP("ENFACTT","RESTART") is setup manaully.
 ; 3. ^XTMP("ENFACTT",1) has the next record to be processed.
 ;
 I $G(^XTMP("ENFACTT","RESTART"))=1 D
 . M ENT=^XTMP("ENFACTT",2)
 ;
 S ENDA=^XTMP("ENFACTT",1) ;Initial value of zero
 ;
 ; loop thru equipment in FA DOCUMENT LOG file
 F  S ENDA=$O(^ENG(6915.2,"B",ENDA)) Q:'ENDA  D
 . S ENEQ("DA")=ENDA
 . ;
 . S ^XTMP("ENFACTT",1)=ENDA ;Keep track of IEN
 . ;
 . Q:+$$CHKFA^ENFAUTL(ENDA)'>0  ; not currently reported to FA
 . ;
 . ;Data vaildation - No entry in the Equipment File
 . I '$D(^ENG(6914,ENDA)) D BAD^ENFACTX("NO ENTRY IN 6914") Q
 . ;
 . F I=2,8,9 K ENEQ(I) ;clear array
 . F I=2,8,9 S ENEQ(I)=$G(^ENG(6914,ENDA,I)) ;Get data from 6914
 . ;
 . ;Data vaildation - Check for missing nodes
 . ;   1. Node 2 has the Total Asset Value
 . ;   2. Node 8 has the Standard General Ledger
 . ;   3. Node 9 has Station no. and Fund no. 
 . ;
 . ;If missing do not place on report
 . I ENEQ(2)="" D BAD^ENFACTX("NODE 2 MISSING IN 6914")
 . I ENEQ(8)="" D BAD^ENFACTX("NODE 8 MISSING IN 6914")
 . I ENEQ(9)="" D BAD^ENFACTX("NODE 9 MISSING IN 6914")
 . ;
 . ;Missing pertinent information do not place on the report
 . I $D(^TMP($J,"BAD",ENDA)) Q
 . ;
 . ;Station Number - If missing do not process
 . S ENSN=$$GET1^DIQ(6914,ENDA_",",60)_" " S:ENSN=" " ENSN="UNK"
 . I ENSN="UNK" D BAD^ENFACTX("MISSING STATION NUMBER")
 . ;
 . ;Fund - If missing do not process
 . S ENFUND=$$GET1^DIQ(6914,ENDA_",",62)_" " S:ENFUND=" " ENFUND="UNK"
 . I ENFUND="UNK" D BAD^ENFACTX("MISSING FUND NUMBER")
 . ;
 . ;Standard General Ledger - If missing do not process
 . S ENSGL=$$GET1^DIQ(6914,ENDA_",",38) S:ENSGL="" ENSGL="UNK"
 . I ENSGL="UNK" D BAD^ENFACTX("MISSING GENERAL LEDGER NUMBER")
 . ;
 . ;Total asset value 
 . S ENVAL=$$GET1^DIQ(6914,ENDA_",",12) S:ENVAL="" ENVAL="UNK"
 . I ENVAL="UNK" D BAD^ENFACTX("MISSING TOTAL ASSET VALUE")
 . ;
 . ;Missing pertinent information do not place on the report
 . I $D(^TMP($J,"BAD",ENDA)) Q
 . ;
 . ; update capitalized count and amount
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,1)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U)+1
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,2)=$P(ENT(ENSN,ENFUND,ENSGL),U,2)+ENVAL
 . ;
 . ; quit if item should not be expensed
 . Q:$$CHKEXP^ENFACTU(ENDA)'>0
 . ;
 . ; expense it
 . S ENX=$$EXP^ENFACTX(ENDA)
 . ;
 . ; if not successful then ensure it is on problem list and quit
 . I 'ENX S:'$D(^TMP($J,"BAD",ENDA)) ^TMP($J,"BAD",ENDA)="" Q
 . ;
 . ; was successful so update expensed count and amount
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,3)=$P(ENT(ENSN,ENFUND,ENSGL),U,3)+1
 . S $P(ENT(ENSN,ENFUND,ENSGL),U,4)=$P(ENT(ENSN,ENFUND,ENSGL),U,4)+ENVAL
 . ;
 . ; Save data from array
 . S ^XTMP("ENFACTT",2,ENSN,ENFUND,ENSGL)=ENT(ENSN,ENFUND,ENSGL)
 ;
 ; save data for report in XTMP in case of problems during print
 K ^XTMP("ENFACT")
 S ^XTMP("ENFACT",0)=$$FMADD^XLFDT(DT,21)_U_DT ; purge date is T+21
 I $D(^TMP($J,"BAD")) M ^XTMP("ENFACT","BAD")=^TMP($J,"BAD")
 I $D(ENT) M ^XTMP("ENFACT","ENT")=ENT
 ;
QRPT ; queue a task to report results on device ENIO
 ; note: if a site needs to reprint the summary report for some reason
 ;       then enter the following commands at the programmer prompt
 ;        >S ENIO=name of an output device (.01 field of DEVICE file)
 ;        >D QRPT^ENFACTT
 S ZTRTN="RPT^ENFACTT"
 S ZTDESC="ENG Results of Capitalization Threshold Task"
 S ZTDTH=$H,ZTIO=ENIO
 D ^%ZTLOAD K ZTSK
 ;
 ; cleanup
 K ENIO
 K ^TMP($J,"BAD")
 S ZTREQ="@"
 Q
 ;
RPT ; report results
 ; Input
 ;   ^XTMP("ENFACT","ENT",station,fund,sgl)
 ;      = starting capitalized count ^ $ ^ expensed by task count ^ $
 ;   ^XTMP("ENFACT","BAD",ENDA) = # of problems for an equipment item
 ;   ^XTMP("ENFACT","BAD",ENDA,seqn #) = description of a problem
 ;
 N END,ENCAP,ENDA,ENDT,ENEXP,ENFUND,ENI,ENL,ENPG,ENSGL,ENSN,Y
 ;
 U IO
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENDT=Y
 S ENL="",$P(ENL,"-",IOM)=""
 D RPTHD
 ;
 ; first report problems
 W !,$S($D(^XTMP("ENFACT","BAD")):"Some",1:"No")
 W " problems were detected while expensing items.",!
 S ENDA=0 F  S ENDA=$O(^XTMP("ENFACT","BAD",ENDA)) Q:'ENDA  D
 . I $Y+6>IOSL D RPTHD
 . W !,"ERROR : Couldn't create FD Doc. for ENTRY # "_ENDA
 . W !,"REASON:"
 . ; List Problems with Equipment/Document if known
 . S ENI=0 F  S ENI=$O(^XTMP("ENFACT","BAD",ENDA,ENI)) Q:'ENI  D
 . . I $Y+4>IOSL D RPTHD
 . . I ENI=1 W " "_$G(^XTMP("ENFACT","BAD",ENDA,ENI)),! Q
 . . W "        "_$G(^XTMP("ENFACT","BAD",ENDA,ENI)),!
 ;
 ; display summary
 K ENT M ENT=^XTMP("ENFACT","ENT") ; load into local array
 I $Y+8>IOSL D RPTHD
 I '$D(ENT) W !,"No capitalized equipment was found."
 E  W ! D RPTHDS
 ; loop thru ENT( by station, fund, SGL
 S ENSN="" F  S ENSN=$O(ENT(ENSN)) Q:ENSN=""  D
 . S ENFUND="" F  S ENFUND=$O(ENT(ENSN,ENFUND)) Q:ENFUND=""  D
 . . S ENSGL="" F  S ENSGL=$O(ENT(ENSN,ENFUND,ENSGL)) Q:ENSGL=""  D
 . . . I $Y+6>IOSL D RPTHD,RPTHDS
 . . . W !,?3,ENSN,?12,ENFUND,?20,ENSGL
 . . . S ENX=$G(ENT(ENSN,ENFUND,ENSGL))
 . . . W ?27,$J($FN($P(ENX,U,1),",",0),5)
 . . . W ?33,$J($FN($P(ENX,U,2),",",2),14)
 . . . W ?50,$J($FN($P(ENX,U,3),",",0),5)
 . . . W ?56,$J($FN($P(ENX,U,4),",",2),14)
 . . . ; add to subtotals for station
 . . . S $P(ENT(ENSN),U,1)=$P($G(ENT(ENSN)),U,1)+$P(ENX,U,1)
 . . . S $P(ENT(ENSN),U,2)=$P(ENT(ENSN),U,2)+$P(ENX,U,2)
 . . . S $P(ENT(ENSN),U,3)=$P(ENT(ENSN),U,3)+$P(ENX,U,3)
 . . . S $P(ENT(ENSN),U,4)=$P(ENT(ENSN),U,4)+$P(ENX,U,4)
 . ; print subtotals for station
 . W !,?27,"-----",?33,"--------------"
 . W ?50,"-----",?56,"--------------"
 . W !,?3,ENSN,"totals"
 . W ?27,$J($FN($P(ENT(ENSN),U,1),",",0),5)
 . W ?33,$J($FN($P(ENT(ENSN),U,2),",",2),14)
 . W ?50,$J($FN($P(ENT(ENSN),U,3),",",0),5)
 . W ?56,$J($FN($P(ENT(ENSN),U,4),",",2),14),!
 ;
 ; wrapup
 K ENT
 S ZTREQ="@"
 D ^%ZISC
 Q
 ;
RPTHD ; page header
 W @IOF
 S ENPG=ENPG+1
 W !,"RESULTS OF ONE-TIME TASK TO EXPENSE EQUIP."
 W ?48,ENDT,?72,"page ",ENPG
 W !,ENL
 Q
RPTHDS ; summary header
 W !,"                           Totals before task     Expensed by Task"
 W !,"   Station  Fund    SGL    Count  $ Amount        Count  $ Amount"
 W !,"   -------  ------  ----   ----- --------------   ----- --------------"
 Q
 ;
REPRINT ;Call at this tag to reprint (ENG*7*71)
 ;
 W !,"PLEASE ENTER A VALID DEVICE TO REPRINT THE REPORT"
 W !,"           ** Do Not Use P-Message **",!!
 ;
 D ^%ZIS
 I IO=IO(0) D RPT^ENFACTT Q
 S ENIO=ION D QRPT^ENFACTT
 ;
 Q
 ;
 ;ENFACTT
