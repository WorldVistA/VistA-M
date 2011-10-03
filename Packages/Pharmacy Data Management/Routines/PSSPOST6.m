PSSPOST6 ;BHAM ISC/MR - Master File Update for Non-VA Med Flag ; 03/19/02
 ;;7.0;OUTPATIENT PHARMACY;**68**;DEC 1997
 ;
 N OI,APPUSE,DGIEN
 ;
 ; - Initializing NON-VA MED field (#8) on File #50.7
 S OI="" F  S OI=$O(^PS(50.7,OI)) Q:'OI  S $P(^PS(50.7,OI,0),"^",10)=""
 ;
 ; - Updating APPL PCKGS' USE (File #50) and NON-VA MED (File #50.7)
 S APPUSE=""
 F  S APPUSE=$O(^PSDRUG("IU",APPUSE)) Q:APPUSE=""  D
 . I APPUSE'["O" Q                           ; Not marked for Outpatient
 . I APPUSE["X" Q                            ; Already marked for Non-VA
 . S DGIEN=""
 . F  S DGIEN=$O(^PSDRUG("IU",APPUSE,DGIEN)) Q:DGIEN=""  D
 . . I $G(^PSDRUG(DGIEN,"I")),($P(^("I"),"^")<DT) Q   ; Drug is Inactive
 . . ;
 . . S OI=$P($G(^PSDRUG(DGIEN,2)),"^")       ; Get Orderable Item
 . . I OI S $P(^PS(50.7,OI,0),"^",10)=1      ; Mark as Non-VA Med
 . . D XREFS(DGIEN,APPUSE)                   ; Update x-references
 . . W !,"Updating Drug ",DGIEN
 ;
END Q
 ;
XREFS(DGIEN,APPUSE) ; - Updating existing x-references for the Application
 ;                   Use field (#63) - DRUG File
 N DGNAME,NEWAPP
 S DGNAME=$P(^PSDRUG(DGIEN,0),"^")           ; Retrive the Drug Name
 S NEWAPP=APPUSE_"X"                         ; Build the New App Use
 S $P(^PSDRUG(DGIEN,2),"^",3)=NEWAPP         ; Update the DRUG file
 S ^PSDRUG("AIUX",DGNAME,DGIEN)=""           ; Set "AIU" x-reference
 K:APPUSE]"" ^PSDRUG("IU",APPUSE,DGIEN)      ; Kill "IU" x-reference
 S ^PSDRUG("IU",NEWAPP,DGIEN)=""             ; Set "IU" x-reference
 Q
