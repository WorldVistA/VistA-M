DGPFRDB1 ;SHRPE/SGM - DBRS HISTORY REPORT ; Aug 07, 2018 09:45
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM, Aug 10, 2018 16:04
 ;
 ; ICR# TYPE DESCRIIPTION
 ;----- ---- ----------------------------
 ;      Sup  $$FMTE^XLFDT
 ;      Sup  $$STA^XUAF4
 ;
 ;  Called from DGPFRDB routine
 ;  See DGPFRDB for example format of report
 QUIT
 ;
 ;     PAGE(page#,row#) = line of data in report
 ;     PG = total number of pages in report
 ;
START ;--- Taskman Entry Point
 N X,Y,DGHIST,HEAD,PG,PAGE,RPT,TRM
 Q:'$G(DGSRC("ASGN"))
 S TRM=($E(IOST)="C")
 S PG=0
 S RPT=$NA(^TMP("DGPFRDB",$J)) K @RPT
 D GET ;           create DGHIST()
 D BLDHEAD ;       create HEAD()
 D BLDPAGES ;      create formatted pages for the report
 D DISPLAY
 I TRM W @IOF
 K @RPT
 Q
 ;
 ;------------------------ PRIVATE SUBROUTINES ------------------------
BLDHEAD ; construct HEAD()
 ;;
 ;;BEHAVIORAL PRF DISRUPTIVE BEHAVIOR DATA REPORT                         Page:
 ;;Patient: [-----patient name-----------] (6890)        Dates: 01/01/18 - 03/09/18
 ;;================================================================================
 ;;   DBRS Number        Date    DBRS Other Information
 ;;------------------  --------  --------------------------------------------------
 ;;
 N X,Y,TMP
 S X="BEHAVIORAL PRF DISRUPTIVE BEHAVIOR DATA REPORT",$E(X,72)="Page: "
 S HEAD(1)=$P($T(BLDHEAD+2),";",3)
 ;
 D GETPAT^DGPFUT2(DGSRC("DFN"),.TMP)
 S X="Patient: "_TMP("NAME")_" ("_$E(TMP("SSN"),6,$L(TMP("SSN")))_")"
 S Y="Dates: "_$$FMTE(DGSRC("BEG"))_" - "_$$FMTE(DGSRC("END"))
 S $E(X,55)=Y
 S HEAD(2)=X
 S $P(HEAD(3),"=",81)=""
 S HEAD(4)=$P($T(BLDHEAD+5),";",3)
 S HEAD(5)=$P($T(BLDHEAD+6),";",3)
 S HEAD(9)=$TR(HEAD(3),"=","_")
 Q
 ;
BLDPAGES ; construct PAGE(page#,row#)
 N J,DATE,ROW
 S PG=0
 D BLDPGA
 I '$G(@RPT@("DATE")) D  Q
 . S J="     There were no DBRS data edits found for this assignment."
 . D BLDPGS(J)
 . Q
 S DATE="A" F J=0:0 S DATE=$O(@RPT@("DATE",DATE),-1) Q:'DATE  D
 . N I,L,X,Y,Z,DBRS,DBRSX,OTHER,VAL
 . D BLDPGN(0)
 . S X=@RPT@("DATE",DATE,0)
 . S VAL=$P(X,U),$E(VAL,41)=$P(X,U,2),$E(VAL,51)=$P(X,U,3)
 . D BLDPGS(VAL),BLDPGS(HEAD(5))
 . S DBRSX=0
 . F I=0:0 S DBRSX=$O(@RPT@("DATE",DATE,1,DBRSX)) Q:DBRSX=""  D
 . . S X=@RPT@("DATE",DATE,1,DBRSX)
 . . S DBRS=$P(X,U)
 . . S Y=$P(X,U,2)
 . . S OTHER=$P(X,U,3)
 . . S X=DBRS,$E(X,21)=Y,$E(X,31)=OTHER
 . . D BLDPGS(X) S X=$E(X,81,$L(X)) ; remnant no more than 10 chars
 . . ;  are we at end of page?
 . . I (IOSL-ROW)<2 D BLDPGA
 . . I $L(X) D BLDPGN(1) S Z="",$E(Z,31)=X D BLDPGS(Z)
 . . ;  are we at end of page
 . . I (IOSL-ROW)<2 D BLDPGA
 . . Q
 . D BLDPGS("")
 . Q
 Q
 ;
BLDPGN(WHERE) ;  add a new page?
 ;   if WHERE=0, starting new history record
 ;   if WHERE=1, for a history record writing a DBRS record
 I +$G(WHERE)=0 I (IOSL-ROW)>3 Q
 I +$G(WHERE) I (IOSL-ROW)>1 Q
 ;
BLDPGA ;  add a new page
 ;  fill out existing page if PG>0
 I PG>0,(IOSL-ROW)>0 D
 . N L,T,X
 . S T="   Press any key to continue, '^' to exit: "
 . F L=ROW+1:1:IOSL S X="" S:(L=IOSL)&TRM X=T D BLDPGS(X)
 . Q
 ;   start a new page
 S PG=1+PG
 S @RPT@("RPT",PG,1)=HEAD(1)_PG
 N I F I=2:1:5 S @RPT@("RPT",PG,I)=HEAD(I)
 S ROW=5
 Q
 ;
BLDPGS(V) ;  set a row in PAGE()
 S ROW=ROW+1,@RPT@("RPT",PG,ROW)=$E(V,1,80)
 Q
 ;
DISPLAY ;
 N I,J,X,PG,OUT,ROW
 S OUT=0
 I TRM W @IOF
 F PG=0:0 S PG=$O(@RPT@("RPT",PG)) Q:'PG  D  Q:OUT
 . N L,X,PAGE
 . M PAGE=@RPT@("RPT",PG)
 . I PG>1 W @IOF
 . F ROW=0:0 S ROW=$O(PAGE(ROW)) Q:'ROW  W !,PAGE(ROW)
 . I TRM S OUT=$$DISPX
 . Q
 ;  for terminal, last page may not have press return text
 I TRM D
 . S PG=$O(@RPT@("RPT","A"),-1)
 . S ROW=$O(@RPT@("RPT",PG,"A"),-1)
 . S X=@RPT@("RPT",PG,ROW)
 Q
 ;
DISPX() ;  for terminal, check if this is the last page
 I '$O(@RPT@("RPT",PG)) D
 . I ROW<IOSL W !,"   Press any key to continue, '^' to exit: "
 . Q
 N X R X:DTIME
 Q $S('$T:1,1:X[U)
 ;
FMTE(DATE) Q $$FMTE^XLFDT(DATE,"2Z")
 ;
GET ;
 ;   get the History data
 ;   store a copy of data in ^TMP
 ;      @RPT@("INPUT")        = input answers
 ;      @RPT@("HIST",date)    = history DGPFAH()
 ;      @RPT@("HIST",9999999) = current DGPFA()
 ;      @RPT@("DATE")                  = total number of records
 ;      @RPT@("DATE",DATE,0)           = SITE_U_EDITDT_U_ENTERBY 
 ;      @RPT@("DATE",date,1," "_dbrs#) = dbrs#^ext_date^other
 ;
 N J,X,Y,DATE,DGHIST,DGPFA,ED,ST,TOT
 ;  save input date to ^TMP
 M @RPT@("INPUT")=DGSRC
 S ST=DGSRC("BEG")-.000001
 S ED=(DGSRC("END")+.25)
 S TOT=0 ;    total# of History records with edited DBRS
 ;
 ;--- get all history records sorted by date
 D GETALLDT^DGPFAAH(DGSRC("ASGN"),.DGHIST)
 F DATE=ST:0 S DATE=$O(DGHIST(DATE)) Q:'DATE  Q:DATE>ED  D
 . N I,X,Y,L,DGPFAH,EDITDT,ENTERBY,IEN,SITE
 . S IEN=DGHIST(DATE)
 . D GETHIST^DGPFAAH(IEN,.DGPFAH,1)
 . Q:'$D(DGPFAH("DBRS"))
 . M @RPT@("HIST",DATE)=DGPFAH
 . ;   assignment history data for the report
 . S ENTERBY=$P($G(DGPFAH("ENTERBY")),U,2)
 . S EDITDT=$$FMTE(DATE\1)
 . S SITE="",Y=$G(DGPFAH("ORIGFAC"))
 . I +Y S SITE=$$STA^XUAF4(+Y)_" "_$P(Y,U,2)
 . S @RPT@("DATE",DATE,0)=SITE_U_EDITDT_U_ENTERBY
 . ;
 . S L=0 F  S L=$O(DGPFAH("DBRS",L)) Q:'L  D
 . . N X,Y,DAT,DBDT,DBRS,OTHER,STAT
 . . F I=1:1:5 S DAT(I)=$P(DGPFAH("DBRS",L),U,I)
 . . S STAT=$P(DAT(4),";")
 . . Q:STAT="N"  ;   no change to DBRS data
 . . S DBRS=DAT(1)
 . . S OTHER=DAT(2)
 . . I STAT="D" S OTHER="[DELETED] "_OTHER
 . . I STAT="A" S OTHER="[NEW] "_OTHER
 . . S DBDT=$P(DAT(3),";") S:DBDT DBDT=$$FMTE(DBDT\1)
 . . S @RPT@("DATE",DATE,1," "_DBRS)=DBRS_U_DBDT_U_OTHER
 . . Q
 . I $D(@RPT@("DATE",DATE,1)) S TOT=TOT+1
 . Q
 ;
 ;   get the current DBRS data
 D GETASGN^DGPFAA(DGSRC("ASGN"),.DGPFA,1) D
 . N L,X,SITE
 . S X=DGPFA("OWNER")
 . S SITE=$$STA^XUAF4(+X)_" "_$P(X,U,2)
 . M @RPT@("HIST",9999999)=DGPFA
 . S @RPT@("DATE",9999999,0)=SITE_"^Current^"
 . F L=0:0 S L=$O(DGPFA("DBRS#",L)) Q:'L  D
 . . N DATE,DBRS,OTHER
 . . S DBRS=$P(DGPFA("DBRS#",L),U)
 . . S DATE=$P($G(DGPFA("DBRS DATE",L)),U) S:DATE DATE=$$FMTE(DATE\1)
 . . S OTHER=$P($G(DGPFA("DBRS OTHER",L)),U)
 . . S @RPT@("DATE",9999999,1," "_DBRS)=DBRS_U_DATE_U_OTHER
 . . Q
 . S TOT=TOT+1
 . Q
 S @RPT@("DATE")=TOT
 Q
