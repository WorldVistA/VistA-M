MAGGNTI1 ;WOIFO/GEK - Imaging interface to TIU. RPC Calls etc. ; 04 Apr 2002  2:37 PM
 ;;3.0;IMAGING;**46,59**;Nov 27, 2007;Build 20
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;      
 Q
NEW(MAGRY,MAGDFN,MAGTITLE,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGLOC,MAGDATE,MAGCNSLT,MAGTEXT) ;RPC [MAG3 TIU NEW]
 ;
 ;  RPC call to create a New Note 
 ;  and Optionally :  
 ;     Electronically Sign,  
 ;     Administratively Close 
 ;     or Add Text to the Note.
 ;       
 ;  - - -  Required  - - - 
 ;  MAGDFN   - Patient DFN
 ;  MAGTITLE - IEN of TIU Document Title in file 8925.1
 ;  - - -  Optional  - - - 
 ;  Use DUZ for TIUAUTH 
 ;  Use NOW for TIURDT
 ;  MAGTEXT  - Array of Text to add to the New Note.
 ;  MAGLOC   - IEN in Hospital Location File 44
 ;  MAGES    - The encrypted Electronic Signature
 ;  MAGESBY  - The DUZ of the Signer (Defaults to DUZ)
 ;  MAGADCL  - 1 = Mark this Note as Administratively Closed
 ;  MAGMODE  - Mode of Admin Closure: "S" = Scanned Document 
 ;             "M" = Manual closure, "E" = Electronically Filed
 ;  MAGDATE  - Date of the Note. For New Notes.
 ;  MAGCNSLT - DA of Consult to Link to.
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MAGDFN=$G(MAGDFN),MAGTITLE=$G(MAGTITLE),MAGLOC=$G(MAGLOC)
 S MAGES=$G(MAGES),MAGADCL=$G(MAGADCL)
 S MAGESBY=$S($G(MAGESBY):MAGESBY,1:DUZ)
 S MAGMODE=$S($L($G(MAGMODE)):MAGMODE,1:"S")
 S MAGDATE=$G(MAGDATE),MAGCNSLT=$G(MAGCNSLT)
 N MAGTIUDA,I,NODE,MAGTY,ISVAL,MAGISC,MTXT,MUPD,MAGX,MAGVSTR,MAGTIUX
 ;
 ;  MAGMODE is only sent if Admin Closure is wanted.
 I (MAGMODE="S") S MAGTEXT(.1)="   VistA Imaging - Scanned Document"
 I (MAGMODE="M") S MAGTEXT(.1)="   VistA Imaging - Manual Closure"
 I "MSE"'[MAGMODE S MAGRY="0^Invalid Mode of Closure: """_MAGMODE_"""" Q
 ;
 ;       Here if we have no Text, we'll add at least a line.
 I $O(MAGTEXT(""))="" S MAGTEXT(.1)="   VistA Imaging - - Scanned Document"
 ;               Reformat Text - "TEXT",i,0)"   for TIU Call.
 S I="",NODE=0
 F  S I=$O(MAGTEXT(I)) Q:I=""  D
 . S NODE=NODE+1 S MAGTIUX("TEXT",NODE,0)=MAGTEXT(I)
 . Q
 ;          validate the DFN
 I '$D(^DPT(+MAGDFN,0)) S MAGRY="0^Invalid data: Patient DFN is invalid" Q
 ;      validate the User
 I '$D(^VA(200,MAGESBY,0)) S MAGRY="0^Invalid data: Author DUZ is invalid" Q
 ;      validate the TIU TITLE
 I '$D(^TIU(8925.1,MAGTITLE,0)) S MAGRY="0^Invalid data: Note TITLE is invalid" Q
 ;      validate Esig first, if caller wants to also mark this Note as Signed
 I +$G(MAGES) I '$$VALES^MAGGNTI2(MAGES) S MAGRY="0^Invalid data: E-sign is invalid" Q
 ;      validate the Date   MAGDATE is changed to INternal if it is valid.
 I +$L(MAGDATE) I '$$VALID^MAGGSIV1(8925,1301,.MAGDATE,.MAGX) S MAGRY="0^"_MAGX Q
 I '$L(MAGDATE) S MAGDATE=$$NOW^XLFDT
 ; LINK TO CONSULT
 ; can user create Notes with This Title
 I '$$CANENTR^TIULP(MAGTITLE) S MAGRY="0^You need privileges to enter notes of that Title" Q
 ;
 D ISCNSLT^TIUCNSLT(.MAGISC,MAGTITLE)
 I MAGISC D  I 'MAGISC S MAGRY=MAGISC Q
 . ;  See if a Consult DA was sent.
 . IF 'MAGCNSLT S MAGISC="0^A Consult is needed to link to this note title"
 . Q
 I ('MAGISC)&(MAGCNSLT) S MAGRY="0^Cannot Link Consult with a Non Consult Title" Q
 ;
 ;               make a VSTR for TIU Call.
 S MAGVSTR=MAGLOC_";"_MAGDATE_";E"
 ;
 ; Call to NEW^TIUPNAPI wasn't doing what we needed. Now call TIU CREATE RECORD
 ; MAKE(SUCCESS,DFN,TITLE,VDT,VLOC,VSIT,TIUX,VSTR,SUPPRESS,NOASF)                
 D MAKE^TIUSRVP(.MAGTIUDA,MAGDFN,MAGTITLE,"",MAGLOC,"",.MAGTIUX,MAGVSTR)
 I 'MAGTIUDA!(MAGTIUDA=-1) S MAGRY="0^Error creating Note"_$G(MAGTIUDA) Q
 S MAGRY=MAGTIUDA_"^Note was created."
 S MAGTY=MAGRY
 ;
 ;       ;Put in the Date that was sent.
 I '$$VALID^MAGGSIV1(8925,1301,.MAGDATE,.MAGRES) S MAGRY=MAGRY_"  "_MAGRES
 E  S MTXT(1301)=MAGDATE
 ; - Fix in T30,  if DUZ isn't MAGESBY, we have Author different than User.
 I MAGESBY'=DUZ S MTXT("1202")=MAGESBY
 ;               Update and LINK TO CONSULT if needed.
 I MAGISC S MTXT("1405")=MAGCNSLT_";GMR(123,"
 I $D(MTXT) D  I 'MUPD S MAGRY=MUPD Q
 . D UPDATE^TIUSRVP(.MUPD,MAGTIUDA,.MTXT)
 . Q
 ;
 ;               If Admin Close, then We quit.
 I MAGADCL="1" D  Q
 . D ADMNCLOS^MAGGNTI2(.MAGTY,MAGDFN,MAGTIUDA,MAGMODE)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"  Administrative Closure.")
 . Q
 ;
 ;               if caller sent esignature to Sign this Note.
 I $L(MAGES) D
 . D SIGN^MAGGNTI3(.MAGTY,MAGDFN,MAGTIUDA,MAGES,MAGESBY)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"  Signed.")
 . Q
 Q
 ;
 ;(MAGRY,MAGDFN,MAGTITLE,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGLOC,MAGTEXT)
NEWADD(MAGRY,MAGDFN,MAGTIUDA,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGDATE,MAGTEXT) ; RPC [MAG3 TIU CREATE ADDENDUM]
 ;  RPC call to create an Addendum to a Note
 ;  and Optionally :  
 ;           Electronically Sign,
 ;           Administratively Close,
 ;           or Add Text to the Addendum
 ;       
 ;  - - -  Required  - - - 
 ;  MAGDFN   - Patient DFN
 ;  MAGTIUDA - IEN of TIU NOTE in file 8925
 ;  - - -  Optional  - - - 
 ;  MAGTEXT  - Array of Text to add to the New Note.
 ;  MAGES    - The encrypted Electronic Signature
 ;  MAGESBY  - The DUZ of the Signer (Defaults to DUZ)
 ;  MAGADCL  - 1 = Mark this Note as Administratively Closed
 ;  MAGMODE  - Mode of Admin Closure: "S" = Scanned Document "M" = Manual closure  "E" = Electronically Filed
 ;  MAGDATE  - Date of the Addendum.
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MAGDFN=$G(MAGDFN),MAGTIUDA=$G(MAGTIUDA),MAGES=$G(MAGES),MAGADCL=$G(MAGADCL)
 S MAGESBY=$S($G(MAGESBY):MAGESBY,1:DUZ),MAGMODE=$S($L($G(MAGMODE)):MAGMODE,1:"S")
 S MAGDATE=$G(MAGDATE)
 ;
 I '$$VALDATA^MAGGNTI2(.MAGRY,MAGDFN,MAGTIUDA) Q
 N MAGXT,I,CT,NEWTIUDA,MAGY,MAGRES,MAGUPD
 S CT=1,I=""
 S MAGXT("TEXT",1,0)="VistA Imaging  Scanned Document - Addendum."
 I $D(MAGTEXT) F  S I=$O(MAGTEXT(I)) Q:I=""  D
 . S CT=CT+1,MAGXT("TEXT",CT,0)=MAGTEXT(I)
 . Q
 ;
 ; Calling TIU CREATE ADDENDUM RECORD
 D MAKEADD^TIUSRVP(.MAGRY,MAGTIUDA,.MAGXT)
 ; MAGRY could be 0^error message
 ;       -1^message
 ;       TIUDA
 I $P(MAGRY,"^")<0 S $P(MAGRY,"^")=0 Q
 S NEWTIUDA=+MAGRY
 S MAGRY=MAGRY_"^Addendum was created."
 ;
 ;Put in the Date that was sent.
 K MAGUPD
 I '$$VALID^MAGGSIV1(8925,1301,.MAGDATE,.MAGRES) S MAGRY=MAGRY_"  "_MAGRES
 E  D
 . S MAGUPD(1301)=MAGDATE
 . S MAGUPD(1211)=$$GET1^DIQ(8925,1211,MAGTIUDA,"I")
 ; - Fix in T30,  if DUZ isn't MAGESBY, we have Author different than User.
 I MAGESBY'=DUZ S MAGUPD("1202")=MAGESBY
 I $D(MAGUPD) D
 . D UPDATE^TIUSRVP(.MAGY,NEWTIUDA,.MAGUPD)
 . I 'MAGY S MAGRY=MAGRY_" TIU Data was Not Correctly Filed."
 . Q
 ;
 ; if caller sent esignature to Sign this Addendum.
 I $L(MAGES) D  Q
 . D SIGN^MAGGNTI3(.MAGTY,MAGDFN,NEWTIUDA,MAGES,MAGESBY)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"  Signed.")
 . Q
 ;
 ; if caller wants to Admin Close this Addendum.
 I MAGADCL="1" D  Q
 . D ADMNCLOS^MAGGNTI2(.MAGTY,MAGDFN,NEWTIUDA,MAGMODE)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"  Administrative Closure.")
 . Q
 Q
MOD(MAGRY,MAGDFN,MAGTIUDA,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGTEXT) ; RPC [MAG3 TIU MODIFY NOTE]
 ; After a Note is filed, we call this to Modify the Note.  We do this to sign it.
 ;  That way the Signed Date is After the Image Association  Date/Time.
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MAGDFN=$G(MAGDFN),MAGTIUDA=$G(MAGTIUDA)
 S MAGADCL=$G(MAGADCL)
 S MAGMODE=$S($L($G(MAGMODE)):MAGMODE,1:"S")
 S MAGES=$G(MAGES)
 S MAGESBY=$S($G(MAGESBY):MAGESBY,1:DUZ)
 D MOD^MAGGNTI3(.MAGRY,MAGDFN,MAGTIUDA,MAGADCL,MAGMODE,MAGES,MAGESBY)
 Q
ERR ; ERROR TRAP
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY="0^ETRAP: "_ERR
 D @^%ZOSF("ERRTN")
 Q
SIGN(MAGRY,MAGDFN,MAGTIUDA,MAGES,MAGESBY) ;RPC [MAG3 TIU SIGN RECORD]
 ; RPC Call to 'Sign' a Note. 
 D SIGN^MAGGNTI3(.MAGRY,$G(MAGDFN),$G(MAGTIUDA),$G(MAGES),$G(MAGESBY))
 Q
