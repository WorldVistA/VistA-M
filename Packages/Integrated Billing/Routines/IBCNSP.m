IBCNSP ;ALB/AAS - INSURANCE MANAGEMENT - EXPANDED POLICY ;05-MAR-1993
 ;;2.0;INTEGRATED BILLING;**6,28,43,52,85,251,363,371,416,497,516,528,549**;21-MAR-94;Build 54
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
 N DOD,IBDOB,IBNAME,W,X,Y,Z                 ; IB*2.0*549 Added DOD
 S IBNAME=^DPT(DFN,0)                       ; Direct global read on file 2 supported by IA 10035
 S IBDOB=$P(IBNAME,"^",3)
 S IBNAME=$E($P(IBNAME,U),1,20)
 ;
 ; IB*2.0*549 Shortened 'Expanded Policy Information For ' to 'For: ' below
 S VALMHDR(1)="For: "_IBNAME_"  "_$P($$PT^IBEFUNC(DFN),U,2)_"  "_$$FMTE^XLFDT(IBDOB,"5DZ")
 ;
 ; IB*2.0*549 Added next 4 lines
 S DOD=$$GET1^DIQ(2,DFN_",",.351,"I")
 I DOD'="" D
 . S DOD=$$FMTE^XLFDT(DOD,"5DZ")
 . S VALMHDR(1)=VALMHDR(1)_"    DoD: "_DOD
 S Z=$G(^DPT(DFN,.312,+$P(IBPPOL,U,4),0))
 S W=$P($G(^IBA(355.3,+$P(Z,U,18),0)),U,11)
 S Y=$E($P($G(^DIC(36,+Z,0)),U),1,20)_" Insurance Company"
 S X="** Plan Currently "_$S(W:"Ina",1:"A")_"ctive **"
 S VALMHDR(2)=$$SETSTR^VALM1(X,Y,48,29)
 Q
 ;
INIT ; -- init variables and list array
 K VALMQUIT
 S VALMCNT=0,VALMBG=1
 I '$D(IBPPOL) D PPOL Q:$D(VALMQUIT)
 D BLD,HDR
 Q
 ;
BLD ; -- list builder
 K ^TMP("IBCNSVP",$J),^TMP("IBCNSVPDX",$J)
 D KILL^VALM10()
 N IBCDFND,IBCDFND1,IBCDFND2,IBCDFND4,IBCDFND5,IBCDFND7
 S IBCDFND=$G(^DPT(DFN,.312,$P(IBPPOL,U,4),0)),IBCDFND1=$G(^(1)),IBCDFND2=$G(^(2)),IBCDFND4=$G(^(4)),IBCDFND5=$G(^(5)),IBCDFND7=$G(^(7))
 ; MRD;IB*2.0*516 - Use $$ZND^IBCNS1 to pull zero node of 2.312.
 S IBCDFND=$$ZND^IBCNS1(DFN,$P(IBPPOL,U,4))
 S IBCPOL=+$P(IBCDFND,U,18),IBCNS=+IBCDFND,IBCDFN=$P(IBPPOL,U,4)
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
 ;
 ;IB*2.0*549 Removed next line
 ;D CONTACT^IBCNSP0                  ; last insurance contact
 D COMMENT                          ; comments - policy & plan
 D RIDER^IBCNSP01                   ; policy rider info
 ;
 S VALMCNT=+$O(^TMP("IBCNSVP",$J,""),-1)
 Q
 ;
COMMENT ; -- Comment region
 ; Input:   DFN                 - IEN of the currently selected patient
 ;          IBCPOL              -
 ;          IBPPOL              - O node of the selected Patient Policy
 ;          ^TMP("IBCNSVP",$J)  - Current global Array of display lines
 ; Output:  IB1ST("COMMENT")    - 1st line of comments display
 ;          ^TMP("IBCNSVP",$J)  - Updated global Array of display lines
 ;
 ;IB*2.0*549 Moved Group Plan Comment above Patient Policy Comment. Changed
 ;           Patient Policy Comment to display the two most recent comments
 ;           in the patient policy comment multiple (2.342,1.18)
 N COMDT,COMIEN,COMCTR,COMSTOP,IBI,IBIIEN,IBL,OFFSET,XX
 S IBL=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=2
 S IB1ST("COMMENT")=IBL
 ;
 ; Display Group Plan Comment 
 D SET(IBL,OFFSET," Comment -- Group Plan ",IORVON,IORVOFF)
 S IBI=0
 F  S IBI=$O(^IBA(355.3,+IBCPOL,11,IBI)) Q:IBI<1  D
 . S IBL=IBL+1
 . D SET(IBL,OFFSET," "_$E($G(^IBA(355.3,+IBCPOL,11,IBI,0)),1,80))
 S IBL=IBL+1
 D SET(IBL,OFFSET," ")
 ;
 ; Display Last two Patient Policy Comments
 S IBIIEN=$P(IBPPOL,"^",4),IBL=IBL+1
 D SET(IBL,OFFSET," Comment -- Patient Policy ",IORVON,IORVOFF)
 S IBL=IBL+1,XX=" Dt Entered  Entered By                Method     Person Contacted"
 S XX=XX_$J("",78-$L(XX))
 D SET(IBL,OFFSET,XX,IOUON,IOUOFF)
 S COMDT="",(COMCTR,COMSTOP)=0
 F  D  Q:(COMDT="")!COMSTOP
 . S COMDT=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT),-1)
 . Q:COMDT=""
 . S COMIEN=""
 . F  D  Q:(COMIEN="")!COMSTOP
 . . S COMIEN=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT,COMIEN),-1)
 . . Q:COMIEN=""
 . . S COMCTR=COMCTR+1
 . . I COMCTR>2 S COMSTOP=1 Q
 . . I COMCTR=2 D
 . . . S IBL=IBL+1
 . . . D SET(IBL,OFFSET," ")
 . . D DISPPPC(.IBL,DFN,IBIIEN,COMIEN)          ; Display Patient Policy Comment
 ;
 ; Add two blank lines at end
 S IBL=IBL+1
 D SET(IBL,OFFSET," ")
 S IBL=IBL+1
 D SET(IBL,OFFSET," ")
 Q
 ;
DISPPPC(IBL,DFN,IBIIEN,COMIEN) ; Display one Patient Policy Comment
 ;IB*2.0*549 - Added sub-routine
 ; Input:   IBL                 - Current Display Line Counter
 ;          DFN                 - IEN of the currently selected patient
 ;          IBIIEN              - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                                multiple IEN of the selected patient policy
 ;          COMIEN              - ^DPT(DFN,.312,IBIIEN,13,COMIEN,0) Where 
 ;                                COMIEN is the multiple IEN of the selected
 ;                                Patient Policy Comment
 ;          ^TMP("IBCNSVP",$J)  - Current global Array of display lines
 ; Output:  IBL                 - Updated Display Line Counter
 ;          ^TMP("IBCNSVP",$J)  - Updated global Array of display lines
 N COMDATA,LINE,XX,ZZ
 S COMDATA=$$GETONEC^IBCNCH2(DFN,IBIIEN,COMIEN,0,77,0,1)
 S LINE=$P(COMDATA,"^",1)_"    "
 S XX=$P(COMDATA,"^",2),ZZ=$J("",26-$L(XX))
 S LINE=LINE_XX_ZZ
 S XX=$P(COMDATA,"^",4),ZZ=$J("",11-$L(XX))
 S LINE=LINE_XX_ZZ_$P(COMDATA,"^",3),IBL=IBL+1
 D SET(IBL,OFFSET,LINE)
 S IBL=IBL+1,LINE=" "_$P(COMDATA,"^",8)
 D SET(IBL,OFFSET,LINE)
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
 ;
 ;IB*2.0*549 Changed OFFSET-4 to OFFSET-8
 ;           Changed 'Policy Not Billable' to 'Stop Policy From Billing'
 D SET(START+4,OFFSET-9,"Stop Policy From Billing: "_$S($P($G(^DPT(DFN,.312,IBCDFN,3)),"^",4):"YES",1:"NO"))
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
 ; ib*2*497 move employer lines around
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
 D SET(START+5+IBADD,OFFSET," ")  ; ib*2*497  only 1 blank line to end the section
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
