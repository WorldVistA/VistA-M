DGPFLMA2 ;ALB/KCL - PRF ASSIGNMENT LM PROTOCOL ACTIONS CONT. ; 6/12/06 12:46pm
 ;;5.3;Registration;**425,623,554,650,864,951**;Aug 13, 1993;Build 135
 ;    Last edited: SHRPE/SGM - Nov 9, 2018 12:44
 ;
 QUIT
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -------------------------
 ; 2050  Sup   ^DIALOG: BLD, MSG
 ; 2054  Sup   $$OREF^DILF
 ; 2055  Sup   $$EXTERNAL^DILFD
 ; 2056  Sup   $$GET1^DIQ
 ; 2171  Sup   ^XUAF4: $$NS, $$STA, $$TF
 ;10028  Sup   EN^DIWE
 ;10103  Sup   ^XLFDT: $$FMTE, $$NOW
 ;10116  Sup   ^VALM1: FULL, PAUSE
 ;
AF ;Entry point for DGPF ASSIGN FLAG action protocol.
 ;
 ;  Input:
 ;     DGDFN - pointer to patient in PATIENT (#2) file
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DIC,DGWPROOT,DIWETXT,DIWESUB,DWLW,DWPK  ;input vars for EN^DIWE call
 N DGABORT   ;abort flag for entering assignment narrative
 N DGFAC     ;pointer to INSTITUTION (#4) file
 N DGOK      ;ok flag for entering assignment narrative
 N DGPFA     ;assignment array
 N DGPFAH    ;assignment history array
 N DGRDAT    ;results of review date calculation
 N DGRESULT  ;result of STOALL api call
 N DGERR     ;if unable to add assignment
 N DGPFERR   ;if error returned from STOALL
 N PRFIEN    ;PRF IEN from file 26.15 dg*5.3*864
 N PRFNAME   ;PRF NAME (.01) field dg*5.3*864
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;quit if patient not selected
 I '$G(DGDFN) D  Q
 . D BLD^DIALOG(261129,"Patient has not been selected.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;is user's DUZ(2) an enabled Division for PRF ASSIGNMENT OWNERSHIP
 I '$D(^DG(40.8,"APRF",+$G(DUZ(2)))) D  Q
 . D BLD^DIALOG(261129,"Your Division, "_$$STA^XUAF4($G(DUZ(2)))_", is not enabled for PRF Assignment Ownership.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 D  ;drops out of DO block on assignment failure
 . ;
 . ;init assignment and history arrays
 . K DGPFA,DGPFAH
 . ;
 . ;get patient DFN into assignment array
 . S DGPFA("DFN")=$G(DGDFN)
 . Q:'DGPFA("DFN")
 . ;
 . ;select flag for assignment
 . S DGPFA("FLAG")=$$ANSWER^DGPFUT("Select a flag for this assignment","","26.13,.02")
 . Q:(DGPFA("FLAG")'>0)
 . ; Urgent    Address is Female,check if user has programmer access dg*5.3*864.
 . N PRFIEN,PRFNAME,PRFNAT
 . S PRFNAT="" I $P(DGPFA("FLAG"),";",2)="DGPF(26.15," S PRFNAT=1
 . S PRFIEN="" I PRFNAT=1 S PRFIEN=$P(DGPFA("FLAG"),";")
 . S PRFNAME="" I PRFIEN'="" S PRFNAME=$$GET1^DIQ(26.15,PRFIEN,.01)
 . I PRFNAME="URGENT    ADDRESS AS FEMALE"&(DUZ("0")'="@") D  Q
 . . W !!!,"The URGENT    ADDRESS AS FEMALE National Flag is limited to purposes"
 . . W !,"authorized by the Undersecretary for Health only."
 . . W !!!
 . . D PAUSE^VALM1
 . ;
 . ;National ICN when Cat I assignment?
 . I $P(DGPFA("FLAG"),U)["26.15",'$$MPIOK^DGPFUT(DGPFA("DFN")) D  Q
 . . W !!,"Unable to proceed with flag assignment..."
 . . D BLD^DIALOG(261132,"","","DGERR","F")
 . . D MSG^DIALOG("WE","","","","DGERR") W *7
 . . D PAUSE^VALM1
 . ;
 . ;run query for Cat I assignments
 . I $P(DGPFA("FLAG"),U)["26.15",$$GETSTAT^DGPFHLL1(DGDFN)'="C" D
 . . N DGDIFF ;   difference between pre and post query count
 . . N DGFLGCNT ; total count of Cat I flags
 . . N DGMSG ;    temp array for messages
 . . N DGPRECNT ; pre-query count of Cat I assignments
 . . N DGPSTCNT ; post-query count of Cat I assignments
 . . N L,X
 . . ;
 . . ;get count of current assignments
 . . S (DGPRECNT,DGPSTCNT)=$$GETALL^DGPFAA(DGDFN,,,1)
 . . ;
 . . ;get total count of possible Category I flags
 . . S DGFLGCNT=$$CNTRECS^DGPFUT1(26.15)
 . . ;
 . . ;stop if all flags are assigned
 . . Q:DGPRECNT=DGFLGCNT
 . . ;
 . . ;execute the query...stop on failure
 . . Q:'$$SNDQRY^DGPFHLS(DGDFN,1,.DGFAC)
 . . ;
 . . ;recheck current assignment count
 . . S DGPSTCNT=$$GETALL^DGPFAA(DGDFN,,,1)
 . . S DGDIFF=DGPSTCNT-DGPRECNT
 . . S L=2,DGMSG("DIMSG",1)="   "
 . . S X="    "_$S(DGDIFF:"One or more",1:"No")
 . . S X=X_" Category I record flag assignments were "
 . . S X=X_$S(DGDIFF:"returned",DGPSTCNT:"returned",1:"found.")
 . . S DGMSG("DIMSG",2)=X
 . . I DGDIFF!DGPSTCNT D
 . . . S X="    from "_$P($$NS^XUAF4($G(DGFAC)),U)
 . . . I DGDIFF S X=X_" and filed on your system."
 . . . S DGMSG("DIMSG",3)=X,L=3
 . . . Q
 . . S L=L+1,DGMSG("DIMSG",L)="   "
 . . D MSG^DIALOG("MW",,,,"DGMSG")
 . . ;
 . . ;re-build list when flag assignments have been added
 . . I DGDIFF D BLDLIST^DGPFLMU(DGDFN)
 . ;
 . ;ok to add new assignment?
 . I '$$ADDOK^DGPFAA2(DGPFA("DFN"),$P(DGPFA("FLAG"),U),"DGERR") D  Q
 . . W !!,"Unable to proceed with flag assignment..."
 . . D MSG^DIALOG("WE","","",5,"DGERR")
 . . D PAUSE^VALM1
 . ;
 . ;prompt for owner site
 . S DGPFA("OWNER")=$$ANSWER^DGPFUT("Enter Owner Site",$$EXTERNAL^DILFD(26.13,.04,"",DUZ(2),"DGERR"),"P^4:EMZ","","I $D(^DG(40.8,""APRF"",+Y)),$$TF^XUAF4(+Y)")
 . Q:(DGPFA("OWNER")'>0)
 . ;
 . ;prompt user for approved by person, quit if not selected
 . S DGPFAH("APPRVBY")=$$ANSWER^DGPFUT("Approved By","","P^200:EMZ")
 . Q:(DGPFAH("APPRVBY")'>0)
 . ;
 . ;have user enter assignment narrative text (required)
 . S (DGABORT,DGOK)=0
 . S DGWPROOT=$NA(^TMP($J,"DGPFNARR"))
 . K @DGWPROOT
 . F  D  Q:(DGOK!DGABORT)
 . . N I,DGTX
 . . S I="" ; init. I in order to prevent <UNDEFINED> error in LNQ^DIWE5 (part of EN^DIWE API call)
 . . W !!,"Enter Narrative Text for this record flag assignment:" ;needed for line editor
 . . S DIC=$$OREF^DILF(DGWPROOT)
 . . S DIWETXT="Patient Record Flag - Assignment Narrative Text"
 . . S DIWESUB="Assignment Narrative Text"
 . . S DWLW=75 ;max # of chars allowed to be stored on WP global node
 . . S DWPK=1  ;if line editor, don't join lines
 . . D EN^DIWE
 . . I $$CKWP^DGPFUT(DGWPROOT,.DGTX) S DGOK=1
 . . E  D
 . . . W !,"Assignment Narrative Text is required!"_$C(7)
 . . . I $D(DGTX) S I=0 F  S I=$O(DGTX(I)) Q:'I  W !,DGTX(I)
 . . . I '$$CONTINUE^DGPFUT() S DGABORT=1
 . . . Q
 . . Q
 . . ;
 . ;quit if required assignment narrative not entered
 . Q:$G(DGABORT)
 . ;
 . ;place assignment narrative text into assignment array
 . M DGPFA("NARR")=@DGWPROOT K @DGWPROOT
 . ;
 . ;setup remaining assignment and history array nodes for filing
 . S DGPFA("STATUS")=1 ;                active
 . S DGPFA("ORIGSITE")=DUZ(2) ;         current user's login site
 . S DGPFAH("ASSIGNDT")=$$NOW^XLFDT ;   current date/time
 . S DGPFAH("ACTION")=1 ;               new assignment
 . S DGPFAH("ENTERBY")=DUZ ;            current user
 . S DGPFAH("ORIGFAC")=+$$SITE^VASITE ; created by site
 . S DGPFAH("COMMENT",1,0)="New record flag assignment."
 . ;
 . ;calculate the default review date
 . S DGRDAT=$$GETRDT^DGPFAA3($P(DGPFA("FLAG"),U),DGPFAH("ASSIGNDT"))
 . ;
 . ;prompt for review date on valid default review date, otherwise null
 . I DGRDAT>0 D
 . . N X,XO
 . . S X=$$FMTE^XLFDT(DGRDAT,"5D")
 . . S XO="D^"_DT_":"_DGRDAT_":EX"
 . . S DGPFA("REVIEWDT")=$$ANSWER^DGPFUT("Enter Review Date",X,XO)
 . . Q
 . E  S DGPFA("REVIEWDT")=""
 . Q:DGPFA("REVIEWDT")<0
 . ;
 . ;prompt for DBRS# ; DG*5.3*951
 . D DBRS
 . ;
 . ;display flag assignment review screen to user
 . D REVIEW^DGPFUT3(.DGPFA,.DGPFAH,"",XQY0,XQORNOD(0))
 . ;
 . Q:$$ANSWER^DGPFUT("Would you like to file this new record flag assignment","YES","Y")'>0
 . ;
 . ;file the assignment and history using STOALL api
 . W !,"Filing the patient's new record flag assignment..."
 . S DGRESULT=$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGPFERR,"D")
 . W !?5,"Assignment was "_$S(+$G(DGRESULT):"filed successfully.",1:"not filed successfully.")
 . ;
 . ;send HL7 message if adding an assignment to a CAT I flag
 . I $G(DGRESULT),DGPFA("FLAG")["26.15",$$SNDORU^DGPFHLS(+DGRESULT) D
 . . W !?5,"Message sent...updating patient's sites of record."
 . ;
 . D PAUSE^VALM1
 . ;
 . ;re-build list of flag assignments for patient
 . D BLDLIST^DGPFLMU(DGDFN)
 . Q
 ;
 S VALMBCK="R"
 ;
 Q
 ;---------------------------------------------------------------------
DBRS() ; DG*951
 ;Expects:
 ;   DGPFA() = int^ext  /  PRFNAME = name of flag
 ;  DGPFAH() = int
 ;
 I $G(DGPFA("FLAG"))'["26.15," Q 1
 I PRFNAME'="BEHAVIORAL" Q 1
 ;
 N J,X,DBRS,OUT
 ;
 ;   prompt for dbrs# /other
 S OUT=0 F J=0:0 D  Q:OUT
 . N L,X,DGNM,DGXA,OTH
 . ;  build DIR("A") if appropriate
 . S L=1,DGXA("A",1)="   Disruptive Behavior Report System Number"
 . I $D(DBRS) D
 . . N X,Y,SCR
 . . S L=L+1
 . . S DGXA("A",L)="The following DBRS Numbers have already been entered:"
 . . S (X,Y)="" F  S X=$O(DBRS(X)) Q:X=""  D
 . . . S Y=Y_$E(X_"                    ",1,20)
 . . . I $L(Y)>60 S L=L+1,DGXA("A",L)=Y,Y=""
 . . . Q
 . . I $L(Y) S L=L+1,DGXA("A",L)=Y
 . . S L=L+1,DGXA("A",L)="   "
 . . Q
 . S L=L+1,DGXA("A",L)="   "
 . S DGXA="Enter DBRS Number"
 . S SCR="26.131,.01Or^^S:X?.E1L.E X=$$UP^XLFSTR(X) K:$D(DBRS(X))!($$DBRSNO^DGPFUT6(X)<0) X"
 . W ! S DGNM=$$ANSWER^DGPFUT(.DGXA,,SCR)
 . I (DGNM<0)!("@"[DGNM) S OUT=1 Q
 . ;
 . S OTH=$$ANSWER^DGPFUT("DBRS Other",,"26.131,.02")
 . S OTH=$S(OTH=-1:"",OTH="@":"",1:OTH)
 . S DBRS(DGNM)=OTH
 . Q
 ;
 ;  set up DGPFA() and DGPFAH()
 I $D(DBRS) D
 . N J,L,Y,DATE,NM,OTH,SITE
 . S DATE=+$E($$NOW^XLFDT,1,12),$P(DATE,U,2)=$$FMTE^XLFDT(DATE,"1Z")
 . S SITE=$P($$SITE^VASITE,U,1,2)
 . S (L,NM)=0 F J=0:0 S NM=$O(DBRS(NM)) Q:NM=""  D
 . . S L=L+1
 . . S OTH=DBRS(NM)
 . . S DGPFA("DBRS#",L)=NM_U_NM
 . . S DGPFA("DBRS OTHER",L)=OTH_U_OTH
 . . S DGPFA("DBRS DATE",L)=DATE
 . . S DGPFA("DBRS SITE",L)=SITE
 . . S DGPFAH("DBRS",L)=NM_U_OTH_U_(+DATE)_"^A^"_(+SITE)
 . . ;   all five piece are internal FM format 
 . . Q
 . Q
 Q
