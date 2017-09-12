IBYRPOST ;ALB/EMG - IB*2*70 POST-INIT ; 21-MAY-97
 ;;2.0; INTEGRATED BILLING ;**70**; 21-MAR-94
 ;
EN ; Patch IB*2*70 post initialization.
 ;
 D OGEN ;   output generator for post init
 Q
 ;
OGEN ; set up check points for post init
 N %,Z
 S %=$$NEWCP^XPDUTL("HOLD","HOLD^IBYRPOST")
 S %=$$NEWCP^XPDUTL("DAYS","DAYS^IBYRPOST")
 S %=$$NEWCP^XPDUTL("DATE","DATE^IBYRPOST")
 S %=$$NEWCP^XPDUTL("REL","REL^IBYRPOST")
 Q
 ;
HOLD ; modify IB ACTION TYPE entries - place on hold
 N DONE,S1,Z,Z1
 S DONE="   >>> Step complete <<<"
 D BMES^XPDUTL("   <<< Updating IB Action Type file (350.1) >>>")
 S S1=0 F  S S1=$O(^IBE(350.1,S1)) Q:'S1  S Z=$G(^IBE(350.1,S1,0)),Z1=$P(Z,U,11) D
 .I Z1'=""&(Z1<6) S $P(^IBE(350.1,S1,0),U,10)=1 Q
 D MES^XPDUTL(DONE)
 Q
 ;
DAYS ; set NUMBER OF DAYS PT CHARGES HELD field (#7.04) in file #350.9 
 N DONE,S1,Z,Z1
 S DONE="   >>> Step complete <<<"
 D BMES^XPDUTL("   <<< Setting Number of Days Pt Charges Held in file (350.9) >>>")
 S $P(^IBE(350.9,1,7),U,4)=90
 D MES^XPDUTL(DONE)
 Q
 ;
DATE ; find charges on hold & related 3rd party bills
 ; set ON HOLD DATE to either:
 ;   - date entry added to file #350
 ;   - authorization date of 3rd party bill
 ;
 N DONE,IBDEA,IBADT,IBOHDT,IBNAME,IBN,DFN,IBNUM,FDA,DIERR
 S DONE="   >>> Step complete <<<"
 D BMES^XPDUTL("   <<< Setting ON HOLD DATE field in IB ACTION (#350) file >>>")
 D CHRGS^IBOHLD1 ; find charges on hold
 ;
 ; set ON HOLD DATE
 S (IBDEA,IBADT,IBOHDT)=0
 S IBNAME="" F  S IBNAME=$O(^TMP($J,"HOLD",IBNAME)) Q:IBNAME=""  S DFN=0 F  S DFN=$O(^TMP($J,"HOLD",IBNAME,DFN)) Q:'DFN  S IBN=0 F  S IBN=$O(^TMP($J,"HOLD",IBNAME,DFN,IBN)) Q:'IBN  D
 .S IBNUM=$P($G(^IB(IBN,0)),"^")
 .S IBDEA=$P($P($G(^IB(IBN,1)),"^",2),"."),IBOHDT=IBDEA
 .D BILLDT
 .S FDA(350,IBN_",",16)=$S(IBOHDT:IBOHDT,1:"")
 .D FILE^DIE("K","FDA")
 .I $G(DIERR) D BMES^XPDUTL("  >>> Check IB Action # '"_IBNUM_".  ON HOLD DATE was not set. <<<")
 .Q
 D MES^XPDUTL(DONE)
 Q
 ;
BILLDT ; find authorization date for 3rd party bills
 N IBADT,IBBILL
 S IBBILL="" F  S IBBILL=$O(^TMP($J,"HOLD",IBNAME,DFN,IBN,IBBILL)) Q:IBBILL=""  D
 .S IBADT=$P($G(^DGCR(399,IBBILL,"S")),"^",10)
 .S IBOHDT=$S(IBADT>IBDEA:IBADT,1:IBDEA) Q:IBADT=""
 .Q
 Q
 ;
 ;
REL ; Auto-release entries on hold for more than 90 days
 N DONE
 S DONE="   >>> Step Complete <<<."
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("   <<< Releasing IB charges ON HOLD longer than 90 days >>>.")
 ;
 D EN^IBOHRL
 D MES^XPDUTL(DONE)
 D MES^XPDUTL("   ** Use 'On Hold Charges Released to AR' option to see detailed **")
 D MES^XPDUTL("   ** list of charges released during post-init.                  **")
 Q
 ;
