DGPFUT62 ;SHRPE/SGM - PRF DBRS FILE/GET/SORT ; Mar 1, 2018 17:20
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM - Oct 08, 2018 11:08
 ;
 ; ^DGPFUT6 is the only component to directly reference this routine
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -----------------------------------------
 ; 2056  Sup   $$GET1^DIQ, GETS^DIQ
 ; 2051  Sup   $$FIND1^DIC
 ; 2053  Sup   ^DIE: FILE, UPDATE
 ;10013  Sup   ^DIK
 ;10112  Sup   $$SITE^VASITE
 ;
 ;=====================================================================
AASGN(DGIENS,DGPFIN,DGFDA,DGPFUV,DGPFERR) ;
 ;    Called from STOASGN^DGPFAA
 ;BUSINESS RULES:
 ; 1. Create FDA(), do not change any data in existing files
 ;      Calling program will call FILE^DIE or UPDATE^DIE
 ; 2. Calling program may add DGPFA("ACTION") if it has an associated
 ;      History record.
 ; 3. If ACTION is 3 (Inactive) no DBRS data edited
 ; 4. If ACTION is 5 (EIE), delete all existing DBRS data, add no new
 ;      DBRS data
 ; 5. If ACTION is 7 (Refresh), delete all existing DBRS before adding
 ; 6. Updates called from processing HL7 message
 ;      May set DGPFA("DBRS ACTION") = U:add/update  D:delete
 ;      Applies to that one DBRS record only
 ; 7. DBRS DATE and SITE fields may not be overwritten except for
 ;      Refresh
 ; 8. Only REFRESH action is authorized to overwrite an existing field
 ;      values for DATE and CREATE SITE
 ;
 ;INPUT PARAMETERS:
 ;   DGIENS - 26.13 iens, may be +N, or N,
 ;  .DGPFIN - DGPFA() passed by reference - see DGPFAA for details
 ;  .DGFDA  - FDA() array to be populated, may have existing values
 ;   DGPFUV - optional - default to "", consists of single character
 ;           ="D" delete all existing DBRS records before adding others
 ;           ="d" delete all existing DBRS record, quit, do not
 ;                  continue processing in this module
 ;           =""  only act upon DBRS# indicated in DGPFA()
 ;
 ;RETURN PARAMETERS:
 ;   .DGFDA - FDA() array to be populated if appropriate
 ; .DGPFERR - error message array
 ;            $D(DGPFERR) - fail, calling program does not continue
 ;           '$D(DGPFERR) - calling program continues
 ;
 N I,J,X,ACT,FAC,DBRS,DGDBRS,DIEN,INC,NOW,SITE
 ;   initialize local variables
 I '$L($G(DGIENS)) Q
 S:$E(DGIENS,$L(DGIENS))'="," DGIENS=DGIENS_","
 S NOW=+$E($$NOW^XLFDT,1,12)
 S FAC=+$$SITE^VASITE
 S ACT=+$G(DGPFIN("ACTION"))
 S DGPFUV=$$UV^DGPFAA Q:DGPFUV=-1
 I ACT=5,DGPFUV'="d" S DGPFUV="d"
 I ACT=3 Q  ;  no editing of DBRS data for inactivate
 ;             do not set up DGFDA()
 ;
 ;  see GETDBRS for array description
 ;      DBRS(dbrs#,1)     = 26.131_iens
 ;      DBRS(dbrs#,1,sub) = pre_edit_image
 ;      DBRS(dbrs#,2)     = < does not exist >
 ;      DBRS(dbrs#,2,sub) = post_edit_image
 ;
 ;  get current DBRS records on file (PRE-image)
 I DGIENS'["+" D
 . N X,ARR
 . D GETDBRS(.ARR,DGIENS)
 . I $G(ARR(0))>0 S X=0 F  S X=$O(ARR(X)) Q:X=""  D
 . . S DBRS(X,1)=ARR(X) ;    26.131 iens value
 . . S DBRS(X,1,"DBRS#")=X
 . . S DBRS(X,1,"OTHER")=$P($G(ARR(X,"OTHER")),U)
 . . S DBRS(X,1,"DATE")=$P($G(ARR(X,"DATE")),U)
 . . S DBRS(X,1,"SITE")=$P($G(ARR(X,"SITE")),U)
 . . Q
 . Q
 ;
 ;  moved INPUT data to DBRS(dbrs#,2) [POST-image]
 S I=0 F J=0:0 S I=$O(DGPFIN("DBRS#",I)) Q:'I  D
 . N X,Y
 . S DBRS=$P(DGPFIN("DBRS#",I),U)
 . S DBRS(DBRS,2,"DBRS#")=DBRS
 . S Y=$P(DGPFIN("DBRS OTHER",I),U) S:Y="<no value>" Y=""
 . S DBRS(DBRS,2,"OTHER")=Y
 . S Y=$P(DGPFIN("DBRS DATE",I),U)
 . S DBRS(DBRS,2,"DATE")=Y
 . S Y=$P(DGPFIN("DBRS SITE",I),U)
 . S DBRS(DBRS,2,"SITE")=Y
 . ;   DBRS ACTION only comes from HL7 message processing
 . ;   Set ACT to -1 if not coming from HL7 processing
 . S X=$G(DGPFIN("DBRS ACTION",I),-1)
 . S DBRS(DBRS,2,"ACT")=$P(X,U)
 . Q
 ;
 ;  set up FDA()
 ; 
 ;  if DGPFUV="d" or ="D" then set all existing DBRS records to be
 ;     deleted.  Edits may override delete
 ;  if DGPFUV="" then called from PRF HL processor, only act upon
 ;     specific DBRS# listed in DGPFA()
 ;
 I DGPFUV="D"!(DGPFUV="d") D
 . N X,Y,IENS,NM
 . S NM="" F  S NM=$O(DBRS(NM)) Q:NM=""  I $D(DBRS(NM,1)) D
 . . S IENS=DBRS(NM,1),DGFDA(26.131,IENS,.01)="@"
 . . Q
 . Q
 I DGPFUV="d" Q
 ;
 S INC=10 ;    incrementor used for add new DBRS record
 S DBRS=0 F J=0:0 S DBRS=$O(DBRS(DBRS)) Q:DBRS=""  D
 . N ACT,HLACT,DIEN,IENS
 . S IENS=$G(DBRS(DBRS,1))
 . S HLACT=$G(DBRS(DBRS,2,"ACT"))
 . S ACT=+$G(DGPFIN("ACTION"))
 . ;
 . ;  PRE exists, POST does not;  record deleted if DGPFUV="D"
 . I $D(DBRS(DBRS,1)),'$D(DBRS(DBRS,2)) Q
 . ;
 . ;  POST exists, PRE does not, adding a new record
 . ;     Post DBRS action may be Delete
 . I $D(DBRS(DBRS,2)),'$D(DBRS(DBRS,1)) D  Q
 . . I HLACT="D" Q
 . . S INC=INC+1,DIEN="+"_INC_","_DGIENS
 . . S DGFDA(26.131,DIEN,.01)=DBRS
 . . S X=DBRS(DBRS,2,"OTHER") S:$L(X) DGFDA(26.131,DIEN,.02)=X
 . . S X=DBRS(DBRS,2,"DATE") S:+X DGFDA(26.131,DIEN,.03)=X
 . . S X=DBRS(DBRS,2,"SITE") S:+X DGFDA(26.131,DIEN,.04)=X
 . . Q
 . ;
 . ;  Both PRE and POST exists, update existing record
 . ;    conditional update of fields .03,.04
 . I HLACT="D" S DGFDA(26.131,IENS,.01)="@" Q
 . K DGFDA(26.131,IENS,.01)
 . S X=$G(DBRS(DBRS,1,"OTHER")),Y=$G(DBRS(DBRS,2,"OTHER")) D
 . . I X'=Y S DGFDA(26.131,IENS,.02)=Y
 . . Q
 . S X=$G(DBRS(DBRS,1,"DATE")),Y=$G(DBRS(DBRS,2,"DATE")) D
 . . I $S((ACT=7)!(ACT=8):1,+X:0,1:+Y) S DGFDA(26.131,IENS,.03)=Y
 . . Q
 . S X=$G(DBRS(DBRS,1,"SITE")),Y=$G(DBRS(DBRS,2,"SITE")) D
 . . I $S((ACT=7)!(ACT=8):1,+X:0,1:+Y) S DGFDA(26.131,IENS,.04)=Y
 . . Q
 . Q
 Q
 ;
 ;=====================================================================
DEL(DGXIEN,DGFILE) ;
 ;   delete all DBRS records for a flag assignment or history record
 ;   QA on input values done in DGPFUT6
 Q:'$G(DGXIEN)  Q:'$G(DGFILE)
 S DGXIEN=+DGXIEN
 Q:'$O(^DGPF(DGFILE,DGXIEN,2,0))
 Q:"^26.13^26.14^"'[(U_DGFILE_U)
 N X,Y,DA,DGDBRSE,DIK
 S DGDBRSE=1 ;  not need but cya, DEL node on ^DD(26.131,.01)
 S DIK="^DGPF("_DGFILE_","_DGXIEN_",2," S DA(1)=DGIEN
 S DA=0 F  S DA=$O(^DGPF(DGFILE,DGXIEN,2,DA)) Q:'DA  D ^DIK
 Q
 ;
 ;=====================================================================
GETDBRS(DGRET,DGAIEN) ;
 ;Return all DBRS data associated with a CAT I BEHAVIORAL assignment
 ;INPUT PARAMETER:  DGPFIEN - req - file_26.13_ien
 ;RETURN VALUES:
 ;  .DGRET(0)             = total number of DBRS records [0,1,2,...]
 ;  .DGRET(dbrs#)         = <26.131_ien>,<26.13_ien>, [iens]
 ;        (dbrs#,"DBRS#") = internal^external  [#.01]
 ;        (dbrs#,"OTHER") = internal^external  [#.02]
 ;        (dbrs#,"DATE")  = internal^external  [#.03]
 ;        (dbrs#,"SITE")  = internal^external  [#.04]
 ;
 N X,Y,DGARR,DGIEN,DGERR,DIERR,IENS
 S DGRET(0)=0
 S DGAIEN=$G(DGAIEN) Q:$E(DGAIEN)="+"  Q:'DGAIEN
 ;
 S DGIEN=(+DGAIEN)_","
 D GETS^DIQ(26.13,DGIEN,".02;2*","IE","DGARR","DGERR")
 Q:$D(DIERR)
 Q:DGARR(26.13,DGIEN,.02,"I")'[26.15
 Q:DGARR(26.13,DGIEN,.02,"E")'="BEHAVIORAL"
 S IENS=0 F  S IENS=$O(DGARR(26.131,IENS)) Q:'IENS  D
 . N DBRS,TMP M TMP=DGARR(26.131,IENS)
 . S DBRS=TMP(.01,"E")
 . S DGRET(0)=1+DGRET(0)
 . S DGRET(DBRS)=IENS
 . S DGRET(DBRS,"DBRS#")=TMP(.01,"I")_U_TMP(.01,"E")
 . S DGRET(DBRS,"OTHER")=TMP(.02,"I")_U_TMP(.02,"E")
 . S DGRET(DBRS,"DATE")=TMP(.03,"I")_U_TMP(.03,"E")
 . S DGRET(DBRS,"SITE")=TMP(.04,"I")_U_TMP(.04,"E")
 . Q
 Q
 ;
 ;=====================================================================
GETDBRSH(DGRET,DGHIEN) ;
 ;   Get DBRS data for a History record
 ;INPUT PARAMETERS:  DGPFIEN - req - ien to file 26.14
 ;RETURN VALUES:
 ;  .DGRET(0)             = total number of DBRS records
 ;  .DGRET(dbrs#)         = <26.142_ien>,<26.14_ien>, [iens]
 ;        (dbrs#,"DBRS#") = internal^external  [#.01]
 ;        (dbrs#,"OTHER") = internal^external  [#.02]
 ;        (dbrs#,"DATE")  = internal^external  [#.03]
 ;        (dbrs#,"STAT")  = internal^external  [#.04]
 ;        (dbrs#,"SITE")  = internal^external  [#.05]
 ;
 S DGRET(0)=0
 S DGHIEN=$G(DGHIEN)
 I DGHIEN,$D(^DGPF(26.14,DGHIEN,2)) D
 . N DGARR,DGERR,DIERR,IEN,IENS
 . S IENS=(+DGHIEN)_","
 . D GETS^DIQ(26.14,IENS,"2*","IE","DGARR","DGERR")
 . Q:$D(DIERR)
 . S IEN=0 F  S IEN=$O(DGARR(26.142,IEN)) Q:'IEN  D
 . . N DBRS,TMP
 . . M TMP=DGARR(26.142,IEN)
 . . S DBRS=TMP(.01,"E")
 . . S DGRET(0)=1+DGRET(0)
 . . S DGRET(DBRS)=IEN
 . . S DGRET(DBRS,"DBRS#")=TMP(.01,"I")_U_TMP(.01,"E")
 . . S DGRET(DBRS,"OTHER")=TMP(.02,"I")_U_TMP(.02,"E")
 . . S DGRET(DBRS,"DATE")=TMP(.03,"I")_U_$P(TMP(.03,"E"),":",1,2)
 . . S DGRET(DBRS,"STAT")=TMP(.04,"I")_U_TMP(.04,"E")
 . . S DGRET(DBRS,"SITE")=TMP(.05,"I")_U_TMP(.05,"E")
 . . Q
 . Q
 Q
 ;
 ;=====================================================================
STOHIST(DGIENS,DGFLD,DGFDA,DGPFERR) ;
 ;  Set up FDA() for use in UPDATE^DIE
 ;  For more information on input params, see STOHIST^DGPFAAH
 ;INPUT PARAMETERS:
 ;  DGIENS - req - fda() iens to file 26.14, may be "+1,"
 ;  .DGFLD - req - subset of DGPFAH()
 ;RETURN PARAMETERS:
 ;   .DGFDA - FDA array of UPDATE^DIE
 ;            DGFDA() may have existing nodes unrelated to DBRS
 ; .DGPFERR - error array to return to calling program
 ;
 N I,J,IEN,INC
 S DGIENS=$G(DGIENS) I DGIENS="" Q
 I $E(DGIENS)'="+",'$D(^DGPF(26.14,+DGIENS,0)) Q
 Q:'$D(DGFLD("DBRS"))
 ;
 S INC=50,I=0 F J=0:0 S I=$O(DGFLD("DBRS",I)) Q:'I  D
 . N J,IENS,INP
 . ;  expects DGFLD("DBRS",I) to consist of 5 single valued pieces
 . F J=1:1:5 S INP(J)=$P(DGFLD("DBRS",I),U,J)
 . S INC=INC+1,IENS="+"_INC_","_DGIENS
 . S DGFDA(26.142,IENS,.01)=INP(1) ;              DBRS#
 . I $L(INP(2)) S DGFDA(26.142,IENS,.02)=INP(2) ; OTHER
 . I +INP(3) S DGFDA(26.142,IENS,.03)=INP(3) ;    DATE
 . I INP(4)?1U S DGFDA(26.142,IENS,.04)=INP(4) ;  STAT
 . I +INP(5) S DGFDA(26.142,IENS,.05)=INP(5) ;    SITE
 . Q
 Q
