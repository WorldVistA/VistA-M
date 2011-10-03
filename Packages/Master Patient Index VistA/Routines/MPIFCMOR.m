MPIFCMOR ;BHM/RGY-Set and broadcast CMOR changes ;FEB 20, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,6,11,30**;30 Apr 99
 ;
 ; Intergation Agreements Utilized:
 ;   EXC^RGHLLOG    IA #2796
 ;   START^RGHLLOG  IA #2796
 ;   STOP^RGHLLOG   IA #2796
 ;   $$EN^VAFCPID   IA #3015
 ;
BROAD(REQNO,ER) ;Broadcase CMOR change to everyone
 N CN,RGL,HL,CNT,HLA,PDX,ICN,HOME,RGLINK,RGL,TMP,II,CLIENT,HLA,USER,N0,NDATE,RLST,SERVER,ERR,MPILK
 S ER=0
 S SERVER="MPIF CMOR RESULT SERVER"
 S CLIENT="MPIF CMOR RESULT CLIENT"
 S N0=$G(^MPIF(984.9,REQNO,0))
 S DFN=$P(N0,"^",4)
 S NDATE=$P(N0,"^",3)
 N X,Y,DIC
 S DIC="^VA(200,",DIC(0)="MZO",X="`"_+$P(N0,"^",2)
 D ^DIC
 I $G(Y)<1 S USER="Automatic Processing"
 I $G(Y)>0 S USER=$G(Y(0,0))
 S SITE=+$P($$SITE^VASITE,"^",3)
 S ICN=$$ICN^MPIFNQ(DFN)
 S HOME=$P($$MPINODE^MPIFAPI(DFN),"^",3)
 S CN=+$P($$MPINODE^MPIFAPI(DFN),"^",5)
 S HL=0,CNT=0
 K ^XTMP("MPIFCMOR","ERR")
 D INIT^HLFNC2(SERVER,.HL)
 I HL S ERR=HL D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(220,"Unable to setup HL7 for Change CMOR Request # "_REQNO_" for ICN= "_ICN,DFN)
 .D STOP^RGHLLOG()
 .D RESET(DFN,REQNO)
 K HLL("LINKS")
 S MPILK=$$MPILINK^MPIFAPI ;routing all messages through the MPI
 I +MPILK<0 D  Q
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(224,"No MPI link found for Change CMOR Request # "_REQNO_" for ICN="_ICN,DFN)
 .D STOP^RGHLLOG()
 .D RESET(DFN,REQNO)
 .S ER="-1^No Links found"
 ;Broadcast new CMOR to MPI which will send it out to all sites
 S HLL("LINKS",1)=CLIENT_"^"_MPILK
 S CNT=CNT+1,HLA("HLS",CNT)="EVN"_HL("FS")_"A31"_HL("FS")_NDATE_HL("FS")_HL("FS")_""_HL("FS")_USER_HL("FS")_"NEW"
 S CNT=CNT+1,PDX=$$EN^VAFCPID(DFN,"1,2,3,5,6,7,8,11,12,13,14,16,17,19")
 S HLA("HLS",CNT)=PDX
 S CNT=CNT+1,HLA("HLS",CNT)="PV1"_HL("FS")_HL("FS")_HL("FS")_$P($$NNT^XUAF4(+$P(N0,"^",7)),"^",2)_HL("FS")_HL("FS")_HL("FS")_$P($$SITE^VASITE,"^",3)
 D GENERATE^HLMA(SERVER,"LM",1,.RLST,"",.HL)
 I 'RLST D
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(220,"Unable to Generate HL7 msg for Change CMOR Request # "_REQNO_" for ICN= "_ICN,DFN)
 .D STOP^RGHLLOG()
 .D RESET(DFN,REQNO)
 .S ER="-1^error in HL7 sending msg"
 Q
RESET(DFN,REQNO) ;
 ; reset status to pending approval and change CMOR to this site
 N ERR
 D RESET2^MPIFREQ(REQNO)
 S ERR=$$CHANGE^MPIF001(DFN,+$$SITE^VASITE)
 Q
 ;
SET(DFN,SITE) ;Set CMOR for patient to site
 NEW RESULT
 S RESULT=$$CHANGE^MPIF001(DFN,SITE)
 Q
