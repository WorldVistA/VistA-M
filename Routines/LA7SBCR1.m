LA7SBCR1 ;DALOI/JMC - Shipping Barcode Reader Utility ; 23 Feb 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,64**;Sep 27, 1994
 Q
 ;
PT(LA7,LA7PROM,LA7SCFG) ; Setup patient/ordering site info from barcode.
 ; Input:
 ;        LA7=array to return values
 ;    LA7PROM=array of prompts to display to user
 ;    LA7SCFG=array of shipping configuration info
 ;
 ; Returns array LA7()
 ;  If successful DFN=ien of patient in #2, if DPF=2
 ;                DOB=patient's date of birth
 ;                DPF=source file (2, 67, or 537010)
 ;                CDT=collection date/time
 ;              ERROR=0
 ;                PNM=patient name
 ;              RSITE=sending site
 ;               RUID=specimen unique identifier
 ;                SEX=patient's sex
 ;                SSN=patient's SSN
 ;
 ;   unsuccessful ERROR=>0
 ;
 N LA7BCS,LA7IEN,LA7X,LA7Y,LA7Z,Y
 S LA7="",LA7BCS=0,LA7PNM=""
 S LA7PROM=$G(LA7PROM,"Patient/Accession Info (PD)")
 S Y=$$RD^LA7SBCR(.LA7PROM,1)
 ;
 I Y=0 D  Q
 . S LA7("ERROR")="1^User timeout/abort"
 ;
 I Y<1 D  Q
 . S LA7("ERROR")="2^Incorrect bar-code format"
 ;
 ; barcode info & longitudinal parity check
 ; original style bar code
 I $E(Y,1,9)="1^STX^PD^" D
 . S LA7=$P(Y,"STX^PD^",2)
 . S LA7=$P(LA7,"^ETX",1)
 . S LA7("LPC")=$P(Y,"^ETX",2)
 ; new style bar code
 I $E(Y,1,5)="1^PD^" D
 . S LA7=$P(Y,"^",3,6)
 . S LA7("LPC")=$P(Y,"^",7)
 . S LA7BCS=1
 ;
 I LA7="" D  Q
 . S LA7("ERROR")="2^Incorrect bar-code format"
 ;
 I $G(LA7("LPC"))'=$G(LA7SCFG("LPC")) D  Q
 . S LA7("ERROR")="9^Parity check does not match on (SM) and (PD) barcodes"
 ;
 S LA7("RSITE")=$P(LA7,"^",2)
 I LA7("RSITE")'=$P(LA7SCFG("RSITE"),"^",3) D
 . S LA7("ERROR")="31^Site in PD barcode does not match shipping configuration file"
 ;
 ; Remote specimen identifier
 S LA7("RUID")=$P(LA7,"^",3)
 ;
 ; Specimen collection date, using either old or new style(LA7BCS=1) bar code
 I 'LA7BCS,$P(LA7,"^",5) S LA7("CDT")=$$DT^LA7SBCR($P(LA7,"^",5))
 I LA7BCS,$P(LA7,"^",4) S LA7("CDT")=$$DT^LA7SBCR($P(LA7,"^",4))
 ;
 ; Patient identifier
 S LA7X=$P(LA7,"^") ; Patient's ID
 ;
 ; No SSN in first piece
 I LA7X="" S LA7("ERROR")="3^No SSN in barcode" Q
 S LA7("SSN")=LA7X
 ;
 ; Try LAB PENDING ORDERS file
 D LPO(.LA7,LA7SCFG("SMID"))
 ;
 ; Check for patient in file #2.
 I $G(LA7("ERROR")) D DPT(.LA7,LA7X)
 ;
 ; Else try Lab Referral file.
 I $G(LA7("ERROR")) D LRT(.LA7,LA7X)
 ;
 ; Get additional info from PD1 bar code
 I +$G(LA7("ERROR"))=4 D PD1
 Q
 ;
 ;
DPT(LA7,LA7X) ; Lookup in Patient file.
 ; Check for patient in file #2.
 S LA7Y=$O(^DPT("SSN",LA7X,0))
 ; SSN not found.
 I 'LA7Y S LA7("ERROR")="4^Unsuccessful SSN lookup" Q
 S LA7Y(0)=$G(^DPT(LA7Y,0))
 ; SSN not found.
 I LA7Y(0)="" S LA7("ERROR")="4^Unsuccessful SSN lookup" Q
 ;
 D DPTSET(.LA7,LA7Y)
 Q
 ;
 ;
LRT(LA7,LA7X) ; Lookup in Lab Referral file.
 ; Clear error flag.
 S LA7("ERROR")=""
 S LA7Y=$O(^LRT(67,"C",LA7X,0))
 ; SSN not found.
 I 'LA7Y S LA7("ERROR")="4^Unsuccessful SSN lookup" Q
 S LA7Y(0)=$G(^LRT(67,LA7Y,0))
 ; SSN not found.
 I LA7Y(0)="" S LA7("ERROR")="4^Unsuccessful SSN lookup" Q
 D LRTSET(.LA7,LA7Y)
 Q
 ;
 ;
LPO(LA7,LA7SM) ; Lookup in LAB PENDING ORDERS file #69.6
 ;
 N LA7696,LA7RUID
 S LA7RUID=LA7("RUID"),LA7696=""
 I LA7SM'="",LA7RUID'="" S LA7696=$O(^LRO(69.6,"AD",LA7SM,LA7RUID,0))
 I 'LA7696 S LA7("ERROR")="4^Unsuccessful SSN lookup" Q
 D LPOSET(.LA7,LA7696)
 Q
 ;
 ;
DPTSET(LA7,LA7Y) ; Setup array from Patient file.
 ;
 N RACE,LA7ERR
 S LA7Y(0)=$G(^DPT(LA7Y,0))
 ; Zeroth node not found.
 I LA7Y(0)="" S LA7("ERROR")="6^No zeroth node in file" Q
 S LA7("DFN")=LA7Y
 S LA7("DOB")=$P(LA7Y(0),"^",3)
 ; Source file
 S:LA7Y LA7("DPF")=2_U_"DPT("
 S LA7("PNM")=$P(LA7Y(0),"^")
 S LA7("RIEN")=+$G(^DPT(LA7Y,"LRT"))
 S LA7("SEX")=$P(LA7Y(0),"^",2)
 S LA7("SSN")=$P(LA7Y(0),"^",9)
 D GETS^DIQ(2,LA7Y_",","2*","I","RACE","LA7ERR")
 I '$D(LA7ERR) D
 . S X=$Q(RACE(2.02)) Q:X=""
 . S LA7("RACE")=$P(@X,"^")
 Q
 ;
 ;
LRTSET(LA7,LA7Y) ; Setup array from Lab Referral file.
 S LA7Y(0)=$G(^LRT(67,LA7Y,0))
 ; Zeroth node not found.
 I LA7Y(0)="" S LA7("ERROR")="6^No zeroth node in file" Q
 S LA7("DFN")=LA7Y
 S LA7("DOB")=$P(LA7Y(0),"^",3)
 ;
 ; Source file
 S:LA7Y LA7("DPF")=67_U_"LRT(67,"
 ;
 S LA7("PNM")=$P(LA7Y(0),"^")
 S LA7("RIEN")=LA7Y
 S LA7("SEX")=$P(LA7Y(0),"^",2)
 S LA7("SSN")=$P(LA7Y(0),"^",9)
 Q
 ;
 ;
LPOSET(LA7,LA7Y) ; Setup array from LAB PENDING ORDERS file #69.6
 ;
 N I
 F I=0,.1 S LA7Y(I)=$G(^LRO(69.6,LA7Y,I))
 ; Zeroth node not found.
 I LA7Y(0)="" D  Q
 . S LA7("ERROR")="6^No zeroth node in file"
 ; Patient identifiers don't match
 I LA7("SSN")'=$P(LA7Y(0),U,9) Q
 ;
 S LA7("PNM")=$P(LA7Y(0),U,1)
 S LA7("DOB")=$P(LA7Y(0),U,3)
 S LA7("SEX")=$P(LA7Y(0),U,2)
 S LA7("DPF")="67^LRT(67,"
 S LA7("RACE")=$P(LA7Y(.1),U)
 S LA7("ERROR")=""
 S LA7("RIEN")=$O(^LRT(67,"C",LA7("SSN"),0))
 I $G(LA7("RIEN")),$G(^LRT(67,LA7("RIEN"),"LR")) D
 . S LA7("LRDFN")=^LRT(67,LA7("RIEN"),"LR")
 . S LA7("DFN")=LA7("RIEN")
 Q
 ;
 ;
PD1 ; Read PD1 bar code information
 ;
 N LA7PROM
 ;
 S LA7PROM="Scan Patient Name Barcode (PD1)"
 S LA7PROM(1)="Patient Demographics not found"
 S LA7("ERROR")="",LA7Z=""
 S Y=$$RD^LA7SBCR(.LA7PROM,1)
 I Y<1 D  Q
 . S LA7("ERROR")="2^Incorrect bar-code format"
 ;
 ; barcode info & longitudinal parity check
 ; original style bar code
 I $E(Y,1,10)="1^STX^PD1^" D
 . S LA7Z=$P(Y,"STX^PD1^",2)
 . S LA7Z=$P(LA7Z,"^ETX")
 . S LA7Z("LPC")=$P(Y,"^ETX",2)
 ; new style bar code
 I $E(Y,1,6)="1^PD1^" D
 . S LA7Z=$P(Y,"^",3,6)
 . S LA7Z("LPC")=$P(Y,"^",7)
 ;
 I LA7Z="" D  Q
 . S LA7("ERROR")="2^Incorrect bar-code format"
 ;
 I $G(LA7Z("LPC"))'=$G(LA7SCFG("LPC")) D  Q
 . S LA7("ERROR")="10^Parity check does not match on (SM) and (PD1) barcodes"
 ;
 ; Name not found.
 I $L($P(LA7Z,U,2))<2 D  Q
 . S LA7("ERROR")="21^Unsuccessful name scan"
 ;
 ; wrong patient scanned not found.
 I $P(LA7Z,U)'=LA7("SSN") D  Q
 . S LA7("ERROR")="22^SSN does not match PD barcode"
 ;
 ; Wrong DOB format.
 I $P(LA7Z,U,3)'?7N D  Q
 . S LA7("ERROR")="23^Incorrect DOB"
 ;
 S LA7("PNM")=$P(LA7Z,U,2)
 S LA7("DOB")=$P(LA7Z,U,3)
 S LA7("SEX")=$P(LA7Z,U,4)
 S LA7("DPF")="67^LRT(67,"
 S LA7("ERROR")=""
 Q
