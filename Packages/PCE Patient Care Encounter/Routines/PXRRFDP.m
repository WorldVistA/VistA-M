PXRRFDP ;ISL/PKR - Final sort and print of frequency of diagnosis report. ;9/5/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,31,121,199**;Aug 12, 1996;Build 51
 ;
PRINT ;
 N ANS,BD,BMARG,C1E,C1S,C2E,C2S,C3E,C3S,C1HS,C2HS,C3HS,CMAX,INDENT,MID
 N DCSTR,HEAD,LEN,NUM,PAGE
 N BYLOC,BYPC,BYPRV,DCIEN,DOCOUNT,DONE,DTOT,ED,ETOT,FOUND,HLOC,IC,ICD9IEN
 N FACILITY,FACPNAME,IC,ICDDATA,ICDDATE,IMPDATE,INFOTYPE,LOCPNAM,NEWPAGE,PCLASS,PRV
 N RATIO,STOIND,TEMP,TOTAL,TOTSTR,VACODE,ICDSTR
 ;
 ;Allow the task to be cleaned up upon successful completion.
 S ZTREQ="@"
 ;
 U IO
 S IMPDATE=$$IMPDATE^LEXU("10D")
 ; When no Diagnoses found for Criteria for either ICD-9 or ICD-10, rpt Criteria
 ; and End the run.
 I (DIAGTOT=0)&(DGTOT10=0) S DOCOUNT=1 D PROCSS2 G END
 F DOCOUNT=1:1:2 D PROCESS
 G END
 ;
PROCESS ;
 I DOCOUNT=1,DIAGTOT=0 Q
 I DOCOUNT=2,DGTOT10=0 Q
PROCSS2 S ICDDATE=$S(DOCOUNT=2:IMPDATE,1:$$FMADD^XLFDT(IMPDATE,-1))
 S BMARG=2
 S INDENT=3,PAGE=1,C1S=INDENT+29
 ;
 S DONE=0
 D HDR^PXRRGPRT(PAGE)
 W !!,"Criteria for Frequency of Diagnoses Report"
 W !,?INDENT,"Encounter diagnoses:",?C1S,$P(PXRRFDDC,U,2)
 S BD=$$FMTE^XLFDT(PXRRBDT)
 S ED=$$FMTE^XLFDT(PXRREDT)
 W !,?INDENT,"Encounter date range:",?C1S,BD," through ",ED
 I PXRRECAT="" D  G MAXP
 . W !,?INDENT,"Selected encounters:",?C1S,"ALL"
 ;
 I $D(PXRRPRSC) W !,?INDENT,"Selected Providers:",?C1S,$P(PXRRPRSC,U,2)
 I $D(PXRRCS) S ANS="YES"
 E  S ANS="ALL"
 I $D(PXRRLCSC) W !,?INDENT,$P(PXRRLCSC,U,2)
 I $D(PXRRETYP) W !,?INDENT,"Encounter type:",?C1S,PXRRETYP
 ;
 I $D(PXRRDOB) D
 . I (PXRRDOBE'=DT)&(PXRRDOBS'=0) D
 .. W !,?INDENT,"Patient age range:",?C1S,PXRRMINA," to ",PXRRMAXA
 .. S BD=$$FMTE^XLFDT(PXRRDOBS),ED=$$FMTE^XLFDT(PXRRDOBE)
 .. W !,?INDENT,"Patient date of birth:",?C1S,BD," through ",ED
 . I (PXRRDOBS=0) D
 .. W !,?INDENT,"Patient age range:",?C1S,PXRRMINA," or more"
 .. S ED=$$FMTE^XLFDT(PXRRDOBE)
 .. W !,?INDENT,"Patient date of birth:",?C1S,ED," or before"
 . I (PXRRDOBE=DT) D
 .. W !,?INDENT,"Patient age range:",?C1S,"Up to ",PXRRMAXA
 .. S BD=$$FMTE^XLFDT(PXRRDOBS),ED=$$FMTE^XLFDT(DT)
 .. W !,?INDENT,"Patient date of birth:",?C1S,BD," through ",ED
 E  W !,?INDENT,"Patient age range:",?C1S,"ALL"
 ;
 I $D(PXRRRACE) D
 . N RACE
 . S RACE="race"
 . I NRACE>1 S RACE="races"
 . W !?INDENT,"Patient ",RACE,":",?C1S,$P(PXRRRACE(1),U,2)
 . F IC=2:1:NRACE W !,?C1S,$P(PXRRRACE(IC),U,2)
 E  W !?INDENT,"Patient race(s):",?C1S,"ALL"
 ;
 I $D(PXRRSEX) W !?INDENT,"Patient sex:",?C1S,$P(PXRRSEX,U,2)
 E  W !?INDENT,"Patient sex:",?C1S,"BOTH"
 ;
 I $D(PXRRSCAT) D OSCAT^PXRRGPRT(PXRRSCAT,INDENT)
 ;
 I $P($G(PXRRPRSC),U,1)="C" D PECLASS^PXRRGPRT(INDENT)
 ;
MAXP W !!,?INDENT,"Maximum number of diagnoses to be displayed: ",PXRRDMAX
 ;
 S CMAX=70
 ;
 I $D(PXRRLCSC) D
 . I PXRRLCSC["C" S PLOCNAM="Clinic Stop: "
 . I PXRRLCSC["H" S PLOCNAM="Hospital Location: "
 ;
 S FACILITY=""
NFAC S INFOTYPE="FACILITY"
 S FACILITY=$O(^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY))
 I +FACILITY=0 Q
 ;Mark the facility as being found.
 F IC=1:1:NFAC I $P(PXRRFAC(IC),U,1)=FACILITY D  Q
 . S $P(PXRRFAC(IC),U,4)="M"
 S FACPNAME=$P(PXRRFACN(FACILITY),U,1)_"  "_$P(PXRRFACN(FACILITY),U,2)
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRFDD
 ;
NINFO S INFOTYPE=$O(^XTMP(PXRRXTMP,"INFO",INFOTYPE))
 I INFOTYPE="" G NFAC
 ;
 I INFOTYPE["LOC" S BYLOC=1
 E  S BYLOC=0
 I INFOTYPE["PC" S BYPC=1
 E  S BYPC=0
 I INFOTYPE["PRV" S BYPRV=1
 E  S BYPRV=0
 ;
 S PRV=""
NPRV ;
 S PRV=$O(^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY,PRV))
 I PRV="" G NINFO
 ;
 S VACODE=""
NVACODE ;
 S VACODE=$O(^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY,PRV,VACODE))
 I VACODE="" G NPRV
 ;
 S HLOC=""
NLOC S HLOC=$O(^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY,PRV,VACODE,HLOC))
 I HLOC="" G NVACODE
 ;
 S STOIND=^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY,PRV,VACODE,HLOC)
 ;
 ;If the report is by provider get a person class for the provider.
 I BYPRV D
 . S TEMP=$P(PRV,U,4)
 . I $L(TEMP)>0 S PCLASS=$$ABBRV^PXRRPECU(TEMP)
 . E  S PCLASS="Unknown"
 ;
 ;If the report is by person class get the person class.
 I BYPC D
 . S PCLASS=$$ABBRV^PXRRPECU(VACODE)
 ;
 S HEAD=1
 D HEAD(0)
 I DONE G EXIT
 S C1S=INDENT+60
 I $Y>(IOSL-BMARG-4) D HEAD(1)
 I DONE G EXIT
 I $P(PXRRFDDC,U,1)="P" S TEMP="Total number of Primary Diagnoses for these Encounters:"
 E  S TEMP="Total number of Diagnoses for these Encounters:"
 I $D(^XTMP(PXRRXTMP,"TOTALS","ENCTOT",STOIND)) S ETOT=^XTMP(PXRRXTMP,"TOTALS","ENCTOT",STOIND)
 E  S ETOT=0
 S TOTSTR=$S(DOCOUNT=1:"DIAGTOT",1:"DGTOT10")
 I $D(^XTMP(PXRRXTMP,"TOTALS",TOTSTR,STOIND)) S DTOT=^XTMP(PXRRXTMP,"TOTALS",TOTSTR,STOIND)
 E  S DTOT=0
 S LEN=$$MAX^XLFMTH($L(DTOT),$L(ETOT))
 W !!,?INDENT,"Total number of Encounters meeting the selection criteria:",?C1S,$J(ETOT,LEN)
 W !,?INDENT,TEMP,?C1S,$J(DTOT,LEN)
 S RATIO=$S(ETOT>0:(DTOT/ETOT),1:0)
 W !,?INDENT,"Diagnoses/Encounter ratio:",?C1S,$J(RATIO,LEN,2)
 ;
 S C1S=INDENT+8,C2E=INDENT+59
 S C1HS=INDENT+9,C2HS=INDENT+33
 S TOTAL=""
 S NUM=0,ICDSTR=$S(DOCOUNT=1:"ICD9",1:"ICD10")
NTOTICD S TOTAL=$O(^XTMP(PXRRXTMP,"PRINT",STOIND,ICDSTR,TOTAL),-1)
 I TOTAL="" G DIAGCAT
 S TEMP=TOTAL
 S ICD9IEN=""
NICD9 S ICD9IEN=$O(^XTMP(PXRRXTMP,"PRINT",STOIND,ICDSTR,TOTAL,ICD9IEN),-1)
 I ICD9IEN="" G NTOTICD
 S NUM=NUM+1
 I NUM=1 S HEAD=1
 I $Y>(IOSL-BMARG-5) S NEWPAGE=1
 E  S NEWPAGE=0
 D DHEAD(NEWPAGE)
 I DONE G EXIT
 S C3S=C3E-$L(TEMP)
 S ICDDATA=$$ICDDATA^ICDXCODE("DIAG",ICD9IEN,ICDDATE,"I")
 W !," ",$P(ICDDATA,U,2),?11,$E($P(ICDDATA,U,4),1,60),?72,$J($FN(TEMP,",",0),7)
 I NUM<PXRRDMAX G NICD9
DIAGCAT ;
 S C1S=INDENT+8,C1E=INDENT+38
 S C1HS=14
 S TOTAL=""
 S NUM=0
 S DCSTR=$S(DOCOUNT=1:"DC",1:"DC10")
NTOTDC S TOTAL=$O(^XTMP(PXRRXTMP,"PRINT",STOIND,DCSTR,TOTAL),-1)
 I TOTAL="" G NLOC
 S TEMP=TOTAL
 S DCIEN=""
NDC S DCIEN=$O(^XTMP(PXRRXTMP,"PRINT",STOIND,DCSTR,TOTAL,DCIEN),-1)
 I DCIEN="" G NTOTDC
 S NUM=NUM+1
 I NUM=1 S HEAD=1
 I $Y>(IOSL-BMARG-5) S NEWPAGE=1
 E  S NEWPAGE=0
 D DCHEAD(NEWPAGE)
 I DONE G EXIT
 S C2S=C2E-$L(TEMP)
 ;We will need a DBIA to read ICM.  Some sites have had a corrupted ICM
 ;file.  Check for this problem, if found print an error message and
 ;quit.
 I (DCIEN>0)&('$D(^ICM(DCIEN,0))) D  G EXIT
 . W !!,"CANNOT CONTINUE, File 80.3 Major Diagnostic Category is corrupted!"
 . W !,"^ICM(",DCIEN,",0) is missing."
 . W !,"Please contact customer service for help."
 I DCIEN>0 W !,?INDENT,$J(NUM,5),".",?C1S,$P(^ICM(DCIEN,0),U,1),?C2S,TEMP
 E  W !,?INDENT,$J(NUM,5),".",?C1S,"Unknown",?C2S,TEMP
 I NUM<PXRRDMAX G NDC
 ;
 ;Get the next location.
 G NLOC
END ;
 ;Check for facilities that were listed but had no encounters.
 D FACNE^PXRRGPRT(INDENT)
EXIT ;
 D EXIT^PXRRGUT
 D EOR^PXRRGUT
 Q
 ;
 ;=======================================================================
DHEAD(NEWPAGE) ;
 N DASH60 S $P(DASH60,"-",61)=""
 I NEWPAGE D PAGE^PXRRGPRT
 E  I $Y>(IOSL-BMARG) D PAGE^PXRRGPRT
 I DONE Q
 I (HEAD)&(RATIO>0) D
 . S LEN=$$MAX^XLFMTH(9,$L(TEMP))
 . S MID=C2E+3+(LEN/2)
 . S C3HS=MID-5
 . S C3E=MID+($L(TEMP)/2)
 . W !!,?INDENT,PXRRDMAX," Most Frequent ICD",$S(DOCOUNT=1:"9",1:"10")," Diagnoses:"
 . W !," Code",?11,"Description",?72,"Freq."
 . W !," --------",?11,DASH60,?72,"-------"
 . S HEAD=0
 Q
 ;
 ;=======================================================================
DCHEAD(NEWPAGE) ;
 I NEWPAGE D PAGE^PXRRGPRT
 E  I $Y>(IOSL-BMARG) D PAGE^PXRRGPRT
 I DONE Q
 I (HEAD)&(RATIO>0) D
 . S LEN=$$MAX^XLFMTH(9,$L(TEMP))
 . S MID=C1E+3+(LEN/2)
 . S C2HS=MID-5
 . S C2E=MID+($L(TEMP)/2)
 . W !!,?INDENT,PXRRDMAX," Most Frequent ICD",$S(DOCOUNT=1:"9",1:"10")," Diagnostic Categories:"
 . W !,?C1HS,"Diagnostic Category",?C2HS,"Frequency"
 . W !,?C1S,"------------------------------",?C2HS,"---------"
 . S HEAD=0
 Q
 ;
 ;=======================================================================
HEAD(NEWPAGE) ;
 N LEN,TEMP
 I NEWPAGE D PAGE^PXRRGPRT
 E  I $Y>(IOSL-BMARG-8) D PAGE^PXRRGPRT
 I DONE Q
 I HEAD D
 . W !!,"___________________________________________________________________"
 . W !,"Facility: ",FACPNAME
 . I BYLOC W !,PLOCNAM,$P(HLOC,U,1)_" (",$P(HLOC,U,3)_")"
 . I BYPRV D
 .. S TEMP="Provider: "_$P(PRV,U,1)_" ("_PCLASS_")"
 .. S LEN=$L(TEMP)
 .. I LEN>CMAX D
 ... W !,$E(TEMP,1,CMAX)
 ... W !," ",$E(TEMP,CMAX+1,LEN)
 .. E  W !,TEMP
 . I BYPC D
 .. W !,"Person Class (Occupation+Specialty+Subspecialty): "
 .. S LEN=INDENT+$L(PCLASS)
 .. I LEN>CMAX D
 ... W !,?INDENT,$E(PCLASS,1,CMAX)
 ... W !,?(INDENT+1),$E(PCLASS,CMAX+1,LEN)
 .. E  W !,?INDENT,PCLASS
 . S HEAD=0
 Q
 ;
