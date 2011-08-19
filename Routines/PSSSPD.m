PSSSPD ;BIR/RLW-PRINT/CREATE PHARMACY ORDERABLE ITEMS ; 09/01/98 7:13
 ;;1.0;PHARMACY DATA MANAGEMENT;**15**;9/30/97
EN ;
 ; name-spaced variables:  ADD=iv additive file   SOL=iv solution file
 ;                         PD=primary drug file   DD=dispense drug file
 ;                         NDF=national drug file DF=NDF dosage form
 ;                         SPD=pharmacy orderable item file
 N ADDIEN,ADDNAME,CHR,DDIEN,PDIEN,PDNAME,NDF,NDFVA,DF,DDNAME,DFNAME,SPDNAME,X,PGN,PSMATCH,SOLIEN,SOLNAME,SPD,SPDFN,CML,LIVE
 ;
 S (PDIEN,DDIEN,NDF,X)=0,CHR=$S($G(PSCREATE):"~",1:" ")
 K ^TMP("PSSD",$J),^TMP("PSS",$J),^TMP("PSSADD",$J),^TMP("PSSOL",$J)
LOOP ; loop through dispense drugs for each primary drug, get NDF entry
 F  S PDIEN=$O(^PSDRUG("AP",PDIEN)) Q:'PDIEN!('$D(^PS(50.3,+PDIEN,0)))  S PDNAME=$P(^PS(50.3,PDIEN,0),"^"),DDIEN="" D
 .F  S DDIEN=$O(^PSDRUG("AP",PDIEN,DDIEN)) Q:'DDIEN!('$D(^PSDRUG(+DDIEN,0)))!($P($G(^PSDRUG(+DDIEN,0)),"^")="")  D
 ..D DOSE I DFNAME="",'$G(PSCREATE) S ^TMP("PSSD",$J,"ZZZZ",DDNAME)="NDF link missing or incomplete" Q
 ..S:DFNAME]"" ^TMP("PSSD",$J,PDNAME_CHR_DFNAME,DDNAME)=PDNAME,^TMP("PSS",$J,DDNAME)=PDNAME_" "_DFNAME
 ;
IVADD ; IV Additives
 S ADDIEN=0 F  S ADDIEN=$O(^PS(52.6,ADDIEN)) Q:ADDIEN=""  D
 .S DDIEN=$P($G(^PS(52.6,ADDIEN,0)),"^",2) Q:DDIEN=""!('$D(^PSDRUG(+DDIEN,0)))  S ADDNAME=$P($G(^PS(52.6,ADDIEN,0)),"^")
 .D DOSE I DFNAME="",'$G(PSCREATE) S ^TMP("PSSADD",$J,"ZZZZ",DDNAME)="NDF link missing or incomplete" Q
 .S:DFNAME]"" ^TMP("PSSADD",$J,ADDNAME,DDNAME)=DFNAME
 ;
IVSOL ; IV solutions
 S (SOLNAME,SOLIEN)="" F  S SOLNAME=$O(^PS(52.7,"B",SOLNAME)) Q:SOLNAME=""  S SOLIEN="" F  S SOLIEN=$O(^PS(52.7,"B",SOLNAME,SOLIEN)) Q:SOLIEN=""  D
 .S DDIEN=$P($G(^PS(52.7,SOLIEN,0)),"^",2) Q:DDIEN=""!('$D(^PSDRUG(+DDIEN,0)))  D DOSE I DFNAME="",'$G(PSCREATE) S ^TMP("PSSOL",$J,"ZZZZ",DDNAME)="NDF link missing or incomplete" Q
 .S:DFNAME]"" ^TMP("PSSOL",$J,SOLNAME,DFNAME,DDNAME)=SOLIEN
 ; if PSCREATE is defined, load the Pharmacy Orderable Item file from the ^TMP global
 D:$G(PSCREATE) ^PSSPOI
 Q
 ;
DOSE ; get dispense drug name and NDF dosage form
 S (DF,DFNAME)="",DDNAME=$P(^PSDRUG(DDIEN,0),"^"),NDF=$G(^PSDRUG(DDIEN,"ND")) S DA=$P($G(NDF),"^"),X=$$VAGN^PSNAPIS(DA),GEN=X,K=$P($G(NDF),"^",3),X=$$PSJDF^PSNAPIS(DA,K),NDFVAGN=X,X=$$PROD0^PSNAPIS(DA,K),PROD=X D
 .Q:($P(NDF,"^")="")!(GEN=0)
 .Q:($P(NDF,"^",3)="")!(PROD']"")
 .I GEN'=0 D
 ..; get pointer to dosage form file from VA PRODUCT NAME node
 ..Q:NDFVAGN=0  D
 ...S DF=$P(NDFVAGN,"^") Q:DF=0
 ...S DFNAME=$P(NDFVAGN,"^",2)
 Q
