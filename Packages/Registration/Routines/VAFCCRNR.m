VAFCCRNR ;BIR/JFW-VAFC EHRM MIGRATED FACILITIES FILE (#391.919) Utilities; ; 7/22/19 2:39pm
 ;;5.3;Registration;**981**;Aug 13, 1993;Build 1
 ;
 ;Story 961754 (jfw) - Support processes where there is a need to know
 ;                     which facilities have migrated to CERNER.
 ;DBIA: $$IEN^XUAF4 : Supported - #2171
 Q
 ;
 ;Input: VAFCARY - Array of Station #'s migrated to CERNER (*Required by Ref.)
 ;                 ie. VAFCARY(<Station#>)=""
 ;       VAFCRTN - 1 upon processing completed (*Required by Ref.)
 ;                 Additional Error Info - VAFCRTN(<#>)=Station# ^ Error Code ^ Error Message
UPDT(VAFCARY,VAFCRTN) ;Add/Update EHRM MIGRATED FACILITIES (#391.919) records
 N VAFCSN,VAFCSITE,VAFCRSLT
 ;Remove CERNER ENABLED? Flag if site is no longer using the application
 S VAFCSN=0 F  S VAFCSN=$O(^DGCN(391.919,"ACRNR",VAFCSN)) Q:'+VAFCSN  D
 .D:('($D(VAFCARY(VAFCSN))))
 ..S VAFCRSLT=$$OFFCRNR($$IEN^XUAF4(VAFCSN))
 ..S:(VAFCRSLT'=1) VAFCRTN(VAFCSN)=VAFCRSLT
 ;Add/Update Facility entries that have migrated to CERNER if applicable
 S VAFCSN=0 F  S VAFCSN=$O(VAFCARY(VAFCSN)) Q:'+VAFCSN  D
 .D:('($D(^DGCN(391.919,"ACRNR",VAFCSN))))
 ..S VAFCRSLT=$$ONCRNR($$IEN^XUAF4(VAFCSN))
 ..S:(VAFCRSLT'=1) VAFCRTN(VAFCSN)=VAFCSN_"^"_VAFCRSLT
 S VAFCRTN=1
 Q
 ;
 ;Input: VAFCSIEN - IEN of the Facility to Add/Update
 ;Output: 1 if Successful or ErrorCode ^ Error Message
ONCRNR(VAFCSIEN) ;Update EHRM MIGRATED FACILITIES (#391.919) entry to show site migrated to CERNER
 N VAFCFDA,VAFCEMSG,VAFCEXST,VAFCFIEN
 Q:(VAFCSIEN="") "^IEN for Station Number is NOT known!"
 S VAFCEXST=$D(^DGCN(391.919,"B",VAFCSIEN))
 ;Add new facility entry to the file
 D:('VAFCEXST)
 .S VAFCFDA(391.919,"+1,",.01)=VAFCSIEN
 .S VAFCFDA(391.919,"+1,",.02)=1
 .S VAFCFIEN(1)=VAFCSIEN  ;.01 is DINUMED to Site IEN.
 .D UPDATE^DIE("","VAFCFDA","VAFCFIEN","VAFCEMSG")
 ;Updating existing facility entry in the file
 D:(VAFCEXST)
 .S VAFCFDA(391.919,VAFCSIEN_",",.02)=1
 .D FILE^DIE("K","VAFCFDA","VAFCEMSG")
 Q $S('$D(VAFCEMSG):1,1:$G(VAFCEMSG("DIERR",1))_"^"_$G(VAFCEMSG("DIERR",1,"TEXT",1)))
 ;
 ;Input: VAFCSIEN - IEN of the Facility to Update
 ;Output: 1 if Successful or ErrorCode ^ Error Message
OFFCRNR(VAFCSIEN) ;Set CERNER ENABLED? field to NO for Site
 N VAFCFDA,VAFCEMSG
 Q:(VAFCSIEN="") "^IEN for Station Number is NOT known!"
 S VAFCFDA(391.919,VAFCSIEN_",",.02)=0
 D FILE^DIE("K","VAFCFDA","VAFCEMSG")
 Q $S('$D(VAFCEMSG):1,1:$G(VAFCEMSG("DIERR",1))_"^"_$G(VAFCEMSG("DIERR",1,"TEXT",1)))
