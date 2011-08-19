SCDXRT02 ;ALB/JRP - RETRANSMIT REJECTS FROM NPCDB;15-OCT-1996
 ;;5.3;Scheduling;**68**;AUG 13, 1993
 ;
EN ;Entry point for List Manager display
 D EN^VALM("SCDX RETRAN REJECTS FROM NPCDB")
 Q
 ;
HEADER ;Entry point for building header List Manager header
 ;Input  : Variables as set by List Manager interface
 ;Output : Header for List Manager screen
 ;
 ;Declare variables
 N TMP,SPOT
 ;Build header
 S TMP="Patients whose encounter data has been rejected by the National"
 S SPOT=40-($L(TMP)\2)
 S VALMHDR(1)=$$INSERT^SCDXUTL1(TMP,"",SPOT)
 S TMP="Patient Care Database and not currently marked for retransmission"
 S SPOT=40-($L(TMP)\2)
 S VALMHDR(2)=$$INSERT^SCDXUTL1(TMP,"",SPOT)
 S TMP="(Entries marked by '*' will be flagged for retransmission on exit)"
 S SPOT=40-($L(TMP)\2)
 S VALMHDR(3)=$$INSERT^SCDXUTL1(TMP,"",SPOT)
 Q
 ;
INIT ;Entry point for building List Manager display & indexes
 ;Input  : Variables as set by List Manager interface
 ;Output : List Manager display
 ;           VALMAR(Line,0) = Line to display
 ;         Indexes
 ;           VALMAR("ENTRIES") = Total number of entries
 ;           VALMAR("LINES") = Total number of lines
 ;           VALMAR("ENTRY2DFN",Entry) = DFN of entry
 ;           VALMAR("DFN",DFN,XmitPtr) = Patient's name
 ;              XmitPtr => Pointer to TRANSMITTED OUTPATIENT
 ;                         ENCOUNTER file (#409.73)
 ;           VALMAR("NAME",Name) = DFN ^ Total encounters rejected
 ;
 ;Declare variables
 N SPOT,COL4ENT,LINE4ENT,TOTENTRY,DATA,ENTRY,DFN,NAME,NAMEID,VA,BS,VAERR
 ;Initialize global locations being used
 K @VALMAR
 ;Get array of all rejections not currently marked for [re]transmission
 W !!
 W !,"Building list of patients who have encounters that were rejected by"
 W !,"the National Patient Care Database and are not currently marked for"
 W !,"retransmission.  This list only includes demographic and other non-"
 W !,"encounter related errors."
 S TOTENTRY=+$$GETREJ^SCDXUTL4(VALMAR,3,20)
 I (TOTENTRY<1) D  Q
 .;No rejections on file - print message and quit
 .W !!,"No demographic rejections requiring retransmission are currently on file.",!
 .K @VALMAR
 .H 2
 .S VALMQUIT=1
 ;Determine total number of lines that will be in display
 ; (this is also the last entry number of column 1)
 S VALMCNT=TOTENTRY\2
 S:(TOTENTRY#2) VALMCNT=VALMCNT+1
 ;Remember total number of entries and lines
 S @VALMAR@("ENTRIES")=TOTENTRY
 S @VALMAR@("LINES")=VALMCNT
 ;Build display
 W !!,"Building display screen "
 S ENTRY=1
 ; string of blank characters
 S BS="",$P(BS," ",25)=""
 ; Loop through name index of rejection array
 S NAME=""
 F  S NAME=$O(@VALMAR@("NAME",NAME)) Q:(NAME="")  D
 .;Write a dot for every 10 entries
 .W:('(ENTRY#10)) "."
 .;Get DFN
 .S DFN=+$G(@VALMAR@("NAME",NAME))
 .D PID^VADPT6
 .;Determine which column & line to put entry in
 .S COL4ENT=(ENTRY>VALMCNT)+1
 .S LINE4ENT=ENTRY
 .S:(ENTRY>VALMCNT) LINE4ENT=ENTRY-VALMCNT
 .;Get data currently stored in display
 .S DATA=$G(@VALMAR@(LINE4ENT,0))
 .;Insert entry number
 .S SPOT=5-$L(ENTRY)
 .S:(COL4ENT=2) SPOT=43-$L(ENTRY)
 .S DATA=$$INSERT^SCDXUTL1(ENTRY,DATA,SPOT)
 .;Insert patient name truncated to 20 characters, then BID
 .S SPOT=6
 .S:(COL4ENT=2) SPOT=44
 .S NAMEID=$E(NAME_BS,1,20)_$S(VA("BID")]"":"  ("_VA("BID")_")",1:"")
 .S DATA=$$INSERT^SCDXUTL1(NAMEID,DATA,SPOT)
 .;Put data back into display
 .S @VALMAR@(LINE4ENT,0)=DATA
 .;Store data into indexes
 .S @VALMAR@("ENTRY2DFN",ENTRY)=DFN
 .S @VALMAR@("DFN2ENTRY",DFN)=ENTRY
 .;Increment entry number
 .S ENTRY=ENTRY+1
 ;Done
 S VALMBG=1
 Q
 ;
MARK(RESET) ;Entry point to prompt user for entry numbers to mark/unmark
 ; for retransmission
 ;
 ;Input  : RESET - Flag denoting which process to execute
 ;                 0 = Mark entry for retransmission (default)
 ;                 1 = Unmark entry for retransmission
 ;         Variables as set by List Manager interface
 ;Output : None
 ;         The following index is set when marking an entry
 ;            VALMAR("MARKED",Entry) = ""
 ;         This index is deleted when unmarking an entry
 ;         The List Manager display is updated accordingly  
 ;Note   : Marking/unmarking is done only in the context of the List
 ;         Manager display
 ;
 ;Check input
 S RESET=+$G(RESET)
 ;Declare variables
 N ENTRY,SELECT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;Switch to full screen
 D FULL^VALM1
 ;Prompt user for selection(s)
 S X=+$O(@VALMAR@("ENTRY2DFN",""))
 S Y=+$O(@VALMAR@("ENTRY2DFN",""),-1)
 S DIR(0)="LAO^"_X_":"_Y_":0"
 S DIR("A")="Select "_VALM("ENTITY")_"(s)  ("_X_"-"_Y_"): "
 S DIR("?",1)="     Select the patient(s) whose rejected encounters you want "_$S(RESET:"un",1:"")_"marked"
 S DIR("?")="     for retransmission to the National Patient Care Database"
 D ^DIR
 I $D(DIRUT) S VALMBCK="R" Q
 ;Move selections from Y into SELECT - parse main output of DIR
 ; into individual entries in SELECT() array
 M SELECT=Y
 F X=1:1 S Y=$P(SELECT(0),",",X) Q:('Y)  S SELECT(Y)=""
 K SELECT(0)
 ;Loop through selected entries
 S ENTRY=0
 F  S ENTRY=+$O(SELECT(ENTRY)) Q:('ENTRY)  D
 .;Mark/unmark entry for retransmission
 .D MARKIDX(ENTRY,RESET)
 ;Done
 S VALMBCK="R"
 Q
 ;
MARKPT(RESET) ; Entry point to prompt user for patients to mark/unmark
 ; for retransmission
 ;
 ; (see description of input/output for MARK call)
 ;
 S RESET=+$G(RESET)
 ;Declare variables
 N ENTRY,DA,DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,VAUTN
 ;Switch to full screen
 D FULL^VALM1
 ;Prompt user for selection(s) via VAUTOMA
 S VAUTNI=2
 S DIC("S")="I $D(@VALMAR@(""DFN2ENTRY"",+Y))"
 D PATIENT^VAUTOMA
 I Y<0 S VALMBCK="R" Q
 I VAUTN=1 D MARKALL(RESET)
 ;Loop through selected entries
 S DFN=0
 F  S DFN=+$O(VAUTN(DFN)) Q:('DFN)  D
 .S ENTRY=$G(@VALMAR@("DFN2ENTRY",DFN)) Q:'ENTRY
 .;Mark/unmark entry for retransmission
 .D MARKIDX(ENTRY,RESET)
 ;Done
 S VALMBCK="R"
 Q
 ;
MARKALL(RESET) ;Entry point to mark all entries for retransmission
 ;
 ;Input  : RESET - Flag denoting which process to execute
 ;                 0 = Mark entry for retransmission (default)
 ;                 1 = Unmark entry for retransmission
 ;         Variables as set by List Manager interface
 ;Output : None
 ;         The following index is set when marking an entry
 ;            VALMAR("MARKED",Entry) = ""
 ;         This index is deleted when unmarking an entry
 ;         The List Manager display is updated accordingly  
 ;Note   : Marking/unmarking is done only in the context of the List
 ;         Manager display
 ;
 ;Check input
 S RESET=+$G(RESET)
 ;Declare variables
 N ENTRY
 ;Loop through all entries in entry & DFN index
 S ENTRY=""
 F  S ENTRY=+$O(@VALMAR@("ENTRY2DFN",ENTRY)) Q:('ENTRY)  D
 .;Mark/unmark for retransmission
 .D MARKIDX(ENTRY,RESET)
 ;Done
 S VALMBCK="R"
 Q
 ;
MARKIDX(ENTRY,RESET) ;Entry point to mark/unmark an entry for retransmission
 ;
 ;Input  : ENTRY - Entry number in display to mark/unmark
 ;         RESET - Flag denoting which process to execute
 ;                 0 = Mark entry for retransmission (default)
 ;                 1 = Unmark entry for retransmission
 ;         Variables as set by List Manager interface
 ;Output : None
 ;         The following index is set when marking an entry
 ;            VALMAR("MARKED",Entry) = ""
 ;         This index is deleted when unmarking an entry
 ;         The List Manager display is updated accordingly  
 ;Note   : Marking/unmarking is done only in the context of the List
 ;         Manager display
 ;
 ;Check input
 S ENTRY=+$G(ENTRY)
 Q:(ENTRY<1)
 Q:('$D(@VALMAR@("ENTRY2DFN",ENTRY)))
 S RESET=+$G(RESET)
 ;Declare variables
 N TMP,COL4ENT,LINE4ENT,DATA,SPOT
 ;Set index
 S:('RESET) @VALMAR@("MARKED",ENTRY)=""
 ;Delete index
 K:(RESET) @VALMAR@("MARKED",ENTRY)
 ;Update display
 ; Determine which column & line to put entry in
 S TMP=+$G(@VALMAR@("LINES"))
 S COL4ENT=(ENTRY>TMP)+1
 S LINE4ENT=ENTRY
 S:(ENTRY>TMP) LINE4ENT=ENTRY-TMP
 ;Get data currently stored in display
 S DATA=$G(@VALMAR@(LINE4ENT,0))
 ;Put/remove retransmission mark
 S SPOT=1
 S:(COL4ENT=2) SPOT=39
 S TMP="*"
 S:(RESET) TMP=" "
 S DATA=$$INSERT^SCDXUTL1(TMP,DATA,SPOT)
 ;Put data back into display
 S @VALMAR@(LINE4ENT,0)=DATA
 ;Done
 Q
 ;
CLEANUP ;Entry point for cleaning up
 ;
 ;Input  : Variables as set by List Manager interface
 ;Output : None
 ;
 ;Declare variables
 N ENTRY,DFN,XMITPTR
 ;Switch to full screen
 D FULL^VALM1
 W !
 W !,"Rejected encounters for the selected patient(s) will now be"
 W !,"marked for retransmission "
 ;Loop through index of marked entries
 S ENTRY=""
 F  S ENTRY=+$O(@VALMAR@("MARKED",ENTRY)) Q:('ENTRY)  D
 .;Get DFN for entry
 .S DFN=+$G(@VALMAR@("ENTRY2DFN",ENTRY))
 .Q:('DFN)
 .;Loop through index of all entries in TRANSMITTED OUTPATIENT
 .; ENCOUNTER file (#409.73) for DFN
 .S XMITPTR=""
 .F  S XMITPTR=+$O(@VALMAR@("DFN",DFN,XMITPTR)) Q:('XMITPTR)  D
 ..;Mark entry for retransmission
 ..D STREEVNT^SCDXFU01(XMITPTR,0)
 ..;Turn on transmission flag
 ..D XMITFLAG^SCDXFU01(XMITPTR)
 ..W "."
 ;Done - clean up global location used and quit
 K @VALMAR
 Q
