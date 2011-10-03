RCRJRBDR ;WISC/RFJ,TJK-bad debt report generator ;1 Feb 98
 ;;4.5;Accounts Receivable;**101,139,170,191,203,215,220,138,239**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report on printer, called from menu option
 N RCRJDATE
 W !!,"This option will print the Bad Debt Report.  The Bad Debt allowance"
 W !,"estimates are computed by the AR Data Collector at the end of the"
 W !,"accounting month, and sent to FMS at that time.  The allowance"
 W !,"estimate is no longer editable prior to transmission to FMS.",!
 N %ZIS,POP,ZTRTN,ZTDESC S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^RCRJRBDR",ZTDESC="Bad Debt Report"
 . D ^%ZTLOAD
 ;
 W !,"please wait"
 D DQ
 Q
 ;
 ;
DQ ;  generate the report
 ;  rcrjfmm = flag to put in mail message (if $g(rcrjfmm)) (optional)
 ;  rcrjdate = date month and year for report (optional)
 ;  rcrjfxsv = fms document id number if sent to fms (optional)
 ;             (newed and set by rcxfmssv, label Q)
 ;
 N %,%I,CHANGED,DATA,DATA1319,DATA1338,DATA1339,DATALTC,DATEREPT,ENDDATE,X
 N LINE,RCRJFLAG,SCREEN,SPACE,Y,DATA133N
 ;
 K ^TMP($J,"RCRJRCORMM")
 S SPACE="",$P(SPACE," ",81)=""
 ;  the date of the report is for previous month if the DT is before the EOAM date of the current month,  it is for the current month if the date is after the EOAM cut-off date.
 I $G(RCRJDATE) S RCRJDATE=$E($$LDATE^RCRJR(RCRJDATE),1,5)_"00"
 I '$G(RCRJDATE) D
 .I $E(DT,6,7)'>$E($$LDATE^RCRJR(DT),6,7) S RCRJDATE=$$PREVMONT^RCRJRBD(DT)
 .I $E(DT,6,7)>$E($$LDATE^RCRJR(DT),6,7) S RCRJDATE=$E($$LDATE^RCRJR(DT),1,5)_"00"
 S Y=$E(RCRJDATE,1,5)_"00" D DD^%DT S DATEREPT=Y
 S LINE=0
 ;
 ;  jump to RCRJRBDT to generate the new Bad Debt Report,
 ;  in order to save the code for the older report.
 D BDR^RCRJRBDT G MAIL
 ;
 D SETLINE(" ")
 D SETLINE($E(SPACE,1,32)_"Bad Debt Report")
 D SETLINE($E(SPACE,1,13)_"Allowance for Bad Debt and Contract Adjustment Report")
 D SETLINE($E(SPACE,1,27)_"for the month of "_DATEREPT)
 I $D(RCRJFXSV) D
 . D SETLINE(" ")
 . I $E(RCRJFXSV,1,2)="SV" D SETLINE($E(SPACE,1,13)_"***** Report sent to FMS, doc id: "_RCRJFXSV_" *****") Q
 . ;  report errored out or did not get generated to fms
 . D SETLINE($E(SPACE,1,10)_"***** NOTICE:  Report was NOT sent to FMS, the message is *****")
 . D SETLINE($E(SPACE,1,10)_"***** "_RCRJFXSV_" *****")
 ;
 ;  show mccf
 D SETLINE(" ")
 D SETLINE($E(SPACE,1,26)_"Medical Care Collection Fund")
 I $E($G(RCRJDATE),2,5)'<"0410" D SETLINE($E(SPACE,1,26)_" Funds 528701, 528703, & 528704")
 I $E($G(RCRJDATE),2,5)<"0410" D SETLINE($E(SPACE,1,26)_" Funds 5287.1, 5287.3, & 5287.4")
 D SETLINE($E(SPACE,1,26)_"----------------------------")
 D SETLINE(" ")
 D SETLINE("Calculated           "_$J("            ",14)_$J(" Third Party",14)_$J(" Third Party",14))
 D SETLINE("Percentages          "_$J(" First Party",14)_$J("    Cont Adj",14)_$J("    Cont Adj",14)_$J("Tort Feasors",14))
 D SETLINE("For                  "_$J("    SGL 1319",14)_$J("    SGL 1339",14)_$J("    SGL 133N",14)_$J("    SGL 1338",14))
 D SETLINE("---------------------"_$J("------------",14)_$J("------------",14)_$J("------------",14)_$J("------------",14))
 S DATA1319=$G(^RC(348.1,+$O(^RC(348.1,"B",1319,0)),0))
 S DATA1338=$G(^RC(348.1,+$O(^RC(348.1,"B",1338,0)),0))
 S DATA1339=$G(^RC(348.1,+$O(^RC(348.1,"B",1339,0)),0))
 S DATA133N=$G(^RC(348.1,+$O(^RC(348.1,"B","133N",0)),0))
 D SETLINE("Collection          %"_$J($P(DATA1319,"^",2),14,2)_$J($P(DATA1339,"^",2),14,2)_$J($P(DATA133N,"^",2),14,2)_$J($P(DATA1338,"^",2),14,2))
 D SETLINE("Write-Off           %"_$J($P(DATA1319,"^",3),14,2)_$J($P(DATA1339,"^",3),14,2)_$J($P(DATA133N,"^",3),14,2)_$J($P(DATA1338,"^",3),14,2))
 D SETLINE("Contract Adjustment %"_$J($P(DATA1319,"^",4),14,2)_$J($P(DATA1339,"^",4),14,2)_$J($P(DATA133N,"^",4),14,2)_$J($P(DATA1338,"^",4),14,2))
 D SETLINE("---------------------"_$J("------------",14)_$J("------------",14)_$J("------------",14)_$J("------------",14))
 D SETLINE("TOTAL               %"_$J(100,14,2)_$J(100,14,2)_$J(100,14,2)_$J(100,14,2))
 D SETLINE(" ")
 ;
 S DATALTC=$G(^RC(348.1,+$O(^RC(348.1,"B",1319.2,0)),0))
 I $E($G(RCRJDATE),2,5)'<"0410" D SETLINE($E(SPACE,1,26)_"  Extended (LTC) Care Fund 528709")
 I $E($G(RCRJDATE),2,5)<"0410" D SETLINE($E(SPACE,1,26)_"  Extended (LTC) Care Fund 4032")
 D SETLINE($E(SPACE,1,26)_"---------------------------------")
 D SETLINE(" ")
 I $E($G(RCRJDATE),2,5)'<"0410" D SETLINE("Calculated           "_$J("   Fund 528709",18))
 I $E($G(RCRJDATE),2,5)<"0410" D SETLINE("Calculated           "_$J("   Fund 4032",18))
 D SETLINE("Percentages          "_$J(" First Party",18))
 D SETLINE("For                  "_$J("    SGL 1319",18))
 D SETLINE("---------------------"_$J("------------",18))
 D SETLINE("Collection          %"_$J($P(DATALTC,"^",2),18,2))
 D SETLINE("Write-Off           %"_$J($P(DATALTC,"^",3),18,2))
 D SETLINE("Contract Adjustment %"_$J($P(DATALTC,"^",4),18,2))
 D SETLINE("---------------------"_$J("------------",18))
 D SETLINE("TOTAL               %"_$J(100,18,2))
 D SETLINE(" ")
 ;
 ;  show totals
 ;  1319 mccf allowance
 D SETLINE("Allowance for Bad Debt - First Party (SGL 1319 MCCF):")
 D SETLINE("----------------------------------------------------")
 S CHANGED="  " I $P(DATA1319,"^",10) S CHANGED="**"
 D SETLINE($E("Allowance Estimate for "_DATEREPT_SPACE,1,35)_":"_$J($P(DATA1319,"^",8),16,2)_" "_CHANGED_" (Normally Credit Value)")
 D SETLINE($E("Bad Debt Write-Off (Plus)  "_SPACE,1,35)_":"_$J($P(DATA1319,"^",9),16,2)_"    (Normally Debit Value )")
 D SETLINE("----------------------------------------------------")
 D SETLINE($E("Transmitted Amount to FMS for Month"_SPACE,1,35)_":"_$J($P(DATA1319,"^",8)+$P(DATA1319,"^",9),16,2)_" "_CHANGED_" (Normally Credit Value)")
 I $P(DATA1319,"^",10) D SETLINE($E(SPACE,1,53)_"**  Changed Locally")
 D SETLINE(" ")
 ;
 ;  1319 ltc allowance
 D SETLINE("Allowance for Bad Debt - First Party (SGL 1319 LTC 528709):")
 D SETLINE("----------------------------------------------------")
 S CHANGED="  " I $P(DATALTC,"^",10) S CHANGED="**"
 D SETLINE($E("Allowance Estimate for "_DATEREPT_SPACE,1,35)_":"_$J($P(DATALTC,"^",8),16,2)_" "_CHANGED_" (Normally Credit Value)")
 D SETLINE($E("Bad Debt Write-Off (Plus)  "_SPACE,1,35)_":"_$J($P(DATALTC,"^",9),16,2)_"    (Normally Debit Value )")
 D SETLINE("----------------------------------------------------")
 D SETLINE($E("Transmitted Amount to FMS for Month"_SPACE,1,35)_":"_$J($P(DATALTC,"^",8)+$P(DATALTC,"^",9),16,2)_" "_CHANGED_" (Normally Credit Value)")
 I $P(DATALTC,"^",10) D SETLINE($E(SPACE,1,53)_"**  Changed Locally")
 D SETLINE(" ")
 ;
 ;  1339 allowance
 D SETLINE("Allowance for Contract Adj - Third Party (SGL 1339):")
 D SETLINE("----------------------------------------------------")
 S CHANGED="  " I $P(DATA1339,"^",10) S CHANGED="**"
 D SETLINE($E("Allowance Estimate for "_DATEREPT_SPACE,1,35)_":"_$J($P(DATA1339,"^",8),16,2)_" "_CHANGED_" (Normally Credit Value)")
 D SETLINE($E("Bad Debt Contract Adj (Plus)  "_SPACE,1,35)_":"_$J($P(DATA1339,"^",9),16,2)_"    (Normally Debit Value )")
 D SETLINE("----------------------------------------------------")
 D SETLINE($E("Transmitted Amount to FMS for Month"_SPACE,1,35)_":"_$J($P(DATA1339,"^",8)+$P(DATA1339,"^",9),16,2)_" "_CHANGED_" (Normally Credit Value)")
 I $P(DATA1339,"^",10) D SETLINE($E(SPACE,1,53)_"**  Changed Locally")
 D SETLINE(" ")
 ;
 ;  133N allowance - Post-MRA non-Medicare
 D SETLINE("Allowance for Contract Adj - Third Party (SGL 133N):")
 D SETLINE("----------------------------------------------------")
 S CHANGED="  " I $P(DATA133N,"^",10) S CHANGED="**"
 D SETLINE($E("Allowance Estimate for "_DATEREPT_SPACE,1,35)_":"_$J($P(DATA133N,"^",8),16,2)_" "_CHANGED_" (Normally Credit Value)")
 D SETLINE($E("Bad Debt Contract Adj (Plus)  "_SPACE,1,35)_":"_$J($P(DATA133N,"^",9),16,2)_"    (Normally Debit Value )")
 D SETLINE("----------------------------------------------------")
 D SETLINE($E("Transmitted Amount to FMS for Month"_SPACE,1,35)_":"_$J($P(DATA133N,"^",8)+$P(DATA133N,"^",9),16,2)_" "_CHANGED_" (Normally Credit Value)")
 I $P(DATA133N,"^",10) D SETLINE($E(SPACE,1,53)_"**  Changed Locally")
 D SETLINE(" ")
 ;
 ;  1338 allowance
 D SETLINE("Allowance for Bad Debt - Tort Feasors (SGL 1338):")
 D SETLINE("----------------------------------------------------")
 S CHANGED="  " I $P(DATA1338,"^",10) S CHANGED="**"
 D SETLINE($E("Allowance Estimate for "_DATEREPT_SPACE,1,35)_":"_$J($P(DATA1338,"^",8),16,2)_" "_CHANGED_" (Normally Credit Value)")
 D SETLINE($E("Bad Debt Write-Off (Plus)  "_SPACE,1,35)_":"_$J($P(DATA1338,"^",9),16,2)_"    (Normally Debit Value )")
 D SETLINE("----------------------------------------------------")
 D SETLINE($E("Transmitted Amount to FMS for Month"_SPACE,1,35)_":"_$J($P(DATA1338,"^",8)+$P(DATA1338,"^",9),16,2)_" "_CHANGED_" (Normally Credit Value)")
 I $P(DATA1338,"^",10) D SETLINE($E(SPACE,1,53)_"**  Changed Locally")
 D SETLINE(" ")
 D SETLINE("Report Footnotes:")
 D SETLINE("-----------------")
 ;
 D ENDOFREP^RCRJRBDT
 ;
MAIL ;  put report in mailman
 I $G(RCRJFMM) D  D Q Q
 . N XMY
 . S XMY("G.RC AR DATA COLLECTOR")=""
 . S %=$$SENDMSG^RCRJRCOR("BAD DEBT REPORT",.XMY)
 ;
 ;  print report
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO I SCREEN W @IOF
 S LINE=1 F  S LINE=$O(^TMP($J,"RCRJRCORMM",LINE)) Q:'LINE!($G(RCRJFLAG))  D
 . I $Y>(IOSL-5) D:SCREEN PAUSE^RCRJRTR1 Q:$G(RCRJFLAG)  W @IOF F %=2:1:5 W !,^TMP($J,"RCRJRCORMM",%)
 . W !,^TMP($J,"RCRJRCORMM",LINE)
 I '$G(RCRJFLAG),SCREEN R !!,"<end of report, press return to continue>",X:DTIME
 D ^%ZISC
 ;
Q K ^TMP($J,"RCRJRCORMM")
 Q
 ;
 ;
SETLINE(DATA) ;  build the line for the report
 S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 Q
