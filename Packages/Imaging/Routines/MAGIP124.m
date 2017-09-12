MAGIP124 ;WOIFO/BT - INSTALL CODE FOR MAG*3.0*124 ; 11/07/12 10:01am
 ;;3.0;IMAGING;**124**;Mar 19, 2002;Build 143;Nov 14, 2012
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
 ;
 ; There are no environment checks here but the MAGIP124 has to be
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
 ;Find VBAREASN in MAG REASON FILE
 N REASNIEN S REASNIEN=$$FIND1^DIC(2005.88,,"BX",$$VBAREASN)
 ;
 N OK
 ;If reason exists, update reason type if it doesn't have 'C' and/or 'P' access
 I REASNIEN S OK=$$UPDREASN(REASNIEN)
 ;If reason doesn't exist, add reason
 I 'REASNIEN S OK=$$ADDREASN
 I 'OK D ERROR Q
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
UPDREASN(REASNIEN) ;update reason type if it doesn't have 'C' and/or 'P' access
 N REASNTYP S REASNTYP=$$GET1^DIQ(2005.88,REASNIEN_",",.02)
 N TYPFOUND S TYPFOUND=(REASNTYP["P")&(REASNTYP["C")
 Q:TYPFOUND 1 ;TYPE contains 'P' and 'C' already, no update requires
 ;
 I REASNTYP'["P" S REASNTYP="P"_REASNTYP ;Add print image access
 I REASNTYP'["C" S REASNTYP="C"_REASNTYP ;Add copy image access
 ;
 N ERR,FDA
 S FDA(2005.88,REASNIEN_",",.02)=REASNTYP ;update reason type
 D FILE^DIE("","FDA","ERR")
 Q '$D(ERR)
 ;
ADDREASN() ;add reason
 N ERR,FDA,IENROOT
 N REASON S REASON=$$VBAREASN
 S FDA(2005.88,"+1,",.01)=REASON
 S FDA(2005.88,"+1,",.02)="CP"
 ;use the last ien + 1 (potentially the next ien) for a place holder
 ;since field .04 (CODE) is a required field
 S FDA(2005.88,"+1,",.04)=$P($G(^MAG(2005.88,0)),U,3)+1
 D UPDATE^DIE("","FDA","IENROOT","ERR")
 Q:$D(ERR) 0
 K FDA
 ;
 ;Update field .04 with the IEN
 S FDA(2005.88,IENROOT(1)_",",.04)=IENROOT(1)
 D FILE^DIE("","FDA","ERR")
 ;
 Q '$D(ERR)
 ;
VBAREASN() ;
 Q "For use in Veterans Benefits Administration claims processing."
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
