TIUFWRAP2 ;SPFO/AJB - Clean File #8927 ;04/06/22  12:50
 ;;1.0;TEXT INTEGRATION UTILITIES;**338,254**;Jun 20, 1997;Build 9
 ;
 Q
 ;
FMR(DIR,PRM,DEF,HLP,SCR) ; fileman reader
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP) M DIR=HLP
 W $G(IOCUON) D ^DIR W $G(IOCUOFF)
 Q $S($D(DIROUT):U,$D(DIRUT):U,$D(DTOUT):U,$D(DUOUT):U,1:Y)
 ;
PRINT(LOC) ; print output
 Q:$G(LOC)=""
 N FIRST,ROOT S END="",FIRST=1,ROOT=$P(LOC,")"),LOC=$Q(@LOC)
 Q:LOC'[ROOT
 D:$E(IOST,1,2)="C-" CLS
 F  D  Q:(LOC="")!(END=U)
 . W:'+FIRST ! S FIRST=0
 . D BRK:$Y+4>IOSL Q:END=U  W @LOC S LOC=$Q(@LOC) S:'(LOC[ROOT) LOC=""
 Q:END=U
 I $E(IOST,1,2)="C-" S END=U D FMR("EA","Press <Enter> to continue ")
 Q
BRK ;
 I $E(IOST,1,2)="C-" S END=$$FMR("EA","Press <Enter> to continue or '^' to exit ")
 Q:END=U
CLS ;
 W:$E(IOST,1,2)="C-" @IOF
 Q
 ;
LOD(ANS) ; level of detail
 N DIR,HELP,PROMPT,X
 W @IOF,IOCUON,IOUON_$$CJ^XLFSTR("UPDATE TYPE [^TIU(8927,]",IOM)_IOUOFF,!
 S DIR="SA^1:BASIC;2:INTERMEDIATE;3:ADVANCED;Q:QUIT"
 N TMP S TMP="LODHELP^TIUFWRAP2"
 F X=1:1 S HELP=$P($T(LODHELP+X),";;",2) Q:HELP="EOM"  D
 . S HELP("?",X)=HELP
 . W !,HELP
 S HELP("?")=" ",PROMPT="What type of UPDATE would you like?  "
 W ! S ANS=$$FMR(DIR,PROMPT,"BASIC",.HELP)
 Q ANS
 ;
LODHELP ;
 ;;Basic            Attempt to fix broken fields/objects in boilerplate text.
 ;;
 ;;                 Delete entries with no boilerplate text, items, or linked
 ;;                 entries.
 ;;
 ;;                 Boilerplate text updates:  Remove trailing spaces
 ;;                                            Remove control characters
 ;;
 ;;Intermediate     Basic + wrap lines >80 characters*.
 ;;
 ;;Advanced         Basic + merge sequential lines of text**.
 ;;
 ;;* Please select HELP (** No, really!) on the main menu for more information.
 ;;EOM
 Q
 ;
HELP ;
 N CNT,LABEL,LINE,OUTPUT S CNT=1,OUTPUT(CNT)=""
 F LINE=1:1 S LABEL=$P($T(CONTENTS+LINE),";;",2) Q:LABEL="EOM"  D
 . S CNT=CNT+1,OUTPUT(CNT)=IOUON_$P(LABEL,U,2)_IOUOFF
 . D DATA(.CNT,"PART"_$P(LABEL,U))
 D BROWSE^DDBR("OUTPUT","NR","Help & Detailed Information")
 Q
 ;
CONTENTS ;
 ;;01^Introduction & Critical Information
 ;;02^Backing Up/Restoring File #8927
 ;;03^Updating File #8927
 ;;04^Viewing Entries
 ;;05^Print/Email Entries
 ;;EOM
 ;
DATA(CNT,OPT) ;
 N DATA,I F I=1:1 S DATA=$P($T(@OPT+I),";;",2) Q:DATA="EOM"  D
 . S CNT=CNT+1,OUTPUT(CNT)=DATA
 Q
 ;
DISPLAY(OPT) ; displays text from the parameter
 N DATA,I
 W:$D(IOF) @IOF
 F I=1:1 S DATA=$P($T(@OPT+I),";;",2) Q:DATA="EOM"  D
 . W:OPT="INFO" @DATA,!
 Q
 ;
INFO ;
 ;;IOUON_$$CJ^XLFSTR("TIU TEMPLATE (File #8927) Analysis & Cleanup Tool",IOM)_IOUOFF
 ;;""
 ;;"Critical Information:  A backup copy of the TIU TEMPLATE file has been created"
 ;;"                       for you and can be restored from the menu below."
 ;;""
 ;;"                       This copy will remain on the system for 30 days."
 ;;""
 ;;"                       Select H(elp) for more information."
 ;;""
 ;;"Analyze File #8927 via the VIEW, PRINT, or EMAIL options."
 ;;EOM
 ;
PART01 ;
 ;;
 ;; [Press <PF1>+Q or <CNTRL>+E to exit this browser.]
 ;;
 ;; Tip:  If your keyboard doesn't have a separate 10-key keyboard (like a laptop),
 ;;       your emulator should have a "Virtual Keyboard" so that you can access
 ;;       the PF1 (and more) keys via the "Show or hide terminal keyboard." button.
 ;;
 ;; Please read this information before using the utility.
 ;;
 ;; This utility will attempt to fix most common issues with the TIU TEMPLATE
 ;; file [#8927].
 ;;
 ;; The TIU TEMPLATE file is automatically saved to the ^XTMP global at first
 ;; use.
 ;;
 ;; This data will automatically be removed from the system 30 days after it
 ;; is last used.
 ;;
 ;; Accessing the new TIU option, TIU ANALYZE/UPDATE FILE 8927 (Analyze/Update
 ;; File #8927) will update the purge date to T+30 to prevent the system from
 ;; removing the data.
 ;;
 ;;EOM
 ;;01234567890123456789012345678901234567890123456789012345678901234567890123456789
 ;
PART02 ;
 ;;
 ;; The TIU TEMPLATE file will automatically be saved in the ^XTMP global.
 ;;
 ;; This will be the original, unaltered copy of the file.
 ;;
 ;; Selecting BACKUP from the main menu will automatically reset the purge date of
 ;; this data to T+30.  This also happens automatically when you enter the utility.
 ;;
 ;; If the utility is not used for 30 days, the system will automatically remove
 ;; the saved data!
 ;;
 ;; RESTORE will restore File #8927 to its original state from the saved ^XTMP
 ;; data.
 ;;
 ;; You will be asked to confirm this action.
 ;;
 ;;EOM
 ;
PART03 ;
 ;;
 ;; The UPDATE action has 3 levels to choose from for cleaning and fixing
 ;; entries in File #8927.
 ;;
 ;; Option 1) Basic Cleanup
 ;;
 ;; The Basic cleanup will NOT wrap any lines and may be used to safely
 ;; attempt to fix entries with broken fields and objects.
 ;;
 ;; The Basic cleanup will:  Delete TEMPLATES that have no linked ITEMS, no
 ;;                          Boilerplate Text, or linked entries.
 ;;
 ;;                          Clean TEMPLATES by removing trailing spaces and
 ;;                          control characters embedded in boilerplate text.
 ;;
 ;;                          Attempt to fix the most common issue with broken
 ;;                          fields and objects: last field/object missing the
 ;;                          closing bracket.
 ;;
 ;; Option 2) Intermediate Cleanup
 ;;
 ;; The Intermediate cleanup will do all the above and WILL wrap lines that are
 ;; >80 characters.  This can lead to incorrectly formatted text paragraphs in
 ;; templates that have long lines.  This wrap is the default wrap seen when
 ;; creating a note with a TEMPLATE with long lines that display properly in the
 ;; CPRS TEMPLATE EDITOR with "Allow long lines" turned on.
 ;;
 ;; This is how CPRS wraps text >80 characters from TEMPLATES with long lines.
 ;;
 ;; Example (the 3rd line is >80 characters):
 ;;
 ;; Present pharmacotherapy assessed for appropriateness, dosing, efficacy
 ;; and safety, adverse effects, pharmacologic duplication, unnecessary meds,
 ;; omissions, drug interactions, indications, allergies, need for dose adjustment
 ;; based on organ
 ;; function, drug administration problems, etc.
 ;;
 ;; Option 3) Advanced Cleanup
 ;;
 ;; The Advanced cleanup will perform the Basic cleanup and WILL wrap lines that
 ;; are >80 characters.  The primary difference is that it will attempt to fix
 ;; the common issue above with improperly formatted paragraphs of text.
 ;;
 ;; The Advanced cleanup will merge sequential lines of text and then wrap the
 ;; lines.
 ;;
 ;; Example:
 ;;
 ;; Present pharmacotherapy assessed for appropriateness, dosing, efficacy
 ;; and safety, adverse effects, pharmacologic duplication, unnecessary meds,
 ;; omissions, drug interactions, indications, allergies, need for dose adjustment
 ;; based on organ function, drug administration problems, etc.
 ;;
 ;; Exceptions to merging lines:
 ;;
 ;;      - Lines of text less than 80 characters.
 ;;      - Lines of text that end with an OBJECT or TEMPLATE FIELD.
 ;;      - Lines of text that contain TEMPLATE FIELDS that resolve to less than
 ;;        80 characters.
 ;;      - Lines of text where the next line contains one or more OBJECTS or
 ;;        TEMPLATE FIELDS.
 ;;
 ;; ** WARNING ** The Intermediate and Advanced cleanup options may ruin the
 ;; formatting of TEMPLATES that have long lines and have special formatting
 ;; following the long lines.
 ;;
 ;; This is why a backup of the TIU TEMPLATE file MUST be made before running
 ;; the UPDATE.
 ;;
 ;; Press <PF1>+Q or <CNTRL>+E to exit this browser.
 ;;
 ;;EOM
 ;
PART04 ;
 ;;
 ;; VIEW will allow the user to browse the following information:
 ;;
 ;;      - Entries with Broken Fields/Objects.
 ;;      - Entries with lines >80 characters.
 ;;      - Entries that have no text, items or linked.
 ;;      - Entries Missing Fields from File #8927.1
 ;;      - Entries Missing Objects from File #8925.1
 ;;
 ;; In the browser, Press <PF1>S to select the CURRENT LIST to view.
 ;;
 ;; You MUST use <PF1> S to switch between the available lists.
 ;;
 ;; The browser displays a representation of the GUI Tree View accessible
 ;; via the CPRS GUI - Options - Edit Templates... or Edit Shared Templates...
 ;;
 ;; This representation allows users to find, view/verify the entry in
 ;; File #8927 via the CPRS GUI template editor.  Because the template editor
 ;; allows long lines, entries in this file are NOT to be edited or viewed in
 ;; FileMan due to potential issues with wrapping fields or objects incorrectly.
 ;;
 ;; Example:
 ;;
 ;;    IEN:  (Internal Entry Number)
 ;;    <Shared Templates>
 ;;       <Education Templates>
 ;;          - Blank/Broken Template [(Line #)]
 ;;
 ;; Press <PF1>+Q or <CNTRL>+E to exit the browser.
 ;;
 ;; Tip:  If your keyboard doesn't have a separate 10-key keyboard (like a laptop),
 ;;       your emulator should have a "Virtual Keyboard" so that you can access
 ;;       the PF1 (and more) keys via the "Show or hide terminal keyboard." button.
 ;;
 ;;EOM
 ;
PART05 ;
 ;;
 ;; PRINT/EMAIL will allow the user to print or email the analysis results to a
 ;; device of their choosing or a mail message to their account.
 ;;
 ;; Tip:  You can PRINT the results and choose P-MESSAGE as the device to send the
 ;;       email with a custom subject and multiple recipients.
 ;;
 ;; Press <PF1>+Q or <CNTRL>+E to exit the browser.
 ;;
 ;;EOM
