TIUDIRH ; SLC/SBW - Help for DIR call (READ^GMRDU) ;4/12/93
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
REL ;Help for release from transcription or edit
 W !,"Enter either 'Y' or 'N'"
 W !,"To hold the document in a DRAFT state, where only you may see it, enter 'NO'."
 W !,"If you are finished editing, releasing the document will make it available"
 W !,"for others to view."
 Q
SBACK ;Help for send back report for retranscription or edit
 W !,"Enter either 'Y' or 'N'"
 W !,"When a transcriptionist or an author creates a new report, it must be"
 W !,"released before MAS or Clinicians can view it. Sending the report back to"
 W !,"transcription changes the status from released to unreleased and retricts"
 W !,"it from being viewed by MAS or clinicians."
 Q
VER ;Help for verify reports
 W !,"Enter either 'Y' or 'N'"
 W !,"Verification is quality assurance step done prior to allowing Clinicians to"
 W !,"view report. Verify means it passes this step."
 Q
UNVER ;Help for unverify reports
 W !,"Enter either 'Y' or 'N'"
 W !,"Verification is quality assurance step done prior to allowing Clinicians to"
 W !,"view report. Unverify means it was verified but now it needs to be unverified."
 Q
SIG ;Help for sign report
 W !,"Enter either 'Y' or 'N'"
 W !,"If this report is accurate and meets clinician's approval, it can be"
 W !,"electronically signed now."
 Q
OCSIG ;Help for sign report on chart
 W !,"Enter either 'Y' or 'N'"
 W !,"This allows the electronic record to be marked to indicate that the author "
 W !,"and/or attending physician signed on the chart copy."
 Q
DEF ;Help for edit default format
 W !,"Enter either 'Y' or 'N'"
 W !,"Upon creation of an original report, the default format will be entered into the"
 W !,"text portion of the new record. If the same text is entered for each original"
 W !,"report, setting up a default format will eliminate the entry of this text."
 Q
FIL ;Help for retry the upload filer
 W !,"Enter either 'Y' or 'N'"
 W !,"Allows the reports that were unable to be filed into DHCP at upload time"
 W !,"to be reprocessed in order to try to file them into DHCP again."
 Q
REAS1 ;Help for reassign by MIS Manager if report is uneditable.
 W !,"Enter either 'Y' or 'N'"
 W !,"Report is uneditable. If signed Original is assigned to wrong patient or"
 W !,"admission or signed Addendum is assigned to wrong original, the MIS Manager"
 W !,"can reassign it. The MIS Manager can also promote Addendum to be an Original."
 Q
REAS2 ;Help for reassign by MIS Manager if report is uneditable.
 W !,"Enter either 'Y' or 'N'"
 W !,"If Addendum should be the original, the MIS Manager can promote it to be "
 W !,"an Original."
 Q
CHART ;Help for mark printed summaries as chart copies.
 W !,"Enter either 'Y' or 'N'"
 W !,"If you enter YES, printed 10-1000s for summaries will be MARK as"
 W !,"CHART COPY."
 Q
