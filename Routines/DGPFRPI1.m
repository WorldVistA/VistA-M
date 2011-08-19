DGPFRPI1 ;ALB/RBS - PRF PRINCIPAL INVEST REPORT CONT. ; 6/8/04 5:07pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used to display/print all patient assignments
 ;for a Principal Investigator assigned to the Research record flag.
 ;
 ; Input:   DGSORT() - Array containing user report parameters.
 ;
 ; Output:  A formatted report of the Principal Investigator person's
 ;          associated patient record flag assignments.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 ;
 I $E(IOST)="C" D WAIT^DICD
 N DGLIST ;temp global name used for report list
 S DGLIST=$NA(^TMP("DGPFRPI1",$J))
 K @DGLIST
 D LOOP(.DGSORT,DGLIST)
 D PRINT^DGPFRPI2(.DGSORT,DGLIST)
 K @DGLIST
 D EXIT
 Q
 ;
LOOP(DGSORT,DGLIST) ;use sort var's for record searching to build list
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name
 ;
 ; Output:
 ;      ^TMP("DGPFRPI1",$J) - temp global containing report output
 ;
 N DGAIEN   ;patient assignment ien
 N DGBEG    ;sort beginning date
 N DGCNT    ;flag counter
 N DGDFNLST ;array of patient dfn's assigned to the flag
 N DGEND    ;sort ending date
 N DGFIEN   ;flag ien
 N DGFLAG   ;local array used to hold flag record
 N DGPI     ;principal investigator person ien
 N DGPIIEN  ;sort selection var
 N DGPINAME ;name of principal investigator
 N DGPINUM  ;subscript number for principal investigator
 N DGPRINC  ;principal investigator sort
 N DGSTAT   ;status of assignment
 N DGSTATUS ;sort status
 N DGSUB    ;loop flag name var
 N DGVPTR   ;variable pointer of flag record (i.e.) "25;DGPF(26.11,"
 N DGX      ;loop var
 ;
 ; setup variables equal to user input parameter subscripts
 ; Only Category II (Local) ^DGPF(26.11) file for Research Flags
 ;   "DGPRINC", "DGSTATUS", "DGBEG", "DGEND"
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 ;
 S DGPIIEN=+DGPRINC  ; if 0, then 'A'll PI sort was selected
 S DGSTAT=+DGSTATUS
 S:DGSTAT=2 DGSTAT=0  ; inactive assignment status value is '0'
 ;
 ; loop research type (2) record flag x-ref
 S DGSUB="",DGCNT=0
 F  S DGSUB=$O(^DGPF(26.11,"ATYP",2,DGSUB)) Q:DGSUB=""  D
 . S DGFIEN=""
 . F  S DGFIEN=$O(^DGPF(26.11,"ATYP",2,DGSUB,DGFIEN)) Q:DGFIEN=""  D
 . . K DGFLAG
 . . Q:'$$GETLF^DGPFALF(DGFIEN,.DGFLAG)  ;local flag record data
 . . Q:DGPIIEN&'$D(^DGPF(26.11,DGFIEN,2,"B",DGPIIEN))
 . . S (DGPINUM,DGPI)=""
 . . F  S DGPINUM=$O(DGFLAG("PRININV",DGPINUM)) Q:DGPINUM=""  D
 . . . S DGPI=$P($G(DGFLAG("PRININV",DGPINUM,0)),U)
 . . . S DGPINAME=$P($G(DGFLAG("PRININV",DGPINUM,0)),U,2)
 . . . S:DGPINAME']"" DGPINAME="Missing Name"
 . . . S DGVPTR=DGFIEN_";DGPF(26.11,"  ; flag variable pointer setup
 . . . K DGDFNLST
 . . . S DGCNT=$$ASGNCNT^DGPFLF6(DGVPTR,.DGDFNLST)  ;patient dfn list
 . . . Q:'DGCNT
 . . . D BLDTMP(DGBEG,DGEND,DGSTAT,DGPI,DGPINAME,.DGDFNLST,DGLIST)
 Q
 ;
BLDTMP(DGBEG,DGEND,DGSTAT,DGPI,DGPINAME,DGDFNLST,DGLIST) ; list global builder
 ;  Input:
 ;      DGBEG    - sort beginning date
 ;      DGEND    - sort ending date
 ;      DGSTAT   - status of assignment
 ;      DGPI     - principal investigator person ien
 ;      DGPINAME - name of principal investigator
 ;      DGDFNLST - array of patient dfn's assigned to the flag
 ;      DGLIST   - temp global name used for report list
 ;
 ; Output:
 ;      ^TMP("DGPFRPI1",$J) - temp global containing report output
 ;
 N DGACTDT ;initial entry date
 N DGAIEN  ;patient assignment ien
 N DGDFN   ;pointer to patient being reported on
 N DGFGNM  ;flag name
 N DGHIEN  ;history assignment ien
 N DGINIT  ;initial assignment date
 N DGPFA   ;assignment data array
 N DGPFAH  ;assignment history data array
 N DGLINE  ;report detail line
 N DGPAT   ;array of patient demographics
 N DGPNM   ;patient name
 N DGREV   ;review date
 ;
 S DGDFN=""
 F  S DGDFN=$O(DGDFNLST(DGDFN)) Q:DGDFN=""  D
 . S DGAIEN=$G(DGDFNLST(DGDFN))
 . Q:DGAIEN=""
 . K DGPFA
 . Q:'$$GETASGN^DGPFAA(DGAIEN,.DGPFA)  ;get assignment data
 . Q:DGDFN'=$P(DGPFA("DFN"),U)
 . I DGSTAT'=3,+DGPFA("STATUS")'=DGSTAT Q  ;not correct status
 . ; get last history record (most current)
 . K DGPFAH
 . S DGHIEN=$$GETLAST^DGPFAAH(DGAIEN)
 . Q:'DGHIEN
 . Q:'$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH)
 . S DGINIT=+$$GETADT^DGPFAAH(DGAIEN)  ;initial assignment date
 . Q:'DGINIT
 . ; check if assignment falls within the Begin and End dates
 . I DGINIT>DGBEG&($P(DGINIT,".")'>DGEND) D
 . . ; get patient demographics
 . . K DGPAT
 . . Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPAT)
 . . S DGPNM=DGPAT("NAME")
 . . S:DGPNM']"" DGPNM="Missing Patient Name"
 . . S DGFGNM=$P(DGPFA("FLAG"),U,2)
 . . S:DGFGNM']"" DGFGNM="Missing Flag Name"
 . . S DGACTDT=$$FDATE^VALM1(+DGPFAH("ASSIGNDT"))
 . . S DGAIEN=+DGPFAH("ASSIGN")
 . . I +DGPFA("REVIEWDT") S DGREV=$$FDATE^VALM1(+DGPFA("REVIEWDT"))
 . . E  S DGREV="N/A"
 . . S DGLINE=DGPAT("SSN")_U_$P(DGPFAH("ACTION"),U,2)_U_DGACTDT_U_DGREV_U_$P(DGPFA("STATUS"),U,2)
 . . ; - Flag Name, 0 node, IEN of Principal Investigator = PI Name
 . . S @DGLIST@(DGFGNM,0,DGPI)=DGPINAME
 . . ; - Flag Name, Pat Name, DFN, Asignment IEN
 . . S @DGLIST@(DGFGNM,DGPNM,DGDFN,DGAIEN)=DGLINE
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
