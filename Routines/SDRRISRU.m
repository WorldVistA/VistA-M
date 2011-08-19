SDRRISRU ;10N20/MAH;Recall Reminder Utilities ;01/18/2008  11:32
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
OPENSLOT(SDRRIEN,SDRRST,SDRRND) ; Function returns the number of open (available)
 ; slots at the clinic during the time period.
 ; SDRRIEN - IEN of clinic in file #44
 ; SDRRST  - (optional) start checking on this date (default=today)
 ; SDRRND  - (optional) end of time period (default=last day of month)
 N SDRRNOAV,SDRRTOT,SDRRHOL,SDRRT,SDRRTPT,SDRRTPDT,SDRRDT,SDRRDA
 N SDRRFTR,CK,CLIN1,DA,DFN
 I '$D(SDRRST) S SDRRST=DT
 I '$D(SDRRND) D  ; end of month
 . S SDRRND=$E($$SCH^XLFDT("1M(L)",SDRRST),1,7)
 . S SDRRND=$$FMADD^XLFDT(SDRRND,1)
 . Q:$E(SDRRST,1,5)=$E(SDRRND,1,5)
 . S SDRRND=$$FMADD^XLFDT($E(SDRRND,1,5)_"01",-1)
 S SDRRST=$$FMADD^XLFDT(SDRRST,-1)
 S SDRRNOAV=0
 I '$O(^SC(SDRRIEN,"OST",SDRRST)),'$O(^SC(SDRRIEN,"ST",SDRRST,0)) D
 . N SDRRI,SDRRDOW
 . F SDRRI=0:1:6 S SDRRDOW=$O(^SC(SDRRIEN,"T"_SDRRI,SDRRST)) Q:SDRRDOW  S:SDRRDOW SDRRNOAV=1
 I SDRRNOAV Q 0  ; No future dates available
 I '$D(SDRRYEAR) N SDRRYEAR D YEAR
 S SDRRHOL=($P($G(^SC(SDRRIEN,"SL")),U,8)="Y")
 S SDRRTOT=0,SDRRDT=SDRRST
 F  S SDRRDT=$O(SDRRYEAR(SDRRDT)) Q:SDRRDT>SDRRND!'SDRRDT  D
 . I 'SDRRHOL,$P(SDRRYEAR(SDRRDT),U,2) Q
 . S SDRRTPDT=$G(^SC(SDRRIEN,"ST",SDRRDT,1)) ; Pattern
 . I SDRRTPDT="" D  Q:SDRRTPDT=""
 . . S SDRRT="T"_+SDRRYEAR(SDRRDT)
 . . S SDRRTPT=$O(^SC(SDRRIEN,SDRRT,SDRRDT)) Q:SDRRTPT=""
 . . S SDRRTPDT=$G(^SC(SDRRIEN,SDRRT,SDRRTPT,1))
 . S SDRRTOT=SDRRTOT+$$AVAIL(SDRRTPDT)
 Q SDRRTOT
AVAIL(SDRRPAT) ; Given pattern, returns number of available slots.
 ; Check the pattern for available slots
 ; 0-9 and j-z = available slots where j=10, k=11...z=26
 ; $A(1)=49 $A(9)=57 $A("j")=106 $A("z")=122
 N SDRRCNT,SDRRCHAR,I
 S SDRRCNT=0
 S SDRRPAT=$TR($E(SDRRPAT,6,$L(SDRRPAT)),"|[] ","")
 F I=1:1:$L(SDRRPAT) S SDRRCHAR=$A(SDRRPAT,I) D
 . I SDRRCHAR>48,SDRRCHAR<58 S SDRRCNT=SDRRCNT+$C(SDRRCHAR) Q
 . I SDRRCHAR>105,SDRRCHAR<123 S SDRRCNT=SDRRCNT+SDRRCHAR-96
 Q SDRRCNT
YEAR ; Set-up 1 year dates
 ; This array is used for available appointments
 N SDRRI,SDRRDT
 S SDRRDT=SDRRST
 F SDRRI=1:1:365 D  Q:SDRRDT=SDRRND
 . S SDRRDT=$$FMADD^XLFDT(SDRRDT,1)
 . S SDRRYEAR(SDRRDT)=$$DOW^XLFDT(SDRRDT,1)
 . I $D(^HOLIDAY(SDRRDT)) S $P(SDRRYEAR(SDRRDT),U,2)=1
 Q
DELETE ; This entry point is invoked by the new style xref A66201 on the .01 field of file 403.5
 I $D(SDRRDA),$D(APPT),$D(CLIN1) D  Q
 .D DELAPPT(SDRRDA,APPT,CLIN1)
 D DELUSER(DA)
 Q
DELAPPT(SDRRIEN,APPT,CLIN1) ; Record deleted from Recall List because of appointment.
 N SDRRFDA
 S SDRRFDA(403.56,"+1,",101)=APPT ; appt date
 S SDRRFDA(403.56,"+1,",102)=CLIN1 ; appt clinic
 D DELSET(SDRRIEN,.SDRRFDA)
 Q
DELUSER(SDRRIEN) ; Record deleted by a user.
 N SDRRFDA
 S SDRRFDA(403.56,"+1,",201)=$E($$NOW^XLFDT(),1,12) ; delete date
 S SDRRFDA(403.56,"+1,",202)=DUZ ; delete clerk
 S:$G(SDRRFTR) SDRRFDA(403.56,"+1,",203)=SDRRFTR ; delete reason: 
 D DELSET(SDRRIEN,.SDRRFDA)
 Q
DELSET(SDRRIEN,SDRRFDA) ;
 N SDRRREC
 S SDRRREC=$G(^SD(403.5,SDRRIEN,0))
 S SDRRFDA(403.56,"+1,",.01)=$P(SDRRREC,U,1) ; patient
 S SDRRFDA(403.56,"+1,",2)=$P(SDRRREC,U,3)   ; accession #
 S SDRRFDA(403.56,"+1,",2.5)=$P(SDRRREC,U,7) ; comment
 S SDRRFDA(403.56,"+1,",2.6)=$P(SDRRREC,U,8) ; fast / non-fast
 S SDRRFDA(403.56,"+1,",3)=$P(SDRRREC,U,4)   ; test/app.
 S SDRRFDA(403.56,"+1,",4)=$P(SDRRREC,U,5)   ; provider
 S SDRRFDA(403.56,"+1,",4.5)=$P(SDRRREC,U,2) ; clinic
 S SDRRFDA(403.56,"+1,",4.7)=$P(SDRRREC,U,9) ; length of appt.
 S SDRRFDA(403.56,"+1,",5)=$P(SDRRREC,U,6)   ; recall date
 S SDRRFDA(403.56,"+1,",6)=$P(SDRRREC,U,10)  ; date reminder sent
 S SDRRFDA(403.56,"+1,",7)=$P(SDRRREC,U,11)  ; user who entered recall
 D UPDATE^DIE("","SDRRFDA")
 Q
