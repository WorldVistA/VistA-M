DGOTHMGT ;SHRPE/YMG - OTH Management option ;04/30/19
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 N DGDFN,DGIEN33,DGSVDDF,DSPMODE,HASREQ
 S DSPMODE=0 ; 0 = display approved requests, 1 = display denied requests
 S (DGDFN,DGIEN33)=0
 ; load list template 
 D EN^VALM("DG OTH MANAGEMENT")
 Q
 ;
HDR ; header code
 D BLDHDR(DSPMODE)
 Q
 ;
INIT ; init variables and list array
 S VALMBG=1
 ; save off VALMDDF array data for approved and denied requests
 M DGSVDDF("A")=VALMDDF
 S DGSVDDF("D","LINE")="LINE^2^4^Line^U^0"
 S DGSVDDF("D","SUBMISSION DATE")="SUBMISSION DATE^8^15^Submission date^U^0"
 S DGSVDDF("D","COMMENT")="COMMENT^25^55^Authorization comment^U^0"
 ; build list to display
 D SET^VALM10(1,"")
 D SET^VALM10(2,$$CJ^XLFSTR("A patient has not been selected.  Please select a patient.",80))
 S VALMCNT=2
 Q
 ;
HELP ; help code
 D FULL^VALM1
 W @IOF
 W !,"This option allows users to view and enter / edit OTH data."
 W !
 S VALMBCK="R"
 Q
 ;
EXIT ; exit point
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
BLD(DSPMODE) ; build list of requests for display
 ;
 ; DSPMODE = 0 for displaying approved requests, DSPMODE = 1 for displaying denied requests
 ;
 N DENIEN,DGIEN365,DGIEN90,Z
 D CLEAN^VALM10 S VALMCNT=0
 S HASREQ=0 ; set to 1 if there's at least one request on the list
 W !!,"Working..."
 I DGIEN33'>0 G BLDX
 I DSPMODE D  G BLDX
 .; build list of denied requests
 .S Z=0 F  S Z=$O(^DGOTH(33,DGIEN33,3,"C",Z)) Q:'Z  D
 ..S DENIEN=+$O(^DGOTH(33,DGIEN33,3,"C",Z,"")) I 'DENIEN Q
 ..S VALMCNT=$$BLDLND(VALMCNT,DENIEN) I '(VALMCNT#10) W "."
 ..Q
 .Q
 ; DSPMODE=0, build list of approved requests
 S DGIEN365=0 F  S DGIEN365=$O(^DGOTH(33,DGIEN33,1,DGIEN365)) Q:'DGIEN365  D
 .S DGIEN90=0 F  S DGIEN90=$O(^DGOTH(33,DGIEN33,1,DGIEN365,1,DGIEN90)) Q:'DGIEN90  D
 ..S VALMCNT=$$BLDLNA(VALMCNT,DGIEN365,DGIEN90) I '(VALMCNT#10) W "."
 ..Q
 .Q
 ;
BLDX ; exit point
 I VALMCNT=0 S VALMCNT=$$NOREC(DSPMODE) Q
 S HASREQ=1
 Q
 ;
NOREC(DSPMODE) ; show message when display list is empty
 ;
 ; DSPMODE = 0 for displaying approved requests, DSPMODE = 1 for displaying denied requests
 ;
 ; returns line count in the created array
 ;
 D SET^VALM10(1,"")
 D SET^VALM10(2,"")
 D SET^VALM10(3,$$SETSTR^VALM1("No "_$S(DSPMODE:"denied",1:"approved")_" requests found.","",26,29))
 Q 3
 ;
BLDLND(LNUM,DENIEN) ; build one denied request line to display
 ; 
 ; LNUM - last line number
 ; DENIEN - ien in sub-file 33.03
 ;
 ; returns current line number
 ;
 N DATASTR,LINE,LN
 S DATASTR=$$GETDEN^DGOTHUT1(DGIEN33,DENIEN)
 ; build line
 S LINE="",LN=LNUM+1
 S LINE=$$SETSTR^VALM1($$CJ^XLFSTR(LN,$P(VALMDDF("LINE"),U,3)),LINE,1,3)
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR($$FMTE^XLFDT($P(DATASTR,U,2),"2DZ"),$P(VALMDDF("SUBMISSION DATE"),U,3)),LINE,"SUBMISSION DATE")
 S LINE=$$SETFLD^VALM1($E($P(DATASTR,U,3),1,55),LINE,"COMMENT")
 D SET^VALM10(LN,LINE,LN)
 S @VALMAR@("IDX",LN,LN)=DENIEN
 Q LN
 ;
BLDLNA(LNUM,DGIEN365,DGIEN90) ; build one approved request line to display
 ; 
 ; LNUM - last line number
 ; DGIEN365 - ien in sub-file 33.01
 ; DGIEN90 - ien in sub-file 33.11
 ;
 ; returns current line number
 ;
 N AUTH,DATASTR,DGNOW,ENDDT,LINE,LN,NUM90,STARTDT,STATUS
 S DATASTR=$$GET90DT^DGOTHUT1(DGIEN33,DGIEN365,DGIEN90)
 S ENDDT=$P(DATASTR,U,2)
 S DATASTR=$$GETAUTH^DGOTHUT1(DGIEN33,DGIEN365,DGIEN90)
 S STARTDT=$P(DATASTR,U,3),NUM90=$P(DATASTR,U,2)
 ; build line
 S LINE="",LN=LNUM+1
 S LINE=$$SETSTR^VALM1($$CJ^XLFSTR(LN,$P(VALMDDF("LINE"),U,3)),LINE,1,3)
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR($P(DATASTR,U),$P(VALMDDF("365 DAY NUM"),U,3)),LINE,"365 DAY NUM")
 S LINE=$$SETFLD^VALM1($$CJ^XLFSTR(NUM90,$P(VALMDDF("90 DAY NUM"),U,3)),LINE,"90 DAY NUM")
 S LINE=$$SETFLD^VALM1($$FMTE^XLFDT(STARTDT,"2DZ"),LINE,"START DATE")
 S LINE=$$SETFLD^VALM1($$FMTE^XLFDT(ENDDT,"2DZ"),LINE,"END DATE")
 S AUTH=$S(NUM90'>1:"Not required",1:$$FMTE^XLFDT($P(DATASTR,U,5),"2DZ"))
 S LINE=$$SETFLD^VALM1(AUTH,LINE,"AUTH")
 S DGNOW=$$NOW^XLFDT()
 S STATUS=$S(STARTDT>DGNOW:"Not started",ENDDT<DGNOW:"Expired",1:"Active")
 S LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 D SET^VALM10(LN,LINE,LN)
 S @VALMAR@("IDX",LN,LN)=DGIEN365_U_DGIEN90
 Q LN
 ;
BLDHDR(DSPMODE) ; build display header
 ;
 ; DSPMODE = 0 for displaying approved requests, DSPMODE = 1 for displaying denied requests
 ;
 N HASPND,PNDSTR
 S PNDSTR=$$GETPEND^DGOTHUT1(DGDFN),HASPND=+PNDSTR
 S VALMHDR(1)=$$LJ^XLFSTR("Current view: "_$S(DSPMODE:"Denied",1:"Approved")_" requests",40)
 S VALMHDR(1)=VALMHDR(1)_$$LJ^XLFSTR("Pending request: "_$S(HASPND=1:"Yes",1:"No"),40)
 S VALMHDR(2)=$$LJ^XLFSTR("Patient: "_$S(DGDFN>0:$$EXTERNAL^DILFD(33,.01,,DGDFN),1:"Not selected"),40)
 ;S VALMHDR(2)=VALMHDR(2)_$$LJ^XLFSTR("Pending request date: "_$S(HASPND=1:$$FMTE^XLFDT($P(PNDSTR,U,2),"2DZ"),1:"N/A"),40)
 S VALMHDR(2)=VALMHDR(2)_$$LJ^XLFSTR("Date request submitted: "_$S(HASPND=1:$$FMTE^XLFDT($P(PNDSTR,U,2),"2DZ"),1:"N/A"),40)
 S VALMHDR(3)=""
 Q
