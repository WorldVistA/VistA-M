IBCNSP ;ALB/AAS - INSURANCE MANAGEMENT - EXPANDED POLICY ;05-MAR-1993
 ;;2.0;INTEGRATED BILLING;**6,28,43,52,85,251,363,371,416,497,516,528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
% ;
EN ; -- main entry point for IBCNS EXPANDED POLICY
 N IB1ST
 K VALMQUIT,IBPPOL,IBTOP
 S IBTOP="IBCNSP"
 D EN^VALM("IBCNS EXPANDED POLICY")
 Q
 ;
HDR ; -- header code
 ; 528 - baa ; Add DOB to hdr
 N W,X,Y,Z,IBNAME,IBDOB
 S IBNAME=^DPT(DFN,0),IBDOB=$P(IBNAME,U,3),IBNAME=$E($P(IBNAME,U),1,20)  ; direct global read on file 2 supported by IA 10035
 S VALMHDR(1)="Expanded Policy Information for: "_IBNAME_"  "_$P($$PT^IBEFUNC(DFN),U,2)_"  "_$$FMTE^XLFDT(IBDOB,5)
 S Z=$G(^DPT(DFN,.312,+$P(IBPPOL,U,4),0))
 S W=$P($G(^IBA(355.3,+$P(Z,U,18),0)),U,11)
 S Y=$E($P($G(^DIC(36,+Z,0)),U),1,20)_" Insurance Company"
 S X="** Plan Currently "_$S(W:"Ina",1:"A")_"ctive **"
 S VALMHDR(2)=$$SETSTR^VALM1(X,Y,48,29)
 Q
 ;
INIT ; -- init variables and list array
 ; input - IBPPOL
 K VALMQUIT
 S VALMCNT=0,VALMBG=1
 I '$D(IBPPOL) D PPOL Q:$D(VALMQUIT)
 N POLIEN
 D BLD,HDR
 Q
 ;
BLD ; -- list builder
 K ^TMP("IBCNSVP",$J),^TMP("IBCNSVPDX",$J)
 K ^TMP("IB PT POL COMMENTS",$J)
 D KILL^VALM10()
 N IBCDFND,IBCDFND1,IBCDFND2,IBCDFND4,IBCDFND5,IBCDFND7
 N DATE,B2
 S POLIEN=$P(IBPPOL,U,4)
 S IBCDFND=$G(^DPT(DFN,.312,POLIEN,0)),IBCDFND1=$G(^(1)),IBCDFND2=$G(^(2)),IBCDFND4=$G(^(4)),IBCDFND5=$G(^(5)),IBCDFND7=$G(^(7))
 S IBCDFND=$$ZND^IBCNS1(DFN,POLIEN)
 S IBCPOL=+$P(IBCDFND,U,18),IBCNS=+IBCDFND,IBCDFN=POLIEN
 ; ib*2*528  - retrieve comments - patient policy data from new multiple at 13 subscript
 S DATE="" F  S DATE=$O(^DPT(DFN,.312,POLIEN,13,"B",DATE)) Q:DATE=""  S B2=0 F  S B2=$O(^DPT(DFN,.312,POLIEN,13,"B",DATE,B2)) Q:'B2  D
 . S ^TMP("IB PT POL COMMENTS",$J,DFN,.312,POLIEN,13,B2,0)=$G(^DPT(DFN,.312,POLIEN,13,B2,0))  ; date and user ID (when and who)
 . S ^TMP("IB PT POL COMMENTS",$J,DFN,.312,POLIEN,13,B2,1)=$G(^DPT(DFN,.312,POLIEN,13,B2,1))  ;comments
 ; 
 ; retrieve group insurance plan data 
 S IBCPOLD=$G(^IBA(355.3,+$P(IBCDFND,U,18),0)),IBCPOLD1=$G(^(1))
 S IBCPOLD2=$G(^IBA(355.3,+$G(IBCPOL),6)) ;; Daou/EEN adding BIN and PCN
 S IBCPOLDL=$G(^IBA(355.3,+$G(IBCPOL),2))  ;IB*2*497  new group name and group number locations
 ;
 D INS^IBCNSP0                      ; insurance company
 D POLICY^IBCNSP0                   ; plan information
 D UR                               ; utilization review info
 D EFFECT                           ; effective dates & source of info
 D SUBSC^IBCNSP01                   ; subscriber info
 D EMP                              ; subscriber's employer info
 D PRV^IBCNSP01                     ; subscriber's provider contact info ;IB*2*497
 D SPON^IBCNSP0                     ; insured person's info
 D ID^IBCNSP01                      ; ins co ID numbers (IB*2*371)
 D PLIM                             ; plan coverage limitations
 D VER^IBCNSP01                     ; user/verifier/editor info
 D CONTACT^IBCNSP0                  ; last insurance contact
 D COMMENT                          ; comments - policy & plan
 D RIDER^IBCNSP01                   ; policy rider info
 ;
 S VALMCNT=+$O(^TMP("IBCNSVP",$J,""),-1)
 Q
 ;
COMMENT ; -- Comment region
 N START,OFFSET,IBL,IBI,IBPCOMM
 N DATE,USER,X,LN,QUIT
 S (START,IBL)=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2
 S IB1ST("COMMENT")=START
 ;
 ; -- this tmp global is used to parse the comments and wrap the comments
 S IBPCOMM=$NA(^TMP("IB COMMENTS PARSER",$J))
 K @IBPCOMM
 ;
 D SET(START,OFFSET," Comment -- Patient Policy ",IORVON,IORVOFF)
 ; ib*2*528 - include user id and date
 I '$D(^TMP("IB PT POL COMMENTS",$J)) D 
 . S IBL=IBL+1
 . D SET(IBL,OFFSET,$S($P(IBCDFND1,U,8)="":"None",1:$P(IBCDFND1,U,8)))
 E  D
 . S LN=""
 . F  S LN=$O(^TMP("IB PT POL COMMENTS",$J,DFN,.312,POLIEN,13,LN),-1) Q:LN=""  D
 . . S DATE=^TMP("IB PT POL COMMENTS",$J,DFN,.312,POLIEN,13,LN,0),USER=$P(DATE,U,2),DATE=$P(DATE,U)
 . . S IBL=IBL+1
 . . D SET(IBL,OFFSET,$$FMTE^XLFDT(DATE,2)_"  "_$S(USER:$P(^VA(200,USER,0),U),1:"UNKNOWN USER"))
 . . K PCOMM K @IBPCOMM
 . . D GCOMM(.PCOMM,.IBPCOMM,LN)
 . . S (QUIT,X)=0 F  S X=$O(@IBPCOMM@(X)) Q:'X  Q:QUIT  D
 . . . I @IBPCOMM@(X)="" S QUIT=1 Q
 . . . S IBL=IBL+1
 . . . D SET(IBL,OFFSET,@IBPCOMM@(X))
 . . S IBL=IBL+1
 . . D SET(IBL,OFFSET," ")
 S IBL=IBL+1
 D SET(IBL,OFFSET," ")
 S IBL=IBL+1
 D SET(IBL,OFFSET," Comment -- Group Plan ",IORVON,IORVOFF)
 S IBI=0 F  S IBI=$O(^IBA(355.3,+IBCPOL,11,IBI)) Q:IBI<1  D
 . S IBL=IBL+1
 . D SET(IBL,OFFSET,"  "_$E($G(^IBA(355.3,+IBCPOL,11,IBI,0)),1,80))
 . Q
 S IBL=IBL+1 D SET(IBL,OFFSET," ")
 S IBL=IBL+1 D SET(IBL,OFFSET," ")
 Q
 ;
EFFECT ; -- Effective date region
 N START,OFFSET
 S START=$O(^TMP("IBCNSVP",$J,""),-1)-6  ;ib*2*497 lines need to be displayed alongside UR region
 S OFFSET=45
 D SET(START,OFFSET-4," Effective Dates & Source ",IORVON,IORVOFF)
 D SET(START+1,OFFSET," Effective Date: "_$$DAT1^IBOUTL($P(IBCDFND,U,8)))
 D SET(START+2,OFFSET,"Expiration Date: "_$$DAT1^IBOUTL($P(IBCDFND,U,4)))
 D SET(START+3,OFFSET," Source of Info: "_$$EXPAND^IBTRE(2.312,1.09,$P($G(IBCDFND1),U,9)))
 D SET(START+4,OFFSET-4,"Policy Not Billable: "_$S($P($G(^DPT(DFN,.312,IBCDFN,3)),"^",4):"YES",1:"NO"))
 Q
 ;
UR ; -- UR of insurance region
 N START,OFFSET
 S START=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2  ;IB*2*497
 D SET(START,OFFSET," Utilization Review Info ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,"         Require UR: "_$$EXPAND^IBTRE(355.3,.05,$P(IBCPOLD,U,5)))
 D SET(START+2,OFFSET,"   Require Amb Cert: "_$$EXPAND^IBTRE(355.3,.12,$P(IBCPOLD,U,12)))
 D SET(START+3,OFFSET,"   Require Pre-Cert: "_$$EXPAND^IBTRE(355.3,.06,$P(IBCPOLD,U,6)))
 D SET(START+4,OFFSET,"   Exclude Pre-Cond: "_$$EXPAND^IBTRE(355.3,.07,$P(IBCPOLD,U,7)))
 D SET(START+5,OFFSET,"Benefits Assignable: "_$$EXPAND^IBTRE(355.3,.08,$P(IBCPOLD,U,8)))
 D SET(START+6,2," ")
 Q
EMP ; -- Insurance Employer Region   
 N OFFSET,START,IBADD,COL2
 S START=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2
 D SET(START,OFFSET," Subscriber's Employer Information ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,$$RJ^XLFSTR(" Employment Status: ",20)_$$EXPAND^IBTRE(2.312,2.11,$P(IBCDFND2,U,11)))
 S COL2=START+1
 D SET(START+2,OFFSET,$$RJ^XLFSTR("Employer: ",20)_$P(IBCDFND2,U,9))
 D SET(START+3,OFFSET,$$RJ^XLFSTR("Street: ",20)_$P(IBCDFND2,U,2)) S IBADD=1
 I $P(IBCDFND2,U,3)'="" D SET(START+4,OFFSET,$$RJ^XLFSTR("Street 2: ",20)_$P(IBCDFND2,U,3)) S IBADD=2
 I $P(IBCDFND2,U,4)'="" D SET(START+5,OFFSET,$$RJ^XLFSTR("Street 3: ",20)_$P(IBCDFND2,U,4)) S IBADD=3
 D SET(START+3+IBADD,OFFSET,$$RJ^XLFSTR("City/State: ",20)_$E($P(IBCDFND2,U,5),1,15)_$S($P(IBCDFND2,U,5)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCDFND2,U,6),0)),U,2)_" "_$E($P(IBCDFND2,U,7),1,5))
 D SET(START+4+IBADD,OFFSET,$$RJ^XLFSTR("Phone: ",20)_$P(IBCDFND2,U,8))
 D SET(START+5+IBADD,OFFSET," ")
 ;
 S START=COL2,OFFSET=40
 D SET(START,OFFSET,"Emp Sponsored Plan: "_$S(+$P(IBCDFND2,U,10):"Yes",1:"No"))
 D SET(START+1,OFFSET,"Claims to Employer: "_$S(+IBCDFND2:"Yes, Send to Employer",1:"No, Send to Insurance Company"))
 D SET(START+2,OFFSET,"   Retirement Date: "_$$DAT1^IBOUTL($P(IBCDFND2,U,12)))
 ;
EMPQ Q
 ;
PLIM ; plan coverage limitations/plan limitation category display
 N START,END S START=$O(^TMP("IBCNSVP",$J,""),-1)+1
 S IB1ST("PLIM")=START
 D LIMBLD^IBCNSC41(START,2)
 S END=$O(^TMP("IBCNSVP",$J,""),-1)  ; last line constructed
 D SET(END+1,2," ")    ; 2 blank lines to end this section
 D SET(END+2,2," ")
PLIMX ;
 Q
 ; 
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K IBPPOL,VALMQUIT,IBCNS,IBCDFN,IBCPOL,IBCPOLD,IBCPOLD1,IBCPOLD2,IBCPOLDL,IBCDFND,IBCDFND1,IBCDFND2,IBVPCLBG,IBVPCLEN
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
PPOL ; -- select patient, select policy
 I '$D(DFN) D  G:$D(VALMQUIT) PPOLQ
 .S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC
 .S DFN=+Y
 I $G(DFN)<1 S VALMQUIT="" G PPOLQ
 ;
 I '$O(^DPT(DFN,.312,0)) W !!,"Patient doesn't have Insurance" K DFN G PPOL
 ;
 S DIC="^DPT("_DFN_",.312,",DIC(0)="AEQMN",DIC("A")="Select Patient Policy: "
 D ^DIC I +Y<1 S VALMQUIT=""
 G:$D(VALMQUIT) PPOLQ
 S IBPPOL="^2^"_DFN_U_+Y_U_$G(^DPT(DFN,.312,+Y,0))
PPOLQ K DIC Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
SET(LINE,COL,TEXT,ON,OFF) ; -- set display info in array
 I '$D(@VALMAR@(LINE,0)) D BLANK(.LINE) S VALMCNT=$G(VALMCNT)+1
 D SET^VALM10(.LINE,$$SETSTR^VALM1(.TEXT,@VALMAR@(LINE,0),.COL,$L(TEXT)))
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(.LINE,.COL,$L(TEXT),$G(ON),$G(OFF))
 W:'(LINE#5) "."
 Q
 ;
GCOMM(PCOMM,IBPCOMM,LN) ; data retrived from the new patient policy - comment multiple
 ; input  - PCOMM passed by reference
 ;          IBPCOMM passed by reference
 ;          LN = subscript reference at which the comments were stored in TMP 
 ;
 ; output - PCOMM array - holds comments from 1.18, .03
 ;          IBPCOMM array - holds comments from the PCOMM array for word wrapping
 ;
 N FR,TO,I,J,IBOUT
 S FR=1,TO=78,IBOUT=0
 ;
 ; -- get the comments and put them in an array
 F I=1:1:4 D
 . I I=4 S TO=245
 . S PCOMM(I)=$E(^TMP("IB PT POL COMMENTS",$J,DFN,.312,POLIEN,13,LN,1),FR,TO)
 . S FR=TO+1
 . S TO=FR+78
 . ;
 ;
 ; -- quit if comment line is one long comment with no spaces
 I $D(PCOMM) D  Q:IBOUT
 . I $O(PCOMM(1)) D  Q:IBOUT
 . . S I=0 F  S I=$O(PCOMM(I)) Q:IBOUT!(I']"")  I $L(PCOMM(I))=78&(PCOMM(I)'[" ")  D
 . . . F J=1:1:$O(PCOMM(99),-1) S @IBPCOMM@(J)=PCOMM(J)
 . . . S IBOUT=1
 ;
 ; -- put the array into one string
 S I=0 F  S I=$O(PCOMM(I)) Q:I'>0  D
 . I I=1 S @IBPCOMM@(1)=PCOMM(1) Q
 . S @IBPCOMM@(1)=@IBPCOMM@(1)_PCOMM(I)
 ;
 ; -- go parse the string
 D TXT(.IBPCOMM) ; parse array
 Q
 ;
TXT(TXT) ; Parse text for wrapping
 ;  Input Parameter
 ;    TXT = The array name
 ;
 ;  Output:
 ;    TXT - array with wrapped text
 ;
 N X,CT,DIWF,DIWL,DIWR,DIW,DIWI,DIWT,DIWTC,DIWX,DN
 ;
 I '$D(@(TXT)) Q
 ;
 K ^UTILITY($J,"W")
 ;
 ;  -- define length of text string; left is 1 and right is 78
 S DIWF="",DIWL=1,DIWR=78
 ;
 ;  -- format text into scratch file
 S CT=0
 F  S CT=$O(@(TXT)@(CT)) Q:'CT  D
 . S X=@TXT@(CT) D ^DIWP
 ;
 K @(TXT)
 ;
 ;  -- reset formatted text back to array
 S CT=0
 F  S CT=$O(^UTILITY($J,"W",1,CT)) Q:'CT  D
 . S @(TXT)@(CT)=^UTILITY($J,"W",1,CT,0)
 ;
 K ^UTILITY($J,"W")
 Q
