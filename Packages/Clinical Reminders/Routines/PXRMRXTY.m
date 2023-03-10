PXRMRXTY ; SLC/PKR - Routines for RXTYPE. ;09/01/2021
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
 ;
 ;===============================================
HTEXT ;RxType executable help text.
 ;;RXTYPE controls the search for medications. The possible RXTYPEs are:
 ;; A - all
 ;; I - inpatient
 ;; N - non-VA meds
 ;; O - outpatient
 ;;
 ;;You may use any combination of the above in a comma separated or plain list.
 ;;For example, 'I,N' or 'IN' would search for inpatient medications and non-VA
 ;;meds.
 ;;
 ;;The default is to search for all possible types of medications. So a blank
 ;;RXTYPE is equivalent to 'A'. If the list contains 'A', it takes precedence,
 ;;and all RXTYPES will be searched for.
 ;;
 ;;**End Text**
 Q
 ;
 ;===============================================
RXTYXHLP ;Rxtype executable help.
 N DONE,IND,TEXT
 ;DX and DY should not be newed or killed, control by ScreenMan
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","RXTYPE Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;===============================================
SRXTYL(FIND0,RXTYL) ;Set the Rxtype list.
 N RXTYPE
 K RXTYL
 S RXTYPE=$P(FIND0,U,13)
 I (RXTYPE="")!(RXTYPE["A") S (RXTYL("I"),RXTYL("N"),RXTYL("O"))="" Q
 I RXTYPE["I" S RXTYL("I")=""
 I RXTYPE["N" S RXTYL("N")=""
 I RXTYPE["O" S RXTYL("O")=""
 Q
 ;
 ;===============================================
VRXTYPE(X) ;Rxtype input transform. Check for valid Rxtypes.
 N CHAR,IND,VALID
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 S VALID=1
 F IND=1:1:$L(X) D
 . S CHAR=$E(X,IND)
 . I CHAR="," Q
 . I CHAR="A" Q
 . I CHAR="I" Q
 . I CHAR="N" Q
 . I CHAR="O" Q
 . S VALID=0
 . D EN^DDIOL(CHAR_" is not a valid RXTYPE")
 Q VALID
 ;
 ;===============================================
VRXTYPEO(X) ;Rxtype input transform. Check for valid Rxtypes.
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
