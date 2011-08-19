TIUPXAP3 ;SLC/RMO - Link Document to Visit API ;10/24/03@1000
 ;;1.0;TEXT INTEGRATION UTILITIES;**179**;Jun 20, 1997
 ;
LNKVST(TIUDA,TIUVSIT) ;Entry point to link a document to an existing visit
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- 1=Successful and 0=Failure
 ;           TIUVSIT  Visit file (#9000010) IEN
 N OKF,TIUMVSTF
 ;
 ;Check if document needs to be linked to a visit
 I $D(^TIU(8925,TIUDA,0)),$P(^(0),U,3)'>0 D
 . ;Get existing visit to associate with document
 . D GETVST(TIUDA,.TIUVSIT,.TIUMVSTF)
 . ;If only one visit update the document with the visit
 . I $G(TIUVSIT)>0,'$G(TIUMVSTF) D
 . . I $$UPDVST^TIUPXAP2(TIUDA,TIUVSIT) S OKF=1
 Q +$G(OKF)
 ;
GETVST(TIUDA,TIUVSIT,TIUMVSTF) ;Get visit to associate with document
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- TIUVSIT  Visit file (#9000010) IEN
 ;           TIUMVSTF Multiple Visit Flag
 ;                    1=Multiple Visits
 ;
 N TIUD0,TIUDFN,TIUEDT,TIUHL,TIUVSITS,TIUVSTR
 ;
 ;Set variables
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S TIUDFN=$P(TIUD0,U,2),TIUEDT=$P(TIUD0,U,7)
 S TIUHL=$P($G(^TIU(8925,TIUDA,12)),U,11)
 S TIUVSTR=TIUHL_";"_TIUEDT_";"_$P(TIUD0,U,13)
 ;
 ;Check if document is an addendum, if it is use visit of parent
 I +$$ISADDNDM^TIULC1(TIUDA) D  G GETVSTQ
 . I $D(^TIU(8925,+$P(TIUD0,U,6),0)),$P(^(0),U,3)>0 S TIUVSIT=$P(^(0),U,3)
 ;
 ;Check if a document has already been entered for the Vstring,
 ;if it has use the visit in the AVSTRV cross-reference
 I +$G(TIUVSTR),+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))>0 D  G GETVSTQ:$G(TIUVSIT)>0
 . S TIUVSIT=+$O(^TIU(8925,"AVSTRV",+TIUDFN,TIUVSTR,0))
 . I $P($G(^AUPNVSIT(+TIUVSIT,0)),U,5)'=TIUDFN S TIUVSIT=""
 ;
 ;Check PCE for a visit
 S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUEDT,TIUHL)
 I TIUVSITS>0 S TIUVSIT=+TIUVSITS
 ;
 ;Set a flag if multiple visits
 I $P(TIUVSITS,U,2)'="" S TIUMVSTF=1
GETVSTQ K ^TMP("PXKENC",$J)
 Q
