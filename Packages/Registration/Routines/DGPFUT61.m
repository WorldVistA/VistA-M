DGPFUT61 ;SHRPE/SGM - DBRS# EDIT UTILS ; Jan 19, 2018 16:45
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/sgm - Nov 7, 2018 09:26
 ;
 ; This routine is only invoked via routine DGPFUT6
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -----------------------------------------
 ; 2050  Sup   MSG^DIALOG
 ; 2053  Sup   ^DIE: CHK, $$FILE, $$UPDATE
 ; 2171  Sup   $$NS^XUAF4
 ;10006  Sup   ^DIC
 ;10013  Sup   ^DIK
 ;10018  Sup   ^DIE
 ;10103  Sup   $$NOW^XLFDT
 ;10112  Sup   $$SITE^VASITE
 ;
 Q
 ;=====================================================================
 ;  $$GETASGN^DGPFA initializes DGPFA()
 ;  Use ^DIC to select DBRS record, may add a new record
 ;  Use ^DIR to edit .01 and/or .02 fields
 ;  When editing done, put file 26.13 entry back to state before edit
 ;  Set up DPGFA() and DGPFAH().  See ^DGPFAA for array formats
 ;
DBRS() ;  called from DGPFLMA3, action = 3,4,5,6
 ;EXTRINSIC FUNCTION:  1:allow DGPFLMA3 to continue
 ;                     0:DGPFLMA3 is to exit and return to LM screen
 ;
 ; Expected local variables from DGPFLMA3:
 ;   DGPFA(), DGPFAH(), DGIEN
 ;
 N I,J,X,Y,ACT,CHG,DBRS,NM,OUT
 ;----- only select actions to be prompted for DBRS enter/edit
 S ACT=+DGPFAH("ACTION") I "^2^3^4^6^"'[(U_ACT_U) Q 1
 S OUT=1
 ;
 ;----- initially set up the PRE and POST arrays to be the same
 D GET(.DBRS,"PRE",DGIEN)
 M DBRS("POST")=DBRS("PRE")
 ;----- inactivate action does not edit dbrs data
 I ACT=3 D EDTINACT Q 1
 ;
 D EDIT I OUT=-2 Q 0
 ;------ If no changes what action should LM take?
 ;       If action="X", exit to LM menu
 ;       If no data changes, no change to DGPFA(), setup DGPFAH()
 I '$$EDITCHG Q $S(ACT=6:0,1:1)
 ;------ Set DGPFA() to be what it will look like if accept changes
 D EDITPFA
 ;------ Build DBRS(0) which sorts data by DBRS#
 ;       DBRS(0,dbrs#,1,field#) = pre-image value
 ;       DBRS(0,dbrs#,2,field#) = post-image value
 D EDITSORT
 ;------ Build DGPFAH()
 D EDITPFAH
 Q 1
 ;
 ;=====================================================================
DBRSVAL(DGN,DGNIEN) ;  validate DBRS#, check for uniqueness
 ; INPUT PARAMETERS:
 ;      DGN - required - DBRS Number
 ;   DGNIEN - optional - <26.131_ien>,<26.13_ien>
 ;                       if passed, 26.13_ien is required
 ;                       26.131_ien can be "", n, or +n
 ;                       26.13_ien required if passed
 ;                       if adding a new DBRS, 26.131_ien=""
 ; EXTRINSIC FUNCTION returns:  p1^p2^p3 where
 ;   p1 = -1:failed   0:passed with conditions  1:DBRS# unique
 ;   p2 = message
 ;        -1^message = failure
 ;         0^message = DGN passed, DGN assigned, but cannot determine
 ;                     if DGNIEN and that assignment are the same or
 ;                     that the DBRS internal record number match
 ;         0^iens    = DGN passed, 26.13 values match, cannot determine
 ;                     if DBRS record number match.  If DBRS#
 ;                     registered then iens=26.131ien,26.13ien
 ;         1[^iens]  = DGN passes all business rules
 ;                     if appropriate pass back the existing IENS for
 ;                     that DBRS#
 ;
 N X,Y,ANS,ASGN,DA,DGA,DGERR,DIERR,DGRET,IEN,MSG
 S MSG(1)="DBRS# not of the proper format"
 S MSG(2)="Invalid IENS value received"
 S MSG(3)="This DBRS# is already assigned to another assignment: #"
 S MSG(4)="This DBRS# already assigned to this flag assignment"
 S MSG(5)="Assignment IEN received does not exist: "
 S DGNIEN=$G(DGNIEN) S:DGNIEN="" DGNIEN=",,"
 I $L(DGNIEN,",")'=3 S ANS="-1^2" G DVOUT
 ;
 ;   check format of DBRS#
 I '$L($G(DGN)) S ANS="-1^1" G DVOUT
 ;
 D CHK^DIE(26.131,.01,,DGN,.DGRET,"DGERR") K DA
 I $D(DIERR)!(DGRET=U) S ANS="-1^1" G DVOUT
 ;
 ;  check for uniqueness of DBRS#
 ;  DA has existing IEN values for DBRS#
 ;  DGA has iens from input DGNIEN
 S (DA,DA(1))=0
 S Y=$O(^DGPF(26.13,"DBRS",DGN,0)) I Y D
 . S DA(1)=Y,DA=$O(^DGPF(26.13,"DBRS",DGN,DA(1),0))
 . Q
 S DGA=$P(DGNIEN,",")
 S DGA(1)=$P(DGNIEN,",",2)
 ;  dbrs# is not already assigned
 I 'DA(1) S ANS=1 G DVOUT
 ;  dbrs# is assigned to some assignment
 ;  iens is adding a new assignment or looking for one
 I $E(DGA(1))="+" S ANS="-1^3^"_DA(1) G DVOUT
 I $E(DGA(1))="?" S ANS="0^3^"_DA(1) G DVOUT
 ;  validate assignment ien passed in
 I +DGA(1)=0 S ANS="0^3^"_DA(1) G DVOUT
 I +DGA(1),'$D(^DGPF(26.13,DGA(1),0)) S ANS="-1^5"_DGA(1) G DVOUT
 I DGA(1)'=DA(1) S ANS="-1^3^"_DA(1) G DVOUT
 ;  evaluate if trying to add DBRS a second time to an assignment
 I 'DA S ANS=1 G DVOUT
 I $E(DGA)="+" S ANS="-1^4" G DVOUT
 I $E(DGA)="?" S ANS="0^4" G DVOUT
 I +DGA=0 S ANS="0^4" G DVOUT
 I DGA'=DA S ANS="-1^4" G DVOUT
 S ANS=1
DVOUT ;
 S X=$P(ANS,U),Y=$P(ANS,U,2) S:Y X=X_U_MSG(Y)_$P(ANS,U,3)
 Q X
 ;
 ;=====================================================================
EIE(DGPFH) ;   Message about EIE and deleting DBRS data
 ;  INPUT: .DGPFH = .DGPFAH, see GETHIST^DGPFAAH for array description
 Q:'$D(DGPFH("DBRS"))
 N I,X,Y,DGT,INC,JINC,NM,SP,TXT
 D TEXT(.TXT,7,1)
 F I=1:1:3 S DGT("DIMSG",I)=TXT(I)
 S $P(SP," ",21)=""
 S INC=3
 S (X,NM)="" F JINC=0:0 S JINC=$O(DGPFH("DBRS",JINC)) Q:'JINC  D
 . S Y=DGPFH("DBRS",JINC),NM=$P(Y,U) Q:$P(Y,U,4)'="D"
 . S X=X_$E(NM_SP,1,20) I $L(X)>60 S INC=INC+1,DGT("DIMSG",INC)=X,X=""
 . Q
 I $L(X) S INC=INC+1,DGT("DIMSG",INC)=X
 S INC=INC+1,DGT("DIMAG",INC)="   "
 F J=4,5 S INC=INC+1,DGT("DIMSG",INC)=TXT(J)
 S INC=INC+1,DGT("DIMSG",INC)="   "
 D MSG^DIALOG("MW",,,,"DGT")
 Q
 ;
 ;=====================================================================
 ;                         PRIVATE SUBROUTINES
 ;=====================================================================
ADD(DGIEN,DGDATA,DEL) ;
 ;   INPUT PARAMETERS
 ;      DGIEN  - required - file 26.13 ien
 ;      DEL    - optional - 1:delete any existing dbrs#
 ;     .DGDATA - optional - DBRS# to be added, do not add dups
 ;        DGDATA(dbrs#)        = iens for dbrs multiple
 ;                               first ien may be a number or +inc
 ;        DGDATA(dbrs#,field#) = internal value
 ;
 N I,J,X,Y,DGERR,DGEXIST,DGFDA,DIERR,INC,NM
 Q:$G(DGIEN)<1  Q:$E(DGIEN)="+"
 Q:'$D(^DGPF(26.13,+DGIEN,0))
 D GETDBRS^DGPFUT6(.DGEXIST,+DGIEN) ;     get any existing iens
 I +$G(DEL) D DEL^DGPFUT6(+DGIEN,26.13) K DGEXIST
 I '$D(DGDATA) Q
 S INC=0
 S NM=0 F I=0:0 S NM=$O(DGDATA(NM)) Q:NM=""  D
 . N IENS
 . I $D(DGEXIST(NM)) Q
 . S INC=INC+1
 . S IENS="+"_INC_","_(+DGIEN)_","
 . S DGFDA(26.131,IENS,.01)=NM
 . S X=$P($G(DGDATA(NM,.02)),U)
 . I $L(X),X'="<no value>" S DGFDA(26.131,IENS,.02)=X
 . S X=$P($G(DGDATA(NM,.03)),U) I +X S DGFDA(26.131,IENS,.03)=X
 . S X=$P($G(DGDATA(NM,.04)),U) I +X S DGFDA(26.131,IENS,.04)=X
 . Q
 I $D(DGFDA) D UPDATE^DIE(,"DGFDA","DGERR")
 Q
 ;
 ;  ===============  FM ENTER/EDIT DBRS DATA  ===============
EDIT ;
 ;  Only certain actions allowed to edit DBRS#
 ;  FOR loop allows for editing more than one DBRS#
 ;  DBRS() reset if appropriate in each iteration through FOR loop
 ;
 N DGPRE
 D EH
 F  D  Q:OUT<0
 . ; DATA := value of DBRS record data after DIC selection
 . ;         DATA(1) = after ^DIC, .01^.02^.03^.04^dbrs#_iens^new_flag
 . ;         DATA(2) = after ^DIR, .01^.02^.03^.04
 . ; OUT := controller of FOR loop and ListManager action
 . ;       -2 := time_out, exit to Listmanager, make no changes
 . ;       -1 := finish editing, continue processing
 . ;        1 := one DBRS# edit session completely successfully
 . ;
 . ;----- select or add a new DBRS record
 . N X,Y,DGDIC,DGDIE,NM
 . S OUT=1
 . D  I OUT<0 Q
 . . N X,DA,DIC,DLAYGO,DTOUT,DUOUT,TMP
 . . S DA(1)=DGIEN
 . . S DIC=$NA(^DGPF(26.13,+DGIEN,2)),DIC=$TR(DIC,")",",")
 . . S DIC(0)="QAELMZn",DLAYGO=26.131
 . . S DIC("DR")=".02""DBRS Other"""
 . . W ! D ^DIC I $D(DTOUT) S OUT=-2 Q
 . . I $D(DUOUT)!(Y<1) S OUT=-1 Q
 . . ;   TMP = .01^.02^.03^.04^iens^new_flag
 . . S TMP=Y(0),$P(TMP,U,5)=(+Y)_","_DGIEN_","_U_$P(Y,U,3)
 . . ;   is new record a duplicate?
 . . I +$P(TMP,U,6),$D(DBRS("POST",$P(TMP,U))) D  S OUT=0
 . . . S OUT=0 W ! D TEXT(,1) W !
 . . . N Y,DA,DIK
 . . . S Y=$P(TMP,U,5),DA=+Y,DA(1)=+$P(Y,",",2),DIK=DIC D ^DIK
 . . . Q
 . . S DGDIC=TMP
 . . Q
 . ;
 . I '$D(DGDIC) S OUT=-1 Q
 . S DGDIE=$P(DGDIC,U,1,4)
 . ;
 . ;-----  if existing record selected, allow editing of .01 field
 . I '$P(DGDIC,U,6),DGDIE'="@" D  I OUT<1 Q
 . . N A,X,Y,DR,DIE,DR,DTOUT,DUOUT,PRE
 . . S A=$P(DGDIC,U,5),DA=+A,DA(1)=+$P(A,",",2)
 . . S PRE=^DGPF(26.13,DA(1),2,DA,0)
 . . S DIE=$NA(^DGPF(26.13,+DGIEN,2)),DIE=$TR(DIE,")",",")
 . . S DR=".01;.02"
 . . W ! D ^DIE
 . . I $D(DTOUT) S OUT=-2 Q
 . . S A=$P(DGDIC,U,5),DA=+A,DA(1)=+$P(A,",",2)
 . . S X=$G(^DGPF(26.13,DA(1),2,DA,0))
 . . I X="" S DGDIE="@" Q
 . . E  S DGDIE=X
 . . I $P(X,U)=$P(PRE,U) Q
 . . I '$D(DBRS("POST",$P(X,U))) Q
 . . W ! D TEXT(,3) W ! S OUT=0
 . . S DR=".01///"_$P(PRE,U)_";.02///"_$P(PRE,U,2) D ^DIE
 . . Q
 . ;
 . ;----- now make changes to DBRS()
 . S NM=$P(DGDIC,U)
 . S NM(1)=$P(DGDIE,U)
 . ;      new record added
 . I +$P(DGDIC,U,6) D  Q
 . . S DBRS("POST",NM)=$P(DGDIC,U,5)
 . . S DBRS("POST",NM,.01)=$P(DGDIC,U,1)
 . . S DBRS("POST",NM,.02)=$P(DGDIC,U,2)
 . . S DBRS("POST",NM,.03)=$P(DGDIC,U,3)
 . . S DBRS("POST",NM,.04)=$P(DGDIC,U,4)
 . . Q
 . ;      existing record to be deleted
 . I NM(1)="@" K DBRS("POST",NM) Q
 . ;      existing record .01 field value changed
 . I NM'=NM(1) D  Q
 . . K DBRS("POST",NM)
 . . S DBRS("POST",NM(1))=$P(DGDIC,U,5)
 . . S DBRS("POST",NM(1),.01)=$P(DGDIE,U,1)
 . . S DBRS("POST",NM(1),.02)=$P(DGDIE,U,2)
 . . S DBRS("POST",NM(1),.03)=$P(DGDIE,U,3)
 . . S DBRS("POST",NM(1),.04)=$P(DGDIE,U,4)
 . . Q
 . ;   dbrs# unchanged, OTHER may or may not have changed
 . S DBRS("POST",NM(1),.02)=$P(DGDIE,U,2)
 . Q
 ;    Reset 26.13 file DBRS data to pre-edit state
 M DGPRE=DBRS("PRE") D ADD(DGIEN,.DGPRE,1)
 Q
 ;
EDITCHG() ;----- check to see if any data changed at all
 N J,X,CHG,INC,NM
 S CHG=0
 S NM=0 F J=0:0 S NM=$O(DBRS("PRE",NM)) Q:NM=""  D  Q:CHG
 . I DBRS("PRE",NM,.01)'=$G(DBRS("POST",NM,.01)) S CHG=1
 . I DBRS("PRE",NM,.02)'=$G(DBRS("POST",NM,.02)) S CHG=1
 . Q
 I 'CHG S NM=0 F J=0:0 S NM=$O(DBRS("POST",NM)) Q:NM=""  D  Q:CHG
 . I DBRS("POST",NM,.01)'=$G(DBRS("PRE",NM,.01)) S CHG=1
 . I DBRS("POST",NM,.02)'=$G(DBRS("PRE",NM,.02)) S CHG=1
 . Q
 I 'CHG D EDTINACT
 Q CHG
 ;
EDTINACT ;  set up DGPFAH() if no change
 N J,X,INC,NM
 S INC=0
 S NM=0 F J=0:0 S NM=$O(DBRS("PRE",NM)) Q:NM=""  D
 . S X=DBRS("PRE",NM,.01)_U_DBRS("PRE",NM,.02)_U_DBRS("PRE",NM,.03)
 . S X=X_U_"N"_U_DBRS("PRE",NM,.04)
 . S INC=INC+1,DGPFAH("DBRS",INC)=X
 . Q
 Q
 ;
EDITPFA ;----- set DGPFA() to values if changes accepted
 N J,X,NM
 F X="DBRS#","DBRS OTHER","DBRS DATE","DBRS SITE" K DGPFA(X)
 S (J,NM)=0 F J=0:0 S NM=$O(DBRS("POST",NM)) Q:NM=""  D
 . S J=J+1
 . S DGPFA("DBRS#",J)=DBRS("POST",NM,.01)_U_$$EXT(NM,.01)
 . S DGPFA("DBRS OTHER",J)=DBRS("POST",NM,.02)_U_$$EXT(NM,.02)
 . S DGPFA("DBRS DATE",J)=DBRS("POST",NM,.03)_U_$$EXT(NM,.03)
 . S DGPFA("DBRS SITE",J)=DBRS("POST",NM,.04)_U_$$EXT(NM,.04)
 . Q
 Q
 ;
EDITPFAH ;----- Create DGPFAH()
 N I,J,X,Y,INC,NM
 S (INC,NM)=0 F I=0:0 S NM=$O(DBRS(0,NM)) Q:NM=""  D
 . N PRE,POST
 . S PRE="" I $D(DBRS(0,NM,1)) D
 . . S $P(PRE,U,1)=$G(DBRS(0,NM,1,.01))
 . . S $P(PRE,U,2)=$G(DBRS(0,NM,1,.02))
 . . S $P(PRE,U,3)=$G(DBRS(0,NM,1,.03))
 . . S $P(PRE,U,5)=$G(DBRS(0,NM,1,.04))
 . . Q
 . S POST="" I $D(DBRS(0,NM,2)) D
 . . S $P(POST,U,1)=$G(DBRS(0,NM,2,.01))
 . . S $P(POST,U,2)=$G(DBRS(0,NM,2,.02))
 . . S $P(POST,U,3)=$G(DBRS(0,NM,2,.03))
 . . S $P(POST,U,5)=$G(DBRS(0,NM,2,.04))
 . . Q
 . S INC=INC+1
 . ;----- no changes to DBRS
 . I PRE=POST S:PRE'="" $P(PRE,U,4)="N",DGPFAH("DBRS",INC)=PRE Q
 . ;----- POST="", DBRS deleted
 . I POST="" S $P(PRE,U,4)="D",DGPFAH("DBRS",INC)=PRE Q
 . ;----- PRE="", DBRS added
 . I PRE="" S $P(POST,U,4)="A",DGPFAH("DBRS",INC)=POST Q
 . ;----- DBRS record edited
 . ;      If date/site exist, may not be changed
 . S $P(POST,U,4)="E"
 . S X=$P(PRE,U,3) I X>0,$P(POST,U,3)'=X S $P(POST,U,3)=X
 . S X=$P(PRE,U,5) I X>0,$P(POST,U,5)'=X S $P(POST,U,5)=X
 . S DGPFAH("DBRS",INC)=POST
 . Q
 Q
 ;
EDITSORT ;----- Sort the DBRS() by DBRS#
 N I,NM
 S NM=0
 F I=0:0 S NM=$O(DBRS("PRE",NM)) Q:NM=""  M DBRS(0,NM,1)=DBRS("PRE",NM)
 S NM=0
 F I=0:0  S NM=$O(DBRS("POST",NM)) Q:NM=""  M DBRS(0,NM,2)=DBRS("POST",NM)
 Q
 ;
EH ;
 ;;You may add, edit, or delete a DBRS entry for this assignment.
 ;;To delete an entry, use the '@' sign after '//'.
 ;;
 N I,X,Y
 W !
 F I=1:1 S X=$P($T(EH+I),";;",2) Q:X=""  W !,X
 ; S X=$$ANSWER^DGPFUT("Press any key to continue",,"E")
 Q
 ;
EXT(DBS,FLD) ;  get external value
 ;   DBS = DBRS#
 ;   FLD = field number
 N X,Y
 S Y="",X=$G(DBRS("POST",NM,FLD))
 I FLD=.01 S Y=X
 I FLD=.02 S Y=X S:X="" Y="<no value>"
 I FLD=.03,X>0 S Y=$$FMTE^XLFDT(X,"5Z")
 I FLD=.04,X>0 S Y=$P($$NS^XUAF4(X),U)
 Q Y
 ;
GET(DBRS,NODE,IEN) ;
 ;   get dbrs records from 26.13
 ;   only return DBRS() with internal FM form of the data
 ;  .DBRS - return array
 ;   NODE = PRE or POST
 ;    IEN = file 26.13 ien
 N I,DGRET,NM
 Q:$G(IEN)<1
 D GETDBRS^DGPFUT6(.DGRET,IEN)
 ;   see GETDBRS^DGPRUT62 for description of .DGRET
 S DBRS(NODE)=0
 S (I,NM)=0 F  S NM=$O(DGRET(NM)) Q:NM=""  D
 . S DBRS(NODE)=1+$G(DBRS(NODE))
 . S DBRS(NODE,NM)=DGRET(NM) ;   iens
 . S DBRS(NODE,NM,.01)=NM
 . S DBRS(NODE,NM,.02)=$P(DGRET(NM,"OTHER"),U)
 . S DBRS(NODE,NM,.03)=$P(DGRET(NM,"DATE"),U)
 . S DBRS(NODE,NM,.04)=$P(DGRET(NM,"SITE"),U)
 . Q
 Q
 ;
NOW() N I,X,Y,Z Q $E($$NOW^XLFDT,1,12)
 ;
TEXT(TXT,ST,NOWR) ;
 N I,J,X S J=0
 F I=ST:1 S X=$P($T(T+I),";",3,9) Q:X="[end]"  S J=J+1,TXT(J)="   "_X
 I '$G(NOWR) F I=1:1 Q:'$D(TXT(I))  W !,TXT(I)
 Q
T ;
 ;;This DBRS# Number is already associated with this assignment.
 ;;[end]
 ;;You have changed the name of an existing DBRS Number to be the same
 ;;as an existing DBRS entry for this flag assignment.  This is not
 ;;allowed.
 ;;[end]
 ;;   
 ;;You have marked this assignment as Entered In Error
 ;;All of the following DBRS Numbers will be removed from this assignment:
 ;;DO NOT file the assignment if you do not wish these DBRS Numbers
 ;;removed from this assignment.
 ;;[end]
