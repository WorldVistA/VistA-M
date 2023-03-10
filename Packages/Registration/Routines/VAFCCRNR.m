VAFCCRNR ;BIR/JFW-VAFC EHRM MIGRATED FACILITIES FILE (#391.919) Utilities ;2/22/22  13:55
 ;;5.3;Registration;**981,1050,1071**;Aug 13, 1993;Build 4
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
 ;
CRNRSITE(VAFCSTNUM) ;is site cerner enabled ;**1050, VAMPI-10038 (dri)
 ;Input:
 ;  VAFCSTNUM - station number to check
 ;
 ;Output;
 ;  0 - not cerner enabled
 ;  1 - cerner enabled
 ;
 I $G(VAFCSTNUM)'="",$O(^DGCN(391.919,"ACRNR",VAFCSTNUM,0)) Q 1
 Q 0
 ;
GCRNSITE() ;Return the CERNER Station Number configured for this VistA Instance
 ;**1071 VAMPI-13671 (dri) new api for VistA consumers needed due to cerner cert/mock accounts
 N CRNIEN,CRNSITE
 S CRNIEN=$O(^MPIF(984.8,"B","FOUR",0)) I CRNIEN S CRNSITE=$P($G(^MPIF(984.8,CRNIEN,0)),"^",5)
 I $G(CRNSITE)="" S CRNSITE="200CRNR"
 Q CRNSITE
 ;
ISCRNPAT(DGDFN) ;Is this a Cerner patient (i.e., is 200CRNR in the TFL)?
 ;**1071 VAMPI-13671 (dri) new api for VistA consumers needed due to cerner cert/mock accounts
 ;Input:
 ;  DGDFN - pointer to PATIENT (#2) file
 ;
 ;Return:
 ;  1 - yes, 0 - no
 ;
 N DGRES,DGOUT,DGSITE,DGKEY,DGI
 S DGRES=0
 S DGSITE=$P($$SITE^VASITE,U,3)
 S DGKEY=DGDFN_U_"PI"_U_"USVHA"_U_DGSITE
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 S DGI=0 F  S DGI=$O(DGOUT(DGI)) Q:DGI=""  I $P(DGOUT(DGI),U,4)=$$GCRNSITE(),$P(DGOUT(DGI),U,2)="PI" S DGRES=1 Q
 Q DGRES
 ;
