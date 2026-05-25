TIUMOBJLM ;XAN/AJB - MEDICATION OBJECT LIST MANAGER ;Aug 29, 2025@09:15:27
 ;;1.0;TEXT INTEGRATION UTILITIES;**372**;Jun 20, 1997;Build 5
 ;
 ; Reference to *^%ZIS in ICR #10086
 ; Reference to ^DIC in ICR #10006
 ; Reference to ^DIM in ICR #10016
 ; Reference to ^DIR in ICR #10026
 ; Reference to ^DPT( in ICR #10035
 ; Reference to *^VALM in ICR #10118
 ; Reference to *^VALM1 in ICR #10116
 ; Reference to *^VALM10 in ICR #10117
 ; Reference to *^XGF in ICR #3173
 ; Reference to *^XLFDT in ICR #10103
 ; Reference to *^XLFSTR in ICR #10104
 ; Reference to *^XPAR in ICR #2263
 ; Reference to *^XQORM1 in ICR #10102
 ;
 Q
ASK(ACT) ; list manager default entry for numeric input
 Q:VALMCNT=0  D FULL^VALM1 G MEDREC:ACT="MEDREC"
 S ACT(1)=+$P(XQORNOD(0),"=",2) S:'ACT(1) ACT(1)=$$FMR("NAO^1:"_VALMLST_":0","Select Object (1-"_VALMLST_"): ") Q:'ACT(1)
 S ACT=ACT_"("_$O(@VALMAR@("IDX",ACT(1),""))_")"
 D @ACT
 Q
EN ; main entry point
 N %,%DT,C,DISYS,HV0,HV1,IOINHI,IOINORM,IORVOFF,IORVON,IOUOFF,IOUON,POP,RV0,RV1,UL0,UL1,VAR,XPARSYS,XQXFLG,X
 D HOME^%ZIS D PREP^XGF
 S HV0=IOINORM,HV1=IOINHI,UL0=IOUOFF,UL1=IOUON,RV1=IORVON,RV0=IORVOFF
 D EN^VALM("TIUMOBJ MANAGER")
 Q
LMEXIT ; exit
 D CLEAN^XGF
 Q
LMHELP(VALMANS) ; help
 S:VALMANS="??" VALMANS=""
 D CLS^TIUMOBJLM
 W "Selectable Actions:",!!,HV1_"Create Medication Object:"_HV0_" Prompts user for medication parameters and creates",!,"                          a new object without requiring programmer access.",!!
 W HV1_"Med Rec Object Auto Fix:"_HV0_"  Prompts user to automatically set the new",!,"                          Med Rec/TIUDATE parameter for only Med Rec Objects.",!
 W "                          After entering 'YES', prompts for desired parameter",!,"                          value and confirmation to begin update.",!!
 W HV1_"Detailed Display/Edit:"_HV0_"  Displays object information and allows user to update",!,"                        the status, print the details, test the output, and",!
 W "                        update the medication specific parameters.",!!,HV1_"Parameter TIUMOBJ On/Off:"_HV0_"  Toggles the TIUMOBJ STATUS parameter On/Off.",!
 W "                           This alters the behavior of objects to use the ",!,"                           original TIULMED* routines [OFF] or the updated",!
 W "                           TIUMOBJ routine [ON].  'Indication' will only be",!,"                           shown when the paremter value is set to ON.",!!
 W HV1_"Readme.txt:"_HV0_"  Medication Objects 101 + Developer's Notes."
 D IOSL^TIUMOBJLM,CLS^TIUMOBJLM,HKEYS^TIUMOBJLM,IOSL^TIUMOBJLM,LMHDR^TIUMOBJLM S VALMANS="",VALMBCK="R"
 Q
LMHDR ; header
 S VALMHDR(2)=$$CJ^XLFSTR("TIUMOBJ Parameter Value",80)
 S VALMHDR(3)=$$SETSTR("Med",$$CJ^XLFSTR("[Status: "_$S($$GET^XPAR("SYS","TIUMOBJ STATUS"):" "_RV1_"ON",1:RV1_"OFF")_RV0_"]",88),78,3)
 S VALMSG="?Help                   PS/PL Print            +/-"
 S XQORM("#")=$O(^ORD(101,"B","TIUMOBJ DISPLAY OBJECT",0))_U_"1:"_VALMCNT,XQORM("??")="D LMHELP^TIUMOBJLM(.VALMANS)"
 Q
LMINIT(VAR,VALMCNT) ; build list
 N IEN,NAME S (VAR("medRec"),VALMCNT)=0,NAME="" F  S NAME=$O(^TIU(8925.1,"B",NAME)) Q:NAME=""  S IEN=0 F  S IEN=$O(^TIU(8925.1,"B",NAME,IEN)) Q:'IEN  D
 . Q:'$D(^TIU(8925.1,"AT","O",IEN))  N N S N(0)=$G(^TIU(8925.1,IEN,0)) Q:$P(N(0),U)=""  S N(9)=$G(^TIU(8925.1,IEN,9)) Q:$S(N(9)["^TIULMED":0,N(9)["^TIUMOBJ":0,1:1)
 . S VALMCNT=VALMCNT+1 S:N(9)["TIUDATE" VAR("medRec",IEN)="",VAR("medRec")=VAR("medRec")+1
 . S N=$$SETFLD^VALM1(VALMCNT,"","NUMBER"),N=$$SETFLD^VALM1($P(N(0),U),N,"NAME"),N=$$SETFLD^VALM1($S(N(9)["TIUDATE":" *",1:""),N,"MEDR"),N=$$SETFLD^VALM1($S($P(N(0),U,7)=11:"  YES",1:"   NO"),N,"STATUS")
 . D SET^VALM10(VALMCNT,N,IEN)
 Q
HKEYS ; hidden menu keys
 W !,"The following actions are also available:"
 N XQORM,ORULT S XQORM=$O(^ORD(101,"B",$P(VALMKEY,U,2),0))_";ORD(101,"
 D DISP^XQORM1:XQORM
 Q
CROBJ ; create object
 D CLS N P D PASK(.P) Q:'$D(P)
 I $$FMR("YAO"," Would you like to make this a 'Med Rec' object? ","YES","^D HELP^TIUMOBJLM($X,$Y,"" Enter either 'Y' or 'N'. '^' to exit."")") D CLS,MEDREC^TIUMOBJ2(.P)
 D CLS
 W UL1_$$CJ^XLFSTR("Medication Object Creator",IOM)_UL0,!!
 I $D(P("TIUDATE")) D TIUDATE^TIUMOBJ2(P("TIUDATE"))
 W "Selected Parameter Values",!,"=========================",!
 D DPAR(.P),IOXY^XGF($Y,0)
 G EX:'$$FMR("YAO"," Create a new medication object with these parameters? ","NO","^D HELP^TIUMOBJLM($X,$Y,"" Enter either 'Y' or 'N'. '^' to exit."")")
 D CLS,IOXY^XGF($Y+1,0)
 S P("Name")=$$OASK($X,$Y)
 G EX:$L(P("Name"))<3
 D CLEAR^XGF($Y+1,0,$Y+1,130),IOXY^XGF($Y,0)
 G EX:'$$FMR("YAO"," Create this object now? ","NO","^D HELP^TIUMOBJLM($X,$Y,"" Enter either 'Y' or 'N'. '^' to exit."")")
 S P("IEN")=$$CROBJ^TIUCROBJ(P("Name"),"","",P("OBJM"))
 I P("IEN") D CLEAR^XGF($Y+2,0,$Y+2,IOM),IOXY^XGF($Y,1) W P("Name")_" object created successfully."
 E  W !!?1,$P(P("IEN"),U,2) G EX
 D REBLD
EX D IOSL
 Q
CHGSTAT(IEN,N) ;
 D IOXY^XGF($Y-1,25)
 Q:'$$FMR("YAO",$S($P(N(0),U,7)=11:"INACTIVATE",1:"ACTIVATE")_" this object now? ","YES","^D HELP^TIUMOBJLM($X,$Y,""Enter either 'Y' or 'N'. '^' to exit."")")
 S $P(^TIU(8925.1,IEN,0),U,7)=$S($P(N(0),U,7)=11:13,1:11)
 Q
DISPLAY(IEN) ; detailed display
 Q:'IEN  I '$D(^TIU(8925.1,IEN)) D REBLD Q
 N INPUT,N,OPT,P,PAR,PARS,PNUM,X
D2 ; redisplay
 D CLS
 D EXTRACT(IEN,.N,.P)
 S PARS=$P($T(PARAMETERS),";",2)
 F PNUM=1:1:$L(PARS,U) S PAR=$P(PARS,U,PNUM),P(PAR)=$P(P(3),",",PNUM)
 D DHDR(.N) D DPAR(.P)
 W !,RV1_$$SETSTR("   'def' indicates no parameter value set, default shown","",0,80)_RV0,!,$$SETSTR("Test Object","     Change Status",45,11)
 W !,$$SETSTR("Update Parameters","     Print Object",45,17),! S OPT="CHANGE STATUS PRINT OBJECT TEST OBJECT UPDATE PARAMETERS"
 F  D  Q:$D(INPUT)
 . D IOXY^XGF($Y,0) S INPUT=$$UP($E($$FMR("FAO^1:30^S X=$$UP^TIUMOBJLM(X) K:$S(OPT[X:0,""QUIT""[X:0,1:1) X","Select Action: ","Quit","^D HELP^TIUMOBJLM($X,$Y,""Enter 'C', 'P', 'T', or 'U'. '^' to exit."")")))
 D:INPUT="C" CHGSTAT(IEN,.N) D:INPUT="T" CLS,TEST(IEN) D:INPUT="U" CLS,UPDATE(IEN) D:INPUT="P"
 . N ZTSAVE S ZTSAVE("IEN")="",ZTSAVE("PARS")="" D IOXY^XGF($Y+1,0),EN^XUTMDEVQ("POBJ^TIUMOBJLM("_IEN_","""_PARS_""")","Print Med Object",.ZTSAVE)
 G D2:INPUT="C"!(INPUT="P")!(INPUT="T")!(INPUT="U")
 Q
MEDREC ; med rec auto fix
 D CLS W UL1_$$CJ^XLFSTR("Medication Reconciliation Auto Fix",IOM)_UL0,!!
 N NOW,P,PAR
 D MEDFIX^TIUMOBJ2(HV0,HV1)
 Q:'$$FMR("YAO"," Select the new parameter value and update the Med Rec objects? ","YES","^D HELP^TIUMOBJLM($X,$Y,"" Enter either 'Y' or 'N'. '^' to exit."")")
 S NOW=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 D CLS,PASK(.P,7) Q:'$D(P)  S PAR=P("MR") D CLS
 W HV1_"Object Method Update"_HV0,$$RJ^XLFSTR(NOW,IOM-20),!
 W UL1_$$CJ^XLFSTR("Medication Reconciliation Auto Fix",IOM)_UL0,!!
 W " # of Medication",!," Reconciliation Objects:",?30,VAR("medRec"),!!
 W " Med Rec/TIUDATE Fix Value:",?30,P("MR")_$S(P("MR"):"  Include TIUDATE [default]",1:"  Exclude TIUDATE")
 D IOXY^XGF($Y+1,0) Q:'$$FMR("YAO"," Begin the update process? ","NO","^D HELP^TIUMOBJLM($X,$Y,"" Enter either 'Y' or 'N'. '^' to exit."")")
 D CLEAR^XGF($Y-1,0,$Y+3,130),IOXY^XGF($Y-3,0)
 N IEN,NUM S (IEN,NUM)=0 F  S IEN=$O(VAR("medRec",IEN)) Q:'IEN  D
 . N P,REP S NUM=NUM+1
 . D EXTRACT(IEN,,.P)
 . S $P(P(3),",",7)=PAR
 . S REP(P("Parameters"))=P(1)_","""_P(2)_""","_P(3)
 . S P("Update")=$$REPLACE^XLFSTR(P("Method"),.REP)
 . S ^TIU(8925.1,IEN,9)=P("Update")
 . D IOXY^XGF($Y,1) W "Objects Complete: ",?30,NUM
 W "     Done."
 D IOSL
 Q
README ;
 D README^TIUMOBJ2
 Q
TEST(IEN) ; test medication object
 Q:'IEN  I '$D(^TIU(8925.1,IEN)) D REBLD Q
 N DFN,X,Y S DFN=+$$GETPT() Q:DFN'>0
 D CLS
 S X=$G(^TIU(8925.1,IEN,9))
 I '$$VALIDM(X) W "Syntax error in method." D IOSL Q
 ; execute method
 X X
 S X=$P(X,"~@",2),Y=0
 F  S Y=$O(@X@(Y)) Q:'Y  W @X@(Y,0),!
 K @X
 D IOSL
 Q
UPDATE(IEN) ; update medication object
 Q:'IEN  I '$D(^TIU(8925.1,IEN)) D REBLD Q
 N N,NOW,P,REP S NOW=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12))
 D EXTRACT(IEN,.N,.P),PASK(.P) Q:'$D(P)
 ; set replacement of current parameters for user selected parameters
 S REP(P("Parameters"))=P(1)_","""_P(2)_""","_P
 S REP("^TIUMOBJ(")="^TIULMED("
 I P("Method")["TIUDATE" D UPDTMR^TIUMOBJ2(.P,.REP)
 S P("Update")=$$REPLACE^XLFSTR(P("Method"),.REP) K REP
 W HV1_"Object Method Update"_HV0,$$RJ^XLFSTR(NOW,IOM-20),!!,UL1_$$CJ^XLFSTR("Object "_P("Name"),IOM)_UL0,!!,"Current Method:",!!
 S REP(P(1))="<no change>",REP(P(1)_",")="",REP(""""_P(2)_""",")="<no change>,"
 W $$REPLACE^XLFSTR(P("Method"),.REP),!!,"Updated Method:",!!,$$REPLACE^XLFSTR(P("Update"),.REP),!
 I $$REPLACE^XLFSTR(P("Method"),.REP)=$$REPLACE^XLFSTR(P("Update"),.REP) W !,"No updates needed." G EXU
 I $$FMR("YAO","Update this object's method with these parameters? ","NO","^D HELP^TIUMOBJLM(,$Y,""Enter either 'Y' or 'N'."")") D
 . S ^TIU(8925.1,IEN,9)=P("Update") W "     Done."
EXU D IOSL
 Q
 ; utility functions
CLS D CLEAR^VALM1 Q
 ;
DHDR(N) ; object detailed display
 ;;$S(IOST["C-":HV1,1:"")_"Detailed Display"_$S(IOST["C-":HV0,1:"")_$$RJ^XLFSTR($$FMTE^XLFDT($E($$NOW^XLFDT,1,12)),IOM-16)
 ;;$S(IOST["C-":UL1,1:"")_$$CJ^XLFSTR("Object: "_$P(N(0),U),IOM)_$S(IOST["C-":UL0,1:"")
 ;;?9,"IEN:",?15,IEN,?40,"Status:",?48,$S($P(N(0),U,7)=11:"ACTIVE",1:"INACTIVE")
 ;;"Abbreviation:",?15,$P(N(0),U,2),?41,"Owner:",?48,$E($S($P(N(0),U,5):$$GET1^DIQ(200,$P(N(0),U,5)_",",.01),1:$$GET1^DIQ(8930,$P(N(0),U,6)_",",.01)),1,30)
 ;;""
 ;;$S(IOST["C-":UL1,1:"")_"Technical Details"_$S(IOST["C-":UL0,1:"")
 ;;?6,"Method:",?15,$E(N(9),1,65)
 ;;?15,$S($E(N(9),66,$L(N(9)))'="":$E(N(9),66,$L(N(9))),1:"")
 ;;$S(IOST["C-":UL1,1:"")_"Medication Parameters"_$S(IOST["C-":UL0,1:"")
 ;;EOM
 N X,Y F X=1:1 S Y=$P($T(DHDR+X),";;",2) Q:Y="EOM"  W @Y,!
 Q
DPAR(P) ; display parameter values
 N PAR,PLIST,PNUM
 S PLIST=$P($T(PARAMETERS),";",2) F PNUM=1:1:$L(PLIST,U) S PAR=$P(PLIST,U,PNUM) D
 . W ?$S($L(PAR)=1:2,1:1),PAR,"=",$S(P(PAR)="":"def",1:P(PAR)),?9
 . I PAR="A" W $S('P(PAR):"Active & Recently Expired",P(PAR)=1:"Active",P(PAR)=2:"Recently Expired")
 . I PAR="D" W $S('P(PAR):"Standard",1:"Detailed")_" Output"
 . I PAR="M",P(PAR)<4 W $S('P(PAR):"Inpatient or Outpatient [Based on Patient Status]",P(PAR)=1:"Inpatient, Outpatient, Clinic, & Non-VA",P(PAR)=2:"Inpatient",P(PAR)=3:"Outpatient")_" Medications"
 . I PAR="M",P(PAR)>3 W $S(P(PAR)=4:"Clinic",P(PAR)=5:"Inpatient & Clinic",P(PAR)=6:"Outpatient & Clinic",P(PAR)=7:"Non-VA")_" Medications"
 . I PAR="O" W "Sort by Type [Clinic, Inpatient, Outpatient, & Non-VA]" W:'P(PAR) ", and Status"
 . I PAR="SC" W "and Sort by"_$S('P(PAR):" Name",1:" Class") W:P(PAR)=2 " and Display Class in Header"
 . I PAR="SU" W $S('P(PAR):"Exclude",1:"Include")_" Supplies"
 . I PAR="MR" W $S(P(PAR)=""!(P(PAR)):"Include",1:"Exclude")_" TIUDATE value when calling OCL^PSOORRL"
 . W !
 I $D(P("TIUDATE")) S P("OBJM")="S TIUDATE="""_P("TIUDATE")_""",X=$$LIST^TIULMED(DFN,""OUTPUT"","_P("A")_","_P("D")_","_P("M")_","_P("O")_","_P("SC")_","_P("SU")_","_P("MR")_")"
 E  S P("OBJM")="S X=$$LIST^TIULMED(DFN,""OUTPUT"","_P("A")_","_P("D")_","_P("M")_","_P("O")_","_P("SC")_","_P("SU")_","_P("MR")_")"
 Q
EXTRACT(IEN,N,P) ; parameters from method
 ; returns N(0),N(9) nodes
 ;         P(1)=patient,P(2)=return loc,P(3)=csv of med parameters
 ;         P("Name")=object name
 ;         P("Method")=object method
 ;         P("Parameters")=complete med parameters only
 N PAR,REP
 S N(0)=$G(^TIU(8925.1,IEN,0)) Q:$P(N(0),U)=""  S P("Name")=$P(N(0),U)
 S N(9)=$G(^TIU(8925.1,IEN,9)) S P("Method")=N(9)
 S PAR=$P(N(9),"X=$$LIST^",2)
 S PAR=$P(PAR,")",1,$L(PAR,")")-1)
 S PAR=$P(PAR,"(",2,$L(PAR,"("))
 S P("Parameters")=PAR,(P(1),P(2),P(3))=""
 S P(1)=$P(PAR,",") S:P(1)'="" REP(P(1))="",PAR=$$REPLACE^XLFSTR(PAR,.REP) K REP
 S P(2)=$P(PAR,"""",2,$L(PAR,"""")-1)
 S P(2)=$S(P(2)="":"OUTPUT",1:P(2)) S REP(P(2))="",PAR=$$REPLACE^XLFSTR(PAR,.REP) K REP
 S P(3)=$P(PAR,",",3,9)
 Q
FMR(DIR,PRM,DEF,HLP,SCR) ; FM reader, PRM format:  <#>;Prompt to auto indent #
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR=$G(DIR),DIR(0)=$G(DIR(0),DIR) Q:DIR(0)="" ""
 I $G(PRM)'="" S DIR("A")=$S(PRM:$P(PRM,";",2),1:PRM) I PRM S DIR("A")=$$SETSTR(DIR("A"),"",+PRM,$L(DIR("A")))
 I $G(DEF)'="" S DIR("B")=DEF
 I $G(HLP)'="" S DIR("?")=HLP
 I $G(SCR)'="" S DIR("S")=SCR
 I $P(DIR(0),U)["S",$G(HLP)'="" S DIR("L")=HLP
 M DIR=HLP
 D ^DIR
 Q Y
GETPT() ; prompt user for patient
 N %H,%I,DIC,DILOCKTM,DISYS,DTOUT,DUOUT,X,Y
 S DIC=2,DIC(0)="AEIMQ",DIC("A")=" Select PATIENT NAME: " D ^DIC
 Q Y
HELP(COL,ROW,MSG) ; general help
 D IOXY^XGF(ROW+1,$G(COL,0)) W MSG
 N X,Y S Y=+$O(MSG(""),-1),X=0 F  S X=$O(MSG(X)) Q:'X  W !?30,MSG(X)
 D IOXY^XGF(ROW-3,0)
 D CLEAR^XGF(ROW-1,0,ROW-1,80)
 D IOXY^XGF(ROW-3,0)
 Q
IOSL F  Q:$Y>(IOSL-3)  W !
 I $$FMR("EA"," Press <Enter> or '^' to continue.")
 Q
OASK(COL,ROW) ; prompt user for object name
 N RESULT F  D  Q:$D(RESULT)
 . D CLEAR^XGF(ROW+1,0,ROW+1,IOM)
 . D IOXY^XGF(ROW,0) S RESULT=$$UP($$FMR("FAO^3:60^K:'(X'?1P.E) X"," Enter the Object Name:  ","","^D HELP^TIUMOBJLM($X,$Y,"" Object NAME must be 3-60 characters, not start with punctuation, and be unique."")")) Q:RESULT=""
 . I $$CHKNAME^TIUCROBJ(RESULT,"B;C;D") D IOXY^XGF(ROW+3,0) W $$SETSTR(RESULT_" is already in use.","",2,IOM) K RESULT
 Q RESULT
PARAMETERS ;A^D^M^O^SC^SU^MR; medication object parameters
PASK(P,PS) ; prompt user for medication object parameters, ps=parameter start
 ; returns P(<parameter>)=individual parameter value
 ;                      P=csv of selected parameters
 N PAR,PLIST,PNUM S P(3)=$G(P(3)),PS=$G(PS,1)
 S PLIST=$P($T(PARAMETERS),";",2) F PNUM=PS:1:$L(PLIST,U) S PAR=$P(PLIST,U,PNUM) D  Q:P(PAR)=U
 . N DEF,LINE,LNUM,RNG F LNUM=1:1 S LINE=$P($T(@PAR+LNUM),";;",2) Q:LINE="EOM"  D
 . . I LNUM=1 D IOXY^XGF(LNUM,30) W "Parameter "_PNUM_" (of "_$L(PLIST,U)_"):"
 . . D IOXY^XGF(LNUM+2,30) W LINE
 . S DEF=$S($P(P(3),",",PNUM):$P(P(3),",",PNUM),PAR="SU"!(PAR="MR"):1,1:0),RNG=$P($T(@PAR),";;",2)
 . S P(PAR)=$$FMR("NOA^0:"_RNG,"31;Parameter Value:  ",DEF,"^D HELP^TIUMOBJLM(30,$Y,""Enter a number from 0-""_RNG_"". '^' to exit."")") Q:P(PAR)=U
 . S $P(P,",",PNUM)=P(PAR)
 . D CLS
 I P(PAR)=U K P
 Q
POBJ(IEN,PARS) ; print object
 N N,P,PAR,PNUM
 D EXTRACT(IEN,.N,.P)
 F PNUM=1:1:$L(PARS,U) S PAR=$P(PARS,U,PNUM),P(PAR)=$P(P(3),",",PNUM)
 D DHDR(.N) D DPAR(.P) D IOSL:IOST["C-"
 Q
REBLD ; rebuild list & header
 D CLEAN^VALM10,LMINIT(.VAR,.VALMCNT),LMHDR
 Q
SETSTR(S,V,X,L) Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
VALIDM(X) ; validate object method
 D ^DIM
 Q $S('$D(X):0,1:1)
 ; parameter details
A ;;2
 ;;Filter by Medication Status
 ;;
 ;;Value  Display
 ;;=====  ========
 ;;  0    Active & Recently Expired [default]
 ;;  1    Active Only
 ;;  2    Recently Expired Only
 ;;
 ;;EOM
D ;;1
 ;;Standard or Detailed Display
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Standard [default]
 ;;  1    Detailed
 ;;
 ;;EOM
M ;;7
 ;;Filter by Medication Type
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Inpatient or Outpatient based on Patient
 ;;         Status [default]
 ;;  1    Clinic, Inpatient, Outpatient, & Non-VA
 ;;  2    Inpatient Only
 ;;  3    Outpatient Only
 ;;  4    Clinic Only
 ;;  5    Inpatient and Clinic
 ;;  6    Outpatient and Clinic
 ;;  7    Non-VA Only
 ;;
 ;;EOM
O ;;1
 ;;Sort Medications By Type and/or Status
 ;;
 ;;Type   [Inpatient/Outpatient/Clinic]
 ;;Status [Active/Pending/Inactive]
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Sort Meds by Type and Status [default]
 ;;  1    Sort Meds by Type Only
 ;;
 ;;EOM
SC ;;2
 ;;Sort Medications By Class
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Alphabetical by Name [default]
 ;;  1    By Class (Alphabetically)
 ;;  2    By Class (Alphabetically) and
 ;;         Display Class Header
 ;;
 ;;EOM
SU ;;1
 ;;Filter Supplies
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Exclude Supplies
 ;;  1    Include Supplies [default]
 ;;
 ;;EOM
MR ;;1
 ;;Med Rec/TIUDATE Fix
 ;;
 ;;Value  Display
 ;;=====  =======
 ;;  0    Exclude TIUDATE
 ;;  1    Include TIUDATE [default]
 ;;
 ;;EOM
