PRSNCR1 ;WOIFO/DAM - Return Approved POC Record;10/28/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
RETPOC ; called from option Return Approved Nurse POC Daily Time Record
 N GROUP,PRSIEN,VALUE,CANRET
 D PIKGROUP^PRSNUT04(.GROUP,"",0)
 ; quit if any error during group selection
 I $P($G(GROUP(0)),U,2)="E" W !!,?4,$P(GROUP(0),U,3) S X=$$ASK^PRSLIB00(1) Q
 S VALUE=+GROUP($O(GROUP(0)))
 Q:VALUE'>0
 ;
 ; Select Nurse
 ;
 S PRSIEN=+$$PICKNURS^PRSNUT03($P(GROUP(0),U,2),VALUE)
 Q:+PRSIEN'>0
 ;
 ; Allow user to select a date and reprompt if record is not valid
 ; for return
 ;
 N %DT,Y,X,OUT
 S (CANRET,OUT)=0
 S %DT="A"
 F  D  Q:CANRET!OUT
 .  D ^%DT
 .  I $G(X)[U!($G(X)="")!(Y'>0) S OUT=1 Q
 .  S PRSDT=Y
 .  S PRSDTDAT=$G(^PRST(458,"AD",PRSDT))
 .  S PPI=$P(PRSDTDAT,U),PRSD=$P(PRSDTDAT,U,2)
 .  I (PRSD'>0)!(PPI'>0) W " ?? ",$C(7),"ETA Timecard record does not exist for that date." Q
 .  S CANRET=$$CANRET(PRSIEN,PRSDT,PRSD,PPI)
 .  I 'CANRET W " ?? ",$C(7),$P(CANRET,U,3)
 Q:OUT!('CANRET)
 ;
 D POCDSPLY^PRSNRUT0(PRSIEN,PRSDT,PRSDT)
 ;
 ; Confirm that the user does want to return the record
 ;
 N DIR,X,Y,DIRUT
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A",1)="Are you sure you want to return this Nurse's"
 S DIR("A")=$S($P(CANRET,U,2)="R":"daily record",1:"entire pay period")_" for editing"
 S DIR("?")="Accept the default YES or enter NO"
 D ^DIR
 Q:$D(DIRUT)!'$G(Y)
 ;
 ; Lookup Record
 ;
 ; Confirm return or display a status message that record can't be returned.
 ; Display Record on that date?
 ;
 ;  if pp status is R then it must be a return of a daily correction
 ;  otherwise we return the whole pay period.
 ;
 I $P(CANRET,U,2)="R" D
 .  D UPDTPOCD^PRSNCGP(PPI,PRSIEN,PRSD,"","E")
 .  W !,"POC daily record successfully returned."
 E  D
 .  D UPDTPOC^PRSNCGR1(PPI,PRSIEN,"E",1)
 .  W !,"POC pay period successfully returned."
 ;
 Q
 ;
CANRET(PRSIEN,PRSDT,PRSD,PPI) ; Return true if the record on the specified date
 ; is allowed to be deleted, otherwise return an error message.
 ;
 N CANRET,PRSDTDAT,PDAYSTAT,PPSTAT
 S CANRET=0
 ;
 ;
 ;  check does record exist
 ;
 I '+$G(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)) D  Q CANRET
 .  S CANRET="0^^POC record does not exist for that date."
 ;
 ;  if pay period status is only (A)pproved then this pay 
 ;  pay period record has never been released and can be
 ;  returned
 ;
 S PPSTAT=$P($G(^PRSN(451,PPI,"E",PRSIEN,0)),U,2)
 I PPSTAT="A" S CANRET="1"_U_PPSTAT_U Q CANRET
 ;
 I PPSTAT="E" D  Q CANRET
 .  S CANRET="0"_U_PPSTAT_U_"POC record status is Entered.  It does not need to be returned.  It is currently available for editing."
 ;
 ; If pay period status is released we need to check the status
 ; of individual days to determine if Coordinator can return
 ;
 S PDAYSTAT=$P($G(^PRSN(451,PPI,"E",PRSIEN,"D",PRSD,0)),U,2)
 ;
 I PDAYSTAT="" D  Q CANRET
 . S CANRET="0"_U_PPSTAT_U_"Record does not need to be returned.  It is currently available for editing."
 ;
 ; status A can be returned, otherwise it's Entered or Released
 ; and can already be edited or deleted or approved.
 ;
 I PDAYSTAT="A" D
 .  S CANRET="1"_U_PPSTAT_U
 E  D
 .  S CANRET="0"_U_PPSTAT_U_"POC record status is "_$S(PDAYSTAT="E":"Entered",1:"Released")_". It is currently available for editing."
 ;
 ;
 Q CANRET
 ;
