PRSALIB ;WIRMFO-JAH    LIBRARY OF SCOPED FUNCTIONS AND PROCEDURES;
 ;;4.0;PAID;**11**;Sep 21, 1995
 Q
 ;must enter thru a function or procedure call
 ;
PERM(PPI,DFN) ;JAHeiges- check DAY multiple, temp tour field, 4 perm status
 ;return true if all are permanent false otherwise
 N DAY S RTN=1
 F DAY=1:1:14 I $P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",3)'=0 S RTN=0
 Q RTN
TMPST(TYPE) ;JAHeiges-Ask tour type. (Return TYP: 0=temp,1=perm)
 ; (function returns 0 if status question not answered, else true)
 W ! N DIR,DIRUT
 S DIR("A",1)="Is this tour PERMANANT."
 S DIR("A")="Should this tour automatically move to future pay periods"
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("?")="Answer YES to ensure permanent status for this person."
 S DIR("?",1)="A permanent status enables an automatic move into "
 S DIR("?",2)="future pay periods.  Answer NO for a temporary status."
 D ^DIR
 I $D(DIRUT) S TYPE="",RTN=0
 E  S TYPE='(Y),RTN=1
 Q RTN
UPDSTAT(PPI,DFN,STAT) ;JAHeiges
 ;function loops thru DAY multiple (temp tour field) and sets status
 N DAY S RTN=1
 F DAY=1:1:14 D
 . S $P(^PRST(458,PPI,"E",DFN,"D",DAY,0),"^",3)=STAT
 Q
UPDTQ() ;JAHeiges-Ask 2 update tour status /Return 0=no 1=yes/
 N RTN,DIR,DIRUT
 S DIR("A")="Update Tour Status"
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("?",1)="Answer YES to update status.  Answer NO keep current."
 S DIR("?",2)="I'll ask type of tour next, (temporary or permanent.)"
 S DIR("?")="Update tour status"
 D ^DIR
 I $D(DIRUT) S RTN=0
 E  S RTN=Y
 Q RTN
