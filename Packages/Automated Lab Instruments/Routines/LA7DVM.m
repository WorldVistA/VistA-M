LA7DVM ;SFCIOFO/MJM/DALOI/PWC - EXTRACTION ROUTINE FOR VERIFIED "MI" LAB RESULTS TO CAREVUE&LIFELOG;01/14/2000
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**53,58,62**;Sep 27, 1994
 ;
 ; Reference to ^DPT( supported by DBIA #10035
 ; Reference to ^%DTC supported by DBIA #10000
 ; Reference to ^DIC supported by DBIA #10006
 ; Reference to INIT^HLFNC2 supported by DBIA #2161
 ; Reference to GENERATE^HLMA supported by DBIA #2164
 ; Reference to DEM^VADPT supported by DBIA #10061
 ; Reference to $$EN^VAFHLPID supported by DBIA #263
 ; Reference to $$FMTHL7^XLFDT supported by DBIA #10103
 ; Reference to ^XMD supported by DBIA #10070
 ;
EN ;ENTRY POINT FROM VERIFICATION PROCESS
 N I
 S DFN=$P(^LR(LRDFN,0),"^",3)
 S GMTS1=9999999-LRIDT,GMTS2=9999999-LRIDT,VFLAG=1 D DEM^VADPT
 D INIT,RR^LR7OR1(DFN,,GMTS1,GMTS2,"MI"),HL7
 K ^TMP("LRRR",$J),DFN,EXPAND,NXREC,MAX,SEX
 Q
 ;
INIT ;Set up needed variables
 S NXREC=0,MAX=75,EXPAND=1,SEX=$P(VADM(5),"^",1)
 Q
 ;
HL7 ; Build the HL7 message and send to the Ward.
 K HL,HLA,HLP,HLRESLT  ; Clean the enviroment
 S DIC="^ORD(101,",DIC(0)="MNOZ",X="LA7D CARELIFE SERVER" D ^DIC
 I Y=-1 S TEXT="Unable to send out test result to CAREVUE, Protocol Server is not setup" K Y,DIC D ERROR Q
 S LA7DVEID=+Y  ; Server Protocol IEN
 K Y,DIC
 D INIT^HLFNC2(LA7DVEID,.HL)
 I $G(HL) S TEXT="Unable to send out test result to CAREVUE, Protocol Server is downed" D ERROR Q
 N COUNT
 S LA7DVTYP="LM",LA7DVFMT=1
 S HLFS=$E(HL("FS")),Z=$E(HL("ECH"),1),COUNT=1,S=HLFS
 S HLA("HLS",COUNT)=$$EN^VAFHLPID(DFN,"2,3,5,7,8,19")
 S HOLD=COUNT+1  ;  Hold the space for OBR segment
 S COUNT=COUNT+2,LA7DVTXT=""
 ; Start the NTE segment
 F  S LA7DVTXT=$O(^TMP("LRRR",$J,DFN,"MI",LRIDT,"N",LA7DVTXT)) Q:LA7DVTXT=""  D
 . S HLA("HLS",COUNT)="NTE"_HLFS_HLFS_"L"_HLFS_^TMP("LRRR",$J,DFN,"MI",LRIDT,"N",LA7DVTXT)
 . S COUNT=COUNT+1
 ; Start the OBX segment
 S (OBX,LA7DVSCR)=""
 F  S OBX=$O(^TMP("LRRR",$J,DFN,"MI",LRIDT,OBX)) Q:+OBX=0  D
 . S LA7DVOBX=^TMP("LRRR",$J,DFN,"MI",LRIDT,OBX)
 . S LINE1="OBX"_HLFS_HLFS_"TX"_HLFS_"TX"_HLFS_HLFS_$P(LA7DVOBX,"^",2)_HLFS_HLFS
 . S HLA("HLS",COUNT)=LINE1_HLFS_HLFS_HLFS_HLFS
 . S COUNT=COUNT+1
 . K LINE1
 ; Start the OBR segment
 S LA7DVTMP=0,LA7DVTMP=$O(^LR(LRDFN,"MI",LA7DVTMP)) ; Get the first entry of this collection
 S SITE=$P(^LR(LRDFN,"MI",LA7DVTMP,0),"^",5),LA7DVSCR=$P(^LAB(61,SITE,0),"^",1)
 ; change all $$HLDATE^HLFNC calls to $$FMTHL7^XLFDT   pwc-10/6/2000
 S LA7DVCOL=$$FMTHL7^XLFDT($P(^LR(LRDFN,"MI",LA7DVTMP,0),"^"))  ; Get theCollection date/time
 S LA7DVRCV=$$FMTHL7^XLFDT($P(^LR(LRDFN,"MI",LA7DVTMP,0),"^",10)) ; Get the Specimen Received Date/time
 S LA7DVRCP=$$FMTHL7^XLFDT($P(^LR(LRDFN,"MI",LA7DVTMP,0),"^",3))  ; Get the Report Complete Date/time
 S LA7DVACC=$P(^LR(LRDFN,"MI",LA7DVTMP,0),"^",6)  ; Get the Accession #
 S HLA("HLS",HOLD)="OBR"_HLFS_HLFS_HLFS_LA7DVACC_HLFS_"MI"
 S $P(HLA("HLS",HOLD),HLFS,8)=LA7DVCOL
 S $P(HLA("HLS",HOLD),HLFS,15,16)=LA7DVRCV_HLFS_LA7DVSCR
 S $P(HLA("HLS",HOLD),HLFS,23,29)=LA7DVRCP_S_S_"LAB"_S_S_S_S_LA7DVL
 S HLP("NAMESPACE")="LA"
 D GENERATE^HLMA(LA7DVEID,LA7DVTYP,LA7DVFMT,.HLRESLT,"",.HLP)
 I $P(HLRESLT,"^",2) D ERROR
 K LA7DVRCP,LA7DVSCR,HOLD,LA7DVCOL,LA7DVACC,LA7DVTMP,LA7DVOBX,COUNT
 K LA7DVTXT,LA7DVFMT,LA7DVEID,LA7DVTYP,OBX,GMTS1,GMTS2,HLFS,HLP,HLRESLT
 K LA7DVRCV,LRSPEC,S,SITE,SPEC,TEXT,VADM,VAIN,VFLAG,XMDT
 K XMDUZ,XMSUB,XMTEXT,XMY,Z
 Q
ERROR ; Send out error message when HL7 fail to build the message
 D INP^VADPT
 S XMSUB="ERROR IN SENDING LAB RESULTS TO "_$P(VAIN(4),"^",2)_" WARD"
 D NOW^%DTC S XMDT=X K X
 S XMDUZ=.5,XMY("G.CARELIFE RESULT ERROR")=""
 S A(1)="There was an error in building an HL7 Lab Result Message for accession"
 I LA7DVACC'="" D
 . S A(2)=" # "_LA7DVACC_"of patient name: "_$P(^DPT(DFN,0),"^")_" at "_$P(VAIN(4),"^",2)_" Ward."
 . S A(3)="The error was "_$P(HLRESLT,"^",3)_"."
 E  D
 . S A(2)="The error was "_TEXT_"."
 . S A(3)=""
 S A(4)="Please make a note of it and take any actions that necessary"
 S XMTEXT="A(" D ^XMD
 K A
 Q
