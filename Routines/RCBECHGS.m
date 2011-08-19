RCBECHGS ;WISC/RFJ-add charges to an account or bill (top routine) ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,237**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
FIRSTPTY ;  add int/admin charges to all benefit debts
 ;  this entry point is called from CCPC on the
 ;  statement day
 ;  variable rclasdat passed equal to statement date
 ;
 N RCDEBTDA
 K ^TMP("RCBECHGS REPORT",$J)  ;used to generate mailman report
 ;
 ;  check statement date
 I +$E(RCLASDAT,6,7)'=+$P($G(^RC(342,1,0)),"^",11) Q
 ;
 ;  lock the int/admin update to prevent two jobs from applying
 ;  the charges at the same time
 L +^RCD(340,"RCBECHGS")
 ;
 S RCDEBTDA=0 F  S RCDEBTDA=$O(^RCD(340,"AB","DPT(",RCDEBTDA)) Q:'RCDEBTDA  D CHGACCT(RCDEBTDA,RCLASDAT)
 ;
 ;  clear the lock
 L -^RCD(340,"RCBECHGS")
 ;
 ;  generate mailman report showing all charges added
 D REPORT^RCBECHGU
 ;
 K ^TMP("RCBECHGS REPORT",$J)
 Q
 ;
 ;
NONBENE ;  add int/adm/penalty charges to all non-benefit debts
 ;  this includes vendor, employee, ex-employee.
 ;  this is called by prcabj.  it does not update first party
 ;  debts since they work off a set statement day where as
 ;  non-benefit debts could be any statement day.
 ;
 N RCDEBTDA,RCLASDAT
 K ^TMP("RCBECHGS REPORT",$J)  ;used to generate mailman report
 ;
 ;  lock the int/admin update to prevent two jobs from applying
 ;  the charges at the same time
 L +^RCD(340,"RCBECHGS")
 ;
 ;  get the last date the system was last updated
 S RCLASDAT=$P($P(^RC(342,1,0),"^",10),".")
 ;  loop all days from the last update date up to today
 ;  this will make sure all accounts are updated for missed days
 F  S RCLASDAT=$$FMADD^XLFDT(RCLASDAT,1) Q:RCLASDAT>DT  D
 .   S RCDEBTDA=0
 .   F  S RCDEBTDA=$O(^RCD(340,"AC",+$E(RCLASDAT,6,7),RCDEBTDA)) Q:'RCDEBTDA  D
 .   .   ;  do not look at first party debts here
 .   .   I $P($G(^RCD(340,RCDEBTDA,0)),"^")["DPT(" Q
 .   .   ;  add int/admin to non-benefit debts
 .   .   D CHGACCT(RCDEBTDA,RCLASDAT)
 ;
 ;  clear the lock
 L -^RCD(340,"RCBECHGS")
 ;
 ;  generate mailman report showing all charges added
 D REPORT^RCBECHGU
 ;
 K ^TMP("RCBECHGS REPORT",$J)
 Q
 ;
 ;
CHGACCT(RCDEBTDA,RCUPDATE) ;  get bills for debtor and add charges
 ;  for a given date in rcupdate
 N DAYSINT,DFN,FROMDATE,RCBILLDA,RCDATA0,RCDATA6,RCDATE,RCLASTDT,RCSTATUS,VA,VADM,VAERR,X
 S RCDATA0=$G(^RCD(340,RCDEBTDA,0))
 ;  do not add charges for insurance companies
 I $P(RCDATA0,"^")["DIC(36" Q
 ;  if first party and patient is dead, do not add charges
 I $P(RCDATA0,"^")["DPT(" S DFN=+$P(RCDATA0,"^") D DEM^VADPT I +VADM(6) Q
 ;If Emergency Response Indicator flag is set quit out, do not add charges.
 I $P(RCDATA0,"^")["DPT(",$$EMERES^PRCAUTL(+$P(RCDATA0,"^"))]"" Q
 ;  lock the debtor to show charges being applied
 L +^RCD(340,RCDEBTDA)
 ;
 ;  loop thru all bills in active (16) and suspended (40) status
 ;  build a list of bills sorted by the date bill prepared
 K ^TMP("RCBECHGS",$J)
 F RCSTATUS=16,40 D
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"AS",RCDEBTDA,RCSTATUS,RCBILLDA)) Q:'RCBILLDA  D
 .   .   ;  hold letter date (field 21) is set for bill
 .   .   I $G(^PRCA(430,RCBILLDA,1)) Q
 .   .   ;  no letter1 sent
 .   .   I '$G(^PRCA(430,RCBILLDA,6)) Q
 .   .   ;  no principal balance
 .   .   I '$P($G(^PRCA(430,RCBILLDA,7)),"^") Q
 .   .   ;  no date bill prepared
 .   .   I '$P(^PRCA(430,RCBILLDA,0),"^",10) Q
 .   .   ;  store the bills in date prepared order
 .   .   S ^TMP("RCBECHGS",$J,"LIST",$P(^PRCA(430,RCBILLDA,0),"^",10),RCBILLDA)=""
 ;
 ;  *** calculate interest ***
 D INTEREST^RCBECHGI
 ;
 ;  *** calculate admin ***
 D ADMIN^RCBECHGA
 ;
 ;  *** calculate penalty ***
 ;  penalty charges are not assessed on a first party account
 I $P(RCDATA0,"^")'["DPT(" D PENALTY^RCBECHGP
 ;
 ;  *** add charges to bills for this account ***
 D ADDCHARG^RCBECHGU
 ;
 ;  clear the lock on the debtor
 L -^RCD(340,RCDEBTDA)
 ;
 K ^TMP("RCBECHGS",$J)
 Q
