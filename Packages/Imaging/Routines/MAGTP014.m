MAGTP014 ;WOIFO/FG - TELEPATHOLOGY RPCS ; 03/28/2012 2:50pm
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q  ;
 ;
 ;***** GET THE TEXT OF A NOTE ATTACHED TO A SPECIFIED CASE
 ; RPC: MAGTP GET NOTE
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LRAC          Accession Code for the case
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Total Number of Lines
 ;
 ; MAGRY(i)     Description
 ;                ^01: Note Line of Text
 ;
GETNOTE(MAGRY,LRAC) ; RPC [MAGTP GET NOTE]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I LRAC="" S MAGRY(0)="0^0^No Accession Code" Q
 N MAGREC,MAGOUT,MAGERR,CT,I
 S MAGREC=$O(^MAG(2005.42,"B",LRAC,""))
 I MAGREC="" S MAGRY(0)="0^0^Invalid Accession Code" Q
 D GET1^DIQ(2005.42,MAGREC_",",3,"","MAGOUT","MAGERR")
 I $D(MAGERR) D  Q
 . S MAGRY(0)="0^0^Access Error: "_MAGERR("DIERR",1,"TEXT",1)
 S (CT,I)=0
 F  S I=$O(MAGOUT(I)) Q:I=""  D
 . S CT=CT+1
 . S MAGRY(CT)=MAGOUT(I)
 . Q
 S MAGRY(0)="1^"_CT
 Q  ;
 ;
 ;***** RECORD THE TEXT OF A NOTE ATTACHED TO A SPECIFIED CASE
 ; RPC: MAGTP PUT NOTE
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; .ENT          Input array. One line of note text must be
 ;               on each line of the array
 ;
 ; LRAC          Accession Code for the case
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: 0
 ;                ^03: "<LRAC> Note Updated"
 ;
PUTNOTE(MAGRY,ENT,LRAC) ; RPC [MAGTP PUT NOTE]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I LRAC="" S MAGRY(0)="0^0^No Accession Code" Q
 N MAGREC,I,LINE,MAGFDA,MAGERR,MAGROOT,NOW,USER
 S MAGREC=$O(^MAG(2005.42,"B",LRAC,""))
 I MAGREC="" S MAGRY(0)="0^0^Invalid Accession Code" Q
 ;Only append no delete(WPR) 
 D  ; enter new text, or clear old text?
 . ;I $D(ENT)<10 S MAGROOT="@" Q  ; clear old text
 . ; enter (override) new text
 . S MAGROOT="MAGFDA",(I,LINE)=""
 . F  S LINE=$O(ENT(LINE)) Q:LINE=""  D
 . . S I=I+1
 . . S MAGFDA(I)=ENT(LINE)        ; FDA arrays cannot start from 0
 . . Q
 . D GETS^DIQ(200,+DUZ,.01,"E","USER") S MAGFDA(I+1)="Added by: "_USER(200,+DUZ_",",.01,"E")
 . S NOW=$$NOW^XLFDT(),MAGFDA(I+2)="      On: "_$$FMTE^XLFDT(NOW) ;DT/TM
 . S MAGFDA(I+3)=" " F LINE=1:1:32 S MAGFDA(I+4)="- "_$G(MAGFDA(I+4))
 . S MAGFDA(I+5)=" "
 . Q
 D WP^DIE(2005.42,MAGREC_",",3,"A",MAGROOT,"MAGERR") ; Whole text killed for WP
 I $D(MAGERR) D  Q
 . S MAGRY(0)="0^0^Updating Error: "_MAGERR("DIERR",1,"TEXT",1)
 S MAGRY(0)="1^0^"_LRAC_" Note "_$S(MAGROOT="MAGFDA":"Updated",MAGROOT="@":"Deleted",1:"Disposition Unknown")
 Q  ;
 ;
 ;***** GET THE RETENTION DAYS OF A UNREAD WORKLIST FROM SITE
 ; RPC: MAGTP GET RETENTION DAYS
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; SITE          Site number (e.g.: 660)
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Total Number of Lines
 ; MAGRY(1)     Description
 ;                ^01: Retention Days
 ;
GETRTDAY(MAGRY,SITE) ; RPC [MAGTP GET RETENTION DAYS]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I $G(SITE)="" S SITE=$G(DUZ(2)) I SITE<1 S MAGRY(0)="0^0^No SITE Info" Q
 N MAGPLACE
 S MAGPLACE=+$O(^MAG(2006.1,"B",SITE,""))
 I MAGPLACE<1 S MAGRY(0)="0^0^No SITE Info ("_SITE_") in #2006.1" Q
 S MAGRY(1)=+$G(^MAG(2006.1,MAGPLACE,"TELEPATH")),MAGRY(0)="1^1"
 Q  ;
 ;
 ;***** SET THE RETENTION DAYS OF A UNREAD WORKLIST FOR SITE
 ; RPC: MAGTP SET RETENTION DAYS
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; DAYS          Read list retention days (0-90)
 ;
 ; SITE          Site number (e.g.: 660)
 ;
 ; Return Values
 ; =============
 ;
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array is as follows:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1   SUCCESS
 ;               
 ;
SETRTDAY(MAGRY,DAYS,SITE) ; RPC [MAGTP SET RETENTION DAYS]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I $G(SITE)="" S SITE=$G(DUZ(2)) I SITE<1 S MAGRY(0)="0^0^No SITE INFO" Q
 I +$G(DAYS)<0 S MAGRY(0)="0^0^Invalide Retention Days ("_$G(DAYS)_")" Q
 N MAGPLACE
 S MAGPLACE=+$O(^MAG(2006.1,"B",SITE,""))
 I MAGPLACE<1 S MAGRY(0)="0^0^No SITE Info ("_SITE_") in #2006.1" Q
 s $P(^MAG(2006.1,MAGPLACE,"TELEPATH"),"^")=DAYS
 S MAGRY(0)="1"
 Q  ;
 ;
