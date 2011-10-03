TIUDD1 ; SLC/JER - XREFs for file 8925.1 ;19-OCT-2001 10:05:37 [7/28/04 9:08am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,51,115,163,224**;Jun 20, 1997;Build 7
SACL(X,FLD) ; Set logic for ACL cross-reference
 ; Called from fields .01 (NAME), .07 (STATUS), .03 (PRINT NAME),
 ; .02 (ABBREVIATION), and Subfield .01 of ITEM sub-file
 N TIUCLASS,TIUSTTS,TIUTTL
 I FLD=10.01 D
 . ; Include only TITLES in the index
 . I $P($G(^TIU(8925.1,+X,0)),U,4)'="DOC" Q
 . S TIUSTTS=$P($G(^TIU(8925.1,+X,0)),U,7)
 . ; Include only TEST or ACTIVE titles
 . I $S(TIUSTTS=10:0,TIUSTTS=11:0,1:1) Q
 . S TIUTTL=$P($G(^TIU(8925.1,+X,0)),U)
 . Q:TIUTTL']""
 . ; First build x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+X)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+X)=""
 . S ^TIU(8925.1,"ACL",38,TIUTTL,+X)=""
 . D SACLKWIC(TIUTTL,TIUCLASS,+X)
 . ; Now build x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+X)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+X)=""
 . D SACLKWIC(TIUTTL,TIUCLASS,+X)
 ; For Abbreviation and Print Name fields, just set the Synonym subscript
 I $S(FLD=.02:1,FLD=.03:1,1:0) D  Q
 . N TIUDA
 . Q:X']""
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . I $P($G(^TIU(8925.1,+TIUDA,0)),U,4)'="DOC" Q
 . S TIUSTTS=$P($G(^TIU(8925.1,+TIUDA,0)),U,7)
 . ;VMPELR P 224 allow the update of inactive titles
 . ; Include only TEST or ACTIVE or INACTIVE TITLES
 . I $S(TIUSTTS=10:0,TIUSTTS=11:0,TIUSTTS=13:0,1:1) Q
 . S TIUTTL=$P($G(^TIU(8925.1,+TIUDA,0)),U)
 . Q:TIUTTL']""
 . S X=$$UP^XLFSTR(X)
 . Q:X=TIUTTL
 . S TIUTTL=X_"  <"_TIUTTL_">"
 . ; First build x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)=""
 . S ^TIU(8925.1,"ACL",38,TIUTTL,+TIUDA)=""
 . ; Now build x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)=""
 I FLD=.07 D  Q
 . N TIUDA
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . I $P($G(^TIU(8925.1,+TIUDA,0)),U,4)'="DOC" Q
 . S TIUSTTS=$P($G(^TIU(8925.1,+TIUDA,0)),U,7)
 . ; Include only TEST or ACTIVE titles
 . I $S(TIUSTTS=10:0,TIUSTTS=11:0,1:1) Q
 . S TIUTTL=$P($G(^TIU(8925.1,+TIUDA,0)),U)
 . Q:TIUTTL']""
 . ; First build x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)=""
 . S ^TIU(8925.1,"ACL",38,TIUTTL,+TIUDA)=""
 . D SACLKWIC(TIUTTL,TIUCLASS,+TIUDA)
 . ; Now build x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)=""
 . D SACLKWIC(TIUTTL,TIUCLASS,+TIUDA)
 I FLD=.01 D
 . N TIUDA
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . I $P($G(^TIU(8925.1,+TIUDA,0)),U,4)'="DOC" Q
 . S TIUSTTS=$P($G(^TIU(8925.1,+TIUDA,0)),U,7)
 . ; Include only TEST or ACTIVE OR inactive titles
 . I $S(TIUSTTS=10:0,TIUSTTS=11:0,TIUSTTS=13:0,1:1) Q
 . ; First build x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,X,+TIUDA)=""
 . S ^TIU(8925.1,"ACL",38,X,+TIUDA)=""
 . S TIUABV=$P($G(^TIU(8925.1,+TIUDA,0)),U,2)
 . I TIUABV]"" S TIUABV=TIUABV_"  <"_X_">" S ^TIU(8925.1,"ACL",TIUCLASS,TIUABV,+TIUDA)="",^TIU(8925.1,"ACL",38,TIUABV,+TIUDA)=""
 . S TIUPN=$P($G(^TIU(8925.1,+TIUDA,0)),U,3)
 . I TIUPN]"" S TIUPN=TIUPN_"  <"_X_">" S ^TIU(8925.1,"ACL",TIUCLASS,TIUPN,+TIUDA)="",^TIU(8925.1,"ACL",38,TIUPN,+TIUDA)=""
 . D SACLKWIC(X,TIUCLASS,+TIUDA)
 . ; Now build x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . S ^TIU(8925.1,"ACL",TIUCLASS,X,+TIUDA)=""
 . ;VMP/ELR PATCH 224 ADDED NEXT 4 LINES
 . S TIUABV=$P($G(^TIU(8925.1,+TIUDA,0)),U,2)
 . I TIUABV]"" S TIUABV=TIUABV_"  <"_X_">" S ^TIU(8925.1,"ACL",TIUCLASS,TIUABV,+TIUDA)=""
 . S TIUPN=$P($G(^TIU(8925.1,+TIUDA,0)),U,3)
 . I TIUPN]"" S TIUPN=TIUPN_"  <"_X_">" S ^TIU(8925.1,"ACL",TIUCLASS,TIUPN,+TIUDA)=""
 . D SACLKWIC(X,TIUCLASS,+TIUDA)
 Q
SACLKWIC(X,TIUCLASS,TIUDA) ; Set logic for KWIC analog
 N TIUI,TIUJ,TIUC S TIUI=1
 F TIUJ=1:1:$L(X)+1 D
 . S TIUC=$E(X,TIUJ)
 . I "(,.?! '-/&:;)"[TIUC S TIUC=$E($E(X,TIUI,TIUJ-1),1,30),TIUI=TIUJ+1
 . I  I $L(TIUC)>2,(^DD("KWIC")'[TIUC),(TIUC'=X) S (^TIU(8925.1,"ACL",TIUCLASS,TIUC_"  <"_X_">",TIUDA),^TIU(8925.1,"ACL",38,TIUC_"  <"_X_">",TIUDA))=""
 Q
KACL(X,FLD) ; KILL Logic for ACL cross-reference
 N TIUCLASS,TIUTTL,TIUDA
 I FLD=10.01 D
 . ; First remove x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+X)
 . S TIUTTL=$P($G(^TIU(8925.1,+X,0)),U)
 . Q:TIUTTL']""
 . Q:X=TIUTTL
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+X)
 . K ^TIU(8925.1,"ACL",38,TIUTTL,+X)
 . D KACLKWIC(TIUTTL,TIUCLASS,+X)
 . ; Now remove x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+X)
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+X)
 . D KACLKWIC(TIUTTL,TIUCLASS,+X)
 I $S(FLD=.02:1,FLD=.03:1,1:0) D  Q
 . N TIUDA
 . Q:X']""
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . I $P($G(^TIU(8925.1,+TIUDA,0)),U,4)'="DOC" Q
 . S TIUSTTS=$P($G(^TIU(8925.1,+TIUDA,0)),U,7)
 . ; Include only TEST or ACTIVE or INACTIVE titles
 . I $S(TIUSTTS=10:0,TIUSTTS=11:0,TIUSTTS=13:0,1:1) Q
 . S TIUTTL=$P($G(^TIU(8925.1,+TIUDA,0)),U)
 . Q:TIUTTL']""
 . S TIUTTL=X_"  <"_TIUTTL_">"
 . ; First build x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)
 . K ^TIU(8925.1,"ACL",38,TIUTTL,+TIUDA)
 . ; Now build x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . I TIUCLASS'>0 Q
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)
 I FLD=.07 D
 . N TIUDA
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . ; First remove x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . S TIUTTL=$P($G(^TIU(8925.1,+TIUDA,0)),U)
 . Q:TIUTTL']""
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)
 . K ^TIU(8925.1,"ACL",38,TIUTTL,+TIUDA)
 . D KACLKWIC(TIUTTL,TIUCLASS,+TIUDA)
 . ; Now remove x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . K ^TIU(8925.1,"ACL",TIUCLASS,TIUTTL,+TIUDA)
 . D KACLKWIC(TIUTTL,TIUCLASS,+TIUDA)
 I FLD=.01 D
 . N TIUDA,TIUABV,TIUPN
 . S TIUDA=$S(+$G(DA(1)):+$G(DA(1)),1:+$G(DA))
 . ; First remove x-ref for Clinical Documents & Immediate descendents
 . S TIUCLASS=+$$CLINDOC^TIULC1(+TIUDA)
 . K ^TIU(8925.1,"ACL",TIUCLASS,X,+TIUDA)
 . K ^TIU(8925.1,"ACL",38,X,+TIUDA)
 . S TIUABV=$P($G(^TIU(8925.1,+TIUDA,0)),U,2)
 . I TIUABV]"" S TIUABV=TIUABV_"  <"_X_">" K ^TIU(8925.1,"ACL",TIUCLASS,TIUABV,+TIUDA),^TIU(8925.1,"ACL",38,TIUABV,+TIUDA)
 . S TIUPN=$P($G(^TIU(8925.1,+TIUDA,0)),U,3)
 . I TIUPN]"" S TIUPN=TIUPN_"  <"_X_">" K ^TIU(8925.1,"ACL",TIUCLASS,TIUPN,+TIUDA),^TIU(8925.1,"ACL",38,TIUPN,+TIUDA)
 . D KACLKWIC(X,TIUCLASS,+TIUDA)
 . ; Now remove x-ref for document classes
 . S TIUCLASS=+$$DOCCLASS^TIULC1(+TIUDA)
 . K ^TIU(8925.1,"ACL",TIUCLASS,X,+TIUDA)
 . ;VMP/ELR PATCH 224 ADDED NEXT 4 LINES
 . S TIUABV=$P($G(^TIU(8925.1,+TIUDA,0)),U,2)
 . I TIUABV]"" S TIUABV=TIUABV_"  <"_X_">" K ^TIU(8925.1,"ACL",TIUCLASS,TIUABV,+TIUDA)
 . S TIUPN=$P($G(^TIU(8925.1,+TIUDA,0)),U,3)
 . I TIUPN]"" S TIUPN=TIUPN_"  <"_X_">" K ^TIU(8925.1,"ACL",TIUCLASS,TIUPN,+TIUDA)
 . D KACLKWIC(X,TIUCLASS,+TIUDA)
 Q
KACLKWIC(X,TIUCLASS,TIUDA) ; KILL Logic for KWIC analog
 N TIUI,TIUJ,TIUC S TIUI=1
 F TIUJ=1:1:$L(X)+1 D
 . S TIUC=$E(X,TIUJ)
 . I "(,.?! '-/&:;)"[TIUC S TIUC=$E($E(X,TIUI,TIUJ-1),1,30),TIUI=TIUJ+1
 . I  I $L(TIUC)>2 K ^TIU(8925.1,"ACL",TIUCLASS,TIUC_"  <"_X_">",TIUDA),^TIU(8925.1,"ACL",38,TIUC_"  <"_X_">",TIUDA)
 Q 
