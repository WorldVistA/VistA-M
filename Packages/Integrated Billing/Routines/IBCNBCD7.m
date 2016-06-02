IBCNBCD7 ;ALB/AWC - MCCF FY14 Subscriber Display Screens ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Input Parameters:
 ;  See routine IBCNBCD1
 ;
SUB(SKPBLANK,IBFNAM,IBHOLD,IBXHOLD) ; called from SUB^IBCNBAC
 S SKPBLANK=$G(SKPBLANK)
 ;
 W @IOF
 W ! D WRTFLD^IBCNBAC(" Subscriber Data:  Patient Registration            Patient Insurance Policy   ",0,80,"BU")
 ;
 I $G(IBFNAM)="DPT" S IBSET="DPT" D SBFLDS(IBSET,SKPBLANK,.IBHOLD,.IBXHOLD) Q
 I $G(IBFNAM)="DGPR" S IBSET="DGPR" D SBFLDS(IBSET,SKPBLANK,.IBHOLD,.IBXHOLD) Q
 I $G(IBFNAM)="" S IBSET="N" D SBFLDS(IBSET,SKPBLANK,.IBHOLD,.IBXHOLD) Q
 Q
 ;
SBFLDS(IBSET,SKPBLANK,IBHOLD,IBXHOLD) ; accept each field and set into temp array
 N IBX,IB1,IB2,IBSEL,IBDF,IBDRB,IBDRX,IBBUFVAL,IBEXTVAL,CHGCHK,IBFLDS,IBLBLS,IBADDS,IBLABEL,IBUSER
 S CHGCHK=0
 ;
 S IBSEL=$NA(^TMP($J,"IB BUFFER SELECTED"))
 K @IBSEL
 ;
 ; -- get corresponding fields from routine IBCNBCD6 to populate data
 D FIELDS^IBCNBCD6(IBSET_"FLD",.IBFLDS,.IBLBLS,.IBADDS)
 S IBDF=$P($T(@(IBSET_"DR")+1^IBCNBCD6),";;",2),IBDRB=$P(IBDF,U,2),IBDRX=$P(IBDF,U,3)
 ;
 ;
 F IBX=1:1:$L(IBDRB,";") I '$D(IBADDS(IBX)) D  Q:$G(IBUSER)<0
 . ;
 . S IB1=$P(IBDRB,";",IBX),IB2=$P(IBDRX,";",IBX)
 . ;
 . S IBBUFVAL=$G(@IBHOLD@(2,IB1)),IBEXTVAL=$G(@IBXHOLD@(2,IB2)),IBLABEL=$G(IBLBLS(IB1))_":"
 . ;
 . D SBDIS(IBBUFVAL,IBEXTVAL,IBLABEL,SKPBLANK)
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I SKPBLANK,IBBUFVAL="" Q
 . ;
 . S CHGCHK=1
 . S IBUSER=$$ACCEPT^IBCNBAC(IBBUFVAL,IBEXTVAL) Q:IBUSER<0
 . I +IBUSER S @IBSEL@(IB1)=""
 ;
 K DIR
 D DMSG(CHGCHK),PAUSE^VALM1
 Q
 ;
SBDIS(BFLD,IFLD,LABEL,SKPBLANK) ; write the two corresponding fields; one from buffer, one from ins files
 N IBOVER,IBMERG,IBATTR
 S (IBOVER,IBMERG,IBATTR)=""
 ;
 ; -- turn bold attributes on
 I BFLD'=IFLD S (IBOVER,IBMERG,IBATTR)="B"
 ;
 ; -- skipping blanks, display skipped items without bold
 I SKPBLANK,BFLD="" S (IBOVER,IBMERG,IBATTR)=""
 ;
 ; -- display a line of data to screen
 D WRTLN^IBCNBAC(LABEL,BFLD,IFLD,IBOVER,IBMERG,IBATTR)
 Q
 ;
DMSG(CHGCHK) ; Display message if there were no changes to accept
 I CHGCHK=0 W !!,"There are no changes to be accepted, based on the method of update chosen." Q
 I CHGCHK=1 W !!,"End of changes for SUBSCRIBER related data."
 Q
