RGADT ;HIRMFO/GJC-ADT MESSAGE PROCESSING/ROUTING ;09/21/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4,8,14,17**;30 Apr 99
 Q  ; quit if called from the top
 ;
EN ;entry point to process local ADT messages.
 ;
 ;This is call by the following clients:
 ; RG ADT-A01 CLIENT & RG ADT-A03 CLIENT (Generate/Process
 ; Routine(771) & Routing Logic(774) field definitions
 ;
 ; Integration Agreements (IAs) utilized in this application:
 ; #2051-$$FIND1^DIC
 ; #2165-GENACK^HLMA1
 ; #2171-$$LKUP^XUAF4
 ; #2541-$$KSP^XUPARAM
 ; #2701-$$GETDFN^MPIF001
 ; #2702-$$MPINODE^MPIFAPI
 ; #2988-IAs for VAFCTFU utilities
 ; #3037-ADT/HL7 EVENT REASON (#391.72) file access
 ; #10106-$$FMDATE^HLFNC
 ;
 Q:$G(HL("MTN"))="ACK"  ; quit if a ACK message type is passed here
 K RGDC,RGDCDFN,RGDCERR,RGDCEVN,RGDCEVT1,RGDCPID,RGDCSFN,RGDCV,RGFLG
 S RGFLG=0,U="^" D INITIZE^RGRSUTIL ; copy HL7 message into local RGDC
 ; array
 S RGDCV=$$EN^RGRSMSH() ;return: dt rec'd^event dt^sending fac.(xternal)
 ; note: the above dates are in FileMan internal format
 S RGDCFROM=$$LKUP^XUAF4(+$P(RGDCV,U,3)) ; facility that sent the
 ; message.  Could differ from the facility where the event occurred 
 ; if inbound data is sent from a site running RG*1.0*17
 S RGDCPID=$$SEG1^RGRSUTIL("PID",1,"PID")
 S RGDCPV1=$$SEG1^RGRSUTIL("PV1",1,"PV1")
 S RGFLG=$S($P($P(RGDCPV1,HL("FS"),3),$E(HL("ECH")),4)["&":1,1:0)
 ; if RGFLG, the inbound message is from a patch 17 site and this
 ; site has patch 17 installed, so the message can be processed using
 ; TF data off the PV1 segment
 S RGDCEVN=$P($$SEG1^RGRSUTIL("EVN",1,"EVN"),HL("FS"),5)
 ; RGDCEVN is the event reason code
 S RGDCEVN=$$FIND1^DIC(391.72,"","AXM",RGDCEVN) ; event reason(internal)
 S RGDCEVT1=$P($$SEG1^RGRSUTIL("EVN",1,"EVN"),HL("FS"),2) ; event type
 S RGDCDFN=$$GETDFN^MPIF001(+$P(RGDCPID,HL("FS"),3))
 ; Note: $P(RGDCPID,HL("FS"),3) is: ICN_"V"_ICN checksum
 I RGFLG S RGDCSFN=$$SFN(RGDCPV1),RGDCSFN=$$LKUP^XUAF4(RGDCSFN)
 S:'RGFLG RGDCSFN=RGDCFROM ; TF from MSH segment
 ; RGDCSFN - obtain treating facility ien (file 4) from station #
 ;
 ; input variables to FILE^VAFCTFU
 ; RGDCDFN - patient ien ; RGDCSFN - treating facility
 ; $P(RGDCV,U,2) - date last treated ; RGDCEVN - event reason
 D FILE^VAFCTFU(RGDCDFN,RGDCSFN_U_$P(RGDCV,U,2)_U_RGDCEVN,$$SFCMOR(RGDCDFN,RGDCFROM))
 ; call to the TFL utility routine VAFCTFU.  Centrally located code
 ; to add or edit to the TFL file. If $$SFCMOR(RGDCDFN,RGDCFROM)
 ; returns 1, let the Pivot file handle updates (MFUs) to subscribers.
 ; If 0, file data and do not re-broadcast.
 ;
 D GENACK ; generate the 'ack' message
 ;
KILL ; kill and exit
 K HLINKP,HLINKX,HLL,RGDC,RGDCDFN,RGDCERR,RGDCEVN,RGDCEVT1,RGDCFROM,RGDCPID,RGDCPV1,RGDCSFN,RGDCV,RGFLG
 Q
 ;
DYNROU(RGDCEVT) ; dynamic message routing, but first need to update the
 ; TREATING FACILITY LIST (TFL-391.91) file at the local site
 ; input-{RGDCEVT=event type
 K RGDCEDT,RGDCEVTR,RGDCSITE
 S RGDCSITE=$$KSP^XUPARAM("INST"),U="^"
 S RGDCEDT=$$FMDATE^HLFNC($P($$EVN(),U,3)) ; determine event date/time
 S RGDCEVTR=$$FIND1^DIC(391.72,"","AXM",$P($$EVN(),U,5)) ; event reason
 ;
 ; input variables to FILE^VAFCTFU
 ; DFN - patient ien ; RGDCSITE - treating facility
 ; RGDCEDT - date last treated ; RGDCEVTR - event reason
 D FILE^VAFCTFU(DFN,RGDCSITE_U_RGDCEDT_U_RGDCEVTR,1)
 ; call to the TFL utility routine VAFCTFU.  Centrally located code
 ; to add or edit to the TFL file.
 ;
 ; route the message
 D EN^RGRSDYN("RG ADT-"_RGDCEVT_" CLIENT",0)
 K RGDCEDT,RGDCEVTR,RGDCSITE
 Q
EVN() ; pass back the EVN segment.
 N I,X S I=0
 F  S I=$O(HLA("HLS",I)) Q:I'>0  D  Q:$D(X)
 . S:$P(HLA("HLS",I),U)="EVN" X=$G(HLA("HLS",I))
 . Q
 Q $G(X)
GENACK ; Compile the 'ACK' segment, generate the 'ACK' message.
 S HLA("HLA",1)="MSA"_HL("FS")_$S($G(RGDCERR)]"":"AE",1:"AA")_HL("FS")_HL("MID")_$S($G(RGDCERR)]"":HL("FS")_$G(RGDCERR),1:"")
 S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="LM",HLFORMAT=1
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.HLRESTLA)
 Q
 ;
SFCMOR(DFN,SFAC) ; sent from CMOR?  Determine if the patient's CMOR sent
 ; this VistA HL7 message
 ; input: DFN (patient dfn); SFAC (sending facility, ptr file 4)
 ; yield: 1 if sent from CMOR of patient, else 0
 Q $S(SFAC=$P($$MPINODE^MPIFAPI(DFN),"^",3):1,1:0)
 ;
SFN(X) ; return the station number of the sending facility; PV1(3)
 ; input: PV1 segment
 ; yield: station number of sending facility
 N Y S Y=$P(X,HL("FS"),4) ; pnt_of_care~room~bed~&fac. station #
 S Y=$P(Y,$E(HL("ECH")),4) ; &fac. station #
 Q $P(Y,$E(HL("ECH"),4),2) ; fac. station #
