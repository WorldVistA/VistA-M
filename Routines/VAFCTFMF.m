VAFCTFMF ;ALB/JLU,LTL-Broadcast Master File Update for Treating Facility ;09/03/98 
 ;;5.3;Registration;**149,261,255,307,361,428,697**;Aug 13, 1993
 ;
 ;Reference to ^ORD(101 supported by IA #872
BCKTFMFU ;
 ;This entry point is used to generate a Master File update
 ;for each patient that is in the "AXMIT" cross reference in the PIVOT
 ;file.
 ;INPUTS  NONE
 ;OUTPUTS Sending of MFU messages
 ;
 ;IA: 2056  - $$GET1^DIQ
 ;IA: 10106 - $$HLDATE^HLFNC
 ;IA: 2161  - INIT^HLFNC2
 ;IA: 2164  - GENERATE^HLMA
 ;IA: 2270  - GET^HLSUB
 ;IA: 2701  - $$GETICN/$$HL7CMOR/$$IFVCCI^MPIF001
 ;IA: 2702  - $$MPINODE^MPIFAPI
 ;IA: 3073  - EN1^RGADT2
 ;IA: 2796  - EXC/STOP^RGHLLOG
 ;IA: 10141 - $$PATCH^XPDUTL
 ;IA: 2171  - $$WHAT^XUAF4
 ;
 ;quit if CIRN is not installed
 N X S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 N PDFN,LP,EVTDATE,EVTR,SUBSCN,VAFCMPI
 I '$D(^VAT(391.71,"AXMIT",5)) G BCKQ
 F LP=0:0 S LP=$O(^VAT(391.71,"AXMIT",5,LP)) Q:'LP  D
 .S PDFN=$P($G(^VAT(391.71,LP,0)),U,3)
 .I PDFN="" D EXC^RGHLLOG(212,"Unable to send TF update due to unknown patient for IEN#"_$G(LP)) D STOP^RGHLLOG(1) Q  ; log exception
 .I PDFN'=""&'$D(^DPT(PDFN,0)) D EXC^RGHLLOG(212,"Unable to send TF update due to unknown patient for IEN#"_$G(LP)) D STOP^RGHLLOG(1) Q  ; log exception
 .;making sure that your site is added or updated before continuing, FILE will also add CMOR
 . I '$$PATCH^XPDUTL("RG*1.0*4") D FILE^VAFCTFU(PDFN,+$$SITE^VASITE,1)
 .S SUBSCN=$$MPINODE^MPIFAPI(PDFN) I +$G(SUBSCN)<1 D XMITFLAG^VAFCDD01(LP,0,1) Q
 .; if no subscribers (piece 5) and no CMOR (piece 3), turn off xmit flag for Pivot file.  
 .I +$P(SUBSCN,"^",3)<1,(+$P(SUBSCN,"^",5)<1) D XMITFLAG^VAFCDD01(LP,0,1)
 .;Removed section to create a new subscription as it is no longer used.
 .;1/23/06
 .I +$P($G(SUBSCN),"^",5)<1 D XMITFLAG^VAFCDD01(LP,0,1) Q
 .K HLL D GET^HLSUB($P(SUBSCN,"^",5),"","VAFC MFU-TFL CLIENT",.HLL) I '$D(HLL("LINKS")) D XMITFLAG^VAFCDD01(LP,0,1) Q
 .K HLL
 .;Update last treatment date and event reason
 .I $$PATCH^XPDUTL("RG*1.0*4") D EN1^RGADT2(PDFN,1)
 .I PDFN DO
 ..K VAFCERR
 ..I $D(^DGCN(391.91,"APAT",PDFN)) D TFMFU(PDFN)
 ..;CALL TAG TO FLIP TRANSMIT FIELD IN VAT(391.71
 ..D:$G(RESLT) XMITFLAG^VAFCDD01(LP,0,1)
 ..;store resulting message in ADT/HL7 PIVOT file
 ..S RESLT=$S($G(RESLT)]"":RESLT,1:$P($G(ER),U,2))
 ..D FILERM^VAFCUTL(LP,RESLT)
 ..K ER,RESLT,VAFCERR Q
BCKQ Q
 ;
TFMFU(PDFN) ;
 ;sends a MFU message for a single patient
 N HLEID
 S ER=$$INIT
 I ER G TFMFUQ
 D BLDTFMFU(PDFN)
 ;if error from build don't send
 I '$D(VAFCERR) D SEND
 D KILLHL7
TFMFUQ Q
 ;
INIT() ;
 ;initialize HL7 variables
 S ER=0
 S HLEID=+$O(^ORD(101,"B","VAFC MFU-TFL SERVER",0))
 I 'HLEID S ER="1^Unable to initialize HL7 variables - Protocol not found." G INITQ
 S HL=""
 D INIT^HLFNC2(HLEID,.HL)
 I $O(HL(""))="" S ER="1^"_$P(HL,U,2) G INITQ
 I $G(HL)]"" S ER=$G(HL)
INITQ Q ER
 ;
 ;
BLDTFMFU(PDFN) ;
 ;builds the segments and formats the HL7 MFU message
 N CTR,INST,ICN,INSTNUM,IEN,TF,EC,INSTNAM,PPF,CMOR
 S PPF=$$IFVCCI^MPIF001(PDFN)
 S EC=$E(HL("ECH"),1,1)
 S CTR=1
 S TFMF(1)="TFL",TFMF(2)="",TFMF(3)=$S(PPF>0:"REP",1:"UPD"),TFMF(4)="",TFMF(5)="",TFMF(6)="NE"
 S CMOR=$$HL7CMOR^MPIF001(PDFN,EC)
 I CMOR'>0 K CMOR
 S HLA("HLS",CTR)=$$EN^VAFHLMFI(HL("ECH"),HL("FS"),HL("Q"),"TFMF")_HL("FS")_$G(CMOR)
 K TFMF
 S ICN=$$GETICN^MPIF001(PDFN)
 S TFMF(1)="MAD",TFMF(2)=""
 I PPF>0 DO
 .F INST=0:0 S INST=$O(^DGCN(391.91,"APAT",PDFN,INST)) Q:'INST  S IEN=$O(^(INST,0)),TF=^DGCN(391.91,IEN,0) DO
 ..S INSTNAM=$$WHAT^XUAF4(+$P(TF,U,2),.01)
 ..S INSTNUM=$$WHAT^XUAF4(+$P(TF,U,2),99)
 ..S TFMF(3)=$$HLDATE^HLFNC($P(TF,U,3))
 ..S TFMF(4)=INSTNUM_EC_INSTNAM_EC_"VA"_EC_+ICN_EC_"ICN"_EC_"VA"
 ..D SETMFE
 ..D SETZET(IEN)
 ..Q
 E  DO  ;NOT THE PRIMARY FACILITY
 .S INSTNAM=$$SITE^VASITE(),INST=+INSTNAM
 .S IEN=$O(^DGCN(391.91,"APAT",PDFN,INST,0))
 .;if there was a subscription but no TF add it, quit and don't send
 .I +IEN'>0 D FILE^VAFCTFU(PDFN,INST,1) S VAFCERR=1 Q
 .S TF=$G(^DGCN(391.91,IEN,0))
 .S TFMF(3)=$$HLDATE^HLFNC($P(TF,"^",3))
 .S TFMF(4)=$P(INSTNAM,U,3)_EC_$P(INSTNAM,U,2)_EC_"VA"_EC_+ICN_EC_"ICN"_EC_"VA"
 .D SETMFE
 .D SETZET(IEN)
 .Q
BLDTFMFQ K TFMF
 Q
 ;
SETMFE S CTR=CTR+1
 S HLA("HLS",CTR)=$$EN^VAFHLMFE(HL("ECH"),HL("FS"),HL("Q"),"TFMF")
 Q
SETZET(IEN) ;Date of Last Treatment event type ZET segment
 S CTR=CTR+1
 S HLA("HLS",CTR)="ZET"_HL("FS")_$$GET1^DIQ(391.91,+IEN_",",.07)
 Q
 ;
SEND ;
 ;sends the MFU message
 D GENERATE^HLMA(HLEID,"LM",1,.HLRESLT,"","")
 S RESLT=$S(+HLRESLT:HLRESLT,1:$P(HLRESLT,U,3))
 Q
 ;
KILLHL7 ;
 ;kills off the variables from the HL7 package.
 K HL,HLA,HLECH,HLEID,HLFS,HLMTIEN,HLMTIENA,HLQ,HLRESLT,HLN,HLSAN
 Q
