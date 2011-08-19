RCRJRCOR ;WISC/RFJ-ar data collector summary report ;1 Mar 97
 ;;4.5;Accounts Receivable;**68,96,139,103,156,170,174,191,220,138,239**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SEND ;  send data to ndb and data to FMS
 N %,AMOUNT,DATEMOYR,FUND,LINE,RSC,SPACE,TOTAL,TOTALFUN,TOTALTYP,TYPE,X,XMY,Y
 ;
 ;  ---------- send to ndb ----------
 ;  data stored in tmp($j,rcrjrcolndb)
 I '$G(RCRJFAR1) D NDB(PRCASITE,DATEBEG,DATEEND)
 ;
 ;
 ;  ---------- send sv to fms ----------
 ;  data stored in tmp($j,rcrjrcolsv)
 ;  rcrjfsv is a flag set in the routine rcrjrco for retransmission
 ;  to prevent accepted fms documents from being resent
 I '$G(RCRJFSV) D STARTSV^RCXFMSSV(DATEEND)
 ;
 ;
 ;  ---------- send wr to fms ----------
 ;  data stored in tmp($j,rcrjrcolwr)
 ;  rcrjfwr is a flag set in the routine rcrjrco for retransmission
 ;  to prevent accepted fms documents from being resent
 I '$G(RCRJFWR) D STARTWR^RCXFMSWR(DATEEND)
 ;
 ;  ---------- send tr to fms ----------
 N RCTRANS
 ;  this call returns rctrans array (see rcxfmstx for description)
 ;  rcrjftr is a flag set in the routine rcrjrco for retransmission
 ;  to prevent accepted fms documents from being resent
 I '$G(RCRJFTR) D STARTTR^RCXFMSTX(DATEEND)
 ;
 ;  ---------- send oig extract ----------
 ;  data stored in tmp(j,rcrjroig)
 ;  get non-mccf bills for extract and user report
 D NONMCCF^RCRJROIG(DATEEND)
 ;  rcrjfoig is a flag set in the routine rcrjrco for retransmission
 ;  to prevent the oig extract from being resent
 I '$G(RCRJFOIG) D OIG^RCRJROIG(DATEEND)
 ;
 ;  generate a mailman message to the group showing the data
 K ^TMP($J,"RCRJRCORMM")
 S Y=$E(DATEEND,1,5)_"00" D DD^%DT S DATEMOYR=Y
 S LINE=0,SPACE="",$P(SPACE," ",80)=""
 D SET("Data has been collected for the month "_DATEMOYR_".  The data has been")
 D SET("transmitted to the following systems:")
 D SET(" ")
 ;
 I '$G(RCRJFAR1) D
 .   D SET("NATIONAL DATABASE DATA")
 .   D SET("----------------------")
 .   D SET("The data has been sent to the National Database.  For a detail list")
 .   D SET("of the data sent, please review the Return Reports which are sent")
 .   D SET("from the National Database.")
 .   D SET(" ")
 ;
 I '$G(RCRJFSV) D
 .   D SET("FMS, STANDARD VOUCHER (SV) DOCUMENT")
 .   D SET("-----------------------------------")
 .   D SET("The following data has been transmitted to FMS in the SV document:")
 .   D SET("  Revenue Source Code                                        Type       Amount")
 .   D SET("  -------------------                                        ----       ------")
 .   S TOTAL=0
 .   S TYPE="" F  S TYPE=$O(^TMP($J,"RCRJRCOLSV",TYPE)) Q:TYPE=""  D
 .   .   I TYPE=17!(TYPE=18) Q    ; display the Medicare totals later
 .   .   S TOTALTYP=0
 .   .   S FUND="" F  S FUND=$O(^TMP($J,"RCRJRCOLSV",TYPE,FUND)) Q:FUND=""  D
 .   .   .   S TOTALFUN=0
 .   .   .   S RSC="" F  S RSC=$O(^TMP($J,"RCRJRCOLSV",TYPE,FUND,RSC)) Q:RSC=""  S AMOUNT=^(RSC) D
 .   .   .   .   D SET("  "_RSC_" "_$E($$GETDESC^RCXFMSPR(RSC)_SPACE,1,54)_"  "_TYPE_$J(AMOUNT,13,2))
 .   .   .   .   S TOTALFUN=TOTALFUN+AMOUNT
 .   .   .   .   S TOTALTYP=TOTALTYP+AMOUNT
 .   .   .   .   S TOTAL=TOTAL+AMOUNT
 .   .   .   ;
 .   .   .   N RCFUND S RCFUND=$S($E(DATEEND,2,5)<"0410":$E(FUND,1,4)_"."_$E(FUND,6),1:$E(FUND,1,4)_"0"_$E(FUND,6))
 .   .   .   I TYPE=21 D SET($E("            Sub-Total by Fund "_RCFUND_":"_SPACE,1,38)_$J(TOTALFUN,12,2))
 .   .   ;
 .   .   D SET("                                                                    ----------")
 .   .   D SET("                                                    TOTAL TYPE "_TYPE_$J(TOTALTYP,13,2))
 .   .   D SET(" ")
 .   ;
 .   ; Display Medicare totals and update the SV total
 .   S AMOUNT=+$G(^TMP($J,"RCRJRCOLSV",17)),TOTAL=TOTAL+AMOUNT
 .   D SET("       Medicare Contractual Adjustment              TOTAL TYPE 17"_$J(AMOUNT,13,2))
 .   S AMOUNT=+$G(^TMP($J,"RCRJRCOLSV",18)),TOTAL=TOTAL+AMOUNT
 .   D SET("       Unreimbursable Medicare Expense              TOTAL TYPE 18"_$J(AMOUNT,13,2))
 .   D SET(" ")
 .   ;
 .   D SET("                                                                    ----------")
 .   D SET("                                                         TOTAL SV"_$J(TOTAL,13,2))
 .   D SET(" ")
 ;
 I '$G(RCRJFWR) D
 .   D SET("FMS, WRITEOFFS/CONTRACT ADJUSTMENTS (WR) DOCUMENT")
 .   D SET("-------------------------------------------------")
 .   D SET("The following data has been transmitted to FMS in the WR document:")
 .   D SET("  Revenue Source Code                                        Type       Amount")
 .   D SET("  -------------------                                        ----       ------")
 .   S TOTAL=0
 .   S TYPE="" F  S TYPE=$O(^TMP($J,"RCRJRCOLWR",TYPE)) Q:TYPE=""  D
 .   .   S TOTALTYP=0
 .   .   S FUND="" F  S FUND=$O(^TMP($J,"RCRJRCOLWR",TYPE,FUND)) Q:FUND=""  D
 .   .   .   S TOTALFUN=0
 .   .   .   S RSC="" F  S RSC=$O(^TMP($J,"RCRJRCOLWR",TYPE,FUND,RSC)) Q:RSC=""  S AMOUNT=^(RSC) D
 .   .   .   .   D SET("  "_RSC_" "_$E($$GETDESC^RCXFMSPR(RSC)_SPACE,1,54)_"  "_TYPE_$J(AMOUNT,13,2))
 .   .   .   .   S TOTALFUN=TOTALFUN+AMOUNT
 .   .   .   .   S TOTALTYP=TOTALTYP+AMOUNT
 .   .   .   .   S TOTAL=TOTAL+AMOUNT
 .   .   .   ;
 .   .   .   N RCFUND S RCFUND=$S($E(DATEEND,2,5)<"0410":$E(FUND,1,4)_"."_$E(FUND,6),1:$E(FUND,1,4)_"0"_$E(FUND,6))
 .   .   .   I TYPE=37 D SET($E("            Sub-Total by Fund "_RCFUND_":"_SPACE,1,38)_$J(TOTALFUN,12,2))
 .   .   ;
 .   .   D SET("                                                                    ----------")
 .   .   D SET("                                                    TOTAL TYPE "_TYPE_$J(TOTALTYP,13,2))
 .   .   D SET(" ")
 .   D SET("                                                                    ----------")
 .   D SET("                                                         TOTAL WR"_$J(TOTAL,13,2))
 .   D SET(" ")
 ;
 I '$G(RCRJFTR) D
 .   D SET("FMS, TRANSFER FROM MCCF TO HSIF (TR) DOCUMENT")
 .   D SET("-------------------------------------------------")
 .   D SET("The following data has been transmitted to FMS in the TR document:")
 .   D SET("  From Fund    From RSC       To Fund    To RSC                         Amount")
 .   D SET("  ---------    --------       -------    ------                     ----------")
 .   I $O(RCTRANS(""))="" D SET("  No Dollars to Transfer.") Q
 .   ;
 .   S FUND="" F  S FUND=$O(RCTRANS(FUND)) Q:FUND=""  D
 .   .   S RSC="" F  S RSC=$O(RCTRANS(FUND,RSC)) Q:RSC=""  D
 .   .   .   ;  rctrans(fromfund,fromrsc) = tofund ^ torsc ^ amount
 .   .   .   S AMOUNT=RCTRANS(FUND,RSC)
 .   .   .   D SET($J(FUND,11)_$J(RSC,12)_$J($P(AMOUNT,"^"),14)_$J($P(AMOUNT,"^",2),10)_$J($P(AMOUNT,"^",3),31,2))
 ;
 S XMY("G.RC AR DATA COLLECTOR")=""
 S %=$$SENDMSG("AR Data Collector for "_DATEMOYR_" Station "_PRCASITE,.XMY)
 K ^TMP($J,"RCRJRCORMM")
 ;
 ;  send users detail report
 D USERREPT^RCRJRCOU(DATEMOYR)
 Q
 ;
 ;
NDB(PRCASITE,DATEBEG,DATEEND) ;  send data to the national database
 N %,BATCNAME,COUNT,CRITERIA,DATA,LINE,XMY,X,Y
 K ^TMP($J,"RCRJRCORMM")
 S LINE=2,DATA="D$ "
 S CRITERIA="" F COUNT=1:1 S CRITERIA=$O(^TMP($J,"RCRJRCOLNDB",CRITERIA)) Q:CRITERIA=""  D
 .   S DATA=DATA_":"_COUNT_"/"_CRITERIA_"/"_^TMP($J,"RCRJRCOLNDB",CRITERIA)
 .   I $L(DATA)>200 D SET(DATA) S DATA="D$ "
 I DATA'="D$ " D SET(DATA)
 ;
 ;  build the first two control lines in mail message
 S Y=DATEBEG D DD^%DT
 S BATCNAME="AR1-"_$E(Y,1,3)_$E(DATEBEG,6,7)_$TR($P(Y,",",2)," ")
 S Y=DATEEND D DD^%DT
 S BATCNAME=BATCNAME_"-"_$E(Y,1,3)_$E(DATEEND,6,7)_$TR($P(Y,",",2)," ")
 S ^TMP($J,"RCRJRCORMM",1)="T$ "_PRCASITE_"$"_BATCNAME_"$$$$$*"
 ;  get end time (in %)
 D NOW^%DTC
 S ^TMP($J,"RCRJRCORMM",2)="S$ "_STRTTIME_"^"_%_"$0$"_(COUNT-1)
 ;
 S XMY("S.PRQN DATA COLLECTION MONITOR@FO-ALBANY.MED.VA.GOV")=""
 S %=$$SENDMSG("AR1 "_$E(DATEEND,4,5)_"/"_$E(DATEEND,2,3)_" NDB DATA FOR SITE "_PRCASITE,.XMY)
 K ^TMP($J,"RCRJRCORMM")
 Q
 ;
 ;
SUMMARY ;  print summary report in mailman bulletin
 N %,BILLDA,CRITER2,CRITERIA,DATA0,DFN,LINE,STAT,TOTAL,VA,XMY
 K ^TMP($J,"RCRJRCOR")   ; used to identify test patients
 K ^TMP($J,"RCRJRCORMM") ; used to build mailman message
 ;
 ;  print any test patient bills which have not been closed
 S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCRJRCOL","CRIT2",1,BILLDA)) Q:'BILLDA  I $D(^(BILLDA,1)) D
 .   S DATA0=$G(^PRCA(430,BILLDA,0)),STAT=$P(DATA0,"^",8)
 .   I STAT'=16,STAT='42 Q  ; bill not currently open
 .   S DFN=+$P(DATA0,"^",7) I 'DFN Q
 .   D PID^VADPT
 .   I $E($TR($G(VA("PID")),"-"),1,5)="00000" S ^TMP($J,"RCRJRCOR","TEST",BILLDA)=""
 ;
 I '$D(^TMP($J,"RCRJRCOR","TEST")) Q
 ;
 ;  print data
 S LINE=0
 D SET(" ")
 D SET("The following bills are active and linked to test patients:")
 S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCRJRCOR","TEST",BILLDA)) Q:'BILLDA  D SET("  "_$P($G(^PRCA(430,BILLDA,0)),"^")_" (#",BILLDA_")")
 ;
 S XMY("G.RC AR DATA COLLECTOR")=""
 S %=$$SENDMSG("MCCR DATA COLLECTOR INFORMATION",.XMY)
 K ^TMP($J,"RCRJRCOR")
 K ^TMP($J,"RCRJRCORMM")
 Q
 ;
 ;
SET(DATA)          ;  store report
 S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 Q
 ;
 ;
SENDMSG(XMSUB,XMY) ;  send message with subject and recipients
 N %X,D0,D1,D2,DIC,DICR,DIW,X,XCNP,XMDISPI,XMDUN,XMDUZ,XMTEXT,XMZ,ZTPAR
 S XMDUZ="AR PACKAGE",XMTEXT="^TMP($J,""RCRJRCORMM"","
 D ^XMD
 Q +$G(XMZ)
