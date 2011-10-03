RGADT1 ;HIRMFO/GJC-BUILD ADT MESSAGES (A01/A03) ;09/21/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4,14,17,27,28,31,34,45**;30 Apr 99;Build 9
 Q  ; quit if called from the top
 ;
EN ; entry point to build/transmit ADT messages
 ; Messages built by this software are fired off by server protocols:
 ; RG ADT-A01 SERVER -or- RG ADT-A03 SERVER
 ;
 ; This code is called from the RG ADT INPATIENT ENCOUNTER DRIVER &
 ; RG ADT OUTPATIENT ENCOUNTER DRIVER protocols.
 ;
 ; RG ADT OUTPATIENT ENCOUNTER DRIVER is an item protocol under the
 ; SDAM APPOINTMENTS EVENTS protocol & RG ADT INPATIENT ENCOUNTER DRIVER
 ; hangs off of the DGPM MOVEMENT EVENTS protocol.
 ;
 ; RG ADT OUTPATIENT ENCOUNTER DRIVER hangs off of SDAM APPOINTMENTS
 ; EVENTS because of DBIA: 1320; RG ADT INPATIENT ENCOUNTER DRIVER
 ; hangs off of DGPM MOVEMENT EVENTS because of DBIA: 1181.
 ;
 ; Integration Agreements (IAs) utilized in this application:
 ; #1181-subscribers for the DGPM MOVEMENT EVENTS event driver
 ; #1320-subscribers for the SDAM APPOINTMENT EVENTS event driver
 ; #2070-check for a national ICN 1st piece, "MPI" node (global read)
 ; #2161-INIT^HLFNC2
 ; #2164-GENERATE^HLMA
 ; #2171-$$WHAT^XUAF4 (Name_"^"_Station Number, we're after Station #)
 ; #2541-$$KSP^XUPARAM (facility ien, file 4)
 ; #2624-$$SEND^VAFHUTL()
 ; #3015-PID segment generation (CIRN PD)
 ; #3016-EVN segment generation (CIRN PD)
 ; #3017-PD1 segment generator (CIRN PD)
 ; #3018-PV1 segment generator (CIRN PD)
 ; #3072-assign a local ICN to a patient
 ; #3630-BLDEVN^VAFCQRY, BLDPD1^VAFCQRY & BLDPID^VAFCQRY
 ; #2988-FILE^VAFCTFU
 ;
 ; I $D(RGDG101) then we know we've dropped into this software
 ; from the DGPM MOVEMENT EVENTS protocol (RG ADT INPATIENT
 ; ENCOUNTER DRIVER)
 ;
 ; Note: DFN is a supported variable in the case of admissions and
 ; discharges within the Registration package. (part of the discovery
 ; in the development of RG*1.0*14)
 ;
 ; first check if HL7 2.3 messaging has been disabled.  DBIA: 2624
 I '$P($$SEND^VAFHUTL(),"^",2) Q
 S RGOK=0,RGDATE=""
 I $D(RGDG101) D
 . I $G(DFN)'=+$G(DFN) Q  ; DFN must be valid
 .; if an national ICN is missing, assign a local then quit
 . I '$P($G(^DPT(DFN,"MPI")),"^") S RGLOCAL=$$ICNLC^MPIF001(DFN) Q
 . Q:$$IFLOCAL^MPIF001(DFN)  ; IA 2701, patient has local icn, quit
 . N %,VAERR,VAIP
 . S VAIP("D")="LAST" D IN5^VADPT ; dfn should be defined at this point
 . S RGTYPE=+$G(VAIP(2)) ; RGTYPE=movement type
 . I RGTYPE'=1&(RGTYPE'=3) Q  ; admission or discharges only
 . S RGENVR=$S(RGTYPE=1:"A1",1:"A2") ; A1=admission, A2=discharge
 . S RGDATE=$P($G(VAIP(3)),"^"),RGMOV=$G(VAIP(1))
 . ; RGDATE=movement date/time, RGMOV=ien #405
 . S:RGDATE]"" RGOK=1
 . Q
 ;
 ; I $D(RGSD101) then we know we've dropped into this software
 ; from the SDAM APPOINTMENT EVENTS protocol (RG ADT OUTPATIENT
 ; ENCOUNTER DRIVER)
 ;
 ; Check SDAMEVT for values between five and nine inclusive.  See if
 ; this particular outpatient encounter has a status of CHECKED OUT.
 ; gjc@Hines OI for patch 14
 ;
 ; Note: DFN is not a supported variable in the case of clinic
 ; appointments and workload crediting for count clinics within the
 ; Scheduling package. (part of the discovery in the development of
 ; RG*1.0*14)
 ;
 ; check-out, stop code add/edit, disp add/edit?
 N I
 I $D(RGSD101),($D(SDAMEVT))#2 N DFN D
 . ; Note: DFN is unstable; it's up to us to define it...
 . ;chk-out, stop code add, stop code change, disp add & disp change
 . I SDAMEVT<5!(SDAMEVT>9) Q
 . S RGTYPE=SDAMEVT,RGENVR="A3"
 . N RGSDOE,RGPARSE,RGPROC,RGTMP S RGPROC=0
 . F  S RGPROC=$O(^TMP("SDEVT",$J,SDHDL,RGPROC)) Q:'RGPROC  D
 .. S RGSDOE=0
 .. F  S RGSDOE=$O(^TMP("SDEVT",$J,SDHDL,RGPROC,"SDOE",RGSDOE)) Q:'RGSDOE  D
 ... S RGSDOE(0)=$G(^TMP("SDEVT",$J,SDHDL,RGPROC,"SDOE",RGSDOE,0,"AFTER"))
 ... ; Note: RGSDOE(0)=zero node of 409.68, DFN is the second piece 
 ... S DFN=$P(RGSDOE(0),"^",2) Q:'DFN  ; DFN must exist
 ... ; ignore current inpatients
 ... Q:$L($G(^DPT(DFN,.1)))  ; ward location check IA: 10035
 ...; if an national ICN is missing, assign a local then quit
 ... I '$P($G(^DPT(DFN,"MPI")),"^") S RGLOCAL=$$ICNLC^MPIF001(DFN) Q
 ... Q:$$IFLOCAL^MPIF001(DFN)  ; IA 2701, patient has local icn, quit
 ... K RGPARSE D PARSE^SDOE(.RGSDOE,"EXTERNAL","RGPARSE")
 ... I $G(RGPARSE(.12))="CHECKED OUT" S RGTMP=$P(RGSDOE(0),U)
 ... S:$G(RGTMP)>RGDATE RGDATE=RGTMP
 ... Q
 .. Q
 . S:$G(RGDATE)]"" RGOK=1
 . Q
 ; S ^TMP("RGTRACE",$J)=1
 I 'RGOK K RGLOCAL,RGTYPE,RGMOV,RGDATE,RGENVR,RGOK Q  ; quit if not A01 or A03
 I '($G(DGQUIET)) S:$D(^TMP("RGTRACE",$J)) RGTRACE=1
 N RGSITE S RGSITE=+$$SITE^VASITE
 ;before updating and broadcasting check to see if the date and/or event changed
 N LIST,X,OUT,RGCHNG,RGDLT,RGEVN D TFL^VAFCTFU1(.LIST,DFN) S (RGCHNG,OUT,X)=0 F  S X=$O(LIST(X)) Q:'X!(OUT=1)  D
 . S RGDATE=$P(RGDATE,"."),RGDLT=$P(LIST(X),"^",3),RGDLT=$P(RGDLT,"."),RGEVN=$P(LIST(X),"^",4)
 . I $P(LIST(X),"^")=$P($$SITE^VASITE,"^",3) S OUT=1 D
 .. I RGDATE'=RGDLT D  Q
 ... I RGDATE>RGDLT S RGCHNG=1
 .. I RGDATE=RGDLT D
 .. I $E(RGENVR,2)'=RGEVN D
 ... I RGENVR="A3" S RGCHNG=0
 ... I RGENVR="A1" S RGCHNG=1
 ... I RGENVR="A2" S RGCHNG=1
 ;if no change in DLT or Event Reason quit
 Q:RGCHNG=0
 D FILE^VAFCTFU(DFN,RGSITE_"^"_$G(RGDATE)_"^"_$G(RGENVR),1)
 ;do FILE^VAFCTFU to update DLT and event reason
 I $D(RGTRACE) D EVENT,EXIT Q
 N ZTDESC,ZTRTN,ZTSAVE,ZTIO,ZTDTH
 S ZTDESC="CIRN HL7 ADT-"_$S(RGTYPE=1:"A01",1:"A03")_" Messaging"
 S ZTRTN="EVENT^RGADT1",ZTIO="",ZTDTH=$H
 F I="DFN","RGDATE","RGTYPE","RGENVR" S ZTSAVE(I)=""
 ; check for $D of RGDG101 & RGSD101 need to know protocol executed
 S:$D(RGDG101) ZTSAVE("RGDG101")="" S:$D(RGSD101) ZTSAVE("RGSD101")=""
 S:$D(RGMOV) ZTSAVE("RGMOV")="" ; defined for admissions & discharges
 S:$D(SDOE) ZTSAVE("SDOE")="" ; file ien: 409.68, clinic check out
 D ^%ZTLOAD,EXIT
 K DGQUIET
 Q
 ;
EVENT ; build the HL7 message
 S:$D(ZTQUEUED) ZTREQ="@"
 S RGEVT=$S(RGTYPE=1:"A01",1:"A03") K HL
 D INIT^HLFNC2("RG ADT-"_RGEVT_" 2.4 SERVER",.HL)
 I $G(HL) Q  ; error
 D BUILD
 D GENERATE^HLMA("RG ADT-"_RGEVT_" 2.4 SERVER","LM",1,.RGRSLT,"",.HL)
 D KILL^HLTRANS
 K HLA("HLS"),RGDATE,RGDG101,RGENVR,RGEVT,RGSD101,RGTYPE
 Q
EXIT ; kill and quit
 K ^TMP("RGTRACE",$J),RGDATE,RGENVR,RGEVT,RGOK,RGLOCAL,RGMOV,RGPAT
 K RGRSLT,RGFSTR,RGTRACE,RGTYPE
 Q
BUILD ; build the ADT message
 ; EVN segment
 N CNT,ERR,EVN,RGCNT,SEQ
 S RGCNT=1
 D BLDEVN^VAFCQRY(DFN,"1,2,4,5,6,7",.EVN,.HL,$G(HL("ETN")))
 S HLA("HLS",RGCNT)=$G(EVN(1)) S RGCNT=RGCNT+1
 N PID S SEQ="ALL" D BLDPID^VAFCQRY(DFN,1,.SEQ,.PID,.HL,.ERR) S HLA("HLS",RGCNT)=PID(1) S X=1,CNT=1 F  S X=$O(PID(X)) Q:'X  I $D(PID(X)) S HLA("HLS",RGCNT,CNT)=PID(X),CNT=CNT+1
 S RGCNT=RGCNT+1
 ; PD1 segment
 N PD1
 S SEQ="3" D BLDPD1^VAFCQRY(DFN,.SEQ,.PD1,.HL,.ERR) S HLA("HLS",RGCNT)=PD1(1)
 S RGCNT=RGCNT+1
 ; PV1 segment
 S RGFSTR="2,3,4,5,"_$$COMMANUM(7,45)
 ;for admission/discharges (registration)
 I RGTYPE=1!(RGTYPE=3) S HLA("HLS",4)=$$IN^VAFHLPV1(DFN,RGDATE,RGFSTR,RGMOV,"","")
 ;for scheduling events: checkout
 I RGTYPE'=1&(RGTYPE'=3) S HLA("HLS",4)=$$EN^VAFHLPV1("",,RGFSTR,,HL("Q"),HL("FS"))
 S HLA("HLS",4)=$$FAC(HLA("HLS",4))
 ; adding ZPD segment for POW Status - patch P
 S HLA("HLS",5)=$$EN1^VAFHLZPD(DFN,"1,17,21,34") ;**45 changed to EN1 call and added PSEUDO SSN REASON TO ZPD SEGMENT
 ;**45 added 21 and 1 to ZPD call also
 Q
COMMANUM(FROM,TO) ;Build comma seperated list of numbers
 ;Input  : FROM - Starting number (default = 1)
 ;                   TO - Ending number (default = FROM)
 ;Output : Comma separated list of numbers between FROM and TO
 ;             (Ex: 1,2,3)
 ;Notes  : Call assumes FROM <= TO
 ;             copied from COMMANUM^VAFCADT2
 ;
 S FROM=$G(FROM) S:(FROM="") FROM=1
 S TO=$G(TO) S:(TO="") TO=FROM
 N OUTPUT,X
 S OUTPUT=FROM
 F X=(FROM+1):1:TO S OUTPUT=(OUTPUT_","_X)
 Q OUTPUT
 ;
FAC(X) ; set facility information, in the form of the Station Number, into
 ; PV1(3).
 ; input: the entire PV1 segment
 ; yield: updated PV1 segment; PV1(3) has facility information (Sta. #)
 N Y0,Y1 S Y0=$E(HL("ECH"),$L(HL("ECH")))_$$WHAT^XUAF4(+$$KSP^XUPARAM("INST"),99)
 S Y1=$P(X,HL("FS"),4),$P(Y1,$E(HL("ECH")),4)=Y0,$P(X,HL("FS"),4)=Y1
 Q X
