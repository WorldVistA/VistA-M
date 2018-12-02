DGPFRAL1 ;ALB/RBS - PRF ACTION NOT LINKED REPORT CONT. ; 10/12/05 2:48pm
 ;;5.3;Registration;**554,650,892,960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/SGM - July 9, 2018 15:55
 ;
 ; ICR# TYPE DESCRIPTION
 ;----- ---- ---------------------
 ;2171  Sup  $$STA^XUAF4
 ;10024 Sup  WAIT^DICD
 ;10063 Sup  $$S^%ZTLOAD
 ;10086 Sup  HOME^%ZIS
 ;10089 Sup  ^%ZISC
 ;10103 Sup  ^XLFDT: $$FMTE, $$NOW
 ;10112 Sup  $$SITE^VASITE
 ;
 ;This routine will be used to display or print all of the patient
 ;assignment history records that are not linked to a progress note.
 ;
 ; INPUT:  DGSORT() - see comments at the top of routine DGPFRAL for
 ;         explanation of DGSORT array
 ;
 ; Output:  A formatted report of patient Assignment History Actions
 ;          that are not linked to a TIU Progress Note.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 N DGLIST,DGQ,HD,TRM
 D INIT
 D LOOP I 'DGQ D PRINT(.DGSORT,DGLIST)
 ;
EXIT ;
 K @DGLIST
 I $D(ZTQUEUED) S ZTREQ="@"
 I 'DGQ,TRM S X=$$E^DGPFUT7 W @IOF
 I 'TRM,$Y>0 W @IOF
 Q
 ;
LOOP ;use sort var's for record searching to build list
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name
 ;
 ; Output:
 ;      ^TMP("DGPFRAL1",$J) - temp global containing report output
 ;
 N DGBEG    ;beginning date
 N DGC      ;var used to check which category is being reported on
 N DGCAT    ;flag category
 N DGCATG   ;category 1 or 2
 N DGCNT    ;flag counter
 N DGDFN    ;pointer to patient being reported on
 N DGDFNLST ;array of dfn's assigned to the flag
 N DGEND    ;ending date
 N DGHIENS  ;array subscripted by assignment history date
 N DGIEN    ;assignment ien
 N DGPAT    ;patient data array
 N DGPFA    ;assignment data array
 N DGSUB    ;loop flag
 N DGX      ;loop var
 ;
 ; setup variables equal to user input parameter subscripts
 ;   "DGCAT", "DGBEG", "DGEND"
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 S DGC=$S(+DGCAT=3:0,1:+DGCAT)
 S:DGC DGC=$S(DGC=1:26.15,1:26.11)
 N DGI S DGI=0
 ;
 ; loop assignment variable pointer flag x-ref file to run report
 S (DGDFN,DGIEN)="",(DGSUB,DGCNT)=0
 F  S DGSUB=$O(^DGPF(26.13,"AFLAG",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . I DGC,DGSUB'[DGC Q  ;not correct file based on category
 . S DGCATG=$S(DGSUB[26.15:1,1:2)
 . K DGDFNLST
 . S DGCNT=$$ASGNCNT^DGPFLF6(DGSUB,.DGDFNLST)
 . Q:'DGCNT
 . S DGDFN=""
 . F  S DGDFN=$O(DGDFNLST(DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . S DGI=1+DGI I '(DGI#200) D CHK Q:DGQ
 . . S DGIEN=$G(DGDFNLST(DGDFN)) Q:DGIEN=""
 . . ; get assignment record
 . . K DGPFA
 . . Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 . . ; check if calling site is owner site
 . . Q:'$$ISDIV^DGPFUT($P(DGPFA("OWNER"),U))
 . . ;
 . . ;filter patient when last action is ENTERED IN ERROR
 . . Q:$$ENTINERR(DGIEN)
 . . ;
 . . ;filter for single flag - DG*5.3*960
 . . Q:'$$FLAGNM($P(DGPFA("FLAG"),U))
 . . ;
 . . ;filter on assignment status - DG*5.3*960
 . . Q:'$$STATUS(+DGPFA("STATUS"))
 . . ;
 . . ;action ien array subscripted by assignment history date
 . . K DGHIENS
 . . Q:'$$GETALLDT^DGPFAAH(DGIEN,.DGHIENS)
 . . ; check if any Action's fall within the Begin and End dates
 . . I $P($O(DGHIENS("")),".")'>DGEND&($P($O(DGHIENS(""),-1),".")'<DGBEG) D
 . . . ;delete any action that is not within Begin and End dates
 . . . S DGX=0 F  S DGX=$O(DGHIENS(DGX)) Q:DGX=""  D
 . . . . I $P(DGX,".")<DGBEG!($P(DGX,".")>DGEND) K DGHIENS(DGX)
 . . . Q:'$O(DGHIENS(""))
 . . . ;
 . . . ; get patient demographics
 . . . K DGPAT
 . . . Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPAT)
 . . . ;
 . . . ; call to build temp global
 . . . D BLDTMP(.DGPFA,.DGPAT,.DGHIENS,DGCATG,DGLIST)
 ;
 Q
 ;
BLDTMP(DGPFA,DGPAT,DGHIENS,DGCATG,DGLIST) ; list global builder
 ;  Input:
 ;      DGPFA  - array of assignment record data
 ;      DGPAT  - array of patient demographics
 ;      DGHIENS - array of history action IEN's sorted by d/t
 ;      DGCATG - category of flag 1=National, 2=Local
 ;      DGLIST - temp global name used for report list
 ;
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DGACTDT ;initial entry date
 N DGFGNM  ;flag name
 N DGHIEN  ;assignment ien
 N DGLINE  ;report detail line
 N DGLNCNT ;unique subscript counter
 N DGPDFN  ;pointer to patient
 N DGPFAH  ;assignment history record data
 N DGPNM   ;patient name
 N DGFLAG   ;change of assignment flag
 ;
 ; Check to see if this was a change of assignment
 S DGFLAG=0
 N DGI S DGI=0
 D FLGXFER
 ;
 ; loop all assignment history ien's
 S DGHIEN="",DGLNCNT=0
 F  S DGHIEN=$O(DGHIENS(DGHIEN)) Q:DGHIEN=""  D  Q:DGQ
 . S DGI=DGI+1 I '(DGI#200) D CHK Q:DGQ
 . ;   get assignment history record
 . K DGPFAH
 . Q:'$$GETHIST^DGPFAAH(DGHIENS(DGHIEN),.DGPFAH)
 . Q:+$G(DGPFAH("TIULINK"))  ;  progress note pointer
 . Q:+$G(DGPFAH("ACTION"))=5  ; no ENTERED IN ERROR action
 . S DGACTDT=$$FMTE^XLFDT(+DGPFAH("ASSIGNDT")\1,"2Z")
 . I DGFLAG I +DGPFAH("ASSIGNDT")'>DGFLAG Q  ; if < assignment chg
 . Q:'$$LOCAL()  ;              check local/not local DG*5.3*960
 . S DGPNM=DGPAT("NAME")
 . S:DGPNM']"" DGPNM="MISSING PATIENT NAME"
 . S DGPDFN=$P(DGPFA("DFN"),U)
 . S DGFGNM=$P(DGPFA("FLAG"),U,2)
 . S:DGFGNM']"" DGFGNM="MISSING FLAG NAME"
 . S DGLINE=$E(DGPNM)_$E(DGPAT("SSN"),6,10)_U_$E(DGFGNM,1,17)
 . S DGLINE=DGLINE_U_$P(DGPFAH("ACTION"),U,2)_U_DGACTDT
 . S DGLNCNT=DGLNCNT+1
 . S @DGLIST@(DGCATG,DGFGNM,DGPNM,DGPDFN,DGLNCNT)=DGLINE
 ;
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name used for report list
 ;
 ; Output: Formatted report to user selected device
 ;
 N CAT   ;  flag category
 N OCAT  ;  previous flag category
 N DFN   ;  ien of patient
 N ODFN  ;  previous DFN
 N FLAG  ;  flag name
 N NAM   ;  patient name
 N OFLAG ;  previoous flag name
 N PAGE  ;  page counter
 N REF   ;  $query incrementing variable
 N STR   ;  string of detail line to display
 N I,X,Y,STOP,TOTAL
 ;
 S (OCAT,ODFN,OFLAG)=""
 S REF=DGLIST
 S STOP=$TR(REF,")",",")
 S (TOTAL,TOTAL(1),TOTAL(2))=0
 S PAGE=0
 ;
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria.",!
 . Q
 ;
 F I=1:1 S REF=$Q(@REF) Q:REF=""  Q:REF'[STOP  D  Q:DGQ
 . N NL S NL=1 ;  flag to indicate a new line is needed
 . S STR=@REF
 . S CAT=$QS(REF,3),FLAG=$QS(REF,4),NAM=$QS(REF,5),DFN=$QS(REF,6)
 . ; for each flag/pat combination, write flag and pat only once
 . ; however, repeat name/flag at beginning of new page
 . ; do header for each category change
 . I CAT'=OCAT,+OCAT D SUBTOT Q:DGQ
 . I CAT'=OCAT D HEAD S OCAT=CAT
 . I $Y>(IOSL-4) D PAUSE Q:DGQ  D HEAD S ODFN=""
 . I DFN'=ODFN D
 . . W !,$E(NAM,1,18),?20,$P(STR,U),?32,$E($P(STR,U,2),1,17)
 . . S ODFN=DFN,OFLAG=FLAG,NL=0
 . . Q
 . ; - write new flag name
 . I OFLAG'=FLAG S OFLAG=FLAG W !?32,$E($P(STR,U,2),1,17),NL=0
 . ; - write action detail
 . W:NL ! W ?51,$E($P(STR,U,3),1,16),?69,$P(STR,U,4)
 . S TOTAL(CAT)=TOTAL(CAT)+1
 . Q
 ;
 ;   Last category subtotals did not print
 S OCAT=CAT D SUBTOT
 ;
 D CHK
 ;   Print totals if both cat I & II selected
 I 'DGQ,+DGSORT("DGCAT")=3 D
 . I 'TRM,(IOSL-$Y)<10 D HEAD
 . W !!,"REPORT SUMMARY:",!,"---------------"
 . W !,"Total Actions not Linked for Category I:",?48,$J(TOTAL(1),7)
 . W !,"Total Actions not Linked for Category II:",?48,$J(TOTAL(2),7)
 . W !?48,"-------"
 . S X=TOTAL(1)+TOTAL(2)
 . W !,"Total Actions not Linked for Category I & II:",?48,$J(X,7)
 . Q
 W !!,"<End of Report>"
 Q
 ;
 ;-----------------------  PRIVATE SUBROUTINES  -----------------------
 ;
CHK ;
 ;   Check is Taskman request to stop
 I 'DGQ,$D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1
 I DGQ,$D(ZTQUEUED) W !!,"REPORT STOPPED AT USER REQUEST",!
 Q
 ;
ENTINERR(DGIEN) ;
 ;  Is last action ENTERED IN ERROR
 ;  Input:
 ;    DGIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - Return 1 on success, 0 on failure
 ;
 N DGPFAH
 I $$GETHIST^DGPFAAH($$GETLAST^DGPFAAH(DGIEN),.DGPFAH)
 Q +$G(DGPFAH("ACTION"))=5
 ;
FLAGNM(FLG) ;
 ;  Is flag = selected flag; DG*5.3*960
 ;  "DGFLG": variable_pointer for flag, else ""
 N SORT S SORT=$P($G(DGSORT("DGFLG")),U,3)
 Q $S('SORT:1,1:SORT=FLG)
 ;
FLGXFER ;
 ;   If flag transferred and prior to assignment change date
 ;   then do not rpt missing TIU link
 N X,DGHIEN,DGHACT
 Q:$P($G(DGPFA("ORIGSITE")),U)=$P($G(DGPFA("OWNER")),U)
 S X="Change of flag assignment ownership."
 S DGHIEN=""
 F  S DGHIEN=$O(DGHIENS(DGHIEN)) Q:DGHIEN=""  D
 . S DGHACT=DGHIENS(DGHIEN)
 . I $G(^DGPF(26.14,DGHACT,1,1,0))[X S DGFLAG=$P(DGHIEN,U)
 Q
 ;
HEAD ;
 ;   Print/Display page header
 N X D CHK Q:DGQ
 I TRM!('TRM&PAGE) W @IOF
 S PAGE=PAGE+1
 S X=$S('$D(CAT):"",+CAT=1:"I (National)",1:"II (Local)")
 F I=1:1:3 W !,HD(I) W:I=2 $J(PAGE,5)
 I PAGE<2 F I=1:1:4 W !,HD(1,I)
 I $D(CAT),CAT'=OCAT F I=1:1:4 W !,HD(2,I) W:I=1 X
 Q
 ;
INIT ;  initial certain local variables
 N X,BEG,END,FLG,PRT,SP
 S $P(SP," ",80)=""
 S TRM=($E(IOST)="C") I TRM D WAIT^DICD
 S DGLIST=$NA(^TMP("DGPFRAL1",$J)) ;temp global for report
 K @DGLIST
 S DGQ=0
 ;
 ;   header display for all pages
 S HD(1)=$E(SP,1,24)_"Patient Record Flags"
 S X="Assignment Action Not Linked To A Progress Note Report"
 S $E(X,68)="Page: "
 S HD(2)=X
 S $P(HD(3),"-",80)=""
 ;
 S BEG=$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")
 S END=$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 S PRT=$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 S FLG=$P(DGSORT("DGFLG"),U,2) S:FLG="" FLG="All flags"
 ;
 ;   display in header for first page only
 S HD(1,1)="REPORT TYPE: "_$P(DGSORT("DGCAT"),U,2)
 S $E(HD(1,1),47)="STATUS: "_$P(DGSORT("DGSTA"),U,2)
 S HD(1,2)="       FLAG: "_FLG
 S $E(HD(1,2),44)="ACTION BY: "_$P(DGSORT("DGFAC"),U,2)
 S HD(1,3)=" DATE RANGE: "_BEG_" To "_END
 S $E(HD(1,3),46)="PRINTED: "_PRT
 S HD(1,4)=HD(3)
 ;
 ;   sub-header display / column header display
 S HD(2,1)="   CATEGORY: "
 S HD(2,2)=""
 S HD(2,3)="PATIENT             SSN         FLAG NAME          ACTION            ACTION DATE"
 S HD(2,4)="------------------  ----------  -----------------  ----------------  -----------"
 Q
 ;
LOCAL() ;
 ;   Filter is history created locally or not; DG*5.3*960
 ;   expects .DGPFAH; "DGFAC": 1:local;2:other;3:both
 N X,LOC,SORT,TMP
 S SORT=+$G(DGSORT("DGFAC")) I SORT=3 Q 1
 F X="APPRVBY","ENTERBY","ORIGFAC" S TMP(X)=$G(DGPFAH(X))
 S LOC=$$LOC^DGPFUT63(.TMP)
 ;   filter for locally created history records only
 I SORT=1 Q LOC=1
 ;   filter for history records not created locally
 I SORT=2 Q LOC=0
 Q 0
 ;
PAUSE ; pause screen display
 ;  if DGQ=1 exit printing
 I TRM,PAGE,$$E^DGPFUT7<1 S DGQ=1
 Q
 ;
STATUS(STAT) ;filter on active/inactive; DG*5.3*960
 ; "DGSTA": 1:inactive;2:active;3:both
 ;   STAT : 0:inactive;1:active
 N SORT S SORT=$G(DGSORT("DGSTA"))-1 S:SORT<0 SORT=2
 Q $S(SORT>1:1,SORT=1:STAT=1,1:STAT=0)
 ;
SUBTOT ;
 ;   Print subtotals for category at end of that category listing
 ;   Expects CAT and OCAT
 W !!,"Total Actions not Linked for Category "
 W $S(OCAT=1:"I",1:"II")_":  "_(+TOTAL(OCAT))
 D:+DGSORT("DGCAT")=3 PAUSE
 S ODFN=""
 Q
