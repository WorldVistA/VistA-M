PSOFDAMG ;BHAM ISC/MR - FDA Medication Guide ;11/10/09 3:44pm
 ;;7.0;OUTPATIENT PHARMACY;**343,367**;DEC 1997;Build 62
 ;External reference EN^PSNFDAMG supported by DBIA 5517
 ;External reference ^PSDRUG supported by DBIA 221
 ;External reference to DEVICE file (#3.5) supported by DBIA 5718
 ;
DISPLAY ; Display the FDA Medication Guide
 ; Note: RX0 is a global variable (assumed as such by most hidden actions)
 N DRGIEN,VAPRDIEN
 S DRGIEN=+$P($G(RX0),"^",6)
 I '$D(^PSDRUG(DRGIEN,0)) W $C(7),!,"Invalid Drug" D WAIT^VALM1 Q
 S VAPRDIEN=+$P($G(^PSDRUG(DRGIEN,"ND")),"^",3)
 I 'VAPRDIEN W $C(7),!!,$$GET1^DIQ(50,DRGIEN,.01)_" not matched to the National Drug File (NDF)" D WAIT^VALM1 Q
 ;
 D FULL^VALM1 D EN^PSNFDAMG(VAPRDIEN)
 Q
 ;
PRINTMG(RXIEN,PRINTER) ; This API is used to automatically print FDA Med Guides along with Rx labels.
 ; Input: (r) RXIEN   - Pointer to the DRUG file (#50)
 ;        (r) PRINTER - Windows Printer Network Name (e.g., '\\vhaistfpc4\IST-HP4525-1')
 ;
 ;Output: ERROR (2 pieces)
 ;        P1 - 0: Success / 1:Error
 ;        P2 - Error Message (when P1 = 1) (e.g. "No FDA Med Guide on file", "Invalid Printer Name", etc.)
 ;
 N PRTSVURL,FDAMGURL,FDAMGFN,STATUS,RXNUM,PATNAM
 ;
 I '$$MGONFILE^PSOFDAUT(RXIEN) Q "1^No FDA Med Guide Available"
 I $G(PRINTER)="" Q "1^Invalid Printer"
 I $$GET1^DIQ(59,PSOSITE,134)="" Q "1^FDA Med Guide automatic printing functionality turned OFF"
 ;
 ; Concatenating/Encoding the Web Server URL to the FDA Med Guide file name
 S FDAMGFN=$P($$MGONFILE^PSOFDAUT(RXIEN),"^",2)
 S RXNUM=$$GET1^DIQ(52,RXIEN,.01)
 S PATNAM=$$GET1^DIQ(52,RXIEN,2)
 S FDAMGURL=$$ENCODE^XTHCURL($$GET1^DIQ(59.7,1,100)_FDAMGFN_"^"_RXNUM_"^"_PATNAM_"^"_PRINTER_"^")
 ;
 S PRTSVURL=$$GET1^DIQ(59,PSOSITE,134)_"Eep9qUmT="
 ;
 ;Invoking Kernel HTTP Toolkit
 S STATUS=$$GETURL^XTHC10(PRTSVURL_FDAMGURL,30)
 I (+STATUS'=200) Q "1^"_$P(STATUS,"^",2)
 ;
 Q 0
 ;
REPRTMG ; Entry point for Reprint FDA Medication Guide
 ; Note: The PSOSITE variable is assumed to be set with the Pharmacy Division IEN
 ;
 N RXIEN,DRGIEN,VAPRDIEN,PRTSVURL,FDAMGURL,FDAMGFN,PRINTER,STATUS
 ;
 S RXIEN=$P(PSOLST(ORN),"^",2)
 S DRGIEN=+$P($G(RX0),"^",6)
 I '$D(^PSDRUG(DRGIEN,0)) W $C(7),!!,"Invalid Drug" D WAIT^VALM1 Q
 S VAPRDIEN=+$P($G(^PSDRUG(DRGIEN,"ND")),"^",3)
 I 'VAPRDIEN W $C(7),!!,$$GET1^DIQ(50,DRGIEN,.01)_" not matched to the National Drug File (NDF)" D WAIT^VALM1 Q
 I '$$MGONFILE^PSOFDAUT(RXIEN) W $C(7),!!,"No FDA Medication Guide on file for this Rx." D WAIT^VALM1 Q
 I $$GET1^DIQ(59,PSOSITE,134)="" W $C(7),!!,"FDA Med Guide automatic printing functionality is turned OFF for this site." D WAIT^VALM1 Q
 ;
 D FULL^VALM1
 ;
 ; Printer Selection
 F  D  Q:$P(PRINTER,"^",2)'=""!(PRINTER="^")
 . S PRINTER=$$SELPRT^PSOFDAUT($P($G(PSOFDAPT),"^")) Q:PRINTER="^"
 . I $P(PRINTER,"^",2)="" W $C(7),!,"You must select a valid FDA Medication Guide printer."
 I PRINTER="^" D WAIT^VALM1 Q
 ;
 S PSOFDAPT=PRINTER
 ;
 W !,"Select FDA Medication Guide to reprint:",!
 S FDAMGFN=$$FDAMGDOC^PSOFDAUT(RXIEN) I FDAMGFN="^" D WAIT^VALM1 Q
 ;
 ; Concatenating/Encoding the Web Server URL to the FDA Med Guide file name
 S RXNUM=$$GET1^DIQ(52,RXIEN,.01)
 S PATNAM=$$GET1^DIQ(52,RXIEN,2)
 S FDAMGURL=$$ENCODE^XTHCURL($$GET1^DIQ(59.7,1,100)_FDAMGFN_"^"_RXNUM_"^"_PATNAM_"^"_$P(PSOFDAPT,"^",2)_"^")
 ;
 S PRTSVURL=$$GET1^DIQ(59,+$G(PSOSITE),134)_"Eep9qUmT="
 ;
 ;Invoking Kernel HTTP Toolkit //Zaleplon_(Sonata)_(2007).pdf
 S STATUS=$$GETURL^XTHC10(PRTSVURL_FDAMGURL,30)
 I (+STATUS=200) D
 . W !!,"FDA Medication Guide sent to printer."
 I (+STATUS=-1) W !!,"Unable to reprint FDA Medication Guide (",$P(STATUS,"^",2),")."
 N DIR W ! D WAIT^VALM1
 Q
