VAQLED03 ;ALB/JFP,JRP - PDX, DISPLAY POSSIBLE MATCHES, SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**6,10**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 K DFNARR
 W !!,"Checking for potential duplicates and matches of remote patient "
 S VAQDFN=$$GETDFN^VAQUTL97(VAQPTNM,1) I +VAQDFN>0 S DFNARR(VAQDFN)=""
 S VAQDFN=$$GETDFN^VAQUTL97(VAQISSN,1) I +VAQDFN>0 S DFNARR(VAQDFN)=""
 ;
 N DOB,SSN,DPTNM,DPTKS,DPTKD
 S DPTNM=VAQPTNM,SSN=VAQISSN
 S DOB=$S(VAQIDOB'="":VAQIDOB,1:" ")
 S (DPTKS,DPTKD)=0
 D ^DPTDUP ; -- Duplicate checker
 I $D(DPTD)&(DPTD>0) S VAQDFN="" F  S VAQDFN=$O(DPTD(VAQDFN))  Q:VAQDFN=""  S DFNARR(VAQDFN)=""
 I '$D(VAQCHK) D EN^VALM("VAQ MATCHES PDX8") K DPTD
 Q
 ;
INIT ; -- Builds array of possible matches
 K ^TMP("VAQL3",$J),^TMP("VAQIDX",$J)
 S DFN="",(VAQECNT,VALMCNT)=0
 F  S DFN=$O(DPTD(DFN))  Q:DFN=""  D SETD
 I VAQECNT=0 D
 .S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1(" ** No possible matches found for patient entered... ","",1,80) D TMP
 Q
 ;
SETD ; -- Set data for display in list processor
 S VAQECNT=VAQECNT+1
 D DEM^VADPT
 S X=$$SETFLD^VALM1(VAQECNT,"","ENTRY")
 S X=$$SETFLD^VALM1(VADM(1),X,"LOCAL PATIENT NAME")
 S X=$$SETFLD^VALM1($P(VADM(2),U,2),X,"SSN")
 S VAERR=$$DOBFMT^VAQUTL99($P(VADM(3),U,1))
 S X=$$SETFLD^VALM1(VAERR,X,"DOB")
 S X=$$SETFLD^VALM1(VA("PID"),X,"PID")
 D TMP
 K VA,VADM,VAERR ; -- cleans up local variables set by vadpt call
 Q
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQL3",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQL3",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQIDX",$J,VAQECNT)=DFNTR_"^"_DFN
 Q
 ;
HD ; -- Make header line for list processor
 S VALMHDR(1)=$$INSERT^VAQUTL1("Remote Patient Name","",9)
 S VALMHDR(1)=$$INSERT^VAQUTL1("DOB",VALMHDR(1),41)
 S VALMHDR(1)=$$INSERT^VAQUTL1("SSN",VALMHDR(1),54)
 S VALMHDR(2)=$$INSERT^VAQUTL1(VAQPTNM,"",9)
 S VALMHDR(2)=$$INSERT^VAQUTL1(VAQEDOB,VALMHDR(2),41)
 S VALMHDR(2)=$$INSERT^VAQUTL1(VAQESSN,VALMHDR(2),54)
 S VALMHDR(3)=" "
 Q
 ;
SEL ; -- Select possible match
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S SDI=""
 S SDI=$O(VALMY(SDI))
 S SDAT=$G(^TMP("VAQIDX",$J,SDI))
 S DFNTR=$P(SDAT,U,1)
 S DFNPT=$P(SDAT,U,2)
 D MRGECHK
 S VAQBCK=1
 K VALMBCK
 Q
 ;
EXP ; -- Displays MAS minimal information from patient file (2)
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S SDI=""
 F  S SDI=$O(VALMY(SDI))  Q:SDI=""  D
 .S SDAT=$G(^TMP("VAQIDX",$J,SDI))
 .S DFN=$P(SDAT,U,2)
 .D PT^VAQDIS01 ; -- display local patient data
 S VALMBCK="R"
 Q
 ;
NEW ; -- Creates new patient in local database
 D ^VAQLED07
 K VALMBCK
 Q
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQL3",$J),^TMP("VAQIDX",$J),DFNARR
 K VAQECNT,DFN,DPTD,X,VALMY,SDI,SDAT
 Q
 ;
MRGECHK ;CHECK FOR EXACT MATCH BEFORE ALLOWING MERGE
 N TMP,LOCNAME,LOCSSN,LOCDOB,DIFF
 ;GET LOCAL PATIENT
 S TMP=$$PATINFO^VAQUTL1(DFNPT)
 S LOCNAME=$P(TMP,"^",1)
 S LOCSSN=$TR($P(TMP,"^",2),"-","")
 S LOCDOB=$$DATE^VAQUTL99($P(TMP,"^",3))
 S:(LOCDOB="-1") LOCDOB=""
 ;COMPARE AGAINST REMOTE PATIENT
 S DIFF=0
 S:(VAQPTNM'=LOCNAME) DIFF=DIFF+1
 S:(VAQISSN'=LOCSSN) DIFF=DIFF+2
 S:(VAQIDOB'=LOCDOB) DIFF=DIFF+4
 ;NO DIFFERENCES - MERGE ALLOWED
 I ('DIFF) D EP^VAQLED02 Q
 ;PRINT DIFFERENCES
 D CLEAR^VALM1
 S TMP="***** MERGING OF REMOTE PATIENT WITH LOCAL PATIENT NOT ALLOWED *****"
 S X=$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)/2)))
 W $C(7),X
 S TMP=""
 I (DIFF>3) S TMP="DATE OF BIRTH",DIFF=DIFF-4
 I (DIFF>1) S:(TMP'="") TMP=" and "_TMP S TMP="SOCIAL SECURITY NUMBER"_TMP,DIFF=DIFF-2
 I (DIFF) S:(TMP'="") TMP=" and "_TMP S TMP="NAME"_TMP
 S TMP="***** "_TMP_" do"_$S((TMP'[" and "):"es",1:"")_" not match *****"
 S X=$$INSERT^VAQUTL1(TMP,"",(40-($L(TMP)/2)))
 W !,X,$C(7)
 W !!,?22,"Name",?48,"SSN",?64,"DOB"
 S X=$$REPEAT^VAQUTL1("-",30)
 W !,?8,X,?43,$E(X,1,12),?60,$E(X,1,10)
 W !," Local: ",LOCNAME,?43,$$DASHSSN^VAQUTL99(LOCSSN),?60,$$DOBFMT^VAQUTL99(LOCDOB,0)
 W !,"Remote: ",VAQPTNM,?43,VAQESSN,?60,VAQEDOB
 W !!!
 W !,?3,"Pertinent patient data must match in order for the upload process"
 W !,?3,"to continue.  Local and remote patient should be verified using the"
 W !,?3,"appropriate procedures.  Once verified, the Load/Edit Patient Data"
 W !,?3,"option, which is found in the Registration Menu, should be used to"
 W !,?3,"correct the information."
 F X=$Y:1:(IOSL-5) W !
 D PAUSE^VALM1
 Q
