HBHCTXT2 ; LR VAMC(IRMS)/MJT-HBHC Medical Foster Home (MFH) delimited text file output, user selects Inspection or Training data, includes all data on file ; Dec 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
EN ; Prompt for whether Inspection or Training report 
 K DIR S DIR(0)="SB^I:Inspection;T:Training",DIR("A")="Include Inspection or Training data",DIR("?")="Include Inspection (I) or Training (T) data on report." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHCTYP=Y
 S %ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCTXT2",ZTDESC="HBPC MFH Inspection/Training Delimited File Output",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 S HBHCDLMT=U
 W "Medical Foster Home Name"_HBHCDLMT_"MFH Closure Date"_HBHCDLMT
 I HBHCTYP="I" W "Inspection Discipline"_HBHCDLMT_"Inspection Date"_HBHCDLMT_"Inspector Name"
 I HBHCTYP="T" W "Training Category"_HBHCDLMT_"Training Date"_HBHCDLMT_"Other Training Topic"
LOOP ; Loop thru ^HBHC(633.2 Inspection multiples; 1 = Nurse, 2 = Social Work, 3 = Dietitian, 4 = Fire/Safety
 I HBHCTYP="I" S HBHCI=0 F  S HBHCI=$O(^HBHC(633.2,HBHCI)) Q:HBHCI'>0  F HBHCJ=1:1:4 S HBHCK=0 F  S HBHCK=$O(^HBHC(633.2,HBHCI,HBHCJ,HBHCK)) Q:HBHCK'>0  D SET
LOOP2 ; Loop thru ^HBHC(633.2 Training multiples; 5 = Home Operation, 6 = Fire/Safety, 7 = Medication Management, 8 = Personal Care, 9 = Infection Control, 10 = End of Life, 11 = Other 
 I HBHCTYP="T" S HBHCI=0 F  S HBHCI=$O(^HBHC(633.2,HBHCI)) Q:HBHCI'>0  F HBHCJ=5:1:11 S HBHCK=0 F  S HBHCK=$O(^HBHC(633.2,HBHCI,HBHCJ,HBHCK)) Q:HBHCK'>0  D SET
EXIT ; Exit module
 D ^%ZISC
 K DIR,HBHCCLOS,HBHCDAT,HBHCDLMT,HBHCI,HBHCJ,HBHCK,HBHCNODE,HBHCPRV,HBHCTYP,X,Y
 Q
SET ; Set ^TMP node for valid record
 ; quit if no Inspection or Training data 
 Q:'$D(^HBHC(633.2,HBHCI,HBHCJ))
 ; notate if MFH closed
 S (HBHCDAT,HBHCCLOS)="" S:$P(^HBHC(633.2,HBHCI,0),U,6)]"" HBHCDAT=$P(^HBHC(633.2,HBHCI,0),U,6),HBHCCLOS=$E(HBHCDAT,4,5)_"-"_$E(HBHCDAT,6,7)_"-"_$S($E(HBHCDAT)=3:20,1:19)_$E(HBHCDAT,2,3)
 S HBHCNODE=^HBHC(633.2,HBHCI,HBHCJ,HBHCK,0)
 W !,$P(^HBHC(633.2,HBHCI,0),U)_HBHCDLMT_HBHCCLOS_HBHCDLMT
 I HBHCTYP="I" W $S(HBHCJ=1:"Nurse",HBHCJ=2:"Social Work",HBHCJ=3:"Dietitian",1:"Fire/Safety")
 I HBHCTYP="T" W $S(HBHCJ=5:"Home Operation",HBHCJ=6:"Fire/Safety",HBHCJ=7:"Medication Management",HBHCJ=8:"Personal Care",HBHCJ=9:"Infection Control",HBHCJ=10:"End of Life",1:"Other")
 W HBHCDLMT_$E($P(HBHCNODE,U),4,5)_"-"_$E($P(HBHCNODE,U),6,7)_"-"_$S($E($P(HBHCNODE,U))=3:20,1:19)_$E($P(HBHCNODE,U),2,3)
 I HBHCTYP="I" D NAME W HBHCDLMT_$S(HBHCPRV]"":HBHCPRV,1:"")
 I HBHCTYP="T" W:$P(HBHCNODE,U,2)]"" HBHCDLMT_$P(HBHCNODE,U,2)
 Q
NAME ; Obtain Provider Name from VA(200 file
 N Y
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 S DIC=200,DR=.01,DA=$P(HBHCNODE,U,2) D EN^DIQ1
 S HBHCPRV=^UTILITY("DIQ1",$J,200,DA,DR)
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 Q
