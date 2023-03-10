ORVCODATA02 ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:05:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;DEC 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
DISCL(DFN) ; disclaimer
 N DATA,HDR,I S HDR="HDR"_$S(+$G(RMD):1,1:"")
 F I=1:1 S DATA=$P($T(@HDR+I),";;",2) Q:DATA="EOM"  D
 . I DATA["[" D
 . . N REP S REP("[DATE]")=$$FMTE^XLFDT($$NOW^XLFDT),REP("[PFAC]")=PFAC S DATA=$$REPLACE^XLFSTR(DATA,.REP)
 . . N X S X="",$P(X," ",80-$L(DATA))="*",DATA=DATA_X
 . D ADDTXT(DATA)
 Q
HDR ; disclaimer information top of document
 ;;********************************************************************************
 ;;*  Disclaimer                                                                  *
 ;;*  ==========                                                                  *
 ;;*  This EHRM CUTOVER DOCUMENT contains pertinent patient information as of     *
 ;;*  [DATE] from [PFAC] CPRS.
 ;;*
 ;;*  No REMOTE data is included in this document and it should be used for       *
 ;;*  reference purposes only.  The Joint Longitudinal Viewer (JLV) should be     *
 ;;*  used to access the complete record of local, remote, DoD, and Cerner data.  *
 ;;*                                                                              *
 ;;*  Most new patient data exists in the new EHRM.  Note that this is an         *
 ;;*  Administrative document to assist providers who are seeing patients using   *
 ;;*  the new EHRM.  If there are multiple EHRM Cutover Reports, please refer to  *
 ;;*  the document with the most current date/time.                               *
 ;;*                                                                              *
 ;;*  For Clinical Reminder information, see the document entitled:               *
 ;;*      EHRM CUTOVER REMINDERS [PFAC]
 ;;*                                                                              *
 ;;********************************************************************************
 ;;
 ;;EOM
HDR1 ; clinical reminder disclaimer top of document
 ;;********************************************************************************
 ;;*  Disclaimer                                                                  *
 ;;*  ==========                                                                  *
 ;;*  This EHRM CUTOVER DOCUMENT contains the Clinical Reminder data as of        *
 ;;*  [DATE] from [PFAC] CPRS.
 ;;*                                                                              *
 ;;*  New patient data exists in the new EHRM.  Note that this is an              *
 ;;*  Administrative document to assist providers who are seeing patients using   *
 ;;*  the new EHRM to aid in transitioning CPRS Reminders due to the new system's *
 ;;*  Clinical Recommendations.                                                   *
 ;;*                                                                              *
 ;;********************************************************************************
 ;;
 ;;EOM
 Q
ADDTXT(DATA) ;
 S DOCTXT=DOCTXT+1
 S DOCTXT(DOCTXT,0)=DATA
 Q
PAST(DFN) ; past outpatient encounters
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 D ADDTXT("Past Appointments"),ADDTXT("=================")
 N DATA,END,GBL,IEN,VDT S END=$$FMADD^XLFDT(DT,-1096) ; go back 3 years
 N VAERR,VAROOT,VASD S VAROOT="Data",VASD("F")=END,VASD("T")=DT,VASD("W")=123456789 D SDA^VADPT
 N I S I=0 F  S I=$O(@VAROOT@(I)) Q:'+I  S VDT=$P(@VAROOT@(I,"I"),U) D
 . S DATA(9999999-VDT)=VDT_U_$P(@VAROOT@(I,"E"),U,2,3)
 S VDT=$$NOW^XLFDT,GBL="^SCE" F  S VDT=$O(@GBL@("ADFN",DFN,VDT),-1) Q:'+VDT!(VDT<END)  S IEN=0 F  S IEN=$O(@GBL@("ADFN",DFN,VDT,IEN)) Q:'+IEN  D
 . N NODE0 S NODE0=$G(@GBL@(IEN,0)) Q:NODE0=""
 . N RDT S RDT=9999999-VDT Q:$D(DATA(RDT))
 . Q:$P(NODE0,U,6)'=""
 . I $P(NODE0,U,4) N GBL S GBL="^SC" Q:+$G(@GBL@($P(NODE0,U,4),"OOS"))
 . N GBL,CSC,LOC S GBL="^DIC(40.7)",CSC=$P(NODE0,U,3),CSC=$P($G(@GBL@(CSC,0)),U),LOC=$P(NODE0,U,4),GBL(1)="^SC",LOC=$P($G(@GBL(1)@(LOC,0)),U)
 . S DATA(RDT)=VDT_U_$S(LOC'="":LOC,1:CSC)_U_"Unscheduled"
 S VDT=0 F  S VDT=$O(DATA(VDT)) Q:'+VDT  D
 . S DATA=$TR($$FMTE^XLFDT(+DATA(VDT),"5MZ"),"@"," "),DATA=$$SETSTR^VALM1($P(DATA(VDT),U,2),DATA,19,56),DATA=$$SETSTR^VALM1($P(DATA(VDT),U,3),DATA,58,21)
 . D ADDTXT(DATA)
 I '$D(@VAROOT),'$D(DATA) D ADDTXT("No past appointments found.") D ADDTXT("")
 K @VAROOT
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Past Visits [CPU]")=+$G(@INF@(" Duration","Past Visits [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Past Visits [SECS]")=+$G(@INF@(" Duration","Past Visits [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
RMDRS(DFN) ; coversheet reminders
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N CNT,DILOCKTM,DISYS,GBL,I,LIST,LOC,NODISC,SEPDTO,XMDUN,XMMG,XPARSYS
 S GBL="^DPT",GBL(1)="^DIC(42)"
 S LOC=$G(@GBL@(DFN,.1)) S:$L(LOC) LOC=+$G(@GBL(1)@(+$O(@GBL(1)@("B",LOC,0)),44)) ; icr #10035
 D APPL^ORQQPXRM(.LIST,DFN,LOC) Q:'$D(LIST)
 D ADDTXT("Clinical Reminders")
 D ADDTXT("==================")
 S I=0 F  S I=$O(LIST(I)) Q:'+I  D
 . I $P(LIST(I),U,6)'=1 Q
 . N X S X=$$SETSTR^VALM1($P(LIST(I),U,2),"",1,50)
 . N Y S Y=$P(LIST(I),U,3),Y=$S(+Y:$$FMTE^XLFDT(Y),Y="DUE NOW":"Due as of "_$$FMTE^XLFDT(DT),1:Y)
 . S X=$$SETSTR^VALM1(Y,X,55,$L(Y))
 . D ADDTXT(X)
 I '$D(LIST) D ADDTXT("No clinical reminders found.")
 D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Reminders [CPU]")=+$G(@INF@(" Duration","Reminders [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Reminders [SECS]")=+$G(@INF@(" Duration","Reminders [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
