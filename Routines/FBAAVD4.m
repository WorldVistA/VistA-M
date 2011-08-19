FBAAVD4 ;AISC/CLT, Special routine for entering/inactivating/deleting NPI in file 161.2; ; 19 Sep 2006  12:31 PM
 ;;3.5;FEE BASIS;**98**;30-JAN-95;Build 54
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine will ask for the NPI, check for proper format, check for duplicate entries
 ;check for proper format using the double-add-double formula.  If the NPI is being
 ;deleted it will check if it is being deleted because of a valid NPI being removed for some
 ;other reason.  If it is being deleted because of an erroneous entry it will be completely deleted.
 ; If it is a valid NPI being deleted because of a possible inappropriate usage it will be maintained
 ; in the history cross reference to preclude anyone from using this NPI again.
 ;
EN ;Routine primary entry point
 ;
 N DIR,DUOUT,DTOUT,FBIEN,FBRTN,FBNPI,X,Y,FBCHECK,FBOLDNPI,FBRBNPI,DIE,DIC,DR
 S FBIEN=DA,FBRTN=""
 I $G(DA) S:$P($G(^FBAAV(DA,3)),U,2)'="" (DIR("B"),FBOLDNPI)=$P($G(^FBAAV(DA,3)),U,2)
EN1 S DIR(0)="FO^10:10",DIR("A")="BILLING PROVIDER NPI",DIR("?")="Enter a 10 digit National Provider Identifier" S:'$G(DTIME) DIR("T")=600 S FBCHECK=0
 D ^DIR G:$G(DUOUT)!$G(DTOUT) XIT G:X="@" DEL I X=""!(X=$P($G(^FBAAV(FBIEN,3)),U,2)) G XIT
 I Y="" S:$G(FBOLDNPI) FBNPI=FBOLDNPI G XIT
 S FBNPI=Y I '$$CHKDGT^XUSNPI(FBNPI) D BADCHK  G EN1
 I $$DUP^FBNPILK(FBNPI)'=""&(FBRTN'=DA) K DIR("A") G EN1
 I $G(FBOLDNPI)'="" I FBNPI'=FBOLDNPI D INACT
 D:FBNPI'="" ACTIVATE
 G XIT
 ;
BADCHK ;BACK CHECK DIGIT ON THE NPI
 W !,*7,"Not a valid NPI.  Please try again."
 Q
 ;
ACTIVATE ;CREATE AN ACTIVATED ENTRY IN MULTIPLE NPI FIELD
 Q:$G(FBNPI)=""
 S DA(1)=FBIEN,DIC="^FBAAV("_DA(1)_",""NPI"",",DIC(0)="L",X=$$NOW^XLFDT() H 1
 S DIC("DR")=".02////^S X=1;.03////^S X=FBNPI;.04////^S X=DUZ"
 D ^DIC
 S $P(^FBAAV(FBIEN,3),U,2)=FBNPI,^FBAAV("NPI",FBNPI,FBIEN)="",^FBAAV("NPIHISTORY",FBNPI,FBIEN)=""
 Q
 ;
DEL ;NPI HAS BEEN DELETED
 ;If the user deletes the NPI this subroutine will determine why it was deleted and if it was because it was found
 ;in a false identity situation will not allow it to be deleted, but removed to history to never be used again.
 I $P($G(^FBAAV(DA,3)),U,2)="" W " ??",$C(7) Q
 S FBNPI=DIR("B") K DIR S DIR(0)="Y",DIR("A")="Are you sure you wish to delete this NPI",DIR("?")="You have indicated you wish to delete the NPI.  This is a second chance check."
 D ^DIR
 G:$G(Y)=0 XIT
 S DIR(0)="S^E:ERROR;V:VALID",DIR("A")="Was this a Valid NPI or an NPI entered in Error",DIR("?",1)="An example of an NPI entered in error is if the entry person transposes numbers,"
 S DIR("?",2)="or the NPI for one provider is accidentally assigned to a different provider."
 S DIR("?")="Enter a 'E' for Error or a 'V' for Valid."
 D ^DIR
 D:$G(Y)="E" COMP I $G(Y)="V" S FBCHECK=3 D INACT
 Q
 ;
COMP ;COMPLETELY DELETE THE NPI
 ;This subroutine will delete the NPI from the NPI and NPIHISTORY cross references.  It make an entry in the 
 ;NPI multiple field within a vendor record to indicate that the NPI has been deleted.
 K ^FBAAV("NPI",FBNPI,DA),^FBAAV("NPIHISTORY",FBNPI,DA)
 S DA(1)=FBIEN,DIC="^FBAAV("_DA(1)_",""NPI"",",DIC(0)="L",X=$$NOW^XLFDT()
 S FBRB=0
 D  ; Find the most recent status '0' (inactive) NPI entry in the list that was not later made status '2' (deleted).
 . N FBRBLST,FBRBTMP
 . ; Don't want to roll back to the same number you are deleting.
 . S FBRBLST(FBNPI)=""
 . S FBRBTMP=$P(^FBAAV(FBIEN,"NPI",0),U,3)
 . ; Go through each entry in reverse order
 . F  S FBRBTMP=$O(^FBAAV(FBIEN,"NPI",FBRBTMP),-1) Q:'FBRBTMP  D  Q:FBRB'=0
 .. S FBRBLST=^FBAAV(FBIEN,"NPI",FBRBTMP,0)
 .. ; If this is an 'active' entry then ignore it.
 .. I $P(FBRBLST,U,2)=1 Q
 .. ; If this is a 'deleted' entry then store the NPI for later comparison to any 'inactive' entries found.
 .. I $P(FBRBLST,U,2)=2 S FBRBLST($P(FBRBLST,U,3))="" Q
 .. ; If this is an 'inactive' entry and there is no 'deleted' entry then report it.
 .. I $P(FBRBLST,U,2)=0,'$D(FBRBLST($P(FBRBLST,U,3))) S FBRB=FBRBTMP Q
 .. Q
 . Q
 S DIC("DR")=".02////^S X=2;.03////^S X=FBOLDNPI;.04////^S X=DUZ"
 D ^DIC S ^FBAAV(DA,3)="^"
 W !,"This NPI has been deleted.",!
 I FBRB>0 D ROLLBACK
 Q
 ;
INACT ;INACTIVATE AN ENTRY
 ;This subroutine makes two entries in the NPI multiple field.  One for the activation of a new NPI and the second
 ;is the deactivation of the old NPI.
 S DA(1)=FBIEN,DIC="^FBAAV("_DA(1)_",""NPI"",",DIC(0)="L",X=$$NOW^XLFDT()
 S DIC("DR")=".02////^S X=$S(FBCHECK=2:2,FBCHECK=3:0,1:0);.03////^S X=FBOLDNPI;.04////^S X=DUZ"
 D ^DIC
 S ^FBAAV("NPIHISTORY",FBOLDNPI,DA(1))="" K ^FBAAV("NPI",FBOLDNPI,DA(1))
 S $P(^FBAAV(FBIEN,3),U,2)=""
 I FBCHECK=0 D ACTIVATE
 S ^FBAAV("NPIHISTORY",FBNPI,DA(1))=""
 Q
 ;
ROLLBACK ;ROLL BACK TO THE PREVIOUS NPI AFTER AN NPI IS DELETED
 S (FBNPI,FBRBNPI)=$P(^FBAAV(FBIEN,"NPI",FBRB,0),U,3)
 S $P(^FBAAV(DA(1),3),U,2)=FBRBNPI,^FBAAV("NPI",FBRBNPI,DA(1))=""
 H 1 D ACTIVATE
 Q
 ;
XIT ;CLEAN AND EXIT
 K FBRTN,FBRB,FBNPI,FBBT
 Q
