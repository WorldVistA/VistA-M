IBCNBCD2 ;ALB/AWC - MCCF FY14 Display Group Plan Coverage Limitations from Insurance Buffer entry ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Input Parameters:
 ;   See routine IBCNBCD1
 ;
COVLIM(IBBUFDA,IBGRPDA,IBCSAV,IBQ,IBERR) ; Coverage Limitations entry point. - Called from routine ACCOV^IBCNBAA
 N IBGSAV,IBSYS,IBDATE,IBDTL,IBFOUND,IBDATA,IBEDIT,IBOUT,IBPLAN,IBYES,IBTXT,IBN,DTOUT
 S IBN=0,IBTXT=""
 ;
 ; -- **** CAUTION DO NOT KILL ****  
 N IBSYS S IBSYS=$NA(^IBA(355.32)) ; -- **** VistA System Coverage Limitation Global ****
 ; -- **** CAUTION DO NOT KILL ****  
 ;
 ;
 F  S IBQ=$$ASKREV() Q:IBQ'=1!($D(DTOUT))  D  Q:$D(IBERR)
 . ;
 . ; -- display a list of coverage limitations years for the group policy
 . D CVDTS(IBGRPDA,.IBDTL)
 . ;
 . ; -- prompt user to select coverage limitation year
 . S IBDATE=$$ASKYR() Q:$E(IBDATE)=U!($D(DTOUT))
 . ;
 . ; -- get data for selected coverage limitation year
 . S IBFOUND=$$CVDATA(IBDATE,.IBDTL,.IBGSAV,.IBSYS,.IBDATA,.IBERR) Q:$D(IBERR)
 . ;
 . ; -- user entered a new date not found in the display list
 . I 'IBFOUND D  Q:'IBYES!('IBFOUND)!($D(IBERR))
 . . ;
 . . ; -- ask user to create new benifit year
 . . S IBYES=$$CREYR(.IBDATE) Q:'IBYES
 . . ;
 . . ; -- create a new record entry
 . . D CVDLC(IBGRPDA,IBDATE,.IBDTL,.IBERR) Q:$D(IBERR)
 . . ;
 . . ; -- get data for newly created record
 . . S IBFOUND=$$CVDATA(IBDATE,.IBDTL,.IBGSAV,.IBSYS,.IBDATA,.IBERR) Q:$D(IBERR)
 . . S IBN=1
 . . ;
 . ;
 . ; -- get coverage plans and display coverage limitations for selected year
 . D CVPLAN(.IBPLAN) S IBOUT=$$CVDISP^IBCNBCD3(.IBDATA,.IBPLAN) Q:IBOUT
 . ;
 . ; -- edit coverage limitations
 . S IBTXT=$S(IBN:"the NEW",1:"existing")
 . S IBEDIT=$$EDTYR(IBDATE,IBTXT) I IBEDIT D CVEDIT(IBGRPDA,.IBGSAV,.IBSYS,IBDATE,.IBCSAV,.IBDATA,.IBERR)
 . S IBN=0
 . ;
 D CVOUT(.IBDATA)
 Q
 ;
CVDTS(IBGRPDA,IBDTL) ; Display a list of Coverage Limitations Years to select
 N IBI,IBIEN,IBDT,IBXDT,IBIDT,IBRET
 ;
 S IBDTL=$NA(^TMP("IBCNBCD2 CVDTS DATES",$J))
 K @IBDTL
 ;
 F IBI=0:0 S IBI=$O(^IBA(355.32,"APCD",IBGRPDA,IBI)) Q:IBI'>0  D
 . S IBDT="" F  S IBDT=$O(^IBA(355.32,"APCD",IBGRPDA,IBI,IBDT)) Q:IBDT=""  D
 . . S IBIEN=$O(^IBA(355.32,"APCD",IBGRPDA,IBI,IBDT,0))
 . . S IBIDT=-(IBDT) D DT^DILF("E",IBIDT,.IBRET) S IBXDT=$G(IBRET(0))
 . . ;
 . . ; -- put dates in assending order  -  example: S @IBDTL@(nncyyddmm,IEN)=mmm dd, yyyy
 . . I IBXDT["JAN" S @IBDTL@(11_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["FEB" S @IBDTL@(12_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["MAR" S @IBDTL@(13_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["APR" S @IBDTL@(14_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["MAY" S @IBDTL@(15_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["JUN" S @IBDTL@(16_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["JUL" S @IBDTL@(17_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["AUG" S @IBDTL@(18_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["SEP" S @IBDTL@(19_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["OCT" S @IBDTL@(20_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["NOV" S @IBDTL@(21_IBIDT,IBIEN)=IBXDT Q
 . . I IBXDT["DEC" S @IBDTL@(22_IBIDT,IBIEN)=IBXDT
 ;
 W !!,"Coverage Date:",!
 F IBDT=0:0 S IBDT=$O(@IBDTL@(IBDT)) Q:IBDT'>0  S IBIEN=$O(@IBDTL@(IBDT,0)) W ?2,@IBDTL@(IBDT,IBIEN),!
 Q
CVDATA(IBDATE,IBDTL,IBGSAV,IBSYS,IBDATA,IBERR) ; Get data for the selected year
 N IBI,IBJ,IBHOLD,IBFLDS,IBCDA,IBIEN,IBPLN,IBDAT,IBLOCK
 S IBDATA=$NA(^TMP("IBCNBCD2 CVDATA DATA",$J))
 S IBGSAV=$NA(^TMP("IBCNBCD2 IB CV GSAV",$J))
 K @IBDATA,@IBGSAV
 ; ;
 S IBDAT=0,IBFLDS=".02;.03;.04"
 ;
 F IBI=0:0 S IBI=$O(@IBDTL@(IBI)) Q:IBI'>0  I $E(IBI,3,$L(IBI))=+IBDATE D  Q:$D(IBERR)
 . F IBIEN=0:0 S IBIEN=$O(@IBDTL@(IBI,IBIEN)) Q:IBIEN'>0  D  Q:$D(IBERR)
 . . ;
 . . S IBHOLD=$NA(^TMP("IBCNBCD2 CVDATA HOLD",$J))
 . . K @IBHOLD
 . . D GETS^DIQ(355.32,IBIEN_",",.IBFLDS,"IE",.IBHOLD,"IBERR") I $D(IBERR) W !,"***Error...CVDATA^IBCNBCD2 Cannot retrieve Coverage Limitations data fields." D PAUSE^VALM1 Q
 . . S IBPLN=@IBHOLD@(355.32,IBIEN_",",.02,"E")
 . . M @IBDATA@(IBPLN)=@IBHOLD@(355.32,IBIEN_",")
 . . S @IBDATA@(IBPLN)=IBIEN ; -- top level so set it to the IEN
 . . S IBLOCK=$$CVLOCK(IBIEN,.IBSYS) I 'IBLOCK S IBERR=1 Q  ; -- lock the record
 . . ;
 . . ; -- save off the system global data
 . . S @IBGSAV@(IBIEN,0)=$G(^IBA(355.32,IBIEN,0))
 . . S @IBGSAV@(IBIEN,1)=$G(^IBA(355.32,IBIEN,1))
 . . S @IBGSAV@(IBIEN,2,0)=$G(^IBA(355.32,IBIEN,2,0))
 . . ;
 . . F IBJ=0:0 S IBJ=$O(^IBA(355.32,IBIEN,2,IBJ)) Q:IBJ'>0  D
 . . . S @IBDATA@(IBPLN,"COMM",IBJ)=^IBA(355.32,IBIEN,2,IBJ,0)
 . . . S @IBGSAV@(IBIEN,2,IBJ,0)=$G(^IBA(355.32,IBIEN,2,IBJ,0)) ; -- save off the system global comments data
 ;
 I $D(@IBDATA) S IBDAT=1
 Q IBDAT
 ;
CVPLAN(IBPLAN) ; Display/Edit Coverage Limitations for selected date
 N IBI,IBJ
 S IBPLAN=$NA(^TMP("IBCNBCD2 CVDSEL PLAN COV",$J))
 K @IBPLAN
 ;
 S IBI="" F  S IBI=$O(^IBE(355.31,"B",IBI)) Q:IBI']""  S IBJ=$O(^IBE(355.31,"B",IBI,0)) S @IBPLAN@(IBI,IBJ)=""
 Q
 ;
CVLOCK(IBIEN,IBSYS) ; Lock the Coverage Limitations records
 N IBOUT
 S IBOUT=1
 L +@IBSYS@(IBIEN):5 I '$T S IBOUT=0 D CVLKD
 Q IBOUT
 ;
CVEDIT(IBGRPDA,IBGSAV,IBSYS,IBDATE,IBCSAV,IBDATA,IBERR) ; Edit Coverage Limitations via Input Template 355.32
 N IBI,IBIEN,IBDR,IBDIF,IBSAV,IBADD,IBOUT,IBPLC
 N IBIP,IBOP,IBPH,IBDN,IBMH,IBLT
 N IBCI,IBCO,IBCP,IBCD,IBCM,IBCL
 ;
 ; -- check if data for the coverage categories
 S (IBOP,IBIP,IBPH,IBLT,IBDN,IBMH)="" ; -- DA's of the IBDATA global holding the record location
 S (IBCI,IBCO,IBCP,IBCD,IBCM,IBCL)="" ; -- pointers to the PLAN LIMITATION CATEGORY FILE (#355.31)
 ;
 ; -- get plan limitation categories ien'S
 S IBPLC=$NA(^TMP("IBCNBCD2 IB PLAN LIM CATEGORIES",$J))
 K @IBPLC
 D LIST^DIC(355.31,,"@;.01E",,,,,"B",,,.IBPLC,"IBERR") I $D(IBERR) W !,"*** Error...CVEDIT^IBCNBCD2 Cannot access Plan Limitations Category File!" D PAUSE^VALM1 Q
 F IBI=0:0 S IBI=$O(@IBPLC@("ID",IBI)) Q:IBI'>0  D
 . I @IBPLC@("ID",IBI,.01)="DENTAL" S IBCD=@IBPLC@(2,IBI) Q
 . I @IBPLC@("ID",IBI,.01)="OUTPATIENT" S IBCO=@IBPLC@(2,IBI) Q
 . I @IBPLC@("ID",IBI,.01)="PHARMACY" S IBCP=@IBPLC@(2,IBI) Q
 . I @IBPLC@("ID",IBI,.01)="INPATIENT" S IBCI=@IBPLC@(2,IBI) Q
 . I @IBPLC@("ID",IBI,.01)="MENTAL HEALTH" S IBCM=@IBPLC@(2,IBI) Q
 . I @IBPLC@("ID",IBI,.01)="LONG TERM CARE" S IBCL=@IBPLC@(2,IBI)
 ;
 ; -- check if our data list contain plan coverage limitations
 S IBI=""
 F  S IBI=$O(@IBDATA@(IBI)) Q:IBI']""  D
 . I IBI="INPATIENT" S IBIP=IBI Q
 . I IBI="OUTPATIENT" S IBOP=IBI Q
 . I IBI="PHARMACY" S IBPH=IBI Q
 . I IBI="DENTAL" S IBDN=IBI Q
 . I IBI="MENTAL HEALTH" S IBMH=IBI Q
 . I IBI="LONG TERM CARE" S IBLT=IBI
 ;
 ;
 W !!,"---------------------- EDIT COVERAGE LIMITATIONS INFORMATION  -----------------------",!
 ;
 ; -- inpatient
 I IBIP]"" D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . S IBOUT=0,IBIEN=$G(@IBDATA@(IBIP)),IBDR="[IBCNBC CV IP EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBIP,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBIP']"" S IBADD=$$ASKADD("INPATIENT",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCI,IBDATE,.IBERR)
 ;
 ; -- outpatient
 I IBOP]"" D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . W ! S IBOUT=0,IBIEN=$G(@IBDATA@(IBOP)),IBDR="[IBCNBC CV OP EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBOP,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBOP']"" S IBADD=$$ASKADD("OUTPATIENT",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCO,IBDATE,.IBERR)
 ;
 ; -- pharmacy
 I IBPH]"" D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . W ! S IBOUT=0,IBIEN=$G(@IBDATA@(IBPH)),IBDR="[IBCNBC CV PH EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBPH,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBPH']"" S IBADD=$$ASKADD("PHARMACY",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCP,IBDATE,.IBERR)
 ;
 ; -- dental
 I IBDN]"" D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . W ! S IBOUT=0,IBIEN=$G(@IBDATA@(IBDN)),IBDR="[IBCNBC CV DN EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBDN,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBDN']"" S IBADD=$$ASKADD("DENTAL",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCD,IBDATE,.IBERR)
 ;
 ; -- mental health
 I IBMH]""  D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . W ! S IBOUT=0,IBIEN=$G(@IBDATA@(IBMH)),IBDR="[IBCNBC CV MH EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBMH,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBMH']"" S IBADD=$$ASKADD("MENTAL HEALTH",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCM,IBDATE,.IBERR)
 ;
 ; -- long term
 I IBLT]"" D  Q:IBOUT!($D(IBERR))!($D(DTOUT))
 . W ! S IBOUT=0,IBIEN=$G(@IBDATA@(IBLT)),IBDR="[IBCNBC CV LT EDIT]"
 . D EDTREC(IBIEN,IBDR) I $G(Y(0))="AUDIT" S IBOUT=1 Q
 . S IBDIF=$$CVDIF(.IBSYS,.IBGSAV,IBIEN),IBSAV=1
 . I IBDIF S IBSAV=$$CVASK()
 . I (IBDIF&('IBSAV))!($D(DTOUT)) D CVUNDO(IBIEN,IBLT,.IBSYS,.IBGSAV,.IBDATA,.IBERR) Q
 . I (IBDIF&(IBSAV))&('$D(DTOUT)) S IBCSAV=1
 I IBLT']"" S IBADD=$$ASKADD("LONG TERM",IBDATE) Q:IBADD=U  I IBADD Q:'$$ADDCV(IBGRPDA,IBCL,IBDATE,.IBERR)
 Q
 ;
CVUNDO(IBIEN,IBPL,IBSYS,IBGSAV,IBDATA,IBERR) ; - undo any coverage limitations edits
 N X,Y,DA,DIC,DIK,IBI,IBJ,IBFLD,IBIENH,IBFDA
 ;
 S IBFDA=$NA(^TMP("IBCNBCD2 CV EDIT FDA",$J))
 K @IBFDA
 ;
 ; -- updo edits except for comments
 F IBFLD=.01:0 S IBFLD=$O(@IBDATA@(IBPL,IBFLD)) Q:IBFLD'>0  S @IBFDA@(355.32,IBIEN_",",IBFLD)=$G(@IBDATA@(IBPL,IBFLD,"E"))
 D FILE^DIE("E",.IBFDA,"IBERR") I $D(IBERR) S IBERR=1 W !,!,"*** Error...CVUNDO^IBCNBCD2 Cannot update Fields in the Coverage Limitations file! ",! K @IBFDA D PAUSE^VALM1
 ;
 ; -- put back any deleted comments
 S IBJ=0
 F IBI=0:0 S IBI=$O(@IBDATA@(IBPL,"COMM",IBI)) Q:IBI'>0  D  Q:$D(IBERR)
 . ;
 . ; -- if comment subscript deleted - add the comment
 . I $G(@IBSYS@(IBIEN,2,IBI,0))']"" D
 . . S DIC="^IBA(355.32,"_IBIEN_",2,",DIC(0)="L",DA(1)=IBIEN,DA=IBI,X=@IBDATA@(IBPL,"COMM",IBI)
 . . D FILE^DICN I '+Y S IBERR=1 W !,!,"*** Error...Cannot Add 'deleted' Comments in the Coverage Limitations file! ",! D PAUSE^VALM1
 . . ;
 . S IBJ=IBI
 ;
 ; -- delete any added comments
 I +IBJ F IBI=IBJ:0 S IBI=$O(@IBSYS@(IBIEN,2,IBI)) Q:IBI'>0  D
 . S DA(1)=IBIEN,DIK="^IBA(355.32,"_DA(1)_",2,",DA=IBI
 . D ^DIK K DA,DIK
 ;
 ; -- put modified comments into fda array
 S IBI=0,IBIENH=$G(@IBDATA@(IBPL))_","
 F IBFLD=0:0 S IBFLD=$O(@IBDATA@(IBPL,"COMM",IBFLD)) Q:IBFLD'>0  D
 . S IBIEN=IBFLD_","_IBIENH
 . S @IBFDA@(355.321,IBIEN,0)=$G(@IBDATA@(IBPL,"COMM",IBFLD))
 ;
 ; -- undo any modified comments
 I $D(@IBFDA)>9 D
 . D FILE^DIE("E",.IBFDA,"IBERR")
 . I $D(IBERR) W !,!,"*** Error...CVUNDO^IBCNBCD2 Cannot Put Original Comments in the Coverage Limitations file! ",! D PAUSE^VALM1
 Q
 ;
CVDLC(IBGRPDA,IBDATE,IBDTL,IBERR) ; Create records for the new coverage limitation year
 N IBI,IBPCC,IBIP,IBOP,IBPH,IBDN,IBMH,IBLT,IBIEN,IBDT,IBFDT
 ;
 S IBDTL=$NA(^TMP("IBCNBCD2 CVDTS DATES",$J)),IBPCC=$NA(^TMP("IBCNBCD2 IB COVERAGE CAT",$J))
 K @IBDTL,@IBPCC
 ;
 ; -- get coverage categories
 D LIST^DIC(355.31,,"@;.01E",,,,,"B","",,.IBPCC,"IBERR") I $D(IBERR) W !,"Error...CVDLC^IBCNBCD2 Cannot access PLAN LIMITATION CATEGORY FILE!" D PAUSE^VALM1 Q
 S (IBIP,IBOP,IBPH,IBDN,IBMH,IBLT)=0
 F IBI=0:0 S IBI=$O(@IBPCC@("ID",IBI)) Q:IBI'>0  D
 . I @IBPCC@("ID",IBI,.01)="INPATIENT" S IBIP=@IBPCC@(2,IBI) Q
 . I @IBPCC@("ID",IBI,.01)="OUTPATIENT" S IBOP=@IBPCC@(2,IBI) Q
 . I @IBPCC@("ID",IBI,.01)="PHARMACY" S IBPH=@IBPCC@(2,IBI) Q
 . I @IBPCC@("ID",IBI,.01)="DENTAL" S IBDN=@IBPCC@(2,IBI) Q
 . I @IBPCC@("ID",IBI,.01)="MENTAL HEALTH" S IBMH=@IBPCC@(2,IBI) Q
 . I @IBPCC@("ID",IBI,.01)="LONG TERM CARE" S IBLT=@IBPCC@(2,IBI)
 ;
 ; -- add new records to the database
 I IBIP&(IBOP)&(IBPH)&(IBDN)&(IBMH)&(IBLT) D  Q:$D(IBERR)
 . ;
 . ; -- format the date
 . S IBDT=+IBDATE D DT^DILF("E",IBDT,.IBRET) S IBFDT=$G(IBRET(0))
 . ;
 . ; -- load the coverage limitation date array with formatted date
 . S IBIEN=$$ADDCV(IBGRPDA,IBIP,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 . S IBIEN=$$ADDCV(IBGRPDA,IBOP,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 . S IBIEN=$$ADDCV(IBGRPDA,IBPH,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 . S IBIEN=$$ADDCV(IBGRPDA,IBDN,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 . S IBIEN=$$ADDCV(IBGRPDA,IBMH,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 . S IBIEN=$$ADDCV(IBGRPDA,IBLT,IBDATE,.IBERR) Q:$D(IBERR)  S @IBDTL@(99_IBDT,IBIEN)=IBFDT
 Q
 ;
ADDCV(IBGRPDA,IBCAT,IBDATE,IBERR) ; Add new coverage limitation record
 N X,Y,DA,DIC,IBIEN,IBA,IBB,IBC
 S IBIEN=0,IBC="COVERED"
 ;
 ; -- retrieve the plan limitation category
 S IBA=$$GET1^DIQ(355.31,IBCAT_",",.01,"E") I IBA']"" S IBERR=1 W !,"Error #1...ADDCV-IBCNBCD2 Cannot retrieve PLAN LIMITATION CATEGORY!" D PAUSE^VALM1 Q IBIEN
 S IBB=$P(IBDATE,U,2)
 ;
 ; -- update plan coverage limitation file
 S DIC="^IBA(355.32,",DIC(0)="L",X=IBGRPDA,DIC("DR")=".02///^S X=IBA;.03///^S X=IBB;.04///^S X=IBC"
 D FILE^DICN S IBIEN=+Y I IBIEN<0!(IBIEN=0) S IBERR=1 W !,"Error #2...ADDCV-IBCNBCD2 Cannot add New Record to the PLAN COVERAGE LIMITATIONS FILE!" D PAUSE^VALM1
 Q IBIEN
 ;
CVDIF(IBSYS,IBGSAV,IBIEN) ; -- check for any edits made to coverage limitations
 N IBI,IBDIF
 S IBDIF=0
 I $G(@IBSYS@(IBIEN,0))'=$G(@IBGSAV@(IBIEN,0)) S IBDIF=1 Q IBDIF
 I $G(@IBSYS@(IBIEN,1))'=$G(@IBGSAV@(IBIEN,1)) S IBDIF=1 Q IBDIF
 I $G(@IBSYS@(IBIEN,2,0))'=$G(@IBGSAV@(IBIEN,2,0)) S IBDIF=1 Q IBDIF
 I $D(@IBSYS@(IBIEN,2,0)) D
 . F IBI=0:0 S IBI=$O(@IBSYS@(IBIEN,2,IBI)) Q:IBI'>0!(IBDIF)  I $G(@IBSYS@(IBIEN,2,IBI,0))'=$G(@IBGSAV@(IBIEN,2,IBI,0)) S IBDIF=1 Q
 Q IBDIF
 ;
EDTREC(IBIEN,IBDR) ; Edit Coverage Limitaitons
 N DA,DR,DIE
 S DA=IBIEN,DR=IBDR
 S DIE="^IBA(355.32,",DIE("NO^")="BACKOUTOK"
 D ^DIE
 Q
 ;
CVOUT(IBDATA) ; -- unlock coverage limitations records
 N IBI,IBIEN
 I $D(IBDATA)>9 D
 . S IBI=""
 . F  S IBI=$O(@IBDATA@(IBI)) Q:IBI']""  S IBIEN=$G(@IBDATA@(IBI)) L -@IBSYS@(IBIEN)
 Q
 ;
CVLKD ; -- write locked message
 W !!,"Sorry, another user currently editing this entry."
 W !,"Try again in a few minutes."
 D PAUSE^VALM1
 Q
 ;
CVASK() ; Prompt to ask user to Save Changes
 Q $E($$READ^IBCNBAA("YA^::E","Save Changes to Coverage Limitations File Y/N? ","No","Enter Yes or No to Save the Changes to the CV File <or> ^ to Quit"))
 ;
ASKREV() ; Prompt to review Coverage Limitations
 Q $E($$READ^IBCNBAA("YA^::E","Do you want to Review the CV Y/N? ","No","Enter Yes or No to Review the Coverage Limitations <or> ^ to Quit"))
 ;
ASKYR() ; Prompt to Enter a New or Existing AB year
 Q $$READ^IBCNBAA("DA^::EX","Enter Existing Date or Add New Coverage Date:  ","","Enter a New/Existing Coverage Limitation Date <or> ^ to Quit")
 ;
ASKADD(IBTXT,IBDATE) ; Prompt to ask user to add new coverage CATEGORY
 Q $E($$READ^IBCNBAA("YA^::E","There is no "_IBTXT_" Coverage Category for year "_$P(IBDATE,U,2)_". Do you want to add it now Y/N? ","No","Enter Yes or No to add the record now  <or> ^ to Quit"))
 ;
EDTYR(IBDATE,IBTXT) ; Prompt to Edit an existing Coverage Date
 Q +$$READ^IBCNBAA("YA^::E","Are you sure you want to Edit "_IBTXT_" Coverage Date information: "_$P(IBDATE,U,2)_" Y/N?: ","","Enter Yes or No to Edit the Coverage Date")
 ;
CREYR(IBDATE) ; Prompt to Create a new Coverage Date
 Q +$$READ^IBCNBAA("YA^::E","Are you sure you want to Create a new Coverage Date:  "_$P(IBDATE,U,2)_" Y/N? ","","Enter Yes or No to Create a New Coverage Year Date")
