DGREGDD1 ;ALB/REW/BRM - REGISTRATION PATIENT FILE MUMPS X-REF ; 10/22/02 2:17pm
 ;;5.3;Registration;**454,522**;Aug 13, 1993
 ;
 ; VARIABLES FOR TAGS SZIP,KFIELD:
 ;  INPUT:
 ;       DFN      IEN OF PATIENT FILE  - 1ST PARAMETER (REQUIRED)
 ;       DGFLD:   NEW FIELD# (SET/KILLED BY X-REF)
 ;       DGNODE:  NODE OF NEW FIELD
 ;       DGPIECE: PC # OF NEW FIELD
 ;       X:       STORED VALUE OF NEW FIELD
 ;   USED:
 ;       DGIX:    X-REF#
 ;       DGRGFL1: FLAG TO PREVENT INFINITE LOOP
 ;       DGRGX:   STORED VALUE OF X
 ;
SET(DFN,DGFLD,DGNODE,DGPIECE,X) ; SET NEW FIELD & DO SET X-REFS
 Q:$G(DGRGFL1)!'$G(DGFLD)!'$G(DGPIECE)!($G(X)']"")!($G(DGNODE)']"")
 N DGIX,DGRGFL1,DGRGX
 S DGRGX=X,DGRGFL1=1
 S $P(^DPT(DFN,DGNODE),U,DGPIECE)=DGRGX
 F DGIX=0:0 S DGIX=$O(^DD(2,DGFLD,1,DGIX)) Q:'DGIX  S X=DGRGX X ^(DGIX,1)
 Q
 ;
KILL(DFN,DGFLD,DGNODE,DGPIECE,X) ; KILL OLD FIELD & DO KILL X-REFS
 Q:$G(DGRGFL1)!'$G(DGFLD)!'$G(DGPIECE)!($G(X)']"")!($G(DGNODE)']"")
 N DGIX,DGRGFL1,DGRGX
 S DGRGX=X,DGRGFL1=1
 S $P(^DPT(DFN,DGNODE),U,DGPIECE)=""
 F DGIX=0:0 S DGIX=$O(^DD(2,DGFLD,1,DGIX)) Q:'DGIX  S X=DGRGX X ^(DGIX,2)
 Q
SETMULT(DFN,DFN1,MULTNUM,MULTNODE,DGFLD,DGNODE,DGPIECE,X) ; SET
 ; SETSNEW FIELD & DOES SET X-REFS
 Q:$G(DGRGFL1)!'$G(DGFLD)!'$G(DGPIECE)!($G(X)']"")!($G(DGNODE)']"")!('$G(MULTNUM))!(MULTNODE']"")!('$G(DFN))!($G(DFN1)']"")
 N DGIX,DGRGFL1,DGRGX
 S DGRGX=X,DGRGFL1=1
 S $P(^DPT(DFN,MULTNODE,DFN1,DGNODE),U,DGPIECE)=DGRGX
 F DGIX=0:0 S DGIX=$O(^DD(MULTNUM,DGFLD,1,DGIX)) Q:'DGIX  S X=DGRGX X ^(DGIX,1)
 Q
KILLMULT(DFN,DFN1,MULTNUM,MULTNODE,DGFLD,DGNODE,DGPIECE,X) ; KILL
 ;KILLS OLD FIELD & DOES KILL X-REF
 Q:$G(DGRGFL1)!'$G(DGFLD)!'$G(DGPIECE)!($G(X)']"")!($G(DGNODE)']"")!('$G(MULTNUM))!(MULTNODE']"")!('$G(DFN))!($G(DFN1)']"")
 N DGIX,DGRGFL1,DGRGX
 S DGRGX=X,DGRGFL1=1
 S DGRGX=$P($G(^DPT(DFN,MULTNODE,DFN1,DGNODE)),U,DGPIECE)
 S $P(^DPT(DFN,MULTNODE,DFN1,DGNODE),U,DGPIECE)=""
 F DGIX=0:0 S DGIX=$O(^DD(MULTNUM,DGFLD,1,DGIX)) Q:'DGIX  S X=DGRGX X ^(DGIX,2)
 Q
 ;
ZIP(DA,ZIP,CITY) ; update city, state and county based on zip code change
 ;
 ;   This tag will be used to link the patient's zip code
 ;   with the associated city, state, and county code as
 ;   established by the US Postal Service.  The 'AZIPLINK' and
 ;   'AZIPLNK' new style x-refs on the Patient (#2) file call
 ;   this tag if the Zip+4 (.1112) or Zip Code (.116) fields change.
 ;
 ; Input:
 ;   DA    - Patient File (#2) Patient record DFN
 ;   ZIP - ZIP+4 (.1112) or ZIP CODE (.116) field of the Patient
 ;         File (#2) entry that is being edited
 ;
 ; Output:
 ;   1 - The values in the following fields were updated with the
 ;       USPS data associated with the new zipcode:
 ;          CITY field (.114) of the Patient File (#2)
 ;          STATE field (.115) of the Patient File (#2)
 ;          COUNTY field (.117) of the Patient File (#2)
 ;   0 - the above fields were NOT updated
 ;
 I 'DA!$G(ZIP)="" K EASZIPLK Q 0
 I '$D(EASZIPLK) Q 0
 N EASDATA,FDA,MSG,DGN,CNTYIEN
 S EASDO2=1
 I '$$MLT(ZIP) K EASZIPLK Q 0
 I $$FOREIGN^DGREGAZL() K EASZIPLK Q 0
 D POSTAL^XIPUTIL(ZIP,.EASDATA)
 ; accomodate 15 character limit on the city in the patient file
 ; set FDA array to be filed in the Patient (#2) file
 S CNTYIEN=""
 S:$G(EASDATA("STATE POINTER"))'="" CNTYIEN=$$FIND1^DIC(5.01,","_$G(EASDATA("STATE POINTER"))_",","MOXQ",$E($G(EASDATA("FIPS CODE")),3,5),"C")
 D:'CNTYIEN  ;could be duplicate county codes in subfile #5.01
 .Q:'$D(^DIC(5,+$G(EASDATA("STATE POINTER")),1))
 .Q:$E($G(EASDATA("FIPS CODE")),3,5)=""
 .S CNTYIEN=$O(^DIC(5,$G(EASDATA("STATE POINTER")),1,"C",$E($G(EASDATA("FIPS CODE")),3,5),""))
 S FDA(2,DA_",",.115)=$S(CNTYIEN:$G(EASDATA("STATE POINTER")),1:$G(EASDATA("STATE")))
 S FDA(2,DA_",",.117)=$S(CNTYIEN:CNTYIEN,1:$G(EASDATA("COUNTY")))
 ; file data
 D FILE^DIE($S(CNTYIEN:"",1:"E"),"FDA","MSG")
 K EASZIPLK
 Q '$D(MSG)
KEY(DUZ,DFN) ; determine if a security key is necessary for editing
 ; a patient's state and county fields.  If it is necessary,
 ; determine if this user holds it.
 ;
 ; INPUT:
 ;   DUZ - ien for the #200 file of the user
 ;   DFN - ien of the #2 file for the patient
 ;
 K EASDO2  ;kill zip code linking flag (AZIPLINK and AZIPLNK x-refs)
 Q:'$D(DUZ)!('$D(DFN)) 0
 N ZIP,DGR
 S ZIP=$E($$GET1^DIQ(2,DFN_",",.1112),1,5)
 S DGR=$$ALWEDT(DUZ,ZIP)
 Q DGR
ALWEDT(DUZ,ZIP) ; determine if a security key is necessary for editing
 ; Input: zip code
 ; Output: 1: allow edit state and county
 ;         0: don't allow edit state and county
 N EASDATA
 I $G(ZIP)="" Q 0
 I '$D(DUZ) Q 0
 I '$$MLT(ZIP) Q 1 ; > 1 state or county for the zip - allow edit
 I $$FOREIGN^DGREGAZL() Q 1 ; Foreign location - allow edit
 D POSTAL^XIPUTIL(ZIP,.EASDATA)
 Q:$D(EASDATA("ERROR")) 1  ;zip code does not exist - allow editing
 Q:'$D(EASDATA("FIPS CODE")) 1  ;cnty code does not exist - allow edit
 Q:'$D(EASDATA("STATE")) 1  ;state does not exist - allow editing
 Q:$D(^XUSEC("EAS GMT COUNTY EDIT",+DUZ)) 1  ;user holds security key
 W !,"STATE: ",$G(EASDATA("STATE"))
 W !,"COUNTY: ",$G(EASDATA("COUNTY"))
 Q 0
 ;
MLT(ZIP) ;Determine if a zip correspond to multiple state and\or county
 ;Output: 0: >1 state and\or county for this zip
 ;        1: 1 state and 1 county for this zip
 N DGN,DGFIPS,DGDATA,POP,DGCNTY,DGST
 S (DGN,DGST,DGCNTY,DGFIPS)=""
 S POP=0
 D POSTALB^XIPUTIL(ZIP,.DGDATA)
 I $D(DGDATA("ERROR")) Q 0
 S DGN=$O(DGDATA(DGN))
 S DGFIPS=$G(DGDATA(DGN,"FIPS CODE"))
 F  S DGN=$O(DGDATA(DGN)) Q:(DGN="")!POP  D
 . I $G(DGDATA(DGN,"FIPS CODE"))'=DGFIPS S POP=1 Q
 I POP=1 Q 0
 Q 1
