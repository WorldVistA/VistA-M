ORWRP ; ALB/MJK,dcm Report Calls ; 12/05/02 11:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**1,10,85,109,132,160,194,227,215,262,243,280**;Dec 17, 1997;Build 85
 ;
LABLIST(LST) ; -- report list for labs tab
 ;  RPC: ORWRP LAB REPORT LIST
 N I,J,X,X0,X2,CNT,EOF,IFN,ROOT,RPC,ORLIST,HEAD
 S EOF="$$END",ROOT=$NA(LST),(CNT,I)=0
 D SETITEM(ROOT,"[LAB REPORT LIST]")
 D GETLST^XPAR(.ORLIST,"ALL","ORWRP REPORT LAB LIST")
 F  S I=$O(ORLIST(I)) Q:'I  Q:'$D(^ORD(101.24,$P(ORLIST(I),"^",2),0))  S X0=^(0),X2=$G(^(2)) D
 . Q:$P(X0,"^",12)="L"
 . S RPC=$$GET1^DIQ(8994,+$P(X0,"^",13),.01),IFN=ORLIST(I),HEAD=$P(X0,"^")
 . I $L($P(X2,"^",3)) S HEAD=$P(X2,"^",3)
 . S X=$P(X0,"^",2)_"^"_HEAD_"^"_$P(X0,"^",3)_"^"_$P(X0,"^",12)_"^"_$P(X0,"^",7)_"^"_RPC_"^"_IFN
 . D SETITEM(.ROOT,X)
 D SETITEM(.ROOT,"$$END")
 Q
LIST(LST) ; -- report lists for reports tab
 ;  RPC: ORWRP REPORT LIST
 N EOF,ROOT
 S EOF="$$END",ROOT=$NA(LST)
 K @ROOT
 D GETRPTS(.ROOT,.EOF) ; -report list
 D GETHS(.ROOT,.EOF) ; -health summary types
 D GETDT(.ROOT,.EOF) ; -date ranges
 Q
GETCOL(ROOT,IFN) ; -- get Column headers for ListView
 N I,J,X,VAL
 Q:'$G(IFN)
 S I=0,ROOT=$NA(ROOT)
 F  S I=$O(^ORD(101.24,IFN,3,"C",I)) Q:'I  D
 . S VAL=$$GET^XPAR(DUZ_";VA(200,","ORWCH COLUMNS REPORTS",IFN,"I"),J=0
 . F  S J=$O(^ORD(101.24,IFN,3,"C",I,J)) Q:'J  I $D(^ORD(101.24,IFN,3,J)) S X=^(J,0) D
 .. I $L(VAL),$P(VAL,",",I) S $P(X,"^",10)=$P(VAL,",",I)
 .. D SETITEM(.ROOT,X)
 Q
GETRPTS(ROOT,EOF) ; -- get report list
 N I,J,X,X0,X2,CNT,IFN,ORLIST,HEAD
 D SETITEM(.ROOT,"[REPORT LIST]"),GETLST^XPAR(.ORLIST,"ALL","ORWRP REPORT LIST")
 S (CNT,I)=0
 F  S I=$O(ORLIST(I)) Q:'I  Q:'$D(^ORD(101.24,$P(ORLIST(I),"^",2),0))  S X0=^(0),X2=$G(^(2)) D
 . Q:$P(X0,"^",12)="L"
 . S RPC=$$GET1^DIQ(8994,+$P(X0,"^",13),.01),IFN=ORLIST(I),HEAD=$P(X0,"^")
 . I $L($P(X2,"^",3)) S HEAD=$P(X2,"^",3)
 . S X=$P(X0,"^",2)_"^"_HEAD_"^"_$P(X0,"^",4)_"^"_$P(X0,"^",19)_";"_$P(X0,"^",20)_"^"_$P(X0,"^",6)_"^"_$P(X0,"^",5)_"^"_$P(X0,"^",3)_"^"_$P(X0,"^",12)_"^"_$P(X0,"^",7)_"^"_RPC_"^"_IFN
 . D SETITEM(.ROOT,X)
 D SETITEM(.ROOT,"$$END")
 Q
GETHS(ROOT,EOF) ; --get health summary types
 N C,I,IFN,ORHSPARM,ORHSROOT,ORERR,X,T
 K ^TMP("ORHSPARM",$J)
 S ORHSROOT="^TMP(""ORHSPARM"",$J)"
 I $$GET^XPAR("ALL","ORWRP HEALTH SUMMARY LIST ALL",1) S I="",C=0 D
 . F  S I=$O(^GMT(142,"B",I)) Q:I=""  S IFN=$O(^(I,0)) Q:'IFN  D
 .. S X=$G(^GMT(142,IFN,0)) Q:'$L(X)
 .. S T=$G(^GMT(142,IFN,"T")),C=C+1,@ORHSROOT@(C)=IFN_"^"_$S($L(T):T,1:$P(X,"^"))_"^^^^^1"
 .. I I="GMTS HS ADHOC OPTION" S @ORHSROOT@(C)="0^GMTS Adhoc Report"
 I '$$GET^XPAR("ALL","ORWRP HEALTH SUMMARY LIST ALL",1) D
 . D:$L($T(GETLIST^GMTSXAL)) GETLIST^GMTSXAL($NA(@ORHSROOT),$G(DUZ),1,.ORERR)
 . Q:$G(ORERR)
 . S I=0 F  S I=$O(@ORHSROOT@(I)) Q:'I  S @ORHSROOT@(I)=@ORHSROOT@(I)_"^^^^^1" I $P(@ORHSROOT@(I),"^",2)="GMTS HS ADHOC OPTION" S @ORHSROOT@(I)="0^Adhoc Report"
 D SETITEM(.ROOT,"[HEALTH SUMMARY TYPES]")
 S I=0  F  S I=$O(@ORHSROOT@(I)) Q:'I  D SETITEM(.ROOT,"h"_@ORHSROOT@(I))
 D SETITEM(.ROOT,EOF)
 Q
GETDT(ROOT,EOF) ; -- get date range choices
 N I,X
 D SETITEM(.ROOT,"[DATE RANGES]")
 F I=2:1 S X=$P($T(DTLIST+I),";",3) Q:X=EOF  D SETITEM(.ROOT,"d"_X)
 Q
DTLIST ; -- list of date ranges
 ;<number of days>^ <display text>
 ;;S^Date Range...
 ;;0^Today
 ;;7^One Week
 ;;30^One Month
 ;;180^Six Months
 ;;365^One Year
 ;;732^Two Year
 ;;50000^All Results
 ;;$$END
 ;
SETITEM(ROOT,X) ; -- set item in list
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
RPT(ROOT,DFN,RPTID,HSTYPE,DTRANGE,EXAMID,ALPHA,OMEGA) ; -- return report text
 ;ROOT=Output in ^TMP("ORDATA",$J)
 ;DFN=Patient DFN ; ICN for remote sites
 ;RPTID=Unique report ID_";"_Remote ID_"~"_HSComponent for listview (ent;rtn;0;MaxOcc) or text (ent;rtn;#component;MaxOcc)
 ;HSTYPE=Health Sum Type
 ;DTRANGE=# days back from today
 ;EXAMID=Rad exam ID
 ;ALPHA=Start date
 ;OMEGA=End date
 ;  RPC: ORWRP REPORT TEXT
 ;
 N X,X0,X2,X4,I,J,ENT,RTN,ID,REMOTE,GO,OUT,MAX,SITE,ORFHIE,%ZIS,HSTAG,DIRECT,TAB
 K ^TMP("ORDATA",$J)
 S TAB="R"
 I $E(RPTID,1,2)="L:" S TAB="L",RPTID=$P(RPTID,":",2,999) ;an ID beginning with "L:" forces TAB to LAB - "L:" added in GUI code
 S HSTAG=$P($G(RPTID),"~",2),RPTID=$P($G(RPTID),"~"),ROOT=$NA(^TMP("ORDATA",$J,1)),REMOTE=+$P(RPTID,";",2),RPTID=$P($P(RPTID,";"),":")
 I 'REMOTE S DFN=+DFN ;DFN = DFN;ICN for remote calls
 S I=0,X0="",X2="",X4="",SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)_";"_$P(SITE,"^",3)
 F  S I=$O(^ORD(101.24,"AC",I)) Q:I=""  S J=0 F  S J=$O(^ORD(101.24,"AC",I,J)) Q:'J  D
 . I $P($G(^ORD(101.24,J,0)),"^",2)=RPTID,$P(^(0),"^",8)=TAB S X0=^(0),X2=$G(^(2)),ORFHIE=$G(^(4)),DIRECT=$P(ORFHIE,"^",4),X4=$P(ORFHIE,"^",2),ORFHIE=$P(ORFHIE,"^",3)
 I '$L(X0) D NOTYET(.ROOT) Q
 S RTN=$P(X0,"^",5),ENT=$P(X0,"^",6)
 I '$L(RTN)!'$L(ENT) D NOTYET(.ROOT) Q
 I '$L($T(@(ENT_"^"_RTN))) D NOTYET(.ROOT) Q
 ;I $G(ALPHA) S X=ALPHA-$G(OMEGA) D  ;jeh 243
 I $G(ALPHA) D
 . N X1,X2
 . S X=ALPHA
 . S X1=ALPHA,X2=$G(OMEGA) D:X2 ^%DTC ;X returned, # of days diff
 . I X<0 S X=X*(-1)
 . I X4,X>X4 S:ALPHA>OMEGA OMEGA=$$FMADD^XLFDT(ALPHA,-X4) S:ALPHA'>OMEGA ALPHA=$$FMADD^XLFDT(OMEGA,-X4) S DTRANGE=""
 I X4,$G(DTRANGE)>X4 S DTRANGE=X4,ALPHA=""
 I $L($G(DTRANGE)),'$G(ALPHA) S ALPHA=$$FMADD^XLFDT(DT,-DTRANGE),OMEGA=DT_".235959"
 I $G(OMEGA),$E(OMEGA,8)'="." S OMEGA=OMEGA_".235959"
 S ID=$G(HSTAG),$P(ID,";",5,10)=SITE_";"_$P(X2,"^",8)_";"_$P(X2,"^",9)_";"_RPTID_";"_$G(DIRECT) ;HDRHX CHANGE
 I $L($P($G(HSTAG),";",4)) S MAX=$P(HSTAG,";",4)
 I $L($G(HSTYPE)) M ID=HSTYPE
 I $L($G(EXAMID)) M ID=EXAMID
 S OUT=ENT_"^"_RTN_"(.ROOT,DFN,.ID,.ALPHA,.OMEGA,.DTRANGE,.REMOTE,.MAX,.ORFHIE)"
 I REMOTE S GO=0 D  Q:'GO
 . I '$L($T(GETDFN^MPIF001)) D SETITEM(.ROOT,"MPI routines missing on remote system ("_SITE_")") S GO=0 Q
 . S ICN=+$P(DFN,";",2),DFN=+$$GETDFN^MPIF001(ICN)
 . I DFN<0 D SETITEM(.ROOT,"Patient not found on remote system ("_SITE_")") S GO=0 Q
 . S GO=+$P(X0,"^",3)
 . I 'GO D SETITEM(.ROOT,"Remote access not available for this report ("_SITE_")")
 S %ZIS="0N"
 D @OUT
 Q
NOTYET(ROOT) ; -- not available
 D SETITEM(.ROOT,"Report not available at this time.")
 Q
START(RM,GOTO,ORIOSL) ;
 ;RM=Right margin
 N ZTQUEUED,ORHFS,ORSUB,ORIO,ORHANDLE,IOM,IOSL,IOST,IOF,IOT,IOS
 S ORHFS=$$HFS(),ORSUB="ORDATA",ORHANDLE="ORWRP"
 D HFSOPEN(ORHANDLE,ORHFS,"W")
 I POP D  Q
 . I $D(ROOT) D SETITEM(.ROOT,"ERROR: Unable to open HFS file")
 D IOVAR(.ORIO,.RM,.ORIOSL)
 N $ETRAP,$ESTACK
 S $ETRAP="D ERR^ORWRP Q"
 U IO
 D @GOTO
 D HFSCLOSE(ORHANDLE,ORHFS)
 Q
ERR ;Error trap
 S $ETRAP="D UNWIND^ORWRP Q"
 N %ZIS
 S %ZIS="0N"
 D @^%ZOSF("ERRTN") ;file error
 I $D(ORHANDLE) D CLOSE^%ZISH(ORHANDLE)
 I $D(ORHFS) D
 . N ORARR,OROK
 . S ORARR(ORHFS)="",OROK=$$DEL^%ZISH("",$NA(ORARR)) ;delete HFS file
 S $ECODE=",UOR69 error during CPRS report build,"
 Q
UNWIND ;Unwind Error stack
 Q:$ESTACK>1  ;pop stack
 ;
 Q
HFS() ; -- get hfs file name
 N H
 S H=$H
 Q "ORU_"_$J_"_"_$P(H,",")_"_"_$P(H,",",2)_".DAT"
HFSOPEN(HANDLE,ORHFS,ORMODE) ;
 D OPEN^%ZISH(HANDLE,,ORHFS,$G(ORMODE,"W")) Q:POP
 Q
IOVAR(ORIO,ORRM,ORIOSL,ORIOST,ORIOF,ORIOT) ;Setup IO variables based on IO Device
 N IFN,IFN1
 S ORIO=$G(ORIO,"OR WORKSTATION"),ION=ORIO,IOM=$G(ORRM,80),IOSL=$G(ORIOSL,62),IOST=$G(ORIOST,"P-OTHER"),IOF=$G(ORIOF,""""""),IOT=$G(ORIOT,"HFS")
 I $O(^%ZIS(1,"B",ORIO,0)) S IFN=$O(^(0)),IOS=IFN
 I $D(^%ZIS(1,IFN,0)) S IOST(0)=+$G(^("SUBTYPE")),IOT=$G(ORIOT,^("TYPE")),IOST=$G(ORIOST,$P($G(^%ZIS(2,IOST(0),0),IOST),"^"))
 I $O(^%ZIS(2,"B",IOST,0)) S IFN=$O(^(0)) I IFN S IOST(0)=IFN,IFN1=$G(^%ZIS(2,IFN,1)),IOM=$G(ORRM,$P(IFN1,"^")),IOF=$G(ORIOF,$P(IFN1,"^",2)),IOSL=$G(ORIOSL,$P(IFN1,"^",3))
 Q
HFSCLOSE(HANDLE,ORHFS) ;Close HFS and unload data
 N ORDEL,X,%ZIS
 S %ZIS="0N"
 I IO[ORHFS D CLOSE^%ZISH(HANDLE)
 S ROOT=$NA(^TMP(ORSUB,$J,1)),ORDEL(ORHFS)=""
 K @ROOT
 S X=$$FTG^%ZISH(,ORHFS,$NA(@ROOT@(1)),4)
 D STRIP
 S X=$$DEL^%ZISH(,$NA(ORDEL))
 Q
USEHFS ; -- use host file to build global array
 N OROK,SECTION
 S SECTION=0
 D INIT
 S OROK=$$FTG^%ZISH(,ORHFS,$NA(@ROOT@(1)),4) I 'OROK Q
 D STRIP
 N ORARR S ORARR(ORHFS)=""
 S OROK=$$DEL^%ZISH("",$NA(ORARR))
 Q
INIT ; -- initialize counts and global section
 S (INC,CNT)=0,SECTION=SECTION+1,ROOT=$NA(^TMP(ORSUB,$J,SECTION))
 K @ROOT
 Q
FINAL ; -- set 'x of y' for each section CALLED FROM ^ORWLR
 N I
 F I=1:1:SECTION S ^TMP(ORSUB,$J,I,.1)=I_U_SECTION
 Q
STRIP ; -- strip off control chars
 N I,X
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S X=^(I) D
 . I X[$C(8) D  ;BS
 .. I $L(X,$C(8))=$L(X,$C(95)) S (X,@ROOT@(I))=$TR(X,$C(8,95),"") Q  ;BS & _
 .. S (X,@ROOT@(I))=$TR(X,$C(8),"")
 . I X[$C(7)!(X[$C(12)) S @ROOT@(I)=$TR(X,$C(7,12),"") ;BEL or FF
 Q
WINDFLT(ORY) ;Windows printer as default?
 S ORY=+$$GET^XPAR("ALL","ORWDP WINPRINT DEFAULT")
 Q
GETDFPRT(Y,ORUSER,ORLOC) ; Returns default printer for user
 N IEN,X0,ENT
 S ENT="ALL"
 I $G(ORLOC) S ORLOC=+ORLOC_";SC(",ENT=ENT_"^"_ORLOC
 I +$$GET^XPAR(ENT,"ORWDP WINPRINT DEFAULT") S Y="WIN;Windows Printer" Q
 S IEN=$$GET^XPAR(ENT,"ORWDP DEFAULT PRINTER",1) Q:+IEN=0
 Q:'$D(^%ZIS(1,IEN,0))  S X0=^(0)
 S Y=IEN_";"_$P(X0,U)
 Q
SAVDFPRT(Y,ORDEV) ; Save new default printer for user
 N ORPAR,ORERR,ORWINDEF
 Q:$L(ORDEV)=0
 ; Reset Windows printer default to True/False
 S ORPAR="ORWDP WINPRINT DEFAULT"
 I ORDEV="WIN" S ORWINDEF="Y"
 E  S ORWINDEF="N"
 I $$GET^XPAR(DUZ_";VA(200,",ORPAR,1)'="" D CHG^XPAR(DUZ_";VA(200,",ORPAR,1,ORWINDEF,.ORERR)
 E  D ADD^XPAR(DUZ_";VA(200,",ORPAR,1,ORWINDEF,.ORERR)
 Q:ORDEV="WIN"
 ; If not Windows printer selected, save VistA default printer
 S ORPAR="ORWDP DEFAULT PRINTER",ORDEV="`"_ORDEV
 I $$GET^XPAR(DUZ_";VA(200,",ORPAR,1)'="" D CHG^XPAR(DUZ_";VA(200,",ORPAR,1,ORDEV,.ORERR)
 E  D ADD^XPAR(DUZ_";VA(200,",ORPAR,1,ORDEV,.ORERR)
 Q
