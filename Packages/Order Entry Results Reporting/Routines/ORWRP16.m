ORWRP16 ; ALB/MJK Report Calls - 16bit ;5/22/97  19:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;
LIST(ROOT) ; -- return lists for list boxes
 ;  RPC: ORWRP REPORT LIST
 ;  See RPC definition for details on input and output parameters
 ;
 N EOF
 S EOF="$$END",ROOT=$NA(^TMP($J,"ORPTLIST"))
 K @ROOT
 ;
 ; -- get list of reports
 D GETRPTS(.ROOT,.EOF)
 ; -- get list of health summary types
 D GETHS(.ROOT,.EOF)
 ; -- get list of date ranges
 D GETDT(.ROOT,.EOF)
 ;
 Q
 ;
GETRPTS(ROOT,EOF) ;  -- get list of reports
 N I,X
 D SETITEM(.ROOT,"[REPORT LIST]")
 F I=2:1 S X=$P($T(RPTLIST+I),";",3) D SETITEM(.ROOT,X) Q:X=EOF
 Q
 ;
RPTLIST ; -- list of reports
 ;<ID> ^ <report name> ^ <ask date range> ^ <ask health summary type> ^ <right margin>
 ;;1^Health Summary^N^Y^80
 ;;2^Blood Bank Report^N^N^80
 ;;3^Anatomic Path Report^N^N^80
 ;;4^Dietetics Profile^N^N^80
 ;;5^Vitals Cumulative^Y^N^132
 ;;6^Vitals SF511^Y^N^132
 ;;$$END
 ;
GETHS(ROOT,EOF) ; --get list of health summary types
 N I,HSPARM
 D GETLST^XPAR(.HSPARM,"SYS","ORWRP HEALTH SUMMARY TYPE LIST","N")
 ;
 D SETITEM(.ROOT,"[HEALTH SUMMARY TYPES]")
 S I=0  F  S I=$O(HSPARM(I)) Q:'I  D SETITEM(.ROOT,HSPARM(I))
 D SETITEM(.ROOT,EOF)
 Q
 ;
GETDT(ROOT,EOF) ; -- get date range choices
 N I,X
 D SETITEM(.ROOT,"[DATE RANGES]")
 F I=2:1 S X=$P($T(DTLIST+I),";",3) D SETITEM(.ROOT,X) Q:X=EOF
 Q
 ;
DTLIST ; -- list of date ranges
 ;<number of days>^ <display text>
 ;;0^Today
 ;;7^One Week Back
 ;;14^Two Weeks Back
 ;;30^One Month Back
 ;;180^Six Months Back
 ;;365^One Year Back
 ;;$$END
 ;
SETITEM(ROOT,X) ; -- set item in list
 S @ROOT@($O(@ROOT@(9999),-1)+1)=X
 Q
 ;
RPT(ROOT,DFN,RPTID,HSTYPE,DTRANGE,SECTION) ; -- return report text
 ;  RPC: ORWRP REPORT TEXT
 ;  See RPC definition for details on input and output parameters
 ;
 IF $G(SECTION),$D(^TMP("ORDATA",$J,SECTION)) D  G RPTQ
 . S ROOT=$NA(^TMP("ORDATA",$J,SECTION))
 ;
 ; -- init output global for close logic of WORKSTATION device
 K ^TMP("ORDATA",$J)
 S ROOT=$NA(^TMP("ORDATA",$J,1))
 ;
 ; -- get report text
 IF RPTID=1 D HS(DFN,HSTYPE) G RPTQ
 IF RPTID=2 D BL(DFN) G RPTQ
 IF RPTID=3 D PATH(DFN) G RPTQ
 IF RPTID=4 D DIET(.ROOT,DFN) G RPTQ
 IF RPTID=5 D VITALS(DFN,DTRANGE,"VITCUM") G RPTQ
 IF RPTID=6 D VITALS(DFN,DTRANGE,"VIT511") G RPTQ
 ;
 ; -- basic report if id not found above
 D NOTYET(.ROOT)
RPTQ Q
 ;
HS(ORDFN,ORHS) ; - get health summary report
 N ZTQUEUED,ORRM,ORHFS,ORSUB,ORIO
 S ORRM=80,ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.ORRM,.ORHFS,"W",.ORIO)
 ;
 D HSB(.ORDFN,.ORHS)
 ;
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
 ;
HSB(ORDFN,ORHS) ; - build health summary report
 N ORVP,GMTYP,Y
 S ORVP=ORDFN_";DPT("
 S Y=$P($G(^GMT(142,+ORHS,0)),U)
 S GMTYP(0)=1,GMTYP(1)=+ORHS_U_Y_U_Y_U_Y
 D PQ^ORPRS13
 Q
 ;
BL(ORDFN) ; -- get blood bank report
 N ZTQUEUED,ORRM,ORHFS,ORSUB,ORIO
 S ORRM=80,ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.ORRM,.ORHFS,"W",.ORIO)
 ;
 D BLB(.ORDFN)
 ;
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
 ; 
BLB(ORDFN) ; -- build blood bank report
 N DFN
 ;
 D SET^LRBLPD1
 IF $G(OREND)'=1 D
 . S DFN=ORDFN
 . D OERR^LRBLPD1
 . D CLEAN^LRBLPD1
 Q
 ; 
PATH(ORDFN) ; -- get anatomic path report
 N ZTQUEUED,ORRM,ORHFS,ORSUB,ORIO
 S ORRM=80,ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.ORRM,.ORHFS,"W",.ORIO)
 ;
 D PATHB(.ORDFN)
 ;
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
 ;
PATHB(ORDFN) ; -- build anatomic path report
 N DFN
 ;
 D SET^LRAPS3
 IF $G(OREND)'=1 D
 . S DFN=ORDFN
 . D OERR^LRAPS3
 . D CLEAN^LRAPS3
 Q
 ;
DIET(ROOT,DFN) ; -- get dietetics profile
 D NOTYET(.ROOT)
 Q
 ;
DIETB(DFN) ; -- get dietetics profile
 W !!,"Dietetics Profile not yet available."
 Q
 ;
VITALS(DFN,DTRANGE,ORTAG) ; -- get vitals report
 N ZTQUEUED,ORRM,ORHFS,ORSUB,ORIO
 S ORRM=132,ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.ORRM,.ORHFS,"W",.ORIO)
 ;
 D VITALSB(.DFN,.DTRANGE,.ORTAG)
 ;
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
 ;
VITALSB(DFN,DTRANGE,ORTAG) ; -- build vitals report
 N ORVP,XQORNOD,ORSSTRT,ORSSTOP
 ;
 S ORVP=DFN_";DPT(",XQORNOD=1
 S X1=DT
 ; -- if TODAY then do not substract 1
 S X2=-$S(DTRANGE:DTRANGE-1,1:0)
 D C^%DTC
 S ORSSTRT(XQORNOD)=X-.7641,ORSSTOP(XQORNOD)=DT+.2359
 D @ORTAG^ORPRS14
 Q
 ;
NOTYET(ROOT) ; -- standard not available display text
 D SETITEM(.ROOT,"Report not available at this time.")
 S @ROOT@(.1)="1^1"
 Q
 ;
HFS() ; -- get hfs file name
 ; -- need to define better unique algorithm
 Q "ORU_"_$J_".DAT"
 ;
OPEN(ORRM,ORHFS,ORMODE,ORIO) ; -- open WORKSTATION device
 ;   ORRM: right margin
 ;  ORHFS: host file name
 ; ORMODE: open file in 'R'ead or 'W'rite mode
 S ZTQUEUED="" K IOPAR
 S IOP="WORKSTATION;"_$G(ORRM,80)
 S %ZIS("HFSMODE")=ORMODE,%ZIS("HFSNAME")=ORHFS
 D ^%ZIS K IOP,%ZIS
 U IO S ORIO=IO
 Q
 ;
CLOSE(ORRM,ORHFS,ORSUB,ORIO) ; -- close WORKSTATION device
 ; ORSUB: unique subscript name for output 
 IF IO=ORIO D ^%ZISC
 U IO
 D USEHFS
 U IO
 Q
USEHFS ; -- use host file to build global array
 N IO,OROK
 ; D OPEN^%ZISH(ORSUB,"",ORHFS,"R") I POP Q
 K ^TMP($J,"ORTMPLST")
 S OROK=$$FTG^%ZISH(,ORHFS,$NA(^TMP($J,"ORTMPLST",1)),3)
 D BUILD
 K ^TMP($J,"ORTMPLST")
 ; D CLOSE^%ZISH(ORSUB)
 N ORARR S ORARR(ORHFS)=""
 S OROK=$$DEL^%ZISH("",$NA(ORARR))
 Q
 ;
BUILD ; -- build tmp global for report
 N INC,CNT,MAX,SECTION,ROOT,STRIP,LN
 S SECTION=0,MAX=20000,STRIP=$C(7,12)
 D INIT
 ; -- strip out ff's and quit on error
 S LN=0 F  S LN=$O(^TMP($J,"ORTMPLST",LN)) Q:'LN  S X=^(LN) D
 . ;F  U IO R X:5 D  Q:$$STATUS^%ZISH
 . I (CNT+250)>MAX D INIT
 . S X=$TR(X,STRIP,"")
 . S INC=INC+1,@ROOT@(INC)=X
 . S CNT=CNT+$L(X)
 D FINAL
 Q
 ;
INIT ; -- initialize counts and global section
 S (INC,CNT)=0,SECTION=SECTION+1
 S ROOT=$NA(^TMP(ORSUB,$J,SECTION))
 K @ROOT
 Q
 ;
FINAL ; -- set 'x of y' for each section
 N I
 F I=1:1:SECTION S ^TMP(ORSUB,$J,I,.1)=I_U_SECTION
 Q
 ;
