LBRYRPT ;ISC2/DJM-LIBRARY TECHNICIAN REPORTS ; 4/18/12 5:05pm
 ;;2.5;Library;**2,9,12,14**;Mar 11, 1996;Build 5
MIL ;Missing Issues List Report
 S TEXT="Missing Issues List" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(682,"
 S DIS(0)="I $P(^LBRY(682,D0,0),U,4)=LBRYPTR"
 S FLDS="[LBRY MISSING ISSUES LIST]",BY="[LBRY MISSING ISSUES LIST]"
 S %=0 I $D(LBRYPTR),$P($G(^LBRY(680.6,LBRYPTR,0)),U,10) D
 . W !,"List CoreFLS Vendors" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY MISSING ISSUES LIST 2]",1:FLDS),BY=$S(%=1:"[LBRY MISSING ISSUES LIST 2]",1:BY)
 D EN1^DIP
 G EXIT
DFR ;Titles Due for Renewal Report
 S TEXT="Titles Due For Renewal" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(681,"
 S DIS(0)="I $P($G(^LBRY(681,D0,1)),U,7)="""""
 S DIS(1)="I $P(^LBRY(681,D0,0),U,4)=LBRYPTR"
 S %=0 I $D(LBRYPTR),$P($G(^LBRY(680.6,LBRYPTR,0)),U,10) D
 . W "List CoreFLS vendors" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY TITLES DUE RENEWAL 2]",1:"[LBRY TITLES DUE RENEWAL]"),BY="[LBRY TITLES DUE RENEWAL]"
 D EN1^DIP
 G EXIT
LST ;Total local holdings, alphabetical w/brief or full listings
 S TEXT="All Serials Titles" D HEAD G EXIT:$G(DUOUT)=1
LST0 W "Do you want DETAILED HOLDINGS listed" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY TITLE ALPHABETICAL]",%=2:"[LBRY TITLE ALPHABETICAL BRIEF]",1:"") G:%=-1 EXIT G:%=0 LST1
 S DIS(0)="I $P(^LBRY(680,D0,0),U,4)=LBRYPTR"
 S L=0,DIC="^LBRY(680,",BY="[LBRY TITLE ALPHABETICAL]"
 D EN1^DIP
 G EXIT
LST1 W !!,"Yes will present a complete description of the title's holdings."
 W !,"No will present a brief description of the title's holdings.",!!
 G LST0
LTL ;Total local holdings printed by location w/brief or full holdings
 S TEXT="Local Titles by Location" D HEAD G EXIT:$G(DUOUT)=1
LTL0 W "Do you want DETAILED HOLDINGS listed" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY TITLE LOCATION]",%=2:"[LBRY TITLE LOCATION BRIEF]",1:"") G:%=-1 EXIT G:%=0 LTL1
 S DIS(0)="I $P(^LBRY(680,D0,0),U,4)=LBRYPTR"
 S L=0,DIC="^LBRY(680,",BY="[LBRY TITLE LOCATION]"
 D EN1^DIP
 G EXIT
LTL1 W !!,"Yes will present a complete description of the title's holdings."
 W !,"No will present a brief description of the title's holdings.",!!
 G LTL0
LTV ;Current subscriptions by vendor
 S TEXT="Active Titles by Vendor" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(681,"
 S DIS(0)="I $P(^LBRY(681,D0,0),U,4)=LBRYPTR"
 S %=0 I $D(LBRYPTR),$P($G(^LBRY(680.6,LBRYPTR,0)),U,10) D
 . W "Sort using CoreFLS Vendors" S %=1 D YN^DICN
 S FLDS="[LBRY SUBSCRIPTION/VENDOR]",BY=$S(%=1:"[LBRY SUBSCRIPTION/VENDOR 2]",1:"[LBRY SUBSCRIPTION/VENDOR]")
 D EN1^DIP
 G EXIT
LGL ;Local Titles with Gaps Lists
 S TEXT="Gaps Lists" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(680,"
 S DIS(0)="I $P(^LBRY(680,D0,0),U,4)=LBRYPTR"
 S FLDS="[LBRY GAPS LIST]",BY="[LBRY GAPS LIST]"
 D EN1^DIP
 G EXIT
LMT ;Local Microfilm Titles
 S TEXT="Local Microfilm Titles" D HEAD G EXIT:$G(DUOUT)=1
LMT0 W "Do you want microfilm holdings by titles" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY MICROFILM HOLDINGS]",%=2:"[LBRY MICROFILM VENDOR]",1:"") G:%=-1 EXIT G:%=0 LMT1
 S DIS(0)="I $P(^LBRY(680,D0,0),U,4)=LBRYPTR"
 S L=0,DIC="^LBRY(680,",BY=$S(%=1:"[LBRY MICROFILM HOLDINGS]",1:"[LBRY MICROFILM VENDOR]")
 S %=0 I $D(LBRYPTR),$P($G(^LBRY(680.6,LBRYPTR,0)),U,10) D
 . W !,"List CoreFLS Vendors" S %=1 D YN^DICN
 I %=1 S:FLDS["HOLDINGS" FLDS="[LBRY MICROFILM HOLDINGS 2]" S:BY["VENDOR" BY="[LBRY MICROFILM VENDOR 2]"
 D EN1^DIP
 G EXIT
LMT1 W !!,"'Yes' will list microfilm holdings by title."
 W !,"'No' will list microfilm holdings by vendor.",!!
 G LMT0
REC ;List of Recipients by title or recipient
 S TEXT="List of Recipients" D HEAD G EXIT:$G(DUOUT)=1
REC0 W "Do you want a list of recipients arranged by titles" S %=1 D YN^DICN
 S FLDS=$S(%=1:"[LBRY RECIPIENTS BY TITLE]",%=2:"[LBRY RECIPIENTS WITH TITLES]",1:"") G:%=-1 EXIT G:%=0 REC1
 S DIS(0)="I $P(^LBRY(681,D0,0),U,4)=LBRYPTR"
 S DIS(1)="I $P(^LBRY(680,$P(^LBRY(681,D0,0),U,2),0),U,2)="""""
 S L=0,DIC="^LBRY(681,",BY=$S(%=1:"[LBRY RECIPIENTS BY TITLE]",1:"[LBRY RECIPIENTS WITH TITLES]")
 D EN1^DIP
 G EXIT
REC1 W !!,"'Yes' will present a listing of all the recipients of any title or ToC."
 W !,"'No' will list for each recipient all the titles or ToCs received.",!!
 G REC0
ORR ;All Outstanding Routed-To-Return Issues Listed
 S TEXT="Outstanding R-T-R Issues" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(682,"
 S DIS(0)="I $P(^LBRY(682,D0,0),U,4)=LBRYPTR"
 S FLDS="[LBRY ROUTE-TO-RETURN]",BY="[LBRY ROUTE-TO-RETURN]"
 D EN1^DIP
 G EXIT
FYI ;Listing of all titles with For-Your-Information
 S TEXT="F-Y-I Local Titles List" D HEAD G EXIT:$G(DUOUT)=1
 S L=0,DIC="^LBRY(680,"
 S DIS(0)="I $P(^LBRY(680,D0,0),U,4)=LBRYPTR"
 S DIS(1)="I $P(^LBRY(680,D0,0),U,2)'="""""
 S DIS(2)="I $P($G(^LBRY(680,D0,1)),U,5)'="""""
 S FLDS="[LBRY FYI LIST]",BY=.01
 D EN1^DIP
 G EXIT
HEAD I $G(LBRYPTR)="" S DUOUT=1 Q
 W @IOF,"Serials "_TEXT_" for "_LBRYNAM_"   "
 S Y=DT X ^DD("DD") W Y,!!
 Q
EXIT I IOT="TRM" R !!,"Press return to continue: ",LBRYC:DTIME
 K L,DIC,FLDS,BY,TEXT,%,Y,LBRYC,DUOUT,DIS
 Q
