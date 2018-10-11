DGPFRFA1 ;ALB/RBS - PRF FLAG ASSIGNMENT REPORT CONT. ; 1/21/04 5:14pm
 ;;5.3;Registration;**425,554,960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/sgm - Jul 9, 2018 13:30
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ---------------------------------
 ;10024  Sup   WAIT^DICD
 ;10026  Sup   ^DIR
 ;10086  Sup   HOME^%ZIS
 ;10103  Sup   ^XLFDT: $$FMDIFF, $$FMTE, $$NOW
 ;10063  Sup   $$S^%ZTLOAD
 ;
 ;This routine will compile and produce the FLAG ASSIGNMENT REPORT.
 ;This routine will be used to display or print all of the patient
 ; assignments for Category I and Category II Patient Record Flags.
 ;
 ;All sort input was created in routine DGPFRFA passed by Taskman
 ; Input: The following array contains the sort var's:
 ;
 ;   DGSORT(subscript)=value [see routine DGPFRFA for details]
 ;
 ; Output: A formatted report of Record Flag Assignments to patients.
 ;5/1/2018 - DG*5.3*960 - report format substantially changed
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 N DGLIST,HDR,LINE,TRM,ZTSTOP
 N DGC,DGF,DGO,DGS,DGBEG,DGEND
 S ZTSTOP=0
 K ^TMP("DGPFRFA1",$J)
 S DGLIST=$NA(^TMP("DGPFRFA1",$J))
 S $P(LINE,"-",104)=""
 ;
 D  ;  convert some DGSORT() to convenient local variables
 . ;   DGC, DGF, DGO, DGS
 . ;   Category, Flag, Ownership, Status
 . N X
 . S (DGBEG,DGC,DGEND,DGF,DGO,DGS)=""
 . ;    convert category to 0 or file# of variable pointer
 . S X=+DGSORT("DGCAT") S DGC=$S(X=3:0,X=1:26.15,1:26.11)
 . ;
 . ;    convert ownership to 1:Local; 2:Other; 0:Both
 . S X=+DGSORT("DGOWN") S DGO=$S(X=3:0,1:X)
 . ;
 . ;    status 0:Inactive  1:Active
 . ;    reset so coordinated with ^DD(26.13)
 . S DGS=(+DGSORT("DGSTAT")=1)
 . ;
 . ;   DGF = A:all or variable pointer syntax for single flag
 . S DGF=$P(DGSORT("DGFLAG"),U)
 . S DGBEG=(DGSORT("DGBEG")\1)
 . S DGEND=(DGSORT("DGEND")\1)
 . Q
 ;
 S TRM=($E(IOST)="C") I TRM D WAIT^DICD
 ;  START module initialized 6 local variables used by next code
 D A1 ;    find data to print
 D HDR ;   build HDR() array
 D PRT
 ;
EXIT ;
 K ^TMP("DGPFRFA1",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 I TRM D ^%ZISC
 Q
 ;
 ;-----------------------  PRIVATE SUBROUTINES  -----------------------
A1 ; 
 ;  Find records using sort var's to build list
 ;  Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DGQ,DGSUB
 S DGQ=0
 ;  DGF="A" for all flags or is single variable pointer syntax
 ;          ^DGPF(26.13,"AFLAG",DGSUB,dfn,ien)
 I +DGF,'$D(^DGPF(26.13,"AFLAG",DGF)) Q
 ;
 S DGSUB=0 I +DGF S DGSUB=$O(^DGPF(26.13,"AFLAG",DGF),-1)
 F  S DGSUB=$O(^DGPF(26.13,"AFLAG",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . I +DGF,DGSUB'=DGF S DGQ=1 Q  ;  single flag
 . I +DGC,DGSUB'[DGC Q  ;          single flag category
 . ;
 . N DGCNT,DGDFN,DGDFNLST
 . ;  now get all patients with DGSUB flag assignment
 . ;  dgdfnlst(dfn)=ien_file_26.13
 . Q:'$$ASGNCNT^DGPFLF6(DGSUB,.DGDFNLST)
 . S DGDFN=0 F  S DGDFN=$O(DGDFNLST(DGDFN)) Q:DGDFN=""  D
 . . N X,Y,DGIEN,DGPFA,OWN,STAT
 . . S DGIEN=DGDFNLST(DGDFN) Q:DGIEN=""
 . . Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 . . ;   filter, get history, save computed value in DGPFA()
 . . I $$A11 D A12
 . . Q
 . Q
 Q
 ;
A11() ;  apply filters
 ; 1. Get all History records of certain ACTION types:
 ; 2: Action types: New, Inactivate, Reactivate, Enter in Error
 ; 3. Action DATE must be within date range
 ;
 N X,Y,ACT,DATE,DEACT,DGHST,IEN,LAST,NUM
 ;   check STATUS
 S X=+$G(DGPFA("STATUS")) I X'=DGS Q 0
 ;   check type of owner
 S X=+$G(DGPFA("OWNER")),Y=0 I X>0 S Y=$$ISDIV^DGPFUT(X)
 I DGO>0 I '$S(DGO=2:Y<1,1:Y>0) Q 0
 ;   get all History records of the desired ACTION
 I '$$ACTFILT^DGPFAAH2("DGHST",DGIEN,"1;3;4;5",,"D") Q 0
 ;   filter records by date range and action
 ;   LAST(1) = last activation action date
 ;   LAST(3) = last inactivation action date
 ;   LAST(2) = first inactivation action after last activation action
 ;   count total number of activation events within time range
 S (LAST(1),LAST(2),LAST(3),NUM)=""
 S DATE=0 F  S DATE=$O(DGHST(DATE)) Q:'DATE  D
 . S Y=DATE\1
 . I Y<DGBEG K DGHST(DATE) S DGHST=DGHST-1 Q
 . I Y>DGEND K DGHST(DATE) S DGHST=DGHST-1 Q
 . S IEN=0 F  S IEN=$O(DGHST(DATE,IEN)) Q:'IEN  D
 . . S X=+$G(DGHST(DATE,IEN,"ACTION"))
 . . I "^1^3^4^5^"'[(U_X_U) Q
 . . S Y=DATE\1
 . . I (X=1)!(X=4) D
 . . . S NUM=NUM+1 ;            number of activations
 . . . S LAST(1)=Y,LAST(2)=0 ;    last activation action
 . . . Q
 . . I (X=3)!(X=5) D
 . . . S LAST(3)=Y ;  last inactivation action
 . . . ;  first inactivation action after last activation action
 . . . I +LAST(1),'LAST(2),Y'<LAST(1) S LAST(2)=Y
 . . . Q
 . . Q
 . Q
 I 'DGHST Q 0 ;    no history records within date range
 I 'NUM Q 0 ;      no activations within date range
 S DGPFA("ztimesactive")=NUM
 S DGPFA("zlastdate")=LAST(1)
 S Y="" I LAST(1) D
 . S:'LAST(2) LAST(2)=DT
 . S Y=$$FMDIFF^XLFDT(LAST(2),LAST(1),1)+1
 . Q
 S DGPFA("zdaysactive")=Y
 S DGPFA("zlastinact")=LAST(3)
 Q 1
 ;
A12 ;  build the list global
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N I,X,Y,DATE,DGNAME,DGTMP,VAL
 Q:'$$GETPAT^DGPFUT2(DGDFN,.DGTMP)
 S DGNAME=DGTMP("NAME")
 ;   set VAL = 9 '^'-pieces to save in global
 ;       p1 = patient name
 ;       p2 = 1U4N
 ;       p3 = New Assignment date
 ;       p4 = last activation date
 ;       p5 = number of days last activation active
 ;       p6 = next review date (may be null)
 ;       p7 = review overdue?
 ;       p8 = number of times assignment was activated in date range
 ;       p9 = current owner of the assignment
 ;      p10 = last date of inactivation
 ;
 S VAL=DGNAME_U_$E(DGTMP("NAME"))_$E(DGTMP("SSN"),6,10)
 K DGTMP
 ;   retrieve initial history assign record
 Q:'$$GETHIST^DGPFAAH($$GETFIRST^DGPFAAH(DGIEN),.DGTMP)
 ;-- get 'initial assignment' date
 S DATE=$P($P($G(DGTMP("ASSIGNDT")),U),".")
 S:DATE DATE=$$FMTE^XLFDT(DATE,"2Z")
 S $P(VAL,U,3)=DATE
 ;
 S DATE=$G(DGPFA("zlastdate"))
 S:DATE DATE=$$FMTE^XLFDT(DATE,"2Z")
 S $P(VAL,U,4)=DATE
 ;
 ;   days active, if assign inactive , put days active in ()
 S X=$G(DGPFA("zdaysactive")) I X,DGS=0 S X="("_X_")"
 S $P(VAL,U,5)=X
 ;
 S DATE="",Y=$P($G(DGPFA("REVIEWDT")),U)
 S:Y DATE=$$FMTE^XLFDT(Y,"2Z")
 S $P(VAL,U,6)=DATE
 ;
 S $P(VAL,U,7)=$S('Y:"N/A",Y<DT:"Yes",1:"No")
 ;
 S $P(VAL,U,8)=$G(DGPFA("ztimesactive"))
 ;
 S X=$P($G(DGPFA("OWNER")),U,2) S:$L(X) $P(VAL,U,9)=X
 ;
 S Y=$G(DGPFA("zlastinact")) S:Y $P(VAL,U,10)=$$FMTE^XLFDT(Y,"2Z")
 ;
 ;   construct nodes to sort return global
 N CAT,FLAG
 S FLAG=$G(DGPFA("FLAG")) Q:FLAG=""
 S CAT=$S(FLAG[26.15:1,1:2)
 S FLAG=$P(FLAG,U,2)
 S @DGLIST@(CAT,FLAG,DGNAME,DGDFN)=VAL
 Q
 ;
FORMAT(VAL) ;   format one row of data for display
 N I,L,P,COL,DAT,STR
 F I=1:1:10 S DAT(I)=$P(VAL,U,I)
 S COL=1,STR=DAT(1) ;                                patient name
 S COL=33,$E(STR,COL)=$E(DAT(2),1,6) ;               1U4N
 S COL=40,$E(STR,COL)=$E(DAT(3),1,8) ;               init assign date
 S COL=50,$E(STR,COL)=$E(DAT(4),1,8) ;               last active date
 S COL=60,$E(STR,COL)=$J($E(DAT(5),1,6),6) ;         # days active
 I +DGS S COL=68,$E(STR,COL)=$E(DAT(6),1,8) ;        review date
 I +DGS S COL=81,$E(STR,COL)=$E(DAT(7),1,5) ;        overdue?
 I 'DGS S COL=68,$E(STR,COL)=$E(DAT(10),1,8) ;       inactivation date
 S COL=$S(DGS:88,1:80),$E(STR,COL)=$J($E(DAT(8),1,7),7) ;#times activat
 S COL=$S(DGS:100,1:92),$E(STR,COL)=$E(DAT(9),1,30) ;  current own site
 S:$L(STR)<132 $E(STR,132)=" "
 S:$L(STR)>132 STR=$E(STR,1,132)
 Q STR
 ;
HDR ;  build header array
 ;  see sample header at end of routine
 ;  S $E(X,start_pos)=value
 ;    Active header: 1,33,40,50,60,68,79,89,100
 ;  Inactive header: 1,33,40,50,60,58,80,92
 N I,L,X,Y,COL,ROW
 K HDR
 S ROW=1 S HDR(ROW)="Flag Assignment Report",$E(HDR(ROW),123)="Page: "
 S ROW=2 S $P(HDR(ROW),"=",133)=""
 S ROW=3 D
 . S X="CATEGORY: " D
 . . S Y="I & II (National/Local)"
 . . I +DGC S Y=$S(DGC=26.15:"I (National)",1:"II (Local)")
 . . S HDR(ROW)=X_Y
 . . Q
 . S COL=39,$E(HDR(ROW),COL)="STATUS: "_$P(DGSORT("DGSTAT"),U,2)
 . S COL=69,X="OWNERSHIP: " D
 . . S Y=$P("All^Local^Other",U,DGO+1)_" Facilit"_$S(+DGO:"y",1:"ies")
 . . S $E(HDR(ROW),COL)=X_Y
 . . Q
 . S COL=99,X="DATE RANGE: " D
 . . S Y=$$FMTE^XLFDT(DGBEG,"2Z")_" to "_$$FMTE^XLFDT(DGEND,"2Z")
 . . S $E(HDR(ROW),COL)=X_Y
 . . Q
 . Q
 S ROW=4 D
 . I +DGF S HDR(ROW)="    FLAG: "_$P(DGSORT("DGFLAG"),U,2)
 . S COL=102,$E(HDR(ROW),COL)="PRINTED: "_$$FMTE^XLFDT(DT,"Z")
 . Q
 S ROW=5,HDR(ROW)=HDR(2)
 S ROW=6 D
 . ;   inactive only report has different column headers
 . S X=""
 . S COL=40,$E(X,COL)="Orig"
 . S COL=50,$E(X,COL)="Last"
 . S COL=60,$E(X,COL)="# Days"
 . I +DGS S COL=89,$E(X,COL)="# Times"
 . I 'DGS D  ;  inactive report
 . . S COL=68,$E(X,COL)="Inactivate"
 . . S COL=80,$E(X,COL)="# Times"
 . . Q
 . S $E(X,132)=" "
 . S HDR(ROW)=X
 S ROW=7 D
 . S X="Patient Name"
 . S COL=33,$E(X,COL)="SSN"
 . S COL=40,$E(X,COL)="AssignDT"
 . S COL=50,$E(X,COL)="AssignDT"
 . S COL=60,$E(X,COL)="Active"
 . I +DGS D  ;   active only report
 . . S COL=68,$E(X,COL)="Review On"
 . . S COL=79,$E(X,COL)="Overdue?"
 . . S COL=89,$E(X,COL)="Activated"
 . . S COL=100,$E(X,COL)="Current Owning Site"
 . . Q
 . I 'DGS D  ;   inactive only report
 . . S COL=68,$E(X,COL)="Date"
 . . S COL=80,$E(X,COL)="Activated"
 . . S COL=92,$E(X,COL)="Current Owning Site"
 . . Q
 . S $E(X,132)=" "
 . S HDR(ROW)=X
 . Q
 S ROW=8,HDR(ROW)=$TR(HDR(2),"=","-")
 Q
 ;
PRT ;
 ;    DGLIST = ^TMP("DGPFRFA1",$J,CAT,FLAG,DGNAME,DGDFN)
 N I,X,Y,DGQ,GR,PAGE,STOP,SUBHD,TOTAL
 N CAT,CAT0,FLAG,FLAG0
 S (DGQ,PAGE)=0
 S SUBHD=(DGSORT("DGFLAG")<1)
 D WRHDR
 I $O(@DGLIST@(""))="" D  G PRTOUT
 . S X="No Record Flag Assignments found using the report criteria."
 . W !!,"   >>> "_X,!
 . Q
 ;
 S GR=DGLIST,STOP=$TR(GR,")",",")
 S (CAT0,FLAG0)=""
 ;
 F  S GR=$Q(@GR) Q:(GR'[STOP)  D  Q:DGQ
 . N X,DATA,DFN,FLAG,PNAM
 . S CAT=$QS(GR,3)
 . S FLAG=$QS(GR,4)
 . S PNAM=$QS(GR,5)
 . S DFN=$QS(GR,6)
 . S DATA=@GR
 . ;   need to write subheader for next flag?
 . ;   no subheader for single flag report
 . I SUBHD,CAT'=CAT0!(FLAG'=FLAG0) D WRSUBHDR Q:DGQ
 . ;  update totals
 . S TOTAL(CAT)=1+$G(TOTAL(CAT))
 . S TOTAL(CAT,FLAG)=1+$G(TOTAL(CAT,FLAG))
 . S CAT0=CAT,FLAG0=FLAG
 . S X=$$FORMAT(DATA) D WR(X)
 . Q
 I 'DGQ D WRTOT
 ;
PRTOUT ;
 I TRM,'DGQ W ! S X=$$E^DGPFUT7
 Q
 ;
WR(X) ;   write out one line
 ;        check for bottom of page
 ;        write new header if necessary
 W !,X D WRCK() I 'DGQ,(IOSL-$Y)<4 D WRHDR
 Q
 ;
WRCK(MIN) ;  check to see if we should quit printing (set DGQ=1)
 ;  Input Parameters:
 ;    MIN - optional - minimal number of lines needed before end of page
 ;                     default to 4
 I 'TRM Q
 S MIN=$G(MIN) S:'MIN MIN=4 S MIN=MIN+1
 I MIN>0,(IOSL-$Y)'<MIN Q
 N Z S Z=$$E^DGPFUT7 I Z<1 S DGQ=1
 Q
 ;
WRHDR ;   write page header, increment page count
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1
 Q:DGQ
 N I
 S PAGE=1+PAGE
 I PAGE=1,TRM W @IOF
 I PAGE>1 W @IOF
 W !,HDR(1)_PAGE
 I PAGE=1 F I=2:1:8 W !,HDR(I)
 I PAGE>1 F I=2,6,7,8 W !,HDR(I)
 Q
 ;
WRSUBHDR ;   write subheader of category or flag name
 D WRCK Q:DGQ
 N X,Y
 S Y=$S(CAT=1:"I (National)",1:"II (Local)")
 S X="     Flag: "_FLAG_"  [Category "_Y_"]"
 W !!,X
 Q
 ;
WRTOT ;   write out totals
 N I,L,X,Y,FL,SUM
 S SUM(1)="     -----------------------------------------------"
 S SUM(2)="              SUMMARY OF TOTAL ASSIGNMENTS"
 S SUM(3)=SUM(1)
 S L=3
 F I=1,2 I $G(TOTAL(I))>0 D
 . S X="     Category "_$P("I (National)^II (Local)",U,I)
 . S $E(X,39)=":"_$J(TOTAL(I),7)
 . S L=L+1,SUM(L)=X
 . S FL="" F  S FL=$O(TOTAL(I,FL)) Q:FL=""  D
 . . S X="        "_FL
 . . S $E(X,39)=":"_$J(TOTAL(I,FL),7)
 . . S L=L+1,SUM(L)=X
 . . Q
 . I I=1,$D(TOTAL(2)) S L=L+1,SUM(L)=SUM(1)
 . Q
 ;
 ;   print summary on one page if possible
 I (IOSL-$Y-L)<0 D WRHDR Q:DGQ
 W ! F I=1:1:L D:(IOSL-$Y-(L-I))<0 WRHDR Q:DGQ  W !,SUM(I)
 Q
 ;
WRX ;  press [ENTER] to continue
 Q:'TRM
 N L,X,Y,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W ! S DIR(0)="E" D ^DIR S:$D(DTOUT)!$D(DUOUT) DGQ=1
 Q
 ;
WR2 ;  write subtotals for flag
 Q
 I DGQ Q
 N X,Y
 S X="     Total Assignments for flag "_FLAG0_"  [Category "
 S Y=$S(CAT0=1:"I (National)",1:"II (Local)")
 S X=X_Y_"]: "_(+$G(TOTAL(CAT0,FLAG0)))
 S Y="     "_$TR($E(LINE,1,$L(X)-5),"-","=")
 ;  do not allow subtotals to print on 2 pages
 I (IOSL-$Y)<4 D WR()
 I 'DGQ W !!,X,!,Y,!
 Q
 ;
 ;   Sample Header
 ;         1         2         3         4         5         6         7         8         9         0         1         2         3
 ;123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
 ;Flag Assignment Report                                                                                                    Page: 1
 ;====================================================================================================================================
 ;CATEGORY: I & II (National/Local)     STATUS: Inactive              OWNERSHIP: All Facilities     DATE RANGE: 07/07/15 to 06/26/18  
 ;                                                                                                     PRINTED: Jun 26, 2018          
 ;====================================================================================================================================
 ;                                       Orig      Activated Days                         # Times                                
 ;Patient Name                    SSN    AssignDT  On        Active  Review On  Overdue?  Activated  Current Owning Site         
 ;------------------------------------------------------------------------------------------------------------------------------------
 ;
 ;     Flag: HIGH RISK FOR SUICIDE  [Category I (National)]
