TIUCPCL ; SLC/RMO - Clinical Procedure Class Action Entry Points ; 7-MAR-2001 15:20:41
 ;;1.0;TEXT INTEGRATION UTILITIES;**109**;Jun 20, 1997
 ;
POST(TIUDA,STATUS) ;Executed when the document is "committed" to the
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           STATUS   TIU Status file (#8925.6) Name field (#.01)
 ; Output -- None
 ;database (i.e., when the document is saved, and prior to release,
 ;verification or signature) or "post-signature" (i.e., following
 ;signature or co-signature).
 ;
 ;Invoke TIU API for Consult Tracking
 D POST^TIUCNSLT(TIUDA,STATUS)
 ;
 ;If Clinical Procedures is installed, invoke Clinical Procedures API
 I $$VERSION^XPDUTL("CLINICAL PROCEDURES"),$$TIUCOMP^MDAPI(TIUDA)
 Q
 ;
CHANGE(TIUDA) ;Executed when a document with a link to a client application
 ;is reassigned.
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- None
 ;
 ;Invoke TIU API for Consult Tracking
 D CHANGE^TIUCNSLT(TIUDA,1)
 Q
 ;
ROLLBACK(TIUDA) ;Executed upon deletion of a document.
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- None
 ;
 ;Invoke TIU API for Consult Tracking
 D ROLLBACK^TIUCNSLT(TIUDA)
 ;
 ;If Clinical Procedures is installed, invoke Clinical Procedures API
 I $$VERSION^XPDUTL("CLINICAL PROCEDURES"),$$TIUDEL^MDAPI(TIUDA)
 Q
