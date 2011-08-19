TIUPUTSX ; SLC/MAM - Uploading Op Reports to SURGERY file #130 ;11/15/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**129**;Jun 20, 1997
 ; External References in TIUPUTSX:
 ;   DBIA 3477 ^SRF
LOOKUP ; Upload Lookup Method for Document Definition Operative Report
 ; -- Requires lookup variables TIUSRCN, TIUSSN, & TIUODT --
 ;These contain the transcribed data needed by the Lookup Method
 ;to look up the desired target record in the SURGERY file, and to
 ;check that the record is consistent with at least one other item
 ;of transcribed data.
 ;Lookup variables must be listed in the Op Report Upload Header
 ;Definition. They are set to their corresponding transcribed values
 ;in GETREC^TIUPUTC1.
 ; -- Sets Y= SURGERY record CASE NUMBER (the .001 field in the SURGERY
 ;    file, #130) --
 N DFN,TIUSR0
 ; -- If lookup variable values are invalid or missing from
 ;    transcription, set Y = -1 and quit --
 I $S('$D(TIUSSN):1,$G(TIUSRCN)']"":1,$G(TIUSSN)?4N:1,$G(TIUSSN)']"":1,$G(TIUODT)'>0:1,1:0) S Y=-1 G LOOKUPX
 I TIUSSN?3N1P2N1P4N.E S TIUSSN=$TR(TIUSSN,"-/","")
 I TIUSSN["?" S Y=-1 G LOOKUPX
 ; -- Kill unwanted field nodes of header caption array --
 ;After this lookup (in STUFREC^TIUPUTC), the software uses array
 ;TIUHDR to try to file transcribed data for ALL captions which
 ;specify field numbers in the Upload Header Definition.  Since some
 ;of these transcribed data may not be accurate, it is important NOT to
 ;file them unless they are intended for filing. (They may be included
 ;in the transcription for administrative purposes, or to help
 ;look up the correct target record, but NOT BE INTENDED for filing.)
 ;Since one can't know what captions sites may mistakenly have 
 ;attributed field numbers to, it may be best to save out any nodes
 ;that are intended for filing, kill the whole array, and then
 ;replace the saved nodes. For Op Reports, NO fields are intended for
 ;filing (except the text field, of course), so we kill ALL nodes
 ;of TIUHDR.
 K TIUHDR
 ; -- Get the 0-node of the SURGERY record which corresponds to
 ;    the transcribed CASE NUMBER --
 S TIUSR0=$G(^SRF(TIUSRCN,0))
 ; -- Get the patient that corresponds to transcribed SSN --
 S DFN=+$$PATIENT^TIULA(TIUSSN)
 ; -- Confirm that the patient from the SURGERY record matches
 ;    the patient from the transcribed SSN --
 I +TIUSR0'=DFN S Y=-1 G LOOKUPX
 ; -- Confirm that the transcribed OPERATION DATE matches the OPERATION
 ;DATE from the SURGERY record --
 I $$IDATE^TIULC(TIUODT)'=$P($P(TIUSR0,U,9),".") S Y=-1 G LOOKUPX
 ; -- If the data are consistent, set Y = transcribed CASE NUMBER,
 ;(the .001 field in the SURGERY file) --
 S Y=TIUSRCN
LOOKUPX Q
FIX ; Filing Error Resolution Code for Docmt Def Operative Report
 ; -- Called by MRT Review Filing Events option (FILERR^TIURE)
 ;    if BUFDA exists; otherwise called from an alert
 ;    (DISPLAY^TIUPEVNT).  Warning: XQADATA may be left around
 ;    from a PREVIOUS alert, so don't use it's existence to
 ;    determine how this was called. --
 ;    
 N TIUOK,TIUOUT,X,Y,SURGDA,RETRY,DIC,DWPK,TIUBUF,TIUERRDA
 N ECHO,TIUSR0
 ; -- Inquire to SURGERY file and let user select the correct
 ;    target record --
 F  D  Q:+$G(TIUOUT)!$G(TIUOK)
 . N DIC,X,Y,DA,DIQ
 . W ! S DIC=130,DIC(0)="AEMNQ"
 . S DIC("A")="Select Patient or Surgery Case Number: "
 . D ^DIC I +Y'>0 S TIUOUT=1 W !,"OK, you can try again later" Q
 . ; -- Show user the selected record in its entirety and get
 . ;    user's confirmation --
 . S (DA,SURGDA)=+Y,DIQ(0)="R" ; Show case number
 . W ! D EN^DIQ
 . S TIUOK=$$READ^TIUU("Y","... Is this the correct Surgery record","YES","^D RECDHELP^TIUPUTSX")
 . I $D(DIRUT) S TIUOUT=1 W !,"OK, you can try again later"
 ; -- Quit if user has not selected and confirmed a record --
 I '$G(TIUOK) G FIXEXIT
 ; -- Present user with correct header data corresponding to
 ;    selected record --
 W !!,"To file the transcribed Surgeon's Dictation into the Surgery record you have"
 W !,"just selected, you will need to correct the upload data in its temporary"
 W !,"storage place, and then try again to file it."
 S TIUSR0=$G(^SRF(SURGDA,0))
 ; -- Force $$NAME,SSN^TIULO to reinitialize pt demographics --
 N VADM,VA,VAERR
 W !!,"The stored upload header data for ",$$NAME^TIULS($$NAME^TIULO(+TIUSR0),"LAST,FIRST MI")
 W !,"should be corrected to read:"
 W !!,"PATIENT SSN:",?20,$$SSN^TIULO(+TIUSR0)
 W !,"CASE NUMBER:",?20,SURGDA
 W !,"OPERATION DATE:",?20,$$DATE^TIULS($P($P(TIUSR0,U,9),".")),!
 ; -- Note: We did NOT present the patient name in the data (above)
 ;    that should be corrected.  The patient name tends to be ambiguous
 ;    and is not used in the Lookup Method, so we don't wish to imply
 ;    that it IS used --
 I '$$READ^TIUU("EA","Press RETURN to continue...") W !,"OK, you can try again later" G FIXEXIT
 ; -- Get 8925.2 Buffer IFN and 8925.4 Upload Log Event IFN from
 ;    calling routine TIURE or TIUPEVNT --
 I +$G(BUFDA) S TIUBUF=+BUFDA,TIUERRDA=+$G(ERRDA)
 I '$G(BUFDA),+$G(XQADATA) S TIUBUF=+$G(XQADATA),TIUERRDA=+$P(XQADATA,";",3)
 I '$G(TIUBUF)!'$G(TIUERRDA) W !,"Can't find stored upload record; see IRM" H 5 G FIXEXIT
 I '$G(TIUERRDA) S TIUERRDA=0
 ; -- Let user correct the header data in the TIU UPLOAD BUFFER file
 ;   entry, and then try (again) to file it in the SURGERY file --
 W !!,"You may now correct the stored upload data."
 S DIC="^TIU(8925.2,"_+TIUBUF_",""TEXT"",",DWPK=1 D EN^DIWE
 S RETRY=$$READ^TIUU("YO","Are you ready to file this data in the Surgery file","YES","^D FILEHELP^TIUPUTSX")
 ; -- Delete current filing error alert, mark the current error
 ;    resolved in the TIU UPLOAD LOG file, and try to file the data
 ;    from the corrected TIU UPLOAD BUFFER file entry into
 ;    the SURGERY file. (If data fails to file again, a NEW alert is
 ;    generated during that process.) --
 I 'RETRY W !,"OK, you can try again later." G FIXEXIT
 S ECHO=1 ; Will write "Filing Record//Resolving Error..."
 D ALERTDEL^TIUPEVNT(TIUBUF),RESOLVE^TIUPEVNT(TIUERRDA,ECHO),FILE^TIUUPLD(TIUBUF)
 I $G(BUFDA),'$G(TIUDONE) W !,"Old error marked resolved; new error created.  New error may take several more",!,"seconds to file, and may not be within current date/time range.",! H 5 ; Feedback for MRT option
FIXEXIT ;
 ; -- Set variables to go to exit for DISPLAY^TIUPEVNT
 ;    or FILERR^TIURE immediately upon return from this resolve
 ;    code.  (Everything they do after executing the resolve code
 ;    has been incorporated INTO THIS CODE.)
 K EVNTDA S TIUDONE=1
 Q
 ;
RECDHELP ;Help for correct record prompt
 W !,"Is this the Surgery record you wish to upload the transcribed data into?"
 W !,"If not, answer NO and select a different record, or enter '^' to come back",!,"and resolve the filing error later."
 Q
FILEHELP ;Help for retrying the upload filer prompt
 W !,"If you are sure that you have identified the correct Surgery record, and have"
 W !,"corrected the stored header data accordingly, then answer YES to try again"
 W !,"to upload the data into the Surgery record."
 W !,"If you answer NO, the corrected data will remain in temporary storage,"
 W !,"the filing error alert will remain in place, and you can attempt to resolve"
 W !,"the alert later."
 Q
