VPSALL01 ;DALOI/KML - Retrieve Allergies for Vetlink ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Oct 21, 2011;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ; ICR 3449 - Controlled Subscription for read of ADVERSE REACTION ASSESSMENT file (120.86)
 ; ICR 5843 - Controlled Subscription for read of PATIENT ALLERGIES file (120.8)
 ;
GET(VPSRES,VPSDFN) ;
 ;RPC = VPS GET ALLERGIES
 ; Return allergies for patient VPSDFN
 ; 
 ; INPUT  - VPSRES - 1st parameter required by RPC Broker; represents output
 ;          VPSDFN - IEN of PATIENT file
 ;
 ; OUTPUT - VPSRES - returns results of procedure which is the data taken from the entry in file 120.8
 ;
 K VPSRES,ALST
 I '+$G(VPSDFN) S VPSRES(0)="99^PATIENT DFN not sent" Q
 I '$D(^DPT(VPSDFN)) S VPSRES(0)="99^PATIENT not in VistA database" Q
 N VPSRA S VPSRA=$$GET1^DIQ(120.86,VPSDFN,1,"I")
 I 'VPSRA S VPSRES(0)="0^NO ALLERGIES OR NO ASSESSMENT" Q
 N VDA,VIEN,VIENS,DDFLDS,VCTR
 S (VDA,VIEN)=0
 S VCTR=1
 D TABLE(.DDFLDS)
 F  S VDA=$O(^GMR(120.8,"B",VPSDFN,VDA)) Q:'VDA  D
 . D GETS^DIQ(120.8,VDA_",",".01;.02;1;4;5;22;23;24","IE","ALST")
 . S VIENS=VDA_","
 . D BLDRES(120.8,VIENS,.ALST,.DDFLDS,.VCTR,.VPSRES)
 . S VIEN=0
 . F  S VIEN=$O(^GMR(120.8,VDA,10,VIEN)) Q:'VIEN  D
 . . S VIENS=VIEN_","_VDA_","
 . . D GETS^DIQ(120.81,VIENS,".01;1","IE","ALST")
 . . D BLDRES(120.81,VIENS,.ALST,.DDFLDS,.VCTR,.VPSRES)
 . S VIEN=0
 . F  S VIEN=$O(^GMR(120.8,VDA,26,VIEN)) Q:'VIEN  D
 . . S VIENS=VIEN_","_VDA_","
 . . D GETS^DIQ(120.826,VIENS,".01;1;1.5;2","IE","ALST")
 . . D BLDRES(120.826,VIENS,.ALST,.DDFLDS,.VCTR,.VPSRES)
 I '$D(VPSRES) S VPSRES(0)="0^NO ALLERGIES FOR THIS PATIENT" Q
 Q
 ;
BLDRES(VFL,IENS,ALST,DDFLDS,CTR,RESULTS) ;
 ; build allergy results array that gets returned to client
 ; the results consist of allergy data taken from the entry at 120.8 and associated multiples (sub-entries)
 ; 
 ; INPUT
 ;   VFL     - file number
 ;   IENS    - internal entry numbers for top entries and any sub-entries
 ;   ALST    - contains the data taken from the fields existing at the entry and sub-entries of 120.8 (built from GETS^DIQ)
 ;   DDFLDS  - array of fields defined in 120.8
 ;   CTR     - Sequential numeric value that is assigned as the subscript to the local results array, passed in by reference
 ;   RESULTS - passed in by reference
 ;   
 ; OUTPUT
 ;   RESULTS - array of patient allergies taken from specified fields in the patient entry in 120.8
 ;   Each subscript in the array is assigned a composite, delimited string as described in the next comment:
 ;   RESULTS(ctr)="file name^iens (top file, subfile)^field number^field name^data value"
 ;
 N I,Y,VFLD,VSTR,VINEX,VFNAME,N,TRMIEN
 S VFLD=0
 F  S VFLD=$O(ALST(VFL,IENS,VFLD)) Q:'VFLD  D
 . S TRMIEN=$S($P(IENS,",",2)']"":$P(IENS,","),$P(IENS,",",3)']"":$P(IENS,",",1,2),1:IENS)
 . S VSTR=DDFLDS(VFL,VFLD)
 . S VINEX=$P(DDFLDS(VFL,VFLD),U,2)  ; internal or external value
 . S VFNAME=$P(DDFLDS(VFL,VFLD),U)  ; field name
 . I VINEX="IE" D  Q  ; for fields that need to return both internal and external values
 . . F I="I","E" Q:ALST(VFL,IENS,VFLD,I)']""  S Y=$S(I="I":" IEN",1:" NAME"),RESULTS(CTR)=VFL_U_TRMIEN_U_VFLD_U_VFNAME_Y_U_ALST(VFL,IENS,VFLD,I),CTR=CTR+1
 . I VINEX="WP" D  Q  ; word processing field (comments)
  . . S N=0 F  S N=$O(ALST(VFL,IENS,VFLD,N)) Q:'N  Q:ALST(VFL,IENS,VFLD,N)']""  S RESULTS(CTR)=VFL_U_TRMIEN_U_VFLD_U_VFNAME_U_ALST(VFL,IENS,VFLD,N),CTR=CTR+1
 . Q:ALST(VFL,IENS,VFLD,VINEX)']""
 . S RESULTS(CTR)=VFL_U_TRMIEN_U_VFLD_U_VFNAME_U_ALST(VFL,IENS,VFLD,VINEX)
 . S CTR=CTR+1
 Q
 ;
TABLE(DEFS) ;the DD field array built at this procedure will be used when constructing the allergy results array
 ;input/output - DEFS passed in by reference
 ; example of what gets built:
 ; DEFS(120.8,.01)="PATIENT^I"
 ; DEFS(120.8,.02)="REACTANT^E"
 ; DEFS(120.8,1)="GMR ALLERGY^I"
 N LN,LINE,STRING
 F LN=3:1 S LINE=$T(AFLDS+LN),STRING=$P(LINE,";;",2) Q:STRING=""  S DEFS($P(STRING,U,1),$P(STRING,U,2))=$P(STRING,U,3)_U_$P(STRING,U,4)
 Q
AFLDS ; valid fields defined in the PATIENT ALLERGIES file (120.8)
 ; negotiated fields to be given to kiosk for MRAR event or for the purposes of tiu note during PDO invocable period 
 ;;FILE NUMBER^FIELD NUMBER^FIELD NAME^INTERNAL/EXTERNAL VALUE
 ;;120.8^.01^PATIENT^I^
 ;;120.8^.02^REACTANT^E
 ;;120.8^1^GMR ALLERGY^I
 ;;120.8^4^ORIGINATION DATE/TIME^I
 ;;120.8^5^ORIGINATOR^E
 ;;120.8^22^ENTERED IN ERROR^E
 ;;120.8^23^DATE/TIME ENTERED IN ERROR^I
 ;;120.8^24^USER ENTERING IN ERROR^E
 ;;120.81^.01^REACTION^IE
 ;;120.81^1^OTHER REACTION^E
 ;;120.826^.01^DATE/TIME COMMENT ENTERED^I
 ;;120.826^1^USER ENTERING^E
 ;;120.826^1.5^COMMENT TYPE^E
 ;;120.826^2^COMMENTS^WP
