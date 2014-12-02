LRAPICD ;ALB/JAM - Anatomic Pathology ICD-10 DIAGNOSIS CODE API ;6/15/12
 ;;5.2;LAB SERVICE;**422**;Sep 27, 1994;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Routine based on ^ZZLXDG and ^ICDLOOK
 ;
 ; Reference to $$CODEC^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$DIAGSRCH^LEX10CS supported by ICR #5681
 ; Reference to $$IMPDATE^LEXU supported by ICR #5679
 ; Reference to $$FREQ^LEXU supported by ICR #5679    
 ; Reference to $$MAX^LEXU  supported by ICR #5679
 ;
EN(LRDXV) ;
 N LRDFN,LRSS,LRI,CFL
 I LRDXV="" Q
 S LRDFN=$P(LRDXV,";"),LRSS=$P(LRDXV,";",2),LRI=$P(LRDXV,";",3)
 I LRDFN="" Q
 I LRSS'="AU",LRI="" Q
 S CFL=0
 D GETDX
 D DEMO
 I CFL D DXSAV
 K X,Y
 Q
 ;
 ;this is a demo code,
 ;in your applications you might need to use some or all of the code below,
 ;see comments
DEMO ;
 N QUIT ; to manage demo loop
 N LRETV ;to store the selected code information
 N PARAM ;  to set your application specific prompts and messages
 N CSYS ;coding system "ICD9" or ICD10"
 N LROUT ;to return all available information about the selected code
 N DEFLV ;default ICD value for demo
 N LRADT
 ;settings:
 S LRADT=$P($G(LRICDT,DT),".")
 ;determine coding system based on the date of interest
 S CSYS=$$ICDSYSDG(LRADT)
 S DEFLV=$O(LRADX(""))
 D SETPARAM(.PARAM) ;edit the SETPARAM subroutine below to set your application specific prompts
 ;starting demo loop
 S QUIT=0 F  Q:QUIT=1  D
 . S LRETV=0,LROUT=""
 . ;run either ICD9 or ICD10 prompt/search/select logic
 . ;ICD9 (1 is a pointer to the ICD-9 diagnosis system entry in the new file #80.4 )
 . ;I CSYS=1 S LRETV=$$DIAG9(LRADT,DEFLV,.LROUT,.PARAM) I LRETV=-2 S:$$QUESTION(1,PARAM("TRY ANOTHER"))'=1 QUIT=1 Q
 . ;ICD10 (30 is a pointer to the ICD-10 diagnosis system entry in the new file #80.4 )
 . I CSYS=30 S LRETV=$$DIAG10(LRADT,.DEFLV,.PARAM)
 . ;display information about the code selected (for demo purposes)
 . I LRETV>0 S LRADX($P(LRETV,";",2))=+LRETV D CODEINFO(LRETV) W ! D DXDSP S DEFLV="",CFL=1 W ! Q
 . ;if no data found
 . I LRETV="" W !!,PARAM("NO DATA FOUND"),!,PARAM("NO DATA FOUND 2"),! Q
 . ;in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 . I +LRETV=-4 Q
 . ;no changes to the default value
 . I +LRETV=-5 S QUIT=1 Q
 . ;no data or was aborted 
 . I +LRETV=-2 S QUIT=1 Q
 . ;if exit due to ^ in the ICD Diagnosis code prompt 
 . I +LRETV=-3 S QUIT=1 Q
 . ;if no data found
 . I +LRETV=-1 S:$P(LRETV,"^",2)=-1 QUIT=1 Q
 . ;user entered "@" to delete the currently selected ICD code 
 . I +LRETV=-6 D  Q
 ..I DEFLV="" W "  <NOTHING TO DELETE>" Q
 ..I $$QUESTION(1,PARAM("DELETE"))=1 K:DEFLV'="" LRADX(DEFLV) D DXDSP S DEFLV=$O(LRADX("")),CFL=1 Q
 ..W "  <NOTHING DELETED>",!
 . ; if continue search
 Q
 ;
 ;//---------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; LRADT - date of interest (Fileman format)
 ; LRADFLT - default values for the search string (can be a code by default)
 ; PARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value;IEN file # 757.01^description
 ; results
 ; or -1 if invalid data(press enter)
 ; "" if not found 
 ; or -2 if time out
 ; or -3 if ^ or ^^
 ; or -4 in ICD10 if the user answered NO for the question "Do you wish to continue(Y/N)?"
 ; or -5 if no changes to the default value
DIAG10(LRADT,LRADFLT,PARAM) ;
 N LRAINP,XX
 F  D  Q:LRAINP<0!($L($P(LRAINP,U,2))>1)
 . S LRAINP=$$SRCHSTR(PARAM("SEARCH_PROMPT"),PARAM("HELP ?"),PARAM("HELP ??"),LRADFLT)
 . I LRAINP'<0 I $L($P(LRAINP,U,2))'>1 W !!,PARAM("ENTER MORE") W:$L(PARAM("ENTER MORE2"))>0 !,PARAM("ENTER MORE2") W ! ;user should enter at least 2 characters
 I LRAINP<0 Q +LRAINP_"^-1"
 I $D(LRADX($P(LRAINP,U,2))) D  Q $P(LRAINP,U)_"^"_XX
 .S XX=$$ICDDX^ICDEX($P(LRAINP,U,2),LRADT,30,"E"),LRADFLT=$P(XX,U,2),XX=$TR(XX,"^",";"),CFL=1
 Q $$LEXICD10($P(LRAINP,U,2),LRADT,.PARAM)
 ;
 ;//---------
 ;The entry point for ICD-9 FileMan type (^DIC) diagnosis search functionality
 ;can be called from applications directly
 ;input parameters :
 ; LRADT - date of interest
 ; LRADFLT - default values for the search string (can be a code by default)
 ; LROUT - local array to return results(passed as a reference)
 ; PARAM - parameters/string constants (see SETPARAM for details)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ;  -1 no data or was aborted
 ;  -2 if timeout 
DIAG9(LRADT,LRADFLT,LROUT,PARAM) ;
 N LRAINP,LRETV,CDE9
 S LRETV=$$ICD9(LRADFLT,LRADT,.LROUT,PARAM("SEARCH_PROMPT"))
 I LRETV=-1 Q -2
 I LRETV<0 Q +LRETV
 S CDE9=$P(LRETV,U)
 I $D(LRADX($P(CDE9,";",2))) D  Q $P(CDE9,U)_"^"_XX
 .S XX=$$ICDDX^ICDEX($P(CDE9,U,2),LRADT,1,"E"),LRADFLT=$P(XX,U,2),XX=$TR(XX,"^",";"),CFL=1
 Q LRETV
 ;
 ;--------------
 ;The entry point for ICD-10 diagnosis search functionality
 ;can be called from applications directly
 ; Supported ICR 5681 ($$DIAGSRCH^LEX10CS)
 ;input parameters :
 ; LRATXT - search string
 ; LRADATE - date of interest
 ; LRAPAR - array with text messages and other string constants
 ;returns ICD-10 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; "" if not found 
 ; -1 if exit : ^ or ^^
 ; -2 if continue searching
 ;
LEXICD10(LRATXT,LRADATE,LRAPAR) ; ICD-10 Search
 N LRALVTXT
 ;parameters check
 S LRADATE=+$G(LRADATE)
 I LRADATE'?7N Q -1
 S LRATXT=$G(LRATXT)
 Q:'$L(LRATXT) -1
 N LRANUMB
 S LRANUMB=$$FREQ^LEXU(LRATXT)
 I LRANUMB>$$MAX^LEXU(30) D  I $$QUESTION(2,PARAM("WISH CONTINUE"))'=1 Q -4
 . W !
 . D FORMWRIT(LRAPAR("EXCEEDS MESSAGE1")_LRATXT_LRAPAR("EXCEEDS MESSAGE2")_LRANUMB_LRAPAR("EXCEEDS MESSAGE3")_LRATXT_""".",0)
 . D FORMWRIT("",2)
 . W !
 ;new and set variables
 N DIROUT,DUOUT,DTOUT,LRAEXIT,LRAICDNT
 N LRETV,LRAXX,LRALEVEL
 S LRETV=""
 S LRAEXIT=0
 S LRALEVEL=1,LRALVTXT(LRALEVEL)=LRATXT ;level 1 stores the original search string
 ; main loop
 F  Q:LRAEXIT>0  D
 .K LRAICDY
 .;get the search string from the current level and call LEX API
 .S LRAICDY=$$DIAGSRCH^LEX10CS(LRALVTXT(LRALEVEL),.LRAICDY,LRADATE,30)
 .S:$O(LRAICDY(" "),-1)>0 LRAICDY=+LRAICDY
 .; Nothing found
 .I +LRAICDY'>0 S LRAEXIT=1 S LRAXX=-1 Q
 .; display the list of items and ask the user to select the item from the list
 .S LRAXX=$$SEL^LRAPICD2(.LRAICDY,8)
 .; if ^ was entered 
 .;   if this is on the top level then quit 
 .I LRAXX=-2,LRALEVEL'>1 S LRETV=-1 S LRAEXIT=1 Q
 .;   if lower level then go one level up
 .I LRAXX=-2,LRALEVEL>1 S:LRALEVEL>1 LRALEVEL=LRALEVEL-1 Q
 .; If timeout, or not selected, or ^^ then quit
 .I LRAXX=-1 S LRETV=-1 S LRAEXIT=1 Q
 .; if Code Found and Selected by the user save selection in LRETV and quit
 .I $P(LRAXX,";")'="99:CAT" S LRETV=LRAXX S LRAEXIT=1 Q
 .; If Category Found and Selected by the user:  
 .;  go to the next inner level
 .;  change level number 
 .S LRALEVEL=LRALEVEL+1
 .;  set the new level with the new search string
 .;  and repeat 
 .S LRALVTXT(LRALEVEL)=$P($P($G(LRAXX),"^"),";",2)
 Q LRETV
 ;----------
 ;ICD-9 lookup (FileMan lookup)
 ;Supported ICR 5773 (FileMan lookup for files #80 and #80.1)
 ;Supported ICR 5699 ($$ICDDATA^ICDXCODE)
 ;Supported ICR 5747 ($$CSI^ICDEX)
 ;input parameters :
 ; LRASRCH - search string 
 ; LRAICDT - date of interest  
 ; LROUT - local array to return detailed info (passed as a reference)
 ;returns ICD-9 code selected by the user:
 ;  IEN file #80;ICD code value^description
 ; or 
 ; -1 if exit : ^ or ^^
 ; -2 if no results (timeout)
 ;the array LROUT returns details if the return value >0, here is an example: 
 ; LROUT="6065^814.14"
 ; LROUT(0)=814.14
 ; LROUT(0,0)=814.14
 ; LROUT(0,1)="6065^814.14^^FX PISIFORM-OPEN^^8^^1^^1^^^0^^^^2781001^^1^1"
 ; LROUT(0,2)="OPEN FRACTURE OF PISIFORM BONE OF WRIST"
 ;Note: this API is not silent because the ICD lookup is not silent
ICD9(LRASRCH,LRAICDT,LROUT,LRAPRMT) ;
 N KEY,X,Y,DIC,LRACDS
 ;KEY must be newed as ICD lookup code doesn't kill it
 S DIC="^ICD9(",DIC(0)="EQMNZIA"
 S:$G(LRAPRMT)]"" DIC("A")=LRAPRMT
 S:$G(LRASRCH)]"" DIC("B")=LRASRCH
 S LRACDS="ICD9"
 ;note: you must use Y for the 2nd parameter of $$ICDDATA^ICDXCODE
 S DIC("S")="I $$LS^ICDEX(80,+Y,LRAICDT)>0,$$CSI^ICDEX(80,+Y)=1"
 D ^DIC
 M LROUT=Y
 I $G(Y) Q $S($D(DTOUT):-2,$D(DUOUT):-1,$D(DUOUT):-1,Y=-1:-1,Y=-5:"",1:+Y_";"_$P(Y,U,2)_U_$G(Y(0,2)))
 Q X
 ;
 ;---------
 ; Clean up environment and quit
EXIT ;
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
 ;-----------
 ; Diagnosis display
DXDSP ;
 N DXS
 S DXS=""
 F  S DXS=$O(LRADX(DXS)) Q:DXS=""  D
 . ; Determine Active Coding System Based on Date of Interest
 . S LRCS=$$SINFO^ICDEX("DIAG",$G(LRADT)) ; Supported by ICR 5747
 . W !,?4,DXS,?15,$P($$ICDDX^ICDEX(DXS,$G(LRADT),+LRCS,"E"),"^",4) ; Supported by ICR 5747
 Q
 ;-----------
 ; Look-up help for ?
INPHLP ;
 N DXS,LRCS
 I $D(LRADX) D
 . W !?4,"Answer with ICD DIAGNOSIS"
 . W !?5,"Choose from:"
 . D DXDSP W !
 I $G(X)["???" D INPHLP3 Q
 I $G(X)["??" D INPHLP2 Q
 W !," Enter code or ""text"" for more information." Q
 Q
 ;-----------
 ; Look-up help for ??
INPHLP2 ;
 W !," Enter a ""free text"" term or part of a term such as ""femur fracture""."
 W !!," or "
 W !!," Enter a ""classification code"" (ICD/CPT etc) to find the single term"
 W !," associated with the code."
 W !!," or "
 W !!," Enter a ""partial code"". Include the decimal when a search criterion"
 W !," includes 3 characters or more for code searches."
 Q
 ;--------
 ; Look-up help for ???
INPHLP3 ;
 W !," Number of Code Matches"
 W !," ----------------------"
 W !!," The ICD-10 Diagnosis Code search will show the user the number of matches"
 W !," found, indicate if additional characters in ICD code exist, and the number"
 W !," of codes within the category or subcategory that are available for selection."
 W !," For example:"
 W !!," 14 matches found"
 W !!," M91. - Juvenile osteochondrosis of hip and pelvis (19)"
 W !!," This indicates that 14 unique matches or matching groups have been found"
 W !," and will be displayed."
 W !!," M91. - the ""-"" indicates that there are additional characters that specify"
 W !," unique ICD-10 codes available."
 W !!," (19) Indicates that there are 19 additional ICD-10 codes in the M91 ""family"""
 W !," that are possible selections."
 Q
 ;--------
 ;ask YES/NO questions
 ;input parameters :
 ; LRADFLT- 0/null- not default, 1- yes, 2 -no
 ; LRAPROM - prompt string
 ;returns 
 ; 2 - no,
 ; 1 - yes,
 ; 0 - no answer (time out)
 ; -3 - ^ or ^^
QUESTION(LRADFLT,LRAPROM) ;
 N DIR
 S %=$G(LRADFLT,2)
 S DIR(0)="Y",DIR("A")=LRAPROM,DIR("B")=$S(%=1:"Yes",%=2:"No",1:"")
 D ^DIR
 Q:Y["^" -3
 Q:Y=1 1
 Q:Y=0 2
 Q 0
 ;
 ;------------
 ;get search string
 ;input parameters :
 ; LRAPRMT prompt text
 ; LRAHLP1 "?" help text
 ; LRAHLP2 "??" help text
 ; LRADFLT- default response
 ;returns piece1 ^ piece 2
 ; piece1:
 ; 0 if normal input
 ; or -1 if invalid data
 ; or -2 if time out
 ; or -3 if ^
 ; or -5 if user accepts default value then no need to validate it
 ; or -6 if user enters "@"
 ; piece2: string entered by the user
SRCHSTR(LRAPRMT,LRAHLP1,LRAHLP2,LRADFLT) ;
 N DIR
 S DIR("A")=LRAPRMT
 S DIR("?")=LRAHLP1
 S DIR("??")=LRAHLP2
 I $L($G(LRADFLT)) S DIR("B")=LRADFLT
 S DIR(0)="FAOr^0:245"
 D ^DIR
 Q:$D(DTOUT) -2
 Q:$D(DUOUT) -3
 Q:X="@" -6 ;quit if user entered "@" and handle deletion case in your application
 Q:Y["^" -3
 Q:Y="" -1
 Q:(($L($G(LRADFLT)))&(Y=LRADFLT)) -5 ;if user accepts default value then no need to validate it
 Q 0_U_$$UP^XLFSTR(Y)
 ;
 ;----------
 ;Determines and returns ACTIVE coding system for DIAGNOSES based on date of interest 
 ;input parameters :
 ; LRAICDD - date of interest
 ; if date of interest is null, today's date will be assumed
 ;returns coding system  
 ; as a pointer to the ICD CODING SYSTEM file #80.4 (supported ICR 5780) 
 ; 30  if ICD-10-CM is active system
 ; 1   if ICD-9-CM is active system
ICDSYSDG(LRAICDD) ; 
 N LRAIMPDT
 S LRAICDD=$S(LRAICDD<0!($L(+LRAICDD)'=7):DT,1:+$G(LRAICDD))
 S LRAIMPDT=$$IMPDATE^LEXU("10D")
 Q $S(LRAICDD'<LRAIMPDT:30,1:1)
 ;
 ;set parameters
 ;edit these hardcoded strings that are used for prompts, messages and so on to adjust them to your application's needs
 ;input parameters 
 ; LRAPAR - local array to sets and store string constants for your messages and prompts 
SETPARAM(LRAPAR) ;
 ;S LRAPAR("ASKDATE")="Date of interest? "
 S LRAPAR("SEARCH_PROMPT")="Select "_$S(LRSS="AU":"AUTOPSY ICD CODE",LRSS="EM":"ICD CODE",1:"ICD DIAGNOSIS")_": "
 S LRAPAR("HELP ?")="^D INPHLP^LRAPICD"
 S LRAPAR("HELP ??")="^D INPHLP^LRAPICD"
 S LRAPAR("NO DATA FOUND")=" No records found matching the value entered, revise search or enter ""?"" for"
 S LRAPAR("NO DATA FOUND 2")=" help."
 S LRAPAR("EXITING")=" Exiting"
 S LRAPAR("TRY LATER")=" Try again later"
 S LRAPAR("NO DATA SELECTED")=" No data selected"
 S LRAPAR("TRY ANOTHER")="Try another"
 S LRAPAR("WISH CONTINUE")="Do you wish to continue (Y/N)"
 S LRAPAR("EXCEEDS MESSAGE1")="Searching for """
 S LRAPAR("EXCEEDS MESSAGE2")=""" requires inspecting "
 S LRAPAR("EXCEEDS MESSAGE3")=" records to determine if they match the search criteria. This could take quite some time. Suggest refining the search by further specifying """
 S LRAPAR("NO CHANGES")=" No changes made"
 S LRAPAR("DELETE")="   SURE YOU WANT TO DELETE"
 S LRAPAR("ENTER MORE")=" Please enter at least the first two characters of the ICD-10 code or code"
 S LRAPAR("ENTER MORE2")=" description to start the search."
 Q
 ;
 ;a wrapper for ^DIWP
 ;accumulates a text and then writes it to the device
 ;input parameters :
 ; X - text
 ; LRAMODE:
 ;  0 - start
 ;  1 - accumulate 
 ;  2 - write
 ;example:
 ;D FORMWRIT^LRAPICD("this API is a wrapper for ^DIWP, it accumulates a text and then writes it to the device, you can use it in your application code",0)
 ;D FORMWRIT^LRAPICD("some more text ",1)
 ;D FORMWRIT^LRAPICD("",2)
FORMWRIT(X,LRAMODE) ;
 N LRALI1,DIWL,DIWR
 ;if "start" mode
 I LRAMODE=0 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=79
 I $L(X)>0 D ^DIWP
 ;if "write" mode
 I LRAMODE=2 D
 . S LRALI1=0 F  S LRALI1=$O(^UTILITY($J,"W",1,LRALI1)) Q:+LRALI1=0  W !,$G(^UTILITY($J,"W",1,LRALI1,0))
 . K ^UTILITY($J,"W")
 Q
 ;
 ;---------------
 ;press any key (used for demo)
PRESSKEY ;
 N LRAKEY
 R !!,"Press any key to continue.",LRAKEY:DTIME
 Q
 ;display code info (used for demo)
CODEINFO(LRAXX2) ; Write Output
 W " ",$P(LRAXX2,";",2)
 Q
 ;
GETDX ;Get DX and set in LRADX array
 N DX,DXC,CDE
 K LRADX
 S DX=0
 I LRSS="AU" D  Q
 .F  S DX=$O(^LR(LRDFN,80,DX)) Q:'DX  D
 ..S DXC=$$CODEC^ICDEX(80,DX) Q:DXC<0  S LRADX(DXC)=DX
 F  S DX=$O(^LR(LRDFN,LRSS,LRI,3,DX)) Q:'DX  D
 .S CDE=+$G(^LR(LRDFN,LRSS,LRI,3,DX,0)) I 'CDE Q
 .S DXC=$$CODEC^ICDEX(80,CDE) Q:DXC<0  S LRADX(DXC)=CDE
 Q
 ;
DXSAV ;Save diagnosis codes
 N DX,DXC,TMPDX,LRDXS,LRIEN,LRFL,DIK,DA
 S DX=""
 F  S DX=$O(LRADX(DX)) Q:DX=""  S TMPDX(LRADX(DX))=""
 I LRSS="AU" S DX=0 D  Q
 .F  S DX=$O(^LR(LRDFN,80,DX)) Q:'DX  D
 ..I $D(TMPDX(DX)) K TMPDX(DX) Q
 ..I '$D(TMPDX(DX)) S DA(1)=LRDFN,DA=DX,DIK="^LR("_DA(1)_",80," D ^DIK Q
 .S DX=0 F  S DX=$O(TMPDX(DX)) Q:'DX  D
 ..K LRIEN,LRDXS
 ..S LRIEN(1)=DX
 ..S LRDXS(63.808,"+1,"_LRDFN_",",.01)=DX
 ..D UPDATE^DIE("","LRDXS","LRIEN")
 S DX=0
 ; save DX code to subfiles - 63.02(EM); 63.08 (SP); or 63.09 (CY)
 ; .01 field is DINUM except for subfile 68.02 (EM)
 F  S DX=$O(^LR(LRDFN,LRSS,LRI,3,DX)) Q:'DX  D
 .I $D(TMPDX(DX)) K TMPDX(DX) Q
 .I '$D(TMPDX(DX)) S DA(2)=LRDFN,DA(1)=LRI,DA=DX,DIK="^LR("_DA(2)_","""_LRSS_""","_DA(1)_",3," D ^DIK Q
 S LRFL=$S(LRSS="EM":63.203,LRSS="SP":63.88,1:63.901)
 S DX=0 F  S DX=$O(TMPDX(DX)) Q:'DX  D
 .K LRIEN,LRDXS
 .S:LRSS'="EM" LRIEN(3)=DX
 .S LRDXS(LRFL,"+3,"_LRI_","_LRDFN_",",.01)=DX
 .D UPDATE^DIE("","LRDXS","LRIEN")
 Q
