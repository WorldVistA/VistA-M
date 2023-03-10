ORVCODATA01 ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:03:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;DEC 17, 1997;Build 17
 Q
 ; see ORVCO for list of ICRs/DBIAs
DEMO(DFN) ; demographic data
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DEMO,DILOCKTM,DISYS,GBL,NODE13,VAERR,VAOA,VAROOT
 S GBL="^DPT",NODE13=$G(@GBL@(DFN,.13))
 S VAROOT="DEMO",VAOA("A")=1 D OAD^VADPT
 D ADDTXT("Demographic Data"),ADDTXT("================")
 N HP,CP,WP,EC,ECP S HP=$P(NODE13,U),HP=$S(HP="":"None on file.",1:HP),CP=$P(NODE13,U,4),CP=$S(CP="":"None on file.",1:CP),WP=$P(NODE13,U,2),WP=$S(WP="":"None on file.",1:WP)
 D ADDTXT("       Home Phone: "_HP),ADDTXT("       Cell Phone: "_CP),ADDTXT("       Work Phone: "_WP),ADDTXT("")
 S EC=$G(DEMO(9)),EC=$S(EC="":"None on file.",1:EC),ECP=$G(DEMO(8)),ECP=$S(ECP="":"None on file.",1:ECP)
 D ADDTXT("Emergency Contact: "_EC),ADDTXT("            Phone: "_ECP),ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Demographics [CPU]")=+$G(@INF@(" Duration","Demographics [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Demographics [SECS]")=+$G(@INF@(" Duration","Demographics [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
SCDIS(DFN) ; service connected/rated disabilities - Integration Agreement #700
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DATA,DILOCKTM,DISYS,GBL,I,I1,I2,I3,VAEL S GBL="^DG(391)"
 D ADDTXT("Service Connection/Disabilities"),ADDTXT("===============================")
 D ELIG^VADPT S DGKVAR=1
 S DATA=$S(+VAEL(3):"         SC Percent: "_+$P(VAEL(3),"^",2)_"%",1:"  Service Connected: NO") D ADDTXT(DATA)
 S DATA=" Rated Disabilities: " I 'VAEL(4),$S('$D(@GBL@(+VAEL(6),0)):1,$P(^(0),"^",2):0,1:1) S DATA=DATA_"Not a Veteran" D ADDTXT(DATA) G DISQ
 S GBL="^DPT",GBL(1)="^DIC(31)",I3=0 F I=0:0 S I=$O(@GBL@(DFN,.372,I)) Q:'I  D
 . S I1=^(I,0),I2=$S($D(@GBL(1)@(+I1,0)):$P(^(0),"^",1)_" ("_+$P(I1,"^",2)_"%-"_$S($P(I1,"^",3):"SC",$P(I1,"^",3)']"":"Not Specified",1:"NSC")_")",1:""),I3=I3+1
 . S DATA=$$SETSTR^VALM1(I2,$S(I3>1:"",1:DATA),22,$L(I2)) D ADDTXT(DATA)
 I 'I3 S DATA=$$SETSTR^VALM1("None Stated",DATA,22,11) D ADDTXT(DATA)
 D ADDTXT("")
DISQ I $D(DGKVAR) D KVAR^VADPT K DGKVAR
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Service Connected [CPU]")=+$G(@INF@(" Duration","Service Connected [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Service Connected [SECS]")=+$G(@INF@(" Duration","Service Connected [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
PRF(DFN) ; patient record flag
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,FLG
 D HASFLG^ORPRF(.FLG,DFN)
 D ADDTXT("Active Patient Record Flags"),ADDTXT("===========================")
 S:+FLG FLG=0 F  S FLG=$O(FLG(FLG)) Q:'+FLG  D
 . D ADDTXT("     "_$$TITLE^XLFSTR($P(FLG(FLG),U,2)))
 . S FLG(1)=1
 I '+$G(FLG(1)) D ADDTXT("None found.")
 D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Patient Record Flags [CPU]")=+$G(@INF@(" Duration","Patient Record Flags [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Patient Record Flags [SECS]")=+$G(@INF@(" Duration","Patient Record Flags [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
PROBLST(DFN) ; problem list
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,LCNT,NUM,ORTOTAL ; variables left over by external calls
 N I,J,LIST,TLIST
 D LIST^ORQQPL3(.TLIST,DFN,"A")
 I +TLIST(0) D
 . D ADDTXT("Active Problems"),ADDTXT("===============")
 . S I=0 F  S I=$O(TLIST(I)) Q:'+I  D
 . . S LIST($S(+$P(TLIST(I),U,6)=0:DT,1:$P(TLIST(I),U,6)),I)=TLIST(I) ; put list in order by date last updated
 . S I="" F  S I=$O(LIST(I),-1) Q:'+I  S J=0 F  S J=$O(LIST(I,J)) Q:'+J  D
 . . N X,Y
 . . S X=$P(LIST(I,J),U,3) D WRAP(.X,X,80)
 . . S X=0 F  S X=$O(X(X)) Q:'+X  D ADDTXT(X(X))
 . . I $P(LIST(I,J),U,15)'=0 K X D GETCOMM^ORQQPL2(.X,+LIST(I,J)) D:+$D(X(1)) ADDTXT("     "_X(1))
 I TLIST(0)'>0 D
 . D ADDTXT("Active Problems"),ADDTXT("==============="),ADDTXT("No active problems found.")
 D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Problem List [CPU]")=+$G(@INF@(" Duration","Problem List [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Problem List [SECS]")=+$G(@INF@(" Duration","Problem List [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
ORDERS(DFN) ; open orders
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,I,LIST,ORDERS,TYP,XPARSYS
 D AGET^ORWORR(.LIST,DFN,"2^0",1,0,0,"",0) M ORDERS=@LIST K @LIST,ORDERS(.1),LIST
 S I=0 F  S I=$O(ORDERS(I)) Q:'+I  D
 . S TYP=$P($G(^ORD(100.98,$P(ORDERS(I),U,2),0)),U,2) I TYP="" S TYP=$P($G(^ORD(100.98,$P(ORDERS(I),U,2),0)),U)
 . S LIST(TYP,I)=ORDERS(I)
 D ADDTXT("Active Orders (Including Pending & Recent Activity) - All Services")
 D ADDTXT("==================================================================")
 S TYP="" F  S TYP=$O(LIST(TYP),-1) Q:TYP=""  S I=0 F  S I=$O(LIST(TYP,I)) Q:'+I  D
 . N IEN,ORD,STAT,TMP S IEN=+LIST(TYP,I) Q:'+IEN
 . S STAT=$P(^ORD(100.01,$P(^OR(100,IEN,3),U,3),0),U)
 . S TMP="" I $O(LIST(TYP,I),-1)="" S TMP=$S(TYP="CHEMISTRY":"LAB",1:TYP) ; SET TYP ONLY IF IT'S THE FIRST ONE
 . N I,J S I=0 F  S I=$O(^OR(100,IEN,8,I)) Q:'+I  S J=0 F  S J=$O(^OR(100,IEN,8,I,.1,J)) Q:'+J  D
 . . N DESC I J=1 D  D ADDTXT(ORD) S ORD=""
 . . . S ORD=$$SETSTR^VALM1(TMP,"",1,$L(TMP))
 . . . S DESC=$G(^OR(100,IEN,8,I,.1,J,0)) I $L(DESC)>49 D
 . . . . D WRAP(.DESC,DESC,49) S ORD=$$SETSTR^VALM1(DESC(1),ORD,20,$L(DESC(1)))
 . . . I '+$D(DESC(2)) S ORD=$$SETSTR^VALM1(DESC,ORD,20,$L(DESC))
 . . . S ORD=$$SETSTR^VALM1(STAT,ORD,70,$L(STAT))
 . . I J=1 D  Q  ; ADD THE EXTRA LINES OF THE DESRIPTION
 . . . N I S I=1 F  S I=$O(DESC(I)) Q:'+I  S DESC(I)=$$SETSTR^VALM1(DESC(I),"",20,$L(DESC(I))) D ADDTXT(DESC(I))
 . . S ORD=$G(^OR(100,IEN,8,I,.1,J,0)),ORD=$E(ORD,2,$L(ORD))
 . . I $L(ORD)>49 D  Q
 . . . D WRAP(.ORD,ORD,49) S ORD="" N I S I=0
 . . . F  S I=$O(ORD(I)) Q:'+I  S ORD=$$SETSTR^VALM1(ORD(I),ORD,20,$L(ORD(I))) D ADDTXT(ORD) S ORD=""
 . . S ORD=$$SETSTR^VALM1(ORD,"",20,$L(ORD)) D ADDTXT(ORD)
 I '$D(LIST) D ADDTXT("No active orders found.")
 D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Orders [CPU]")=+$G(@INF@(" Duration","Orders [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Orders [SECS]")=+$G(@INF@(" Duration","Orders [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
MEDS(DFN) ; medications
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,DRG,I,J,LSTDS,LSTRD,ND2P5,RNWDT,SG
 D ADDTXT("********************************************************************************")
 D ADDTXT("* The medication and allergy data below do not contain all of the elements     *")
 D ADDTXT("* necessary for the essential medication and allergy list for review.  Please  *")
 D ADDTXT("* refer to the JLV for the complete list for review.                           *")
 D ADDTXT("********************************************************************************")
 D ADDTXT("")
 N TMP,X S X="$$LIST^TIULMED("_DFN_",""TMP"",0,1,1,0,0,0)" I @X
 S TMP="" F  S TMP=$O(TMP(TMP)) Q:TMP(TMP,0)=" "  D ADDTXT(TMP(TMP,0))
 S X="",$P(X,"=",73)="=" D ADDTXT(X)
 F  S TMP=$O(TMP(TMP)) Q:'+TMP  D ADDTXT(TMP(TMP,0))
 S TMP=$O(TMP(""),-1) I +TMP(TMP,0) D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Medications [CPU]")=+$G(@INF@(" Duration","Medications [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Medications [SECS]")=+$G(@INF@(" Duration","Medications [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
ALLERGIES(DFN) ; allergies
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,GMA,I,LIST,N D LIST^ORQQAL(.LIST,DFN)
 D ADDTXT("Allergies/Adverse Reactions"),ADDTXT("===========================")
 I $P(LIST(1),U,2)="No allergy assessment found." D ADDTXT($P(LIST(1),U,2))
 S I=0 F  S I=$O(LIST(I)) Q:'+I  D
 . N X S X=$$SETSTR^VALM1($P(LIST(I),U,2),"",1,29)
 . S X=$$SETSTR^VALM1($P(LIST(I),U,3),X,30,10)
 . N Y S Y=$P(LIST(I),U,4) N REP S REP(",")=", ",Y=$$REPLACE^XLFSTR(Y,.REP)
 . S Y=$$TITLE^XLFSTR(Y) D WRAP(.Y,Y,40)
 . N J S J=0 F  S J=$O(Y(J)) Q:'+J  D
 . . I J=1 S X=$$SETSTR^VALM1(Y(J),X,40,$L(Y(J))) D ADDTXT(X) Q
 . . S X=$$SETSTR^VALM1(Y(J),"",40,$L(Y(J))) D ADDTXT(X)
 . D ADDTXT("")
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Allergies [CPU]")=+$G(@INF@(" Duration","Allergies [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Allergies [SECS]")=+$G(@INF@(" Duration","Allergies [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
SKIN(DFN) ; skin test
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N D0,NM,DT,GBL,IEN,NODE,ROU
 S GBL="^TMP(""PXS"",$J)" K @GBL S ROU="SKIN^PXRHS04(DFN)" D @ROU
 I $D(@GBL) D ADDTXT("Skin Test             Reading Results  Admin      Reading     Facility") D
 . S $P(NM,"=",79)="=" D ADDTXT(NM)
 . S NM="" F  S NM=$O(@GBL@(NM)) Q:NM=""  S DT=0 F  S DT=$O(@GBL@(NM,DT)) Q:'+DT  S IEN=0 F  S IEN=$O(@GBL@(NM,DT,IEN)) Q:'+IEN  D  ;S NODE="" F  S NODE=$O(@GBL@(NM,DT,IEN,NODE)) Q:NODE=""  D
 . . N DATA,NODE0,NODE1,NODEC S NODE0=@GBL@(NM,DT,IEN,0),NODE1=@GBL@(NM,DT,IEN,1),NODEC=@GBL@(NM,DT,IEN,"COM")
 . . S DATA=$P(NODE0,U),DATA=$S($L(DATA)>20:$E(DATA,1,19)_"*",1:DATA),DATA=$$SETSTR^VALM1($P(NODE0,U,5),DATA,23,10),DATA=$$SETSTR^VALM1($P(NODE0,U,4),DATA,31,10)
 . . S DATA=$$SETSTR^VALM1($$FMTE^XLFDT($P(NODE0,U,2),"5DZ"),DATA,40,10),DATA=$$SETSTR^VALM1($$FMTE^XLFDT($P(NODE0,U,6),"5DZ"),DATA,51,10)
 . . N LOC S LOC=$S($P(NODE1,U,3)]"":$P(NODE1,U,3),$P(NODE1,U,4)]"":$P(NODE1,U,4),1:"NO SITE"),LOC=$S($L(LOC)>17:$E(LOC,1,16)_"*",1:LOC)
 . . S DATA=$$SETSTR^VALM1(LOC,DATA,63,17) D ADDTXT(DATA)
 . . I NODEC'="" D ADDTXT("  COMMENTS: "_NODEC)
 I '$D(@GBL) D ADDTXT("Skin Test(s)"),ADDTXT("================="),ADDTXT("No skin tests found.")
 D ADDTXT("")
 K @GBL
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Skin Test [CPU]")=+$G(@INF@(" Duration","Skin Test [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Skin Test [SECS]")=+$G(@INF@(" Duration","Skin Test [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
IMMUINE(DFN)  ; immunization
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N D0,NM,DT,GBL,IEN,NODE,ROU
 S GBL="^TMP(""PXI"",$J)" K @GBL S ROU="IMMUN^PXRHS03(DFN,""A"")" D @ROU
 I $D(@GBL) D ADDTXT("Immunization                              Series  Date        Facility") D
 . S $P(NM,"=",79)="=" D ADDTXT(NM)
 . S NM="" F  S NM=$O(@GBL@(NM)) Q:NM=""  S DT=0 F  S DT=$O(@GBL@(NM,DT)) Q:'+DT  S IEN=0 F  S IEN=$O(@GBL@(NM,DT,IEN)) Q:'+IEN  D  ;S NODE="" F  S NODE=$O(@GBL@(NM,DT,IEN,NODE)) Q:NODE=""  D
 . . N DATA,NODE0,NODE1 S NODE0=@GBL@(NM,DT,IEN,0),NODE1=@GBL@(NM,DT,IEN,1)
 . . S DATA=$P(NODE0,U),DATA=$S($L(DATA)>40:$E(DATA,1,39)_"*",1:DATA),DATA=$$SETSTR^VALM1($P(NODE0,U,4),DATA,43,2),DATA=$$SETSTR^VALM1($$FMTE^XLFDT($P(NODE0,U,3),"5DZ"),DATA,51,10)
 . . N LOC S LOC=$S($P(NODE1,U,3)]"":$P(NODE1,U,3),$P(NODE1,U,4)]"":$P(NODE1,U,4),1:"NO SITE"),LOC=$S($L(LOC)>18:$E(LOC,1,17)_"*",1:LOC)
 . . S DATA=$$SETSTR^VALM1(LOC,DATA,63,18) D ADDTXT(DATA) I $P(NODE0,U,6)]"" D ADDTXT("   REACTION: "_$$SENTENCE^XLFSTR($P(NODE0,U,6)))
 I '$D(@GBL) D ADDTXT("Immunization"),ADDTXT("================="),ADDTXT("No immunizations found.")
 D ADDTXT("") K @GBL
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Immunizations [CPU]")=+$G(@INF@(" Duration","Immunizations [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Immunizations [SECS]")=+$G(@INF@(" Duration","Immunizations [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
IMAG(DFN) ; imaging
 N CPUCLK,DATE,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 N DILOCKTM,DISYS,RACNI,RADATA,RAMDIV,RAORDER,RAWHOVER,ROOT,VALM
 S DATE("START")=9999999-$$FMADD^XLFDT(DT,-1826),DATE("FINISH")=9999999-(DT_.235959),DATE("BEGIN")=$$FMADD^XLFDT(DT,-1826),DATE("END")=DT_.235959
 D RIM^ORDV08(.ROOT,DATE("START"),DATE("FINISH"),100,DATE("BEGIN"),DATE("END"),"IGET;ORDV08;OR_R18")
 I $D(@ROOT) D
 . N TMP S TMP="Imaging ["_$$FMTE^XLFDT($$FMADD^XLFDT(DT,-1826))_" TO "_$$FMTE^XLFDT(DT)_"]",$P(TMP(1),"=",$L(TMP))="="
 . D ADDTXT(TMP),ADDTXT(TMP(1))
 . N I,J S I=0 F  S I=$O(@ROOT@(I)) Q:'+I  D
 . . N OUT
 . . S OUT=$P(@ROOT@(I,"WP",2),U,2)
 . . S OUT=$$SETSTR^VALM1($P(@ROOT@(I,"WP",3),U,2),OUT,22,$L($P(@ROOT@(I,"WP",3),U,2)))
 . . S OUT=$$SETSTR^VALM1($P(@ROOT@(I,"WP",4),U,2),OUT,70,$L($P(@ROOT@(I,"WP",4),U,2)))
 . . D ADDTXT(OUT)
 I '$D(@ROOT) D ADDTXT("Imaging"),ADDTXT("======="),ADDTXT("No imaging found.")
 D ADDTXT("") K @ROOT
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Imaging [CPU]")=+$G(@INF@(" Duration","Imaging [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Imaging [SECS]")=+$G(@INF@(" Duration","Imaging [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
FUTURE(DFN) ; future outpatient encounters
 N CPUCLK,START,STOP S START=$H,CPUCLK(1)=$$CPUTIME^XLFSHAN
 D ADDTXT("Future Appointments"),ADDTXT("===================")
 N DATA,VAERR,VAROOT,VDT S VAROOT="Data"
 D SDA^VADPT
 N I S I=0 F  S I=$O(@VAROOT@(I)) Q:'+I  S VDT=$P(@VAROOT@(I,"I"),U) D
 . S DATA(9999999-VDT)=VDT_U_$P(@VAROOT@(I,"E"),U,2,3)
 S VDT=0 F  S VDT=$O(DATA(VDT)) Q:'+VDT  D
 . S DATA=$TR($$FMTE^XLFDT(+DATA(VDT),"5MZ"),"@"," "),DATA=$$SETSTR^VALM1($P(DATA(VDT),U,2),DATA,19,56),DATA=$$SETSTR^VALM1($P(DATA(VDT),U,3),DATA,58,21)
 . D ADDTXT(DATA)
 I '$D(@VAROOT) D ADDTXT("No future appointments found.")
 D ADDTXT("")
 K @VAROOT
 S CPUCLK(2)=$$CPUTIME^XLFSHAN
 S @INF@(" Duration","Future Visits [CPU]")=+$G(@INF@(" Duration","Future Visits [CPU]"))+$$ETIMEMS^XLFSHAN(CPUCLK(1),CPUCLK(2))
 S STOP=$H
 S @INF@(" Duration","Future Visits [SECS]")=+$G(@INF@(" Duration","Future Visits [SECS]"))+$$HDIFF^XLFDT(STOP,START,2)
 Q
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N DILOCKTM,DISYS
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
ADDTXT(DATA) ;
 S DOCTXT=DOCTXT+1
 S DOCTXT(DOCTXT,0)=DATA
 Q
WRAP(OUT,TEXT,LENGTH) ;
 N TIUFI,TIUFJ,LINE,TIUFT1,TIUFT2,TIUFY
 I $G(TEXT)']"" Q
 F TIUFI=1:1 D  Q:TIUFI=$L(TEXT," ")
 . S OUT=$P(TEXT," ",TIUFI)
 . I $L(OUT)>LENGTH D
 . . S TIUFT1=$E(OUT,1,LENGTH),TIUFT2=$E(OUT,LENGTH+1,$L(OUT))
 . . S $P(TEXT," ",TIUFI)=TIUFT1_" "_TIUFT2
 S LINE=1,OUT(1)=$P(TEXT," ")
 F TIUFI=2:1 D  Q:TIUFI'<$L(TEXT," ")
 . S:$L($G(OUT(LINE))_" "_$P(TEXT," ",TIUFI))>LENGTH LINE=LINE+1,TIUFY=1
 . S OUT(LINE)=$G(OUT(LINE))_$S(+$G(TIUFY):"",1:" ")_$P(TEXT," ",TIUFI),TIUFY=0
 Q
