IBTRH5H ;ALB/FA - HCSR Create 278 Request ;14-OCT-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; DXTYPE   - Dictionary Screen function for Diagnosis Type field 356.223/.01
 ; HCSDFC   - Dictionary Screen function for Health Care Services Delivery
 ;            Frequency Code fields 4.07 2216/5.07
 ; HCSDQQ   - Dictionary Screen function for Health Care Services Delivery
 ;            Quantity Qualifier fields 4.01, 2216/5.01
 ; JUMPERR  - Displays an error message if the user tried to ^Field jump from
 ;            a Section or Quick View prompt
 ; NHOME    - Nursing home filter for Service line field 2216/2.08
 ; ONEPD    - Used to auto-file the first Provider Data file for facility
 ; PROVTYPE - Dictionary Screen function for Provider Type field 356.2213/.01
 ; SPROVTYP - Dictionary Screen function for Provider Type field 356.22168/.01
 ; UNITS    - Dictionary Screen function for field 356.2216/1.1
 ;-----------------------------------------------------------------------------
 ;
NHOME() ;EP
 ; Screen for the 'Nursing Home Residential Status' Dictionary field (356.2216/2.08)
 ; to exclude 'DA' for a Professional Service Line and 'MJ' for an Institutional
 ; Service Line. Always exclude 'F2"
 ; Input: DA(1)     - IEN of the 356.22 entry being edited
 ;        DA        - IEN of the Service Line multiple being edited
 ;        Y         - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 I Y=9 Q 0  ; Other not allowed for Service line
 Q 1
 ;
UNITS() ;EP
 ; Screen for the 'Unit or Basis For Measurement' Dictionary field (356.2216/1.1)
 ; to exclude 'DA' for a Professional Service Line and 'MJ' for an Institutional
 ; Service Line. Always exclude 'F2"
 ; Input: DA(1)     - IEN of the 356.22 entry being edited
 ;        DA        - IEN of the Service Line multiple being edited
 ;        Y         - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N SLTYPE
 S SLTYPE=$$GET1^DIQ(356.2216,DA_","_DA(1)_",",1.12,"I")
 I SLTYPE="P",Y="DA" Q 0
 I SLTYPE="I",Y="MJ" Q 0
 Q 1
 ;
JUMPERR(INDENT)   ;EP
 ; Input:   INDENT  - # of spaces to indent
 ;                    Optional, defaults to 0
 N SPACES
 S:'$D(INDENT) INDENT=0
 S SPACES=$J("",80)
 W !,*7,$S(INDENT:$J(SPACES,INDENT),1:"")
 W "^Field jumping is not allowed from this prompt",!
 Q
 ;
ONEPD(IBTRIEN) ;EP
 ; Called from Input Template: IB ADD/EDIT 278
 ; Attempts to an Attending Physician Provider Data multiple into 356.22 for
 ; entries with a Inpatient/Outpatient Status of 'I'
 ; Only called if there are currently no Provider Data multiples
 ; Input:   IBTRIEN - IEN of the selected entry
 ; Output:  Attending Physician Provider Data multiple is filed into 356.2213
 ;          (Potentially)
 ; Returns: 1 if one or more lines were added, 0 otherwise
 N DFN,EVDT,FDA,IEN,PROV
 Q:$D(^IBT(356.22,IBTRIEN,13)) 0
 ;
 Q:$$GET1^DIQ(356.22,IBTRIEN_",",.04,"I")="O" 1 ; Entry is for an appointment
 S DFN=$$GET1^DIQ(356.22,IBTRIEN_",",.02,"I")   ; Patient DFN
 S EVDT=$$GET1^DIQ(356.22,IBTRIEN_",",.07,"I")  ; Patient Event Date
 S PROV=$$ADMDFN(EVDT,DFN)
 Q:PROV="" 0
 ;
 ; File Attending Physician Data Multiple
 S PROV=PROV_";VA(200,"
 K FDA
 S FDA(356.2213,"+1,"_IBTRIEN_",",.01)=19       ; 'Attending Phys' Prov Type
 S FDA(356.2213,"+1,"_IBTRIEN_",",.02)=1        ; Person
 S FDA(356.2213,"+1,"_IBTRIEN_",",.03)=PROV     ; Provider IEN
 D UPDATE^DIE("","FDA")
 Q 1
 ;
ADMDFN(EVDT,DFN) ; Checks to see if the specified event date is for
 ; an admission, a scheduled admission or neither
 ; Input:   EVDT    - Fileman date/time of the admission being searched for
 ;          DFN     - IEN of the patient of the admission being searched for
 ; Returns: IEN of the found Attending Physician or "" if not found
 N FOUND,PROV,TDFN,VAIN,VAINDT,XX
 ;
 S XX=$$NOW^XLFDT(),FOUND=0,PROV=""
 ;
 ; Direct admission check
 I EVDT'>XX D  Q PROV
 . S VAINDT=EVDT
 . D INP^VADPT
 . S PROV=$P($G(VAIN(11)),"^",1)
 ;
 ; Next check for a scheduled admission
 S IEN=""
 F  D  Q:FOUND!(IEN="")
 . S IEN=$O(^DGS(41.1,"C",EVDT,IEN))            ; DBIA429
 . Q:IEN=""
 . S:$P($G(^DGS(41.1,IEN,0)),"^",1)=DFN FOUND=1
 S:FOUND PROV=$$GET1^DIQ(41.1,IEN_",",5,"I")
 Q PROV
 Q ""
 ;
DXTYPE() ;EP
 ; Called from within Input template IB ADD/EDIT 278
 ; Screens Diagnosis Type values based upon the Diagnosis multiple being 
 ; added/edit 
 ; Called from field: 356.223/.01
 ; Input:   DA(1)   - IEN of the 356.22 entry being edited
 ;          DA      - IEN of the diagnosis multiple being edited
 ;          Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CNT,DTDIFF,ICDDT,IX,RETURN,WHICH
 ;
 S ICDDT=3151001 ; ICD-9 cut-off date
 S DTDIFF=$$FMDIFF^XLFDT(DT,ICDDT)
 I DTDIFF<0,Y<5 Q 0  ; date is prior to cut-off, only ICD-9 is allowed
 I DTDIFF'<0,Y>4,Y<9 Q 0  ; date is not prior to cut-off, only ICD-10 is allowed
 ;
 I Y=10 Q $S($P($G(^IBT(356.22,DA(1),0)),"^",20)=2:1,1:0)  ; LOI diagnosis codes are not allowed
 ; Determine which multiple is being added/edited
 S WHICH=""
 I '$D(^IBT(356.22,DA(1),3,DA)) D               ; New multiple being created
 . S WHICH=$P($G(^IBT(356.22,DA(1),3,0)),"^",3)+1
 I WHICH="" D                                   ; Existing multiple being edited
 . S IX=0,CNT=0
 . F  D  Q:(+IX=0)!(IX=DA)
 . . S IX=$O(^IBT(356.22,DA(1),3,IX))
 . . Q:+IX=0
 . . S CNT=CNT+1
 . . I IX=DA S WHICH=CNT Q                      ; Skip multiple being edited
 I WHICH=1 Q 1                                  ; All entries allowed
 I WHICH=2 D  Q RETURN                          ; 2nd multiple
 . I (Y=3)!(Y=7) S RETURN=0 Q
 . S RETURN=1
 ;
 ; 3rd-12th multiple
 I (Y=3)!(Y=7)!(Y=2)!(Y=6) Q 0
 Q 1
 ;
HCSDFC() ;EP
 ; Called from within Input template IB ADD/EDIT 278
 ; Dictionary Screen for Health Care Services Delivery Frequency Code
 ; fields 4.07, 2216/5.07
 ; Input:   Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 ;
 ; Check for invalid Frequency Code
 N IEN
 S IEN=$O(^IBE(365.025,"B","WE",""))
 I Y=IEN Q 0
 Q 1
 ;
HCSDQQ() ;EP
 ; Called from within Input template IB ADD/EDIT 278
 ; Dictionary Screen for Health Care Services Delivery Quantity Qualifier
 ; fields 4.01, 2216/5.01
 ; Input:   Y       - Internal Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 N CDE,IEN,IENS
 ;
 ; First Get all of IENS that we want to display
 F CDE="DY","FL","HS","MN","VS" D
 . S IEN=$O(^IBE(365.016,"B",CDE,""))
 . S:IEN'="" IENS(IEN)=""
 Q:'$D(IENS(Y)) 0
 Q 1
 ;
PROVTYPE() ;EP
 ; Called from within Input template IB ADD/EDIT 278
 ; Dictionary Screen for allowable Provider Types.
 ; Called from field screens 356.2213/.01
 ; NOTE: Duplicate entries are allowed
 ; Input:   X - External Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 ;
 N CDE,IENS
 ; Check external values that are not allowed for 278
 F CDE=13,36,"1I","1P","1T","2B","DQ","GP","GW","I3","IL","L5","LR","OC","P4","P5","PR","PRP","SEP","TTP","VER","VN","X3","Y2" D
 . S IENS(CDE)=""
 Q:$D(IENS(X)) 0
 Q 1
 ;
SPROVTYP() ;EP
 ; Called from within Input template IB ADD/EDIT 278
 ; Dictionary Screen for allowable Provider Types for Service Lines.
 ; Called from field screens 356.22168/.01
 ; NOTE: Duplicate entries are allowed
 ; Input:   X       - External Value of the user response
 ; Returns: 1 - Data input by the user is valid, 0 otherwise
 ;
 N CDE,IENS
 ; Check external values for service line 278
 F CDE=13,36,71,"1I","1P","2B","AAJ","DN","GP","GW","I3","IL","L5","LR","OC","P4","P5","PR","PRP","SEP","TTP","VER","VN","X3","Y2" D
 . S IENS(CDE)=""
 Q:$D(IENS(X)) 0
 Q 1
