ACKQWL ;AUG/JLTP BIR/PTD-Compile A&SP Capitation Data ; [ 05/21/96 11:15 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
OPTN ;Introduce option.
 W @IOF,!,"This option compiles the data for the A&SP Capitation Report.",!
 D GETDT G:$D(DIRUT) EXIT D INIT S ACKMAN=1,ACKDUZ=DUZ
 S ACKST=$$STATUS() I 'ACKST W !,"Can't continue: ",$P(ACKST,U,3) G EXIT
BKG ;Queue process to run in the background.
 S ZTRTN="DQ^ACKQWL",ZTIO="",ZTSAVE("ACK*")=""
 S ZTDESC="QUASAR - Compile A&SP Capitation Data" D ^%ZTLOAD W:$D(ZTSK) !,"Data generation queued to run in the background." G EXIT
DQ ;Entry point when queued.
 N CPT,ICD
 S:'$D(ACKM) ACKM=$$LM(DT) D:'$D(ACKDA) INIT
 S ACKST=$$STATUS() I 'ACKST D:'$D(ACKMAN) ABORT^ACKQWB(ACKST) G EXIT
 I $P(ACKST,U,2)=1 D CREATE G:$D(DIRUT) EXIT
 D LOG("BEGIN"),^ACKQWL1,LOG("END")
EXIT ;ALWAYS EXIT HERE
 K ACKBFY,ACKCP,ACKCPP,ACKCPT,ACKD,ACKDA,ACKDUZ,ACKEM,ACKICP,ACKICD,ACKM,ACKMAN,ACKMO,ACKNU,ACKNV,ACKST,ACKSTOP,ACKV,ACKXFT,ACKXST,ACKZIP
 K %X,%Y,D0,DA,DFN,DIE,DIRUT,DTOUT,DUOUT,DR,I,VAERR,VAPA,X,XMZ,Y,ZTSK
 K ^TMP("ACKQWL",$J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
GETDT ;Select month for report.
 N DIR,X,Y
GDT1 S DIR(0)="D^::APE",DIR("A")="Select Month & Year"
 S DIR("B")=$$XDAT^ACKQUTL($$LM(DT)),DIR("?")="^D HELP^%DTC"
 S DIR("??")="^D DATHLP^ACKQWL" D ^DIR Q:$D(DIRUT)  S ACKM=$E(Y,1,5)_"00"
 I ACKM>DT W !,$C(7),"Can't run capitation report for future months!" G GDT1
 Q
INIT ;Initialize important variables.
 N MON
 S MON=$E(ACKM,1,5),ACKEM=MON_"99",ACKDA=+$$SITE^VASITE()_MON
 S ACKBFY=$$BFY^ACKQUTL(ACKM)
 Q
STATUS() ;Find status of WORKLOAD file (#509850.7).
 I '$D(^ACK(509850.7,ACKDA,0)) D STA(1) Q X
 I $P(^ACK(509850.7,ACKDA,0),U,8) D STA(6) Q X
 I $P(^ACK(509850.7,ACKDA,0),U,6) D STA($S($D(^(4)):4,1:3)) Q X
 I $P(^ACK(509850.7,ACKDA,0),U,4) D STA(5) Q X
 I $D(^ACK(509850.7,ACKDA,4,0)) D STA(2) Q X
 Q 1
STA(O) S X=$P($T(STA+O),";;",2) D:$P(X,U)="?" STAQES Q
 ;;1^1^Capitation Report Not Generated - CDR Not Completed
 ;;1^2^Capitation Report Not Generated - CDR Completed
 ;;?^3^Capitation Report Already Generated - CDR Not Completed
 ;;?^4^Capitation Report Already Generated - CDR Completed
 ;;0^5^Capitation Report Already Running - Not Completed
 ;;0^6^Capitation Report Already Verified
STAQES ;If interactive, ask if ok.
 I $D(ZTQUEUED) S $P(X,U)=1 Q
 N ACKX,DIR,Y,DIRUT,DUOUT,DTOUT S ACKX=X
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Continue",DIR("A",1)=$P(X,U,3)
 S DIR("?")="Answer Y for YES or N for NO."
 S DIR("??")="^W !?5,""If you answer YES, I will re-generate capitation data.  This will"",!?5,""overwrite existing capitation data for the chosen month."""
 D ^DIR S X=ACKX,$P(X,U)=$S($D(DIRUT):0,1:+Y) D:X CLEAN
 Q
LM(X) ;Find month previous to X.
 N M,D,Y S M=$E(X,4,5),D=$E(X,6,7),Y=$E(X,1,3),M=M-1
 S:M<1 M=12,Y=Y-1 S:M<10 M="0"_M
 Q Y_M_"00"
CREATE ;Create WORKLOAD file entry.
 S DIC="^ACK(509850.7,",DIC(0)="L",DLAYGO=509850.7,ACKLAYGO="",X=ACKM,DINUM=ACKDA
 K DD,DO D FILE^DICN S:Y<0 DIRUT=1
 Q
CLEAN ;Clean out previously generated data for month.
 D WAIT^DICD N X
 F X=.04,.05,.06 D STF(X,"@",3)
 F X=1,2,3 D MDEL(X)
 Q
STF(F,V,S) ;Use 'S' slash stuff to enter value 'V' in field 'F'.
 N DIE,DR,DA,SL,X,Y
 S SL="",$P(SL,"/",S)="/",DIE="^ACK(509850.7,",DA=ACKDA,DR=F_SL_V D ^DIE Q
MDEL(FLD) ;Delete all entries from multiple field FLD.
 S DIK="^ACK(509850.7,"_ACKDA_","_FLD_",",DA(1)=ACKDA,SUB=0 D
 .F  S SUB=$O(^ACK(509850.7,ACKDA,FLD,SUB)) Q:'SUB  S DA=SUB D ^DIK
 K DA,DIK,SUB
 Q
LOG(X) ;Log the task's start time, end time, and other info.
 I X="END" D NOW^%DTC D STF(.06,%,4) S ACKXFT=$$HTIM^ACKQUTL(),ACKMO=$$XDAT^ACKQUTL(ACKM) D BUILD^ACKQWB Q
 S ACKXST=$$HTIM^ACKQUTL D STF(.01,$$XDAT^ACKQUTL(ACKM),3)
 D NOW^%DTC,STF(.04,%,4),STF(.05,$J,4)
 Q
DATHLP ;Extended help - select month for capitation report. (ACKQWL)
 W !?5,"Select a month, in the past, for which you wish to",!?5,"compile data for the A&SP Capitation Report."
 Q
