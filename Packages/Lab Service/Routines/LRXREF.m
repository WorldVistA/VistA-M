LRXREF ;DALOI/STAFF - BUILD CROSS-REFERENCES FOR RE-INDEX ;09/06/11  14:37
 ;;5.2;LAB SERVICE;**70,153,263,350**;Sep 27, 1994;Build 230
 ;
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
AVS1 ; Rebuild "AVS" cross-reference in file 68 for Re-index utility - DATE/TIME RESULTS AVAILABLE  (68.02,13)
 I $D(DIU(0)),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)="" S ^LRO(68,"AVS",DA(2),DA(1),DA)=$P(^LRO(68,DA(2),1,DA(1),1,DA,0),U)_"^"_$P(^(3),U,5)
 Q
 ;
 ;
AVS2 ; Rebuild "AVS" cross-reference in file 68 for Re-index utility - DATE/TIME RESULTS AVAILABLE  (68.02,13)
 I $D(DIU(0)),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)'="" K ^LRO(68,"AVS",DA(2),DA(1),DA)
 Q
 ;
 ;
AVS3 ; Rebuild "AVS" cross-reference in fie #68 for re-index utility - DATE/TIME RESULTS AVAILABLE  (68.02,13)
 I '$D(DIU(0)),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)'="" K ^LRO(68,"AVS",DA(2),DA(1),DA)
 Q
 ;
 ;
AVS4 ; Rebuild "AVS" cross-reference in file 68 for Re-index utility - DATE/TIME RESULTS AVAILABLE  (68.02,13)
 I '$D(DIU(0)),$P(^LRO(68,DA(2),1,DA(1),1,DA,3),U,4)="" S ^LRO(68,"AVS",DA(2),DA(1),DA)=$P(^LRO(68,DA(2),1,DA(1),1,DA,0),U)_"^"_$P(^(3),U,5)
 Q
 ;
 ;
AC1 ; Build "AC" cross-reference when comment is deleted from a verified test in File 63. Audit trail only.
 I '$D(DIU(0)),$D(DUZ),$P(^LR(DA(2),"CH",DA(1),0),U,3) S ^LR(DA(2),"CH",DA(1),1,"AC",DUZ,$H)=$P(^LR(DA(2),"CH",DA(1),0),U,3,4)_"^"_X
 Q
 ;
 ;
AN1 ; Build logic "AN"" cross-reference in File 69, when results available
 S ^LRO(69,"AN",$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,20),$P(^(0),U),9999999-$P(^LRO(69,DA(1),1,DA,1),U))=""
 Q
 ;
 ;
AN2 ; Kill logic for "AN"" cross-reference in File 69, when results available
 K ^LRO(69,"AN",$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,20),$P(^(0),U),9999999-$P(^LRO(69,DA(1),1,DA,1),U))
 Q
 ;
 ;
AR1 ; Setup variables for set/kill "AR" cross-reference in File 69, when results available
 S LRDT=$E(X,1,7),LRLLOC=$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,20)
 S LRDFN=$P(^(0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 S LRGN=$$GET1^DID(+LRDPF,"","","GLOBAL NAME")_DFN_",0)"
 S LRGN=$S($D(@LRGN):@LRGN,1:"") S LRPNM=$P(LRGN,U)
 Q
 ;
 ;
AR2 ; Build "AR" cross-reference in File 69, when results available
 N LRDT,LRGN,LRDFN,LRLLOC,LRPNM
 D AR1
 S ^LRO(69,LRDT,1,"AR",LRLLOC,LRPNM,LRDFN)=""
 Q
 ;
 ;
AR3 ; Kill "AR" cross-reference in File 69, when results available
 N LRDT,LRGN,LRDFN,LRLLOC,LRPNM
 D AR1
 K ^LRO(69,LRDT,1,"AR",LRLLOC,LRPNM,LRDFN)
 Q
 ;
 ;
LRKILL ; This cross-reference will be reset when the cumulative runs.  Due to the complexity of the cumulative reporting it was felt that
 ; it was better to have reprinted data rather than possibly having some data not printed at all.
 K ^LAC("LRKILL")
 Q
 ;
 ;
AP ; Setup variables for set/kill "AP" cross-reference in File 69, when results available
 S LRDATE=$P($P(^LRO(69,DA(1),1,DA,3),U),".")
 S LRPHY=$P(^LRO(69,DA(1),1,DA,0),U,6),LRPHY=$S($D(^VA(200,LRPHY,0)):$E($P(^(0),U),1,20),1:"UNK")
 S LRDFN=$P(^LRO(69,DA(1),1,DA,0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 S LRGN=$$GET1^DID(+LRDPF,"","","GLOBAL NAME")_DFN_",0)"
 S LRGN=$S($D(@LRGN):@LRGN,1:""),LRPNM=$P(LRGN,U)
 Q
 ;
 ;
AP1 ; Build "AP" cross-reference in File 69, when results available
 N LRDATE,LRPHY,LRPNM,LRDFN,LRGN,LRDPF,DFN
 D AP
 S ^LRO(69,LRDATE,1,"AP",LRPHY,LRPNM,LRDFN)=""
 Q
 ;
 ;
AP2 ; Kill "AP" cross-reference in File 69, when results available
 N LRDATE,LRPHY,LRPNM,LRDFN,LRGN,LRDPF,DFN
 D AP
 K ^LRO(69,LRDATE,1,"AP",LRPHY,LRPNM,LRDFN)
 Q
 ;
 ;
AL ; Setup variables for set/kill "AL" cross-reference in File 69, when results available
 S LRDATE=$P($P(^LRO(69,DA(1),1,DA,3),U),"."),LRDFN=$P(^LRO(69,DA(1),1,DA,0),U),LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 S LRGN=$$GET1^DID(+LRDPF,"","","GLOBAL NAME")_DFN_",0)"
 S LRGN=$S($D(@LRGN):@LRGN,1:"") S LRPNM=$P(LRGN,U)
 S LRLLOC=$E($P(^LRO(69,DA(1),1,DA,0),U,7),1,20)
 Q
 ;
 ;
AL1 ; Build "AL" cross-reference in File 69, when results available
 N LRDATE,LRPNM,LRDFN,LRGN,LRDPF,DFN,LRLLOC
 D AL
 S ^LRO(69,LRDATE,1,"AL",LRLLOC,LRPNM,LRDFN)=""
 Q
 ;
 ;
AL2 ; Kill "AL" cross-reference in File 69, when results available
 N LRDATE,LRPNM,LRDFN,LRGN,LRDPF,DFN,LRLLOC
 D AL
 K ^LRO(69,LRDATE,1,"AL",LRLLOC,LRPNM,LRDFN)
 Q
 ;
 ;
UP ; Convert lower to upper case.
 S X=$$UP^XLFSTR(X)
 Q
 ;
 ;
TRIG ; Trigger LAB Workload
 ; Stuff the Cap Code Name into field .03 of field 4 of field 1 of field 1 of ^LRO(67.9 LAB MONTHLY WORKLOAD
 S X=$P($G(^LAM($O(^LAM("E",$P(^LRO(67.9,DA(3),1,DA(2),1,DA(1),1,DA,0),U),0)),0)),U)
 Q
 ;
 ;
TRIGTS ; Trigger to stuff treating specialty name into .03 field of ^DD(67.91148
 S X=$P($G(^DIC(42.4,+$P($G(^LRO(67.9,DA(4),1,DA(3),1,DA(2),1,DA(1),1,DA,0)),U),0)),U) S:'$L(X) X="AMBULATORY CARE"
 Q
 ;
 ;
TRIG9 ; Trigger for LAB Workload
 ; Stuff the Cap Code Name into field .03 of field 4 of field 1 of field 1 of ^LRO(67.99999 ARCHIVED LAB MONTHLY WORKLOAD
 S X=$P($G(^LAM($O(^LAM("E",$P(^LRO(67.99999,DA(3),1,DA(2),1,DA(1),1,DA,0),U),0)),0)),U)
 Q
 ;
 ;
TRIGTS9 ; Trigger to stuff treating specialty name into .03 field of ^DD(67.999991148
 S X=$P($G(^DIC(42.4,+$P($G(^LRO(67.99999,DA(4),1,DA(3),1,DA(2),1,DA(1),1,DA,0)),U),0)),U) S:'$L(X) X="AMBULATORY CARE"
 Q
 ;
 ;
LAM185 ; Trigger logic to set TYPE(#5) of CODE (#18) of WKLD CODE (#64)
 N %1
 S %1=$P(X,";",2),X=$S(%1="ICPT(":"CPT",%1="LAB(61.1,":"SNO",%1="ICD9(":"ICD",1:"NOS")
 Q
 ;
 ;
SCTCHK(LRSCT,LR612,LRSCT1) ;
 ; File #61.2 SNOMEDCT field check - Coded to work within FM DD calls
 ; Inputs
 ;   LRSCT : SNOMED CT code
 ;   LR612 : File #61.2 IEN
 ;  LRSCT1 : <opt>"old" value of SNOMED CT ID field
 ; Output
 ;    1 = OK to add code
 ;   -1 = SCT code not valid
 ;
 N LRSTAT,LRX,LRCNT,LRT
 S LRT=$T ;save $T
 S LRSCT=$G(LRSCT),LRSCT1=$G(LRSCT1),LR612=+$G(LR612),LRSTAT=1
 Q:LRSCT="" 1
 Q:$G(LR612F20)=1 1
 S LRX=$$CODE^LRSCT(LRSCT,"SCT")
 ; invalid SCT
 S:+LRX=-1 LRSTAT=-1
 ;
 I LRT ;reset $T
 Q LRSTAT
 ;
 ;
DELSCT(LR612) ;
 ; Delete File #61.2 field 20 (SNOMED CT ID) - For use within FM DD calls and SCTCHK API
 N DA,DI,DIC,DIERR,X,Y,LRFDA,LRMSG,LRT
 S LRT=$T
 S LR612=+$G(LR612)
 S LRFDA(1,61.2,LR612_",",20)="@"
 D FILE^DIE("I","LRFDA(1)","LRMSG")
 I LRT ;reset $T
 Q
 ;
 ;
IT61F20 ; Input transform for file #61, field 20
 ; $C(32) tricks EN^DDIOL to not insert a linefeed
 ;
 ;ZEXCEPT: DIUTIL,LRFMERTS,X
 ;
 N LROUT,LRSTATUS
 ;
 Q:$G(X)=""
 ;
 ; Check if SCT ID is valid
 S LRSTATUS=$$CODE^LEXTRAN(X,"SCT",DT,"LROUT")
 I LRSTATUS<1 K X
 ;
 ; Display term if not "quiet" or via FileMan Verify Fields option
 I '$$ISQUIET(),$G(DIUTIL)'="VERIFY FIELDS" D
 . I $G(LROUT("F"))'="" D EN^DDIOL(LROUT("F"),"","$C(32)")
 . I LRSTATUS<1 D EN^DDIOL("  "_$P(LRSTATUS,"^",2),"","$C(32)")
 ;
 ; If not FileMan Verify Fields and not editing via lab software then kill X to lock down local edits.
 I $D(X),$G(DIUTIL)'="VERIFY FIELDS",'$G(LRFMERTS) K X
 ;
 Q
 ;
 ;
IT612F20 ; Input Transform for File #61.2 field 20
 ; $C(32) tricks EN^DDIOL to not insert a linefeed
 ;
 ;ZEXCEPT: DA,DIUTIL,LRFMERTS,X,Y
 ;
 N LRX,LRT
 ;
 S LRT=$T ;save $T
 ;
 Q:$G(X)=""
 ;
 ; Y=Old Value
 ;  Is this SCT code used in #62.47?
 I $G(Y)'="",$D(^LAB(62.47,"AF","SCT",Y)) D  Q
 . K X
 . I '$$ISQUIET(),$G(DIUTIL)'="VERIFY FIELDS" D EN^DDIOL("**Mapped in File #62.47**",,"$C(32)")
 . I LRT ; reset $T
 ;
 Q:+$G(DA)<1
 S LRX=$$SCTCHK(X,DA,$G(Y))
 ;
 I +LRX=-1 D
 . K X
 . I '$$ISQUIET(),$G(DIUTIL)'="VERIFY FIELDS" D EN^DDIOL("**Invalid SCT code**",,"$C(32)")
 ;
 ; If not FileMan Verify Fields and not editing via lab software then kill X to lock down local edits.
 I $D(X),$G(DIUTIL)'="VERIFY FIELDS",'$G(LRFMERTS) K X
 ;
 I LRT ; reset $T
 Q
 ;
 ;
IT62F20 ; Input transform for file #62, field 20
 ; $C(32) tricks EN^DDIOL to not insert a linefeed
 ;
 ;ZEXCEPT: DIUTIL,LRFMERTS,X
 ;
 N LROUT,LRSTATUS
 ;
 Q:$G(X)=""
 ;
 ; Check if SCT ID is valid
 S LRSTATUS=$$CODE^LEXTRAN(X,"SCT",DT,"LROUT")
 I LRSTATUS<1 K X
 ;
 ; Display term if not "quiet" or via FileMan Verify Fields option
 I '$$ISQUIET(),$G(DIUTIL)'="VERIFY FIELDS" D
 . I $G(LROUT("F"))'="" D EN^DDIOL(LROUT("F"),"","$C(32)")
 . I LRSTATUS<1 D EN^DDIOL("  "_$P(LRSTATUS,"^",2),"","$C(32)")
 ;
 ; If not FileMan Verify Fields and not editing via lab software then kill X to lock down local edits.
 I $D(X),$G(DIUTIL)'="VERIFY FIELDS",'$G(LRFMERTS) K X
 ;
 Q
 ;
 ;
ISQUIET() ;
 ; Is "Quiet" or not (Should we Write output?)
 N QUIET
 S QUIET=0
 S:$G(LRQUIET) QUIET=1
 S:$G(DIQUIET) QUIET=1
 Q QUIET
 ;
 ;
SETISOID(LRSUB) ;
 ; Called from #63.05 fields Cross reference
 ; Create and stuff ISOLATE ID when .01 field entered
 ; Inputs
 ;  LRSUB : The global subscript for this isolate
 ;
 N LRFDA,LRMSG,LRIENS,LRX,LRSUBFL
 S LRSUB=$G(LRSUB)
 Q:'$G(DA)
 S LRSUBFL=0
 I LRSUB=3 S LRSUBFL=63.3
 I LRSUB=6 S LRSUBFL=63.34
 I LRSUB=9 S LRSUBFL=63.37
 I LRSUB=12 S LRSUBFL=63.39
 I LRSUB=17 S LRSUBFL=63.43
 Q:'LRSUBFL
 ;
 ; build IENS
 S LRIENS=$$IENS^DILF(.DA)
 S LRX=$$MAKEISO^LRVRMI1(+$$KSP^XUPARAM("INST"),LRSUB_"-"_DA)
 S LRFDA(1,LRSUBFL,LRIENS,.1)=LRX
 D  ;
 . N DA,X,Y,X1,X2,DIE,DIC,DIERR
 . D FILE^DIE("","LRFDA(1)","LRMSG")
 Q
 ;
 ;
IT600201 ;
 ; Input Transform for Sub-File #60.02 field #.01
 ; Expects X (#60 IEN of test being added to panel) and DA array -- DA(1)=^LAB(60,IEN)  DA=^LAB(60,DA(1),2,DA)
 I $P(^LAB(60,DA(1),0),U,5)'="" D  Q  ;
 . K X
 . D EN^DDIOL("NO CAN DO",,"!")
 ;
 Q:$G(DIUTIL)="VERIFY FIELDS"
 I X=DA(1) D  Q  ;
 . K X
 . D EN^DDIOL("CAN'T ADD TEST TO ITSELF",,"!,$C(7)")
 ;
 Q:'$D(X)
 ; Check for recursive panel entries
 N LRRECUR,LR60C,LR60P
 S LR60C=X ;child
 S LR60P=DA(1) ;parent
 ; If they're both panels then check for recursion
 I $O(^LAB(60,LR60C,2,0)) I $O(^LAB(60,LR60P,2,0)) D  ;
 . K ^TMP($J,"LRXREF-PANELCHK")
 . S ^TMP($J,"LRXREF-PANELCHK",LR60C)=""
 . S ^TMP($J,"LRXREF-PANELCHK",LR60P)=""
 . S LRRECUR=0
 . D PANELCHK(LR60P,.LRRECUR) ;check parent
 . I 'LRRECUR D PANELCHK(LR60C,.LRRECUR) ;check the one we're adding
 . K ^TMP($J,"LRXREF-PANELCHK")
 . I LRRECUR D  Q  ;
 . . K X
 . . D EN^DDIOL("RECURSION DETECTED -- TEST NOT ADDED",,"!,$C(7)")
 . ;
 Q
 ;
 ;
PANELCHK(LR60,LRRECUR) ;
 ; Private method for IT600201 above
 ; This is a recursive method.
 ; Called from DD (Input Transform). Must be FileMan safe.
 ; Caller must kill ^TMP($J,"LRXREF-PANELCHK") before
 ; first call and after last call.  Parent and Child panel tests
 ; should be added to ^TMP($J,"LRXREF-PANELCHK",IEN) before calling:
 ;  I $O(^LAB(60,IEN,2,0)) S ^TMP($J,"LRXREF-PANELCHK",IEN)=""
 ;
 ; Inputs
 ;     LR60: #60 IEN of panel
 ;  LRRECUR: <byref> See Outputs
 ;
 ; Outputs
 ;  LRRECUR: 1=recursion found   0=no recursion
 ;  LRRECUR(1): The parent #60 IEN and child #60 IEN that
 ;              caused the recursion.
 ;
 N LR60B,LR6002,LRDATA,DA,X
 S LR60=$G(LR60)
 S LRRECUR=$G(LRRECUR,0)
 Q:LRRECUR
 S LR6002=0
 F  S LR6002=$O(^LAB(60,LR60,2,LR6002)) Q:'LR6002  D  Q:LRRECUR  ;
 . S LR60B=LR60
 . S LRDATA=^LAB(60,LR60,2,LR6002,0)
 . N LR60
 . S LR60=$P(LRDATA,U,1)
 . Q:'LR60
 . Q:'$O(^LAB(60,LR60,2,0))  ;not a panel test
 . I $D(^TMP($J,"LRXREF-PANELCHK",LR60)) D  Q  ;
 . . S LRRECUR=1
 . . S LRRECUR(1)=LR60B_"^"_LR60
 . ;
 . S ^TMP($J,"LRXREF-PANELCHK",LR60)=""
 . D PANELCHK(LR60,.LRRECUR) ;recursive call
 ;
 Q
