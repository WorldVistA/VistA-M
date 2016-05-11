IBCNBCD1 ;ALB/AWC - MCCF FY14 Display Annual Benefits from Insurance Buffer entry ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;* Note:  The following Input Parameters descriptions are used for routines IBCNBCD1, IBCNBCD2, IBCNBCD3 and IBCNBCD4
 ;
 ;Input Parameters:
 ;  DFN     : Internal number of an entry in the PATIENT File (#2)
 ;  IBDFN   : Internal number of an entry in the PATIENT File (#2)
 ;  IBBUFDA : Insurance Verification Processor DA
 ;  IBGRPDA : Insurance Group Plan DA
 ;  IBPOLDA : Insurance Group Plan Policy DA
 ;  IBQ     : Variable used to Quit (1=No, 0=Yes, ^=YES)
 ;  IBERR   : Variable used if error ocurred (If set then error ocurred)
 ;  IBLIST  : Global to hold Annual Benefits information (Populate using indirecton)
 ;  IBHOLD  : Global to hold Annual Benefits information (Populate using indirecton)
 ;  IBIEN   : Variable to hold Annual Benefit record IEN
 ;  IBDA    : Variable to hold Annual Benefit record DA
 ;  IBDATE  : Variable used to hold user selected/entered Date
 ;  IBSYS   : (*** DO NOT KILL ***) Global to hold VistA System Annual Benefits record for comparison (Populate using indirecton)
 ;  IBASAV  : Global used to save off data used for comparison
 ;  IBGSAV  : Global to hold Annual Benefits information for comparison (Populate using indirecton)
 ;  IBFLDS  : Variable to hold Annual Benefits field numbers
 ;  IBRTYP  : Read Type and Input modifiers^Input Parameters^Input Transform (Required)
 ;  IBPROM  : Prompt text that user will see
 ;  IBDFLT  : Default response
 ;  IBHELP  : Help text to display
 ;  IBSCRN  : Screen for pointer, set-of-code, and list/range reads
 ;  IBCOMM  : Global to hold Coverage Limitations comments (Populated using indirection)
 ;  IBSIEN  : Patient Insurance Subfile IEN's
 ;  IBRIEN  : Patient Insurance Subfile IEN's
 ;  IBFNAM  : File name used in variable pointer
 ;  IBRESULT: Array to return FM error message if there are errors when filing data
 ;  IBTYPE  : - 1 = Merge (only buffer data moved to blank fields in ins file, no replace)
 ;              2 = Overwrite (all buffer data moved to ins file, replace existing data)
 ;              3 = Replace (all buffer data including null move to ins file)
 ;              4 = Individually Accept (Skip Blanks) (user accepts individual diffs b/w buffer data and existing file data (excl blanks) to overwrite flds (or addr grp) in existing file)
 ;  IBTXT   : Text use to display to screen or reports
 ;  IBDATA  : Indirection variable to hold data in ^TMP( global
 ;  IBDTL   : Indirection variable to hold dates in ^TMP( global
 ;  IBDR    : Variable to hold DR value
 ;  IBCAT   : Standard IENS indicating internal entry numbers
 ;  IBPL    : Plan Coverage Limitation DA values
 ;  IBPLAN  : Indirection variable to hold Plan Coverage Limitation data held in the ^TMP( global
 ;  IBVAL   : Patient's relationship code
 ;  IBSEL   : 
 ;  IBEXTDA : ifn of insurance entry to update (#36,355.3,2)
 ;  RESULT  : Output array to return FM error message if there are errors when filing the buffer data
 ;  SKPBLANK: Flag - If set to 1, then when skipping blanks, display skipped items without bold
 ;
ANNBEN(IBBUFDA,IBGRPDA,IBASAV,IBQ,IBERR) ; Annual Benefits Entry point. - Called from routine ACANB^IBCNBAA
 N IBDA,IBIEN,IBDTL,IBDATA,IBHOLD,IBDATE,IBLK,IBOUT,IBEDIT,IBPOL
 S IBPOL=$$GET1^DIQ(355.3,IBGRPDA_",",2.01,,,"IBERR") I $D(IBERR) W !,"Error... ANNBEN-IBCNBCD1  Cannot get Policy field: "_2.01 D PAUSE^VALM1 Q 
 ;
 F  S IBQ=$$ASKREV() Q:IBQ'=1!($D(DTOUT))  D  Q:$D(IBERR)
 . ;
 . ; -- display list of dates for annual benefits
 . D ABDTS(IBGRPDA,.IBDTL)
 . ;
 . ; -- prompt user to select a annual benefit year
 . S IBDATE=$$ASKYR() Q:($E(IBDATE)=U)!($D(DTOUT))
 . ;
 . S IBIEN=0
 . ; -- get the annual benefits data for selected date
 . D ABDATA(IBDATE,.IBIEN,.IBDTL,.IBDATA,.IBERR) Q:$D(IBERR)
 . ;
 . ; -- user selected a date from the display list
 . I +IBIEN D  Q
 . . ;
 . . ; -- display the annual benefits for selected year
 . . S IBOUT=$$ABDISP^IBCNBCD3(IBIEN,.IBDATA,IBPOL) I IBOUT D ABCLN Q
 . . ;
 . . ; -- edit annual benefits
 . . S IBEDIT=$$EDTYR(IBDATE) I IBEDIT D ABEDIT(IBIEN,.IBASAV,.IBDATA,IBDATE,IBPOL,.IBERR),ABCLN
 . ;
 . ; -- user entered a new date not found in the display list
 . I 'IBIEN D ABDCRE(IBGRPDA,.IBIEN,.IBDATE,.IBASAV,.IBHOLD,.IBDATA,.IBERR)
 ;
 D ABCLN
 Q
 ;
ABDTS(IBGRPDA,IBDTL) ; Display a list of Annual Benefits Years to select
 N IBIEN,IBRET,IBDT,IBIDT,IBXDT
 ;
 S IBDTL=$NA(^TMP("IBCNBCD1 ABLIST DATES",$J))
 K @IBDTL
 ;
 S IBDT=""
 F  S IBDT=$O(^IBA(355.4,"APY",IBGRPDA,IBDT)) Q:IBDT']""  D
 . ;
 . ; -- annual benefits record IEN
 . S IBIEN=$O(^IBA(355.4,"APY",IBGRPDA,IBDT,0))
 . ;
 . ; -- convert fileman date to external date
 . S IBIDT=-(IBDT) D DT^DILF("E",IBIDT,.IBRET) S IBXDT=$G(IBRET(0))
 . ;
 . ; -- put dates in assending order  -  example: S @IBDTL@(nncyyddmm,IEN)=mmm dd, yyyy
 . I IBXDT["JAN" S @IBDTL@(11_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["FEB" S @IBDTL@(12_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["MAR" S @IBDTL@(13_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["APR" S @IBDTL@(14_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["MAY" S @IBDTL@(15_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["JUN" S @IBDTL@(16_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["JUL" S @IBDTL@(17_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["AUG" S @IBDTL@(18_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["SEP" S @IBDTL@(19_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["OCT" S @IBDTL@(20_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["NOV" S @IBDTL@(21_IBIDT,IBIEN)=IBXDT Q
 . I IBXDT["DEC" S @IBDTL@(22_IBIDT,IBIEN)=IBXDT
 ;
 W !!,"Benefit year:",!
 F IBDT=0:0 S IBDT=$O(@IBDTL@(IBDT)) Q:IBDT'>0  S IBIEN=$O(@IBDTL@(IBDT,0)) W ?2,@IBDTL@(IBDT,IBIEN),!
 Q
 ;
ABDATA(IBDATE,IBIEN,IBDTL,IBDATA,IBERR) ; get the annual benefits data for the user selected date
 N IBI,IBDT,IBOUT,IBFLDS
 ;
 S IBDATA=$NA(^TMP("IBCNBCD1 ABDATA DATA",$J))
 K @IBDATA
 ;
 D ABGFLD(.IBFLDS)
 ;
 S IBI="",IBDT=+IBDATE,IBOUT=0
 F  S IBI=$O(@IBDTL@(IBI)) Q:IBI']""!(IBOUT)!($D(IBERR))  D
 . ;
 . ; -- populate the IBDATA temp global with the annual benefits data
 . I $E(IBI,3,$L(IBI))=IBDT D
 . . S IBIEN=$O(@IBDTL@(IBI,0))
 . . D GETS^DIQ(355.4,IBIEN_",",.IBFLDS,"IE",.IBDATA,"IBERR") I $D(IBERR) W !,"***Error...ABDATTA^IBCNBCD1 Cannot retrieve Annual Benefits data fields." D PAUSE^VALM1 Q
 . . S IBOUT=1
 Q
 ;
ABDCRE(IBGRPDA,IBIEN,IBDATE,IBASAV,IBHOLD,IBDATA,IBERR) ; Display/Edit Annual Benefits for newly created date
 N X,Y,DA,DIC,DIE,DO,IBDTL,DLAYGO,DIRUT
 ;
 ; -- ask user to create new benifit year
 I '$$CREYR(IBDATE) Q
 ;
 S DIC="^IBA(355.4,",DIC(0)="L",DLAYGO=355.4,X=+IBDATE
 D FILE^DICN I +Y<0 S IBERR=1 W !,!,"***Error... ABDCRE^IBCNBCD1 - Cannot Create New Annual Benefit Record" D PAUSE^VALM1 Q
 ;
 ; -- update the stub record
 S (IBIEN,DA)=+Y,DIE="^IBA(355.4,",DR=".02///"_IBGRPDA
 ;
 D ^DIE K DIC,DIE,DA,DR
 ;
 ; -- put exitsing data into tmp global
 S IBDTL=$NA(^TMP("IBCNBCD1 ABLIST DATES",$J))
 K @IBDTL
 S @IBDTL@(99_+IBDATE,IBIEN)=$P(IBDATE,U,2)
 ;
 ; -- get the annual benefits data
 D ABDATA(IBDATE,IBIEN,.IBDTL,.IBDATA,.IBERR) Q:$D(IBERR)
 ;
 ; -- edit annual benefits for that year
 D ABEDIT(IBIEN,.IBASAV,.IBDATA,IBDATE,IBPOL,.IBERR)
 Q
 ;
ABEDIT(IBIEN,IBASAV,IBDATA,IBDATE,IBPOL,IBERR) ; -- Edit Patient Annual Benefits
 N IBDIF,IBOUT,IBSYS,IBGSAV
 ;
 I +$G(IBIEN) L +^IBA(355.4,IBIEN):5 I '$T D ABLKD Q
 ;
 ; ***** DO NOT KILL IBSYS *****    
 S IBSYS=$NA(^IBA(355.4,IBIEN)) ; -- **** CAUTION using Vista System Annual Benefits Global ****
 ; ***** DO NOT KILL IBSYS *****    
 ;
 ; -- save Annual Benefits data
 D ABSAVE(.IBSYS,.IBGSAV)
 ;
 ; -- edit annual benefits data  /  quit if user deleted record
 S IBOUT=$$ABEDT(IBIEN,IBGRPDA,IBDATE,IBPOL,.IBERR) Q:'$D(@IBSYS)!(+$G(IBERR))
 ;
 ; -- check for any changes made to annual benefits
 S IBDIF=$$ABDIF(.IBSYS,.IBGSAV)
 ;
 ; -- timed out ocurred and no changes
 I IBOUT&('IBDIF) D ABOUT(IBIEN) Q
 ;
 ; -- timed out with changes to annual benefits
 I IBOUT&(IBDIF) D ABUNDO(IBIEN,.IBDATA,.IBERR),ABOUT(IBIEN) Q
 ;
 ; -- ask user to save the changes or not
 I IBDIF S IBOUT=+$$ABASK() I 'IBOUT!(IBOUT']"") D ABUNDO(IBIEN,.IBDATA,.IBERR),ABOUT(IBIEN) Q
 ;
 S IBASAV=1 D ABOUT(IBIEN)
 Q
 ;
ABEDT(IBIEN,IBGRPDA,IBDATE,IBPOL,IBERR) ; Main call to edit data in Annual Benefits via Input Template
 N DA,DR,DIE,DTOUT
 ;
 W !!,"---------------------- EDIT ANNUAL BENEFITS INFORMATION  ----------------------",!
 ;
 ; -- use the input template that is stored in file 355.4 to edit annual benefits fields
 ; -- the fields are ".05;.06;2.01:2.15;2.17;3.01:3.09;4.01:4.09;5.01:5.08:5.1:5.12;5.14"
 ; -- the user will not be able to edit the .01 and .02 fields
 S DA=IBIEN,DR="[IBCN AB ACCEPT]",DIE="^IBA(355.4,"
 D ^DIE
 Q $D(DTOUT)
 ;
ABUNDO(IBIEN,IBDATA,IBERR) ; - undo any annual benefits edits
 N IBN,IBFLD,IBFDA
 S IBFDA=$NA(^TMP("IBCNBCD1 AB FDA",$J))
 K @IBFDA
 ;
 S IBN=IBIEN_","
 F IBFLD=".01":0 S IBFLD=$O(@IBDATA@(355.4,IBN,IBFLD)) Q:IBFLD'>0  S @IBFDA@(355.4,IBN,IBFLD)=$G(@IBDATA@(355.4,IBN,IBFLD,"I"))
 ;
 D FILE^DIE("I",.IBFDA,"IBERR") I $D(IBERR) W !,!,"***Error...ABUNDO^IBCNBCD1 - Cannot undo changes to the Annual Benefits file! ",! D PAUSE^VALM1
 Q
 ;
ABGFLD(IBFLDS) ; Put fields into one string
 S IBFLDS=".01;.02;.05;.06"
 S IBFLDS=IBFLDS_";2.01;2.02;2.03;2.04;2.05;2.06;2.07;2.08;2.09;2.1;2.11;2.12;2.13;2.14;2.15;2.17"
 S IBFLDS=IBFLDS_";3.01;3.02;3.03;3.04;3.05;3.06;3.07;3.08;3.09"
 S IBFLDS=IBFLDS_";4.01;4.02;4.03;4.04;4.05;4.06;4.07;4.08;4.09"
 S IBFLDS=IBFLDS_";5.01;5.02;5.03;5.04;5.05;5.06;5.07;5.08;5.09;5.1;5.11;5.12;5.14"
 Q
 ;
ABSAVE(IBSYS,IBGSAV) ; -- save the global before editing
 S IBGSAV=$NA(^TMP("IBCNBCD1 AB GLOBAL SAVE",$J))
 K @IBGSAV
 ;
 S @IBGSAV@(0)=$G(@IBSYS@(0))
 S @IBGSAV@(1)=$G(@IBSYS@(1))
 S @IBGSAV@(2)=$G(@IBSYS@(2))
 S @IBGSAV@(3)=$G(@IBSYS@(3))
 S @IBGSAV@(4)=$G(@IBSYS@(4))
 S @IBGSAV@(5)=$G(@IBSYS@(5))
 Q
 ;
ABDIF(IBSYS,IBGSAV) ; -- check for any edits made to annual benefits
 I $G(@IBSYS@(0))'=$G(@IBGSAV@(0)) Q 1
 I $G(@IBSYS@(1))'=$G(@IBGSAV@(1)) Q 1
 I $G(@IBSYS@(2))'=$G(@IBGSAV@(2)) Q 1
 I $G(@IBSYS@(3))'=$G(@IBGSAV@(3)) Q 1
 I $G(@IBSYS@(4))'=$G(@IBGSAV@(4)) Q 1
 I $G(@IBSYS@(5))'=$G(@IBGSAV@(5)) Q 1
 Q 0
 ;
ABOUT(IBIEN) ; -- Set return variable and unlock global
 I +$G(IBIEN) L -^IBA(355.4,IBIEN)
 Q
 ;
ABCLN ; Clean up ^TMP globals
 K ^TMP("IBCNBCD1 HOLD DATA",$J),^TMP("IBCNBCD1 AB GLOBAL SAVE",$J),^TMP("IBCNBCD1 ABLIST DATES",$J),^TMP("IBCNBCD1 ABDATA DATA",$J)
 Q
 ;
ABLKD ; -- write locked message
 W !!,"Sorry, another user currently editing this entry."
 W !,"Try again later."
 D PAUSE^VALM1
 Q
 ;
ABASK() ; Prompt to ask user to Save Changes
 Q $E($$READ^IBCNBAA("YA^::E","Save Changes to Annual Benefits File Y/N? ","No","Enter Yes or No to Save the Changes to the AB File <or> ^ to Quit"))
 ;
ASKREV() ; Prompt to ask user to Review the Annual Benefits
 Q $E($$READ^IBCNBAA("YA^::E","Do you want to Review the AB Y/N? ","No","Enter Yes or No to Review the Annual Benefits <or> ^ to Quit"))
 ;
ABDEDT() ; ask user if they want to Edit the Annual Benefits
 N IBSCR
 S IBSCR="FO^1:4^K:($E(X)'=""E""&($E(X)'=""e""))!($L(X)=4&(($E(X,1,4)'=""EDIT"")&($E(X,1,4)'=""edit""))) X"
 Q $$READ^IBCNBAA(IBSCR,"Enter 'E' to Edit Annual Benefits data or Return to continue","","Enter 'E' to edit Annual Benefits data <or> Return to continue <or> ^ to quit.")
 ;
ASKYR() ; Prompt to Enter a New or Existing AB year
 Q $$READ^IBCNBAA("DA^::EX","Enter Existing Date or Add New Benefit Year:  ","","Enter a New/Existing Benefit Year Date <or> ^ to Quit")
 ;
EDTYR(IBDATE) ; Prompt to Edit an Existing AB year
 Q +$$READ^IBCNBAA("YA^::E","Are you sure you want to edit existing benefit year information for: "_$P(IBDATE,U,2)_" Y/N?: ","","Enter Yes or No to Edit the Benefit Year")
 ;
CREYR(IBDATE) ; Prompt to Create a new AB year
 Q +$$READ^IBCNBAA("YA^::E","Are you sure you want to create a new benefit year for:  "_$P(IBDATE,U,2)_" Y/N? ","","Enter Yes or No to Create a new Benefit Year Date")
