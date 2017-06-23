RCXFMSPR ;WISC/RFJ-print revenue source codes ;8/31/10 11:34am
 ;;4.5;Accounts Receivable;**90,96,101,156,170,203,273,310**;Mar 20, 1995;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 W !,"This option will print out a list of the revenue source codes sent from"
 W !,"the VISTA system to FMS."
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Revenue Source Code Report",ZTRTN="DQ^RCXFMSPR"
 .   S ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queue starts here
 N %,%I,BINARY,COL2DESC,COL3DESC,COLUMN1,COLUMN2,COLUMN3,COLUMN4
 N DECIMAL,DESCRIP,NOW,PAGE,RCSTFLAG,SCREEN,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 ;
 S COLUMN1="A",COLUMN2="R",COLUMN3="R",COLUMN4="V",DESCRIP="Miscellaneous"
 D WRITEIT
 ;
 ;  for now, column 1 is always 8 and column 4 is always Z
 S COLUMN1=8,COLUMN4="Z"
 F COLUMN2=1:1:9,"A","B","C","D","E","F","G","H","I","J","K","L","M","Q","R","S","T" D  Q:$G(RCSTFLAG)
 .   S COL2DESC=$P($T(@("A"_COLUMN2)),";",3)
 .   ;
 .   S COLUMN3=$S(COLUMN2=5:"*",1:"Z")
 .   S DESCRIP=COL2DESC D WRITEIT
 .   ;
 .   I $G(RCSTFLAG) Q
 .   ;
 .   ;  show hsif - disabled by patch 203
 .   ;I COLUMN2="B"!(COLUMN2="C") S DESCRIP=DESCRIP_" HSIF",COLUMN3=1 D WRITEIT
 ;
 I $G(RCSTFLAG) D Q Q
 ;
 ;  print reimbursable health insurance rsc's
 S COLUMN2=5
 W !!?6,"For REIMBURSABLE HEALTH INSURANCE [85*Z]:"
 F DECIMAL=0:1:31 D  Q:$G(RCSTFLAG)
 .   I DECIMAL<10 S COLUMN3=DECIMAL
 .   E  S COLUMN3=$C(65+DECIMAL-10)
 .   ;
 .   ;  convert decimal to binary (ex: 10011) so it can be
 .   ;  parsed in rsc to get the description
 .   S BINARY=$$CONVERT(DECIMAL)
 .   S COL3DESC=$P($T(@("B"_$E(BINARY,1,2))),";",3)
 .   S COL3DESC=COL3DESC_", "_$P($T(@("C"_$E(BINARY,3))),";",3)
 .   S COL3DESC=COL3DESC_", "_$P($T(@("D"_$E(BINARY,4))),";",3)
 .   S COL3DESC=COL3DESC_", "_$P($T(@("E"_$E(BINARY,5))),";",3)
 .   S DESCRIP=COL3DESC
 .   D WRITEIT
 ;
 ;  print fee basis reimbursable health insurance rsc's (PRCA*4.5*310/DRF)
 S COLUMN2="F"
 W !!?6,"For FEE REIMBURSABLE HEALTH INSURANCE [8F*Z]:"
 F DECIMAL=1:1:2 D  Q:$G(RCSTFLAG)
 .   S DESCRIP="FEE BASIS, NSC VET, MT CAT A, "_$S(DECIMAL=1:"INPATIENT",DECIMAL=2:"OUTPATIENT",1:"")
 .   S COLUMN3=DECIMAL
 .   D WRITEIT
Q D ^%ZISC
 Q
 ;
 ;
GETDESC(RSC) ;  return the description for the revenue source code
 N BINARY,COL3DESC,COLUMN2,COLUMN3,DESC
 I RSC="ARRV" Q "Miscellaneous"
 I RSC=8046 Q "Administrative"
 I RSC=8047 Q "Interest"
 I RSC=8048 Q "Marshal Fee and Court Cost"
 S DESC="UNKNOWN"
 S COLUMN2=$E(RSC,2)
 I "123456789ABCDEFGHIJKLMQRST"[COLUMN2 S DESC=$P($T(@("A"_COLUMN2)),";",3)
 ; HSIF reference disabled by patch 203
 ; I RSC="8B1Z"!(RSC="8C1Z") S DESC=DESC_" (HSIF)"
 I COLUMN2'=5 Q DESC
 ;
 S COLUMN3=$E(RSC,3)
 ;  convert alpha letters to decimal
 I "0123456789"'[COLUMN3 S COLUMN3=$A(COLUMN3)-55
 S BINARY=$$CONVERT(COLUMN3)
 S COL3DESC=$P($T(@("B"_$E(BINARY,1,2))),";",3)
 S COL3DESC=COL3DESC_", "_$P($T(@("C"_$E(BINARY,3))),";",3)
 S COL3DESC=COL3DESC_", "_$P($T(@("D"_$E(BINARY,4))),";",3)
 S COL3DESC=COL3DESC_", "_$P($T(@("E"_$E(BINARY,5))),";",3)
 Q "RHI, "_COL3DESC
 ;
 ;
CONVERT(DECIMAL) ;  convert decimal number to binary (5 digits)
 N Y
 S Y=""
 F  S Y=$E("0123456789ABCDEF",DECIMAL#2+1)_Y,DECIMAL=DECIMAL\2 Q:DECIMAL<1
 S Y=$E("00000",0,5-$L(Y))_Y
 Q Y
 ;
 ;
WRITEIT ;  display the rsc
 W !,COLUMN1,COLUMN2,COLUMN3,COLUMN4,?6,DESCRIP
 I $Y>(IOSL-5) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 Q
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" RCSTFLAG=1 U IO
 Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"REVENUE SOURCE CODE REPORT (VISTA TO FMS)",?(80-$L(%)),%
 W !,"RSC",?6,"Description"
 S %="",$P(%,"-",81)=""
 W !,%
 Q
 ;
 ;
 ;  this is a listing of all column2 values with a description
A1 ;;Hospital Care (NSC)
A2 ;;Outpatient Care (NSC)
A3 ;;Nursing Home Care (NSC)
A4 ;;Ineligible Hospitalization
A5 ;;Reimbursable Health Insurance
A6 ;;Tort Feasor
A7 ;;Workmans Compensation (Non-Federal)
A8 ;;C (Means Test)
A9 ;;Emergency/Humanitarian
AA ;;No Fault Auto Accident
AB ;;Pharmacy Co-Pay (SC Vet)
AC ;;Pharmacy Co-Pay (NSC Vet)
AD ;;Nursing Home Care Per Diem
AE ;;Hospital Care Per Diem
AF ;;Medicare
AG ;;Adult Day Health Care (LTC)
AH ;;Domiciliary (LTC)
AI ;;Respite Care-Institutional (LTC)
AJ ;;Respite Care-Non-Institutional (LTC)
AK ;;Geriatric Eval-Institutional (LTC)
AL ;;Geriatric Eval-Non-Institutional (LTC)
AM ;;Nursing Home Care-Long Term Care (LTC)
AQ ;;Pharmacy No Fault Auto Acc
AR ;;Pharmacy Reimburs Health Ins
AS ;;Pharmacy Tort Feasor
AT ;;Pharmacy Workman's Comp
 ;
 ;
 ;  this is a listing for the type of care, first 2 binary digits
 ;  if column2 is reimbursable health insurance
B00 ;;Inpatient (Hosp)
B01 ;;Outpatient
B10 ;;Nursing Home
B11 ;;Other
 ;
 ;
 ;  this is a listing for the service connected, binary digit 3
C0 ;;SC for NSC
C1 ;;NSC Vet
 ;
 ;
 ;  this is a listing for means test, binary digit 4
D0 ;;MT Cat A
D1 ;;MT Cat C
 ;
 ;
 ;  this is a listing for age group, binary digit 5
E0 ;;Age <65
E1 ;;Age 65+
