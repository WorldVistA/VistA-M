PSSUNMSI ;BHAM ISC/MRR - Unmark Supply Items as Non-VA Med Flag ;06/25/03
 ;;7.0;OUTPATIENT PHARMACY;**69**;DEC 1997
 ;
 ; This makes the Environment Check run only at Install (no at Load)
 I '$G(XPDENV) Q
 ;
ASK W ! S DIR("A")="Unmark Supply Items as Non-VA Meds? "
 S DIR(0)="SA^Y:YES;N:NO",DIR("B")="YES" D ^DIR W !
 ;
 I $D(DTOUT)!$D(DUOUT) S XPDQUIT=1 Q
 I Y'="N",Y'="Y" G ASK
 W !,"   Supply items will "_$S(Y="N":"NOT",1:"")_" be unmarked as Non-VA Med"
 W !,"   with the installation of this patch.",!!
 S ^XTMP("PSS*1*69")=Y
 Q
 ;
EN N OI,APPUSE,DGIEN,X,PSSCROSS,PSSTEST 
 I $G(^XTMP("PSS*1*69"))'="Y" K ^XTMP("PSS*1*69") Q
 K ^XTMP("PSS*1*69"),^TMP("PSSOI",$J)
 ;
 ; - Updating APPL PCKGS' USE (File #50) and NON-VA MED (File #50.7)
 D BMES^XPDUTL("Unmarking supply items as Non-VA Meds...")
 S APPUSE=""
 F  S APPUSE=$O(^PSDRUG("IU",APPUSE)) Q:APPUSE=""  D
 . I APPUSE'["X" Q                           ; Not marked for Non-VA
 . S DGIEN=""
 . F  S DGIEN=$O(^PSDRUG("IU",APPUSE,DGIEN)) Q:DGIEN=""  D
 . . I $G(^PSDRUG(DGIEN,"I")),($P(^("I"),"^")<DT) Q   ; Drug is Inactive
 . . ;
 . . S OI=$P($G(^PSDRUG(DGIEN,2)),"^") Q:'OI   ; Get Orderable Item
 . . I '$P($G(^PS(50.7,OI,0)),"^",9) Q         ; OI is not Supply Item
 . . S OINAM=$P($G(^PS(50.7,OI,0)),"^")
 . . S $P(^PS(50.7,OI,0),"^",10)=0             ; Unmark as Non-VA Med
 . . D XREFS(DGIEN,APPUSE)                     ; Update x-references
 . . S ^TMP("PSSOI",$J,OI)=""
 D BMES^XPDUTL("Done!")
 ;
 ; Sends Master File Updates to CPRS
 D BMES^XPDUTL("Updating CPRS Orderable Item File...")
 S OI=0,PSSCROSS=1
 F  S OI=$O(^TMP("PSSOI",$J,OI)) Q:'OI  D
 . S PSSTEST=OI D EN1^PSSPOIDT
 D BMES^XPDUTL("Done!")
 ;
END K ^TMP("PSSOI",$J) Q
 ;
XREFS(DGIEN,APPUSE) ; - Updating existing x-references for the Application
 ;                   Use field (#63) - DRUG File
 N DGNAME,NEWAPP
 I $G(^PSDRUG(DGIEN,0))="" Q
 S DGNAME=$P(^PSDRUG(DGIEN,0),"^")           ; Retrive the Drug Name
 S NEWAPP=$TR(APPUSE,"X")                    ; Build the New App Use
 S $P(^PSDRUG(DGIEN,2),"^",3)=NEWAPP         ; Update the DRUG file
 K ^PSDRUG("AIUX",DGNAME,DGIEN)              ; Kill "AIU" x-reference
 K:APPUSE]"" ^PSDRUG("IU",APPUSE,DGIEN)      ; Kill "IU" x-reference
 S:NEWAPP]"" ^PSDRUG("IU",NEWAPP,DGIEN)=""   ; Set "IU" x-reference
 Q
