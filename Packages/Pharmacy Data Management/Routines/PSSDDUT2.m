PSSDDUT2 ;BIR/LDT - Pharmacy Data Management DD Utility ;1/20/16 2:45pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**3,21,61,81,95,127,126,139,131,143,188,189,192,218,187**;9/30/97;Build 27
 ;
 ;Reference to ^DIC(42 supported by DBIA #10039
 ;Reference to ^DD(59.723 supported by DBIA #2159
 ;Reference to ^PSNDF(50.68 supported by DBIA 3735
 ;
DEA ;(Replaces ^PSODEA)
 S PSSHLP(1)="THE SPECIAL HANDLING CODE IS A 2 TO 6 POSTION FIELD.  IF APPLICABLE,"
 S PSSHLP(2)="A SCHEDULE CODE MUST APPEAR IN THE FIRST POSITION.  FOR EXAMPLE,"
 S PSSHLP(3)="A SCHEDULE 3 NARCOTIC WILL BE CODED '3A', A SCHEDULE 3 NON-NARCOTIC WILL BE"
 S PSSHLP(4)="CODED '3C' AND A SCHEDULE 2 DEPRESSANT WILL BE CODED '2L'."
 S PSSHLP(5)="THE CODES ARE:"
 D WRITE
 F II=1:1 Q:$P($T(D+II),";",3)=""  S PSSHLP(II)=$P($T(D+II),";",3,99)
 S PSSHLP(1,"F")="!!" D WRITE
 D PKIND,WRITE
D K II Q
 ;;0          MANUFACTURED IN PHARMACY
 ;;1          SCHEDULE 1 ITEM
 ;;2          SCHEDULE 2 ITEM
 ;;3          SCHEDULE 3 ITEM
 ;;4          SCHEDULE 4 ITEM
 ;;5          SCHEDULE 5 ITEM
 ;;6          LEGEND ITEM
 ;;9          OVER-THE-COUNTER
 ;;L          DEPRESSANTS AND STIMULANTS
 ;;A          NARCOTICS AND ALCOHOLS
 ;;P          DATED DRUGS
 ;;I          INVESTIGATIONAL DRUGS
 ;;M          BULK COMPOUND ITEMS
 ;;C          CONTROLLED SUBSTANCES - NON NARCOTIC
 ;;R          RESTRICTED ITEMS
 ;;S          SUPPLY ITEMS
 ;;B          ALLOW REFILL (SCH. 3, 4, 5 ONLY)
 ;;W          NOT RENEWABLE
 ;;F          NON REFILLABLE
 ;;N          NUTRITIONAL SUPPLEMENT
 ;;K          NOT RENEWABLE (BY TELEPHONE)
 ;;D          NOT PARKABLE
 ;;
DEATBL ; More Help regarding DEA Codes
 K PSSHLP
 F II=1:1 Q:$P($T(TBL+II),";",3)=""  S PSSHLP(II)=$P($T(TBL+II),";",3,99)
 S PSSHLP(1,"F")="!!" D WRITE
 ;
TBL K II Q
 ;;          DEA CODE TABLE
 ;; CODE   ALLOW RENEWS ALLOW REFILLS
 ;; 1            NO           NO
 ;; 2            NO           NO
 ;; 2A           NO           NO
 ;; 3            YES          YES
 ;; 3A           YES          NO
 ;; 3AB          YES          YES
 ;; 4            YES          YES
 ;; 4A           YES          NO
 ;; 4AB          YES          YES
 ;; 5            YES          YES
 ;; 5A           YES          NO
 ;; 5AB          YES          YES
 ;; ADDING W TO A SCHED. 3,4,OR 5 CODE DISALLOWS RENEWS.
 ;; ADDING F TO A SCHED. 3,4,OR 5 CODE DISALLOWS REFILLS
 ;; IF A CODE IS NOT LISTED IN THE ABOVE TABLE
 ;; IT HAS NO EFFECT ON RENEW OR REFILL
SIG ;checks SIG for RXs (Replaces SIG^PSOHELP)
 I $E(X)=" " D EN^DDIOL("Leading spaces are not allowed in the SIG! ","","$C(7),!") K X Q
SIGONE S SIG="" Q:$L(X)<1  F Z0=1:1:$L(X," ") G:Z0="" EN S Z1=$P(X," ",Z0) D  G:'$D(X) EN
 .I $L(Z1)>32 D EN^DDIOL("MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.","","$C(7),!?5") K X Q
 .D:$D(X)&($G(Z1)]"")  S SIG=SIG_" "_Z1
 ..S Y=$O(^PS(51,"B",Z1,0)) Q:'Y!($P($G(^PS(51,+Y,0)),"^",4)>1)  S Z1=$P(^PS(51,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",Z0-1),Y=$E(Y,$L(Y)) S:Y>1 Z1=^(9)
EN K Z1,Z0 ;S:$G(POERR) PSOERR("SIG")="("_$E(SIG,2,999999999)_")"
 Q
 ;
DRUGW ;(Replaces DRUGW^PSOUTLA)
 F Z0=1:1 Q:$P(X,",",Z0,99)=""  S Z1=$P(X,",",Z0) D:$D(^PS(54,Z1,0)) EN^DDIOL($P(^(0),"^"),"","!,?35") I '$D(^(0)) D EN^DDIOL("NO SUCH WARNING LABEL","","?35") K X Q
 Q
 ;
P ;(Replaces ^PSODSRC)
 S PSSHLP(1)="A TWO OR THREE POSITION CODE IDENTIFIES THE SOURCE OF SUPPLY AND WHETHER"
 S PSSHLP(2)="THE DRUG IS STOCKED BY THE STATION SUPPLY DIVISION.  THE FIRST"
 S PSSHLP(3)="POSITION OF THE CODE IDENTIFIES SOURCE OF SUPPLY.  THE CODES ARE:"
 D WRITE
 F II=0:1:10 S PSSHLP(II+1)=$P($T(S+II+1),";",3),PSSHLP(II+1,"F")="!?10"
 S PSSHLP(1,"F")="!!?10"
 D WRITE
 S PSSHLP(1)="THE SECOND POSITION OF THE CODE INDICATES WHETHER THE ITEM IS"
 S PSSHLP(2)="OR IS NOT AVAILABLE FROM SUPPLY WAREHOUSE STOCK.  THE CODES ARE:"
 S PSSHLP(3)="P          POSTED STOCK"
 S PSSHLP(3,"F")="!!?10"
 S PSSHLP(4)="U          UNPOSTED"
 S PSSHLP(4,"F")="!?10"
 S PSSHLP(5)="M          BULK COMPOUND"
 S PSSHLP(5,"F")="!?10"
 S PSSHLP(6)="*  USE CODE 0 ONLY WITH SECOND POSITION M."
 D WRITE Q
 ;
S ;;DESCRIPTION MEANINGS
 ;;0          BULK COMPOUND ITEMS *
 ;;1          VA SERVICING SUPPLY DEPOT
 ;;2          OPEN MARKET
 ;;3          GSA STORES DEPOT
 ;;4          VA DECENTRALIZED CONTRACTS
 ;;5          FEDERAL PRISON INDUSTRIES, INC.
 ;;6          FEDERAL SUPPLY SCHEDULES
 ;;7          VA SUPPLY DEPOT, HINES
 ;;8          VA SUPPLY DEPOT, SOMERVILLE
 ;;9          APPROPRIATE MARKETING DIVISION
 ;;10         VA SUPPLY DEPOT, BELL
EDIT ;INPUT XFORM FOR DEA FIELD IN DRUG FILE (Replaces EDIT^PSODEA)
 I X["F",X["B" D EN^DDIOL("Inappropriate F designation!","","$C(7),!") K X Q
 ;;DEA CHANGE PSS*1*126
 I X["B",(+X<3) D EN^DDIOL("The B designation is only valid for schedule 3, 4, 5 !","","$C(7),!") K X Q
 I X["A"&(X["C"),+X=2!(+X=3) D EN^DDIOL("The A & C designation is not valid for schedule 2 or 3 narcotics!","","$C(7),!") K X Q
 I $E(X)=1,X[2!(X[3)!(X[4)!(X[5) D EN^DDIOL("It contains other inappropriate schedule 2-5 narcotics!","","$C(7),!") K X Q
 I $E(X)=2,X[1!(X[3)!(X[4)!(X[5) D EN^DDIOL("It contains other inappropriate schedule 1,3-5 narcotics!","","$C(7),!") K X Q
 I $E(X)=3,X[1!(X[2)!(X[4)!(X[5) D EN^DDIOL("It contains other inappropriate schedule 1-2,4-5 narcotics!","","$C(7),!") K X Q
 I $E(X)=4,X[1!(X[2)!(X[3)!(X[5) D EN^DDIOL("It contains other inappropriate schedule 1-3,5 narcotics!","","$C(7),!") K X Q
 I $E(X)=5,X[1!(X[2)!(X[3)!(X[4) D EN^DDIOL("It contains other inappropriate schedule 1-4 narcotics!","","$C(7),!") K X Q
 ;
 I X["E"!(X["U") D
 .I X["E" D EN^DDIOL("Note: Adding E has no ePharmacy impact. Use the ePharmacy Billable fields.","","$C(7),!")
 .I X["U" D EN^DDIOL("Note: Adding U has no ePharmacy impact. Use the Sensitive Diagnosis Drug field.","","$C(7),!")
 .Q
 ;
 Q
 ;
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSSHLP) K PSSHLP
 Q
 ;
PKIND I +$P($G(^PSDRUG(DA,"ND")),"^",3) S PSSK=$P(^("ND"),"^",3) D
 .S PSSK=$$GET1^DIQ(50.68,PSSK,19,"I") I PSSK S PSSK=$$CSDEA^PSSDDUT2(PSSK) D
 ..I $L(PSSK)=1,$P(^PSDRUG(DA,0),"^",3)[PSSK Q
 ..I $P(^PSDRUG(DA,0),"^",3)[$E(PSSK),$P(^PSDRUG(DA,0),"^",3)[$E(PSSK,2) Q
 ..W !!,"The CS Federal Schedule associated with this drug in the VA Product file"
 ..W !,"represents a DEA, Special Handling code of "_PSSK
 Q
 ;
CSDEA(CS) ;
 Q:'CS ""
 Q $S(CS?1(1"2n",1"3n"):+CS_"C",+CS=2!(+CS=3)&(CS'["C"):+CS_"A",1:CS)
 ;
CLOZ ;DEL node of DRUG file 50, fields 17.2, 17.3, 17.4
 S PSSHLP(1)="To delete this field use the Unmark Clozapine Drug option in the"
 S PSSHLP(2)="Clozapine Pharmacy Manager menu."
 D WRITE
 Q
 ;
NONF ;Non-Formulary Input Transform DRUG file 50, field 51
 S PSSHLP(1)="This drug cannot be marked as a non-formulary item because it is"
 S PSSHLP(2)="designated as a formulary alternative for the following drugs."
 S PSSHLP(3)=" ",PSSHLP(1,"F")="!!"
 D WRITE
 F MM=0:0 S MM=$O(^PSDRUG("AFA",DA,MM)) Q:'MM  S SHEMP=$P(^PSDRUG(MM,0),"^") D EN^DDIOL(SHEMP,"","!?3")
 S X=""
 Q
 ;
ATC ;Executable help for field 212.2, DRUG file 50
 S PSSHLP(1)="The mnemonic entered here must match the mnemonic entered into the"
 S PSSHLP(2)="ATC for this drug EXACTLY, and cannot be numbers only."
 D WRITE
 Q
 ;
ADTM ;ADMINISTRATION SCHEDULE file 51.1, field 1 Executable Help
 S PSSHLP(1)="All times must be the same length (2 or 4 characters), must be"
 S PSSHLP(2)="separated by dashes ('-'), and be in ascending order"
 S PSSHLP(3)=""
 S PSSHLP(4)="This is the set of administration times for this Schedule."
 S PSSHLP(5)=""
 S PSSHLP(6)="If the Schedule Type is CONTINUOUS the number of administration"
 S PSSHLP(7)="times cannot conflict with the frequency of the schedule.  For"
 S PSSHLP(8)="example, a schedule frequency of 720 minutes must have two"
 S PSSHLP(9)="administration times and a schedule frequency of 360 must have a"
 S PSSHLP(10)="four administration times."
 S PSSHLP(11)=""
 S PSSHLP(12)="If the Schedule Type is CONTINUOUS and is an Odd Schedule (A"
 S PSSHLP(13)="schedule whose frequency is not evenly divisible by or into"
 S PSSHLP(14)="1440 minutes or 1 day). Administration Times are not allowed."
 S PSSHLP(15)="For example Q5H, Q17H - these are not evenly divisible by 1440."
 S PSSHLP(16)=""
 S PSSHLP(17)="If the Schedule Type is CONTINUOUS with a non-odd frequency of"
 S PSSHLP(18)="greater than of 1 day (1440 minutes) then more than one"
 S PSSHLP(19)="administration time is not allowed.  For example schedules of"
 S PSSHLP(20)="Q72H, Q3Day, and Q5Day."
 D WRITE
 Q
 ;
LBLS ;PHARMACY SYSTEM file 59.7, field 61.2 Executable Help
 S PSSHLP(1)="ANY NEW LABELS OLDER THAN THE NUMBER OF DAYS SPECIFIED HERE WILL"
 S PSSHLP(2)="AUTOMATICALLY BE PURGED."
 D WRITE
 Q
NFH I '$D(DA(1)) D EN^DDIOL(" (This non-formulary item is "_$P(^PSDRUG($S($D(DA(1)):DA(1),1:DA),0),"^")_".)")
 Q
STRTH S STR=" "_$P(X," ",2),PSSHLP(1)=STR,PSSHLP(1,"F")="" D WRITE K STR
 Q
PSYS1 D EN^DDIOL("(""From"" ward is "_$S('$D(^PS(59.7,D0,22,D1,0)):"UNKNOWN",'$D(^DIC(42,+^(0),0)):"UNKNOWN",$P(^(0),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_")","","!?3")
 Q
PSYS2 ;PSS*1.0*95
 D EN^DDIOL("(""From"" service is "_$S('$D(^PS(59.7,D0,23,D1,0)):"UNKNOWN",$P(^(0),"^")]"":$P($P(";"_$P(^DD(59.723,.01,0),"^",3),";"_$P(^PS(59.7,D0,23,D1,0),"^")_":",2),";"),1:"UNKNOWN")_")")
 Q
 ;
NCINIT ;
 K PSSNQM,PSSNQM2,PSSNQM3,PSSONDU,PSSONQM
NCINIT1 ;
 I $P($G(^PSDRUG(DA,"EPH")),"^",2)="" S $P(^PSDRUG(DA,"EPH"),"^",2)="EA",$P(^PSDRUG(DA,"EPH"),"^",3)=1 D
 . S PSSHLP(1)="  Note:     Defaulting the NCPDP DISPENSE UNIT to EACH and the"
 . S PSSHLP(2)="            NCPDP QUANTITY MULTIPLIER to 1 (one)." S PSSHLP(1,"F")="!!"
 . D WRITE S PSSHLP(2,"F")="!" D WRITE
 S PSSONDU=$P(^PSDRUG(DA,"EPH"),"^",2),PSSONQM=$P(^PSDRUG(DA,"EPH"),"^",3)
 Q
 ;
NCPDPDU ;Drug file 50, field 82
 S:X="" X="EA"
 D NCINIT1:'$D(PSSONDU)
 I $G(PSSONDU)'=X&($G(PSSONQM)'=1) D
 . S PSSHLP(1)="Defaulting the NCPDP QUANTITY MULTIPLIER to 1 (one)." S PSSHLP(1,"F")="!!" D WRITE
 . S $P(^PSDRUG(DA,"EPH"),"^",3)=1,PSSONDU=$P(^PSDRUG(DA,"EPH"),"^",2),PSSONQM=$P(^PSDRUG(DA,"EPH"),"^",3)
 Q
 ;
NCPDPQM ;Drug file 50, field 83
 N ZXX S PSSNQM=0,(PSSNQM2,PSSNQM3)=""
 I $G(X)<.00001 K X S PSSNQM3=1 Q
 S:$G(X)="" X=1
 I +$G(X)'=1 D NCPDPWRN D
NCPDPQM1 . ;
 . R !,"Ok to continue? (Y/N) ",ZXX:30 S ZXX=$TR(ZXX,"yn","YN")
 . I ZXX="^" S X=1 W !!?5,"Warning:  Defaulting NCPDP QUANTITY MULTIPLIER to 1 (one).",!! Q
 . I ZXX'="Y"&(ZXX'="N") W !,"Y or N must be entered." G NCPDPQM1
 . I ZXX'="Y"&(ZXX'="y") S PSSNQM=1,PSSNQM2=X K X
 Q
 ;
NCPDPWRN ;Message called from NCPDPQM
 S PSSHLP(2)="WARNING:    For most drug products, the value for this field should be 1 (one)."
 S PSSHLP(3)="            Answering NO for the following prompt will display more information"
 S PSSHLP(4)="            on how this field is used."
 S PSSHLP(2,"F")="!!" D WRITE
 S PSSHLP(5,"F")="!" D WRITE
 Q
 ;
MXDAYSUP ; INPUT TRANSFORM for Drug file (#50), MAXIMUM DAYS SUPPLY Field (#66)
 ; Input: X  - Maximum Days Supply Entered by user
 ;        DA - DRUG file (#50) IEN
 Q:'$D(^PSDRUG(+$G(DA),0))
 S X=+$G(X)
 ; - DAY SUPPLY must be between 1 and 365 (inclusive)
 I (X<1)!(X>365) D  Q
 . D EN^DDIOL("Type a number between 1 and 365, 0 decimal digits.","","!!") K X W !
 ;
 ; - Checking against NDF Maximum
 N VAPRDIEN S VAPRDIEN=+$$GET1^DIQ(50,DA,22,"I")
 I VAPRDIEN D  I '$D(X) Q
 . N NDFMAXDS
 . S NDFMAXDS=$$GET1^DIQ(50.68,VAPRDIEN,32)
 . I NDFMAXDS,NDFMAXDS<X D
 . . D EN^DDIOL("Cannot be greater than NDF Maximum Days Supply: "_NDFMAXDS,"","!!") K X W !
 ;
 ; - Controlled Substances have different upper limits (not 365)
 N DEASPHLG S DEASPHLG=$$GET1^DIQ(50,DA,3)
 I DEASPHLG["2",X>30 D  Q
 . D EN^DDIOL("Schedule 2 controlled substances have a maximum days supply limit of 30 days","","!!") K X W !
 I (DEASPHLG["3")!(DEASPHLG["4")!(DEASPHLG["5"),X>90 D  Q
 . D EN^DDIOL("Schedule 3-5 controlled substances have a maximum days supply limit of 90 days","","!!") K X W !
 ;
 ; - Clozapine Drug (Not controlled by this field)
 I ($P($G(^PSDRUG(DA,"CLOZ1")),"^")="PSOCLO1") D  Q
 . D EN^DDIOL("Maximum Days Supply for this drug is controlled by the Clozapine functionality","","!!") K X W !
 ;
 I X<$$MXDAYSUP^PSSUTIL1(DA) D
 . W ! D EN^DDIOL("Note: Decreasing the MAXIMUM DAYS SUPPLY field will only affect new","","!")
 . D EN^DDIOL("      prescriptions, including renewals and copies. Orders that are pending","","!")
 . D EN^DDIOL("      or unreleased when the MAXIMUM DAYS SUPPLY field is decreased are not","","!")
 . D EN^DDIOL("      affected by the decrease, so prescriptions with a DAYS SUPPLY above the","","!")
 . D EN^DDIOL("      new MAXIMUM DAYS SUPPLY may need to be edited manually before they are","","!")
 . D EN^DDIOL("      finished or released.","","!")
 . W ! N DIR,X,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 Q
 ;
IVSOLVOL ; IV Solution VOLUME field INPUT TRANSFORM
 N OI
 I X[""""!($A(X)=45)!(X'?.N0.1".".N)!(X>9999)!(X<.01) K X Q
 I $$GET1^DIQ(52.7,DA,17,"I") S OI=+$$GET1^DIQ(52.7,DA,9,"I") I $$CKDUPSOL(OI,DA,+X,1) K X Q
 S X=X_" ML" D EN^DDIOL(" ML","","?0")
 Q
 ;
UIVFOE ; USED IN THE IV FLUID ORDER ENTRY field INPUT TRANSFORM
 I X D
 . N OI
 . S OI=$$GET1^DIQ(52.7,DA,9,"I") I $$CKDUPSOL(OI,DA,+$$GET1^DIQ(52.7,DA,2),1) K X
 Q
 ;
CKDUPSOL(OI,IVSOL,IVVOL,DSPMSG) ; Check if there's an ACTIVE Duplicate IV Solution Marked to be Used in the IV Order Dialog
 ; Input: OI     - PHARMACY ORDERABLE ITEM (#50.7) Pointer
 ;        IVSOL  - IV SOLUTIONS (#52.7) Pointer
 ;        IVVOL  - IV Solution Volume
 ;        DSPMSG - Display Message? (1:Yes/0:No)
 ;Output: DUPSOL - Duplicate IV Solution IEN
 N DUPSOL,OTHSOL,OTHVOL,DRUG
 S (DUPSOL,OTHSOL)=0
 ;
 ; Invalid IV Solution
 I '$D(^PS(52.7,+$G(IVSOL),0)) Q 0
 ;
 ; IV Solution is INACTIVE, no issues
 I $$GET1^DIQ(52.7,IVSOL,8,"I"),$$GET1^DIQ(52.7,IVSOL,8,"I")'>DT Q 0
 ;
 ; Dispense Drug might not be matched to an Orderable Item yet
 S DRUG=+$$GET1^DIQ(52.7,IVSOL,1,"I")
 ;
 I +$G(OI) D
 . F  S OTHSOL=$O(^PS(52.7,"AOI",OI,OTHSOL)) Q:'OTHSOL!DUPSOL  D
 . . I $$DUPVOL(IVSOL,OTHSOL) S DUPSOL=OTHSOL
 E  D
 . F  S OTHSOL=$O(^PS(52.7,"AC",DRUG,OTHSOL)) Q:'OTHSOL!DUPSOL  D
 . . I $$DUPVOL(IVSOL,OTHSOL) S DUPSOL=OTHSOL
 I $G(DSPMSG),DUPSOL D
 . W !!,"The following IV Solution with the same volume is already linked to"
 . W:$G(OI) !,"the Orderable Item ",$$GET1^DIQ(50.7,OI,.01)
 . W:'$G(OI) !,"this dispense drug."
 . W !
 . W:$G(OI) !,"Dispense Drug: ",$$GET1^DIQ(52.7,DUPSOL,1)
 . W !,"  IV Solution: ",$$GET1^DIQ(52.7,DUPSOL,.01)
 . W !
 . W !,"Only one Active IV Solution with a specific volume can be linked to an"
 . W !,"Orderable Item or Dispense Drug when the IV Solution is marked to be used"
 . W !,"in the CPRS IV Fluid Order Entry."
 . W !,$C(7)
 Q DUPSOL
 ;
DUPVOL(IVSOL1,IVSOL2) ; Check 2 IV Solutions to see if they have Duplicate Volumes
 ; Cannot check against itself
 I (IVSOL1=IVSOL2) Q 0
 ; Not Used in the IV Order Dialog
 I '$$GET1^DIQ(52.7,IVSOL2,17,"I") Q 0
 ; Other IV Solution is INACTIVE
 I $$GET1^DIQ(52.7,IVSOL2,8,"I"),$$GET1^DIQ(52.7,IVSOL2,8,"I")'>DT Q 0
 ; IV Solution Volume
 S OTHVOL=$$GET1^DIQ(52.7,IVSOL2,2)
 ; IV Solutions have different volumes
 I (+IVVOL'=+OTHVOL) Q 0
 ; Capturing the Duplicate IV Solution IEN
 Q 1
