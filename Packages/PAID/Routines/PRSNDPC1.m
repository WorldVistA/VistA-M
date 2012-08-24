PRSNDPC1 ;WOIFO/DAM - Delete POC Records;10/28/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
DELPOC ; called from option Delete Nurse POC Daily Time Record
 N GROUP,PRSIEN,VALUE,CANDEL
 D ACCESS^PRSNUT02(.GROUP,"E",DT,0)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" W !!,?4,$P(GROUP(0),U,3) S X=$$ASK^PRSLIB00(1) Q
 S VALUE=+GROUP($O(GROUP(0)))
 Q:VALUE'>0
 ;
 ; Select Nurse
 ;
 S PRSIEN=+$$PICKNURS^PRSNUT03($P(GROUP(0),U,2),VALUE)
 ;
 ; Allow user to select a date and reprompt if record is not valid
 ; for deletion
 ;
 N %DT,Y,X,OUT
 S (CANDEL,OUT)=0
 S %DT="A"
 F  D  Q:CANDEL!OUT
 .  D ^%DT
 .  I $G(X)[U!($G(X)="")!(Y'>0) S OUT=1 Q
 .  S PRSDT=Y
 .  S PRSDTDAT=$G(^PRST(458,"AD",PRSDT))
 .  S PPI=$P(PRSDTDAT,U),PRSD=$P(PRSDTDAT,U,2)
 .  I (PRSD'>0)!(PPI'>0) W " ?? ",$C(7),"ETA Timecard record does not exist for that date." Q
 .  S PRSNVER=$O(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,"V",999),-1)
 .  S CANDEL=$$CANDEL(PRSIEN,PRSDT,PRSD,PPI,PRSNVER)
 .  I 'CANDEL W " ?? ",$C(7),$P(CANDEL,U,2)
 Q:OUT!('CANDEL)
 ;
 D POCDSPLY^PRSNRUT0(PRSIEN,PRSDT,PRSDT)
 ;
 ; Confirm that the user does want to Delete the record
 ;
 N DIR,X,Y,DIRUT
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A")="Are you sure you want to Delete this record"
 S DIR("?")="Accept the default YES or enter NO"
 D ^DIR
 Q:$D(DIRUT)!'$G(Y)
 ;
 ; Lookup Record
 ;
 ; Confirm deletion or status message that record can't be deleted
 ; Display Record on that date?
 ;
 ;
 I $$EDVDEL(PRSIEN,PRSD,PPI,PRSNVER) D
 .   W !,"POC record successfully deleted."
 E  D
 .   W !,"Could not delete POC record."
 ;
 Q
EDVDEL(PRSIEN,PRSD,PPI,PRSNVER) ;  DELETE RECORD FUNCTION
 ; RETURNS 1 IF RECORD IS DELETED OTHERWISE 0
 ;
 N PRSNA,X,RETURN
 S RETURN=0
 Q:'PRSNVER RETURN
 I PRSNVER>1 D
 .  S PRSNA="451;;"_PPI_"~451.09;;"_PRSIEN_"~451.99;;"_PRSD_"~451.999;^PRSN(451,PPI,""E"",PRSIEN,""D"",PRSD,""V"",;"_PRSNVER
 .;  if version is 2 set daily record status back to null (no correction)
 .;  if greater than 2 set status back to released.
 . I PRSNVER=2 D UPDTPOCD^PRSNCGP(PPI,PRSIEN,PRSD,"","")
 . I PRSNVER>2 D UPDTPOCD^PRSNCGP(PPI,PRSIEN,PRSD,"","R")
 .;
 E  D
 .  S PRSNA="451;;"_PPI_"~451.09;;"_PRSIEN_"~451.99;^PRSN(451,PPI,""E"",PRSIEN,""D"",;"_PRSD
 ;
 K X D DELETE^PRSU1B1(.X,PRSNA)
 I X S RETURN=1
 QUIT RETURN
 ;
CANDEL(PRSIEN,PRSDT,PRSD,PPI,VERSION) ; Return true if the record on the specified date
 ; is allowed to be deleted, otherwise return an error message.
 ;
 N CANDEL,PRSDTDAT,PDAYSTAT,PPSTAT
 S CANDEL=0
 ;
 ;  check for a valid date
 ;
 I (PRSD'>0)!(PPI'>0) S CANDEL="0^Timecard record does not exist for that date." Q CANDEL
 ;
 ;  check does record exist
 ;
 I '+$G(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)) D  Q CANDEL
 .  S CANDEL="0^POC record does not exist for that date."
 ;
 ;  if pay period status is only entered (E) then this record
 ;  hasn't been anywhere and they can delete it.
 ;
 S PPSTAT=$P($G(^PRSN(451,PPI,"E",PRSIEN,0)),U,2)
 Q:PPSTAT="E" 1
 ;
 I PPSTAT="A" D  Q CANDEL
 .  S CANDEL="0^POC record status is Approved and never Released. To delete record, VANOD site coordinator must first return record for editing."
 ;
 ; If the pay period is already release we need to check the status
 ; of individual days to determine if DEP can delete, but we can never
 ; delete version 1 of a release POC
 ;
 I VERSION=1 D  Q CANDEL
 .  S CANDEL="0^The POC record status is Released.  Can't delete."
 ;
 S PDAYSTAT=$P($G(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)),U,2)
 ;
 I PDAYSTAT="" D  Q CANDEL
 . S CANDEL="0^The POC record status is Released.  Can't delete."
 ;
 I PDAYSTAT="E" D
 .  S CANDEL=1
 E  D
 .  S CANDEL="0"_U_"POC record status is "_$S(PDAYSTAT="A":"Approved",1:"Released")_". Can't delete."
 Q CANDEL
 ;
