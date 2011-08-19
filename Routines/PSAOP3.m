PSAOP3 ;BIR/LTL,JMB-Nightly Background Job ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21,70**; 10/24/97;Build 12
 ;This is the entry point to gather outpatient pharmacy dispensing data
 ;for all drugs in all pharmacy locations. When the drug is released in
 ;outpatient, an ^XTMP("PSA") global is set to contain the dispensing
 ;data. It is called by PSAPSI3.
 ;^XTMP("PSA",59.7 OP Site#,50 Drug#,Date dispensed)=Total Qty Dispensed
 ;
 N PSA,PSADRUG,PSALOC ;PSA=OP SITE, PSA(1)=DRUG(IEN), PSA(2)=DT
LUP S PSA=0 F  S PSA=$O(^XTMP("PSA",PSA)) Q:'PSA  D
 .S PSA(1)=0 F  S PSA(1)=$O(^XTMP("PSA",PSA,PSA(1))) Q:'PSA(1)  D
 ..S PSA(2)=0 F  S PSA(2)=$O(^XTMP("PSA",PSA,PSA(1),PSA(2))) Q:'PSA(2)  D
 ...S PSALOC=$O(^PSD(58.8,"AOP",PSA,0)),PSADRUG=PSA(1)
 ...Q:'$G(PSALOC)  ;; Added check to PSALOC PSA*3*70
 ...;PSA*3*21 (due to multiple OP locations, check for Inactive - Dave B)
 ...I $P($G(^PSD(58.8,PSALOC,7,PSA,0)),"^",2)'="" Q
 ...S PSA(3)=$G(^XTMP("PSA",PSA,PSA(1),PSA(2)))
 ...D:$D(^PSD(58.8,+PSALOC,1,PSADRUG))&($P($G(^PSD(58.8,+PSALOC,0)),U,2)="P") ^PSAOP1
 ...K ^XTMP("PSA",PSA,PSA(1),PSA(2))
 S X1=DT,X2=7 D C^%DTC S ^XTMP("PSA",0)=X_"^"_DT_"^Drug Accountability Dispensing Data"
QUIT Q
