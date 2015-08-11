VPSPDO1M  ;DALOI/KML,WOIFO/BT -  PDO OUTPUT DISPLAY - MEDS ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;IA #10103 - supported use of XLFDT functions
 ;IA #10104 - supported use of XLFSTR function
 ;
 ; The medication section of the PDO output specifically for the PATIENT ENTERED ALLERGY MEDICATION REVIEW
 ; which can be invoked by CPRS TIU components and as an RPC to be called by Vetlink staff-facing interface
 ;
MEDHDR(OREF) ; build medication sections for Patient Entered allergy medication review note
 ; active medications have an (RX) status of Active, Suspended, Hold, Provider Hold
 ; INPUT
 ;   OREF : Object Reference for the VPS PDO object
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 ;
 D ADDUNDLN^VPSOBJ(OREF)  ; DISPLAY UNDERSCORE
 D ADDLJ^VPSOBJ(OREF,"*** MEDICATION REVIEW - PATIENT RESPONSE KEY *** ")
 D ADDBLANK^VPSOBJ(OREF),ADDBLANK^VPSOBJ(OREF)  ; add 2 blank lines
 ;
 I $D(^VPS(853.5,PTIEN,"MRAR",LMRARDT,"MEDS")) D  ; the display of the medication patient response key occurs only if there are meds
 . D ADDLJ^VPSOBJ(OREF,"'Y' TAKING as written;")
 . D ADDLJ^VPSOBJ(OREF,"'N' NOT TAKING;")
 . D ADDLJ^VPSOBJ(OREF,"'D' TAKING DIFFERENTLY;")
 . D ADDLJ^VPSOBJ(OREF,"'?' patient UNSURE;")
 . D ADDLJ^VPSOBJ(OREF,"'X' NO RESPONSE (incomplete session/no answer)")
 . I STAFF D ADDLJ^VPSOBJ(OREF,">> indicates MARK FOR FOLLOW UP")
 . D ADDUNDLN^VPSOBJ(OREF)  ; DISPLAY UNDERSCORE
 Q
 ;
MEDS(OREF,SAVMEDS) ; sort the displayed meds by active, NONVA, and PAST
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ; OUTPUT
 ;   SAVMEDS  : passed in by reference.  array represents the list of medications to display at a given section
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 ;
 ; -- build active meds section
 D ADDCJ^VPSOBJ(OREF,"*** ACTIVE MEDICATIONS   ***   ACTIVE MEDICATIONS   ***")
 N RXSTAT,MEDITMS
 F RXSTAT=0,5,3,15 D GET(OREF,RXSTAT,.MEDITMS) ;get active, suspended, hold, provider hold meds
 I $D(MEDITMS) D BLD(OREF,.MEDITMS,"ACTIVE")
 N ACTIVE S ACTIVE=$$GETACTIV^VPSOBJ(OREF)
 I 'ACTIVE D ADDLJ^VPSOBJ(OREF,"No active VA medications on file.")
 K SAVMEDS M SAVMEDS=MEDITMS ; SAVMEDS to be used in the CHANGES SINCE algorithm
 K MEDITMS
 ;
 ; -- build NON-VA meds section
 D ADDBLANK^VPSOBJ(OREF)
 D ADDCJ^VPSOBJ(OREF,"***   NON-VA MEDICATIONS   ***   NON-VA MEDICATIONS   ***")
 N NONVA D GETNONVA^VPSOBJ(OREF,.NONVA)
 I '$D(NONVA) D ADDLJ^VPSOBJ(OREF,"No active Non-VA medications on file.")
 I $D(NONVA) D BLDNONVA(OREF)
 ;
 ; -- build PAST meds section
 D ADDUNDLN^VPSOBJ(OREF)  ; DISPLAY UNDERSCORE
 D ADDCJ^VPSOBJ(OREF,"***   EXPIRED & DISCONTINUED MEDS   ***   EXPIRED & DISCONTINUED MEDS   ***")
 N RXSTAT,MEDITMS
 F RXSTAT=11,12,14,15 D GET(OREF,RXSTAT,.MEDITMS) ; get expired, discontinued, discontinued by provider, discontinued edit
 I '$D(MEDITMS) D ADDLJ^VPSOBJ(OREF,"No Expired or Discontinued Medications on file.")
 I $D(MEDITMS) D BLD(OREF,.MEDITMS,"PAST")
 M SAVMEDS=MEDITMS ; SAVMEDS to be used in the CHANGES SINCE algorithm
 K MEDITMS
 Q
 ;
GET(OREF,RXSTAT,MEDITMS) ; get MED data
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;   RXSTAT   : RX status.  Medication list is displayed at specific sections of the note depending on status
 ; OUTPUT
 ;   MEDITMS  : passed in by reference.  array represents the list of medications to display at a given section
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 ;
 N MEDIEN S MEDIEN=0
 F  S MEDIEN=$O(^VPS(853.5,PTIEN,"MRAR",LMRARDT,"MEDS","RXST",RXSTAT,MEDIEN)) Q:'MEDIEN  D
 . N MEDNAME S MEDNAME=$$GET1^DIQ(853.54,MEDIEN_","_LMRARDT_","_PTIEN_",",10) ; medication name
 . Q:MEDNAME=""  ; quit if medication name is null (PDO display requires a medication name)
 . S MEDITMS(MEDNAME,MEDIEN)="" ; medications need to be displayed in alphabetical order; build array sorted by med name;
 Q
 ;
BLDNONVA(OREF) ; build NON VA meds
 ; INPUT
 ;   OREF    : Object Reference for the VPS PDO object
 ;
 N NONVA D GETNONVA^VPSOBJ(OREF,.NONVA)
 N NAME S NAME=""
 ;
 F  S NAME=$O(NONVA(NAME)) Q:NAME=""  D 
 . D SETMEDNM^VPSOBJ(OREF,NAME)
 . D SETPROPS(OREF,.NONVA) ; assign data to properties for ease of handling
 . D NAMELINE(OREF) ; Add followup, patient response, med name 
 . D SIGLINES(OREF) ; Add SIG lines to result array
 . D PRVLINES(OREF) ; Add provider lines
 . D ADDNONVA(OREF) ; Add patient comments 
 ;
 K NONVA
 Q
 ;
BLD(OREF,MEDITMS,TYPE) ; build the array of data associated with a given medication (at the 853.54 SUB-ENTRY)
 ; INPUT
 ;   OREF    : Object Reference for the VPS PDO object
 ;   MEDITMS : passed in by reference.  array represents the list of medications to display at a given section
 ;   TYPE    : "ACTIVE" or "PAST" medication
 ;
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 ;
 N NONVA
 N NAME S NAME=""
 N MIEN S MIEN=0
 D SETACTIV^VPSOBJ(OREF,0)
 D SETMTYPE^VPSOBJ(OREF,TYPE)
 D KILNONVA^VPSOBJ(OREF)
 ;
 F  S NAME=$O(MEDITMS(NAME)) Q:NAME=""  F  S MIEN=$O(MEDITMS(NAME,MIEN)) Q:'MIEN  D
 . D SETMEDNM^VPSOBJ(OREF,NAME)
 . N MEDLST D GETS^DIQ(853.54,MIEN_","_LMRARDT_","_PTIEN_",","2;3;4;5;6;7;9;11;13;14;15;16;21;22","IE","MEDLST")  ; refer to routine VPSMRAR2 for field references at subfile 853.54
 . ;
 . ; -- transform med data (fileman result) to FLD by field name
 . N INEX,FLD
 . ; initialize med fields
 . F FLD=2,3,4,5,6,7,9,11,13,14,15,16,21,22 F INEX="E","I" S FLD(NAME,FLD,INEX)=""
 . S FLD=0
 . F  S FLD=$O(MEDLST(853.54,MIEN_","_LMRARDT_","_PTIEN_",",FLD)) Q:'FLD  F INEX="E","I" S FLD(NAME,FLD,INEX)=MEDLST(853.54,MIEN_","_LMRARDT_","_PTIEN_",",FLD,INEX)
 . ;
 . ; -- NonVA meds need to display in a separate section; save into separate array
 . N ISNONVA S ISNONVA=(FLD(NAME,21,"I")="Y")
 . I TYPE="ACTIVE",ISNONVA D APDNONVA^VPSOBJ(OREF,.FLD) K FLD Q
 . ;
 . ; -- ACTIVE (NON-VA = false) and PAST type continue here
 . D SETACTIV^VPSOBJ(OREF,1)
 . D SETPROPS(OREF,.FLD) ; assign data to properties for ease of handling
 . D NAMELINE(OREF) ; Add followup, patient response, med name 
 . D SIGLINES(OREF) ; Add SIG lines to result array
 . D PRVLINES(OREF) ; Add provider lines
 . ;
 . ; -- patient comment lines
 . N PATCOMM D GCOMM^VPSPUTL1(LMRARDT,PTIEN,MIEN,STAFF,.COL,.PATCOMM)
 . D SETPATCM^VPSOBJ(OREF,.PATCOMM)
 . D PTCLINES(OREF) ; Add patient comments 
 . K MEDLST,PATCOMM,FLD
 Q
 ;
SETPROPS(OREF,FLD) ; assign data to properties for ease of handling
 ; INPUT
 ;   OREF   : Object Reference for the VPS PDO object
 ;   FLD    : Med data by fieldname
 ; 
 N PTIEN S PTIEN=$$GETDFN^VPSOBJ(OREF)
 N LMRARDT S LMRARDT=$$GETLSTMR^VPSOBJ(OREF)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N NAME S NAME=$$GETMEDNM^VPSOBJ(OREF)
 ;
 D SETLREFL^VPSOBJ(OREF,FLD(NAME,6,"E")) ;left refills
 D SETMREFL^VPSOBJ(OREF,FLD(NAME,22,"E")) ;max refills
 D SETSIG^VPSOBJ(OREF,FLD(NAME,13,"E")) ; SIG instruction
 D SETPROV^VPSOBJ(OREF,FLD(NAME,2,"E")) ; provider
 D SETDSPLY^VPSOBJ(OREF,FLD(NAME,5,"E")) ; days supplied
 N MFILL S MFILL=$S(FLD(NAME,4,"I")]"":$$FMDIFF^XLFDT(DT,FLD(NAME,4,"I")),1:"")  ; days of last refill (NOW - DATE LAST FILLED)
 D SETMFILL^VPSOBJ(OREF,MFILL)
 N NXFILLDT S NXFILLDT=$S(FLD(NAME,7,"I")]"":$$FMTE^XLFDT(FLD(NAME,7,"I"),2),1:"")  ; DATE NEXT FILLED
 D SETNFILL^VPSOBJ(OREF,NXFILLDT)
 D SETRMLOC^VPSOBJ(OREF,FLD(NAME,3,"E")) ; remote fill location
 D SETREMOT^VPSOBJ(OREF,FLD(NAME,9,"E")]"") ; remote med id exist
 N MARKFOL S MARKFOL=FLD(NAME,16,"I") ; mark for follow-up for patient facilitated output
 I STAFF,MARKFOL]"" S MARKFOL=">>" D SETMKFOL^VPSOBJ(OREF,MARKFOL)
 D SETPATRP^VPSOBJ(OREF,FLD(NAME,11,"E")) ; MR preset patient response
 Q
 ;
NAMELINE(OREF) ; Add followup, patient response, med name to result array
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N STAFF S STAFF=$$GETSTAFF^VPSOBJ(OREF)
 N MARKFOL S MARKFOL=$$GETMKFOL^VPSOBJ(OREF)
 N PATRESP S PATRESP=$$GETPATRP^VPSOBJ(OREF)
 N NAME S NAME=$$GETMEDNM^VPSOBJ(OREF)
 ;
 N VPSX S VPSX=""
 I STAFF S VPSX=$$SETFLD^VPSPUTL1(MARKFOL,VPSX,COL("FOLLOWUP"))
 S VPSX=$$SETFLD^VPSPUTL1(PATRESP,VPSX,COL("PATRESP"))
 S VPSX=$$SETFLD^VPSPUTL1(NAME,VPSX,COL("MEDNAME"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
SIGLINES(OREF) ; Add SIG lines to result array
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N TYPE S TYPE=$$GETMTYPE^VPSOBJ(OREF)
 N SIG S SIG(1)=$$GETSIG^VPSOBJ(OREF)
 N LFTREFIL S LFTREFIL=$$GETLREFL^VPSOBJ(OREF)
 N MAXREFIL S MAXREFIL=$$GETMREFL^VPSOBJ(OREF)
 N NSIG S ^TMP("VPSPUTL1",$J)=0 D FCOMM^VPSPUTL1(.SIG,$P(COL("SIG"),U,2),.NSIG)
 ;
 N LAST S LAST=$O(NSIG(""),-1)
 N SUB S SUB=0
 ;
 F  S SUB=$O(NSIG(SUB)) Q:'SUB  D
 . N VPSX S VPSX=$$SETFLD^VPSPUTL1(NSIG(SUB),"",COL("SIG"))
 . I SUB=LAST,TYPE'="NONVA" S VPSX=$$SETFLD^VPSPUTL1("Refills left: "_LFTREFIL_" of "_MAXREFIL,VPSX,COL("REFILLS"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
PRVLINES(OREF) ; Add provider lines
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N TYPE S TYPE=$$GETMTYPE^VPSOBJ(OREF)
 N PROVIDER S PROVIDER=$$GETPROV^VPSOBJ(OREF)
 N DAYSUPLY S DAYSUPLY=$$GETDSPLY^VPSOBJ(OREF)
 N VPSX S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Provider: "_PROVIDER,VPSX,COL("PROVIDER"))
 I TYPE'="NONVA" S VPSX=$$SETFLD^VPSPUTL1("Days supplied: "_DAYSUPLY,VPSX,COL("DAYS SUPPLIED"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
PTCLINES(OREF) ; Add patient comments 
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N REMOTE S REMOTE=$$GETREMOT^VPSOBJ(OREF)
 I REMOTE D ADDREMOT(OREF)
 I 'REMOTE D ADDLOCAL(OREF)
 Q 
 ;
ADDNONVA(OREF) ; Add Non-va patient comment
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N PATCOMM D GETPATCM^VPSOBJ(OREF,.PATCOMM) ; Patient comments
 ; 
 I $D(PATCOMM) D
 . N RSS S RSS=0
 . F  S RSS=$O(PATCOMM(RSS)) Q:'RSS  D
 . . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(PATCOMM(RSS),VPSX,COL("COMMENTS"))
 . . D ADDPDO^VPSOBJ(OREF,VPSX)
 D ADDBLANK^VPSOBJ(OREF)  ; add a blank line between medication sets
 Q
 ;
ADDREMOT(OREF) ; Add remote (cdw) patient comment, filled days, next fill date to result array
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N REMLOC S REMLOC=$$GETRMLOC^VPSOBJ(OREF) ; remote location
 N FILLED S FILLED=$$GETMFILL^VPSOBJ(OREF) ; how long in days the medication was filled
 N NXFILLDT S NXFILLDT=$$GETNFILL^VPSOBJ(OREF) ; Next Fill Date
 N PATCOMM D GETPATCM^VPSOBJ(OREF,.PATCOMM) ; Patient comments
 N MEDTYPE S MEDTYPE=$$GETMTYPE^VPSOBJ(OREF) ; "ACTIVE", "NONVA", "PAST" Medication
 ;
 N VPSX S VPSX=""
 S VPSX=$$SETFLD^VPSPUTL1("Remote: "_REMLOC,VPSX,COL("REMOTE"))
 S VPSX=$$SETFLD^VPSPUTL1("Filled: "_FILLED_"d ago",VPSX,COL("FILLED"))
 D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 N RSS S RSS=0
 N FIRST S FIRST=1
 ;
 F  S RSS=$O(PATCOMM(RSS)) Q:'RSS  D
 . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(PATCOMM(RSS),VPSX,COL("COMMENTS"))
 . I TYPE'="PAST",FIRST S VPSX=$$SETFLD^VPSPUTL1("Next est fill: "_NXFILLDT,VPSX,COL("NEXTFILL")),FIRST=0
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 I '$D(PATCOMM),TYPE'="PAST" D
 . S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Next est fill: "_NXFILLDT,VPSX,COL("NEXTFILL"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 Q
 ;
ADDLOCAL(OREF) ; Add local vista patient comment, filled days, next fill date to result array
 ; INPUT
 ;   OREF     : Object Reference for the VPS PDO object
 ;
 N VPSX S VPSX=""
 N RSS S RSS=0
 N NEXTFILL S NEXTFILL=0
 N FIRST S FIRST=1
 N COL D GETFORMT^VPSOBJ(OREF,.COL)
 N FILLED S FILLED=$$GETMFILL^VPSOBJ(OREF) ; how long in days the medication was filled
 N NXFILLDT S NXFILLDT=$$GETNFILL^VPSOBJ(OREF) ; Next Fill Date
 N PATCOMM D GETPATCM^VPSOBJ(OREF,.PATCOMM) ; Patient comments
 N MEDTYPE S MEDTYPE=$$GETMTYPE^VPSOBJ(OREF) ; "ACTIVE", "NONVA", "PAST" Medication
 ;
 F  S RSS=$O(PATCOMM(RSS)) Q:'RSS  D
 . S VPSX="",VPSX=$$SETFLD^VPSPUTL1(PATCOMM(RSS),VPSX,COL("COMMENTS"))
 . I FIRST S VPSX=$$SETFLD^VPSPUTL1("Filled: "_FILLED_"d ago",VPSX,COL("FILLED")) D ADDPDO^VPSOBJ(OREF,VPSX) S FIRST=0 Q
 . I TYPE'="PAST",'FIRST,'NEXTFILL S VPSX=$$SETFLD^VPSPUTL1("Next est fill: "_NXFILLDT,VPSX,COL("NEXTFILL")),NEXTFILL=1
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 I '$D(PATCOMM) D
 . S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Filled: "_FILLED_"d ago",VPSX,COL("FILLED"))
 . D ADDPDO^VPSOBJ(OREF,VPSX)
 ;
 I TYPE="ACTIVE",'NEXTFILL S VPSX="",VPSX=$$SETFLD^VPSPUTL1("Next est fill: "_NXFILLDT,VPSX,COL("NEXTFILL")) D ADDPDO^VPSOBJ(OREF,VPSX)
 D ADDBLANK^VPSOBJ(OREF)  ; add a blank line between medication sets
 Q
