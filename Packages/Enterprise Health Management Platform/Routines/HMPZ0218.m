HMPZ0218 ;ASMR/JCH - Clinical Procedures failing TIU patch quick fix ;Feb 18, 2015@14:29:52
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Feb 18, 2015;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; temporary fix for Clinical Procedures issue (User Story 5021)
DISABLE ;
 ;
 D BMES^XPDUTL("Disabling INDEX entries for Clinical Procedures "_$$NOW),MES^XPDUTL("routine: "_$T(+0))
 ;
 ; HMPARY - IEN array for INDEX
 ; HMPINDX - target INDEX entry
 N F,G,HMPARY,HMPINDX,I,J,Q,X,Y
 ;
 S Q=$C(34)
 F J=1:1 S HMPINDX=$P($T(INDXLST+J),";;",2,99) Q:HMPINDX=""  D  ; find INDEX file (#.11) entries
 .D MES^XPDUTL("looking for INDEX: "_HMPINDX)
 .N FL,I,NTRY,Y
 .S NTRY=0  ; INDEX enrty IEN
 .S FL=+$P(HMPINDX,U)  ; file #
 .S I=0 F  S I=$O(^DD("IX","B",FL,I)) Q:'I!(NTRY)  D  ; find entry and save it
 ..S Y=$G(^DD("IX",I,0)) S:$P(HMPINDX,U,1,3)=$P(Y,U,1,3) NTRY=I,HMPINDX(FL,I)=Y,HMPINDX(0)=$G(HMPINDX(0))+1
 ;
 I '($G(HMPINDX(0))=1) D  Q  ; must locate both entries, exit if not found
 .D BMES^XPDUTL("Unable to find INDEX file entries"),MES^XPDUTL("exiting routine "_$T(+0)_" "_$$NOW)
 ;
 S F=0 F  S F=$O(HMPINDX(F)) Q:'F  D
 .N GLB,ND,UPDT
 .S I=+$O(HMPINDX(F,0)) Q:'I
 .S GLB=$NA(^DD("IX",I,0)),Y=$G(@GLB) D BMES^XPDUTL("examining "_GLB),MES^XPDUTL("   "_Q_Y_Q)
 .S UPDT=0  ; updated flag, false if index not changed
 .F ND=1,2 D
 ..S Y=$G(^DD("IX",I,ND)),GLB=$NA(^(ND))
 ..D MES^XPDUTL("value found in "_GLB_" was: "),MES^XPDUTL("   "_Q_Y_Q)
 ..I $E(Y)'="Q" S UPDT=1,Y="Q  ;"_Y
 ..S:UPDT @GLB=Y
 ..D MES^XPDUTL($S(UPDT:"updated to "_Q_Y_Q,1:"* NOT CHANGED *"))
 ;
 ;
 D BMES^XPDUTL("INDEX entry completed "_$$NOW)
 ;
 Q
 ;
NOW() ; extrinsic variable, now in external format
 Q $$HTE^XLFDT($H)
 ;
INDXLST ; *S68 - disable of AEVT index on file 8925 removed US5074 
 ;;702^AVPR^Trigger updates to VPR^
 ;
