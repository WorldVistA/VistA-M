PXAPI ;ISL/dee - PCE's APIs ;4/16/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**15,14,27,28,124,164**;Aug 12, 1996
 Q
 ;
PROVNARR(PXPNAR,PXFILE,PXCLEX) ;Convert external Provider Narrative to internal.
 ;Input:
 ;  PXPNAR    Is the text of the provider narrative.
 ;  PXFILE  Is the file that the returned pointer will be stored in.
 ;              If a new entry is created then this tells the context
 ;              that it was created under by the file using it.
 ;  PXCLEX  Is and optional pointer to the Lexicon for this narrative.
 ;
 ;Returns:
 ;  Pointer to the provider narrative file ^ narrative
 ;  or pointer to the provider narrative file ^ narrative ^1
 ;    where 1 indicates that the entry has just been added
 ;  or -1 if was unsuccessful.
 ;
 N DIC,Y,DLAYGO,DD,DO,DA
 S DIC="^AUTNPOV(",DIC(0)="L",DLAYGO=9999999.27
 S (DA,Y)=0
 S X=$E(PXPNAR,1,245)
 Q:X="" -1
 L +^AUTNPOV(0):60
 E  W !,"The Provider Narrative is LOCKED try again." Q -1
 F  S DA=$O(^AUTNPOV("B",$E(X,1,30),DA)) Q:DA'>0  I $P(^AUTNPOV(DA,0),"^")=X S Y=DA_"^"_X Q
 I '(+Y) D
 . K DA,Y
 . D FILE^DICN
 . I +Y>0,($G(PXCLEX)!$G(PXFILE)) S ^AUTNPOV(+Y,757)=$G(PXCLEX)_"^"_$G(PXFILE)
 L -^AUTNPOV(0)
 Q $S(+Y>0:Y,1:-1)
 ;
STOPCODE(PXASTOP,PXAPAT,PXADATE) ;This is the function call to return the quantity
 ;                  of a particular Stop Code for a patient on one day.
 ;Input
 ;  PXASTOP  (required) pointer to #40.7
 ;  PXAPAT   (required) pointer to #2
 ;  PXADATE  (required) the date in Fileman format
 ;                     (time is ignored if passed)
 ;Returns
 ;  the count of how many of that stop code are stored for that one day
 ;
 N PXAVST,PXREVDAT,PXENDDAT,PXACOUNT
 S PXASTOP=$G(PXASTOP)
 S PXAPAT=+$G(PXAPAT)
 S PXADATE=+$G(PXADATE)
 S (PXACOUNT,PXAVST)=0
 S PXREVDAT=9999999-$P(PXADATE,".")-.00000001
 S PXENDDAT=PXREVDAT+.9
 F  S PXREVDAT=$O(^AUPNVSIT("AA",PXAPAT,PXREVDAT)) Q:'PXREVDAT!(PXREVDAT>PXENDDAT)  D
 . F  S PXAVST=$O(^AUPNVSIT("AA",PXAPAT,PXREVDAT,PXAVST)) Q:'PXAVST  D
 .. I PXASTOP=$P(^AUPNVSIT(PXAVST,0),"^",8),"E"'=$P(^AUPNVSIT(PXAVST,0),"^",7) S PXACOUNT=PXACOUNT+1
 Q PXACOUNT
 ;
CPT(PXACPT,PXAPAT,PXADATE,PXAHLOC) ;This is the function call to return the quantity
 ;                  of a particular CPT for a patient on one day and for
 ;                  one hospital location if passed.
 ;Input
 ;  PXACPT  (required) pointer to #81
 ;  PXAPAT   (required) pointer to #2
 ;  PXADATE  (required) the date in Fileman format
 ;                     (time is ignored if passed)
 ;  PXAHLOC  (optional) pointer to #44
 ;Returns
 ;  the count of how many (and quantity) of that cpt code are stored for that one day
 ;
 ;
 N PXAVST,PXAVCPT,PXREVDAT,PXENDDAT,PXACOUNT
 S PXACPT=$G(PXACPT)
 S PXAPAT=+$G(PXAPAT)
 S PXADATE=+$G(PXADATE)
 S PXAHLOC=+$G(PXAHLOC)
 S (PXACOUNT,PXAVST)=0
 S PXREVDAT=9999999-$P(PXADATE,".")-.00000001
 S PXENDDAT=PXREVDAT+.9
 F  S PXREVDAT=$O(^AUPNVSIT("AA",PXAPAT,PXREVDAT)) Q:'PXREVDAT!(PXREVDAT>PXENDDAT)  D
 . F  S PXAVST=$O(^AUPNVSIT("AA",PXAPAT,PXREVDAT,PXAVST)) Q:'PXAVST  D
 .. Q:"E"=$P(^AUPNVSIT(PXAVST,0),"^",7)
 .. Q:"1"=$P(^AUPNVSIT(PXAVST,150),"^",2)
 .. I PXAHLOC>0,PXAHLOC'=$P(^AUPNVSIT(PXAVST,0),"^",22) Q
 .. S PXAVCPT=0
 .. F  S PXAVCPT=$O(^AUPNVCPT("AD",PXAVST,PXAVCPT)) Q:'PXAVCPT  D
 ... I PXACPT=$P(^AUPNVCPT(PXAVCPT,0),"^",1) S PXACOUNT=PXACOUNT+$P(^(0),"^",16)
 Q PXACOUNT
 ;
INTV(WHAT,PACKAGE,SOURCE,VISIT,HL,DFN,APPT,LIMITDT,ALLHLOC) ;This api will prompt the user for Visit and related V-file data used to document an encounter.
 ;See INTV^PXBAPI for parameters and return values.
 ;
 I '($D(VISIT)#2) S VISIT=""
 I '($D(DFN)#2) S DFN=""
 I '($D(HL)#2) S HL=""
 ;
 Q $$INTV^PXBAPI(WHAT,PACKAGE,SOURCE,.VISIT,.HL,.DFN,$G(APPT),$G(LIMITDT),$G(ALLHLOC))
 ;
DELVFILE(WHICH,VISIT,PACKAGE,SOURCE,ASK,ECHO,USER) ;Deletes the requested data related to the visit.
 ;See DELVFILE^PXAPIDEL for parameters and return values.
 ;
 Q $$DELVFILE^PXAPIDEL(WHICH,VISIT,$G(PACKAGE),$G(SOURCE),$G(ASK),$G(ECHO),$G(USER))
 ;
DATA2PCE(DATA,PACKAGE,SOURCE,VISIT,USER,DISPLAY,ERROR,SCREEN,ARRAY,ACCOUNT) ;API to pass data for add/edit/delete to PCE
 ;See DATA2PCE^PXAI for parameters and return values.
 ;
 I '($D(DATA)#2) Q -3
 I '($D(PACKAGE)#2) Q -3
 I '($D(SOURCE)#2) Q -3
 I '($D(VISIT)#2) S VISIT=""
 Q $$DATA2PCE^PXAI(DATA,PACKAGE,SOURCE,.VISIT,$G(USER),$G(DISPLAY),.ERROR,$G(SCREEN),.ARRAY,.ACCOUNT) ;PX*1.0*164 CHANGED $G(ERROR) TO .ERROR
 ;
SOURCE(SOURCE) ;Get IEN of data source in the PCE Data Source file
 Q $$SOURCE^PXAPIUTL($G(SOURCE))
 ;
VISITLST(DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--GATHER VISITS
 ;See VISITLST^PXBGVST for parameters and return values.
 ;
 I '($D(DFN)#2) Q "-2^NO PATIENT SELECTED"
 Q $$VISITLST^PXBGVST(DFN,$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
ENCEDIT(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--Ask for encounter the edit it of delete it
 ;See ENCEDIT^PXAPIEED for parameters and return values.
 ;
 Q $$ENCEDIT^PXAPIEED($G(WHAT),$G(PACKAGE),$G(SOURCE),$G(DFN),$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
LOPENCED(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--Ask for encounter the edit it of delete it
 ;See LOPENCED^PXAPIEED for parameters and return values.
 ;
 Q $$LOPENCED^PXAPIEED($G(WHAT),$G(PACKAGE),$G(SOURCE),$G(DFN),$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
GETENC(DFN,ENCDT,HLOC) ;--Get all of the encounter data
 ;See GETENC^PXKENC for parameters and return values.
 ;
 Q $$GETENC^PXKENC($G(DFN),$G(ENCDT),$G(HLOC))
 ;
ENCEVENT(VISIT,DONTKILL) ;--Get all of the encounter data
 ;See ENCEVENT^PXKENC for parameters and return values.
 ;
 D ENCEVENT^PXKENC($G(VISIT),$G(DONTKILL))
 Q
 ;
VST2APPT(VISIT) ;Is this visit related to an appointment
 ;See VST2APPT^PXUTL1 for parameters and return values.
 ;
 Q $$VST2APPT^PXUTL1($G(VISIT))
 ;
APPT2VST(DFN,ENCDT,HLOC) ;Get the visit for an Appointment
 ;See APPT2VST^PXUTL1 for parameters and return values.
 ;
 Q $$APPT2VST^PXUTL1($G(DFN),$G(ENCDT),$G(HLOC))
 ;
SWITCHD() ;This returns the date that PCE starts collecting the data
 ; instead Scheduling (switch over date).
 Q $P($G(^PX(815,1,0)),"^",2)
 ;
SWITCHCK(DATE) ;Returns 1 if after the switch over date 0 otherwise.
 N SWITCH
 S SWITCH=$P($G(^PX(815,1,0)),"^",2)
 Q:SWITCH<2960000 0
 Q SWITCH'>DATE
 ;
DISPVSIT ;Called by Scheduling to create a visit for a disposition
 ;Add to fix scheduling calling visit tracking wrong without the
 ;  dispositioning clinic.  Hospital Location is required by Visit
 ;  Tracking to work correctly.
 I $G(VSIT("LOC"))>0,'$D(^PX(815,1,"DHL","B",VSIT("LOC"))) S VSIT("LOC")=""
 I $G(VSIT("LOC"))'>0,'$D(ZTQUEUED) D
 . I $P(^PX(815,1,"DHL",0),"^",4)=1 S VSIT("LOC")=$O(^PX(815,1,"DHL","B",0))
 . E  D
 .. ;ask for Hospital location from those that can disposition
 .. N DIC,DA,X,Y
DISPASK .. S DA(1)=1
 .. S DIC="^PX(815,1,""DHL"","
 .. S DIC("P")=$P(^DD(815,401,0),"^",2)
 .. S DIC(0)="AEOQ"
 .. D ^DIC
 .. I Y>0 S VSIT("LOC")=$P(Y,"^",2)
 .. ;E  I '$D(DTOUT),'$D(DUOUT) W !!,$C(7),"Disposition Hospital Location is required." G DISPASK
 .. E  W !!,$C(7),"Disposition Hospital Location is required." G DISPASK
 I $G(VSIT("LOC"))'>0 S VSIT("IEN")=-1
 E  D ^VSIT
 Q
 ;
ACTIVPRV(PROVIDER,VISITDT) ;See if this is a good provider on the date of
 ;VISITDT and returns 1 if it is 0 if it is not.
 ;Can be used like S DIC("S")="I $$ACTIVPRV^PXAPIUTL(PRV,DATE)"
 Q:+$$PRVCLASS^PXAPIUTL($G(PROVIDER),$G(VISITDT))>0 1
 Q 0
 ;
PRVCLASS(PROVIDER,VISITDT) ;See if this is a good provider
 ;See PRVCLASS^PXAPIUTL for parameters and return values.
 Q $$PRVCLASS^PXAPIUTL($G(PROVIDER),$G(VISITDT))
 ;
