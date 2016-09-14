SDECAPI4 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
GETVISIT(BSDIN,BSDOUT) ;Private Entry Point
 ; >> All date/time variables must be in FileMan internal format
 ; Special Incoming Variables:
 ;  BSDIN("FORCE ADD")   = 1    ; no matter what, create new visit (Optional)
 ;  BSDIN ("NEVER ADD")  = 1    ; never add visit, just try to find one or more (Optional)
 ;  BSDIN("ANCILLARY")   = 1    ; for ancillary packages to create noon visit if no match found (Optional)
 ;  BSDIN("SHOW VISITS") = 1    ; this will display visits if more than one match
 ; Incoming Variables used in Matching: REQUIRED
 ;  BSDIN("PAT")         = patient IEN (file 2 or 9000001)
 ;  BSDIN("VISIT DATE")  = visit date & time (same as check-in date & time)
 ;  BSDIN ("SITE")       = location of encounter IEN (file 4 or 9999999.06)
 ;  BSDIN("VISIT TYPE")  = internal value for field .03 in Visit file
 ;  BSDIN("SRV CAT")     = internal value for service category
 ;  BSDIN("TIME RANGE")  = #   ; range in minutes for matching on visit time; REQUIRED unless FORCE ADD set
 ;                             ;   zero=exact matches only; -1=don't match on time
 ;   These are used to match if sent (Optional)
 ;  BSDIN("PROVIDER")    = IEN for provider to match from file 200
 ;  BSDIN("CLINIC CODE") = IEN of clinic stop code (file 40.7)
 ;  BSDIN("HOS LOC")     = IEN of hospital location (file 44, field .22 in VISIT file)
 ;  BSDIN("DEF CC")      = IEN of default clinic code for package making call PATCH 1009
 ;  BSDIN("DEF HL")      = IEN of default hospital location for package making call PATCH 1009
 ; Incoming Variables used in creating appt and visit
 ;  BSDIN("APPT DATE")   = appt date & time (Required for scheduled appts and walk-ins; check-in will be performed)
 ;  BSDIN("USR")         = user IEN in file 200; REQUIRED
 ;  BSDIN("OPT")         = name for Option Used To Create field, for check-in only (Optional)
 ;  BSDIN("OI")          = reason for appointment; for walk-ins (Optional)
 ; Incoming PCC variables for adding additional info to visit (Optional)
 ;  BSDIN("SDTPB")  = Third Party Billed (#.04)
 ;  BSDIN("SDPVL")  = Parent Visit Link (#.12)
 ;  BSDIN("SDAPPT") = WalkIn/Appt (#.16)
 ;  BSDIN("SDEVM")  = Evaluation and Management Code (#.17)
 ;  BSDIN("SDCODT") = Check Out Date & Time (#.18)
 ;  BSDIN("SDLS")   = Level of Service -PCC Form  (#.19).
 ;  BSDIN("SDVELG") = Eligibility (#.21)
 ;  BSDIN("SDPROT") = Protocol (#.25).
 ;  BSDIN("SDOPT")  = Option Used To Create (#.24)
 ;  BSDIN("SDOLOC") = Outside Location (#2101)
 ; Outgoing Array:
 ;  BSDOUT(0) always set; if = 0 none found and may have error message in 2nd piece
 ;                        if = 1 and BSDOUT(visit ien)="ADD" new visit just created
 ;                        if = 1 and BSDOUT(visit ien)=#; # is time difference in minutes
 ;                        if >1, multiple BSDOUT(visit ien) entries exist
 NEW BSDTMP K BSDOUT
 M BSDTMP=BSDIN    ;don't mess with incoming array
 IF '$$HAVEREQ(.BSDTMP,.BSDOUT) Q    ;check required fields
 ; if FORCE ADD set, bypass check-in & create visit
 ; if forced add, skip visit match attempt
 ;IF $G(BSDTMP("FORCE ADD")) D APPTDT Q
 I '$G(BSDTMP("SDOPT")) D
 .I $G(BSDTMP("OPT"))]"",BSDTMP("OPT")?.N,$D(^DIC(19,BSDTMP("OPT"))) S BSDTMP("SDOPT")=BSDTMP("OPT") Q
 .I $G(BSDTMP("OPT"))]"",$E(BSDTMP("OPT"),1,1)="`" S BSDTMP("SDOPT")=$TR(BSDTMP("OPT"),"`") Q
 .I $G(BSDTMP("OPT"))]"",BSDTMP("OPT")'?.N S BSDTMP("SDOPT")=$O(^DIC(19,"B",BSDTMP("OPT"),0)) Q
 .I $G(BSDTMP("SDOPT"))]"",$E(BSDTMP("SDOPT"),1,1)="`" S BSDTMP("SDOPT")=$TR(BSDTMP("SDOPT"),"`") Q
 .I $G(BSDTMP("SDOPT"))]"",BSDTMP("SDOPT")'?.N S BSDTMP("SDOPT")=$O(^DIC(19,"B",BSDTMP("SDOPT"),0)) Q
 I $G(BSDTMP("FORCE ADD")) D ADDVIST(.BSDTMP,.BSDOUT) Q
 ; attempt to find matching visits; return BSDOUT array
 I '$G(BSDTMP("FORCE ADD")) D MATCH(.BSDTMP,.BSDOUT)
 ;if >1 visits found, return full array and quit, unless they pass it the variable to show visits then we will display
 ;(calling app decides next step)
 ;IF BSDOUT(0)>1 Q
 ;if appt date set, go to check-in
 ;IF $G(BSDTMP("APPT DATE")),'$G(BSDTMP("NEVER ADD")) D APPTDT Q
 ;if only 1 visit found, return ien and quit
 ;IF BSDOUT(0)'=1 Q
 ; added 2nd match, move never add checks & not kill variables
 ;if called by ancillary package, just create noon visit and quit
 ;IF $G(BSDTMP("ANCILLARY")) D  Q
 ;. K BSDTMP("ANCILLARY"),BSDTMP("PROVIDER")            ; set up to find other ancillaries
 ;. D MATCH(.BSDTMP,.BSDOUT) I BSDOUT(0)=1 Q            ; try to match on hos loc or clinic
 ;. I $G(BSDTMP("NEVER ADD"))=1 Q                       ; if in never add mode, quit after 2nd match
 ;. S BSDTMP("VISIT DATE")=BSDTMP("VISIT DATE")\1       ; take off time; PCC will add noon
 ;. D ADDVIST(.BSDTMP,.BSDOUT)                          ; create noon visit
 ;if no visits found but in never add mode, just quit
 ;IF $G(BSDTMP("NEVER ADD"))=1 Q
 ;otherwise, logic falls through to create visit choices
APPTDT ;
 I $G(BSDTMP("CALLER"))]"",$G(BSDTMP("CALLER"))="BSD CHECKIN" Q  ;interactive visit creation
 ;if no appointment date/time sent, just create visit and quit
 IF '$G(BSDTMP("APPT DATE")) D ADDVIST(.BSDTMP,.BSDOUT) Q
 ; if one matching visit found, check-in but don't create visit
 I BSDOUT(0)=1 S BSDTMP("VIEN")=$O(BSDOUT(0))
 ;if patient already has appt at this time, call Check-in (which creates visit) then quit
 NEW IEN,ERR,V
 S IEN=$$SCIEN^SDECU2(BSDTMP("PAT"),BSDTMP("HOS LOC"),BSDTMP("APPT DATE"))  ;find appt
 I IEN D  Q
 . ; set variables used by checkin call
 . S BSDTMP("CDT")=BSDTMP("VISIT DATE")
 . S BSDTMP("CC")=$G(BSDTMP("CLINIC CODE"))
 . S BSDTMP("PRV")=$G(BSDTMP("PROVIDER"))
 . ; set more variables to use in BSDAPI
 . S BSDTMP("CLN")=$G(BSDTMP("HOS LOC"))
 . S BSDTMP("ADT")=$G(BSDTMP("APPT DATE"))
 . S ERR=$$CHECKIN^SDECAPI(.BSDTMP)      ;check in and create visit
 . ; reset BSDOUT only if truly added one.
 . I 'ERR S V=$$GETVST^SDECU2(BSDTMP("PAT"),BSDTMP("APPT DATE")) I V,'$G(BSDTMP("VIEN")) S:BSDOUT(0)=0 BSDOUT(0)=1 S BSDOUT(V)="ADD" Q
 . I ERR S BSDOUT(0)=0_U_$P(ERR,U,2)
 ; else call walk-in (which calls make appt, checkin and create visit)
 D WALKIN(.BSDTMP,.BSDOUT)
 Q
MATCH(IN,OUT) ; find matching visits based on IN array
 S OUT(0)=0
 NEW END,DATE,VIEN,STOP,DIFF,MATCH
 S MATCH=0
 D TIME(IN("TIME RANGE"),IN("VISIT DATE"),.DATE,.END)
 F  S DATE=$O(^AUPNVSIT("AA",IN("PAT"),DATE)) Q:'DATE  Q:(DATE>END)  D
 . S VIEN=0
 . F  S VIEN=$O(^AUPNVSIT("AA",IN("PAT"),DATE,VIEN)) Q:'VIEN  D
 . . I $$GET1^DIQ(9000010,VIEN,.11)="DELETED" Q                ;check for delete flag just in case xref not killed
 . . I IN("SITE")'=$$GET1^DIQ(9000010,VIEN,.06,"I") Q          ;no match on loc of enc
 . . I IN("VISIT TYPE")'=$$GET1^DIQ(9000010,VIEN,.03,"I") Q    ;no match on visit type
 . . ; get observation and day surgery visits
 . . I IN("SRV CAT")["CENRT" Q  ;don't look at HIM excluded visits
 . . I $$GET1^DIQ(90000010,VIEN,.07,"I")["CENRT" Q  ;don't look at HIM excluded visits
 . . I IN("SRV CAT")=$$GET1^DIQ(9000010,VIEN,.07,"I") S MATCH=1       ;no match on service category
 . . I IN("SRV CAT")="A",$G(IN("ANCILLARY")),$$GET1^DIQ(9000010,VIEN,.07,"I")="O" S MATCH=1  ;match if observation
 . . I IN("SRV CAT")="A",$G(IN("ANCILLARY")),$$GET1^DIQ(9000010,VIEN,.07,"I")="D" S MATCH=1
 . . I '$G(MATCH) Q
 . . I IN("TIME RANGE")>-1 S STOP=0 D  Q:STOP                  ;check time range
 . . . S DIFF=$$TIMEDIF(IN("VISIT DATE"),VIEN)                 ;find difference in minutes
 . . . I $$ABS^XLFMTH(DIFF)>IN("TIME RANGE") S STOP=1
 . . I '$$PRVMTCH Q   ; if provider sent and didn't match, skip
 . . ; if called by ancillary, falls through and sets visit into array
 . . ; otherwise, check if app wants to match on clinic code or hosp location
 . . I '$G(IN("ANCILLARY")) S STOP=0 D  Q:STOP
 . . . I $G(IN("HOS LOC")),'$G(IN("CLINIC CODE")) S IN("CLINIC CODE")=$$GET1^DIQ(44,IN("HOS LOC"),8,"I")
 . . . I $G(IN("CLINIC CODE")),IN("CLINIC CODE")'=$$GET1^DIQ(9000010,VIEN,.08,"I") S STOP=1 Q  ;no match on clinic code
 . . . ; if both have appt date and visit was triage clinic, is a match
 . . . ; create visit on same day no matter what
 . . . I $G(IN("HOS LOC")),(IN("HOS LOC")'=$$GET1^DIQ(9000010,VIEN,.22,"I")) S STOP=1 Q  ;no match on hospital location
 . . . ; if same clinic & same provider but not triage, make new visit
 . . . I $G(IN("APPT DATE")),$$GET1^DIQ(9000010,VIEN,.26,"I"),'$$TRIAGE(VIEN) S STOP=1 Q
 . . ; must be good match, increment counter and set array node
 . . S OUT(0)=OUT(0)+1
 . . S OUT(VIEN)=$$TIMEDIF(IN("VISIT DATE"),VIEN)
 Q
 ;
PRVMTCH() ; do visits match on provider?
 NEW PRVS,IEN
 I '$G(IN("PROVIDER")) Q 1     ; if no provider sent, assume okay
 ;if visit is triage clinic & new encounter is not ancillary, skip provider match
 I $$TRIAGE(VIEN),'$G(IN("ANCILLARY")) Q 1
 ; find all v provider entries for visit
 S IEN=0 F  S IEN=$O(^AUPNVPRV("AD",VIEN,IEN)) Q:'IEN  D
 . S PRVS(+$G(^AUPNVPRV(IEN,0)))=""
 ;if incoming provider in list, this is match
 I $D(PRVS(IN("PROVIDER"))) Q 1
 ;otherwise, no match
 Q 0
 ;
TIMEDIF(VDTTM,VIEN) ; return time diff between incoming time and current visit
 Q $$FMDIFF^XLFDT(VDTTM,+$G(^AUPNVSIT(VIEN,0)),2)\60
 ;
ADDVIST(BSDTMP,BSDOUT)  ;
 N %DT,SDALVR,SUB,X,Y
 N SDDATE,SDHL,SDLOC,SDCODT,SDPAT
 S SUB="SD" F  S SUB=$O(BSDTMP(SUB)) Q:SUB=""  Q:$E(SUB,1,2)'="SD"  S SDALVR(SUB)=BSDTMP(SUB)
 S SDALVR("AUPNTALK")="",SDALVR("SDANE")=""        ;keep it silent
 S (SDLOC,SDALVR("SDLOC"))=BSDTMP("SITE")                     ;facility
 S (SDPAT,SDALVR("SDPAT"))=BSDTMP("PAT")                      ;patient
 S SDALVR("SDTYPE")=BSDTMP("VISIT TYPE")              ;visit type
 S SDALVR("SDCAT")=BSDTMP("SRV CAT")                  ;srv cat
 S (SDDATE,SDALVR("SDDATE"))=BSDTMP("VISIT DATE")              ;chkin dt
 I $G(BSDTMP("CLINIC CODE")) S SDALVR("SDCLN")="`"_BSDTMP("CLINIC CODE")      ;clinic code ien w/`
 S (SDHL,SDALVR("SDHL"))=$G(BSDTMP("HOS LOC"))               ;clinic name
 S SDALVR("SDAPDT")=$G(BSDTMP("APPT DATE"))           ;appt date
 S SDALVR("SDUSR")=$G(BSDTMP("USR"))
 S SDALVR("SDADD")=1                                  ;force add
 S SDCODT=BSDTMP("SDCODT")
 ;create visit
 ;D EN^SDECALV   ;D ^APCDALV
 D EN1^SDECALV(.SDALVR)
 ;if no visit created,error quit
 I '$G(SDALVR("SDVSIT")) D  Q
 . S BSDOUT(0)="0^Error Creating Visit"
 ; set new visit info in out array
 S BSDOUT(SDALVR("SDVSIT"))="ADD",BSDOUT(0)=1
 Q
 ;
WALKIN(BSDATA,OUT) ;EP; create walkin appt which is checked in and visit created
 ; also called by BSDAPI3 to create ancillary walkin appt
 NEW ERR,V
 S OUT(0)=0    ;initialize outgoing count
 S BSDATA("CLN")=$G(BSDATA("HOS LOC"))
 S BSDATA("TYP")=4   ;4=walkin
 S BSDATA("ADT")=$G(BSDATA("APPT DATE"))
 I '$D(BSDATA("LEN")) S BSDATA("LEN")=$$GET1^DIQ(44,BSDATA("CLN"),1912)
 ; make walkin appt
 S ERR=$$MAKE^SDECAPI(.BSDATA) I ERR S $P(OUT(0),U,2)=$P(ERR,U,2) Q
 ; set variables used by checkin call
 S BSDATA("CDT")=BSDATA("VISIT DATE")
 S BSDATA("CC")=$G(BSDATA("CLINIC CODE"))
 S BSDATA("PRV")=$G(BSDATA("PROVIDER"))
 ; check in appt and create visit
 S ERR=$$CHECKIN^SDECAPI(.BSDATA)
 ; update out array based on result
 ;reset BSDOUT(0) only if added new visit
 I 'ERR S V=$$GETVST^SDECU2(BSDATA("PAT"),BSDATA("APPT DATE")) I V,'$G(BSDTMP("VIEN")) S:OUT(0)=0 OUT(0)=1 S OUT(V)="ADD"   ;visit added
 I ERR S $P(OUT(0),U,2)=$P(ERR,U,2)          ;error
 Q
 ;
HAVEREQ(IN,OUT) ; check required fields
 I ('$G(IN("FORCE ADD"))),('$D(IN("TIME RANGE"))) S OUT(0)="0^Missing Time Range" Q 0
 I '$D(IN("PAT")) S OUT(0)="0^Missing Patient IEN" Q 0
 I '$D(IN("VISIT DATE")) S OUT(0)="0^Missing Visit Date" Q 0
 I '$D(IN("SITE")) S OUT(0)="0^Missing Facility/Site" Q 0
 I '$D(IN("VISIT TYPE")) S OUT(0)="0^Missing Visit Type" Q 0
 I '$D(IN("SRV CAT")) S OUT(0)="0^Missing Service Category" Q 0
 I '$D(IN("USR")) S OUT(0)="0^Missing User IEN" Q 0
 I $G(IN("HOS LOC")),'$G(IN("CLINIC CODE")) S IN("CLINIC CODE")=$$GET1^DIQ(44,IN("HOS LOC"),8,"I")
 ; convert service category
 I $G(IN("APPT DATE")),$G(IN("HOS LOC")) S IN("SRV CAT")=$$SERCAT^SDECV(IN("HOS LOC"),IN("PAT"))
 Q 1
 ;
TIME(RANGE,VISIT,DATE,END) ; set DATE and END based on TIME RANGE setting in minutes
 NEW TMDIF,SW
 S TMDIF=$S(RANGE<1:0,1:RANGE)
 S DATE=$$FMADD^XLFDT(VISIT,,,-TMDIF)
 S END=$$FMADD^XLFDT(VISIT,,,TMDIF)
 I (DATE\1)<(END\1) S SW=(END\1),END=(DATE\1)_".9999",DATE=SW
 S DATE=(9999999-(DATE\1)_"."_$P(DATE,".",2))-.0001
 S END=9999999-(END\1)_"."_$P(END,".",2)
 I RANGE=-1 S END=(END\1)_".9999",DATE=(DATE\1)     ;no time range used; go from begin one day to end
 Q
 ;
TRIAGE(VST) ; returns 1 if visit's hosp loc is triage type
 NEW HL
 S HL=$$GET1^DIQ(9000010,VST,.22,"I") I 'HL Q 0
 Q +$$GET1^DIQ(9009017.2,HL,.16,"I")
 ;
