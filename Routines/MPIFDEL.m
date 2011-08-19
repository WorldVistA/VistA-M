MPIFDEL ;SF/MJM,CMC-DELETE PATIENT FROM MPI ;JUL 14, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,3,9,19,17,21,27,28,25**;30 Apr 99
 ;
 ;Integration Agreements Utilized:
 ; ^DPT(         - IA #2070
 ; $$EN^VAFCPID  - IA #3015
 ; START^RGHLLOG - IA #2796
 ; EXC^RGHLLOG   - IA #2796
 ; STOP^RGHLLOG  - IA #2796
 ; $$DELALLTF^VAFCTFU  - IA #2988
 ; $$EN^VAFCPID  - IA #3015
 ;
INTER ;
 ;Entry point for Inactivate Patient from MPI option [MPIF PAT INACT]
 ;No input or output variables ^DPT
 N DIC,DA,DFN,HL,ERROR,CNT,HLRST,ICN,DATE,MPIFCMOR,DTOUT,DUTOUT
 S ERROR=""
 S DIC=2,DIC(0)="QEAM" D ^DIC Q:+Y<0  S DFN=+Y
 S ICN=$P($$MPINODE^MPIFAPI(DFN),"^")
 I ICN=""!(ICN=-1) W !,"** Patient Does NOT have an ICN **" Q
 S MPIFCMOR=+$$LKUP^XUAF4(+$$GETVCCI^MPIF001(DFN))
 I MPIFCMOR=0 W !,"*** Could NOT Inactivate Patient from MPI: Coordinating Master of Record is Not Defined ***" Q
 I $$PAT^MPIFNQ(DFN)'=+$P($$SITE^VASITE,"^",3) W !,"*** Could NOT Inactivate Patient from MPI: Coordinating Master of record site is '"_$$CMOR2^MPIF001(DFN)_"'. You MUST be the CMOR ***" Q
 S ICN=$$GETICN^MPIF001(DFN)
 ;ask user if they are sure
 N DIR,Y S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="Are you sure you want to Inactivate this Patient?"
 D ^DIR
 K DIR
 Q:$D(DTOUT)!($D(DUTOUT))!('Y)
 D HL7(DFN,.ERROR)
 I ERROR="" D DELETE(DFN) S ERROR=$$DELALLTF^VAFCTFU(+ICN),ERROR=""
 I ERROR=""!(ERROR=0) W !,"*** Inactivated on YOUR system, message sent to MPI to Inactivate ***"
 I ERROR'="" W !,"Error Occurred - "_ERROR
 Q
 ;
HL7(DFN,ERROR) ; create HL7 message
 ; check if no subscribers
 N SUB,HL,CNT,ICN,%,HLDATE,TFC,IEN
 K HLL,MPIFDEL
 S ICN=$$GETICN^MPIF001(DFN),ERROR=""
 Q:$E(ICN,1,3)=$P($$SITE^VASITE(),"^",3)
 ; ^ don't generate HL7 message if local ICN
 S SUB=$$QUERYTF^VAFCTFU1(+ICN,"MPIFDEL"),TFC=0
 I $D(MPIFDEL) D
 .S IEN="" F  S IEN=$O(MPIFDEL(IEN)) Q:IEN=""  I +$G(MPIFDEL(IEN))'=$P($$SITE^VASITE,"^") S TFC=TFC+1
 .I TFC'=0 S ERROR="Attempted to Inactivate an ICN and Patient is Shared.  Can't Inactivate patient DFN= "_DFN Q
 Q:ERROR'=""
 D NOW^%DTC S HLDATE=$$HLDATE^HLFNC(%,"DT")
 S HL=0,CNT=0
 D INIT^HLFNC2("MPIF A29 SERVER",.HL)
 I HL S ERROR="ERROR = "_HL_" During INIT^HLFNC2 for MPIF A29 Server for Patient DFN= "_DFN D EXC(DFN,ERROR,220)
 S CNT=CNT+1,HLA("HLS",CNT)="EVN"_HL("FS")_"A29"_HL("FS")_HLDATE_HL("FS")_HL("FS")_""_HL("FS")
 S CNT=CNT+1,HLA("HLS",CNT)=$$EN^VAFCPID(DFN,"2,3,5")
 ; message only goes to MPI Link
 D GENERATE^HLMA("MPIF A29 SERVER","LM",1,.HLRST,"",.HL)
 I 'HLRST S ERROR="Error During Generate for MPIF A29 Server Error= "_HLRST_" for DFN "_DFN D EXC(DFN,ERROR,220)
 K MPIFDEL
 Q
 ;
PAT1 ;entry point for tasked job from .01 in Patient file for ZZ patients
 N ERR,TDA
 S ERR=""
 S TDA=DA
 L +^DPT("INAC",DA):2
 Q:'$T
 D PAT(DA,.ERR)
 S ZTREQ="@"
 L -^DPT("INAC",TDA)
 Q
 ;
PAT(DFN,ERROR) ;Programmer API to Delete MPI entry and remove ICN data from DPT
 ; if CMOR not defined but is a local CMOR, inactivate and don't log exception
 S ERROR=""
 I $G(DFN)="" S ERROR="DFN not defined" Q
 Q:+$$GETICN^MPIF001(DFN)<0  ; incase has been inactivated already
 I $E($P($$GETICN^MPIF001(DFN),"^"),1,3)'=+$P($$SITE^VASITE,"^",3),+$$PAT^MPIFNQ(DFN)'=+$P($$SITE^VASITE,"^",3) S ERROR="Attempt to Inactivate Patient, DFN= "_DFN_" this site is not the CMOR for this patient" D EXC(DFN,ERROR,226) Q
 D HL7(DFN,.ERROR)
 I ERROR="" S ERROR=$$DELALLTF^VAFCTFU(+$$GETICN^MPIF001(DFN)),ERROR="" D DELETE(DFN)
 Q
DELETE(DFN) ;
 N ARRAY,TMP
 S ARRAY(991.01)="@",ARRAY(991.02)="@",ARRAY(991.03)="@",ARRAY(991.04)="@",ARRAY(991.05)="@"
 S ARR="ARRAY"
 S TMP=$$UPDATE^MPIFAPI(DFN,ARR)
 K ARR
 Q
 ;
EXC(DFN,ERROR,TYPE) ; subscribers, log exception
 D START^RGHLLOG(0)
 D EXC^RGHLLOG(TYPE,ERROR,$G(DFN))
 D STOP^RGHLLOG(0)
 Q
 ;
ZZSET(DA,NAME) ;this entry point checks to see if .01 of Patient file entry
 ;starts with at least two Zs
 ;if it does and an ICN is present, it will be inactivated
 ;
 Q
 Q:$E(NAME,1,2)'="ZZ"
 ;task inactivation off
 I +$$GETICN^MPIF001(DA)>0 D
 .S ZTRTN="PAT1^MPIFDEL",ZTDESC="Inactivate ICN for 'ZZ'd patient"
 .S ZTIO="",ZTSAVE("DA")=DA,ZTSAVE("NAME")=NAME
 .S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 .D ^%ZTLOAD
 .K ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTREQ
 Q
ZZKILL(DA,NAME) ;This entry point checks if there is an ICN present, if so
 ;if will be inactivated, following the inactivate rules
 Q
 N ERR S ERR=""
 I +$$GETICN^MPIF001(DA)>0 D PAT(DA,.ERR)
 Q
SSET(DA,SSN) ; this entry point checks to see if the SSN has been changed
 ; to 5 leading zeros and if the ICN is present, if so, it will be
 ; inactivated.
 Q:$E(SSN,1,5)'="00000"
 I +$$GETICN^MPIF001(DA)>0 D
 .S ZTRTN="PAT1^MPIFDEL",ZTDESC="Inactivate ICN for 'ZZ'd patient"
 .S ZTIO="",ZTSAVE("DA")=DA,ZTSAVE("SSN")="SSN"
 .S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 .D ^%ZTLOAD
 .K ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTREQ
 Q
