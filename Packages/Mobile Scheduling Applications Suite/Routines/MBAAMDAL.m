MBAAMDAL ;OIT-PD/VSL - FILE ACCESS DAL ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1,7**;Feb 13, 2015;Build 16
 ;
GETREC(RETURN,IFN,FILE,FLDS,SFILES,INT,EXT,REZ,SD) ;
 ; Input Variables
 ; RETURN - RETURN results passed by reference
 ; IFN - Internal Entry Number to the Files passed in (File 2 or File 44)
 ; FILE - File #
 ; FLDS = Array of FLDS
 ; SFILES - Array of Sub-files
 ; INT - Internal values returned
 ; EXT - External values returned
 ; REZ - Resolve field names instead of those peck numbers
 ; SD - Date.Time if you only want one appointment in particular
 ;      Date if you want all appointment on a give date
 ;      or nothing if you want all appointments from today forward
 ;
 ; Get one record and specified subfiles from a file Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N STRF,FLD,FLAG,C,SFILE,IFLD,REC,SFLDN,SKIPSF
 S STRF=""
 S IFLD=""
 F  S IFLD=$O(FLDS(IFLD)) Q:IFLD=""  S STRF=STRF_$S(STRF="":"",1:";")_IFLD
 S SFILE=""
 ;
 ; want to skip subfile 2.98 so it can be done differently.  no need to pull in all appointments for a patient since the beginning of time.
 F  S SFILE=$O(SFILES(SFILE)) Q:SFILE=""  I $G(SFILES(SFILE,"F"))'=2.98 S STRF=STRF_$S(STRF="":"",1:";")_SFILE_"*"
 ;
 S FLD="",FLAG=""
 S:$G(INT) FLAG=FLAG_"I" ;Returns Internal values
 S:$G(EXT) FLAG=FLAG_"E" ;Returns External values
 S:$G(REZ) FLAG=FLAG_"R" ;Resolves field numbers to field names
 ;
 D GETS^DIQ(FILE,IFN,STRF,FLAG,"REC")
 ;
 I $G(SFILES(1900,"F"))=2.98 D GETRECA  ;  this one we'll treat differently cause it can be huge and want to use a screen
 ;
 F  S FLD=$O(REC(FILE,""_IFN_",",FLD)) Q:FLD=""  D
 . S:FLAG=""!(FLAG="R") RETURN(FLD)=REC(FILE,""_IFN_",",FLD)
 . S:FLAG["I" RETURN(FLD)=REC(FILE,""_IFN_",",FLD,"I")
 . S:FLAG["E" RETURN(FLD)=$S($L($G(RETURN(FLD)))>0:RETURN(FLD)_U,1:"")_REC(FILE,""_IFN_",",FLD,"E")
 ;
 S SFILE=""
 F  S SFILE=$O(SFILES(SFILE)) Q:SFILE=""  D
 . S SFLDN=$S(FLAG["R":SFILES(SFILE,"N"),1:SFILE)
 . D GETSREC(.RETURN,.REC,SFILES(SFILE,"F"),SFLDN,FLAG)
 K FLAG,FILE,STRF
 Q
 ;
GETSREC(RETURN,REC,SFILE,SFLD,FLAG) ; Get record subfile data Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT, MBAA PATIENT PENDING APPT
 N IDX,ID S FLD="",IDX=""
 F  S IDX=$O(REC(SFILE,IDX)) Q:IDX=""  D
 . F  S FLD=$O(REC(SFILE,IDX,FLD)) Q:FLD=""  D
 . . S ID=$P(IDX,",",1)
 . . S:FLAG=""!(FLAG="R") RETURN(SFLD,ID,FLD)=REC(SFILE,IDX,FLD)
 . . S:FLAG["I" RETURN(SFLD,ID,FLD)=REC(SFILE,IDX,FLD,"I")
 . . S:FLAG["E" RETURN(SFLD,ID,FLD)=$S($L($G(RETURN(SFLD,ID,FLD)))>0:RETURN(SFLD,ID,FLD)_U,1:"")_REC(SFILE,IDX,FLD,"E")
 . . N SI S SI=0
 . . F  S SI=$O(REC(SFILE,IDX,FLD,SI)) Q:SI=""!(SI="I")!(SI="E")  D
 . . . S RETURN(SFLD,ID,FLD,SI)=REC(SFILE,IDX,FLD,SI),RETURN(SFLD,ID,FLD)=""
 Q
 ;code below is not being used in the initial release of MBAA. It will be released at a later date in a future release of MBAA
 ;LSTSCOD(FILE,FIELD,LIST) ;List codes in SET OF CODE fields
 ; ;FILE = file number
 ; ;FIELD = field number
 ; ;LIST = output array:
 ; ;   LIST(#)=code^display_name
 ; N SET,NODE,CODE,NAME,I,COUNT
 ; S SET=$$GET1^DID(FILE,FIELD,,"POINTER")
 ; S COUNT=1
 ; F I=1:1:$L(SET,";") D
 ; . S NODE=$P(SET,";",I)
 ; . S CODE=$P(NODE,":")
 ; . Q:CODE=""
 ; . S NAME=$P(NODE,":",2)
 ; . S LIST(COUNT)=CODE_"^"_NAME
 ; . S COUNT=COUNT+1
 ; S LIST(0)=COUNT-1
 ; Q
 ;
GETRECA ;MBAA*1*7;will use SCREEN to get only the data that is needed from sub-file 2.98
 ; The orignal code pulled every appointment the patient ever had by doing one inquiry on the patient file.
 ; It returned so many that it had to store in a global and then parse the global to return everything > than yesterday
 ; and then potentially further parse when it gets back to calling routine which may have only wanted one to cancel
 ; Instead of one DIQ call on the patient, it has been changed to a LIST^DIC call using a SCREEN on the sub-file which gets just what you want.
 ;
 ; This was rewritten to get a specific appointment for cancellation (SD would be a date.time in FileMan format)
 ;  Or
 ; It will give everything on a certain date (SD will be just a date, no time)
 ;  Or
 ; everything from today forward if no date passed in
 ; 
 ; Will it ever want past appointments?
 ;
 N ERROR,TARGET,APT,IENS,LP,SCREEN
 S SCREEN=$$SCREEN($G(SD))
 S IENS=","_IFN_","
 D LIST^DIC(2.98,IENS,".001;@","EI",,,,,SCREEN,,"TARGET","ERROR")
 ;
 ; returns something like this so loop through it
 ;TARGET("DILIST",0)="97^*^0^"
 ;TARGET("DILIST",2,1)=3140826.09
 ;TARGET("DILIST",2,2)=3140925.1
 ;TARGET("DILIST",2,3)=3141023.08
 ;
 ; Make sure we have a bite
 I '$D(TARGET("DILIST",2,1)) Q
 ;
 ; Now, loop through that list and get the deets
 S LP=0 F  S LP=$O(TARGET("DILIST",2,LP)) Q:LP=""  D
 . S IENS=TARGET("DILIST",2,LP)_","_IFN_","
 . K APT   ; mant to make sure it's clean going in
 . D GETS^DIQ(2.98,IENS,"*",FLAG,"APT")    ; might need to revisit the * but maybe not.  GETREC above also grabs all fields in a subfile.
 . M REC=APT  ; save off the appointment it's returning
 Q
 ;
SCREEN(SD) ;
 ; SCREEN will either be I Y=SD (FileMan format)
 ; or I $P(Y,".")=SD
 ; or I Y>(TODAY - 1 second) (FileMan Format)
 I $P($G(SD),".",2) Q "I Y="_SD
 I $G(SD) Q "I $P(Y,""."")="_SD
 Q "I Y>"_$$FMADD^XLFDT(DT,0,0,0,-1)
