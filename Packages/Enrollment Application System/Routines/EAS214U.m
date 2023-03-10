EAS214U  ;SGU/GJW, - eGate - Uninstall to restore logical link in subscriber protocol ;
 ;;1.0;Enrollments Application System;**214**;2-15-2022;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;
 N EASPNAME,EASIEN,EASIENS,EASDATA,EASERR
 S EASPNAME="EAS EDB ORU-Z09 CLIENT"
 S EASIEN=$$FIND1^DIC(101,,"B",EASPNAME)
 S EASIENS=EASIEN_","
 S EASDATA(101,EASIENS,770.7)=$$GETL()
 D FILE^DIE("EK","EASDATA","EASERR")
 Q
 ;
GETL() ;
 Q $G(^XTMP("EAS214U",1))
 ;
