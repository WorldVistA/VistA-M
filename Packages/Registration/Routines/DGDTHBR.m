DGDTHBR ;OAK/ELZ-MAINTAIN DEATH SOURCE OF NOTIFICATION/DOCUMENT TYPE BUSINESS RULES ;7/26/17
 ;;5.3;Registration;**944**;Aug 13, 1993;Build 2
 ;
 ;**944 - Stories 557804 and 557815 (elz)
 ;  This routine will receive RPC calls from DG DEATH SOURCE/DOC UPDATE.  The updates
 ;  will be sent to all sites from the MPI to allow for dynamic updates to the selectable
 ;  SOURCE OF NOTIFICATIONS and SUPPORTING DOCUMENTS as well as the business rules of which
 ;  ones are allowed in combination
 ;
 ;
BRDATA(RETURN,DGDATA) ; = Entry point from RPC with list of business rules to be updated
 ; DGDATA = Array of business rules to file in the following format:
 ;          IEN of Source of Notification^Active^Supporting Document Type (Type Code)^Active
 ;
 K RETURN
 N DGCOUNT,DGLINE,DGTIEN
 S DGCOUNT=0
 S DGLINE=0 F  S DGLINE=$O(DGDATA(DGLINE)) Q:'DGLINE  S DGDATA=DGDATA(DGLINE) D
 . N DGFDA,DGTYPE,DGIEN,DGROOT
 . S DGTYPE=$O(^DG(47.75,"C",$P(DGDATA,"^",3),0))
 . I 'DGTYPE S RETURN(DGLINE)="-1^Document Type "_$P(DGDATA,"^",2)_" NOT FOUND!!" Q
 . S DGIEN=+DGDATA
 . ; Source of Notifications first
 . I '$D(^DG(47.761,DGIEN)) D
 .. N DGFDA
 .. S DGFDA(1,47.761,"+1,",.01)=DGIEN
 .. S DGFDA(1,47.761,"+1,",.02)=$P(DGDATA,"^",2)
 .. S DGFDA(1,47.761,"+1,",.03)=DT
 .. S DGIEN(1)=DGIEN
 .. D UPDATE^DIE("","DGFDA(1)","DGIEN","DGROOT")
 . E  D
 .. N DGFDA
 .. S DGFDA(47.761,DGIEN_",",.02)=$P(DGDATA,"^",2)
 .. S DGFDA(47.761,DGIEN_",",.03)=DT
 .. D FILE^DIE("","DGFDA","DGROOT")
 . I $D(DGROOT) S RETURN(DGLINE)="-1^ERROR filing Source "_DGDATA_" "_$G(DGROOT("DIERR",1,"TEXT",1)) Q
 . ; Now for associated document type
 . I '$D(^DG(47.761,DGIEN,1,DGTYPE)) D
 .. S DGFDA(1,47.7611,"+1,"_DGIEN_",",.01)=DGTYPE
 .. S DGFDA(1,47.7611,"+1,"_DGIEN_",",.02)=$P(DGDATA,"^",4)
 .. S DGTIEN(1)=DGTYPE
 .. D UPDATE^DIE("","DGFDA(1)","DGTIEN","DGROOT")
 . E  D
 .. N DGFDA
 .. S DGFDA(47.7611,DGTYPE_","_DGIEN_",",.02)=$P(DGDATA,"^",4)
 .. D FILE^DIE("","DGFDA","DGROOT")
 . I $D(DGROOT) S RETURN(DGLINE)="-1^ERROR filing Doc Type "_DGDATA_"." Q
 . S DGCOUNT=DGCOUNT+1
 I '$D(RETURN) S RETURN(1)=DGCOUNT_"^Successfully filed"
 Q
 ;
