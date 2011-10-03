PSO55FX2 ;ISC-BHAM/MHA - cleanup of bad p nodes and mismatched Rxs in file 55 ; 07/26/2001
 ;;7.0;OUTPATIENT PHARMACY;**69**;DEC 1997
 ;External reference to ^PS(55 is supported by DBIA 2228
 ;External reference ^DGPM("AMV1" is supported by DBIA 2249
 Q
BEG ;
 I '$D(DUZ) W !!!!,"* DUZ NOT DEFINED - QUITTING *" Q
 D MSG^PSO55FX3
 K %DT D NOW^%DTC S %DT="RAEX",%DT(0)=%,%DT("A")="Select the Date/Time to queue this job: "
 D ^%DT K %DT
 I $D(DTOUT)!(Y<0) W !!!?10,"Job not queued - quitting!" Q
 S ZTDTH=$G(Y),ZTSAVE("DUZ")="",ZTIO="",ZTRTN="EN^PSO55FX2",ZTDESC="Cleanup of bad 'P' cross-references in Pharmacy Patient file"
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued To Run!",!
 Q
EN ;
 I $G(^XTMP("PSO2",69))="PH1" D PH2^PSO55FX3 Q
 S TY="PSO",JN=69 S (DFN,ZA,ZB,ZC)=0
 I '$D(^XTMP(TY,JN)) S X1=DT,X2=+90 D C^%DTC S ^XTMP(TY,JN,0)=$G(X)_"^"_DT G EN1
 I $D(^XTMP(TY,JN,1)) D
 .S DFN=$P(^XTMP(TY,JN,1),"^") S:'DFN DFN=0
 .S ZA=$P(^XTMP(TY,JN,1),"^",2) S:'ZA ZA=0
 .S ZB=$P(^XTMP(TY,JN,1),"^",3) S:'ZB ZB=0
 .S ZC=$P(^XTMP(TY,JN,1),"^",4) S:'ZC ZC=0
EN1 S STA="ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DELETED^DISCONTINUED^DISCONTINUE (EDIT)^PROVIDER HOLD"
 F  S DFN=$O(^PS(55,DFN)) Q:'DFN  D CHK1,CHK2 S ^XTMP(TY,JN,1)=DFN_"^"_ZA_"^"_ZB_"^"_ZC
 D SMAIL S ^XTMP("PSO2",69)="PH1" D PH2^PSO55FX3
 Q
CHK1 ;for every patient go through the "P" x-ref
 K XZ S (RB,I)=0 F  S I=$O(^PS(55,DFN,"P",I)) Q:'I  S RX=$P($G(^(I,0)),"^") D:RX
 .;checks for non-existing Rxs or Rxs with no header record & if found clean it up
 .I '$D(^PSRX(RX)) S RB=1,ZA=ZA+1,XZ(RX)="" K ^PS(55,DFN,"P",I,0) Q
 .I '$D(^PSRX(RX,0)) S RB=1,ZA=ZA+1,XZ(RX)="" K ^PS(55,DFN,"P",I,0) Q
 .;checks for patient mis-match
 .I DFN'=+$P(^PSRX(RX,0),"^",2) D
 ..S ZA=ZA+1,RB=1,XZ(RX)="" K ^PS(55,DFN,"P",I,0)
 ..D:+$P($G(^PSRX(RX,"STA")),"^")=12 ALOG
 D:RB RBP
 Q
ALOG ;
 S CDFN=+$P(^PSRX(RX,0),"^",2)
 Q:$P($G(^DPT(CDFN,.35)),"^")
 S (II,JJ,CT)=0,AL="ZZZ"
 F  S II=$O(^PSRX(RX,"A",II)) Q:'II  S:$P($G(^(II,0)),"^",5)["Auto Discontinued on Admission" JJ=II
 I JJ S CDT=$P($G(^PSRX(RX,"A",JJ,0)),"^") Q:'CDT  D
 .S X1=$E(CDT,1,7),X2=-3 D C^%DTC S SDT=X-.01,EDT=X_".99999"
 .F  S SDT=$O(^DGPM("AMV1",SDT)) Q:'SDT!(SDT>EDT)!(CT)  D
 ..S PDFN=0 F  S PDFN=$O(^DGPM("AMV1",SDT,PDFN)) Q:'PDFN!(PDFN=CDFN)
 ..S:+PDFN=CDFN CT=1
 Q:CT
 S:JJ AL="Auto Discontinued on Admission" S (II,JJ)=0
 F  S II=$O(^PSRX(RX,"A",II)) Q:'II  S:$P($G(^(II,0)),"^",5)["Auto Discontinued Due" JJ=II
 S:JJ AL=$P(^PSRX(RX,"A",JJ,0),"^",5)
 S DIV=$P($G(^PSRX(RX,2)),"^",9) S:DIV="" DIV=998899
CREC ;
 S SSN=$P($G(^DPT(CDFN,0)),"^",9) S:SSN="" SSN="N/A"
 S NAME=$P($G(^DPT(CDFN,0)),"^")_" ("_SSN_")" S:NAME="" NAME="N/A"
 ;S STAT=$P(STA,"^",$P($G(^PSRX(RX,"STA")),"^")+1) S:STAT="" STAT="N/A"
 S:'$D(^XTMP(TY,JN,2,DIV,AL,CDFN,RX)) ^XTMP(TY,JN,2,DIV,AL,CDFN,RX)=NAME_"^"_$P(^PSRX(RX,0),"^")_"^"_$S(AL="ZZZ":"",1:AL),ZC=ZC+1
 S ^XTMP(TY,JN,"Z",DIV,CDFN,RX)=""
 Q
 ;
CHK2 ;for every patient go through the "P","A" x-ref
 S J=0 F  S J=$O(^PS(55,DFN,"P","A",J)) Q:'J  S RX=0 F  S RX=$O(^PS(55,DFN,"P","A",J,RX)) Q:'RX  D
 .;checks for non-existing Rxs or Rxs with no header record & if found clean it up
 .I '$D(^PSRX(RX)) S:'$D(XZ(RX)) ZB=ZB+1 K ^PS(55,DFN,"P","A",J,RX) Q
 .I '$D(^PSRX(RX,0)) S:'$D(XZ(RX)) ZB=ZB+1 K ^PS(55,DFN,"P","A",J,RX) Q
 .;checks for patient mismatch
 .I DFN'=+$P(^PSRX(RX,0),"^",2) D
 ..S:'$D(XZ(RX)) ZB=ZB+1 K ^PS(55,DFN,"P","A",J,RX)
 ..D:+$P($G(^PSRX(RX,"STA")),"^")=12 ALOG
 K XZ Q
RBP ;rebuild the "P" header rec
 S (NR,LR,I)=0 F  S I=$O(^PS(55,DFN,"P",I)) Q:'I  S LR=I,NR=NR+1
 S ^PS(55,DFN,"P",0)="^55.03PA^"_LR_"^"_NR
 K NR,LR,RB Q
 ;
SMAIL ;
 S ZZ="PSOFX" K ^TMP(ZZ,$J),XMY
 I ZA!(ZB)!(ZC) D
 .;S ^TMP(ZZ,$J,1)="**************************************************"
 .S ^TMP(ZZ,$J,2)="*** Following cleanup has been done:           ***"
 .S ^TMP(ZZ,$J,3)="***                                            ***"
 .S ^TMP(ZZ,$J,4)="***          bad P-XREF COUNT "_$E(ZA_"     ",1,6)_"           ***"
 .S ^TMP(ZZ,$J,5)="***          bad PA-XREF COUNT "_$E(ZB_"     ",1,6)_"          ***"
 .S ^TMP(ZZ,$J,6)="***          mismatched PATIENT COUNT "_$E(ZC_"     ",1,6)_"   ***"
 .S ^TMP(ZZ,$J,7)="***                                            ***"
 .I ZC D
 ..S ^TMP(ZZ,$J,8)="***   The count of mismatched patients may     ***"
 ..S ^TMP(ZZ,$J,9)="***   include multiple counts for the same     ***"
 ..S ^TMP(ZZ,$J,10)="***   patient since bad nodes from more than   ***"
 ..S ^TMP(ZZ,$J,11)="***   one patient could point to different     ***"
 ..S ^TMP(ZZ,$J,12)="***   prescriptions for the same 'good'        ***"
 ..S ^TMP(ZZ,$J,13)="***   patient entry in the PRESCRIPTION        ***"
 ..S ^TMP(ZZ,$J,14)="***   file (#52).                              ***"
 .;S ^TMP(ZZ,$J,15)="**************************************************"
 .S ^TMP(ZZ,$J,16)=""
 .I ZC D
 ..S ^TMP(ZZ,$J,17)="A separate message has been sent for the following"
 ..S ^TMP(ZZ,$J,18)="divisions. Each has one or more mismatched patients"
 ..S ^TMP(ZZ,$J,19)="that must be reviewed for inaccurate data."
 ..S ^TMP(ZZ,$J,20)="",XX=21
 ..K XY S J=0 F  S J=$O(^XTMP(TY,JN,"Z",J)) Q:'J  D
 ...S DIV=$P($G(^PS(59,J,0)),"^")
 ...S (I,L)=0 F  S I=$O(^XTMP(TY,JN,"Z",J,I)) Q:'I  S L=L+1
 ...S ^TMP(ZZ,$J,XX)="          "_DIV_": "_L,XX=XX+1,XY(J)=L
 E  D
 .;S ^TMP(ZZ,$J,1)="**************************************************"
 .S ^TMP(ZZ,$J,2)="*** No prescriptions were found with possible  ***"
 .S ^TMP(ZZ,$J,3)="*** bad 'P' or 'P','A' x-refs or prescriptions ***"
 .S ^TMP(ZZ,$J,4)="*** associated with the wrong patient.         ***"
 .;S ^TMP(ZZ,$J,5)="**************************************************"
 S XMY(DUZ)="",XMY("G.PL2 PATCH TRACKING@FORUM.VA.GOV")=""
 S XMSUB="PSO*7*69  - "_$P($$SITE^VASITE(),"^",2)
 S XMDUZ="Outpatient Pharmacy Patch 69"
 S XMTEXT="^TMP(ZZ,$J," D ^XMD K XMY,^TMP(ZZ,$J)
 I $D(^XTMP(TY,JN,2)) S J=0 F  S J=$O(^XTMP(TY,JN,2,J)) Q:'J  D
 .S DIV=$P($G(^PS(59,J,0)),"^")
 .S ^TMP(ZZ,$J,J,1)="This message is comprised of two sections. Section 1 lists prescriptions that"
 .S ^TMP(ZZ,$J,J,2)="may have been automatically discontinued by mistake, either by a Date of Death"
 .S ^TMP(ZZ,$J,J,3)="entry or by the Autocancel on Admission action for a different patient. The"
 .S ^TMP(ZZ,$J,J,4)="second section lists other discontinued prescriptions."
 .S ^TMP(ZZ,$J,J,5)=""
 .S ^TMP(ZZ,$J,J,6)="Please review the following DISCONTINUED prescriptions for the "
 .S ^TMP(ZZ,$J,J,8)=DIV_" (division name) Outpatient Site."
 .S ^TMP(ZZ,$J,J,9)=""
 .S ^TMP(ZZ,$J,J,10)="TOTAL COUNT OF UNIQUE PATIENT IS "_$G(XY(J))
 .S ^TMP(ZZ,$J,J,11)=""
 .S YY=0,$E(S1,36)="",$E(S2,12)="",K="",$P(UL,"=",66)=""
 .S ^TMP(ZZ,$J,J,12)=UL,^TMP(ZZ,$J,J,13)="SECTION 1",^TMP(ZZ,$J,J,14)=""
 .S XX=15 F  S K=$O(^XTMP(TY,JN,2,J,K)) Q:K=""  D
 ..D:'YY
 ...S ^TMP(ZZ,$J,J,XX)="Following prescriptions may have been automatically discontinued by mistake,",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="either by a Date of Death entry or by the Autocancel on Admission action for",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="a different patient.",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)=$E("NAME (SSN#)"_S1,1,35)_$E("Rx #"_S2,1,12)_$S(K="ZZZ":"",1:"Discontinued Reason"),XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="",XX=XX+1 S:K["Auto Discontinued" YY=1
 ..D:K="ZZZ"
 ...I YY S ^TMP(ZZ,$J,J,XX)="",XX=XX+1,YY=0
 ...E  S ^TMP(ZZ,$J,J,XX)="There were no entries that were automatically discontinued.",XX=XX+1,^TMP(ZZ,$J,J,XX)="",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)=UL,XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="SECTION 2",XX=XX+1,^TMP(ZZ,$J,J,XX)="",XX=XX+1
 ...S ^TMP(ZZ,$J,J,XX)="The following prescriptions may have been discontinued manually:",XX=XX+1,^TMP(ZZ,$J,J,XX)="",XX=XX+1
 ..S L=0 F  S L=$O(^XTMP(TY,JN,2,J,K,L)) Q:'L  D
 ...S ^TMP(ZZ,$J,J,XX)=""
 ...S II=0 F  S II=$O(^XTMP(TY,JN,2,J,K,L,II)) Q:'II  D
 ....S QQ=^XTMP(TY,JN,2,J,K,L,II)
 ....I $D(^TMP(ZZ,$J,J,XX)) S ^TMP(ZZ,$J,J,XX)=$E($P(QQ,"^")_S1,1,35)_$E($P(QQ,"^",2)_S2,1,12)_$S(K="ZZZ":"",1:$E($P(QQ,"^",3),1,32)),XX=XX+1
 ....E  S ^TMP(ZZ,$J,J,XX)=S1_$E($P(QQ,"^",2)_S2,1,12)_$S(K="ZZZ":"",1:$E($P(QQ,"^",3),1,32)),XX=XX+1
 .D:'$D(^XTMP(TY,JN,2,J,"ZZZ"))
 ..S ^TMP(ZZ,$J,J,XX)="",XX=XX+1,^TMP(ZZ,$J,J,XX)=UL,XX=XX+1
 ..S ^TMP(ZZ,$J,J,XX)="SECTION 2",XX=XX+1,^TMP(ZZ,$J,J,XX)="",XX=XX+1
 ..S ^TMP(ZZ,$J,J,XX)="There were no entries that were manually discontinued.",XX=XX+1,^TMP(ZZ,$J,J,XX)=""
 .S XMY(DUZ)="",XMDUZ="Search for possible invalid Prescription status"
 .S XMSUB="IMPORTANT - "_$G(DIV)_": Prescriptions to be reviewed."
 .S XMTEXT="^TMP(ZZ,$J,J," D ^XMD K XMY,^TMP(ZZ,$J,J)
END K ^XTMP(TY,JN),^TMP(ZZ,$J),XMY,XMDUZ,ZA,ZB,ZC,DFN,CDFN,RX,RB,XY,XX,TY,JN,ZZ,I,J,K,L,NAME,DIV,STA,STAT,X1,X2
 Q
