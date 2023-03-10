PXAPI ;ISL/dee,PKR - PCE's APIs ;07/13/2021
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**15,14,27,28,124,164,210,211,217**;Aug 12, 1996;Build 134
 Q
 ;
GMPARAMS(FILENUM,IEN) ;Return the measurement parameters for the
 ;FILENUM and IEN.
 N MNODE
 S MNODE=$S(FILENUM=9999999.09:$G(^AUTTEDT(IEN,220)),FILENUM=9999999.15:$G(^AUTTEXAM(IEN,220)),FILENUM=9999999.64:$G(^AUTTHF(IEN,220)),1:"")
 Q MNODE
 ;
PROVNARR(PXPNAR,PXFILE,PXCLEX) ;Add or lookup external Provider Narrative.
 ;Input:
 ;  PXPNAR  Is the text of the provider narrative.
 ;  PXFILE  Is the file that the returned pointer will be stored in.
 ;          If a new entry is created then this tells the context
 ;          that it was created under by the file using it.
 ;  PXCLEX  Is an optional pointer to the Lexicon for this narrative.
 ;
 ;Returns:
 ;  Pointer to the provider narrative file ^ narrative
 ;  or pointer to the provider narrative file ^ narrative ^1
 ;  where 1 indicates that the entry has just been added
 ;  or -1 ^ PXPNAR if was unsuccessful.
 ;
 I PXPNAR="" Q -1
 I PXPNAR="-1" Q -1
 ;Provider narrative must be at least 2 characters.
 I $L(PXPNAR)<2 Q -1_U_PXPNAR
 N MSG,RESULT,X,Y
 S X=$E(PXPNAR,1,245)
 ;It is possible there may already be an invalid entry in the Provider
 ;Narrative file, if the user happens to select it, the lookup on the
 ;"B" index will return it so validate the input passes the input
 ;transform before the lookup.
 D VAL^DIE(9999999.27,"+1",.01,"EU",X,.RESULT,"","MSG")
 I RESULT="^" Q -1_U_X
 S Y=+$O(^AUTNPOV("B",X,""))
 I Y>0 Q Y_U_X
 ;
 ;Add a new entry.
 N FDA,FDAIEN
 S FDA(9999999.27,"+1,",.01)=X
 ;Make sure PXFILE is a valid file number.
 I $G(PXFILE)'="" D
 . N DATA
 . D FILE^DID(PXFILE,"","NAME","DATA","MSG")
 . I $G(DATA("NAME"))'="" S FDA(9999999.27,"+1,",75702)=PXFILE
 . K MSG
 D UPDATE^DIE("E","FDA","FDAIEN","MSG")
 I $D(MSG) Q -1_U_X
 ;If a pointer to file #757.01 was passed validate it.
 ;ICR #457
 I ($G(PXCLEX)'=""),($D(^LEX(757.01,PXCLEX,0))>0) D
 . K FDA,MSG
 . S FDA(9999999.27,FDAIEN(1)_",",75701)=PXCLEX
 . D FILE^DIE("","FDA","MSG")
 Q FDAIEN(1)_U_X_U_1
 ;
STOPCODE(PXASTOP,PXAPAT,PXADATE) ;This is the function call to return the
 ;quantity of a particular Stop Code for a patient on one day. ICR #1898
 ;Input
 ;  PXASTOP  (required) pointer to #40.7
 ;  PXAPAT   (required) pointer to #2
 ;  PXADATE  (required) the date in FileMan format
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
CPT(PXACPT,PXAPAT,PXADATE,PXAHLOC) ;This is the function call to return the
 ;quantity of a particular CPT for a patient on one day and for
 ;one hospital location if passed. ICR #1898
 ;Input
 ;  PXACPT  (required) pointer to #81
 ;  PXAPAT   (required) pointer to #2
 ;  PXADATE  (required) the date in FileMan format
 ;                     (time is ignored if passed)
 ;  PXAHLOC  (optional) pointer to #44
 ;Returns
 ; the count of how many (and quantity) of that CPT code are stored for
 ; that one day
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
INTV(WHAT,PACKAGE,SOURCE,VISIT,HL,DFN,APPT,LIMITDT,ALLHLOC) ;This API will
 ;prompt the user for Visit and related V-file data used to document
 ;an encounter. See INTV^PXBAPI for parameters and return values.
 ; ICR #1891
 ;
 I '($D(VISIT)#2) S VISIT=""
 I '($D(DFN)#2) S DFN=""
 I '($D(HL)#2) S HL=""
 ;
 Q $$INTV^PXBAPI(WHAT,PACKAGE,SOURCE,.VISIT,.HL,.DFN,$G(APPT),$G(LIMITDT),$G(ALLHLOC))
 ;
DELVFILE(WHICH,VISIT,PACKAGE,SOURCE,ASK,ECHO,USER,ERROR,PROBARR) ;Deletes the requested data
 ;related to the visit. See DELVFILE^PXAPIDEL for parameters and return
 ;values. ICR #1890
 ;
 Q $$DELVFILE^PXAPIDEL(WHICH,VISIT,$G(PACKAGE),$G(SOURCE),$G(ASK),$G(ECHO),$G(USER),.ERROR,.PROBARR)
 ;
DATA2PCE(DATA,PACKAGE,SOURCE,VISIT,USER,DISPLAY,ERROR,SCREEN,ARRAY,ACCOUNT) ;
 ;PI to pass data for add/edit/delete to PCE
 ;See DATA2PCE^PXAI for parameters and return values. ICR #1889
 ;
 I '($D(DATA)#2) Q -3
 I '($D(PACKAGE)#2) Q -3
 I '($D(SOURCE)#2) Q -3
 I '($D(VISIT)#2) S VISIT=""
 Q $$DATA2PCE^PXAI(DATA,PACKAGE,SOURCE,.VISIT,$G(USER),$G(DISPLAY),.ERROR,$G(SCREEN),.ARRAY,.ACCOUNT) ;PX*1.0*164 CHANGED $G(ERROR) TO .ERROR
 ;
SOURCE(SOURCE) ;Get IEN of data source in the PCE Data Source file
 ;ICR #1896
 Q $$SOURCE^PXAPIUTL($G(SOURCE))
 ;
VISITLST(DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--GATHER VISITS
 ;See VISITLST^PXBGVST for parameters and return values. ICR #1893
 ;
 I '($D(DFN)#2) Q "-2^NO PATIENT SELECTED"
 Q $$VISITLST^PXBGVST(DFN,$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
ENCEDIT(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--Ask for encounter the edit it of delete it
 ;See ENCEDIT^PXAPIEED for parameters and return values. ICR #1892
 ;
 Q $$ENCEDIT^PXAPIEED($G(WHAT),$G(PACKAGE),$G(SOURCE),$G(DFN),$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
LOPENCED(WHAT,PACKAGE,SOURCE,DFN,BEGINDT,ENDDT,HLOC,SCREEN,APPOINT,PROMPT,COSTATUS) ;--Ask for encounter the edit it of delete it
 ;See LOPENCED^PXAPIEED for parameters and return values. ICR #1892
 ;
 Q $$LOPENCED^PXAPIEED($G(WHAT),$G(PACKAGE),$G(SOURCE),$G(DFN),$G(BEGINDT),$G(ENDDT),$G(HLOC),$G(SCREEN),$G(APPOINT),$G(PROMPT),$G(COSTATUS))
 ;
GETENC(DFN,ENCDT,HLOC) ;--Get all of the encounter data
 ;See GETENC^PXKENC for parameters and return values. ICR #1894
 ;
 Q $$GETENC^PXKENC($G(DFN),$G(ENCDT),$G(HLOC))
 ;
ENCEVENT(VISIT,DONTKILL) ;--Get all of the encounter data
 ;See ENCEVENT^PXKENCOUNTER for parameters and return values. ICR #1894
 ;
 D ENCEVENT^PXKENCOUNTER($G(VISIT),$G(DONTKILL))
 Q
 ;
VST2APPT(VISIT) ;Is this visit related to an appointment
 ;See VST2APPT^PXUTL1 for parameters and return values. ICR #1895
 ;
 Q $$VST2APPT^PXUTL1($G(VISIT))
 ;
APPT2VST(DFN,ENCDT,HLOC) ;Get the visit for an Appointment
 ;See APPT2VST^PXUTL1 for parameters and return values. ICR #1895
 ;
 Q $$APPT2VST^PXUTL1($G(DFN),$G(ENCDT),$G(HLOC))
 ;
SWITCHD() ;This returns the date that PCE starts collecting the data
 ; instead Scheduling (switch over date). ICR #1897
 Q $P($G(^PX(815,1,0)),"^",2)
 ;
SWITCHCK(DATE) ;Returns 1 if after the switch over date 0 otherwise. ICR #1897
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
 ;VISITDT and returns 1 if it is 0 if it is not. ICR #2349
 ;Can be used like S DIC("S")="I $$ACTIVPRV^PXAPIUTL(PRV,DATE)"
 Q:+$$PRVCLASS^PXAPIUTL($G(PROVIDER),$G(VISITDT))>0 1
 Q 0
 ;
PRVCLASS(PROVIDER,VISITDT) ;See if this is a good provider
 ;See PRVCLASS^PXAPIUTL for parameters and return values. ICR #2349
 Q $$PRVCLASS^PXAPIUTL($G(PROVIDER),$G(VISITDT))
 ;
VIS(PXRESULT,PXVIS,PXDATE) ;Return Vaccine Information Statement entry
 ;See VIS^PXAPIIM for parameters and return values.
 ;
 I '$G(PXVIS) Q
 S PXDATE=$G(PXDATE,$$NOW^XLFDT())
 D VIS^PXAPIIM(.PXRESULT,PXVIS,PXDATE)
 Q
