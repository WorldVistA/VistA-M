MDCPV1 ;HINES OIFO/DP/BJ - PV1 Segment Routine;08 Aug 2007
 ;;1.0;CLINICAL PROCEDURES;**16,23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; - This routine uses the following Integration Agreements (IAs):
 ;     #2050     -     $$EZBLD^DIALOG()          (supported)
 ;
 ; - The PV1 Segment Wrapper Sub-routine. This interfaces the creation of a PV1
 ;    segment by the PV1 segment builder.
 Q
EN(PATMVMT,PV1SEG,PV1RONG) ;
 ;
 ;  PATMVMT      = the 704.005 file entry for the HL7 message !! Pass by reference !!
 ;  PV1SEG       = root segment buffer where the PV1 information is to be stored
 ;                                !! Pass by reference !!
 ;  PV1RONG     = the string the error message string goes !! Pass by reference !!
 ;
 N VAFSTR,CHUNX,HLECH,HLMAXLEN,HLCM,HLRP,HLSC,HLES,HLFS,HLQ,HL7RC,HLECH
 S VAFSTR=",1,2,3,"
 D MOREDLMS^MDCUTL
 ; - obtain PV1 information
 ;    submit the field selection string and Segment number in addition to the
 ;    parameters passed by the message builder
 D BUILD^MDCSPV1(VAFSTR,"0001",.PATMVMT,.PV1SEG,.PV1RONG)
 ;
 ; - bail if no segment material
 Q:$G(PV1SEG)=""
 S CHUNX=($D(PV1SEG))-1
 Q:(CHUNX=9)!(CHUNX=-1)
 ;
 N APL,APLOC
 S APL=3+1
 S APLOC=$P(PV1SEG,HLFS,APL)
 ; Change the delimiters from HLRP to HLCM.  Otherwise a message never gets built.
 ;I $P(APLOC,HLRP,1)="" S PV1RONG=$$PVERMSG^MDCPV1("PV1.3.1",MDCIEN,704.005) Q
 ;I $P(APLOC,HLRP,2)="" S PV1RONG=$$PVERMSG^MDCPV1("PV1.3.2",MDCIEN,704.005) Q
 ;Note: if this is an A08, then we're not gonna have an inpatient location and such like.
 I $P(PATMVMT("0"),U,7)'="A08" D
 .I $P(APLOC,HLCM,1)="" S PV1RONG=$$PVERMSG^MDCPV1("PV1.3.1",MDCIEN,704.005) Q
 .I $P(APLOC,HLCM,2)="" S PV1RONG=$$PVERMSG^MDCPV1("PV1.3.2",MDCIEN,704.005) Q
 ;
 Q
 ;
 ; here is an interface for the error message routine
PVERMSG(ELMT,RIEN,FILEN) ;
 ; - this function invokes error message creation.
 ;    ELMT   =  the HL7 element ID, such as PV1.7.2
 ;    RIEN   =  IEN of record lacking missing or containing missing element
 ;    FILEN  =  File number of fileman file containing record
 N PV1PRAMS
 S PV1PRAMS(1)=ELMT,PV1PRAMS(2)=RIEN,PV1PRAMS(3)=FILEN
 Q $$EZBLD^DIALOG(7040020.001,.PV1PRAMS)
