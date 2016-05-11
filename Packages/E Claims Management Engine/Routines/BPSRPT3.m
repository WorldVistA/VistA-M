BPSRPT3 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,11,14,19**;JUN 2004;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Reference to IB NCPCP NON-BILLABLE STATUS REASONS (#366.17) supported by ICR 6136
 ;
 Q
 ;
 ; Select the ECME Pharmacy or Pharmacies
 ; 
 ; Input Variable -> none
 ; Return Value ->   "" = Valid Entry or Entries Selected
 ;                                        ^ = Exit
 ;                                       
 ; Output Variable -> BPPHARM = 1 One or More Pharmacies Selected
 ;                          = 0 User Entered 'ALL'
 ;                            
 ; If BPPHARM = 1 then the BPPHARM array will be defined where:
 ;    BPPHARM(ptr) = ptr ^ BPS PHARMACY NAME and
 ;    ptr = Internal Pointer to BPS PHARMACIES file (#9002313.56)
 ;                    
SELPHARM() N DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;Reset BPPHARM array
 K BPPHARM
 ;
 ;First see if they want to enter individual divisions or ALL
 S DIR(0)="S^D:DIVISION;A:ALL"
 S DIR("A")="Select Certain Pharmacy (D)ivisions or (A)LL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     D         DIVISION"
 S DIR("L",4)="     A         ALL"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define BPPHARM
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 E  S BPPHARM=$S(Y="A":0,1:1)
 ;
 ;If division selected, ask prompt
 I $G(BPPHARM)=1 F  D  Q:Y="^"!(Y="") 
 .;
 .;Prompt for entry
 .K X S DIC(0)="QEAM",DIC=9002313.56,DIC("A")="Select ECME Pharmacy Division(s): "
 .W ! D ^DIC
 .;
 .;Check for "^" or timeout 
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) K BPPHARM S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(X)="" S Y=$S($D(BPPHARM)>9:"",1:"^") K:Y="^" BPPHARM Q
 .;
 .;Handle Deletes
 .I $D(BPPHARM(+Y)) D  Q:Y="^"  I 1
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO" D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) K BPPHARM S Y="^" Q
 ..I Y="Y" K BPPHARM(+P),BPPHARM("B",$P(P,U,2),+P)
 ..S Y=P  ;Restore Original Value
 ..K P
 .E  D
 ..;Define new entries in BPPHARM array
 ..S BPPHARM(+Y)=Y
 ..S BPPHARM("B",$P(Y,U,2),+Y)=""
 .;
 .;Display a list of selected divisions
 .I $D(BPPHARM)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(BPPHARM("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 K BPPHARM("B")
 Q Y
 ;
 ; Select to Include Eligibility of (V)ETERAN, (T)RICARE, (C)HAMPVA or (A)ll
 ; 
 ; Input Variable -> DFLT = 0 = All
 ;                          1 = VETERAN
 ;                          2 = TRICARE
 ;                          3 = CHAMPVA
 ; 
 ; Return Value ->  V, T, C or 0 for All
 ;
SELELIG(DFLT) N DIC,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 S DFLT=$S($G(DFLT)=1:"V",$G(DFLT)=2:"T",$G(DFLT)=3:"C",1:"A")
 S DIR(0)="S^V:VETERAN;T:TRICARE;C:CHAMPVA;A:ALL"
 S DIR("A")="Include Certain Eligibility Type or (A)ll",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":0,1:Y)
 Q Y
 ;
 ; Display (S)ummary or (D)etail Format
 ;
 ; Input Variable -> DFLT = 1 Summary
 ;                          2 Detail
 ;
 ; Return Value ->   1 = Summary
 ;                   0 = Detail
 ;                   ^ = Exit
 ;
SELSMDET(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=1:"Summary",$G(DFLT)=0:"Detail",1:"Detail")
 S DIR(0)="S^S:Summary;D:Detail",DIR("A")="Display (S)ummary or (D)etail Format",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="S":1,Y="D":0,1:Y)
 Q Y
 ;
 ; Display (C)MOP or (M)ail or (W)indow or (A)ll
 ; 
 ;    Input Variable -> DFLT = C CMOP
 ;                             W Window
 ;                             M Mail
 ;                             A All
 ;                          
 ;    Return Value ->   C = CMOP
 ;                      W = Window
 ;                      M = Mail
 ;                      A = All
 ;                      ^ = Exit
 ; 
SELMWC(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)="C":"CMOP",$G(DFLT)="W":"Window",$G(DFLT)="M":"Mail",1:"ALL")
 S DIR(0)="S^C:CMOP;M:Mail;W:Window;A:ALL"
 S DIR("A")="Display (C)MOP or (M)ail or (W)indow or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 Q Y
 ;
 ; Display (R)ealTime Fills or (B)ackbills or (A)LL
 ;
 ;    Input Variable -> DFLT = 4 PRO Option
 ;                             3 Backbill
 ;                             2 Real Time Fills
 ;                             1 ALL
 ;                          
 ;    Return Value ->   4 = PRO Option
 ;                      3 = Backbill (manually)
 ;                      2 = Real Time Fills (automatically during FINISH)
 ;                      1 = ALL
 ;                      ^ = Exit
 ;
SELRTBCK(DFLT) N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 S DFLT=$S($G(DFLT)=2:"Real Time",$G(DFLT)=3:"Backbill",$G(DFLT)=4:"PRO Option",1:"ALL")
 S DIR(0)="S^R:Real Time Fills;B:Backbill;P:PRO Option;A:ALL"
 S DIR("A")="Display (R)ealTime Fills or (B)ackbills or (P)RO Option or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":1,Y="R":2,Y="B":3,Y="P":4,1:Y)
 Q Y
 ;
 ; Display Specific (D)rug or Drug (C)lass
 ; 
 ;    Input Variable -> DFLT = 3 Drug Class
 ;                             2 Drug
 ;                             1 ALL
 ;                          
 ;     Return Value ->   3 = Drug Class
 ;                       2 = Drug
 ;                       1 = ALL
 ;                       ^ = Exit
 ;                       
SELDRGAL(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=2:"Drug",$G(DFLT)=3:"Drug Class",1:"ALL")
 S DIR(0)="S^D:Drug;C:Drug Class;A:ALL"
 S DIR("A")="Display Specific (D)rug or Drug (C)lass or (A)LL",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S Y=$S(Y="A":1,Y="D":2,Y="C":3,1:Y)
 Q Y
 ;
 ; Select Drug
 ; 
 ; Input Variable -> none
 ; 
 ; Return Value -> ptr = pointer to DRUG file (#50)
 ;                   ^ = Exit
 ;                   
SELDRG() N DIC,DIRUT,DUOUT,X,Y
 ;
 ;Prompt for entry
 W ! D SELDRG^BPSRPT6
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 ;
 ;Check for Valid Entry
 I +Y>0 S Y=+Y
 ;
 Q Y
 ;
 ; Select Drug Class
 ; 
 ; Input Variable -> none
 ; 
 ; Return Value -> ptr = pointer to VA DRUG CLASS file (#50.605)
 ;                   ^ = Exit
 ;
SELDRGCL() N DIC,DIRUT,DUOUT,Y
 ;
 ;Prompt for entry
 ;W ! D SELDRGC^BPSRPT6
 ;Using DIC^PSNDI per ICR 4554 - BPS*1*14 ticket 313337
 S DIC="50.605",DIC(0)="QEAMZ" D DIC^PSNDI(DIC,"BPS",.DIC,,,)
 ;
 ;call returns DRUG CLASS CODE, need to extract DRUG CLASSIFICATION
 I +$G(Y)>0 S Y=$P($G(Y(0)),"^",2) I $G(Y)="" S Y=-1
 ;
 ;If nothing was returned set Y="-1" so report knows 
 I $G(Y)=-1 S Y="^"
 ;
 Q Y
 ;
 ; Enter Date Range
 ;
 ; Input Variable -> TYPE = 7 CLOSE REPORT
 ;                          1-6 OTHER REPORTS
 ;
 ; Return Value -> P1^P2
 ; 
 ;           where P1 = From Date
 ;                    = ^ Exit
 ;                 P2 = To Date
 ;                    = blank for Exit
 ;                 
SELDATE(TYPE) N BPSIBDT,DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 S TYPE=$S($G(TYPE)=7:"CLOSE",1:"TRANSACTION")
SELDATE1 S VAL="",DIR(0)="DA^:DT:EX",DIR("A")="START WITH "_TYPE_" DATE: ",DIR("B")="T-1"
 W ! D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^"
 ;
 I VAL="" D
 .S $P(VAL,U)=Y
 .S DIR(0)="DA^"_VAL_":DT:EX",DIR("A")="  GO TO "_TYPE_" DATE: ",DIR("B")="T"
 .D ^DIR
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^" Q
 .;
 .;Define Entry
 .S $P(VAL,U,2)=Y
 ;
 Q VAL
 ;
 ; Select to Include Open or Closed or All claims
 ; 
 ; Input Variable -> DFLT = 0 = All
 ;                          1 = Closed
 ;                          2 = Open
 ; 
 ; Return Value -> 0 = All, 1 = Closed, 2 = Open
SELOPCL(DFLT) N DIC,DIR,DIRUT,DUOUT,X,Y
 ;
 S DFLT=$S($G(DFLT)=1:"C",$G(DFLT)=2:"O",1:"A")
 S DIR(0)="S^O:OPEN;C:CLOSED;A:ALL"
 S DIR("A")="Include (O)pen, (C)losed, or (A)ll Claims",DIR("B")=DFLT
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 ;
 S Y=$S(Y="C":1,Y="O":2,1:0)
 Q Y
 ;
SELELIG1() ;
 ; Select multiple Eligibilities
 ; 
 ; Input Variable -> none
 ; Return Value   -> 0: All, 1: Selected Eligibilities; '^' = Exit
 ;                                       
 ; Output Variable -> BPELIG1 = 1 - One or More Pharmacies Selected
 ;                            = 0 - User Entered 'ALL'
 ;                            = "^" - User quit
 ;                            
 ; If BPELIG1 = 1 then the BPELIG1 array will be defined where:
 ;    BPELIG1("C")="CHAMPVA"
 ;    BPELIG1("T")="TRICARE"
 ;    BPELIG1("V")="VETERAN"
 ;
 ;
 ;Reset BPELIG1 array
 K BPELIG1
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,P
 ;
 ;First see if they want to enter individual eligibilities or ALL
 S DIR(0)="S^E:ELIGIBILITY;A:ALL"
 S DIR("A")="Select Certain (E)ligibilities or (A)LL"
 S DIR("B")="ALL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     E         ELIGIBILITY"
 S DIR("L",4)="     A         ALL"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 ;
 ; Set BPELIG1 and quit unless user wants to select individual eligibilities
 S BPELIG1=$S(Y="A":0,Y="^":"^",1:1)
 I BPELIG1'=1 Q BPELIG1
 ;
 ;Allow user to select multiple eligibilities
 F  D  Q:Y="^"!(Y="")
 .;
 .;Prompt for entry
 .K DIR
 .S DIR(0)="SO^C:CHAMPVA;T:TRICARE;V:VETERAN"
 .S DIR("A")="Select Eligibility"
 .D ^DIR
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(Y)="" S Y=$S($D(BPELIG1)>9:"",1:"^") Q
 .;
 .; Add entry to array or handle duplicate entries
 .I '$D(BPELIG1(Y)) S BPELIG1(Y)=Y(0),BPELIG1("B",Y(0),Y)=""
 .E  D  I Y="^" Q
 ..;Already in the array, so ask whether to delete
 ..N P
 ..S P=Y_"^"_Y(0)  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO"
 ..D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q
 ..I Y="Y" K BPELIG1($P(P,U,1)),BPELIG1("B",$P(P,U,2),$P(P,U,1))
 ..S Y=P  ;Restore Original Value
 ..K P
 .;
 .;Display a list of selected eligibilities
 .I $D(BPELIG1)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(BPELIG1("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 ; Reset BPELIG1 array if user exited
 I Y="^" K BPELIG1 S BPELIG1="^" Q "^"
 ;
 ; Deleted 'x-ref' as we don't need to return that
 K BPELIG1("B")
 ; 
 Q 1
 ;
SELALRC() ; 
 ; Display Most (R)ecent or (A)ll
 ;
 ; Return Value ->   A: All
 ;                   R: Most Recent
 ;                   ^: Exit
 ;
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="S^R:Most Recent;A:ALL"
 S DIR("A")="Select Most (R)ecent or (A)ll"
 S DIR("B")="MOST RECENT"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     R         Most Recent Transaction Only"
 S DIR("L",4)="     A         ALL Transactions (will list the Rx/Fill each time resubmitted)"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, 
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 Q Y
 ;
SELNBSTS() ; 
 ; Select the Non-Billable Status Reason
 ; 
 ; Input Variable -> None
 ; Return Value   -> 0: All, 1: Selected Non-Billable Status; '^' = Exit
 ;                                       
 ; Output Variable -> BPNBSTS = 1 - One or More Non-Billable Statuses Selected
 ;                            = 0 - User Entered 'ALL'
 ;                            = "" - User quit
 ;                            
 ; If BPNBSTS = 1 then the BPNBSTS array will be defined where:
 ;    BPNBSTS(Non-Billable Status IEN)=Non-Billable Status Reason
 ;
 ;Reset BPNBSTS array
 K BPNBSTS
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,P,DIC
 ;
 ;First see if they want to enter individual eligibilities or ALL
 S DIR(0)="S^S:NON-BILLABLE STATUS;A:ALL"
 S DIR("A")="Select Certain Non-Billable (S)tatus or (A)ll"
 S DIR("B")="ALL"
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     S         NON-BILLABLE STATUS"
 S DIR("L",4)="     A         ALL"
 D ^DIR K DIR
 ;
 ;Check for "^" or timeout, otherwise define BPNBSTS
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 S BPNBSTS=$S(Y="A":0,Y="^":"^",1:1)
 I BPNBSTS'=1 Q BPNBSTS
 ;
 ;Allow user to select multiple non-billable statuses
 F  D  Q:Y="^"!(Y="")
 .;Prompt for entry - ICR 6136
 .K X
 .S DIC(0)="QEAM",DIC=366.17,DIC("A")="Select Non-Billable Reason: "
 .W ! D ^DIC
 .I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q
 .;
 .;Check for blank entry, quit if no previous selections
 .I $G(Y)=-1 S Y=$S($D(BPNBSTS)>9:"",1:"^") Q
 .;
 .; Add entry to array or handle duplicate entries
 .I '$D(BPNBSTS($P(Y,U,1))) S BPNBSTS($P(Y,U,1))=$P(Y,U,2),BPNBSTS("B",$P(Y,U,2),$P(Y,U,1))=""
 .E  D  I Y="^" Q
 ..;Already in the array, so ask whether to delete
 ..N P
 ..S P=Y  ;Save Original Value
 ..S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$P(P,U,2)_" from your list?"
 ..S DIR("B")="NO"
 ..D ^DIR
 ..I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^" Q
 ..I Y="Y" K BPNBSTS($P(P,U,1)),BPNBSTS("B",$P(P,U,2),$P(P,U,1))
 ..S Y=P  ;Restore Original Value
 ..K P
 .;
 .;Display a list of selected values
 .I $D(BPNBSTS)>9 D
 ..N X
 ..W !,?2,"Selected:"
 ..S X="" F  S X=$O(BPNBSTS("B",X)) Q:X=""  W !,?10,X
 ..K X
 .Q
 ;
 ; Reset BPNBSTS array if user exited
 I Y="^" K BPNBSTS S BPNBSTS="^" Q "^"
 ;
 ; Deleted 'x-ref' as we don't need to return that
 K BPNBSTS("B")
 ; 
 Q 1
