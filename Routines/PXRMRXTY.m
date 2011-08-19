PXRMRXTY ; SLC/PKR - Routines for RXTYPE. ;01/04/2005
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;===============================================
RXTYXHLP ;Rxtype executable help.
 N DONE,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . W !,TEXT
 Q
 ;
 ;===============================================
SRXTYL(FIND0,RXTYL) ;Set the Rxtype list.
 N IND,NTYPE,RXTY,RXTYPE
 K RXTYL
 S RXTYPE=$P(FIND0,U,13)
 I RXTYPE="" S (RXTYL("I"),RXTYL("N"),RXTYL("O"))="" Q
 S NTYPE=$L(RXTYPE,",")
 F IND=1:1:NTYPE D
 . S RXTY=$P(RXTYPE,",",IND),RXTYL(RXTY)=""
 I $D(RXTYL("A")) S (RXTYL("I"),RXTYL("N"),RXTYL("O"))="" K RXTYL("A")
 Q
 ;
 ;===============================================
TEXT ;RxType executable help text.
 ;;RXTYPE controls the search for medications. The possible RXTYPEs are:
 ;; A - all
 ;; I - inpatient
 ;; N - non-VA meds
 ;; O - outpatient
 ;;
 ;;You may use any combination of the above in a comma separated list.
 ;;For example I,N would search for inpatient medications and non-VA meds.
 ;;
 ;;The default is to search for all possible types of medications. So a blank
 ;;RXTYPE is equivalent to A.
 ;;
 ;;**End Text**
 Q
 ;
 ;===============================================
VRXTYPE(X) ;Rxtype input transform. Check for valid Rxtypes.
 N IND,NTYPE,RXTY,RXTYL,TEXT,VALID
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 S VALID=1
 S NTYPE=$L(X,",")
 F IND=1:1:NTYPE D
 . S RXTY=$P(X,",",IND),RXTYL(RXTY)=""
 .;Check for valid source abbreviations.
 . I RXTY="A" Q
 . I RXTY="I" Q
 . I RXTY="N" Q
 . I RXTY="O" Q
 . S VALID=0
 . S TEXT=RXTY_" is not a valid RXTYPE"
 . D EN^DDIOL(TEXT)
 Q VALID
 ;
