MAGIP239 ;WOIFO/DAC - Install code for MAG*3.0*239 ; Dec 31, 2019@12:47:03
 ;;3.0;IMAGING;**239**;Mar 19, 2002;Build 18
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
 ; There are no environment checks here but the MAGIP239 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 ;--- Link new remote procedure to the MAG DICOM VISA option
 D ADDRPC^MAGQBUT4("MAG GET DICOM FMT PATIENT NAME","MAG DICOM VISA")
 ;--- Fix class index pointers
 D FIXCLASS
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
FIXCLASS ; P239 DAC - Fix clase index pointers in file 2005.63
 N SERIEN,CLASSIDX,CLASSIEN,HIT,FDA
 S SERIEN=0,HIT=0
 D BMES^XPDUTL("Fixing Series Class Indexes")
 F  S SERIEN=$O(^MAGV(2005.63,SERIEN)) Q:'SERIEN  D
 . S CLASSIDX=$P($G(^MAGV(2005.63,SERIEN,10)),U,1)
 . I (CLASSIDX)!(CLASSIDX="") Q
 . S CLASSIEN=$O(^MAG(2005.82,"B",CLASSIDX,""))
 . I CLASSIEN="" Q
 . S FDA(2005.63,SERIEN_",",28)=CLASSIEN
 . D FILE^DIE("","FDA","ERR")
 . K FDA
 D BMES^XPDUTL("Complete.")
 Q
