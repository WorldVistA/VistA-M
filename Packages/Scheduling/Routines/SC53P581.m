SC53P581 ;ALB/ESW - Patch Install Routine ; 3/29/12 11:20am
 ;;5.3;SCHEDULING;**581**;Aug 13, 1993;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; File # 404.52 print template compilation routine
 N SCTEM,SCTEMP
 M SCTEMP=^DIPT("AF",404.52,.03) ; all fields have the same templates so .03 is used
 S SCTEM=""
 F  S SCTEM=$O(SCTEMP(SCTEM)) Q:SCTEM=""  D
 .N DMAX,X,Y,SCROUT
 .S SCROUT=$G(^DIPT(SCTEM,"ROU")) ;Routine name
 .S X=SCROUT,$E(X)="" ; Remove initial ^.
 .S Y=SCTEM
 .S DMAX=$$ROUSIZE^DILF
 .D EN^DIPZ
 D MES^XPDUTL(" Done.")
 Q
 ;
