PRSXP43 ;WCIOFO/JAH-POST INIT FOR PATCH 43 OT WARNINGS--8/18/98
 ;;4.0;PAID;**43**;Sep 21, 1995
 ;PAID
 ; Post install loops thru the pay period (pp) file (458) & looks for 
 ; situations where an overtime warning should appear on the Pay Period
 ; Exceptions report. If such condition occurs, warning is filed in the
 ; file 458.6 (OVERTIME WARNINGS)--new with patch 43 & used to maintain
 ; status of overtime warnings.  Payroll may later clear warnings
 ; thru the new option Overtime Warnings.
 Q
 ;
SERCH4OT ;
 N PPSTART,XPDIDTOT,PPI,PPE,PRSDIV,PRSPCT,DFN,OTFLCNT
 S PPSTART="1998-11",OTFLCNT=0
 ;quit if patch installed already
 I $$PATCH^XPDUTL("PRS*4.0*43") D MES^XPDUTL("     OT Warning search skipped. Checked on earlier PRS*4*43 install") Q
 ;
 ; update installer of patch with messages about post-install.
 ;
 S PPSTART=$O(^PRST(458,"AB",PPSTART))
 Q:$G(PPSTART)'>0
 S PPI=$O(^PRST(458,"AB",PPSTART,0))
 Q:$G(PPI)'>0
 ;
 D MES^XPDUTL("     This process may take several minutes.")
 D MES^XPDUTL("     Estimating # of records to check for overtime (OT) warnings.")
 S XPDIDTOT=$$TOTAL(PPSTART)
 S PRSDIV=XPDIDTOT\50 I 'PRSDIV S PRSDIV=1
 S PRSPCT=0
 ;
 D MES^XPDUTL("     OT check--TT8B string vs. request--pay period "_PPSTART_" to present.")
 ;
 ; back up PPI to include records from current PPI in loop
 S PPI=PPI-.1
 F  S PPI=$O(^PRST(458,PPI)) Q:PPI'>0  D
 .S PPE=$P($G(^PRST(458,PPI,0)),"^")
 .S DFN=0
 .F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  D
 ..   S PRSPCT=PRSPCT+1 ; # records processed
 ..;  call to KIDS to update %complete bar at bottom of install screen.
 ..   I '(PRSPCT#PRSDIV),(PRSPCT<XPDIDTOT) D UPDATE^XPDID(PRSPCT)
 ..;
 ..   Q:'$D(^PRST(458,PPI,"E",DFN,"D",0))
 ..;
 ..;   If timecard does not have a status of (T)imekeeper.
 ..;   and there is a TT8b string on file.
 ..;   Compare OT that's been calculated in the 
 ..;   TT8B to that which is approved in the request file.
 ..;
 ..    N TT8B,STATUS,WEEK,OT8B,OTAPP
 ..    S TT8B=$G(^PRST(458,PPI,"E",DFN,5)),STATUS=$P($G(^(0)),"^",2)
 ..    Q:(STATUS="T")!(TT8B="")
 ..    F WEEK=1:1:2 D
 ...      D GETOTS^PRSAOTT(PPE,DFN,TT8B,WEEK,.OT8B,.OTAPP)
 ...      I OTAPP<OT8B D 
 ....       D FILEOTW^PRSAOTTF(PPI,DFN,WEEK,OT8B,OTAPP)
 ....       S OTFLCNT=OTFLCNT+1
 D UPDATE^XPDID(XPDIDTOT)
 D MES^XPDUTL("          "_OTFLCNT_" overtime warnings filed in 458.6")
 D MES^XPDUTL("     Please delete routine PRSXP43 when installation is complete.")
 Q
TOTAL(PPE4Y) ;ESTIMATE TOTAL RECORDS TO EXAM DURING POST INIT
 ; Get # of records for 1 pay period (pp) & multiply by # of pps on
 ; file from pp passed in.  This total estimates records to 
 ; process during post-install & is used to update KIDS % complete bar.
 ; INPUT:  pp in 4 digit year format
 ; LOCAL:  PPS = # pps from PPE4Y to present
 ;         PPE = pp external.  PPI = pp ien.  DFN = timecard ien
 ; OUTPUT: TOT = estimated timecards from pp passed (PPE4Y)- present
 ;
 S TOT=0
 N PPS,PPE,PPI,DFN
 S PPS=1,PPE=PPE4Y
 F  S PPE=$O(^PRST(458,"AB",PPE)) Q:PPE'>0  S PPS=PPS+1
 S PPI=$O(^PRST(458,"AB",PPE4Y,0))
 ;
 Q:$G(PPI)'>0 TOT
 S TOT=$P($G(^PRST(458,PPI,"E",0)),"^",4)
 I TOT'>0 D
 .  S DFN=0 F  S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN'>0  S TOT=TOT+1
 S TOT=TOT*PPS
 Q TOT
 ;
