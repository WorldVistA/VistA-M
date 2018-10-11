DGPFAAH2 ;SHRPE/SGM - PRF ASSIGNMENT HISTORY API'S ; 5/1/2018 17:00
 ;;5.3;Registration;**960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/sgm - Jul 5, 2018 11:07
 ;
 ;  This routine was introduced in patch 960 to provide additional
 ;  History related APIs.  Patch DG*5.3*951 will be released subsequent
 ;  to this 960 patch.  The 951 will provide a common API entry point
 ;  in the DGPFAAH routine.
 ;
 ;  This routine will ONLY be invoked via the DGPFAAH routine!
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ------------------------------------
 ; 2052  Sup   $$GET1^DID
 ;10103  Sup   $$FMTE^XLFDT
 ;
 QUIT
 ;------------------------  API Entry Points  -------------------------
 ;
ACTFILT(DGHIST,DGIEN,DGACT,DGFLDS,DGBY) ;
 ;  For an assignment, return a list of History records with a specific
 ;  action type
 D ACT Q:$Q +$G(@DGHIST) Q
 ;
INACT(DGIEN) ;
 ;  For an assignment, return the date of the last inactivation action
 Q $$LASTIN
 ; 
LAST(DGIEN) ;
 ;  For an assignment, return the date of the last activation action
 Q $$LASTACT
 ;
 ;-----------------  Private Main Processing Modules  -----------------
ACT ;
 ;  Find all History records associated with an assignment and return
 ;    only those History records of a certain ACTION types
 ;  This may be called as an Extrinsic Function or as a DO w/params
 ;  Use APIs in DGPFAAH if you wish all history records and data
 ;  Use APIs in DGPFAA if you wish all assignment record data
 ;
 ;  INPUT PARAMETERS:
 ;     DGIEN - required - Pointer to PRF ASSIGNMENT (#26.13) file
 ;     DGACT - required - ';'-delimited string of ACTION set of codes
 ;                        see ^DD(26.14,.03)
 ;    DGFLDS - optional - return field values from 26.14
 ;             ';'-delimited string can be field numbers or text
 ;               subscripts as returned in DGPFAAH and DGPFAA routines 
 ;             Default - ACTION ; DATE/TIME
 ;     DGBY  - optional - return sorting order, default to I
 ;        A:sort by action (action_code,ien)=ien^action_code^date/time
 ;        D:sort by date   (date/time,ien)  =ien^action_code^date/time
 ;        I:sort by ien    (1,ien)          =ien^action_code^date/time
 ;
 ;  RETURN PARAMETER:
 ;     DGHIST - named reference to return values
 ;              default to .DGHIST
 ;   @DGHIST = total number of records returned or -1
 ;   @DGHIST@(sub1,sub2,sub3) = internal_FM_value ^ external_FM_value
 ;       where sub1 = action_code_name if BY="A"
 ;             sub1 = assignment date.time if BY="D"
 ;             sub1 = 1 if BY="I"
 ;             sub2 = history record ien
 ;             sub3 = text name for history field (see F14 below)
 ;
 ;  EXTRINSIC FUNCTION:
 ;    Return the total number of history records found
 ;
 N CNT,DGHIEN,INPUT,TMP
 S CNT=0
 S RET=$G(DGHIST) S:RET="" RET="DGHIST"
 S TMP=$NA(^TMP("DGPFAAH2",$J)) K @TMP
 ;   validate input parameters
 ;   INPUT("FLDS",field#)         = text_subscript
 ;   INPUT("FLDS",text_subscript) = field#
 ;   INPUT("ACT",set_of_code#)    = set of code name
 ;   INPUT("BY")                  = A / D / I
 I '$$INPUT S CNT=-1 G ACTOUT
 ;   get all History records for an assignment
 ;   if entered in error action encountered, remove all history records
 ;      prior to the EIE record
 I $$GETALLDT^DGPFAAH(DGIEN,.DGHIEN) D
 . ;   dghien(assignment_dt)=hien
 . N DATE
 . ;  sort history data by assignment date.time
 . S DATE=-1 F  S DATE=$O(DGHIEN(DATE)) Q:'DATE  D
 . . N DGPFAH,HIEN
 . . S HIEN=DGHIEN(DATE)
 . . ; Q:'$$GETHIST^DGPFAAH(HIEN,.DGPFAH,1)  ;after patch 960 released
 . . Q:'$$GETHIST^DGPFAAH(HIEN,.DGPFAH)
 . . M @TMP@(DATE,HIEN)=DGPFAH
 . . Q
 . ; D EIE
 . Q
 ;
 I $D(@TMP) D
 . N I,X,Y,ACT,DATE,HIEN,SUB
 . ;  filter records and set up return array
 . S DATE=-1 F  S DATE=$O(@TMP@(DATE)) Q:'DATE  D
 . . S HIEN=0 F  S HIEN=$O(@TMP@(DATE,HIEN)) Q:'HIEN  D
 . . . ; is history record one of the actions
 . . . S ACT=+$G(@TMP@(DATE,HIEN,"ACTION"))
 . . . I '$D(INPUT("ACT",ACT)) K @TMP@(DATE,HIEN) Q
 . . . S CNT=CNT+1
 . . . S X=INPUT("BY")
 . . . S SUB=$S(X="A":INPUT("ACT",ACT),X="D":DATE,1:1)
 . . . ;   set up return with field text names, not field#
 . . . S X=100 F  S X=$O(INPUT("FLDS",X)) Q:X=""  D
 . . . . S @RET@(SUB,HIEN,X)=@TMP@(DATE,HIEN,X)
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
ACTOUT ;
 S @RET=CNT
 K @TMP
 Q:$Q CNT
 Q
 ;
LASTACT ;
 ; For a PRF assignment return that date of the last activation action
 ;
 ;  INPUT PARAMETER:
 ;    DGIEN - required - Pointer to PRF ASSIGNMENT (#26.13) file
 ;  EXTRINSIC FUNCTION:  return null or p1^p2^p3
 ;    p1 = internal FM date.time   p2 = mm/dd/yy   p3 = mm/dd/yyyy
 ;
 N DATE,DGACT,DGBY,DGFLDS,DGHIST
 S DGACT="1;3;4;5"
 S DGFLDS=".01;.02;.03"
 S DGBY="D"
 S DATE="" I $$ACTFILT(.DGHIST,DGIEN,DGACT,DGFLDS,DGBY)>0 D
 . ;  dghist(assign_d/t,hist_ien,field_text) = int_val^ext_val
 . N X,Y,ACT,IEN
 . S Y="A" F  S Y=$O(DGHIST(Y),-1) Q:Y<1  D  Q:DATE
 . . S IEN="A" F  S IEN=$O(DGHIST(Y,IEN),-1) Q:'IEN  D  Q:DATE
 . . . S ACT=+$G(DGHIST(Y,IEN,"ACTION"))
 . . . I ACT=1!(ACT=4) S DATE=Y
 . . . Q
 . . Q
 . Q
 S:DATE $P(DATE,U,2)=$$FMTE^XLFDT(DATE\1,"2Z")_U_$$FMTE^XLFDT(DATE\1,"5Z")
 Q DATE
 ;
LASTIN ;
 ;For a PRF assignment return that date of the last inactivation action
 ;
 ;  INPUT PARAMETER:
 ;    DGIEN - required - Pointer to PRF ASSIGNMENT (#26.13) file
 ;  EXTRINSIC FUNCTION:  return null or p1^p2^p3
 ;    p1 = internal FM date.time   p2 = mm/dd/yy   p3 = mm/dd/yyyy
 ;
 N DATE,DGACT,DGBY,DGFLDS,DGHIST
 S DGACT="3;5"
 S DGFLDS=".01;.02;.03"
 S DGBY="D"
 S DATE=""
 I $$ACTFILT(.DGHIST,DGIEN,DGACT,DGFLDS,DGBY)>0 D
 . ;  dghist(assign_d/t,hist_ien,field_text) = int_val^ext_val
 . N X,Y,ACT,IEN
 . S Y="A" F  S Y=$O(DGHIST(Y),-1) Q:Y<1  D  Q:DATE
 . . S IEN="A" F  S IEN=$O(DGHIST(Y,IEN),-1) Q:'IEN  D  Q:DATE
 . . . S ACT=+$G(DGHIST(Y,IEN,"ACTION"))
 . . . I ACT=3!(ACT=5) S DATE=Y
 . . . Q
 . . Q
 . Q
 S:DATE $P(DATE,U,2)=$$FMTE^XLFDT(DATE\1,"2Z")_U_$$FMTE^XLFDT(DATE\1,"5Z")
 Q DATE
 ;
 ;-----------------------  PRIVATE SUBROUTINES  -----------------------
 ;
F14 ;
 ;;.01^ASSIGN
 ;;.02^ASSIGNDT
 ;;.03^ACTION
 ;;.04^ENTERBY
 ;;.05^APPRVBY
 ;;.06^TIULINK
 ;;.09^ORIGFAC
 ;;
 N I,X,Y
 F I=1:1 S X=$P($T(F14+I),";",3) Q:X=""  D
 . S Y=$P(X,U,2),DATA(+X)=Y,DATA(Y)=+X
 . Q
 Q
 ;
INPUT() ;  validate input parameters
 N I,X,Y,DATA,DGERR,DIERR,TMP,TX
 S DGIEN=+$G(DGIEN) I '$D(^DGPF(26.13,DGIEN,0)) Q 0
 D F14 ;     sets up DATA()
 ;   validate DGFLDS
 ;     INPUT("FLDS",file#,field#)=textname
 ;     INPUT("FLDS",file#,textname)=field#
 S X=$G(DGFLDS) I $L(X) D
 . F I=1:1:$L(X,";") S Y=$P(X,";",I) D
 . . Q:Y=""  Q:'$D(DATA(Y))
 . . S TX=$S(Y=+Y:DATA(Y),1:Y)
 . . I Y'=+Y S Y=DATA(TX)
 . . S INPUT("FLDS",Y)=TX,INPUT("FLDS",TX)=Y
 . . Q
 . Q
 ;   add in default fields if necessary
 S X="ASSIGNDT" I '$D(INPUT("FLDS",X)) D
 . S INPUT("FLDS",.02)=X,INPUT("FLDS",X)=.02
 . Q
 S X="ACTION" I '$D(INPUT("FLDS",X)) D
 . S INPUT("FLDS",.03)=X,INPUT("FLDS",X)=.03
 . Q
 ;   validate DGACT
 S DGACT=$G(DGACT) I DGACT="" Q 0
 S X=$$GET1^DID(26.14,.03,,"SET OF CODES",,"DGERR")
 F I=1:1:$L(X,";") S Y=$P(X,";",I) Q:Y=""  S TMP(+Y)=$P(Y,":",2)
 F I=1:1:$L(DGACT,";") S X=$P(DGACT,";",I) D
 . I +X,$D(TMP(X)) S INPUT("ACT",X)=TMP(X)
 . Q
 I '$D(INPUT("ACT")) Q 0
 ;   validate DGBY
 S X=$G(DGBY),X=$S(X="":"I","ADI"[$E(X):$E(X),1:"I")
 S INPUT("BY")=X
 Q 1
