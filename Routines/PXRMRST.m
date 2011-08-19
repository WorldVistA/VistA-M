PXRMRST ; SLC/PKR - Rule Set test routines. ;02/16/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;===========================================================
EXIT ; -- exit code
 K ^TMP("PXRMRST",$J)
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
 ;===========================================================
HDR ; -- header code
 S VALMHDR(1)="Rule Set Test"
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;===========================================================
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;===========================================================
RSTEST(RULESET) ;Test a rule set and show the user the results.
 N BEG,END,IND,NL,OUTPUT,VALMCNT
 D DATES^PXRMEUT(.BEG,.END,"Patient List") Q:$D(DTOUT)!$D(DUOUT)
 D DOCDATES^PXRMEUT1(RULESET,BEG,END,.NL,.OUTPUT)
 K ^TMP("PXRMRST",$J)
 S ^TMP("PXRMRST",$J,1,0)="List Build Beginning Date: "_$$FMTE^XLFDT(BEG,"5Z")
 S ^TMP("PXRMRST",$J,2,0)="List Build Ending Date: "_$$FMTE^XLFDT(END,"5Z")
 F IND=1:1:NL S ^TMP("PXRMRST",$J,IND+2,0)=OUTPUT(IND)
 S VALMCNT=NL+2
 D EN^VALM("PXRM RULE SET TEST")
 Q
 ;
 ;===========================================================
RSTESTS ;Select a rule set for testing.
 N IND,RULESET,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S IND="",PXRMDONE=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the rule set ien.
 . S RULESET=^TMP("PXRMLRM",$J,"IDX",IND,IND)
 . D RSTEST^PXRMRST(RULESET)
 S VALMBCK="R"
 Q
 ;
