PSS50 ;BIR/LDT - API FOR INFORMATION FROM FILE 50; 5 Sep 03
 ;;1.0;PHARMACY DATA MANAGEMENT;**85,104**;9/30/97
 ;
DATA(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Drug File (#50) Data
 D DATA^PSS50DAT
 Q
CMOP(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns CMOP information from Drug File (#50)
 D CMOP^PSS50CMP
 Q
DRG(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns information from Drug File (#50) used by Inpatient Meds/Unit Dose
 D DRG^PSS50DAT
 Q
ATC(PSSIEN,PSSFT,PSSFL,PSSPK,LIST) ;
 ;Returns ATC fields from the Drug File (#50)
 N PSSRTOI
 D ATC^PSS50ATC
 Q
INV(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns inventory fields from the Drug File (#50)
 D INV^PSS50B
 Q
NDF(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns NDF fields from the Drug File (#50)
 D NDF^PSS50B
 Q
LAB(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Lab information from the Drug File (#50)
 D LAB^PSS50LAB
 Q
CLOZ(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Clozapine information from the Drug File (#50)
 D CLOZ^PSS50B2
 Q
ARWS(PSSIEN,PSSFT,LIST) ;
 ;Returns fields utilized by the Automatic Replenishment/Ward Stock extract in PBM
 N PSSFL,PSSPK,PSSRTOI
 D ARWS^PSS50WS
 Q
DOSE(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Dosing fields from the Drug File (#50)
 D DOSE^PSS50B
 Q
WS(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Ward Stock fields from the Drug File (#50)
 D WS^PSS50C
 Q
MRTN(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Lab Test Monitor fields from the Drug File (#50)
 D MRTN^PSS50C
 Q
ZERO(PSSIEN,PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Zero node information from the Drug File (#50)
 D ZERO^PSS50C
 Q
NOCMOP(PSSIEN,PSSFL) ;
 ;Returns drugs from the Drug file (#50) with the CMOP Dispense Field set to Null or No
 Q $$NOCMOP^PSS50C(PSSIEN,$S($G(PSSFL)]"":PSSFL,1:""))
 Q
MSG(LIST) ;
 ;Returns entries and data from the Drug File (#50) with data in the Quantity Dispense Message field
 D MSG^PSS50C
 Q
IEN(LIST) ;
 ;Returns Active Outpatient Drugs with a VA Product Name entry
 D IEN^PSS50C
 Q
B(PSSFT,PSSFL,PSSPK,PSSRTOI,LIST) ;
 ;Returns Drug information based on B cross reference
 D B^PSS50D
 Q
VAC(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns Generic Name based on National Drug Class
 N PSSRTOI
 D VAC^PSS50D
 Q
NDC(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns Generic Name or IEN for drugs when passed an NDC
 D NDC^PSS50D
 Q
ASP(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns drug entries when passed an Orderable Item
 N PSSRTOI
 D ASP^PSS50D
 Q
AND(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns drug entries when passed a National Drug File entry
 N PSSRTOI
 D AND^PSS50D
 Q
AP(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns drug entries when passed a Primary Drug entry
 N PSSRTOI
 D AP^PSS50D
 Q
DSPUNT(PSSIEN,PSSIEN2,LIST) ;
 ;Returns Dispense Units Per Order Unit when passed in the Drug and Synonym
 D DSPUNT^PSS50C1
 Q
SKB(PSSIEN,PSSFL) ;
 ;Sets and kills B cross reference on the Name field when the Drug is passed
 I +$G(PSSIEN)'>0 Q 0
 I $G(PSSFL)']"" Q 0
 I "SK"'[$G(PSSFL) Q 0
 Q $$SKB^PSS50E(PSSIEN,PSSFL)
AOC(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns generic name or IEN for drugs when passed the VA CLASSIFICATION
 D AOC^PSS50E
 Q
C(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns information from the Synonym multiple of the Drug File (#50)
 D C^PSS50E
 Q
AQ(PSSIEN) ;
 ;Checks for existence of "AQ" x-ref for PSSIEN passed
 I +$G(PSSIEN)'>0 Q 0
 Q +$G(^PSDRUG(+PSSIEN,3))
SKAQ(PSSIEN,PSSFL) ;
 ;Sets and kills "AQ" x-ref on the CMOP Dispense field for PSSIEN passed
 I +$G(PSSIEN)'>0 Q 0
 I $G(PSSFL)']"" Q 0
 I "SK"'[$G(PSSFL) Q 0
 Q $$SKAQ^PSS50E(PSSIEN,$G(PSSFL))
SKAQ1(PSSIEN) ;
 ;Sets and kills "AQ1" x-ref on the CMOP ID field for PSSIEN passed
 I +$G(PSSIEN)'>0 Q 0
 Q $$SKAQ1^PSS50E(PSSIEN)
AQ1(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns a list of drugs associated with the CMOP ID passed
 D AQ1^PSS50B1
 Q
A526(PSSIEN,LIST) ;
 ;Returns a list of additives associated with the Drug passed
 D A526^PSS50E
 Q
A527(PSSIEN,LIST) ;
 ;Returns a list of solutions associated with the drug passed
 D A527^PSS50E
 Q
AIU(PSSFT,PSSPK,PSSFL,LIST) ;
 ;Returns a list of drugs based on Application Packages' Use and Inactive Date
 D AIU^PSS50B1
 Q
IU(PSSFL,LIST) ;
 ;Returns a list of drugs based on Application Packages' Use not containing "O", "U", "I", or "N"
 D IU^PSS50B1
 Q
SKAIU(PSSIEN,PSSFL) ;
 ;Sets and Kills the "AIU" x-ref on the APPLICATION PACKAGES' USE field for PSSIEN and PSSPK passed
 I +$G(PSSIEN)'>0 Q 0
 I $G(PSSFL)']"" Q 0
 I "SK"'[$G(PSSFL) Q 0
 Q $$SKAIU^PSS50E(PSSIEN,PSSFL)
SKIU(PSSIEN) ;
 ;Sets and Kills the "IU" x-ref on the APPLICATION PACKAGES' USE field for PSSIEN and PSSPK passed
 I +$G(PSSIEN)'>0 Q 0
 Q $$SKIU^PSS50E(PSSIEN)
AB(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns a list of drugs associated with an IFCAP Item Number
 D AB^PSS50C
 Q
AVSN(PSSVAL,PSSFL,PSSPK,LIST) ;
 ;Returns synonym multiple for Synonym value passed
 D AVSN^PSS50B1
 Q
FRMALT(PSSIEN,PSSFT,PSSFL,PSSPK,LIST) ;
 ;Returns the Formulary Altenative for the drug value passed
 N PSSRTOI
 D FRMALT^PSS50B2
 Q
LABEL(PSSIEN,LIST) ;
 ;Returns Information for the scanner for the drug IEN passed
 D LABEL^PSS50A1
 Q
SORT(PSSIEN,LIST) ;
 ;Returns a list of drugs for the IEN passed
 D SORT^PSS50A1
 Q
OLDNM(PSSIEN,PSSFT,PSSFL,PSSPK,LIST) ;
 ;Returns OLD NAME multiple from the Drug File (#50)
 N PSSRTOI
 D OLDNM^PSS50F
 Q
ADDOLDNM(PSSIEN,PSSONM,PSSDT) ;
 ;Adds an entry to the OLD NAME Multiple of the Drug file (#50)
 Q $$ADDOLDNM^PSS50F($G(PSSIEN),$G(PSSONM),$G(PSSDT))
LIST(PSSFT,PSSFL,PSSD,PSSPK,LIST) ;
 ;Returns a list containing GENERIC NAME field (#.01) and PHARMCY ORDERABLE ITEM field (#2.1)
 N PSSRTOI
 D LIST^PSS50F1
 Q
EDTIFCAP(PSSIEN,PSSVAL) ;
 ;Adds an entry to the IFCAP ITEM NUMBER multiple of the DRUG file (#50)
 Q $$EDTIFCAP^PSS50F($G(PSSIEN),$G(PSSVAL))
LOOKUP(PSSFT,PSSFL,PSSPK,PSSRTOI,PSSIFCAP,PSSCMOP,PSSD,LIST) ;
 D LOOKUP^PSS50F1
 Q
CSYN(PSSIEN,PSSVAL,LIST) ;
 ;returns synonym information from the synonym multiple of the Drug file (#50)
 D CSYN^PSS50C1
 Q
