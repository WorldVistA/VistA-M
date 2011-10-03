HDISVF01 ;BPFO/JRP - FILE UTILITIES/API;12/20/2004 ; 07 Mar 2005  9:53 AM
 ;;1.0;HEALTH DATA & INFORMATICS;**1**;Feb 22, 2005
 ;
 ;---- Begin HDIS VUID IMPLEMENTATION STATUS file (#7118.25) APIs ----
 ;
GETSTAT(FILE,FIELD,DATE,FAC,DOMAIN,TYPE) ;Get file/field implementation status
 ; Input : FILE - File number
 ;         FIELD - Field number (defaults to .01)
 ;         DATE - FileMan date/time to return status for (optional)
 ;                (defaults to NOW)
 ;         FAC - Facility number (optional) (defaults to current)
 ;         DOMAIN - Domain/IP address (optional) (defaults to current)
 ;         TYPE - Type of system (optional) (defaults to current)
 ;                0 = Test     1 = Production
 ;Output : StatusCode ^ StatusPointer ^ StatusDate
 ; Notes : Values for "not started" status and no date are returned
 ;         on bad input or if no entry is found
 ;       : If time is not included with the date, the last status
 ;         for the given day is returned
 ;       : If more than one entry for the same date/time is found, the
 ;         higher entry number is returned
 N IEN,STATCODE,STATPTR,STATDT,NOTYET,FFPTR,SYSPTR,X
 ;Calculate output for bad input
 S STATCODE=0
 S X=$$GETIEN^HDISVF06(STATCODE,+$$GETTYPE^HDISVF02(),.STATPTR)
 S NOTYET=STATCODE_"^"_STATPTR_"^"
 ;Check input
 S FILE=+$G(FILE)
 I 'FILE Q NOTYET
 S FIELD=+$G(FIELD)
 I 'FIELD S FIELD=.01
 S DATE=+$G(DATE)
 I 'DATE S DATE=$$NOW^XLFDT()
 I '$P(DATE,".",2) S $P(DATE,".",2)=24
 S FAC=+$G(FAC)
 I 'FAC S FAC=$$FACNUM()
 S DOMAIN=$G(DOMAIN)
 I DOMAIN="" S DOMAIN=$G(^XMB("NETNAME"))
 S TYPE=$G(TYPE)
 I TYPE="" S TYPE=$$PROD^XUPROD()
 I ('FAC)!(DOMAIN="")!(TYPE="") Q NOTYET
 ;Get pointers
 I '$$FINDSYS^HDISVF07(DOMAIN,FAC,TYPE,1,.SYSPTR) Q NOTYET
 I '$$GETIEN^HDISVF05(FILE,FIELD,.FFPTR) Q NOTYET
 ;Get status date/time closest to input date/time
 S DATE=DATE+.0000001
 S STATDT=+$O(^HDISF(7118.25,"AFAC",SYSPTR,FFPTR,DATE),-1)
 I 'STATDT Q NOTYET
 ;Build list of entry numbers with found status date/time
 K IEN
 S STATPTR=0
 F  S STATPTR=+$O(^HDISF(7118.25,"AFAC",SYSPTR,FFPTR,STATDT,STATPTR)) Q:'STATPTR  D
 .S IEN=0
 .F  S IEN=+$O(^HDISF(7118.25,"AFAC",SYSPTR,FFPTR,STATDT,STATPTR,IEN)) Q:'IEN  D
 ..S IEN(IEN)=STATPTR
 ;Get last entry number
 S IEN=+$O(IEN(""),-1)
 I 'IEN Q NOTYET
 ;Build output
 S STATPTR=IEN(IEN)
 S X=$$GETCODE^HDISVF06(STATPTR,.STATCODE)
 Q STATCODE_"^"_STATPTR_"^"_STATDT
 ;
SETSTAT(FILE,FIELD,CODE,DATE,STTYPE,FAC,DOMAIN,SYTYPE) ;Set file/field implementation status
 ; Input : FILE - File number
 ;         FIELD - Field number (defaults to .01)
 ;         CODE - Status code to set (defaults to "not started")
 ;         DATE - FileMan date/time to return status for (optional)
 ;                (defaults to NOW)
 ;         STTYPE - Type of status code being used (optional)
 ;                  1 = Client (default)     2 = Server
 ;         FAC - Facility number (optional) (defaults to current)
 ;         DOMAIN - Domain/IP address (optional) (defaults to current)
 ;         SYTYPE - Type of system (optional) (defaults to current)
 ;                  0 = Test     1 = Production
 ;Output : None
 ; Notes : If time is not included with the date, 1 second past
 ;         midnight will be used as the time
 ;       : If an entry for the given file/field and date/time already
 ;         exists, a new entry will still be added
 N FFPTR,SYSPTR
 ;Check input
 S FILE=+$G(FILE)
 I 'FILE Q
 S FIELD=+$G(FIELD)
 I 'FIELD S FIELD=.01
 S CODE=+$G(CODE)
 S DATE=+$G(DATE)
 I 'DATE S DATE=$$NOW^XLFDT()
 I '$P(DATE,".",2) S $P(DATE,".",2)="000001"
 S STTYPE=+$G(STTYPE)
 I ('STTYPE)!(STTYPE<1)!(STTYPE>2) S STTYPE=1
 S FAC=+$G(FAC)
 I 'FAC S FAC=$$FACNUM()
 S DOMAIN=$G(DOMAIN)
 I DOMAIN="" S DOMAIN=$G(^XMB("NETNAME"))
 S SYTYPE=$G(SYTYPE)
 I SYTYPE="" S SYTYPE=$$PROD^XUPROD()
 I ('FAC)!(DOMAIN="")!(SYTYPE="") Q
 ;Get pointers
 I '$$FINDSYS^HDISVF07(DOMAIN,FAC,SYTYPE,1,.SYSPTR) Q
 I '$$GETIEN^HDISVF05(FILE,FIELD,.FFPTR) Q
 ;Create entry
 D ADDSTAT(FFPTR,SYSPTR,CODE,STTYPE,DATE)
 Q
 ;
SCREEN(FILE,FIELD,DATE) ;Apply screening logic to file/field ?
 ; Input : FILE - File number
 ;         FIELD - Field number (defaults to .01)
 ;         DATE - FileMan date/time to check against (optional)
 ;                (defaults to NOW)
 ;Output : Flag indicating if screening logic should be applied
 ;         0 = Don't screen entries during selection
 ;         1 = Screen entries during selection
 ; Notes : 0 (don't screen) is returned on bad input
 ;       : If time is not included with the date, the last status
 ;         for the given day is returned
 N SCREEN,STAT
 S SCREEN=0
 S FILE=+$G(FILE)
 I 'FILE Q SCREEN
 S FIELD=+$G(FIELD)
 I 'FIELD S FIELD=.01
 S DATE=+$G(DATE)
 I 'DATE S DATE=$$NOW^XLFDT()
 S STAT=$$GETSTAT(FILE,FIELD,DATE)
 I +STAT=6 S SCREEN=1
 Q SCREEN
 ;
ADDSTAT(FFPTR,SYSPTR,CODE,TYPE,DATE) ;Set file/field implementation status
 ; Input : FFPTR - Pointer to HDIS FILE/FIELD file (#7115.6)
 ;         SYSPTR - Pointer to HDIS SYSTEM file (#7118.21)
 ;         CODE - Status code to set (defaults to "not started")
 ;         TYPE - Type of status code being used (optional)
 ;                1 = Client (default)     2 = Server
 ;         DATE - FileMan date/time to return status for (optional)
 ;                (defaults to NOW)
 ;Ouput : None
 ; Notes : If time is not included with the date, 1 second past
 ;         midnight will be used as the time
 ;       : If an entry for the given file/field and date/time already
 ;         exists, a new entry will still be added
 ;       : Call assumes that FFPTR and SYSPTR are valid
 N STATPTR,HDISFDA,HDISIEN,HDISMSG,IENS
 ;Check input
 S FFPTR=+$G(FFPTR)
 I 'FFPTR Q
 S SYSPTR=+$G(SYSPTR)
 I 'SYSPTR Q
 S CODE=+$G(CODE)
 S DATE=+$G(DATE)
 I 'DATE S DATE=$$NOW^XLFDT()
 I '$P(DATE,".",2) S $P(DATE,".",2)="000001"
 S TYPE=+$G(TYPE)
 I ('TYPE)!(TYPE<1)!(TYPE>2) S TYPE=1
 ;Get pointer to status
 I '$$GETIEN^HDISVF06(CODE,TYPE,.STATPTR) Q
 ;Create entry
 S IENS="+1,"
 S HDISFDA(7118.25,IENS,.01)=SYSPTR
 S HDISFDA(7118.25,IENS,.02)=FFPTR
 S HDISFDA(7118.25,IENS,.03)=STATPTR
 S HDISFDA(7118.25,IENS,.04)=DATE
 D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 Q
 ;
 ;---- End HDIS VUID IMPLEMENTATION STATUS file (#7118.25) APIs ----
 ;
FACPTR(FACNUM) ;Return pointer to INSTITUTION file (#4) for facility number
 ; Input : FACNUM - Facility number (optional) (defaults to current)
 ;Output : Pointer to INSTITUTION file (#4)
 ; Notes : NULL ("") is returned if an entry can not be found
 N FACPTR
 S FACNUM=$G(FACNUM)
 I 'FACNUM D  Q FACPTR
 .S FACPTR=+$$SITE^VASITE()
 .I FACPTR<1 S FACPTR=""
 S FACPTR=$$LKUP^XUAF4(FACNUM)
 I 'FACPTR S FACPTR=""
 Q FACPTR
 ;
FACNUM(FACPTR) ;Return facility number
 ; Input : FACPTR - Pointer to INSTITUTION file (#4) (optional)
 ;                  (default to current location)
 ;Output : Facility number
 ;         Null ("") returned if facility number couldn't be determined
 N FACNUM
 S FACPTR=$G(FACPTR)
 I 'FACPTR D  Q FACNUM
 .S FACNUM=$P($$SITE^VASITE(),"^",3)
 .I FACNUM<1 S FACNUM=""
 S FACNUM=$P($$NS^XUAF4(FACPTR),"^",2)
 I FACNUM<1 S FACNUM=""
 Q FACNUM
