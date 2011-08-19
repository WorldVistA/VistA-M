DGRPEIS3 ;ALB/CAW,EG,ERC,BAJ,TDM - INCOME SCREENING DATA (CON'T) ; 5/26/10 2:03pm
 ;;5.3;Registration;**45,624,659,653,688,754**;Aug 13, 1993;Build 46
 ;
HELP ; Display information when veteran's DOB is past the income year
 ;
 W !!,"Please return to screen 8 and check the veteran's effective date."
 W !,"The effective date was created based on the veteran's date of birth."
 W !,"You might also want to check the date of birth for this veteran."
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
WRT ; Write age statement
 Q:'$G(DGMTI)
 W !!,"This dependent is 18 years or older.  To list this person as a dependent"
 W !,"they have to be:"
 W !,"     1.  An UNMARRIED child who is under the age of 18."
 W !,"     2.  Between the ages of 18 and 23 and attending school."
 W !,"     3.  An unmarried child over the age of 17 who became permanently"
 W !,"         incapable of self support before the age of 18."
 Q
 ;
EDIT ;CALLED FROM ROUTINE DGRPEIS
 N DGEXIT,SSNV,SSNVL,SSNUM
 S DGEDDEP=1
 S DGFL=$G(DGFL)
 S DATE=$S($G(DATE):DATE,1:$$LYR^DGMTSCU1(DT))
 S X=$P(DGPREF,"^",2)
 S DGTYPE=$G(DGTYPE),DGTYPE=$S(DGTYPE']"":"S",DGTYPE="C":"C",DGTYPE="D":"D",1:"S")
 S DIE="^"_$P(X,";",2),DA=+X
 ;
 ; DG*5.3*653 ERC Pseudo SSN Reason changes
 ; DG*5.3*688 BAJ SSN Verification changes
 ; 
 ; Retrieve SSN VERIFIED statusrequired 
 S SSNVL=DIE_DA_",0)"
 S SSNUM=$P(@SSNVL,"^",9),SSNV=$P(@SSNVL,"^",11)
 ;
 ; Lock SSN if SSN is VERIFIED
 S DR=$S(SSNV=4:".01;.02;.03;S UPARROW=1",1:".01;.02;.03;.09;S UPARROW=1")
 S DGEXIT=0
 K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1) S DGEXIT=1 D EDITQ Q
 I SSNV="V" W !,"SOCIAL SECURITY NUMBER "_SSNUM_" has been verified by SSA -- NO EDITING"
 ;
 ; changes to make Pseudo SSN Reason required - DG*5.3*653, ERC
 S DGEXIT=0 I $P($G(@(DIE_DA_",0)")),U,9)["P" D SSNREA(.DGEXIT) I DGEXIT=1 Q
 I DGTYPE="S" D
 . S DR="1.1;S UPARROW=1"
 . K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1) S DGEXIT=1
 I DGEXIT=1 Q
 ;
 ; ; end SSN Verification & Pseudo SSN Reason changes
 ; 
 S DOB=$P($G(@(DIE_DA_",0)")),U,3)
 ;
 N DGVADD,DGSADD,DGIPIEN,DGUQTLP,SPOUSE,DGFL,DGRPI
 S (DGVADD,DGSADD,DGIPIEN,DGUQTLP)=0
 S SPOUSE=$S(DGTYPE="S":1,1:0),DGFL=$G(DGFL)
 ;
 ; if veteran address is not USA, skip this ^DIR call
 I $$FORIEN^DGADDUTL($P($G(^DPT(DFN,.11)),U,10)) G FOREIGN
 ; Is spouse/dependent address same as patient address?
 K DIR
 S DIR(0)="YAO^^"
 S DIR("A")="STREET ADDRESS SAME AS PATIENT'S: "
 S DIR("B")="YES"
 S DIR("?")="Enter 'Y' if the "_$S(SPOUSE:"spouse",1:"child")_" has the same address as the patient, otherwise enter 'N'."
 D ^DIR
 S DGVADD=+Y
 K Y,DIR
FOREIGN ;tag added for rejoining if country not USA
 S DGIPIEN=$$SPSCHK^DGRPEIS(DFN)
 I 'DGVADD,(DGTYPE'="S"),DGIPIEN D
 . K DIR,Y
 . S DIR(0)="YAO^^"
 . S DIR("A")="STREET ADDRESS SAME AS SPOUSE'S: "
 . S DIR("B")="YES"
 . S DIR("?")="Enter 'Y' if the child has the same address as the spouse, otherwise enter 'N'."
 . D ^DIR
 . S DGSADD=+Y
 . K Y,DIR
 ;
 ; If spouse/dependent address is same as patient's, set spouse/dep address
 I DGVADD!DGSADD D
 . I DGVADD D PATASET^DGRPEIS(DFN) ;*Set to Patient address
 . I DGSADD D SPSASET^DGRPEIS(DGIPIEN) ;*Set to Spouse address
 . N FLD,FDA S FLD=0 F  S FLD=$O(ANS(FLD)) Q:'FLD  D
 . . S FDA(408.13,DA_",",FLD)=ANS(FLD) K ANS(FLD)
 . D FILE^DIE("","FDA","")
 ;
 ;Spouse/dep address not same as patient/spouse address; prompt for it
 I 'DGVADD,'DGSADD D
 . S DR="1.2;S:X']"""" Y=1.5;1.3;S:X']"""" Y=1.5;1.4;1.5;1.6;1.7;1.8;S UPARROW=1"
 . K DG,DQ D ^DIE
 I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1) D EDITQ Q
 ;
 I DGTYPE'="S" K UPARROW S DIE="^DGPR(408.12,",DA=+DGPREF,DR=".02;S UPARROW=1" K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1)
 S RELATION=$P($G(^DGPR(408.12,+DGPREF,0)),"^",2)
 S DGX=$O(^DGPR(408.12,+DGPREF,"E","AID","")),DGMIEN=$O(^(+DGX,0))
EDACTDT I $G(^DGPR(408.12,+DGPREF,"E",+DGMIEN,0)) D  G:$G(DGFL)<0 EDITQ
 . S (DGACT,Y)=+^(0) X ^DD("DD")
 . S DIR("B")=Y
 . D READ^DGRPEIS2
 . I -DGACT'=DGX W !,"Use 'Expand Dependent' option to change effective date." H 2 S DGFL=-1 Q
 . Q:$G(DGFL)<0
 . S DIE="^DGPR(408.12,"_+DGPREF_",""E"",",DA(1)=+DGPREF,DA=DGMIEN,DR=".01///"_DGACT
 . D ^DIE
 I DGTYPE="S" S X=+DGPREF D SETUP^DGRPEIS1
 K DGACT,DGMIEN,RELATION,DA,DIE,DR,UPARROW,DTOUT,DUOUT,DIRUT
EDITQ K DA,DIE,DIRUT,DR,DTOUT,DUOUT
 Q
 ;
SSNREA(DGEXIT) ;if SSN is pseudo Pseudo SSN Reason is required - DG*5.3*653
 N I,EXIT
 S EXIT=0
 F  D  Q:EXIT
 . S DR=$S(DIE["DGPR":.1,1:.0906)_";S UPARROW=1"
 . K DG,DQ D ^DIE I $D(DTOUT)!$D(DUOUT)!'$D(UPARROW) S DGFL=$S($D(DTOUT):-2,1:-1) S (EXIT,DGEXIT)=1 Q
 . I $P($G(@(DIE_DA_",0)")),U,10)']"" S EXIT=0 Q
 . S EXIT=1
 Q
HELP1(DGISDT) ; Displays the help for the active/inactive prompt
 ;
 D CLEAR^VALM1
 W !,"Enter the date this person first became a dependent of the veteran."
 W !,"In the case of a spouse, this would be the date of marriage.  For"
 W !,"a child, this would be the date of birth or date of adoption.  For a"
 W !,"stepchild, this would be the date of marriage to the child's parent."
 W !!,"Date must be before DEC 31, "_DGISDT_" as dependents are collected for the"
 W !,"prior calendar year only."
 S VALMBCK="R"
 Q
 ;
HELPDOB ; * Displays help for Date of Birth
 N DGRDVAR
 I X="?" D  Q
 . W !?5,"Enter the date this dependent was born.  The date must not be during the"
 . W !?5,"current calendar year.  Only persons that were dependents before the"
 . W !?5,"current year may be entered.",!
 . I $G(DA) W !,"Enter RETURN to continue:" R DGRDVAR:DTIME W !
 ;
 W !?8,"Enter the date on which this relative was born.  This information is"
 W !?8,"necessary for use in the income screening and means test portions of"
 W !?8,"MAS."
 W !!?8,"The date entered must not be during the current calendar year.  That"
 W !?8,"is, it must be on or before December 31 or the prior calendar year."
 I $G(DA) W ! S DIR(0)="E" D ^DIR Q:+Y<1
 W !!?8,"The reason for this is that this data is used for collecting income"
 W !?8,"information for the purposes of comparing this data with the Internal"
 W !?8,"Revenue Service (IRS).  Children born during the calendar year cannot"
 W !?8,"be entered until next year."
 I $G(DA) W !!,"Enter RETURN to continue:" R DGRDVAR:DTIME W !
 Q
 ;
HELPMN ; * Displays help for Spouse Maiden Name
 W !?8,"Enter the spouse's maiden name in 'LAST,FIRST MIDDLE SUFFIX' format."
 W !?8,"Entry of the LAST name only is permitted and the comma may be omitted."
 W !?8,"If the response contains no comma, one will be appended to the value."
 W !?8,"Including the comma, the value must be at least 3 characters in length.",!
 Q
 ;
HELPSA1 ; * Displays help for Street Address 1
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"If a "_DGRELTP_"'s name has been specified, enter the first line of"
 W !,"that person's street address [3-30 characters]; otherwise this field"
 W !,"may be left blank.  This field cannot be deleted as long as a "_DGRELTP_"'s"
 W !,"name is on file."
 I $G(DA),(X="?") W !
 Q
 ;
HELPSA2 ; * Displays help for Street Address 2
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"If a "_DGRELTP_"'s name has been specified, enter the second line of"
 W !,"that person's street address [3-30 characters]; otherwise this field"
 W !,"may be left blank.  This field cannot be deleted as long as a "_DGRELTP_"'s"
 W !,"name is on file."
 I $G(DA),(X="?") W !
 Q
 ;
HELPSA3 ; * Displays help for Street Address 3
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"If a "_DGRELTP_"'s name has been specified, enter the third line of"
 W !,"that person's street address [3-30 characters]; otherwise this field"
 W !,"may be left blank.  This field cannot be deleted as long as a "_DGRELTP_"'s"
 W !,"name is on file."
 I $G(DA),(X="?") W !
 Q
 ;
HELPCITY ; * Displays help for City
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"If a "_DGRELTP_"'s name has been specified, enter the city in which"
 W !,"that person resides [3-30 characters]; otherwise this field may be"
 W !,"left blank.  This field cannot be deleted as long as a "_DGRELTP_"'s"
 W !,"name is on file."
 I $G(DA),(X="?") W !
 Q
 ;
HELPSTAT ; * Displays help for the state
 N DGRELTP,DIRA,DGRDVAR,DDIOLARY
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 S DDIOLARY(1)="If a "_DGRELTP_"'s name has been specified, select the state in which"
 S DDIOLARY(1,"F")="!"
 S DDIOLARY(2)="that person resides; otherwise this field may be left blank.  This"
 S DDIOLARY(2,"F")="!"
 S DDIOLARY(3)="field cannot be deleted as long as a "_DGRELTP_"'s name is on file."
 S DDIOLARY(3,"F")="!"
 S DDIOLARY(4)=""
 S DDIOLARY(4,"F")="!"
 D EN^DDIOL(.DDIOLARY)
 ;
 Q:X="?"
 D EN^DDIOL("Enter RETURN to continue:","","!")
 R DGRDVAR:DTIME
 Q
 ;
HELPZIP ; * Displays help for the Zip code
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"Answer with the 5 digit format (e.g. 12345) or the nine digit"
 W !,"format (e.g. 12345-6789 or 123456789).  This is related to the"
 W !,DGRELTP_"'s address."
 I $G(DA),(X="?") W !
 Q
HELPPHON ; * Displays help for the Phone number
 N DGRELTP
 S DGRELTP=$$RELTYPE^DGRPEIS2($G(DA),1)
 W !,"If a "_DGRELTP_"'s name has been specified, enter the "_DGRELTP_"'s"
 W !,"phone number [4-20 characters], otherwise this field may be left"
 W !,"blank.  This field cannot be deleted as long as a "_DGRELTP_"'s"
 W !,"name is on file."
 I $G(DA),(X="?") W !
 Q
