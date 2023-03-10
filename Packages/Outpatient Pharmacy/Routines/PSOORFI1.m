PSOORFI1 ;BIR/SAB - finish OP orders from OE/RR continued ;Dec 13, 2021@08:00:50
 ;;7.0;OUTPATIENT PHARMACY;**7,15,23,27,32,44,51,46,71,90,108,131,152,186,210,222,258,260,225,391,408,444,467,505,617,441,651**;DEC 1997;Build 30
 ;Ref. ^PS(50.7 supp. DBIA 2223
 ;Ref. ^PSDRUG( supp. DBIA 221
 ;Ref. L^PSSLOCK supp. DBIA 2789
 ;Ref. ^PS(50.606 supp. DBIA 2174
 ;Ref. ^PS(55 supp. DBIA 2228
 ;Ref. ULK^ORX2 supp. DBIA 867
 ;Ref. ^SC( supp. DBIA 10040
 ;Ref. ^VA(200 supp. DBIA 10060
 ;Ref. ^XUSEC( supp. DBIA 10076
 ;Ref. ULK^ORX2 DBIA 867
 ;Ref. KVA^VADPT supp. DBIA 10061
 ;Ref. FULL^VALM1 supp. DBIA 10116
 ;
 ;PSO*186 add call to function $$DEACHK
 ;PSO*210 add call to WORDWRAP api
 ;
 S SIGOK=1
DSPL K ^TMP("PSOPO",$J),CLOZPAT,PSOPRC,PSODSPL
 S (OI,PSODRUG("OI"))=$P(OR0,"^",8),PSODRUG("OIN")=$P(^PS(50.7,$P(OR0,"^",8),0),"^"),OID=$P(OR0,"^",9)
 I $P($G(OR0),"^",9) S POERR=1,DREN=$P(OR0,"^",9) D DRG^PSOORDRG K POERR G DRG
 I '$P(OR0,"^",9) D DREN^PSOORNW2
DRG I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),"CLOZ1")),"^")="PSOCLO1" D CLOZ^PSOORFI2
 ;PSO*186 modify If/Else below to use DEACHK
 I $G(PSODRUG("DEA"))]"" D
 .S PSOCS=0 K DIR,DIC,PSOX
 .N PSDEA,PSDAYS S PSDEA=PSODRUG("DEA"),PSDAYS=+$P(OR0,"^",22)
 .I $$DEACHK^PSOUTLA1("*",PSDEA,PSDAYS,$G(CLOZPAT),.PSOCS,.PSOMAX)
 E  D
 .S PSOMAX=$S($G(CLOZPAT)=2:3,$G(CLOZPAT)=1:1,1:$P(OR0,"^",11))
ISSDT S (PSOID,Y,PSONEW("ISSUE DATE"))=$S($G(PSONEW("ISSUE DATE")):PSONEW("ISSUE DATE"),$P($G(OR0),"^",6):$E($P(OR0,"^",6),1,7),1:DT)
 X ^DD("DD") S PSONEW("ISSUE DATE")=Y
 D USER^PSOORFI2($P(OR0,"^",4)) S PSONEW("CLERK CODE")=$P(OR0,"^",4),PSORX("CLERK CODE")=USER1
 S (PSONEW("DFLG"),PSONEW("QFLG"))=0,PSODFN=$P(OR0,"^",2),PSONEW("QTY")=$P(OR0,"^",10),PSONEW("MAIL/WINDOW")=$S($P(OR0,"^",17)="M":"M",$P(OR0,"^",17)="P":"P",1:"W")
 S:$G(PSONEW("CLINIC"))']"" PSONEW("CLINIC")=+$P(OR0,"^",13),PSORX("CLINIC")=$S($D(^SC(PSONEW("CLINIC"),0)):$P(^SC(PSONEW("CLINIC"),0),"^"),1:"")
 S:$G(PSORX("CLINIC"))']"" PSORX("CLINIC")=$S($D(^SC(+$P(OR0,"^",13),0)):$P(^SC($P(OR0,"^",13),0),"^"),1:"")
 D USER^PSOORFI2($P(OR0,"^",5))
 S PSONEW("CLERK CODE")=$P(OR0,"^",4),PSONEW("PROVIDER")=$P(OR0,"^",5),PSONEW("PROVIDER NAME")=USER1
 S PSONEW("PATIENT STATUS")=$S(+$G(^PS(55,PSODFN,"PS")):+$G(^PS(55,PSODFN,"PS")),1:"")
 S PSONEW("CHCS NUMBER")=$S($P($G(^PS(52.41,+$G(ORD),"EXT")),"^")'="":$P($G(^("EXT")),"^"),1:"")
 S PSONEW("EXTERNAL SYSTEM")=$S($P($G(^PS(52.41,+$G(ORD),"EXT")),"^",3)'="":$P($G(^("EXT")),"^",3),1:"")
 I $P(OR0,"^",22)>0 S PSONEW("DAYS SUPPLY")=$P(OR0,"^",22) G DS
 S PSONEW("DAYS SUPPLY")=$S(+$G(^PS(55,PSODFN,"PS"))&($P($G(^PS(53,+$G(^PS(55,PSODFN,"PS")),0)),"^",3)):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3),1:30)
DS ;
 S:$D(CLOZPAT) PSONEW("DAYS SUPPLY")=$S(CLOZPAT=2&(PSONEW("DAYS SUPPLY")>28):28,CLOZPAT=1&(PSONEW("DAYS SUPPLY")>14):14,'CLOZPAT&(PSONEW("DAYS SUPPLY")>7):7,1:PSONEW("DAYS SUPPLY"))
 S IEN=0 D OBX                ; Display Order Checks Information
 D LMDISP^PSOORFI5(+$G(ORD))  ; Display Flag/Unflag Information
 D DIN^PSONFI(PSODRUG("OI"),$S($D(PSODRUG("IEN")):PSODRUG("IEN"),1:"")) ;Setup for N/F & DIN indicator
 ; pso*7*467 - add display of erx information if the rx came from eRx
 N ERXIEN
 S ERXIEN=$$CHKERX^PSOERXU1(OR0) I ERXIEN D DERX1^PSOERXU1($NA(^TMP("PSOPO",$J)),ERXIEN,"",.IEN,"P")
 ; pso*7*467 - end eRx enhancement
 S:$P($G(^PS(52.41,ORD,4)),"^",2)]"" PSONEW("IND")=$P($G(^PS(52.41,ORD,4)),"^",2) ;*441-IND
 S:$P($G(^PS(52.41,ORD,4)),"^",3)]"" PSONEW("INDO")=$P($G(^PS(52.41,ORD,4)),"^",3)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="*(1) Orderable Item: "_$P(^PS(50.7,PSODRUG("OI"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_NFIO
 S:NFIO["<DIN>" NFIO=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 ;
 K LST I $G(PSODRUG("NAME"))]"" D  G PST
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (2)"_$S($D(^PSDRUG("AQ",PSODRUG("IEN"))):"      CMOP ",1:"           ")_"Drug: "_PSODRUG("NAME")_NFID
 .S:NFID["<DIN>" NFID=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 .I $P(^PSDRUG(PSODRUG("IEN"),0),"^",10)]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       Drug Message:" D DRGMSG^PSOORNEW
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (2)           Drug: No Dispense Drug Selected"
PST D DOSE^PSOORFI4 K PSOINSFL
 S PSOINSFL=$P($G(^PS(52.41,ORD,"INS")),"^",2)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (4)   Pat Instruct:" D INST^PSOORFI4
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Provider Comments:" S TY=3 D INST
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="        Indications: "_$G(PSONEW("IND")) ;*441-IND
 I $G(ERXIEN) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="           eRx Drug: "_$$GET1^DIQ(52.49,ERXIEN,3.1)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   "_$S($G(ERXIEN):"eRx",1:"   ")_" Instructions: " S TY=2 D INST
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                SIG:" D SIG
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (5) Patient Status: "_$P($G(^PS(53,+PSONEW("PATIENT STATUS"),0)),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (6)     Issue Date: "_PSONEW("ISSUE DATE")
 S (Y,PSONEW("FILL DATE"))=$S($E($P(OR0,"^",6),1,7)<DT:DT,1:$E($P(OR0,"^",6),1,7)) X ^DD("DD") S PSORX("FILL DATE")=Y,^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"        (7) Fill Date: "_Y
 I $P(OR0,"^",18) D
 .S IEN=IEN+1,Y=$P(OR0,"^",18) X ^DD("DD") S $P(^TMP("PSOPO",$J,IEN,0)," ",39)="Effective Date: "_Y
 D:$D(CLOZPAT) ELIG^PSOORFI2,CLQTY^PSOORFI4
 N PSDAYS,MAXRF
 S PSDAYS=$S($G(PSONEW("DAYS SUPPLY")):PSONEW("DAYS SUPPLY"),+$G(^PS(55,PSODFN,"PS"))&($P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3)):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3),1:"")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (8)    Days Supply: "_PSDAYS
 S RXPT=+$G(^PS(55,PSODFN,"PS"))
 ; Retrieving the Maximum Number of Refills allowed
 S MAXRF=$$MAXNUMRF^PSOUTIL(+$G(PSODRUG("IEN")),PSDAYS,RXPT,.CLOZPAT)
 S PSONEW("# OF REFILLS")=$S(+$P(OR0,"^",11)>MAXRF:MAXRF,1:+$P(OR0,"^",11))
 KILL RXPT
 ;
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"                (9)   QTY"_$S($P($G(^PSDRUG(+$G(PSODRUG("IEN")),660)),"^",8)]"":" ("_$P($G(^PSDRUG(+$G(PSODRUG("IEN")),660)),"^",8)_")",1:" (  )")_": "_$G(PSONEW("QTY"))
 I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOPO",$J,IEN,0)=$E(RN,$L("QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^"))+1,79)_"QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^") K RN
 S IEN=IEN+1
 I $P(OR0,"^",24) S ^TMP("PSOPO",$J,IEN,0)="   Provider ordered: days supply "_$P(OR0,"^",22)_", quantity "_$P(OR0,"^",10)_" & refills "_+$P(OR0,"^",11)
 E  S ^TMP("PSOPO",$J,IEN,0)="       Provider ordered "_+$P(OR0,"^",11)_" refills"
 D:$D(CLOZPAT) PQTY^PSOORFI4
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(10)   # of Refills: "_PSONEW("# OF REFILLS")_$E("  ",$L(PSONEW("# OF REFILLS"))+1,2)_"               (11)   Routing: "_$S($G(PSONEW("MAIL/WINDOW"))="M":"MAIL",$G(PSONEW("MAIL/WINDOW"))="P":"PARK",1:"WINDOW")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(12)         Clinic: "_PSORX("CLINIC")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(13)       Provider: "_PSONEW("PROVIDER NAME")
 I $G(PKI),+$G(PSODRUG("DEA"))>1,+$G(PSODRUG("DEA"))<6 D PRV^PSOORFI5($P(OR0,"^",5),$P(OR0,"^",9),$P(OR0,"^"))
 I $P($G(^VA(200,$S($G(PSONEW("PROVIDER")):PSONEW("PROVIDER"),1:$P(OR0,"^",5)),"PS")),"^",7)&($P($G(^("PS")),"^",8)) S PSONEW("COSIGNING PROVIDER")=$P(^("PS"),"^",8) D
 .D USER^PSOORFI2(PSONEW("COSIGNING PROVIDER"))
 .S IEN=IEN+1 S ^TMP("PSOPO",$J,IEN,0)="        Cos-Provider: "_USER1
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(14)         Copies: 1"
 S PSONEW("REMARKS")=$S($P(OR0,"^",17)="C":"Administered in Clinic.",1:"")
 K PSONEW("ADMINCLINIC") S:$P(OR0,"^",17)="C" PSONEW("ADMINCLINIC")=1
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(15)        Remarks: "_$S($G(PSONEW("REMARKS"))]"":PSONEW("REMARKS"),1:"")
 D USER^PSOORFI2($P(OR0,"^",4))
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Entry By: "_USER1_$E(RN,$L(USER1)+1,35)
 S Y=$P(OR0,"^",12) X ^DD("DD") S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"Entry Date: "_$E($P(OR0,"^",12),4,5)_"/"_$E($P(OR0,"^",12),6,7)_"/"_$E($P(OR0,"^",12),2,3)_" "_$P(Y,"@",2) K RN
 ; DEA compliance note for eRx CS prescriptions
 N ERXIEN S ERXIEN=$$ERXIEN^PSOERXUT($G(ORD)_"P")
 I ERXIEN,$$GET1^DIQ(52.49,ERXIEN,95.1,"I"),$$CS^PSOERXA0(+$$GET1^DIQ(52.49,ERXIEN,3.2,"I")) D
 . S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=""
 . S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="This prescription meets the requirements of the Drug Enforcement Administration"
 . S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(DEA) electronic prescribing for controlled substances rules (21 CFR Parts 1300,"
 . S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="1304, 1306, & 1311)."
 I $P(OR0,"^",24) S PSOACT=$S($D(^XUSEC("PSDRPH",DUZ)):"DEFX",$D(^XUSEC("PSORPH",DUZ)):"F",$P($G(PSOPAR),"^",2):"F",1:"") D
 .K PSOCSP S PSOCSP("NAME")=$G(PSODRUG("NAME")) M PSOCSP("DOSE")=PSONEW("DOSE"),PSOCSP("DOSE ORDERED")=PSONEW("DOSE ORDERED")
 .S PSOCSP("# OF REFILLS")=PSONEW("# OF REFILLS") ;track original data for dig. orders
 .S PSOCSP("ISSUE DATE")=$E($P(OR0,"^",6),1,7),PSOCSP("QTY")=PSONEW("QTY"),PSOCSP("DAYS SUPPLY")=PSONEW("DAYS SUPPLY")
 E  S PSOACT=$S($D(^XUSEC("PSORPH",DUZ)):"DEFX",'$D(^XUSEC("PSORPH",DUZ))&($P($G(PSOPAR),"^",2)):"F",1:"")
 ; - PSOACTOV is used to force the Pending Order to be Read-Only (no updates) even if invoked by a Pharmacist
 I $G(PSOACTOV) S PSOACT=""
 D:'$G(ACP) EN^PSOLMPO S:$G(ACP) VALMBCK="Q" D:$G(PKI1)=2 DCP^PSOPKIV1
 Q
POST ;post patient selection
 D POST^PSOORFI2 Q
SIG ;displays possible sig
 D SIG^PSOORFI2 Q
INST ;displays provider comments and pharmacy instructions
 S INST=0 F  S INST=$O(^PS(52.41,ORD,TY,INST)) Q:'INST  D     ;PSO*210
 . S (MIG,INST(INST))=^PS(52.41,ORD,TY,INST,0)
 . D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOPO",$J)),20)
 K INST,TY,MIG,SG
 Q
OBX ;formats obx section
 D OBX^PSOORFI4
 Q
ST(PSRT) ;sort by route or patient
 W !!,"Enter: ",!
 I $G(PSRT)'="PA" W "      'PA' to process orders by patients",!
 I $G(PSRT)'="RT" D  ;PAPI 441
 .N RESULTS,PSOPARKX
 .S RESULTS="PSOPARKX" D GETPARK^PSORPC01()
 . ;I '$P($G(PSOPAR),"^",34) W "      'RT' to process orders by route (mail/window)",!
 . ;I $P($G(PSOPAR),"^",34) W "      'RT' to process orders by route (mail/window/park)",!
 .I $G(PSOPARKX(0))'="YES" W "      'RT' to process orders by route (mail/window)",!
 .I $G(PSOPARKX(0))="YES" W "      'RT' to process orders by route (mail/window/park)",!
 I $G(PSRT)'="PR" W "      'PR' to process orders by priority",!
 I $G(PSRT)'="CL" W "      'CL' to process orders by clinic",!
 I $G(PSRT)'="FL" W "      'FL' to process flagged orders",!
 I $G(PSRT)']"" W "      'CS' to process digitally signed CS orders",!
 I $G(PSRT)]"","SUCS"'[$G(PSRT) W "      'CS' to process digitally signed CS orders",!
 I $G(PSRT)']"" W "      'SU' to process supply item orders",!
 I $G(PSRT)]"","SUCS"'[$G(PSRT) W "      'SU' to process supply item orders",!
 I $D(PSRT) W "   or 'C' to continue with one filter ",!
 W "   or 'E' or '^' to exit" W ! Q
RT ;which route to sort by  ;PAPI 441
 N RESULTS,PSOPARKX
 S RESULTS="PSOPARKX" D GETPARK^PSORPC01()
 W !!,"Enter 'W' to process window orders first"
 W !,"      'M' to process mail orders first"
 ;I $P($G(PSOPAR),"^",34) W !,"      'P' to process park orders first"
 I $G(PSOPARKX(0))="YES" W !,"      'P' to process park orders first"
 W !,"      'C' to process orders administered in clinic first"
 W !,"   or 'E' or '^' to exit" Q
PT ;process for all or one patient
 W !!,"Enter 'A' to process all patient orders",!,"      'S' to process orders for a patient",!,"      or 'E' or '^' to exit" Q
EP ;continue processing or not
 W !,"If you want to continue processing orders Press RETURN or enter '^' to exit" Q
LOCK S PSOPLCK=$$L^PSSLOCK(PAT,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S POERR("QFLG")=1
 K PSOPLCK
 Q
ULK S X=PAT_";DPT(" D ULK^ORX2 S:$G(PSOQUIT) POERR("QFLG")=1 ; not called anymore
 Q
LOCK1 ;
 I $P($G(^PS(52.41,ORD,0)),"^",24) S PSOACT=$S($D(^XUSEC("PSDRPH",DUZ)):"DEFX",$D(^XUSEC("PSORPH",DUZ)):"F",'$D(^XUSEC("PSORPH",DUZ))&($P($G(PSOPAR),"^",2)):"F",1:"")
 E  S PSOACT=$S($D(^XUSEC("PSORPH",DUZ)):"DEFX",'$D(^XUSEC("PSORPH",DUZ))&($P($G(PSOPAR),"^",2)):"F",1:"")
 Q
EX K DRET,SIG,PSODRUG,PRC,PHI
 K DIR,DIRUT,DUOUT,DIRUT,X,Y,DIC,POERR,PSONEW,PSOSD,MAIL,CLI,WIN,OR0,OR1,OR2,ORD,SRT,PSRT,PSODFN,PSOFROM,T,OR3,PAT,%,%T,%Y,DI,DQ,DR,DRG,STA,I,T1,PSOSORT,PSOCSP
 K TO,TC,TZ,PSOCPAY,PSOBILL,PSOIBQS,GROUPCNT,AGROUP,AGROUP1,OBX,%,%I,%H,D0,DFN,PSORX,PSOPTPST,PSOQFLG,PT,RTN,TM,TM1,DIPGM,PSOID,PSOCNT,PSOLK,PSZFIN,PSZFZZ D KVA^VADPT
 K PSOFDR,PSOQUIT,PSOFIN,^TMP("PSOAO",$J),^TMP("PSODA",$J),^TMP("PSOPO",$J),^TMP("PSOPF",$J),^TMP("PSOPI",$J),^TMP("PSOHDR",$J),MEDA,MEDP
 K C,CC,CNT,CRIT,D,DGI,DGS,DREN,IT,JJ,LG,MM,NIEN,PSOD,PATA,PSDAYS,PSOACT,PSOBM,PSOCOU,PSOCOUU,PSOFLAG,PSON,PSONOOR,PSOOPT,PSOPF,PSOPI,PSRF,RXFL,SDA,SEG1,SER,SERS,SLPPL,STAT,Z,Z4,ZDA
 D FULL^VALM1
 Q
