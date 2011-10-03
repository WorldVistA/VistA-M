VAFHADT2 ;ALB/RJS - HL7 ADT MESSAGE BUILDING ROUTINE - MAY 18,1995 ; 3/6/06 8:08am
 ;;5.3;Registration;**91,692**;Jun 06, 1996
 ;hl7v1.6
 ;
 ;This routine builds ADT HL7 messages: A01 = Admission
 ;                                      A02 = Transfer
 ;                                      A03 = Discharge
 ;                                      A08 = Update
 ;                                      A11 = Cancel Admission
 ;                                      A12 = Cancel Transfer
 ;                                      A13 = Cancel Discharge
 ;
 ;It is called by VAFHADT1, which is itself is called by the
 ;DGPM patient movement event driver.
 ;
 ;
BLDMSG(DFN,EVENT,VAFHDT,EVCODE,IEN,PIVOT,PV1) ;
 ;Required Variables are:   DFN = IEN of Patient File
 ;                        EVENT = HL7 Event, A01, A02, A03, etc.
 ;                       VAFHDT = Date/Time of Admission, Transfer, etc
 ;
 ;Optional Variables are: Event Code = (EVCODE):A string literal which is
 ;                                     inserted in the Event Reason
 ;                                     Code Field of the EVN segment
 ;                                     of the message. This serves to
 ;                                     indicate that the message might
 ;                                     need to be processed in a special
 ;                                     way. PIMS ADT software uses the
 ;                                     Event Code to indicate whether
 ;                                     the message is the most recent
 ;                                     "Snapshot" of the data "05" or
 ;                                     a "Snapshot" of data that is
 ;                                     followed by more recent data "04"
 ;
 ;                         
 ;                               IEN = The IEN of the Patient Movement
 ;                                     that the HL7 message is being
 ;                                     built from. This is especially
 ;                                     useful for Discharge Movements
 ;                                     where date/time (VAFHDT) is not
 ;                                     enough information to retrieve
 ;                                     the movement
 ;
 ;                             PIVOT = The PIMS Pivot number that
 ;                                     uniquely identifies the ADMISSION
 ;
 ;                               PV1 = In the case of a "Deleted
 ;                                     Admission" the record in the 
 ;                                     Patient Movement File has already
 ;                                     been deleted. But, a PV1 segment
 ;                                     can be built from the DGPMP
 ;                                     variable that has been saved off
 ;                                     by the DGPM Event Driver. This
 ;                                     PV1 segment is passed a string
 ;                                     literal that is built by a call
 ;                                     to DGBUILD^VAFHAPV1 previous to 
 ;                                     calling this software.
 ;
 K HLA N VAFDIAG
 ;Q:($G(EVCODE)'="05")
 ;D INIT^HLTRANS
 K HL D INIT^HLFNC2("VAFH "_EVENT,.HL)
 I $D(HL)=1 G EXIT
 S HLA("HLS",2)=$$EN^VAFHLPID(DFN,",2,3,5,7,8,19")
 S $P(HLA("HLS",2),HLFS,2)=1 ;SET ID
 ;MERGE HLA("HLS",2)=VAFPID
 S HLA("HLS",3)=$$EN^VAFHLZPD(DFN,",1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
 S $P(HLA("HLS",3),HLFS,2)=1 ;SET ID
 I EVENT="A11" D  G NEXT
 . S HLA("HLS",4)=PV1
 . S $P(HLA("HLS",4),HLFS,51)=$G(PIVOT) ;                 VISIT&SET ID'S
 I EVENT="A01"!(EVENT="A03")!(EVENT="A08")!(EVENT="A12")!(EVENT="A13") D  G NEXT
 . S HLA("HLS",4)=$$IN^VAFHLPV1(DFN,VAFHDT,",2,3,7,8,10,19,44,45",$G(IEN),PIVOT,"",.VAFDIAG)
 I EVENT="A02" D  G NEXT
 . S HLA("HLS",4)=$$IN^VAFHLPV1(DFN,VAFHDT,",2,3,6,7,8,10,19,44,45",$G(IEN),PIVOT,"",.VAFDIAG)
 G EXIT
NEXT ;
 S $P(HLA("HLS",4),HLFS,2)=1
 S HLA("HLS",1)="EVN"_HLFS_EVENT_HLFS_$$HLDATE^HLFNC(VAFHDT,"TS")_HLFS
 S HLA("HLS",1)=HLA("HLS",1)_HLFS_$G(EVCODE)
 I (EVENT="A01")!(EVENT="A08")!(EVENT="A11")!(EVENT="A12")!(EVENT="A13") S HLA("HLS",6)="DG1"_HLFS_1_HLFS_HLFS_HLFS_$$HLQ^VAFHUTL($G(VAFDIAG))
 ;Get patient directory call center parameter
 N VAFCCON
 S VAFCCON=$$GET^XPAR("SYS","DG PT DIRECTORY CALL CENTER")
 I VAFCCON S HLA("HLS",5)=$$EN^VAFHLPV2(DFN,IEN,",22,")
 D:$D(VATRACE) LOOP
 ;
 S COUNTER=""
 F  S COUNTER=$O(HLA("HLS",COUNTER)) Q:COUNTER'>0  D
 .; I +(HLA("HLS",COUNTER))=-1 S HLERR="Bad "_COUNTER_" Segment"
 .  I +(HLA("HLS",COUNTER))=-1 S HL="Bad "_COUNTER_" Segment"
 .
 ;
EXIT ;
 ;I $D(HLERR) D
 I $D(HL)=1 DO
 .  S HLERR(1)=HL
 .  D EBULL^VAFHUTL2(DFN,VAFHDT,PIVOT,"HLERR(")
 ;I '$D(HLERR)&($D(HLSDATA)) S HLMTN="ADT"_$E(HLECH)_EVENT D EN^HLTRANS
 I $D(HL)>1,$D(HLA("HLS")) S HLMTN="ADT"_$E(HL("ECH"))_EVENT DO
 .D GENERATE^HLMA("VAFH "_EVENT,"LM",1,.HLRST)
 D KVAR^VADPT,KVAR^VAFHLPV1 K HLA,HLERR
 Q
LOOP ;
 ;
 ;
 W !!
 N XX S XX=0
 F  S XX=$O(HLA("HLS",XX)) Q:XX=""  W !,HLA("HLS",XX)
 Q
