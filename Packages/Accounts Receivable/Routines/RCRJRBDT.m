RCRJRBDT ;WISC/RFJ-bad debt retransmit ;9/2/10 8:47am
 ;;4.5;Accounts Receivable;**101,170,191,138,239,273,310,338,360**;Mar 20, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ; - deactivate this option with patch PRCA*4.5*239
 W !!,"This option may no longer be used to retransmit the Bad Debt"
 W !,"allowance estimates to FMS."
 W !!,"Please use the option 'Monthly NDB, SV and WR Regenerate' to"
 W !,"recalculate the allowance estimates and transmit them to FMS.",!!
 ;
 S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 ;
 Q
 ;
 ;
 N DA347,DATEMOYR,FMSDOCNO,GECSDATA,RCRJFSV
 ;  the date of the report is for previous month if the DT is before the EOAM date of the current month,  it is for the current month if the date is after the EOAM cut-off date.
 I $E(DT,6,7)'>$E($$LDATE^RCRJR(DT),6,7) S DATEMOYR=$$PREVMONT^RCRJRBD(DT)
 I $E(DT,6,7)>$E($$LDATE^RCRJR(DT),6,7) S DATEMOYR=$E($$LDATE^RCRJR(DT),1,5)_"00"
 ;S DATEMOYR=$$PREVMONT^RCRJRBD(DT)
 W !!,"This option will retransmit the Bad Debt documents to FMS (SV23, SV27, SV2B)."
 ;
 ;I +$E(DT,6,7)<$$WD3^RCRJRBD D  Q
 I $E(DT,6,7)<$E($$LDATE^RCRJR(DT),6,7)!($E(DT,6,7)'<$E($$LDAY^RCRJR(DT),6,7)) D  Q
 .  W !,"The FMS documents will be automatically sent to FMS on the second to last ",!,"workday of this month."
 ;  try and find SV document to see if its accepted
 S FMSDOCNO=""
 K GECSDATA
 S DA347=$O(^RC(347,"D","SV-"_$E(DATEMOYR,1,5)_"01",0))
 I DA347 S FMSDOCNO=$P($G(^RC(347,DA347,0)),"^",9)
 ;  if there is an entry, find the code sheet in gcs to rebuild
 ;  gecsdata will be the ien for file 2100.1
 I FMSDOCNO'="" D DATA^GECSSGET(FMSDOCNO,0)
 I $G(GECSDATA) D
 .   W !!,"The SV document has been transmitted to fms, document number: "_FMSDOCNO
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="A" D  Q
 .   .   W !,"The SV document has been ACCEPTED in FMS and will not be resent."
 .   .   S RCRJFSV=1
 .   W !,"The SV document has NOT been ACCEPTED and will be RETRANSMITTED."
 I $G(RCRJFSV) Q
 ;
 I $$ASKOKAY(DATEMOYR)'=1 Q
 ;
 ;  make sure this code is not executed.
 ;W !!,"Re-sending the documents to FMS ..."
 ;D BADDEBT^RCXFMSSV
 ;W " Done.",!,"The Bad Debt Report will be sent to the G.FMS mail group."
 Q
 ;
 ;
ASKOKAY(DATEMOYR) ;  ask if its okay
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S Y=DATEMOYR D DD^%DT
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you SURE you want to resend the Bad Debt Report for "_Y
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ENDOFREP ;  print end of bad debt report footnotes
 ;  called from rcrjrbdr
 ;
 ;  print footnote
 S Y=RCRJDATE D DD^%DT S ENDDATE=Y
 F %=1:1 S DATA=$P($T(FOOTNOTE+%),";",3,99) Q:DATA=""  D
 .   I DATA["DATEREPT" S DATA=$P(DATA,"DATEREPT")_DATEREPT_$P(DATA,"DATEREPT",2)
 .   I DATA["ENDDATE" S DATA=$P(DATA,"ENDDATE")_ENDDATE_$P(DATA,"ENDDATE",2)
 .   D SETLINE^RCRJRBDR(DATA)
 Q
 ;
 ;
FOOTNOTE ;  report footnotes (from rcrjrbdr)
 ;;(1) Calculated Percentages and the Allowance for Contract Adj - Third Party
 ;;    for SGL 1339 are based on bills created prior to the activation of the
 ;;    Medicare Remittance Advice software.  Over time, there will no longer be
 ;;    any bills in this category.
 ;; 
 ;;(2) Calculated Percentages and the Allowance for Contract Adj - Third Party
 ;;    for SGL 133N are based on non-Medicare WNR bills created after the
 ;;    activation of the Medicare Remittance Advice software.
 ;; 
 ;;(3) The "Allowance Estimate for DATEREPT" is the dollar value estimated
 ;;    as the Allowance for Bad Debt or Contract Adjustment for the month.
 ;; 
 ;;(4) The "Bad Debt Write-Off (Plus)" is the actual write-offs or contract
 ;;    adjustments accomplished from FEB 1,1998 thru ENDDATE.
 ;; 
 ;;(5) The "Transmitted Amount to FMS for Month" is the sum of (3) and (4).
 ;;    The transmitted dollar value is normally a credit value.
 ;; 
 ;;(6) Facilities are responsible for reporting monthly accrued unbilled
 ;;    amounts.  When such amounts are identified and reported, a portion of
 ;;    those dollars should be reported as uncollectable.  The estimated
 ;;    uncollectable value of the unbilled amounts should be included as part
 ;;    of the facility's monthly allowance for bad debt or contract adjustments.
 ;;    The AR Override Option should be used to adjust the value provided to
 ;;    report the estimated uncollectable accrued unbilled amounts for the
 ;;    month.  Facilities may wish to consider using the allowance percentages
 ;;    provided with this report, if no other means of determining the
 ;;    estimated allowance for the accrued unbilled amount is acceptable.
 ;; 
 ;;(7) Only members in the facility's local RC AR DATA COLLECTOR mail group
 ;;    will receive this report.
 ;
 ;
 ;
BDR ; Compile new Bad Debt Report.
 ;   This code will be used to compile the new Bad Debt Report.
 ;   This routine is invokved by routine RCRJRBDR when the Bad
 ;   Debt Report needs to be printed.
 ;
 ;     Variable input:  LINE  --  set to 0
 ;                     SPACE  --  set to 81 space characters
 ;                  DATEREPT  --  formatted month and year
 ;
 N RCARR,RCX,RCD,RCDATA,RCREC,X
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
 ; PRCA*4.5*310/DRF - add fee basis fund (528713) to report
 ; PRCA*4.5*338/DRF - add fund (528714) to report
 D SETLINE(" ")
 D SETLINE($E(SPACE,1,26)_"Medical Care Collection Fund")
 D SETLINE($E(SPACE,1,2)_" Funds 528701; 528703; 528704; 528709; 528711; 528713; and 528714")
 D SETLINE($E(SPACE,1,2)_" ----------------------------------------------------------------")
 D SETLINE(" ")
 D SETLINE(" ")
 D SETLINE($E(SPACE,1,57)_"Contract           EOM")
 D SETLINE("FUND - SGL Account     Collection%     Write-Off%     Adjustment%     Allowance")
 D SETLINE(" ")
 ;
 ; List the fund/SGLs as:
 ;   Order     SGL in file      Fund - SGL on report
 ;   ===============================================
 ;     1            1319.3             528701 - 1319
 ;     2              1319             528703 - 1319
 ;     3            1319.4             528704 - 1319
 ;     4              1339             528704 - 1339
 ;     5              133N             528704 - 133N
 ;     6              1338             528704 - 1338
 ;     7            1319.2             528709 - 1319
 ;     8            1319.5             528711 - 1319
 ;     9            133N.2             528711 - 133N
 ;    10            1338.2             528711 - 1338
 ;    11            1319.6             528713 - 1319
 ;    12            1339.1             528713 - 1339
 ;    13            133N.3             528713 - 133N
 ;    14            1338.3             528713 - 1338
 ;    15            1319.7             528714 - 1319
 ;    16            1319.8             528714 - 1319
 ;    17            1319.9             528714 - 1319
 ;
 S RCARR(1)="1319.3^528701 - 1319"
 S RCARR(2)="1319^528703 - 1319"
 S RCARR(3)="1319.4^528704 - 1319"
 S RCARR(4)="1339^528704 - 1339"
 S RCARR(5)="133N^528704 - 133N"
 S RCARR(6)="1338^528704 - 1338"
 S RCARR(7)="1319.2^528709 - 1319"
 S RCARR(8)="1319.5^528711 - 1319"
 S RCARR(9)="133N.2^528711 - 133N"
 S RCARR(10)="1338.2^528711 - 1338"
 S RCARR(11)="1319.6^528713 - 1319"
 S RCARR(12)="1339.1^528713 - 1339"
 S RCARR(13)="133N.3^528713 - 133N"
 S RCARR(14)="1338.3^528713 - 1338"
 S RCARR(15)="1319.7^528714 - 1319.7"
 S RCARR(16)="1319.8^528714 - 1319.8"
 S RCARR(17)="1319.9^528714 - 1319.9"
 ;
 S RCX="" F  S RCX=$O(RCARR(RCX)) Q:RCX=""  S RCD=RCARR(RCX) D
 .S RCDATA=$G(^RC(348.1,+$O(^RC(348.1,"B",$P(RCD,"^"),0)),0))
 .Q:RCDATA=""
 .S RCREC=$P(RCD,"^",2)_$J($P(RCDATA,"^",2),21,2)
 .I RCD[528714 S RCREC=$P(RCD,"^",2)_$J($P(RCDATA,"^",2),19,2) ; patch PRCA*4.5*338 align subcategory format for first party 
 .S RCREC=RCREC_$J($P(RCDATA,"^",3),15,2)
 .S RCREC=RCREC_$J($P(RCDATA,"^",4),16,2)
 .S X=+$P(RCDATA,"^",8)
 .S X=$FN(X,",")_$S(X[".":"",1:".")_$E("00",$L($P(X,".",2))+1,2)
 .S RCREC=RCREC_$J(X,14)
 .D SETLINE(RCREC)
 ;
 D SETLINE(" ")
 D SETLINE(" ")
 D SETLINE("SGL Definitions")
 D SETLINE(" ")
 D SETLINE("1319   Allowance for Bad Debt")
 D SETLINE("1319.7 Allowance Community Care Inpatient/Outpatient/Urgent Care copayments")
 D SETLINE("1319.8 Allowance Community Care RX copayments")
 D SETLINE("1319.9 Allowance Community Care LTC copayments")
 D SETLINE("1338   Allowance for Tort Feasors")
 D SETLINE("1339   Allowance for Contract Adjustments pre-MRA (Medicare Remittance Advice)")
 D SETLINE("133N   Allowance for Contract Adjustments post-MRA")
 D SETLINE(" ")
 D SETLINE(" ")
 D SETLINE("Only members in the facility's local RC AR DATA COLLECTOR mail group")
 D SETLINE("will receive this report.")
 Q
 ;
SETLINE(DATA) ;  build the line for the report
 S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 Q
