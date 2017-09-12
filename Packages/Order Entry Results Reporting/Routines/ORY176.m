ORY176 ; slc/CLA - Pre and Post-init for patch OR*3*176 ; 17 Aug 2004  2:29 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**176**;Dec 17, 1997
 ;
PRE ;initiate pre-init processes
 N FDA,ERR
 S FDA(9.4,"?+1,",.01)="HERBAL/OTC/NON-VA MEDS"
 S FDA(9.4,"?+1,",1)="PSH"
 S FDA(9.4,"?+1,",2)="Non-VA Medications"
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL("Error creating HERBAL/OTC/NON-VA MEDS Package entry.")
 Q
 ;
POST ;initiate post-init processes
 ;update Pharmacy Display Group:
 N FDA,ERR
 S FDA(100.98,"?1,",.01)="PHARMACY"
 S FDA(100.981,"?+2,?1,",.01)="NON-VA MEDICATIONS"
 D UPDATE^DIE("E","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL("Error adding NON-VA MEDICATIONS to Pharmacy Display Group.")
 ;
 D BMES^XPDUTL("Updating OE/RR Orderable Item file with Non-VA Meds...")
 S XPDIDTOT=0 D UPDATE^XPDID(0)     ; reset status bar
 S XPDIDTOT=$P(^PS(50.7,0),"^",4)  ; Pharmacy Orderable Item file
 ;
 ;call PDM to send Master File Updates to CPRS
 N XXOI,PSSCROSS,PSSTEST
 S XXOI=0,PSSCROSS=1
 F  S XXOI=$O(^PS(50.7,XXOI)) Q:'XXOI  D
 . I '(XXOI#100) D UPDATE^XPDID(XXOI)   ; update status bar
 . I '$P(^PS(50.7,XXOI,0),"^",10) Q
 . S PSSTEST=XXOI D EN1^PSSPOIDT
 ;
 Q
