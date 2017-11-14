MAGIP186 ;WOIFO/JSL,DAC,GEK - INSTALL CODE FOR MAG*3.0*186 BP FIX; 27 Jul 2017  9:23 AM
 ;;3.0;IMAGING;**186**;Mar 19, 2002;Build 23
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
 ; There are no environment checks here but the MAGIP186 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 ;
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
POST ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 I $G(DUZ)<.5 S XPDABORT=1 Q
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 ;
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 ;
QCLN ;;CLEAN "D" X-REF of BP MAGQUEUE #2006.03 
 N LOC,QTYP,STG,QIEN,NO,MAX,LNT,BADCT,BADTCT
 S LOC=0,BADTCT=0
 W !,"Removing bad references from IMAGE BACKGROUND QUEUE (2006.03)"
 F NO=1:1 S LOC=$O(^MAGQUEUE(2006.03,"D",LOC)) Q:'LOC  I $D(^MAG(2006.1,LOC)) W !!,"Location(PLACE) = '",LOC,"'  ",$P($G(^MAG(2006.1,LOC,0)),"^",9) D 
 . S QTYP="A" 
 . F  S QTYP=$O(^MAGQUEUE(2006.03,"D",LOC,QTYP)) Q:QTYP=""  W !!,"Queue = '",QTYP,"'" D
 .. S STG="" 
 .. F  S STG=$O(^MAGQUEUE(2006.03,"D",LOC,QTYP,STG)) Q:STG=""  W !,?4,"Category = '",STG,"'" D
 ... S QIEN=0,BADCT=0
 ... F MAX=1:1:1000000 S QIEN=$O(^MAGQUEUE(2006.03,"D",LOC,QTYP,STG,QIEN)) Q:'QIEN  I '$D(^MAGQUEUE(2006.03,QIEN,0)) D
 .... W "*",QIEN S BADCT=BADCT+1 K ^MAGQUEUE(2006.03,"D",LOC,QTYP,STG,QIEN)
 .... F LNT=1:1:$L(QIEN)+1 W $C(8)
 ... I 'BADCT W !,?4,BADCT," bad references."
 ... I BADCT S BADTCT=BADTCT+BADCT W !,?4,BADCT," bad references removed."
 ... Q
 .. Q
 . Q
 W !!,"Processing is complete."
 I 'BADTCT W "  0 bad references."
 I BADTCT W "  Total of ",BADTCT," bad references removed."
 Q
 ;
 ;****
 QUIT
