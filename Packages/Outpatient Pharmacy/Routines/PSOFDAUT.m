PSOFDAUT ;BIRM/MFR - FDA Med Guide Utilities ; 07 Jun 2005  8:39 PM
 ;;7.0;OUTPATIENT PHARMACY;**367**;DEC 1997;Build 62
 ;External reference to $$FDAMG^PSNAPIS supported by DBIA 2531
 ;
SELPRT(DEFAULT) ; FDA Med Guide Printer Selection
 ;Input: DEFAULT - Default Printer Name 
 ;Return Variable: SELPRT: Selected Printer Name ^ Windows Network Printer Name
 ;
 N SELPRT,NTWRKNAM,DEFPRT,%ZIS,VALID,DEVIEN,PRTLST,I
 ;
 ; If FDA MG PRINT SERVER is not present quits (FDA MG Functionality is OFF)
 I $$GET1^DIQ(59,PSOSITE,134)="" Q "^"
 ;
 S SELPRT=$G(DEFAULT) D ^%ZISC
 I SELPRT'="" D
 . S DEFPRT=SELPRT
 E  D
 . S DEFPRT=$$DEFPRT(PSOSITE)
 ;
 D PRTLST(PSOSITE,.PRTLST)
 I $O(PRTLST(0)) D
 . W !!,$$GET1^DIQ(59,PSOSITE,.01),"'s FDA Medication Guide Printer(s) on file:",!
 . F I=0:0 S I=$O(PRTLST(I)) Q:'I  W !?5,$P(PRTLST(I),"^",2)
 ;
PRT ; Printer prompt
 S %ZIS="MNQ",%ZIS("A")="Select FDA MED GUIDE PRINTER: "
 S:$G(DEFPRT)'="" %ZIS("B")=$P(DEFPRT,"^") W ! D ^%ZIS K %ZIS,IO("Q"),IOP I POP Q "^"
 S VALID=1
 I (IO'=IO(0)) D  I 'VALID D ^%ZISC G PRT
 . S DEVIEN=IOS,NTWRKNAM=$$GET1^DIQ(3.5,IOS,75)
 . I (NTWRKNAM=""&(" "_ION_" "'[" NULL ")) D  S VALID=0 Q
 . . W !,"This device cannot be used for printing FDA Medication Guides."
 . . W !,"Please, contact your IRM and ask them to update the Windows"
 . . W !,"Network Printer Name for this device.",$C(7)
 . E  D
 . . S SELPRT=ION_"^"_NTWRKNAM
 ;
 ; HOME device selected
 I (IO=IO(0)) S SELPRT=""
 ;
 D ^%ZISC
 ;
 Q SELPRT
 ;
PRTLST(SITE,PRTLST) ; Returns the List of FDA Medication Guide Printer for the Division
 ; Input:  (r) SITE   - Site IEN (#59)
 ; Output:     PRTLST - Array containing list of FDA Med Guides Printers for the Division
 N PRT,CNT
 S CNT=0
 F PRT=0:0 S PRT=$O(^PS(59,+$G(SITE),"FDA",PRT)) Q:'PRT  D
 . S CNT=CNT+1
 . S PRTLST(CNT)=$$GET1^DIQ(59.0135,PRT_","_+$G(SITE)_",",.01)_"^"_$$GET1^DIQ(59.0135,PRT_","_+$G(SITE)_",",.01)
 . S:$$GET1^DIQ(59.0135,PRT_","_+$G(SITE)_",",.02,"I") PRTLST(CNT)=PRTLST(CNT)_" (Default)"
 Q
 ;
DEFPRT(SITE) ; Returns the Default FDA Medication Guide Printer for the Division
 ; Input:  (r) SITE   - Site IEN (#59)
 ; Output:     DEFPRT - Device Name or blank (no Default)
 N PRT,DEFPRT
 S DEFPRT=""
 F PRT=0:0 S PRT=$O(^PS(59,+$G(SITE),"FDA",PRT)) Q:'PRT  D
 . I $P($G(^PS(59,+$G(SITE),"FDA",PRT,0)),"^",2) D
 . . S PRTIEN=$$GET1^DIQ(59.0135,PRT_","_+$G(SITE)_",",.01,"I") I 'PRTIEN Q
 . . I $$GET1^DIQ(3.5,PRTIEN,75)="" Q
 . . S DEFPRT=$$GET1^DIQ(3.5,PRTIEN,.01)_"^"_$$GET1^DIQ(3.5,PRTIEN,75)
 Q DEFPRT
 ;
FDAMGDOC(RXIEN) ; Lists all FDA Med Guides for a specific Rx & Return Selection
 ; Input:  (r) RXIEN    - Prescription IEN (#52)
 ; Output:     FDAMGDOC - FDA Med Guide PDF file name or blank, "^" (no selection)
 ;
ASK ; Prompt for FDA Medication Guide Selection
 N MGLST,DIR,DIRUT,DUOUT,DTOUT
 D FDAMGLST(RXIEN,1,.MGLST) D HELP W !
 S DIR(0)="FO",DIR("A")="Select FDA Med Guide (1-"_$O(MGLST(999),-1)_")"
 S (DIR("?"),DIR("??"))="^D HELP^PSOFDAUT" D ^DIR
 I $D(DIRUT)!$D(DUOUT)!$D(DTOUT) Q "^"
 I '$D(MGLST(X)) W ?40,"Invalid selection.",$C(7) G ASK
 W "    ",$P(MGLST(X),"^",2)
 Q $P(MGLST(X),"^",2)
 ;
HELP ; List FDA Med Guides and prompt for selection
 N INDEX,XX
 S XX="",$P(XX,"-",81)=""
 W !,XX,!," # FL",?7,"FDA MED GUIDE FILE NAME",?64,"TYPE",?72,"DATE",!,XX
 S INDEX=0 F  S INDEX=$O(MGLST(INDEX)) Q:'INDEX  D
 . W:'$O(MGLST(INDEX)) !
 . W !,$J(INDEX,2),?3,$J($P(MGLST(INDEX),"^"),2),?7,$P(MGLST(INDEX),"^",2)
 . W ?64,$P(MGLST(INDEX),"^",3),?72,$P(MGLST(INDEX),"^",4)
 Q
 ;
FDAMGLST(RXIEN,ADDLST,MGLST) ; Return a list of all FDA Med Guides for a specific Rx
 ; Input:  (r) RXIEN  - Prescription IEN (#52)
 ;         (o) ADDLST - Add Latest FDA Med Guide to the list? (Default: 0 (No))
 ; Output:     MGLST  - Array containing list of FDA Med Guides for the Rx (By Reference)
 N A,B,Z,LBL,CMP,FDAMG,RFL,DRGIEN,NDFIEN,FILL,INDEX,TMPLST,MGDATE
 ;
 K TMPLST
 ; Window Fills
 S LBL=0 F  S LBL=$O(^PSRX(RXIEN,"L",LBL)) Q:'LBL  D
 . S FDAMG=$G(^PSRX(RXIEN,"L",LBL,"FDA")) I FDAMG="" Q
 . S Z=$G(^PSRX(RXIEN,"L",LBL,0)) S FILL=+$P(Z,"^",2) I (FILL>20) S FILL="P"_(99-FILL)
 . S MGDATE=$$GET1^DIQ(52.032,LBL_","_RXIEN_",",.01,"I")\1
 . S TMPLST(MGDATE,FILL)=FILL_"^"_FDAMG_"^"_$S(FILL["P":"PARTIAL",1:"WINDOW")_"^"_$$FMTE^XLFDT(MGDATE,"2ZM")
 ;
 ; CMOP Fills
 S CMP=0 F  S CMP=$O(^PSRX(RXIEN,4,CMP)) Q:'CMP  D
 . S FDAMG=$G(^PSRX(RXIEN,4,CMP,"FDA")) I FDAMG="" Q
 . S Z=$G(^PSRX(RXIEN,4,CMP,0)) Q:'+Z
 . S MGDATE=$$GET1^DIQ(550.2,+Z,5,"I")\1
 .  S TMPLST(MGDATE,+$P(Z,"^",3))=+$P(Z,"^",3)_"^"_FDAMG_"^CMOP^"_$$FMTE^XLFDT(MGDATE,"2ZM")
 ;
 ; - Moving from TMPLST to MGLST
 K MGLST S INDEX=0,(A,B)=""
 F  S A=$O(TMPLST(A)) Q:A=""  F  S B=$O(TMPLST(A,B)) Q:B=""  D
 . S INDEX=INDEX+1,MGLST(INDEX)=TMPLST(A,B)
 ;
 ; - Adding 'LATEST' FDA Med Guide
 I $G(ADDLST) D
 . S DRGIEN=$$GET1^DIQ(52,RXIEN,6,"I"),NDFIEN=$$GET1^DIQ(50,DRGIEN,22,"I")
 . I ($$FDAMG^PSNAPIS(NDFIEN)'="") D
 . . S INDEX=INDEX+1,MGLST(INDEX)="^"_$$FDAMG^PSNAPIS(NDFIEN)_"^LATEST"
 ;
 Q
 ;
MGONFILE(RXIEN) ; Is there an FDA Med Guide on File for the Prescription
 ; Input: (r) RXIEN   - Pointer to the PRESCRIPTION file (#52)
 ;Output: 1^FDA Med Guide Document Name / 0 (no)
 ;
 N DRGIEN,NDFIEN,FDAMGFN
 I '$D(^PSRX(RXIEN)) Q 0
 S DRGIEN=$P($G(^PSRX(RXIEN,0)),"^",6)
 I '$D(^PSDRUG(DRGIEN)) Q 0
 S NDFIEN=+$P($G(^PSDRUG(DRGIEN,"ND")),"^",3) I 'NDFIEN Q 0
 S FDAMGFN=$$FDAMG^PSNAPIS(NDFIEN) I FDAMGFN="" Q 0
 Q ("1^"_FDAMGFN)
