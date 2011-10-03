TIUPRF ; SLC/JMH - API's for Patient Record Flags ; 7/29/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**184**;Jun 20, 1997
 ;
ISPRFDOC(TIUDA) ;Function (called by PIMS) returns 1 if docmt is PRF,
 ;otherwise 0
 N TIUTTL
 S TIUTTL=+$G(^TIU(8925,TIUDA,0))
 I 'TIUTTL Q 0
 Q $$ISPFTTL^TIUPRFL(TIUTTL)
 ;
GETTTL(TIUDA) ; API called by PIMS to retrieve the name of a
 ;TIU Document
 ; Input   TIUDA: The TIU DOCUMENT TITLE IEN
 ; Output TIUTTL: The TIU DOCUMENT TITLE Name
 N TIUTTL,TIUNODE
 S TIUNODE=$G(^TIU(8925.1,TIUDA,0))
 I $G(TIUNODE)="" Q -1
 S TIUTTL=$P(TIUNODE,U,1)
 I $G(TIUTTL)="" Q -2
 Q TIUTTL
CHKDOC(TIUDA) ; API called by PIMS to check the existence of a TIU
 ;   Document before linking, deleting,...
 ; Input   TIUDA: The TIU DOCUMENT IEN
 ; Output TIURET: Return value 
 ;              (0 if Document does not exist, 1 if it does exist)
 N TIURET
 S TIURET=$D(^TIU(8925,TIUDA,0))
 I +TIURET S TIURET=1
 I 'TIURET S TIURET=0
 Q TIURET
 ;
GETLIST(PRFCAT,TARGET) ; API called by PIMS to retrieve a list of active
 ;   Category I and/or Category II Progress Note Titles
 ; Input  PRFCAT: PRF Category Flag [1,2 or 3]
 ;    1:Category I
 ;    2:Category II
 ;    3:Both Category I and II
 ; Input  TARGET: The array name to place the list of 
 ;                  Titles and IENs
 ; Output TIURET: Return value to pass back any error
 ;                  codes if necessary
 ;                 @TARGET@(CATEGORY,D0)=TITLE IEN^TITLE NAME
 ;                If nothing to return in list, TIUCNT=0 and TARGET array is empty
 N TIUCAT1,TIUCAT2,TIURET,TIUCNT,TIUNODE1,TIUNODE2,TIUDA
 S TIUCNT=0
 K @TARGET
 I '$D(PRFCAT)!('$D(TARGET)) Q "-1^MISSING INPUT"
 I PRFCAT=3!(PRFCAT=1) D
 . S TIUNODE1=0
 . S TIUCAT1=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT I","DC")
 . F  S TIUNODE1=$O(^TIU(8925.1,TIUCAT1,10,TIUNODE1)) Q:'TIUNODE1  D
 . . S TIUDA=$P(^TIU(8925.1,TIUCAT1,10,TIUNODE1,0),U)
 . . I $P(^TIU(8925.1,TIUDA,0),U,7)=11!($P(^TIU(8925.1,TIUDA,0),U,7)=10) D
 . . . S TIUCNT=TIUCNT+1
 . . . S @TARGET@("CAT I",TIUCNT)=TIUDA_"^"_$$GETTTL(TIUDA)
 I PRFCAT=3!(PRFCAT=2) D
 . S TIUNODE2=0
 . S TIUCAT2=+$$DDEFIEN^TIUFLF7("PATIENT RECORD FLAG CAT II","DC")
 . F  S TIUNODE2=$O(^TIU(8925.1,TIUCAT2,10,TIUNODE2)) Q:'TIUNODE2  D
 . . S TIUDA=$P(^TIU(8925.1,TIUCAT2,10,TIUNODE2,0),U)
 . . I $P(^TIU(8925.1,TIUDA,0),U,7)=11!($P(^TIU(8925.1,TIUDA,0),U,7)=10) D
 . . . S TIUCNT=TIUCNT+1
 . . . S @TARGET@("CAT II",TIUCNT)=TIUDA_"^"_$$GETTTL(TIUDA)
 Q TIUCNT
