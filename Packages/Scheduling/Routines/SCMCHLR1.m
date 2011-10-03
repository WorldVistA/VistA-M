SCMCHLR1 ;ALB/KCL - PCMM HL7 Reject Processing - List Manager Screen ; 10-JAN-2000
 ;;5.3;Scheduling;**210,505**;AUG 13, 1993;Build 20
 ;
EN ; Description: Main entry point for SCMC PCMM TRANSMISSION ERRORS. Used
 ; to invoke LM and load list template.
 ;
 ;  Input: None
 ; Output: None
 ;
 ;Invoke list template
 D EN^VALM("SCMC PCMM TRANSMISSION ERRORS")
 Q
 ;
 ;
HDR ; Description: Header code to display text in header area.
 ;
 ;Sort by
 S VALMHDR(1)="Sort By: "_$S(SCSORTBY="N":"Patient Name",SCSORTBY="D":"Date Error Received",SCSORTBY="P":"Provider",SCSORTBY="I":"Institution",1:"Unknown")
 ;
 ;Date range
 I $G(SCBEG),($G(SCEND)) D
 .S VALMHDR(1)=$$SETSTR^VALM1("Date Range: "_$$FDATE^VALM1(SCBEG)_" to "_$$FDATE^VALM1(SCEND),VALMHDR(1),46,80)
 E  D
 .S VALMHDR(1)=$$SETSTR^VALM1("Date Range: "_$$DRMSG,VALMHDR(1),46,80)
 ;
 ;Error processing status
 S VALMHDR(2)="Error Processing Status: "_$S(SCEPS=1:"New",SCEPS=2:"Checked",SCEPS=3:"New/Checked",1:"Unknown")
 ;
 ;Indicates marked for re-transmit
 S VALMHDR(2)=$$SETSTR^VALM1($$MRKMSG,VALMHDR(2),46,80)
 ;
 Q
 ;
 ;
INIT ; Description: Initialize variables and list array for building list.
 ;
 K SCBEG,SCEND,SCEPS,SCSORTBY
 K VALMBEG,VALMEND,VALMSG
 ;
 ;Display custom message in LM display window
 ;S VALMSG=$$MRKMSG
 ;
 ;Set sort by = 'Patient Name'
 S SCSORTBY="N"
 ;
 ;Set error processing status = both 'New/Checked'
 S SCEPS=3
 ;
 ;Init date range, list all errors
 S SCBEG=0
 S SCEND=DT
 ;
 ;Build PCMM transmission errors screen
 D BUILD
 Q
 ;
 ;
BUILD ; Description: Used to build PCMM error transmission screen.
 ;
 ;Kill the array related data before building the list
 D CLEAN^VALM10
 ;
 K SCARY,VALMHDR
 S SCARY="SCERR" ; set global array subscript
 K ^TMP(SCARY_"SRT",$J),^TMP(SCARY_"IDX",$J)
 S VALMBG=1 ;  init list start line
 S VALMCNT=0 ; init # of lines in list
 ;
 ;Builder header area
 D HDR
 ;
 ;Build list area for transmission log errors
 D EN^SCMCHLR2(SCARY,SCBEG,SCEND,SCEPS,SCSORTBY,.VALMCNT)
 Q
 ;
 ;
MRKMSG() ; Description: Returns custom message for list manager header
 ;
 Q "* - Marked for re-transmit"
 ;
 ;
DRMSG() ; Description: Returns custom message for date range in list manager header.
 ;
 Q "(None) List All Errors"
 ;
 ;
HELP ; Description: This entry point provides custom help code when user
 ;  enters a '?' at the menu prompt.
 ;
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ; Description: This is used to cleanup variables and do other exit processing.
 ;
 D CLEAR^VALM1
 D CLEAN^VALM10
 K SCBEG,SCEND,SCEPS,SCSORTBY,VALMSG
 K ^TMP(SCARY_"SRT",$J),^TMP(SCARY_"IDX",$J),X
 Q
 ;
 ;
EXPND ;Expand code
 Q
