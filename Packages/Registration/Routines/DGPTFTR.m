DGPTFTR ;ALB/JDS,HIOFO/FT - TRANSMISSION OF PTF ;8/20/15 3:47pm
 ;;5.3;Registration;**37,415,530,601,614,645,787,850,884**;Aug 13, 1993;Build 31
 ;
 ; VA(200) - #10060
 ; XMB(3.9) - #10113
 ; VATRAN - #1011
 ; XLFDT - #10103
 ; XMA21 - #10067
 ; XMD - #10070
 ; %ZTLOAD - #10063
 ;
ENN ;PTF Transmission [DG PTF TRANSMISSION VADATS]
 L +^DGP(45.83):$G(DILOCKTM,5) I '$T W !,"Another user is already transmitting. Please try again later." Q  ;45.83 is PTF RELEASE
 D CEN^DGPTUTL ;find current census (file 45.86). returns DGCN=ien,DGCN0=zero node
 I '$D(DGRTY) S Y=1 D RTY^DGPTUTL ;determine record type. If Y=1, then DGRTY=1,DGRTY0="PTF". If Y=2, then DGRTY=2,DGRTY0="CENSUS"
 D FDT^DGPTUTL S DGFMTDT=Y ;sets Y=2901000
 ;
EN5 ;select a PTF RELEASE date or range
 K DIC S DIC=45.83,DIC(0)="AZEQ",DIC("A")="Enter Start Date: "
 S DIC("S")="I $O(^DGP(45.83,+Y,""P"",0)) F DGX=0:0 S DGX=$O(^DGP(45.83,+Y,""P"",DGX)) Q:'DGX  I '$P(^DGP(45.83,+Y,""P"",DGX,0),U,2),$D(^DGPT(DGX,0)),$D(^(70)),+^(70)>2901000,$P(^(0),U,11)=+DGRTY Q"
 S D="ANT" D IX^DIC G ENQ1:X["^"!(X="")
 I Y'>0 W !,"There are no "_$S($G(DGRTY)=2:"CENSUS",1:"PTF")_" records in this date range to transmit." G EN5
 S DGSD=+Y(0),DIC(0)="EAZQ",DIC("S")="I Y'<DGSD"_" "_DIC("S"),DIC("A")="Enter Through Date: TODAY//  ",D="ANT" D IX^DIC K DIC,D
 ;
 G ENQ1:X["^" S DGED=$S(Y>0:+Y(0),1:DT)
 ;call VATRAN to get transmission variables 
 ;PTF125 should be an entry in TRANSMISSION ROUTERS (#407.7)
 ;VATERR returns null if no error. 1 or 2 or 3 if can't process
 ;returns VAT array. VAT(1) & VAT(2) are receiving users
 ;VAT("F")=message length (fixed record), VAT("V")=message length (variable record)
 S VATNAME="PTF125" D ^VATRAN I VATERR K VATNAME,VATERR,VAT L -^DGP(45.83) G ENQ
 S DGFMT=2 D SCAN G:DGOUTX ENQ1
ENQ D SCAN^DGPTFTR3 ;loops thru 45.83 and updates transmission date
ENQ1 L -^DGP(45.83) K DGACNT,DGXM,XMDUN,XMY,DGOUTX,DGSTCNT,DIC,DGX,DGRTY,DGRTY0,DGCN,DGCN0,DGPTFMT,DGFMT,DGFMTDT,DGLOGIC,VAT,VATERR,VATNAME,DGSD,DGED,DGPTSLF
 Q
 ;
SCAN K DGERR
 N DGY S DGY=$G(Y) D FMT^DGPTUTL S Y=$G(DGY) ;sets DGPTFMT=1, 2 (ICD9 format) or 3 (ICD10 format)
 D LOG S DGCNT=1,DGD=DGSD-.01,DGTR=0,DGID=1
 ;DGTR=counter for # of messges generated, DGID=counter for DGIDN array (DGIDN(DGID)=XMZ)
 ;DGCNT=counter for number of lines in MailMan message. Bumped up in DGPTRI* routines
 ;DGD=release date-.01
 ; DG*5.3*614 - DGFIRST identifies first record in a batch
 N DGFIRST S DGFIRST=1
 W !!,"Now transmitting ",$P(DGRTY0,U)," records..."
 W !,"Includes records of "
 ;
DAT ;create a MailMan message, transmit it and move on to process additional PTFs 
 D:DGCNT>1 XMIT Q:$G(DGPTSLF)>0  ;quit if segment lengths are wrong
 S DGD=$O(^DGP(45.83,DGD)) ;first time thru, DGCNT is 1, so XMIT is not executed.
 I DGD>0,DGD'>DGED D SETTRAN^DGPTUTL1 Q:DGOUTX  ;create MailMan message
 I DGD'>0!(DGD>DGED) D BULL^DGPTFTR3 G DATQ ;create/send bulletin
 S J=0 G PWR
DATQ Q
 ;
PWR ;get the PTF record and start processing it
 Q:$G(DGPTSLF)>0  ;quit if segment lengths are wrong
 D CEN^DGPTUTL ;check if census can be sent
 S P=J,J=$O(^DGP(45.83,DGD,"P",J)) G DAT:J'>0,PWR:$P(^(J,0),U,2)
 I $D(^DGPT(J,0)),$P(^(0),U,11)'=+DGRTY G PWR
 I $P(DGCN0,U,3)>DT,DGRTY=1 D CEN^DGPTFTR3 G PWR:'Y
 S Y=$S($D(^DGPT(J,70)):+^(70),1:0) D FMT^DGPTUTL G PWR:DGPTFMT<DGFMT
 ;LINES^DGPTFVC2 counts number of lines for transmission
 S T1=0,T2=9999999,Y=J,X=0 S:DGRTY=2 T2=+DGCN0_".9",T1=+$P(DGCN0,U,5) D LINES^DGPTFVC2 I (DGCNT+X)>VAT("F"),'$G(DGFIRST) S J=P G XMIT
 I $G(DGFIRST)=1 S DGFIRST=0
 K DICR S DGERR=0,DGSTCNT("P",J)=DGCNT
 ;^TMP("AEDIT",$J) & ^TMP("AERROR",$J) are set in DGPTAE* routines. Used to validate data
 W !,$E($P(^DPT(+^DGPT(J,0),0),U),1,25),?27,"(#",J,")" S X=^DGPT(J,0) Q:'$D(^(0))  S DGNODE=^(0),DGADM=$P(DGNODE,U,2) D
 . W "  Admitted: ",$TR($$FMTE^XLFDT(DGADM,"5DF")," ","0")," " K ^TMP("AEDIT",$J),^TMP("AERROR",$J) S DGACNT=0
 . F DGZ=6,4 W $$GET1^DIQ(45,J_",",DGZ)_" "
 . K DGNODE,DGZ Q
 I DGRTY=1 D COM
 I DGRTY=2 S T2=+DGCN0_".9",T1=+$P(DGCN0,U,5),(PTF,DGCI)=J D COM1
 I DGERR D OPEN^DGPTFTR3 ;does cleanup. deletes 45.83 data. kills XMY, removes segments from MailMan message. sends Mailman message to user that record is re-opened.
 K ^TMP("AEDIT",$J)
 I 'DGERR W ?70," Okay" S DGTR=DGTR+1 G XMIT:DGCNT>VAT("F")
 G PWR
 Q
 ;
XMIT ;transmit message with PTF segments
 K XMY D ROUTER
 S XMZ=DGXMZ,^XMB(3.9,XMZ,2,0)="^3.92A^"_(DGCNT-1)_"^"_(DGCNT-1)_"^"_DT,DGJ=J
 S XMDUZ=.5,XMDUN=$P(^VA(200,DUZ,0),U)
 S DGPTSLF=0 D CHECK(XMZ) ;are segment lengths correct?
 I DGPTSLF>0 Q
 D ENT1^XMD ;forward  message, don't ask for recipients
 W !,"Transmission Queued" S DGIDN(DGID)=XMZ
 F DGK=0:0 S DGK=$O(DGSTCNT("P",DGK)) Q:DGK'>0  D REC
 S DGFIRST=1
 K DGK S DGCNT=1,DGID=DGID+1,J=DGJ Q:J'>0  D SETTRAN^DGPTUTL1 G:'DGOUTX PWR
 Q
 ;
REC ;update PTF RECORD multiple in PTF RELEASE (45.83). includes PTF record ien, date transmitted, & message ien
 ;set PTF STATUS="Transmitted"
 S DGSENFLG=""
 S DIE="^DGP(45.83,",DA=DGD,DR="10///"_DGK,DR(2,45.831)="1///TODAY;2///"_XMZ D ^DIE K DA,DR,DIE
 S DIE="^DGPT(",DR="6///3",DA=DGK D ^DIE K DA,DR,DIE
 K DGSENFLG
 Q
 ;
COM S T1=0,T2=9999999 S:'$D(PTF) PTF=J S:PTF'=J PTF=J
COM1 ;called from DGPTC1
 ;pulls data from PTF (45), PATIENT(2) and PTF CLOSE OUT (45.84). Values are used to build segments and do data validation
 F K=0,70,71,101,"401P" S @("DG"_K)=$S($D(^DGPT(J,K)):^(K),1:"")
 F K=10,.11,.3,.32,.321,.52,57 S @("DG"_$S(K[".":$E(K,2,99),1:K))=$S($D(^DGP(45.84,J,K)):^(K),$D(^DPT(+^DGPT(J,0),$S(K'=10:K,1:0))):$S(K'=10:^(K),1:^(0)),1:"")
 F K=.02,.06 M @("DG"_$S(K[".":$E(K,2,99),1:K))=^DPT(+^DGPT(J,0),K)
 ;uses different processing routines to build segments and MaiLMan based on record format.
 ;DGPTFMT=1 is very old record format, perhaps before ICD9 usage (not sure).
 ;DGPTFMT=2 is ICD9 record format
 ;DGPTFMT=3 is ICD10 record format
 ;DGPTR* & DGPTRI* routines and similiar, but record format is different.
 D ^DGPTFTR0:DGPTFMT=1,^DGPTR0:DGPTFMT=2,^DGPTRI0:DGPTFMT=3
 ;
Q ;
 L -^DGP(45.83)
 F K=0,10,701,"401P",101,11,3,32,41,52,57,70,321,502,702,"02","06" K @("DG"_K)
 K DGPICD10,DGCDR,DGT,DIC,DGADM,DGAO,DGDOB,DGHEAD,DGJ,DGK,DGL,DGM,DGNAM,DGNT,DGO,DGSSN,DGSUD,DGSUR,DGTD,DGX,DGXLS,E,ERR,F,G,H,I,K,L,T,W,Z,DGPROC,DGPROCD ;** NOTE: do not kill variables needed by PTF load/edit option!!!
 ;DGPTFVC1 & DGPTFVC2 do expanded ptf close out edits
 ;DGPTFVC3 does validation checks for ptf additional questions
 I $D(DGERR),DGERR<1 D ^DGPTFVC1 D:'T1 ^DGPTFVC3
 I $D(DGERR),DGERR<1 D EN^DGPTFVC2
 Q
 ;
LOG ;called from PRINT+1^DGPTF2,CLS+1^DGPTF2,EN^DGPTFVC
 D LOG^DGPTFTR1:DGPTFMT=1,LOG^DGPTR1:DGPTFMT=2,LOG^DGPTRI1:DGPTFMT=3,COM:$D(DGERR) ;note: COM is not called unless DGERR exists
 Q
 ;
 ;-- check for real queue if census should be removed for national rel
ROUTER ;called from DGPTF099,DGPTRPO
 ;DGSDI is local or remote address
 ;I $D(XMDF) then all addressing restrictions are waived
 ;XMN - Can't find this variable in MailMan documentation. May not do anything.
 S XMDUZ=.5 F DGSDI=0:0 S DGSDI=$O(VAT(DGSDI)) Q:'DGSDI  S X=VAT(DGSDI),XMN=0,XMDF="" D INST^XMA21 K XMN,XMDF
 S XMY(DUZ)=""
 Q
 ;
CHECK(DGPTXMZ) ;check if every two lines in message body equal 384 characters
 N DGPTLAST,DGPTLOOP,DGPTNODE,DGPTTEXT,DGPTTOT
 S DGPTNODE=$G(^XMB(3.9,DGPTXMZ,2,0))
 S DGPTLAST=$P(DGPTNODE,U,4)
 F DGPTLOOP=1:2:DGPTLAST D  Q:$G(DGPTSLF)=1
 .S DGPTTOT=$L($G(^XMB(3.9,DGPTXMZ,2,DGPTLOOP,0)))+$L($G(^XMB(3.9,DGPTXMZ,2,DGPTLOOP+1,0)))
 .I DGPTTOT'=384 D
 ..S DGPTSLF=1 ;segment length flag
 ..D QMSG(DGPTXMZ)
 ..W !!,"There is a problem with the segment length of a PTF record."
 ..W !,"The MailMan message number is "_DGPTXMZ_"."
 ..W !,"Please log a Remedy ticket. Stopping transmission.",!
 Q
 ;
QMSG(DGPTMIEN) ;notify others about bad segment length
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTDESC="DG PTF TRANSMISSION VADATS",ZTDTH=$$NOW^XLFDT(),ZTIO="",ZTRTN="SMSG^DGPTFTR"
 S ZTSAVE("DGPTMIEN")=""
 D ^%ZTLOAD
 Q
 ;
SMSG ;send MailMan message
 N DGPTTEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMSUB="Station "_$P($$SITE^VASITE(),U,3)_" has wrong PTF segment length"
 S XMDUZ=$S($G(DUZ)>0:$G(DUZ),1:.5)
 S DGPTTEXT(1)="The PTF records contained in this message cannot be transmitted"
 S DGPTTEXT(2)="to AITC due to format of the content issue."
 S DGPTTEXT(3)=" "
 S DGPTTEXT(4)="Contact the support help desk and report."
 S DGPTTEXT(5)=" "
 S DGPTTEXT(6)="Retransmission will need to be attempted once the transmission"
 S DGPTTEXT(7)="message format has been corrected."
 S DGPTTEXT(8)=" "
 S DGPTTEXT(9)="The local MailMan message number is: "_DGPTMIEN
 S XMTEXT="DGPTTEXT("
 S XMY(DUZ)=""
 S XMY("ICD-10OITPTFExpansionTeam@domain.ext")=""
 D ^XMD
 Q
