ORP351 ;BP/SMT Post init OR*3*351 ;7/06/11 11:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**351**;Jul 06, 2011;Build 4
 ;
 ; This routine will clear the CL x-ref and rebuild it.
 ;
 Q
EN ;
 N DIK
 I $D(^ORAM(103,"CL")) D  ;Lets check that values in the X-ref exist before rebuilding.
 . S DIK="^ORAM(103,",DIK(1)="101^CL"
 . D ENALL2^DIK ;Kill CL X-ref to clean up danglers
 . D ENALL^DIK ;Rebuild CL X-ref.
 Q
