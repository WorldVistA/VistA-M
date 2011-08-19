PSSPOIM ;BIR/RTR-Orderable Items by VA Generic Name only ; 09/01/98 7:11
 ;;1.0;PHARMACY DATA MANAGEMENT;**15**;9/30/97
 ;K ^TMP("PSSD",$J)
 I '$G(PSMATCH) G CANT
 ;VA Generic Name only that can match
BEG F RRR=0:0 S RRR=$O(^PSDRUG(RRR)) Q:'RRR  D
 .K NODE,PSONAME,PSOPTR
 .S NODE=$G(^PSDRUG(RRR,"ND")),PSONAME=$P($G(^(0)),"^"),PSOPTR=$P($G(^(2)),"^"),DA=$P(NODE,"^"),K=$P(NODE,"^",3),X=$$PSJDF^PSNAPIS(DA,K),DOSE1=X
 .Q:PSONAME=""
 .I +PSOPTR Q
 .I '$P(NODE,"^") Q
 .;Next 5 lines of code could only apply if this report is run and
 .;there are Dispensed drugs that are already matched
 .K ^TMP($J,"PSSUP") I +$P(NODE,"^"),+$P(NODE,"^",3) F GG=0:0 S GG=$O(^PSDRUG("AND",+NODE,GG)) Q:'GG  I +$P($G(^PSDRUG(GG,2)),"^"),$D(^PS(50.7,$P(^PSDRUG(GG,2),"^"),0)) D
 ..S ONO=$G(^PSDRUG(GG,"ND")) I +$P(ONO,"^"),+$P(ONO,"^",3),DOSE1'=0 S DA=$P($G(ONO),"^"),K=$P($G(ONO),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DOSE2=X I DOSE2'=0 D
 ...I DOSE1=DOSE2 S ^TMP($J,"PSSUP",GG)=$P(^PSDRUG(GG,2),"^")
 .S (COM,COMSUP)=0 I $O(^TMP($J,"PSSUP",0)) S COM=1 S FF=$O(^TMP($J,"PSSUP",0)),SUPER=^TMP($J,"PSSUP",FF) F FF=0:0 S FF=$O(^TMP($J,"PSSUP",FF)) Q:'FF  I SUPER'=^TMP($J,"PSSUP",FF) S COMSUP=1
 .I COM,COMSUP Q
 .I COM,'COMSUP S SSS=$O(^TMP($J,"PSSUP",0)),SSS=^TMP($J,"PSSUP",SSS) S ^TMP("PSSD",$J,$P($G(^PS(50.7,SUPER,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^PS(50.7,SSS,0)),"^",2),0)),"^"),PSONAME)="" Q
 .I +$P(NODE,"^"),+$P(NODE,"^",3) S DA=$P($G(NODE),"^"),X=$$VAGN^PSNAPIS(DA),VAG=X I VAG'=0,DOSE1'=0 D
 ..I $L(VAG)<41 S ^TMP("PSSD",$J,$P(DOSE1,"^",2),PSONAME)=""
END K ^TMP($J,"PSSUP"),APPL,COM,COMSUP,FF,GG,NODE,ONO,POINAME,PSOPTR,PSPTR,RRR,SSS,SUPER Q
CANT ;Generic name only, cannot match
 K ^TMP("PSSD",$J,"ZZZZ")
 F ZZ=0:0 S ZZ=$O(^PSDRUG(ZZ)) Q:'ZZ  D  I TMPFLAG S ^TMP("PSSD",$J,"ZZZZ",PSDNAME)=REASON
 .K PTDOS,DOSEF,REASON
 .S PSND=$G(^PSDRUG(ZZ,"ND")),PSDNAME=$P($G(^(0)),"^"),PSOPRT=$P($G(^(2)),"^"),TMPFLAG=0 S DA=$P($G(PSND),"^"),K=$P($G(PSND),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DSE=X,X=$$VAGN^PSNAPIS(DA),GN1=X
 .I +PSOPRT Q
 .S PSQFLAG=0 I +$P(PSND,"^"),+$P(PSND,"^",3),GN1'=0,DSE'=0 D
 ..I DSE'=0,$D(^PS(50.606,$P(DSE,"^"),0)),$L(GN1)<41 S PSQFLAG=1
 .I PSQFLAG Q
 .S TMPFLAG=1
 .I $P(PSND,"^")="" S REASON="NDF link missing or incomplete" Q
 .I $P(PSND,"^",3)="" S REASON="No PSNDF VA Product Name Entry" Q
 .I GN1=0 S REASON="Invalid National Drug File entry" Q
 .S PSVA=$P(PSND,"^",3),DA=$P(PSND,"^"),K=PSVA,X=$$PROD0^PSNAPIS(DA,K) I X']"" S REASON="Invalid PSNDF VA Product Name Entry" Q
 .I DSE=0 S REASON="No Dosage Form Entry in NDF" Q
 .I DSE=0 S REASON="Missing Dosage Form in NDF" Q
 .I DSE=0 S REASON="Invalid entry in Dosage Form File" Q
 .I $L(GN1)>40 S REASON="Generic name greater than 40 characters" Q
 .S REASON="Undertermined problem" Q
DONE K DOSEFORM,DOSEPTR,PSAPP,PSDNAME,PSND,PSQFLAG,PSVA,TMPFLAG,ZZ Q
