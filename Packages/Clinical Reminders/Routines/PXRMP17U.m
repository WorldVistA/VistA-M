PXRMP17U ;SLC/DAN - Undo updates from patch 17 ;2/1/10  12:54
 ;;2.0;CLINICAL REMINDERS;**17**;Feb 04, 2005;Build 102
 ;
ALLERGY ;Reset computed finding parameter for new version of VA-ALLERGY
 ;computed finding.
 N CFIEN,CFPARAM,IEN,FINDING
 S CFIEN=$O(^PXRMD(811.4,"B","VA-ALLERGY",""))
 I CFIEN="" Q
 K ^TMP($J,"LIST")
 D BLDLIST^PXRMFRPT(811.4,"PXRMD(811.4,",CFIEN,"LIST")
 ;Process definitions
 S IEN=""
 F  S IEN=$O(^TMP($J,"LIST",811.4,CFIEN,"DEF",IEN)) Q:IEN=""  D
 . S FINDING=""
 . F  S FINDING=$O(^TMP($J,"LIST",811.4,CFIEN,"DEF",IEN,FINDING)) Q:FINDING=""  D
 .. S CFPARAM=$G(^PXD(811.9,IEN,20,FINDING,15)) Q:$L(CFPARAM,":")=2  ;already converted if equal to 2
 .. S ^PXD(811.9,IEN,20,FINDING,15)=$P(CFPARAM,":",1,2) ;use only first two parameters
 ;Process terms
 S IEN=""
 F  S IEN=$O(^TMP($J,"LIST",811.4,CFIEN,"TERM",IEN)) Q:IEN=""  D
 . S FINDING=""
 . F  S FINDING=$O(^TMP($J,"LIST",811.4,CFIEN,"TERM",IEN,FINDING)) Q:FINDING=""  D
 .. S CFPARAM=$G(^PXRMD(811.5,IEN,20,FINDING,15)) Q:$L(CFPARAM,":")=2  ;already converted if equal to 2
 .. S ^PXRMD(811.5,IEN,20,FINDING,15)=$P(CFPARAM,":",1,2) ;use only first two parameters
 K ^TMP($J,"LIST")
 Q
 ;
