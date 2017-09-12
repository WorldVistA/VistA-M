PSJ323PO ;TMC - Patch 323 Post Install routine;9/9/2015
 ;;5.0;INPATIENT MEDICATIONS;**323**;DEC 1997;Build 10
 ;
 ;External reference ^DD(55 supported by DBIA 2191
 ;
 ;This post install routine will identify bad "AUD" cross-references and fix them where the date was stored with quotes around them.
 ;
 Q
START ; 
 N PSJCNT,PSJDFN,PSJSDT,PSJI
 S X1=DT,X2=+90 D C^%DTC
 S PSJCNT=0
 S ^XTMP("PSJ323PO",0)=$G(X)_"^"_DT_"^AUD CROSS REFERENCE DATE FIX^"
 S PSJSDT=0 F  S PSJSDT=$O(^PS(55,"AUD",PSJSDT)) Q:'PSJSDT  I $E(PSJSDT,$L(PSJSDT),$L(PSJSDT))=0  D CHKDT
 W !!,"***********PSJ323PO HAS FINISHED*************"
 Q
CHKDT ;
 S PSJDFN=0 F  S PSJDFN=$O(^PS(55,"AUD",PSJSDT,PSJDFN)) Q:PSJDFN=""  D
 .S PSJI=0 F  S PSJI=$O(^PS(55,"AUD",PSJSDT,PSJDFN,PSJI)) Q:PSJI=""  D
 ..S PSJCNT=PSJCNT+1
 ..S ^XTMP("PSJ323PO",PSJCNT)="^PS(55,""AUD"","_PSJSDT_","_PSJDFN_","_PSJI_")"
 ..K ^PS(55,"AUD",PSJSDT,PSJDFN,PSJI)
 ..S ^PS(55,"AUD",+PSJSDT,PSJDFN,PSJI)=""
 Q
