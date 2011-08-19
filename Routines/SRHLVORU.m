SRHLVORU ;B'HAM ISC/DLR - Surgery Interface Receiver of ORU message ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;processing of incoming ORU message
 ; 1. process MSH - create field separator and other encoding characters
 ; 2. process PID - establish patient IEN
 ; 3. process OBR - create observation identifier and stuff fields
 ;    a. process OBX - using OBR identifier stuff fields
 ;    b. process NTE - using OBR identifier stuff anesthesia comment
 ; 4. use ^TMP("SRHL" global to create a descrepancy report if needed
 ;
 ;  Troubleshooting
 ; What to do if a field is not being added?
 ;  1. View descrepancy message.
 ;  2. Check the Flag Interface Fields option for a receive flag.
 ;  3. Check to see if the field has an input transform.
 ;
REC N DFN,DFN1,HLCOMP,HLREP,HLSUB,II,SG,SRERR,SRI,SRHLX,SSN,TYPE,QOBR
 S QOBR=1 ;flag for stopping OBR segments from being processed
 S UPDATE=0
 S SRHLX=1 K ^TMP("SRHL")
 S SRNOCON=1 ;no concurrent case information
 S II=0 F  S II=$O(^HL(772,HLDA,"IN",II)) Q:'II!$D(HLERR)  S MSG=^HL(772,HLDA,"IN",II,0),SG=$E(^(0),1,3)  D PICK
 I $D(DR)&('$D(HLERR))&($G(QOBR)=0) D ^DIE K DR,DO,DIE
EXIT ;
 S HLMTN="ACK",HLSDT=1,SRI=1
 D MSA^SRHLVUO(.SRI,$S($D(HLERR):"AE",1:"AA"))
 I $D(HLERR) D ERR^SRHLVUO(.SRI,.SRERR)
 W:$G(HLERR)'="" !,"ERROR ",$G(HLERR)
 W:$G(HLERR)="" !,"NO ERROR"
 D EN^HLTRANS
 I $D(^TMP("SRHL")) K DIC S DIC="^XMB(3.8,",X="SRHL DISCREPANCY" D ^DIC K DIC Q:Y=-1  D REPORT(HLMID)
 Q
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" S HLERR="Invalid segment "_$G(SG)_" in message "_$G(TYPE) Q
 Q
MSH ;process the MSH segment
 S HLFS=$E(MSG,4),HLECH=$E(MSG,5,8)
 S HLCOMP=$E(HLECH,1),HLREP=$E(HLECH,2),HLSUB=$E(HLECH,4)
 S TYPE=$P(MSG,HLFS,9)
 Q
PID ;process PID segment
 N I,PAT,SSN
 S SSN=$P(MSG,HLFS,20),PAT=$$FMNAME^HLFNC($P(MSG,HLFS,6))
 I $G(PAT)'="" F I=0:0 S I=$O(^DPT("B",PAT,I)) Q:'I  S DFN=I
 I $G(SSN)'="" S DFN1=$O(^DPT("SSN",SSN,0))
 I $G(DFN)=""&($G(DFN1)="") S HLERR="Invalid Patient Name or SSN"
 E  I $G(DFN)'=$G(DFN1) S ^TMP("SRHL",SRHLX)=PAT_" does not match SSN, "_SSN_".",SRHLX=SRHLX+1
 Q
OBX ;OBX segments processing
 I '$D(HLERR)&($G(QOBR)=0) D:'$D(DR)&($D(OBR)) OBR^SRHLVUI("",OBR) D OBX^SRHLVUI2(MSG,OBR) I UPDATE=1 W !,"DR ",DR D ^DIE K DR,DO S UPDATE=0
 Q
NTE ;NTE segment processing
 I $D(DR)&('$D(HLERR))&($G(QOBR)=0) D ^DIE K DR,DO
 I '$D(HLERR)&($G(QOBR)'=1)&($D(OBR)) D NTE^SRHLVUI2(MSG,OBR)
 Q
DSC Q
OBR ;OBR segment processing
 I $D(DR)&('$D(HLERR))&($G(QOBR)=0) W !,"OBR DR",DR D ^DIE K DR,DO,DIE
 N CASE,CDFN,ID,IEN
 S QOBR=0
 ;set-up the IDentifier and check the mapping file (#133.2) for a match
 S ID=$P($P(MSG,HLFS,5),HLCOMP,2) I $G(ID)="" S HLERR="Missing OBR identifier" Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" D SET("Invalid OBR identifier",OBR,"",.SRHLX) Q
 S CASE=$P(MSG,HLFS,4) I CASE="" S HLERR="NULL Case Number" Q
 I '$D(^SRF(CASE,0)) S HLERR="Invalid Surgery Case Number" Q
 I $D(^SRF(CASE,0)) S CDFN=$P(^SRF(CASE,0),U) I CDFN'=$G(DFN)&((CDFN'=$G(DFN1))) S HLERR="Mismatch of PID patient and Case patient" Q
 ;get the next OBR segment that is set to receive
 I $$CHECK(IEN)'=1 S QOBR=1 Q
 S (SRTN,DA)=CASE,DIE=$P(^SRO(133.2,IEN,0),U,2)
 ;process the OBR identifier that is set to receive
 I $$CHECK(IEN)=1 S OBR=MSG D:'$D(HLERR) OBR^SRHLVUI(IEN,OBR)
 Q
CHECK(IEN) ;check for valid receivable segments in file 133.2 (Surgery Interface)
 I $G(IEN)="" Q 0
 Q $P($G(^SRO(133.2,IEN,0)),U,4)["R"
REPORT(HLMID) ;creates discrepancy report to be mailed to SR HL7 mailgroup
 S XMSUB="Message #"_HLMID_" contains Surgery application discrepancies."
 S XMY("G.SRHL DISCREPANCY")=""
 S XMTEXT="^TMP(""SRHL"","
 D ^XMD
 Q
SET(ECODE,OBR,OBX,SRHLX) ;sets up discrepancy global
 S ^TMP("SRHL",SRHLX)=ECODE_" at position OBR-"_$P(OBR,HLFS,2)_$S($G(OBX)'="":" OBX-"_$P(OBX,HLFS,2),1:"")_".",SRHLX=SRHLX+1
 Q
