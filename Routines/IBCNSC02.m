IBCNSC02 ;ALB/ESG - Insurance Company parent/child management ;01-NOV-2005
 ;;2.0;INTEGRATED BILLING;**320,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
DISP ; entry point for display of parent/child companies
 NEW PCFLG,PARENT,PCDESC,TITLE,START,IBLINE,OFFSET,INSDATA,CNT,TXT
 S PCFLG=$P($G(^DIC(36,+IBCNS,3)),U,13),PARENT=""
 I PCFLG="C" S PARENT=$P($G(^DIC(36,+IBCNS,3)),U,14),PCDESC="Child"
 I PCFLG="P" S PCDESC="Parent"
 S TITLE=" Associated Insurance Companies "
 S (START,IBLINE)=62
 S OFFSET=(40-($L(TITLE)/2))\1+1
 D SET^IBCNSP(START,OFFSET,TITLE,IORVON,IORVOFF)
 ;
 ; no link - display this and get out
 I PCFLG="" D  G DISPX
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,3,"This insurance company is not defined as either a Parent or a Child.")
 . Q
 ;
 ; display for either parent or child
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,3,"This insurance company is defined as a "_PCDESC_" Insurance Company.")
 ;
 ; child display
 I PCFLG="C" D  G DISPX
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,3,"It is associated with the following Parent Insurance Company:")
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,2," ")    ; blank line
 . S INSDATA=""
 . I 'PARENT S INSDATA="*** Parent Insurance Company not defined ***"
 . I PARENT D
 .. N AD S AD=$$INSADD(PARENT)   ; get parent ins co data
 .. S INSDATA=$P(AD,U,1)_"  "_$P(AD,U,2)_"  "_$P(AD,U,6)
 .. Q
 . S IBLINE=IBLINE+1
 . D SET^IBCNSP(IBLINE,8,INSDATA)
 . Q
 ;
 ; parent display
 S CNT=$$PCNT(IBCNS)    ; count # of children
 S TXT="There are "_CNT_" Child Insurance Companies"
 I CNT=1 S TXT="There is 1 Child Insurance Company"
 S TXT=TXT_" associated with it."
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,3,TXT)
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,3,"Select the ""AC  Associate Companies"" action to enter/edit the children.")
 ;
DISPX ; end with 2 blank lines
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2," ")    ; blank line
 S IBLINE=IBLINE+1
 D SET^IBCNSP(IBLINE,2," ")    ; blank line
 Q
 ;
PARENT(IBCNS) ; Insurance company parent/child management
 ; Calls ListMan screen for parent insurance companies
 NEW PCFLG
 I '$G(IBCNS) G PARENTX
 S PCFLG=$P($G(^DIC(36,IBCNS,3)),U,13)
 ;
 ; special check to remove 3.13 field if 3.14 field is nil
 I PCFLG="C",'$P($G(^DIC(36,IBCNS,3)),U,14) D
 . N DIE,DA,DR S DIE=36,DA=IBCNS,DR="3.13////@" D ^DIE
 . Q
 ;
 ; get out if not a parent insurance company
 I PCFLG'="P" G PARENTX
 ;
 ; call ListMan for parent/children management
 D EN^VALM("IBCNS ASSOCIATIONS LIST")
 KILL ^TMP($J,"IBCNSL")
PARENTX ;
 Q
 ;
HDR ; List header info
 S VALMHDR(1)="Parent Insurance Company:"
 S VALMHDR(2)="     "_$$INSCO(IBCNS)
 S VALMHDR(3)=""
HDRX ;
 Q
 ;
BLD ; Build list contents
 NEW C,INSDATA,INSNAME,STCITY,ENTRY,NM,ST,IEN,X
 KILL ^TMP($J,"IBCNSL")
 S C=0
 F  S C=$O(^DIC(36,"APC",IBCNS,C)) Q:'C  D
 . S INSDATA=$$INSADD(C)
 . S INSNAME=$P(INSDATA,U,1)
 . I INSNAME="" S INSNAME="~UNKNOWN"
 . S STCITY=$P(INSDATA,U,7)
 . I STCITY="" S STCITY="~UNKNOWN"
 . S ^TMP($J,"IBCNSL",1,INSNAME,STCITY,C)=""
 . Q
 ;
 I '$D(^TMP($J,"IBCNSL",1)) D  G BLDX
 . ; no children insurance companies found
 . S ^TMP($J,"IBCNSL",2,1,0)=""
 . S ^TMP($J,"IBCNSL",2,2,0)="     No Children Insurance Companies Found"
 . S VALMCNT=2
 . Q
 ;
 S VALMCNT=0,ENTRY=0
 S NM=""
 F  S NM=$O(^TMP($J,"IBCNSL",1,NM)) Q:NM=""  D
 . S ST=""
 . F  S ST=$O(^TMP($J,"IBCNSL",1,NM,ST)) Q:ST=""  D
 .. S IEN=0
 .. F  S IEN=$O(^TMP($J,"IBCNSL",1,NM,ST,IEN)) Q:'IEN  D
 ... S VALMCNT=VALMCNT+1,ENTRY=ENTRY+1
 ... S X=$$FO^IBCNEUT1($J(ENTRY,3),5)_$$INSCO(IEN)
 ... S ^TMP($J,"IBCNSL",2,VALMCNT,0)=X
 ... S ^TMP($J,"IBCNSL",2,"IDX",VALMCNT,ENTRY)=""
 ... S ^TMP($J,"IBCNSL",3,ENTRY)=IEN_U_VALMCNT
 ... Q
 .. Q
 . Q
BLDX ;
 Q
 ;
LINK ; action protocol IBCNSL LINK used to associate children insurance
 ; companies to the current parent ins co for the list
 NEW DIC,X,Y,DIE,DR,DA,NEWINS,IBSTOP,PAR,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 D FULL^VALM1
 I '$$KCHK^XUSRB("IB EDI INSURANCE EDIT") D  G LINKX
 . W !!?5,"You must hold the IB EDI INSURANCE EDIT key to access this option."
 . D PAUSE^VALM1
 . Q
 ;
 ; lookup ins company
 W !
 S DIC=36,DIC(0)="AEMQ",DIC("A")="Select Insurance Company: "
 S DIC("W")="D INSLIST^IBCNSC02(Y)"
 ; screen - ins co Y is not a parent and also it is not already in the list of children
 S DIC("S")="I $P($G(^DIC(36,Y,3)),U,13)'=""P""&'$D(^DIC(36,""APC"",IBCNS,Y))"
 D ^DIC K DIC
 I +Y'>0 G LINKX
 S NEWINS=+Y
 ;
 ; check to see if this selected insurance company is already a child
 ; for some other parent
 S PAR=+$P($G(^DIC(36,NEWINS,3)),U,14),IBSTOP=0
 I PAR,PAR'=IBCNS D
 . W !
 . S DIR(0)="YO",DIR("B")="No"
 . S DIR("A",1)="Please Note:  The insurance company you selected is currently identified"
 . S DIR("A",2)="as a Child insurance company associated with the following Parent:"
 . S DIR("A",3)=""
 . S DIR("A",4)="     "_$$INSCO(PAR)
 . S DIR("A",5)=""
 . S DIR("A")="OK to proceed and make this switch"
 . D ^DIR K DIR
 . I Y'=1 S IBSTOP=1 Q
 . Q
 I IBSTOP G LINKX
 ;
 ; lock the potential new child ins company
 L +^DIC(36,NEWINS):0 I '$T D LOCKED^IBTRCD1 G LINKX
 ;
 ; update selected child
 S DIE=36,DA=NEWINS,DR="3.13////C;3.14////"_IBCNS D ^DIE
 ;
 ; Copy the IDs from the parent
 D COPY^IBCEPCID(NEWINS)
 ;
 ; unlock
 L -^DIC(36,NEWINS)
 ;
 D BLD   ; rebuild list of children
LINKX ;
 S VALMBCK="R"
 Q
 ;
UNLINK ; action protocol IBCNSL UNLINK used to disassociate selected children
 ; insurance companies from the list.
 NEW DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT,IBLST,IBSUB,IBPCE,IBSEL,DA,DIE,DR
 D FULL^VALM1
 I '$$KCHK^XUSRB("IB EDI INSURANCE EDIT") D  G UNLINKX
 . W !!?5,"You must hold the IB EDI INSURANCE EDIT key to access this option."
 . D PAUSE^VALM1
 . Q
 ;
 I '$D(^TMP($J,"IBCNSL",3)) D  G UNLINKX
 . W !!?5,"There are no insurance companies to select." D PAUSE^VALM1
 . Q
 S DIR(0)="LO^1:"_+$O(^TMP($J,"IBCNSL",3,""),-1)
 S DIR("A")="Select Insurance Company(s)"
 W ! D ^DIR K DIR
 I $D(DIRUT) G UNLINKX
 M IBLST=Y
 ;
 W !
 S DIR(0)="YO"
 S DIR("A")="OK to proceed",DIR("B")="No"
 D ^DIR K DIR
 I Y'=1 G UNLINKX
 ;
 F IBSUB=0:1 Q:'$D(IBLST(IBSUB))  F IBPCE=1:1 S IBSEL=$P(IBLST(IBSUB),",",IBPCE) Q:'IBSEL  D
 . S DA=+$G(^TMP($J,"IBCNSL",3,IBSEL)) I 'DA Q
 . S DIE=36,DR="3.13////@;3.14////@" D ^DIE
 . Q
 ;
 D BLD   ; rebuild list of children
UNLINKX ;
 S VALMBCK="R"
 Q
 ;
PCNT(Z) ; count number of children for parent ins co Z
 NEW C,CNT
 S C=0,Z=+$G(Z)
 F CNT=0:1 S C=$O(^DIC(36,"APC",Z,C)) Q:'C
 Q CNT
 ;
INSADD(Z) ; function to return ins co address components
 NEW INSDATA,AD,NM,L1,CITY,ST,ZIP,CITYST,STCITY
 S INSDATA=""
 S AD=$G(^DIC(36,+$G(Z),.11))
 S NM=$P($G(^DIC(36,Z,0)),U,1)
 S L1=$P(AD,U,1),CITY=$P(AD,U,4),ST=$P(AD,U,5),ZIP=$P(AD,U,6)
 I ST S ST=$P($G(^DIC(5,ST,0)),U,2)
 S CITYST=$E(CITY,1,15)_" "_ST
 I CITY'="",ST'="" S CITYST=$E(CITY,1,15)_","_ST
 ;
 S $P(STCITY,"|",1)=ST
 I ST="" S $P(STCITY,"|",1)="~~"
 S $P(STCITY,"|",2)=CITY
 I CITY="" S $P(STCITY,"|",2)="~~~~"
 ;
 S INSDATA=NM_U_L1_U_CITY_U_ST_U_ZIP_U_CITYST_U_STCITY
 ;         1    2    3      4    5     6        7
INSADDX ;
 Q INSDATA
 ;
INSCO(Z) ; return display data for ins co Z
 NEW X,Y
 S Y=$$INSADD(Z)
 S X=$$FO^IBCNEUT1($P(Y,U,1),27)
 S X=X_$$FO^IBCNEUT1($P(Y,U,2),26)
 S X=X_$$FO^IBCNEUT1($P(Y,U,6),18)
INSCOX ;
 Q X
 ;
INSLIST(INS) ; insurance company lister for ^DIC call
 NEW Z
 S Z=$$INSADD(INS)
 W ?27,$E($P(Z,U,2),1,20)   ; address line 1
 W ?47,"  ",$P(Z,U,6)       ; city, state
INSLISTX ;
 Q
 ;
