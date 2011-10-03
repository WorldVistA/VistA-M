EASEZU5 ;ALB/jap - Utilities for 1010EZ Processing ; 5/27/08 12:23pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,51,70**;Mar 15, 2001;Build 26
 ;
PRTCOMP ;print comparison of 10-10EZ data with VistA data
 N ACTION
 S ACTION="'Print Data'"
 ;no action if closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;proceed with print of data comparison
 W !,"Data Print queued to background...",!
 S VALMBCK="R"
 D PAUSE^VALM1
 Q
 ;
UPDATE ;update/overwrite a 10-10EZ data element
 N ACTION,SIGDATE,EASSEL,EASERR,EASLN,LN,SUBIEN,MULTIPLE,KEYIEN,UPDATE,UPDATE2,FILE,SUBFILE,FLD,FFF
 N ORIGINAL,DATANM,UPDATE,CODE,FILE,SUBFILE,FLD,FDEF,FTYPE,ROOT,SETCODES,MIN,MAX,X,Y,DA,DR,DIC,DIE,DIR,X1,X2,X3
 ;variable ORIGINAL holds original 1010EZ data
 S ACTION="'Update Field'"
 ;no action if closed
 I EASPSTAT="CLS" D NOACT^EASEZLM("Inactivated",ACTION) Q
 ;invalid for the following process status
 I EASPSTAT="NEW" D NOACT^EASEZLM("New",ACTION) Q
 I EASPSTAT="PRT" D NOACT^EASEZLM("Unsigned",ACTION) Q
 I EASPSTAT="FIL" D NOACT^EASEZLM("Filed",ACTION) Q
 ;select data item to update
 S VALMBCK="R"
 D SEL^EASEZLM
 Q:$G(EASERR)
 Q:'$G(EASSEL)
 S EASLN=EASSEL
 ;
 ;use DIR reader to get input from user which overwrites 1010EZ data
 D FULL^VALM1
 S DIR(0)="",(FDEF,FTYPE)=""
 S LN=^TMP("EASEXP",$J,"IDX",EASLN),SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S X=$G(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1)),ORIGINAL=$P(X,U,1),ACCEPT=$P(X,U,2)
 S DATANM=$P($G(^EAS(711,KEYIEN,0)),U,1)
 S:DATANM="ASSET(N) CASH IN BANK" DATANM="CHILD(N) CASH IN BANK"
 S:DATANM="ASSET(N) LAND/BLDGS. LESS MORTGAGES" DATANM="CHILD(N) LAND/BLDGS. LESS MORTGAGES"
 S:DATANM="ASSET(N) OTHER PROPERTY, ASSETS LESS AMT. OWED" DATANM="CHILD(N) LAND/BLDGS. LESS MORTGAGES"
 S DIR("A")=DATANM
 ;if #3 of file #711 is defined then use to set DIR(0);
 S X=$G(^EAS(711,KEYIEN,3)) I X'="" X X
 S FFF=$G(^EAS(711,KEYIEN,1)),FILE=$P(FFF,U,1),SUBFILE=$P(FFF,U,2),FLD=$P(FFF,U,3)
 ;don't allow updates to data which cannot be filed
 I ((FILE=0)!(ACCEPT=-1)) D  Q
 . W !!,?5,"Sorry...the selected data element cannot be 'Updated'."
 . D ADDMSG ;alb/cmf/51
 . W !!,?5,"After filing this Application to VistA, use Register a Patient "
 . W !,?5,"or Patient Enrollment to enter/update data as needed.",!
 . K DIR D PAUSE^VALM1 S VALMBCK="R"
 ;exceptions for data input; too complex for simple DIR call;
 I DATANM["NAME",DATANM'["OTHER" D ANAME^EASEZU6(EASLN,LN,DATANM) Q
 I DATANM["PHONE" D APHONE^EASEZU6(EASLN,LN,DATANM) Q
 I DATANM["COUNTY" D ACOUNTY^EASEZU6(EASLN,LN,DATANM) Q
 I DATANM["STATE" D ASTATE^EASEZU6(EASLN,LN,DATANM) Q
 I DATANM["SOCIAL SECURITY NUMBER",FILE'=2 D ASSN^EASEZU6(EASLN,LN,DATANM,ACCEPT) Q
 ;setup DIR(0) for remaining mapped-to data elements
 I DIR(0)="",FLD'=0 D
 . ;use DIR read based on mapped-to file/field for all other data elements
 . I (SUBFILE=FILE)!(SUBFILE="") S FDEF=FILE
 . E  S FDEF=SUBFILE
 . S FTYPE=$$GET1^DID(FDEF,FLD,"","TYPE")
 . ;can't use DD type read, some fields will error because DA is not defined for the input transform;
 . ;so set DIR(0) according to field type of VistA target location instead;
 . I FTYPE["POINTER" D
 . . ;mapped to pointer field
 . . S ROOT=$$GET1^DID(FDEF,FLD,"","POINTER")
 . . I ROOT'="" S DIR(0)="P"_U_ROOT_":EMZ"
 . I FTYPE="SET" D
 . . ;mapped to set of codes field
 . . S X=^DD(FDEF,FLD,0)
 . . S SETCODES=$P(X,U,3) K X
 . . S DIR(0)="S"_U_SETCODES
 . I FTYPE="DATE/TIME" D
 . . ;mapped to date/time field
 . . S DIR(0)="D^::AEP"
 . I FTYPE="FREE TEXT" D
 . . ;mapped to free text field
 . . S MAX=$$GET1^DID(FDEF,FLD,"","FIELD LENGTH")
 . . I MAX S DIR(0)="F^1:"_MAX
 . . E  S DIR(0)="F^1:80"
 . I FTYPE="NUMERIC" D
 . . ;mapped to numeric field
 . . S FINP=$$GET1^DID(FDEF,FLD,"","INPUT TRANSFORM")
 . . S MIN=+$P(FINP,"X<",2),MAX=+$P(FINP,"X>",2)
 . . ;ALB/70/AMA -- allow 2 decimal places
 . . I MAX S DIR(0)="N"_U_MIN_":"_MAX_":2"
 . . E  S DIR(0)="N^0:9999999:2"
 . . ;Only non-decimal-place field is Rated Percentage, 2/.302
 . . I (FDEF=2),(FLD=.302) S DIR(0)=$P(DIR(0),":",1,2)_":0"
 I FLD=0 D
 . ;unmapped data element
 . I DIR(0)="" S DIR(0)="F^1:80"
 ;make the DIR call for user input only if DIR(0) has been set
 Q:DIR(0)=""
 D ^DIR
 ;don't continue if user exited w/o input
 Q:($D(DTOUT)!$D(DUOUT))
 K DIR,DTOUT,DUOUT,DIRUT
 ;pickup the DIR output
 S UPDATE=$P($G(Y(0)),U,1) S:UPDATE="" UPDATE=$P($G(Y),U,1)
 ;don't continue if no data
 Q:UPDATE=""
 ;convert dates to mm/dd/yyyy
 I FTYPE="DATE/TIME" D
 . ;Y holds date from DIR call in internal format 
 . S %F=5,UPDATE2=$$FMTE^XLFDT(Y,%F) I $L(UPDATE2)<10 D
 . . S X1=$P(UPDATE2,"/",1),X2=$P(UPDATE2,"/",2),X3=$P(UPDATE2,"/",3)
 . . S:$L(X1)=1 X1="0"_X1 S:$L(X2)=1 X2="0"_X2
 . . S UPDATE2=X1_"/"_X2_"/"_X3
 . . S UPDATE=UPDATE2
 ;special handling for field #.362
 I FILE=2,FLD=.362,EASVRSN>5.99 D
 . I UPDATE["IN LIEU OF VA COMP" S UPDATE="YES"
 . I UPDATE="YES, RECEIVING MILITARY RETIREMENT" S UPDATE="NO"
 ;don't continue if no change to data
 Q:(UPDATE=ORIGINAL)
 Q:(UPDATE="")
 ;
 I 'ACCEPT S ACCEPT=1
 S $P(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1),U,1,2)=UPDATE_U_ACCEPT
 ;file data element; any manually updated element is 'accepted'
 S DIE="^EAS(712,EASAPP,10,",DA=SUBIEN,DA(1)=EASAPP,DR(1)="10;"
 S DR="1.5///^S X=UPDATE;1.1///^S X=ACCEPT;1.2///^S X=DT;1.3////^S X=DUZ"
 D ^DIE
 S VALMBCK="R"
 ;update screen list
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
 ;
REMSIG ;remove signature verification from selected Application
 N APP,STATUS,DA,DIC,DR,DIR,DIRUT,DUOUT,DTOUT,S,X,Y
 W @IOF
 W !!,"Lookup and selection for Signature Verification Removal"
 W !,"is by Application # only."
 W !!,"Only Applications with a Signature Verification Date, but no"
 W !,"Filing Date may be selected.",!!
 S DIC="^EAS(712,",DIC(0)="AENQXZ",DIC("S")="I +$P($G(^(1)),U,2)>0,+$P($G(^(2)),U,5)=0"
 D ^DIC
 S APP=+Y
 I APP>0 D
 . S DIR(0)="YA",DIR("A")="Are you sure Signature Verification should be removed? (Y/N): " D ^DIR
 . Q:$D(DIRUT)
 . Q:'Y
 . W !!,"One moment please...",!
 . ;remove signature verification data; update audit fields for sig. removal
 . S DA=APP K X,Y
 . S DIE=DIC,DR="4///^S X=""@"";4.1///^S X=""@"";4.2///^S X=""@"";4.6///^S X=DT;4.7////^S X=DUZ"
 . D ^DIE
 . D APPINDEX^EASEZU2(APP)
 . S S=$$CURRSTAT^EASEZU2(APP),STATUS=$S(S="PRT":"Printed, Pending Signature",1:"In Review")
 . W !!,"Signature Verification removed..."
 . W !!,"Application #"_APP_" STATUS -- ",STATUS
 W !!
 Q
 ;
ADDMSG ;alb/cmf/51 - special update messages by field
 N SECT,S1,S2
 Q:EASVRSN<6
 S SECT=$P($P(^EAS(711,KEYIEN,0),U,2),";")
 Q:SECT'["II"
 ;
 I SECT="IIC" D  Q
 . I DATANM="CHILD1 GROSS ANNUAL INCOME2" D  Q
 . . D INCTOT("Employment","employment")
 . I DATANM="CHILD1 OTHER INCOME AMOUNTS" D  Q
 . . D INCTOT("Other","other")
 . I DATANM="CHILD1 FARM OR BUSINESS INCOME" D  Q
 . . D INCTOT("Farm/Business","farm/business")
 ;
 I SECT="IIE" D  Q
 . I DATANM="CHILD1 CASH IN BANK" D  Q
 . . D ASSTOT("Cash in Bank","cash in bank")
 . I DATANM="CHILD1 LAND/BLDGS. LESS MORTGAGES" D  Q
 . . D ASSTOT("Land/Bldgs.","land/bldgs.")
 . I DATANM="CHILD1 OTHER PROPERTY, ASSETS LESS AMT. OWED" D  Q
 . . D ASSTOT("Other Property","other property")
 ;
 I SECT="IIG" D  Q
 . I DATANM="ASSET(N) CHILD CASH" D CHLDASS("Cash in Bank") Q
 . I DATANM="ASSET(N) CHILD REAL PROPERTY" D CHLDASS("Real Property") Q
 . I DATANM="ASSET(N) CHILD OTHER PROPERTY" D CHLDASS("Other Property") Q
 Q
 ;
INCTOT(S1,S2) ; income total messages
 W !!,?5,"The "_S1_" Income Child Total is the sum of the"
 W !,?5,"individual child "_S2_" income values.  The Child Total"
 W !,?5,"may only be updated by adjusting the individual child"
 W !,?5,S2_" income values.  - or..."
 Q
 ;
ASSTOT(S1,S2) ; asset total messages
 W !!,?5,"The "_S1_" Child Total is the sum of the individual child"
 W !,?5,S2_" values.  The Child Total may only be adjusted by"
 W !,?5,"updating the individual child "_S2_" values.  - or..."
 Q
 ;
CHLDASS(S1) ; child asset messages
 W !!,?5,"The "_S1_" child amount has been added to the "_S1
 W !,?5,"Veteran amount.  The "_S1_" child amount may only"
 W !,?5,"be adjusted by updating the "_S1_" Veteran amount."
 W !,?5,"  - or..."
 Q
 ;
