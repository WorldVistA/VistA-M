IBCNBAC ;ALB/ARH/DAOU/WCW-Ins Buffer: Individually Accept Insurance Buffer Fields ; 28-APR-03
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
INS(IBBUFDA,IBINSDA,SKPBLANK) ; display a buffer entry's insurance company fields and an existing insurance company fields for comparison
 N IBEXTDA,IBFLD1,IBFLD2,X I '$G(IBBUFDA) Q
 S SKPBLANK=$G(SKPBLANK)
 ;
 S IBEXTDA=$G(IBINSDA)_","
 ;
 I +$P($G(^DIC(36,+IBEXTDA,0)),U,5) W !,?10,"Selected Insurance Company "_$$GET1^DIQ(36,IBEXTDA,.01)_" is Inactive!",!
 ;
 W @IOF
 W ! D WRTFLD("  Insurance Data:  Buffer Data                     Selected Insurance Company   ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(36,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.05),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(36,IBEXTDA,1),1:"") D WRTLN("Reimburse?:",IBFLD1,IBFLD2,"","","U")
 ;
 D FIELDS("INS","",SKPBLANK)
 ;
 Q
 ;
GRP(IBBUFDA,IBGRPDA,SKPBLANK) ; display a buffer entrys group insurance fields and an existing group/plan's fields for comparison
 N IBEXTDA,IBFLD1,IBFLD2,X I '$G(IBBUFDA) Q
 S SKPBLANK=$G(SKPBLANK)
 ;
 S IBEXTDA=$G(IBGRPDA)_","
 ;
 I +$P($G(^IBA(355.3,+IBEXTDA,0)),U,11) W !,?23,"Selected Group/Plan is Inactive!",!
 ;
 W @IOF
 W ! D WRTFLD(" Group/Plan Data:  Buffer Data                     Selected Group/Plan          ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(355.3,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,40.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(355.3,IBEXTDA,.02),1:"") D WRTLN("Is Group Plan?:",IBFLD1,IBFLD2,"","","U")
 ;
 D FIELDS("GRP","",SKPBLANK)
 ;
 Q
 ;
POLICY(IBBUFDA,IBPOLDA,SKPBLANK) ; display a buffer entrys patient policy fields and an existing patient policy's fields for comparison
 N DFN,IBEXTDA,IBFLD1,IBFLD2,X,Y,DIR,DIRUT I '$G(IBBUFDA) Q
 S SKPBLANK=$G(SKPBLANK)
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 ;
 S IBEXTDA=$G(IBPOLDA)_","_DFN_","
 ;
 W @IOF
 W ! D WRTFLD("     Policy Data:  Buffer Data                     Selected Policy              ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2.312,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,40.03),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2.312,IBEXTDA,21),1:"") D WRTLN("Group #:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,60.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2,DFN,.01),1:"") D WRTLN("Patient Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$P($$GET1^DIQ(355.33,IBBUFDA,.1),"@"),IBFLD2=$S(+IBEXTDA:$P($$GET1^DIQ(2.312,IBEXTDA,1.03),"@"),1:"") D WRTLN("Last Verified:",IBFLD1,IBFLD2,"","","U")
 ;
 D FIELDS("POL","",SKPBLANK)
 ;
 I +$G(^IBA(355.33,IBBUFDA,61))!($$GET1^DIQ(2.312,IBEXTDA,2.1)="YES") D ESGHP(SKPBLANK)
 ;
 Q
 ;
ESGHP(SKPBLANK) ; display employee sponsored group health plan
 S SKPBLANK=$G(SKPBLANK)
 W !!
 ;
 D FIELDS("POL",1,SKPBLANK)
 ;
 Q
 ;
FIELDS(SET,ESGHP,SKPBLANK) ; accept each field and set into temp array
 N CHGCHK,IBFLDLST,IBFLDVAL,IBUSER,IBLABEL,EXTFILE,IBEXTFLD
 S ESGHP=$G(ESGHP),SKPBLANK=$G(SKPBLANK)
 ;
 K IBFLDS,IBADDS,IBLBLS
 ;
 S EXTFILE=+$P($T(@(SET_"DR")+1^IBCNBMI),";;",2)
 D FIELDS^IBCNBMI(SET_"FLD")
 ;
 S CHGCHK=0 ; Initialize variable to check for any items to accept
 S IBBUFFLD=0 F  S IBBUFFLD=$O(IBFLDS(IBBUFFLD)) Q:'IBBUFFLD  I '$D(IBADDS(IBBUFFLD)) D  Q:$G(IBUSER)<0
 . I '$$ESGHPFLD(ESGHP,IBBUFFLD) Q
 . ;
 . S IBEXTFLD=IBFLDS(IBBUFFLD),IBLABEL=IBLBLS(IBBUFFLD)_":"
 . S IBFLDVAL=$$DISPLAY(IBBUFFLD,EXTFILE,IBEXTFLD,IBLABEL)
 . I $P(IBFLDVAL,U,1)=$P(IBFLDVAL,U,2) Q
 . I SKPBLANK,$P(IBFLDVAL,U,1)="" Q
 . ;
 . S CHGCHK=1
 . S IBUSER=$$ACCEPT($P(IBFLDVAL,U,1),$P(IBFLDVAL,U,2)) Q:IBUSER<0
 . I +IBUSER S ^TMP($J,"IB BUFFER SELECTED",IBBUFFLD)=""
 ;
 S IBFLDLST="" ; allow selection of address data in a group rather than individually
 S IBBUFFLD=0 F  S IBBUFFLD=$O(IBFLDS(IBBUFFLD)) Q:'IBBUFFLD  I $D(IBADDS(IBBUFFLD)) D
 . I '$$ESGHPFLD(ESGHP,IBBUFFLD) Q
 . ;
 . S IBEXTFLD=IBFLDS(IBBUFFLD),IBLABEL=IBLBLS(IBBUFFLD)_":"
 . S IBFLDVAL=$$DISPLAY(IBBUFFLD,EXTFILE,IBEXTFLD,IBLABEL)
 . I $P(IBFLDVAL,U,1)=$P(IBFLDVAL,U,2) Q
 . I SKPBLANK,$P(IBFLDVAL,U,1)="" Q  ; Do not prompt for blanks, if skipping
 . S CHGCHK=1
 . S IBFLDLST=IBFLDLST_IBBUFFLD_U
 ;
 I IBFLDLST'="" S IBUSER=$$ACCEPTG Q:IBUSER<0  D
 . I +IBUSER F IBUSER=1:1 S IBBUFFLD=$P(IBFLDLST,U,IBUSER) Q:'IBBUFFLD  S ^TMP($J,"IB BUFFER SELECTED",IBBUFFLD)=""
 ;
 ; Display message if there were no changs to accept
 I CHGCHK=0 W !!,"There are no changes to be accepted, based on the method of update chosen."
 I CHGCHK=1 W !!,"End of changes for "_$S(SET="INS":"INSURANCE",SET="GRP":"GROUP",(SET="POL"&'ESGHP):"POLICY",1:"EMPLOYEE SPONSORED GROUP HEALTH PLAN")_" related data."
 K DIR
 D PAUSE^VALM1
 ;
 Q
 ;
ESGHPFLD(ESGHP,IBBUFFLD) ; return true if field should be included, if ESGHP thEN include all 61.* fields, else exclude those fields
 N IBX,IBY S IBX=1 S ESGHP=$G(ESGHP)
 S IBY=0 I IBBUFFLD>61,IBBUFFLD<61.99 S IBY=1
 I +IBY,'ESGHP S IBX=0
 I 'IBY,ESGHP S IBX=0
 Q IBX
 ;
ACCEPT(BUFDATA,EXTDATA) ; ask user if they want to accept the change, returns true if yes
 N IBX S IBX=0
 I $G(BUFDATA)=$G(EXTDATA) Q
 I BUFDATA="" S DIR("A")="Accept Change, Delete",DIR("?")="The Buffer field is null, accepting the change will result in the Insurance Company data ("_EXTDATA_") being deleted"
 I BUFDATA'="" S DIR("A")="Accept Change, Replace",DIR("?")="Accepting the change will result Buffer data ("_BUFDATA_") replacing the Insurance Company data ("_EXTDATA_")"
 S DIR(0)="Y",DIR("B")="No" D ^DIR I Y=1 S IBX=1
 I $D(DIRUT)!$D(DTOUT) S IBX=-1
 W !
 Q IBX
 ;
 ;
ACCEPTG() ; ask user if they want to accept the entire address change, returns true if yes
 N IBX S IBX=0
 S DIR("A")="Accept Address Change",DIR("?")="Accepting the change will result in the entire Buffer Address replacing the Insurance Company Address"
 S DIR(0)="Y",DIR("B")="No" D ^DIR I Y=1 S IBX=1
 I $D(DIRUT)!$D(DTOUT) S IBX=-1
 W !
 Q IBX
 ;
DISPLAY(BFLD,IFILE,IFLD,LABEL) ; extract, compare, write the two corresponding fields; one from buffer, one from ins files
 N BUFDATA,EXTDATA,IBOVER,IBMERG,IBATTR,IBDATA S EXTDATA=""
 S BUFDATA=$$GET1^DIQ(355.33,IBBUFDA,BFLD)
 I +IBEXTDA S EXTDATA=$$GET1^DIQ(IFILE,IBEXTDA,IFLD)
 S IBDATA=BUFDATA_U_EXTDATA
 ;
 S (IBOVER,IBMERG,IBATTR)=""
 I BUFDATA'=EXTDATA S (IBOVER,IBMERG,IBATTR)="B"
 ; When skipping blanks, display skipped items without bold
 I SKPBLANK,BUFDATA="" S (IBOVER,IBMERG,IBATTR)=""
 ;
 D WRTLN(LABEL,BUFDATA,EXTDATA,IBOVER,IBMERG,IBATTR)
 Q IBDATA
 ;
WRTLN(LABEL,FLD1,FLD2,OVER,MERG,ATTR) ; write a line of formated data with label and two fields
 S ATTR=$G(ATTR),OVER=ATTR_$G(OVER),MERG=ATTR_$G(MERG)
 S LABEL=$J(LABEL,17)_"  ",FLD1=FLD1_$J("",29-$L(FLD1)),FLD2=FLD2_$J("",29-$L(FLD2))
 W !
 D WRTFLD(LABEL,0,19,ATTR),WRTFLD(FLD1,19,29,MERG)
 D WRTFLD(" | ",48,3,ATTR),WRTFLD(FLD2,51,29,OVER)
 Q
 ;
WRTFLD(STRING,COL,WD,ATTR) ; write an individual field with display attributes
 N ATTRB,ATTRE,DX,DY,X,Y
 S ATTRB="",ATTRB=$S(ATTR["B":$G(IOINHI),1:"")_$S(ATTR["U":$G(IOUON),1:"")
 S ATTRE="",ATTRE=$S(ATTR["B":$G(IOINORM),1:"")_$S(ATTR["U":$G(IOUOFF),1:"")
 ;
 S DX=COL,DY=$Y X IOXY
 W ATTRB,$E(STRING,1,WD),ATTRE
 S DX=(COL+WD),DY=$Y X IOXY
 Q
