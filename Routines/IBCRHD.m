IBCRHD ;ALB/ARH - RATES: UPLOAD ASSIGN & DELETE ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ACS ; OPTION: assign Charge Sets to existing XTMP files
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,IBX,IBA1,IBA2,IBFILE,IBCS,IBBI1,IBBI2
 W !!,"Assign charges loaded into XTMP to Charge Sets.",!
 ;
ACS1 W !,"------------------------------------------------------------------------------"
 D DISP1^IBCRHU1("",.IBA1,.IBA2) I 'IBA1 W !,"No files in XTMP." Q
 ;
 S DIR("A")="Assign Charge Set to which file",DIR(0)="NO^1:"_+IBA1 D ^DIR K DIR I 'Y!$D(DIRUT) Q
 S IBFILE=IBA2(+Y) Q:IBFILE=""  W !!,?5,$P(IBFILE,U,1),?40,$P(IBFILE,U,2),!
 ;
 S IBCS=$$GETCS^IBCRU1 I IBCS<0 G ACS1
 ;
 I +IBCS W !!,?7,"Charge Set: ",$P($G(^IBE(363.1,+IBCS,0)),U,1),?45,"Billable Item: ",$P($$CSBI^IBCRU3(+IBCS),U,2),!
 I +IBCS S IBX=$$CHKFL^IBCRHU1(IBCS,$P(IBFILE,U,1),$P(IBFILE,U,2)) I +IBX D EOP G ACS1
 I 'IBCS W !!,"Charge Set will be removed from the file."
 ;
 I $D(^XTMP($P(IBFILE,U,1),$P(IBFILE,U,2))) S $P(^XTMP($P(IBFILE,U,1),$P(IBFILE,U,2)),U,3)=+IBCS
 G ACS1
 Q
 ;
DEL ; OPTION:  delete files in XTMP
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,IBX,IBA2,IBA3,IBFILES,IBI,IBF1,IBF2
 W !!,"Delete files in XTMP:"
 W !,"------------------------------------------------------------------------------"
 D DISP1^IBCRHU1("","",.IBA2) I 'IBA2 W !,"No files in XTMP." Q
 ;
 S DIR("A")="Delete which files",DIR(0)="LO^1:"_+IBA2 D ^DIR K DIR I 'Y!$D(DIRUT) Q
 ;
 S IBFILES=Y F IBI=1:1 S IBF1=$P(IBFILES,",",IBI) Q:'IBF1  S IBA3(IBF1)=$G(IBA2(IBF1)),IBA3=+$G(IBA3)+1
 I 'IBA3 W !,"No files selected.",! Q
 ;
 W !!,"The following files will be deleted:",!!
 S IBI=0 F  S IBI=$O(IBA3(IBI)) Q:'IBI  W $P(IBA3(IBI),U,1),?40,$P(IBA3(IBI),U,2),!
 I '$$CONT W !,"No change." Q
 ;
 ; delete selected XTMP files
 S IBI=0 F  S IBI=$O(IBA3(IBI)) Q:'IBI  D
 . S IBF1=$P(IBA3(IBI),U,1),IBF2=$P(IBA3(IBI),U,2) I (IBF1="")!(IBF2="") Q
 . K ^XTMP(IBF1,IBF2)  W !,IBF1,?40,IBF2,?65,"... deleted."
 . I $O(^XTMP(IBF1,0))="" K ^XTMP(IBF1) W !,IBF1,?65,"... deleted.",!
 ;
 ; delete National Reasonable Charges XTMP files if after delete date
 S IBF1="IBCR RC",IBI=$O(^XTMP(IBF1)) I IBI[IBF1 D
 . S IBX=$G(^XTMP(IBI,0)) I DT'>+IBX Q
 . W !!,"Deleting Reasonable Charges XTMP files",!,"uploaded from Host Files on ",$$FMTE^XLFDT($P(IBX,U,2))
 . S IBI=IBF1 F  S IBI=$O(^XTMP(IBI)) Q:IBI'[IBF1  K ^XTMP(IBI) W "."
 W !!
 Q
 ;
CONT() ; continue y/n
 N IBZ,DIR,DIRUT,DTOUT,DUOUT,X,Y S IBZ=0
 S DIR("A")="Is this correct, do you want to continue",DIR(0)="Y" D ^DIR K DIR I Y=1 S IBZ=1 W !
 Q IBZ
 ;
EOP ; continue at end of page of display
 N DIR,DIRUT,DTOUT,DUOUT,X,Y W !,"*** ",$P($P(IBX,U,2),")",1),")",!,?16,$P($P(IBX,U,2),")",2,99),!
 S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
OPTION ; OPTION:  MAIN ENTRY POINT FOR LOADING FILES INTO THE CHARGE MASTER
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
UP1 S DIR(0)="SO^1.1:Load CMAC into XTMP;1.2:Load AWP into XTMP;1.3:Load RC into XTMP;1.4:Load TP into XTMP;2:Assign Charge Set;3:Check Data Validity;4:Load into Charge Master;5:Delete XTMP files"
 D ^DIR K DIR I 'Y!$D(DIRUT) Q
 ;
 I +Y=1.1 D CMAC^IBCRHBC G UP1
 I +Y=1.2 D AWP^IBCRHBA G UP1
 I +Y=1.3 D RC^IBCRHBR G UP1
 I +Y=1.4 D TP^IBCRHBT G UP1
 I +Y=2 D ACS^IBCRHD G UP1
 I +Y=3 D ENTRY^IBCRHO(0) G UP1
 I +Y=4 D ENTRY^IBCRHO(1) G UP1
 I +Y=5 D DEL^IBCRHD G UP1
 Q
 ;
 ;
 ; Format of XTMP file created from host files to load into Charge Master:
 ;   ^XTMP(XRF1, 0) = delete DT ^ loaded DT ^ Name, time, user ^ total count
 ;   ^XTMP(XRF1, XRF2) = subfile count ^ billable item type ^ Charge Set (added by user)
 ;   ^XTMP(XRF1, XRF2, x) = item ptr ^ eff dt ^ inactive dt ^ $ charge ^  modifier ptr
