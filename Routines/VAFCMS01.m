VAFCMS01 ;BP-CIOFO/JRP - ADMISSION RETRANSMISSION;8/3/1998
 ;;5.3;Registration;**209**;Aug 13, 1993
 ;
LISTMAN ;Entry point for ListMan interface to transmit admission data
 ;Input  : None
 ;Output : None
 ;
 N DFN,VALMBEG,VALMEND
AGAIN ;Get patient
 S DFN=$$GETDFN()
 Q:(DFN<0)
 I ('$D(^DGPM("APTT1",DFN))) W !!,"** No admissions on file **",!! G AGAIN
 ;Call ListMan
 D EN^VALM("VAFC ADMISSION TRANSMISSION")
 ;Done
 Q
 ;
GETDFN() ;Get pointer to PATIENT file (#2)
 ;Input  : None
 ;Output : DFN - Pointer to PATIENT file (#2)
 ;         -1  - No entry selected
 ;
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^DPT("
 S DIC(0)="AEMNQZ"
 D ^DIC
 Q +Y
 ;
HEADER ;Build header
 ;Input  : DFN - Pointer to PATIENT file (#2)
 ;         VALMEND - Ending date range (FileMan)
 ;                   Defaults to Today
 ;         VALMBEG - Beginning date range (FileMan)
 ;                   Defaults to VALMEND-45
 ;Output : VALMHDR(x) = Line of text in header
 ;Notes  : VALMBEG & VALMEND will be defined on ouput
 ;
 ;Check input
 Q:('$G(DFN))
 Q:('$D(^DPT(DFN)))
 S VALMEND=$G(VALMEND,$$DT^XLFDT())
 S VALMBEG=$G(VALMBEG,$$FMADD^XLFDT(VALMEND,-45))
 ;Declare variables
 N LINE,TMP,VA,VAPTYP,VAERR
 D PID^VADPT6
 Q:(VAERR)
 S TMP="Admissions for "_$P(^DPT(DFN,0),"^",1)
 S TMP=TMP_" ("_VA("PID")_")"
 S LINE=TMP
 S TMP=$L(LINE)
 S VALMHDR(1)=$$SETSTR^VALM1(LINE,"",(40-(TMP\2)),TMP)
 S TMP=$$FMTE^XLFDT(VALMBEG,"1D")
 S TMP=TMP_" through "_$$FMTE^XLFDT(VALMEND,"1D")
 S LINE=TMP
 S TMP=$L(LINE)
 S VALMHDR(2)=$$SETSTR^VALM1(LINE,"",(40-(TMP\2)),TMP)
 Q
 ;
ENTRY ;Build display list of admissions for given patient in given time frame
 ;Input  : DFN - Pointer to PATIENT file (#2)
 ;         VALMEND - Ending date range (FileMan)
 ;                   Defaults to Today
 ;         VALMBEG - Beginning date range (FileMan)
 ;                   Defaults to VALMEND-45
 ;Output : @VALMAR@(x) = Line of text in ListMan display
 ;         @VALMAR@("IDX",x,y) = ""  (Index array for entry selection)
 ;Notes  : VALMBEG & VALMEND will be defined on ouput
 ;
 ;Check input (strip time from VALMEND & VALMBEG)
 Q:('$G(DFN))
 Q:('$D(^DPT(DFN)))
 S VALMEND=$G(VALMEND,$$DT^XLFDT())
 S VALMEND=$P(VALMEND,".",1)
 S VALMBEG=$G(VALMBEG,$$FMADD^XLFDT(VALMEND,-45))
 S VALMBEG=$P(VALMBEG,".",1)
 ;Declare variables
 N MOVEPTR,DATE,MOVENODE,TMP,LINE,ENTRY,NODE,INVBEG
 D CLEAN^VALM10
 S VALMCNT=1
 S VALMBG=1
 S ENTRY=0
 S INVBEG=9999999.9999999-VALMBEG
 S INVBEG=$P(INVBEG,".",1)
 ;Loop through admissions for patient
 S DATE=9999999.9999999-VALMEND
 S DATE=$P(DATE,".",1)
 F  S DATE=+$O(^DGPM("ATID1",DFN,DATE)) Q:(('DATE)!($P(DATE,".",1)>INVBEG))  D
 .S MOVEPTR=""
 .F  S MOVEPTR=+$O(^DGPM("ATID1",DFN,DATE,MOVEPTR)) Q:('MOVEPTR)  D
 ..S MOVENODE=$G(^DGPM(MOVEPTR,0))
 ..Q:('(+MOVENODE))
 ..S LINE=""
 ..;Increment choice number
 ..S ENTRY=ENTRY+1
 ..S LINE=$$SETFLD^VALM1(ENTRY,LINE,"ENTRY")
 ..;Movement date/time
 ..S TMP=$$FMTE^XLFDT(+MOVENODE)
 ..S LINE=$$SETFLD^VALM1(TMP,LINE,"DATE")
 ..;Movement type
 ..S TMP=+$P(MOVENODE,"^",4)
 ..S NODE=$G(^DG(405.1,TMP,0))
 ..S TMP=$P(NODE,"^",7)
 ..S:(TMP="") TMP=$P(NODE,"^",1)
 ..S LINE=$$SETFLD^VALM1(TMP,LINE,"MOVEMENT")
 ..;Ward
 ..S TMP=+$P(MOVENODE,"^",6)
 ..S NODE=$G(^DIC(42,TMP,0))
 ..S TMP=$P(NODE,"^",1)
 ..S LINE=$$SETFLD^VALM1(TMP,LINE,"WARD")
 ..;Add entry to display & index and increment line count
 ..D SET^VALM10(VALMCNT,LINE,ENTRY)
 ..S @VALMAR@("INDEX",ENTRY)=MOVEPTR
 ..S VALMCNT=VALMCNT+1
 ..Q
 .Q
 ;Decrement line count by one
 S VALMCNT=VALMCNT-1
 ;No admissions within date range
 I ('ENTRY) D
 .S @VALMAR@(1,0)=""
 .S LINE="** NO ADMISSIONS FOUND WITHIN GIVEN DATE RANGE **"
 .S:('$D(^DGPM("APTT1",DFN))) LINE="** NO ADMISSIONS ON FILE **"
 .S TMP=$L(LINE)
 .S @VALMAR@(2,0)=$$SETSTR^VALM1(LINE,"",(40-(TMP\2)),TMP)
 .S VALMCNT=1
 Q
 ;
EXIT ;Clean-up ListMan variables
 D CLEAN^VALM10
 ;Return to full screen mode
 D FULL^VALM1
 Q
 ;
 ; --- LISTMAN PROTOCOLS ---
 ;
DATE ;Change date range
 ;Input  : Variables set by ListMan
 ;Output : None
 ;Notes  : VALMBEG & VALMEND will be updated with the new date range
 ;
 ;Declare variables
 N VALMB,OLDBEG,OLDEND
 ;Remember current date range
 S OLDBED=VALMBEG
 S OLDEND=VALMEND
 ;Switch to full screen mode
 D FULL^VALM1
 ;Prompt for new date range (default begin date is T-45)
 S VALMB=$$FMADD^XLFDT($$DT^XLFDT(),-45)
 D RANGE^VALM1
 ;New date range not entered
 I (('VALMBEG)!('VALMEND)) D  Q
 .S VALMBEG=OLDBED
 .S VALMEND=OLDEND
 .S VALMBCK="R"
 ;Rebuild header
 D HEADER
 ;Rebuild display
 D ENTRY
 ;Done
 S VALMBCK="R"
 Q
 ;
XMIT ;Select and transmit admission from list
 ;Input  : Variables set by ListMan
 ;         DFN - Pointer to PATIENT file (#2)
 ;Output : None
 ;Notes  : Entry for selected admission will be found/created in
 ;         ADT/HL7 PIVOT file (#391.71) and then transmitted
 ;
 ;Declare variables
 N VALMY,ENTRY,MOVEPTR,PIVOTNUM,PIVOT,DATE,VPTR,DIR,X,Y
 ;Switch to full screen mode
 D FULL^VALM1
 ;Prompt for selection
 D EN^VALM2(XQORNOD(0),"SO")
 ;Loop through selections
 S ENTRY=0
 F  S ENTRY=+$O(VALMY(ENTRY)) Q:('ENTRY)  D
 .;Convert selection number to PATIENT MOVEMENT file pointer
 .S MOVEPTR=+$G(@VALMAR@("INDEX",ENTRY))
 .;Get date/time of admission
 .S DATE=+$G(^DGPM(MOVEPTR,0))
 .I ('DATE) D  Q
 ..W !!,"** UNABLE TO TRANSMIT ENTRY NUMBER ",ENTRY," **"
 ..W !,"   COULD NOT FIND ENTRY IN PATIENT MOVEMENT FILE"
 ..W !!
 ..S DIR(0)="EA",DIR("A")="Press RETURN to continue: " D ^DIR
 .;Create/find entry in ADT/HL7 PIVOT file (call returns pivot number)
 .S VPTR=MOVEPTR_";DGPM("
 .S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,DATE,1,VPTR)
 .I ('PIVOTNUM) D  Q
 ..W !!,"** UNABLE TO TRANSMIT ENTRY NUMBER ",ENTRY," **"
 ..W !,"   UNABLE TO CREATE/FIND ENTRY IN ADT/HL7 PIVOT FILE"
 ..W !!
 ..S DIR(0)="EA",DIR("A")="Press RETURN to continue: " D ^DIR
 .;Convert pivot number to pointer
 .S PIVOTPTR=+$O(^VAT(391.71,"D",PIVOTNUM,0))
 .I ('PIVOTPTR) D  Q
 ..W !!,"** UNABLE TO TRANSMIT ENTRY NUMBER ",ENTRY," **"
 ..W !,"   COULD NOT FIND ENTRY IN ADT/HL7 PIVOT FILE"
 ..W !!
 ..S DIR(0)="EA",DIR("A")="Press RETURN to continue: " D ^DIR
 .;Queue retransmission
 .D RETRAN^VAFCMS02(PIVOTPTR)
 .W !,"Entry number ",ENTRY," queued for transmission"
 .S DIR(0)="EA",DIR("A")="Press RETURN to continue: " D ^DIR
 S VALMBCK="R"
 Q
 ;
NEWDFN ;Change patient
 ;Input  : Variables set by ListMan
 ;         DFN - Pointer to PATIENT file (#2)
 ;Output : None
 ;Notes  : DFN will be updated with the newly selected patient
 ;       : VALMBEG & VALMEND will not be modified
 ;
 ;Declare variables
 N OLDDFN
 ;Switch to full screen mode
 D FULL^VALM1
 ;Remember current DFN
 S OLDDFN=DFN
 ;Prompt for patient
 S DFN=$$GETDFN()
 ;New patient not selected
 I (DFN<0) S DFN=OLDDFN S VALMBCK="R" Q
 ;Rebuild header
 D HEADER
 ;Rebuild display
 D ENTRY
 ;Done
 S VALMBCK="R"
 Q
