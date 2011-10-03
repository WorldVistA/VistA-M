TIUPXPM ;SLC OIFO/DKK,GSS - ADDITIONAL PERFORMANCE MONITORS ; 07/01/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**168**Jun 20, 1997
 ;External reference to File ^AUPNVPRV supported by DBIA 1541
 ;External reference to File ^AUPNVSIT supported by DBIA 1625 & DBIA 3580
 ;-----------------------------------
 ;Determines if note has been appropriately signed in a timely manner.
 ;Originally written as an API for use by PIMS
 ;
 ;Note
 ;Category  Type
 ;  A       No note for the Visit IEN
 ;  B       Acceptable Note ('signed')
 ;  C       Unacceptable Note ('unsigned')
 ;  D       Scanned Image
 ;  E       Purged, Deleted, or Retracted Note
 ;
 ;TIU Note Status                                    Possible
 ;Code      Description                              Category
 ;none      No corresponding Progress Note for VIEN     A
 ; 1        Undictated                                  C or D
 ; 2        Untranscribed                               C
 ; 3        Unreleased                                  -
 ; 4        Unverified                                  C or D
 ; 5        Unsigned                                    C
 ; 6        Uncosigned                                  C
 ; 7        Completed                                   B or C
 ; 8        Amended                                     B or C
 ; 9        Purged                                      E
 ;11        Active                                      C
 ;13        Inactive                                    C or D
 ;14        Deleted                                     E
 ;15        Retracted                                   E
 ;variable  Scanned Image                               D
 ;
 ;Primary variables Used:
 ;ARY()      = Array of all visit providers returned by GETPRV^PXAPIOE
 ;CSTATC     = ","_Document status_","
 ;DOCTYP()   = Array of all note types based on Progress Note Class
 ;SIG        = Pointer to File #200 of signer^FM Date.Time of signing
 ;SIGA       = Pointer to F#200 of Amended note signer^FM Date.Time
 ;SIGC       = Pointer to F#200 of note Co-Signer^FM Date.Time
 ;STAT       = Document status
 ;TIUIEN     = TIU Note IEN
 ;VIEN       = Visit IEN
 ;VPRV()     = Array 
 ;X,Y,Z      = Scratch variables
 ;
 ;Returns:
 ;String with 6 fields ('^' delimiter)
 ; 1  VIEN
 ; 2  Note Category (A-E)
 ; 3  Signed By (pointer to File #200)
 ; 4  Signed Date.Time (FM format)
 ; 5  Co-signed By (pointer to File #200) - defined only if necessary
 ; 6  Co-signed Date.Time - defined only if necessary
 ;-------------------------
 ;
PM(VIEN) ; external access point
 ; quit and return null if visit IEN is null
 I $G(VIEN)="" Q ""
 N ARY,CSTATC,DATE,PC,SIG,SIGA,SIGC,STAT,TIUIEN,VPRV
 S (TIUIEN,X,Z)=""
 ; get providers (returned in ARY array) who saw the patient
 D GETPRV^PXAPIOE(VIEN,"ARY")  ; DBIA 1541
 ; create VPRV array of valid providers
 D PROV
 ; initalize return string
 S Y=""
 ; looking for notes re: visit/encounter, get each document in turn
 F  S TIUIEN=$O(^TIU(8925,"V",VIEN,TIUIEN)) Q:TIUIEN=""  D  Q:$E(Y)="B"
 . ; get status of note, signers, and dates
 . D STAT
 . ;
 . ; Category B: Co-signed note by Primary Provider
 . I $D(SIGC),$G(VPRV(+SIGC))="P" D  Q:$E(Y)="B"
 .. Q:'$D(^TIU(8925,TIUIEN,"TEXT"))
 .. I STAT=7 S Y="B"_U_SIG_U_SIGC Q
 .. I STAT=8 S Y="B"_U_SIGA_U_SIGC
 . ;
 . ; Cateogory B: Primary Provider signed & completed note
 . I $D(SIG),$G(VPRV(+SIG))="P" D  Q:$E(Y)="B"
 .. I STAT=7,$D(^TIU(8925,TIUIEN,"TEXT")) S Y="B"_U_SIG_U_U
 . ;
 . ; Category B: Primary Provider Amended note
 . I $D(SIGA),$G(VPRV(+SIGA))="P" D  Q:$E(Y)="B"
 .. I STAT=8,$D(^TIU(8925,TIUIEN,"TEXT")) S Y="B"_U_SIGA_U_U
 . ;
 . ; Category B: Signer a Secondary Provider but in VPRV & note complete
 . I STAT=7,$D(SIG),$G(VPRV(+SIG))="S" S Y="B"_U_SIG_U_U Q
 . ;
 . ; Category D: Scanned Image
 . I $D(^TIU(8925.91,"B",TIUIEN)) S Y="D"_U_U_U_U Q
 . ;
 . ; Category C: Unsigned note
 . I ",1,2,4,5,6,7,8,11,13,"[CSTATC,Y="" S Y="C"_U_U_U_U Q
 . ;
 . ; Category E: Purged, deleted, or retracted
 . I ",9,14,15,"[CSTATC,Y="" S Y="E"_U_U_U_U Q
 ;
 ; Category A: no note found for this visit
 S:Y="" Y="A"_U_U_U_U
 ; return Y string w/ first piece being VIEN
 S Y=VIEN_U_Y
 Q Y
 ;
STAT ; get status of note and signer
 K SIG,SIGA,SIGC
 S STAT=$P($G(^TIU(8925,TIUIEN,0)),U,5),CSTATC=","_STAT_","
 ; document amended (STAT=8)
 I STAT=8 S X=$G(^TIU(8925,TIUIEN,16)) D
 . ; amended by ($P(X,U,2))
 . I $P(X,U,2) S SIGA=$P(X,U,2)_U_$P(X,U)
 S X=$G(^TIU(8925,TIUIEN,15))
 ; co-signature needed ($P(X,U,6)) 1=Yes, 0=No
 ;   per J.Hawsey co-sig field is not reliably set, thus not used
 ; co-signer ($P(X,U,8))
 I $P(X,U,8) S SIGC=$P(X,U,8)_U_$P(X,U,7)
 ; signer of document ($P(X,U,2))
 I $P(X,U,2) S SIG=$P(X,U,2)_U_$P(X,U)
 Q
 ;
PROV ; validate providers by $O through provider array (ARY) and
 ; creating VPRV array, where VPRV(VPRV)=Primary/Secondary^PersonClass
 S X=""
 F  S X=$O(ARY(X)) Q:X=""  D
 . ; Z=VPRV^PTIEN^VIEN^Prim/Secondary^Op/Attend^Ptr2PersonClass
 . S Z=ARY(X),VPRV=$P(Z,U)
 . ; Get Person Class information at the time of the visit
 . S PC=$P($$GET^XUA4A72(VPRV,+$G(^AUPNVSIT(VIEN,0))),U,7)  ; DBIA 1625 & 3580
 . S VPRV(VPRV)=$P(Z,U,4)
 . ; quit if provider is Primary (that is, accept provider)
 . Q:$P(VPRV(VPRV),U)="P"
 . ; PA/NP's are V100000 through V100618, inclusive
 . ; Physician (MD/DO) Resident, Allopathic is V115500
 . ; Physician (MD/DO) Resident, Osteopathic is V115600
 . ; if PC is any of the above, then accept provider, otherwise - don't
 . ; note: already accepted Primary provider above
 . I (PC]"V100618"!(PC']"V099999")),(PC'="V115500"),(PC'="V115600") S VPRV(VPRV)="X"
 Q
