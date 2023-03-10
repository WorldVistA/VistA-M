PSONVNEW ;BIR/SAB - Add Non-VA Med orders ;Feb 28, 2022@14:29:26
 ;;7.0;OUTPATIENT PHARMACY;**132,118,203,265,282,455,441**;DEC 1997;Build 208
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;External reference ^PS(50.7 supported by DBIA 2223
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference to ^PS(51.2 supported by DBIA 2226
 ;External reference to ^ORHLSEC supported by DBIA 4922
 ;adds new non-va med to #55
 ;
 ;*203 change 3 fields from "///" to "////" they can be larger than
 ;      defined and need to be put in as is to prevent hard crash.
 ;*265 change update of Dosage & Sched fields DR strings, can contain ;      free form char ";"
 ;*441 Add Complex Orders to NVA Meds
 ;
 I '$D(^PS(55,DFN,0)) D
 .K DD,DO S DIC(0)="L",(DINUM,X)=DFN,DIC("DR")="52.1////2" D FILE^DICN D:Y<1  K DIC,DA,DR,DD,DO
 ..S $P(^PS(55,DFN,0),"^")=DFN,$P(^(0),"^",6)=2
 ..K DIK S DA=DFN,DIK="^PS(55,",DIK(1)=.01 D EN^DIK K DIK
 ;
 N PSONVA,DSC,ORCSEG,PSOIND K PCOM
 F I=0:0 S I=$O(MSG(I)) Q:'I  D
 .I $P(MSG(I),"|")="NTE",$P(MSG(I),"|",2)=6 S DSC=$G(DSC)+1 S PCOM(DSC)=$P(MSG(I),"|",4) F T=0:0 S T=$O(MSG(I,T)) Q:'T  S DSC=DSC+1,PCOM(DSC)=MSG(I,T)
 .I $P(MSG(I),"|")="ORC" S STDT=$P(MSG(I),"|",10),STRDT=$$HL7TFM^XLFDT(STDT),ORCSEG=$P($G(MSG(I)),"|",8)
 .I $P(MSG(I),"|")="RXO" S PSOIND=$P(MSG(I),"|",21)  ;*441-IND
 ;
 ; - Files the Non-VA Med order into the "NVA" multiple in File #55
 K DR,DIC,DD,DA,DO,DINUM S DA(1)=DFN,X=PSORDITE
 ;*203,*265 fix DR & dose & sched fields
 ;it appears NVA old structure never took into account Possible dose vs. Local Possible dose, fix below
 S PSODOS=$S($G(PSOQWX)&($G(PSOLQ1II(1))):Q1I(1),$G(PSOQWX)&($G(PSOLQ1IX(1))'="")&('$G(PSOLQ1II(1))):PSOLQ1IX(1),1:$G(PSOLQ1I(1)))  ;init Dose for 1st rec for backwards compatible structure
 S PSOSCH=$$SCHED($P($G(QTARRAY(1)),"^"))
 S DR="1////"_PSODDRUG_";2////^S X=PSODOS;3////"_$$ROUTE($G(ROUTE(1)))
 S DR=DR_";4////^S X=PSOSCH;7////"_$G(PLACER)_";8///"_$P($G(STRDT),".") ;*455 - ONLY STORE DATE, NOT TIME
 S DR=DR_";11///"_$G(PSOLOG)_";12////"_$G(ENTERED)_";13////"_$G(LOCATION)_";15////^S X=$$UNESC^ORHLESC($G(PSOIND))"  ;*441-IND
 S DIC("DR")=DR,DIC(0)="L",DIC="^PS(55,"_DFN_",""NVA"",",DLAYGO=55.05
 D FILE^DICN S PSONVA=+Y K DR,DIC,DD,DA,DO,DINUM
 ;introduces complex non-va orders via CPRS
 K FDA S DA(1)=+Y,DA(2)=DFN
 I $G(QCOUNT) D
 .N PP,ORC
 .F PP=0:0 S PP=$O(QTARRAY(PP)) Q:'PP  D
 ..S ORC=$P($G(ORCSEG),"~",PP)
 ..S FDA(55.516,"+1,"_DA(1)_","_DA(2)_",",.01)=$TR($G(ORC),"^","|")
 ..S FDA(55.516,"+1,"_DA(1)_","_DA(2)_",",1)=$$SCHED($P($P($G(QTARRAY(PP)),"^"),"&"))   ;nva meds schedules can have embedded & sub-delimiter for IP patients vs. OP patients
 ..S FDA(55.516,"+1,"_DA(1)_","_DA(2)_",",2)=$P($G(QTARRAY(PP)),"^",2)
 ..S FDA(55.516,"+1,"_DA(1)_","_DA(2)_",",3)=$P($G(QTARRAY(PP)),"^",6)
 ..;init val to either Possible Dose or Local Possible Dose
 ..S VAL=$S($G(PSOQWX)&($G(PSOLQ1II(PP))):Q1I(PP),$G(PSOQWX)&($G(PSOLQ1IX(PP))'="")&('$G(PSOLQ1II(PP))):PSOLQ1IX(PP),1:PSOLQ1I(PP))
 ..S FDA(55.516,"+1,"_DA(1)_","_DA(2)_",",4)=VAL
 ..D UPDATE^DIE("","FDA") K FDA
 ;
 S PSONVA=+Y K DR,DIC,DD,DA,DO,DINUM
 K PSODOS,PSOSCH
 ;
 K DSC,STDT
 I $P(PSODSC,"^",2)]"" D
 .S DSC=1,^PS(55,DFN,"NVA",PSONVA,"DSC",1,0)=$P(PSODSC,"^",2)
 .S ^PS(55,DFN,"NVA",PSONVA,"DSC",0)="^55.052^1^1^"_DT_"^^^^"
 I $O(PSODSC(0)) D
 .F T=0:0 S T=$O(PSODSC(T)) Q:'T  S DSC=$G(DSC)+1,^PS(55,DFN,"NVA",PSONVA,"DSC",DSC,0)=PSODSC(T)
 .S ^PS(55,DFN,"NVA",PSONVA,"DSC",0)="^55.052^"_DSC_"^"_DSC_"^"_DT_"^^^^"
 I $O(PCOM(0)) F T=0:0 S T=$O(PCOM(T)) Q:'T  D
 .S DSC=$G(DSC)+1,^PS(55,DFN,"NVA",PSONVA,"DSC",DSC,0)=$$UNESC^ORHLESC(PCOM(T)) ;*455
 .S ^PS(55,DFN,"NVA",PSONVA,"DSC",0)="^55.052^"_DSC_"^"_DSC_"^"_DT_"^^^^"
 .S ^PS(55,DFN,"NVA",PSONVA,1,T,0)=$$UNESC^ORHLESC(PCOM(T)) ;*455
 .S ^PS(55,DFN,"NVA",PSONVA,1,0)="^^"_T_"^"_T_"^"_DT_"^"
 I $G(OCOUNT) S ^PS(55,DFN,"NVA",PSONVA,"OCK",0)="^55.051^"_OCOUNT_"^"_OCOUNT F OCOUNT=1:1:OCOUNT D
 .S ^PS(55,DFN,"NVA",PSONVA,"OCK",OCOUNT,0)=$G(OBXAR(OCOUNT,1))_"^"_PROV
 .I $G(OBXAR(OCOUNT,1))]"" S ^PS(55,DFN,"NVA",PSONVA,"OCK","B",$E(OBXAR(OCOUNT,1),1,30),OCOUNT)=""
 .S PSOBCT=1 F LLL=2:1 Q:'$D(OBXAR(OCOUNT,LLL))  S ^PS(55,DFN,"NVA",PSONVA,"OCK",OCOUNT,"OVR",1,0)=OBXAR(OCOUNT,LLL)
 K HOLD,SCH,SCHED,SDL,SGL,A,W,WW,CHR,STRDT
 ;
 M PMSG=MSG
REIN K MSG S NULLFLDS="F JJ=0:1:LIMIT S FIELD(JJ)="""""
 K ^UTILITY("DIQ1",$J),DIQ S DA=$P($$SITE^VASITE(),"^")
 I $G(DA) S DIC=4,DIQ(0)="I",DR="99" D EN^DIQ1 S PSOHINST=$G(^UTILITY("DIQ1",$J,4,DA,99,"I")) K ^UTILITY("DIQ1",$J),DA,DR,DIQ,DIC
 S MSG(1)="MSH|^~\&|PHARMACY|"_$G(PSOHINST)_"|||||ORR"
 ;
 S COUNT=1,LIMIT=5 X NULLFLDS D DEM^VADPT S NAME=$G(VADM(1)) K VADM
 S FIELD(0)="PID",FIELD(3)=DFN,FIELD(5)=NAME
 D SEG^PSOHLSN1
 ;
 ;
 S LIMIT=19 X NULLFLDS
 S FIELD(0)="PV1",FIELD(2)="O",FIELD(3)=LOCATION
 D SEG^PSOHLSN1
 ;
 S LIMIT=15 X NULLFLDS
 S FIELD(0)="ORC",FIELD(1)=$S($G(REIN):"SC",1:"OK"),FIELD(2)=PLACER_"^OR",FIELD(3)=PSONVA_"N^PS",FIELD(5)="CM"
 S FIELD(10)=$P(^PS(55,DFN,"NVA",PSONVA,0),"^",11)_"^"_$P(^VA(200,$P(^PS(55,DFN,"NVA",PSONVA,0),"^",11),0),"^")
 D SEG^PSOHLSN1
 I $G(REIN) S MSG(COUNT)=MSG(COUNT)_"|^^^^DATE OF DEATH DELETED BY MAS.^"
 ;
 S LIMIT=20 X NULLFLDS
 S FIELD(0)="RXO",OI=$P(^PS(55,DFN,"NVA",PSONVA,0),"^")
 S FIELD(1)="^^^"_OI_"^"_$P($G(^PS(50.7,OI,0)),"^")_" "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")_"^99PSP"
 S FIELD(20)=$G(PSOIND)
 D SEG^PSOHLSN1
 ;
 S LIMIT=1 X NULLFLDS
 S FIELD(0)="RXE"
 S PSOPSTRT="",X=$P(^PS(55,DFN,"NVA",PSONVA,0),"^",9) I X S PSOPSTRT=$$FMTHL7^XLFDT(X)
 K X S FIELD(1)="^^^"_$G(PSOPSTRT)_"^"
 D SEG^PSOHLSN1
 ;
 D SEND^PSOHLSN1 K FIELDS,LIMIT,PSODSC,PSONVA,OI Q:$G(REIN)
 ;dc change order
DC F OO=0:0 S OO=$O(PMSG(OO)) Q:'OO  I $P(PMSG(OO),"|")="ORC",$P(PMSG(OO),"|",2)="XO" D  Q
 .F XO=0:0 S XO=$O(PMSG(XO)) Q:'XO  I $P(PMSG(XO),"|")="ZRX" S POERR("PSOFILNM")=$P(PMSG(XO),"|",2) Q
 I +$G(POERR("PSOFILNM")),$G(^PS(55,DFN,"NVA",+$G(POERR("PSOFILNM")),0)) S PDFN=DFN D XO^PSOORUTL
 K XO,OO,PMSG
 Q
SCHED(SCH) ; Returns the SCHEDULE description
 ;SCH = Schedule entered
 ;Returns Expanded Schedule, or ""
 N SCHEX,SPCT
 S SCH=$$UPPER(SCH)
 I SCH="" Q ""
 S SPCT=0 F I=1:1:$L(SCH) I $E(SCH,I)=" " S SPCT=SPCT+1
 S SCHEX=$$EXP(SCH) I SCHEX]"" Q SCHEX
 Q:SPCT=0 SCH
 Q $$SCHED($P(SCH," ",1,SPCT))_" "_$$SCHED($P(SCH," ",SPCT+1))
EXP(X) ; expand based on 51.1 and 51
 N PSIN,SCFLG,SCHEX
 S PSIN=0 F  S PSIN=$O(^PS(51.1,"APPSJ",X,PSIN)) Q:'PSIN!$G(SCFLG)  I $P(^PS(51.1,PSIN,0),"^",8)'="" S SCHEX=$P($G(^(0)),"^",8),SCFLG=1
 Q:$G(SCFLG) SCHEX
 S PSIN=0 F  S PSIN=$O(^PS(51,"B",X,PSIN)) Q:'PSIN!$G(SCLFL)  I PSIN,($P(^PS(51,PSIN,0),"^",4)<2)&($P($G(^PS(51,"A",X)),"^")'="") S SCHEX=$P(^(X),"^"),SCFLG=1
 Q:$G(SCFLG) SCHEX
 Q ""
UPPER(PSOSCUP) ;
 Q $TR(PSOSCUP,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
ROUTE(RTIEN) ; Returns the ROUTE description
 N X
 Q:'$G(RTIEN) "" S X=$G(^PS(51.2,RTIEN,0))
 Q $S($P(X,"^",2)'="":$P(X,"^",2),1:$P(X,"^"))
 ;
APSOD ;dc non-va meds because of date of death entry called from psocan3
 N PDA,PDFN ;,POERR("PSOFILNM")
 F PDA=0:0 S PDA=$O(^PS(55,PSODFN,"NVA",PDA)) Q:'PDA  I '$P(^PS(55,PSODFN,"NVA",PDA,0),"^",6),'$P(^(0),"^",7) D
 .S POERR("PSOFILNM")=PDA,PDFN=PSODFN D XO^PSOORUTL
 Q
