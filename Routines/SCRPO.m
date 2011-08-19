SCRPO ;BP-CIOFO/KEITH - Report prompting utilities ; 20 Aug 99  7:46 AM
 ;;5.3;Scheduling;**177,297**;AUG 13, 1993
 ;
DTR(SC,SCDTB,SCDTE) ;Date range prompts
 ;Input: SC=name of array to return values
 ;       @SC@("DTR","BDT")=begin date (internal^external)
 ;       @SC@("DTR","EDT")=end date (internal^external)
 ;Input: SCDTB=array to manipulate %DT begin date values (optional)
 ;Input: SCDTE=array to manipulate %DT end date values (optional)
 ;Output: '1' for success, '0' otherwise
 N %DT M %DT=SCDTB W !
 S:'$L($G(%DT)) %DT="AEPX"
 I %DT["A" S:'$L($G(%DT("A"))) %DT("A")="Select beginning date: "
 D ^%DT I Y<1 Q 0
 S @SC@("DTR","BEGIN")=Y X ^DD("DD") S @SC@("DTR","PBDT")=Y
EDT K %DT M %DT=SCDTE W !
 S:'$L($G(%DT)) %DT="AEPX"
 I %DT["A" S:'$L($G(%DT("A"))) %DT("A")="   Select ending date: "
 D ^%DT I Y<1 K SC Q 0
 I Y<@SC@("DTR","BEGIN") W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S @SC@("DTR","END")=Y X ^DD("DD") S @SC@("DTR","PEDT")=Y
 S @SC@("DTR","INCL")=0
 D XR(.SC,"DTR","Date Range") Q 1
 ;
ATYPE(SC) ;Prompt for assignment types
 ;Input: SC=array to return values (pass by reference)
 ;       @SC@("ATYPE")=assignment types (internal^external)
 ;Output: '1' for success, '0' otherwise
 N DIR,DTOUT,DUOUT
 S DIR(0)="S^P:PRIMARY CARE ASSIGNMENTS;N:NON-PRIMARY CARE ASSIGNMENTS;B:BOTH PC AND NON-PC"
 S DIR("A")="Specify the type of assignments to include",DIR("B")="BOTH"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0
 S @SC@("ATYPE")=Y_U_Y(0)
 D XR(.SC,"ATYPE","Type of Assignments") Q 1
 ;
DSUM(SC) ;Prompt for detail or summary
 ;Input SC=array to return values (pass by reference)
 ;      @SC@("FMT")=format (internal^external)
 ;Output: '1' for success, '0' otherwise
 N DIR,DTOUT,DUOUT
 K DIR S DIR(0)="S^D:DETAIL + SUMMARY;S:SUMMARY ONLY"
 S DIR("A")="Specify output format",DIR("B")="DETAIL + SUMMARY"
 W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT) 0
 S @SC@("FMT")=Y_U_Y(0)
 D XR(.SC,"FMT","Report Format") Q 1
 ;
LIST(SC,WHAT,SUBH,LIMIT) ;Get list of entries from a file
 ;Input: SC=array to return values (pass by reference)
 ;       @SC@(WHAT)="ALL" for all entries, or,
 ;       @SC@(WHAT,ifn)=name of record
 ;       @SC@(WHAT,name,ifn)=""
 ;Input: WHAT=type of selection
 ;        "DIV" for division
 ;        "TEAM" for TEAM
 ;        "ROLE" for STANDARD POSITION
 ;        "POS" for TEAM POSITION
 ;        "PCP" for PC provider (NEW PERSON)
 ;        "ASPR" for assigned provider (NEW PERSON)
 ;        "APR" for associate provider (NEW PERSON)
 ;        "CLINIC" for enrolled clinic (HOSPITAL LOCATION)
 ;Input: SUBH='1' to display category subheader (optional)
 ;Input: LIMIT=maximum selections (optional, default 20)
 ;Output: '1' for success, '0' otherwise
 ;
 N SCW,SCI,SCOUT,DIC,X,Y,SCA,SCB,SCQUIT,SCS,DTOUT,DUOUT
 Q:'$L(WHAT) 0  S:'$G(LIMIT) LIMIT=20 S (SCOUT,SCQUIT)=0
 F SCI="DIV","TEAM","ROLE","POS","PCP","ASPR","APR","CLINIC" S SCW(SCI)=""
 Q:'$D(SCW(WHAT)) 0
 D @WHAT S DIC(0)="AEMQ"
 I $G(SUBH) D SUBT^SCRPW50("**** "_SCA_" Selection ****")
 S SCB=$J("Select "_SCA_":  ",29),DIC("A")=SCB_"ALL// "
 I $L($G(SCS)) S DIC("S")=SCS
 F SCI=1:1:LIMIT D  Q:SCOUT!SCQUIT
 .W ! D ^DIC I $D(DTOUT)!$D(DUOUT) S SCQUIT=1 Q
 .I SCI=1,X="" W "  (ALL)" S @SC@(WHAT)="ALL",SCOUT=1 Q
 .I X="" S SCOUT=1 Q
 .I Y>0 S @SC@(WHAT,+Y)=$P(Y,U,2),@SC@(WHAT,$P(Y,U,2),+Y)=""
 .S DIC("A")=SCB
 .Q
 D XR(.SC,WHAT,SCA) Q 'SCQUIT
 ;
DIV S DIC="^DIC(4,",SCA="Institution",SCS="I $D(^SCTM(404.51,""AINST"",+Y))" Q
TEAM S DIC="^SCTM(404.51,",SCA="Team" Q
ROLE S DIC="^SD(403.46,",SCA="Role" Q
POS S DIC="^SCTM(404.57,",SCA="Team Position" Q
PCP S DIC="^VA(200,",SCA="PC Provider" Q
ASPR S DIC="^VA(200,",SCA="Assigned Provider" Q
APR S DIC="^VA(200,",SCA="Associate Provider" Q
CLINIC S DIC="^SC(",SCA="Associated Clinic",DIC("S")="I $P(^(0),U,3)=""C""" Q
 ;
SORT(SC,SCEL,SCSP) ;Prompt for optional sort elements
 ;Input: SC=array to return sort order (pass by reference)
 ;Input: SCX=comma delimited string of element acronyms where
 ;           'IN' = INSTITUTION
 ;           'TM' = TEAM
 ;           'RO' = ROLE
 ;           'TP' = TEAM POSITION
 ;           'PR' = PROVIDER
 ;           'AC' = ASSOCIATED CLINIC
 ;           'EC' = ENROLLED CLINIC
 ;           'PT' = PATIENT
 ;           'PA' = PATIENT
 ;Input: SCSP=acronym of last sort to add if not selected (optional)
 ;Output: '0' for abnormal exit, '1' otherwise
 ;        @SC@("SORT",1,elementacronym)=element
 ;        @SC@("SORT",2,elementacronym)=element, etc.
 ;
 N DIR,SCI,SCX,SCY,SCQUIT,SCZ
 Q:'$L(SCEL)
 S SCQUIT=0
 F SCI=1:1:$L(SCEL,",") D
 .S SCX=$P(SCEL,",",SCI),SCX=$S(SCX="PA":"PT",SCX="DV":"IN",1:SCX),SCY(SCX)=SCI,SCZ=$P($T(@SCX),";;",2)
 .S SCZ(SCX)=$P(SCZ,U,2),SCX=$P(SCZ,U)
 .I $L(SCX) S SCX(SCI)=";"_SCX
 .Q
 Q:'$O(SCX(""))
 S SCI=0 D QSORT("Sort output by")
 I $L($G(SCSP)),$D(SCY(SCSP)) D
 .S SCI=SCI+1,SCZ=$P($T(@SCSP),";;",2),@SC@("SORT",SCI)=$P(SCZ,":")_U_$P(SCZ,":",2)
 .Q
 D XR(.SC,"SORT","Output will be sorted by") Q 'SCQUIT
 ;
QSORT(DIRA) ;Prompt for sort
 N DTOUT,DUOUT
 S DIR("A")=DIRA
 S DIR(0)=$$DIR0() Q:DIR(0)=""
 D ^DIR I $D(DTOUT)!$D(DUOUT) S SCQUIT=1 Q
 Q:X=""
 S SCI=SCI+1,@SC@("SORT",SCI)=$S(Y="IN":"DV",Y="PT":"PA",1:Y)_U_Y(0)_U_SCZ(Y)
 K SCX(SCY(Y)),SCY(Y) D QSORT("Within "_Y(0)_", sort by")
 Q
 ;
DIR0() ;Return value for DIR(0)
 N SCI
 S SCX="",SCI=0
 F  S SCI=$O(SCX(SCI)) Q:'SCI  S SCX=SCX_SCX(SCI)
 S SCX=$E(SCX,2,999) S:$L(SCX) SCX="SO^"_SCX
 Q SCX
 ;
DV ;;IN:INSTITUTION^SCDIV
IN ;;IN:INSTITUTION^SCDIV
TM ;;TM:TEAM^SCTEAM
RO ;;RO:ROLE^SCROLE
TP ;;TP:TEAM POSITION^SCPOS
PR ;;PR:PROVIDER^SCPROV
EC ;;EC:ENROLLED CLINIC^SCLINIC
AC ;;AC:ASSOCIATED CLINIC^SCLINIC
PA ;;PA:PATIENT^SCPAT
PT ;;PT:PATIENT^SCPAT
 ;
XR(SC,SUB,VAL) ;Create x-ref for printing parameters
 ;Input: SC=array to return parameters
 ;Input: SUB=name of subscript holding parameters being x-ref'd
 ;Input: VAL=value for item subtitle (optional)
 ;
 S @SC@("XR")=$G(@SC@("XR"))+1,@SC@("XR",@SC@("XR"),SUB)=$G(VAL) Q
 ;
PPAR(SC,OK,SCT) ;Print report parameters
 ;Input: SC=array of report parameters
 ;Input: OK='1' to prompt for parameter ok (optional)
 ;Input: SCT=report title
 ;Output: '1' if ok, '0' otherwise
 ;
 N SCL,SCI,SCX,SCOUT,SCLAB,SCF,SCVAL,COL,DTOUT,DUOUT
 S COL=$S($E(IOST)="C":12,1:38)
 S (SCI,SCOUT)=0,SCLAB="",SCL=1
 F  S SCI=$O(@SC@("XR",SCI)) Q:'SCI!SCOUT  D
 .S SCX=$O(@SC@("XR",SCI,"")),SCLAB=@SC@("XR",SCI,SCX)
 .I $E(IOST)="C",SCL>18 D WAIT Q:SCOUT  S SCL=0
 .I $E(IOST)="P",$Y>(IOSL-4) D HDR(.SCT) Q:SCOUT
 .S SCL=SCL+1 W ! Q:SCX="SPACE"
 .S SCL=SCL+1 W !?(COL),$J(SCLAB,24),": "
 .I SCX="DTR" W @SC@("DTR","PBDT")," to ",@SC@("DTR","PEDT") Q
 .I $G(@SC@(SCX))="ALL" W "ALL" Q
 .I $D(@SC@(SCX))=1 W $P(@SC@(SCX),U,2) Q
 .I SCX="SORT" S SCF=0,SCVAL=0 D  Q
 ..F  S SCVAL=$O(@SC@(SCX,SCVAL)) Q:'SCVAL!SCOUT  D
 ...I SCF,$E(IOST)="C",SCL>18 D WAIT Q:SCOUT  S SCL=0
 ...I SCF,$E(IOST)="P",$Y>(IOSL-4) D HDR(.SCT) Q:SCOUT
 ...I SCF W ! S SCL=SCL+1
 ...W ?(COL+26+$S(SCX="SORT":(SCF*2),1:0)),$P(@SC@(SCX,SCVAL),U,2)
 ...S SCF=SCF+1
 ...Q
 ..Q
 .S SCF=0,SCVAL=999999999999
 .F  S SCVAL=$O(@SC@(SCX,SCVAL)) Q:SCVAL=""!SCOUT  D
 ..I $E(IOST)="C",SCL>18 D WAIT Q:SCOUT  S SCL=0
 ..I $E(IOST)="P",$Y>(IOSL-4) D HDR(.SCT) Q:SCOUT
 ..I SCF W ! S SCL=SCL+1
 ..W ?(COL+26+$S(SCX="SORT":(SCF*2),1:0)),SCVAL
 ..S SCF=SCF+1
 ..Q
 .Q
 S SCX=1 I $G(OK) N DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK" D
 .W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SCX=0 Q
 .S SCX=Y
 .Q
 Q SCX
 ;
WAIT N DIR S DIR(0)="E" W ! D ^DIR S SCOUT=Y'=1 W @IOF Q
 ;
HDR(SCT,SCIOM) ;Print report header
 ;Input: SCT=array of header lines
 ;Input: SCIOM=right margin (optional)
 ;
 N SCI
 S:'$G(SCIOM) SCIOM=IOM
 I $E(IOST)="C",SCFF N DIR S DIR(0)="E" W ! D ^DIR S SCOUT=Y'=1 Q:SCOUT
 D STOP Q:SCOUT
 I SCFF!($E(IOST)="C") W $$XY^SCRPW50(IOF,1,0)
 I $X W $$XY^SCRPW50("",0,0)
 W SCLINE
 S SCI=0 F  S SCI=$O(SCT(SCI)) Q:'SCI  D
 .W !?(SCIOM-$L(SCT(SCI))\2),SCT(SCI)
 .Q
 W !,SCLINE,!,"Date printed: ",SCPNOW,?(SCIOM-6-$L(SCPAGE)),"Page: ",SCPAGE
 W !,SCLINE S SCFF=1,SCPAGE=SCPAGE+1
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SCOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
ELIG(DFN) ;Get Primary Eligibility
 ;Input: DFN=patient ifn
 N PRIM,PRIM1
 S PRIM=$P($G(^DPT(DFN,.36)),U) Q:PRIM<1 "[unknown]"
 S PRIM=$P($G(^DIC(8,PRIM,0)),U,9) Q:PRIM<1 "[unknown]"
 ;MAS Primary Eligibility Code
 S PRIM=$P($G(^DIC(8.1,PRIM,0)),U) Q:PRIM="" "[unknown]"
 S PRIM1=PRIM
 ;
 S PRIM=$TR(PRIM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I PRIM="NON-SERVICE CONNECTED" S PRIM="NSC"
 I PRIM["SERVICE CONNECTED" S PRIM=$P(PRIM,"SERVICE CONNECTED")_"SC"_$P(PRIM,"SERVICE CONNECTED",2,999)
 I PRIM["LESS THAN" S PRIM=$P(PRIM,"LESS THAN")_"<"_$P(PRIM,"LESS THAN",2,999)
 I PRIM[" TO " S PRIM=$P(PRIM," TO ")_"-"_$P(PRIM," TO ",2,999)
 I PRIM["%" S PRIM=$TR(PRIM,"%","")
 S PRIM=$E(PRIM,1,9)
 Q PRIM1_U_PRIM
