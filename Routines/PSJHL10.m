PSJHL10  ;BIR/LDT,BSJ-VALIDATE INCOMING HL7 DATA/CREATE NEW ORDER ;30 MAY 07
 ;;5.0; INPATIENT MEDICATIONS ;**58,78,91,109,110,195**;16 DEC 97;Build 3
 ;
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PSBAPIPM is supported by DBIA# 3564.
 ; Reference to ^ORERR is supported by DBIA# 2187.
 ;
VALID ;
 ;Call BCMA for rest of data
 D MOB^PSBAPIPM(PSJHLDFN,+PSJORDER)
 N DATA0,CHK S DATA0=$G(^TMP("PSB",$J,0)) I DATA0=-1 S PSREASON="""YOUR ORDER WAS NOT SAVED. EXIT BCMA, SIGN BACK IN, THEN TRY AGAIN.""" D ERROR Q
 I $P(DATA0,"^")'=PSJHLDFN S PSREASON="Patient does not match" D ERROR Q
 I $P(DATA0,"^",2)'=+PSJORDER S PSREASON="Order number does not match" D ERROR Q
 N VAIP S DFN=PSJHLDFN,VAIP("D")=$G(LOGIN) D IN5^VADPT
 ;If UD do UD set/validate.
 I $P(DATA0,"^",3)="" D UDSET
 ;If IV do IV set/validate.
 I $P(DATA0,"^",3)]"" D IVSET
 D:'CHK EN1^PSJHL2(PSJHLDFN,"OK",PSGORD),EN1^PSJHL2(PSJHLDFN,"SC",PSGORD),EN1^PSJHL2(PSJHLDFN,"ZV",PSGORD),MOBR^PSBAPIPM(PSJHLDFN,+PSJORDER,PSGORD)
 Q
 ;
ERROR ;Sends error msg to CPRS, logs error in OE/RR Errors file
 S X="ORERR" X ^%ZOSF("TEST") I  D EN^ORERR(PSREASON,.PSJMSG),MOBR^PSBAPIPM(PSJHLDFN,+PSJORDER)
 D EN1^PSJHLERR(PSJHLDFN,"OC",PSJORDER,PSREASON) S QFLG=1 K ^TMP("PSJNVO",$J),^TMP("PSB",$J)
 Q
 ;
UDSET ;Set up UD variables
 N PSGPR,PSGMR,PSGSM,PSGHSM,PSGST,PSGP,PSGSCH,PSGPDRG,PSGDO,PSGNESD,PSGNEFD,PSGOEAV,PSJSYSU,PSGS0XT,PSGS0Y
 S PSGPR=PROVIDER,PSGMR=ROUTE,PSGSM=0,PSGHSM="",PSGST="O",PSGP=PSJHLDFN,PSGSCH=SCHEDULE,PSGPDRG=PSITEM
 S (PSGNESD,PSGNEFD)=+$P(DATA0,"^",5),PSGOEAV=1,PSJSYSU=1,PSGS0XT="O",PSGS0Y=""
 I $G(DOSE)]"",$G(UNIT)]"" S PSGDO=DOSE_UNIT
 I $G(PSGDO)']"",$G(INSTR)]"" S PSGDO=$$TRIM^XLFSTR(INSTR,"R"," ")
 S CHK=""
 S ND=U_PSGPR_U_PSGMR_"^U^"_PSGSM_U_PSGHSM_U_PSGST_"^^"_"E"_"^^^^^"_LOGIN_U_PSGP_U_LOGIN
 D CHK("^^"_PSGMR_"^^^^"_PSGST,PSGPDRG_U_PSGDO,PSGSCH_U_PSGNESD_"^^"_PSGNEFD)
 I CHK D ERROR Q
 I PSGSCH'="STAT",PSGSCH'="NOW" S PSREASON="Invalid Schedule" S CHK=1 D ERROR Q
 I ORDCON'="V",ORDCON'="P" S PSREASON="Invalid Nature of Order" S CHK=1 D ERROR Q
 D:'$D(^PS(55,PSGP,0)) ENSET0^PSGNE3(PSGP) S $P(^PS(55,PSGP,5.1),U,2)=PSGPR,PSGOEPR=PSGPR
 S ND0=ND D ENGNA^PSGOETO
 I $D(^PS(51.2,+PSGMR,0)),$P(^(0),U,3)]"" S PSGMRN=$P(^(0),U,3)
 S ND0=DA_ND0
 S $P(ND0,"^",21)=PSJORDER
 S ND2=PSGSCH_U_PSGNESD_"^^"_PSGNEFD_U_PSGS0Y_U_PSGS0XT_"^^^^"_+VAIP(5)
 S $P(ND4,U,7)=DUZ I PSGOEAV,PSJSYSU D
 .S $P(ND4,U,PSJSYSU,PSJSYSU+1)=DUZ_U_+$P(DATA0,"^",5),$P(ND4,U,+PSJSYSU=1+9)=1,$P(ND4,U,+PSJSYSU=3+9)=0
 .S $P(ND4,U,9,10)=+$P(ND4,U,9)_U_+$P(ND4,U,10)
 .I '$P(ND4,U,9) S ^PS(55,"APV",PSGP,DA)=""
 .I '$P(ND4,U,10) S ^PS(55,"NPV",PSGP,DA)=""
 .I $P(ND4,U,9) K ^PS(55,"APV",PSGP,DA)
 .I $P(ND4,U,10) K ^PS(55,"NPV",PSGP,DA)
 S F="^PS(55,"_PSGP_",5,"_DA_",",@(F_"0)")=ND0
 ;naked reference on the four (4) lines below refer to the full ref to ^PS(55,PSGP,5,DA created by indirection using variable F
 I $G(INSTR)]"" S @(F_".3)")=INSTR
 S @(F_".2)")=PSGPDRG_U_PSGDO S $P(^(.2),U,3,6)=$G(ORDCON)_"^"_$E(PRIORITY,2)_"^"_$G(DOSE)_"^"_$G(UNIT)
 S @(F_"2)")=ND2,^(4)=ND4
 S (C,X)=0 F  S X=$O(^TMP("PSB",$J,700,X)) Q:'X  S D=$G(^(X,0)) I D S C=C+1,@(F_"1,"_C_",0)")=$P(D,U,1,2),@(F_"1,""B"","_+D_","_C_")")=""
 S:C @(F_"1,0)")=U_"55.07P^"_C_U_C
 I $D(PROCOM) D
 .;naked refs on the three lines below refer to the full ref to ^PS(55,PSGP,5,DA created by indrection using variable F
 .I '$D(@(F_"12,0)")) S ^(0)=U_55.0612_U_0_U_0
 .S JJ=0 F  S JJ=$O(PROCOM(JJ)) Q:'JJ  S $P(@(F_"12,0)"),"^",3,4)=JJ_"^"_JJ,@(F_"12,"_JJ_",0)")=PROCOM(JJ)
 S @(F_"6)")=$$ENPC^PSJHL11("U",180)
 D CRA^PSGOETO
 L -^PS(55,DFN,5,DA)
 S PSGORD=DA_"U"
OUT ;
 Q
 ;
CHK(X,Y,Z)      ;Check for required fields
 ; Input: X="^^"_MED ROUTE_"^^^^"_SCH TYPE
 ;        Y=ORDERABLE ITEM_"^"_DOSAGE ORDERED
 ;        Z=SCHEDULE_"^"_START DATE/TIME_"^^"_STOP DATE/TIME
 D CHK^PSJHL7(X,Y,Z)
 Q
 ;
DDOK(PSJF,OI) ;Check to be sure all dispense drugs that are active in the
 ;order are valid.
 ; Input: PSJF - File root of the order including all but the IEN of 
 ;               the drug. (EX "^PS(53.45,X,2,")
 ;        OI   - IEN of the order's orderable item
 ; Output: 1 - all active DD's in the order are valid
 ;         0 - no DD's active DD's or at least one active is invalid
 N DDCNT,ND,PSJ,PSJ1 S (PSJ1,DDCNT)=0
 I '$D(PSGDT) D NOW^%DTC S PSGDT=+$E(%,1,12)
 I '$O(@(PSJF_"0)")) Q 1
 ; Naked reference below refers to ^PS(53.45, created using indirection in variable PSJF
 F PSJ=0:0 S PSJ=$O(@(PSJF_PSJ_")")) Q:'PSJ  S ND=$G(@(PSJF_PSJ_",0)"))  D
 .S DDCNT=DDCNT+1
 .S PSJ1=$S('$D(^PSDRUG(+ND,0)):1,$P($G(^(2)),U,3)'["U":1,+$G(^(2))'=+OI:1,$G(^("I"))="":0,1:^("I")'>PSGDT)
 Q $S('DDCNT:0,PSJ1=1:0,1:1)
 ;
IVSET ;
 N P,DFN S DFN=PSJHLDFN,CHK=""
 F X=1:1:23 S P(X)=""
 S (P(2),P(3),P("NINITDT"))=+$P(DATA0,"^",5),P("LOG")=LOGIN,P(4)=$P(DATA0,"^",3),P(5)=$S(P(4)="S":$P(DATA0,"^",4),1:""),P(6)=PROVIDER,P(8)=$G(INFRT),P(9)=$G(SCHEDULE),P(17)="E",P(21)=PSJORDER,P(22)=LOC
 S:P(4)="P" P(9)=$P(DATA0,"^",6)
 I P(4)="S",P(5)=1 S P(9)=$P(DATA0,"^",6)
 S P("MR")=$S(P(4)="P":$O(^PS(51.2,"B","IV PIGGYBACK",0)),1:$O(^PS(51.2,"B","INTRAVENOUS",0)))
 S (P("CLRK"),P("NINIT"))=CLERK,P("PD")=PSITEM,(P("IVRM"),P("SYRS"),P("CLIN"),P("FRES"),P("OPI"))="",P("RES")=ROC,P("PRY")=$E(PRIORITY,2),P("REM")=""
 I $$SCHREQ^PSJLIVFD(.P),P(15)'>0 N P15 S P15=$$INTERVAL^PSIVUTL(.P)
 D CHKIV I CHK D ERROR Q
 D SETN
 D NEW55^PSIVORFB
 N DA,DIK,ND,PSIVACT
 S ND(0)=+ON55 F X=2:1:23 I $D(P(X)) S $P(ND(0),U,X)=P(X)
 S ND(.3)=$G(P("INS"))
 S $P(ND(0),U,17)="E",ND(1)=P("REM"),ND(3)=P("OPI"),ND(.2)=$P($G(P("PD")),U)_U_$G(P("DO"))_U_+P("MR")_U_$G(P("PRY"))_U_$G(ORDCON) F X=0,1,3,.2,.3 S ^PS(55,DFN,"IV",+ON55,X)=ND(X)
 S $P(^PS(55,DFN,"IV",+ON55,2),U,1,4)=P("LOG")_U_P("IVRM")_U_U_P("SYRS"),$P(^(2),U,8,10)=P("RES")_U_$G(P("FRES"))_U_$S($G(VAIN(4)):+VAIN(4),1:"")
 S $P(^PS(55,DFN,"IV",+ON55,2),U,11)=+P("CLRK")
 S:+$G(P("CLIN")) $P(^PS(55,DFN,"IV",+ON55,"DSS"),"^")=P("CLIN")
 S:+$G(P("NINIT")) ^PS(55,DFN,"IV",+ON55,4)=P("NINIT")_U_P("NINITDT")_"^^^^^^^^"_"1"
 S ^PS(55,"APIV",DFN,+ON55)=""
 I $D(PROCOM) D
 .I '$D(^PS(55,DFN,"IV",+ON55,5,0)) S ^(0)=U_55.1115_U_0_U_0
 .S JJ=0 F  S JJ=$O(PROCOM(JJ)) Q:'JJ  S $P(^PS(55,DFN,"IV",+ON55,5,0),"^",3,4)=JJ_"^"_JJ,^PS(55,DFN,"IV",+ON55,5,JJ,0)=PROCOM(JJ)
 S ^PS(55,DFN,"IV",+ON55,3)=$$ENPC^PSJHL11("V",60)
 F DRGT="AD","SOL" D PUTD55
 K DA,DIK S DA(1)=DFN,DA=+ON55,DIK="^PS(55,"_DA(1)_",""IV"",",PSIVACT=1 D IX^DIK
 L -^PS(55,DFN,"IV",DA)
 S PSGORD=ON55
 Q
 ;
PUTD55 ; Move drug data from local array into 55
 K ^PS(55,DFN,"IV",+ON55,DRGT) S ^PS(55,DFN,"IV",+ON55,DRGT,0)=$S(DRGT="AD":"^55.02PA",1:"^55.11IPA")
 F X=0:0 S X=$O(^TMP("PSB",$J,$S(DRGT="AD":800,1:900),X)) Q:'X  D
 .S Y=^PS(55,DFN,"IV",+ON55,DRGT,0),$P(Y,U,3)=$P(Y,U,3)+1,DRG=$P(Y,U,3),$P(Y,U,4)=$P(Y,U,4)+1
 .S ^PS(55,DFN,"IV",+ON55,DRGT,0)=Y,^PS(55,DFN,"IV",+ON55,DRGT,+DRG,0)=$P(^TMP("PSB",$J,$S(DRGT="AD":800,1:900),X,0),"^")_"^"_$P(^TMP("PSJNVO",$J,DRGT,+DRG,0),"^",2)
 Q
 ;
SETN ;Set up patient 0 node if needed.
 I '$D(^PS(55,DFN,0)) K DO,DA,DD,DIC,PSIVFN S:$D(^(5.1)) PSIVFN=^(5.1) K:$D(PSIVFN) ^(5.1) S (DINUM,X)=DFN,DIC(0)="L",DIC="^PS(55," D FILE^DICN S:$D(PSIVFN) ^PS(55,DFN,5.1)=PSIVFN D  K DIC,PSIVFN,DO,DA,DD
 .; Mark PSJ and PSO as converted
 .S $P(^PS(55,DFN,5.1),"^",11)=2
 Q
 ;
CHKIV ;Validate IV data
 N OK S OK=0
 I "APS"'[P(4) S CHK=1,PSREASON="Invalid IV Type" Q
 I P(9)="",P(4)="P" S CHK=1,PSREASON="Piggyback IV Type requires a schedule" Q
 I P(4)="S",P(5)=1,P(9)="" S CHK=1,PSREASON="Intermittent Syringe IV Type requires a schedule" Q
 I P(9)'="STAT",(P(9)'="NOW"),P(9)'="" S CHK=1,PSREASON="Invalid Schedule" Q
 I ORDCON'="V",ORDCON'="P" S CHK=1,PSREASON="Invalid Nature of Order" Q
 I +$G(^TMP("PSB",$J,800,0))=0,+$G(^TMP("PSB",$J,900,0))=0 S CHK=1,PSREASON="IV orders must have at least one additive or solution" Q
 I +$G(^TMP("PSB",$J,900,0))=0,P(4)'="P" S CHK=1,PSREASON="You must have at least one solution for this order." Q
 I +$G(^TMP("PSB",$J,800,0))'=+$G(^TMP("PSJNVO",$J,"AD",0)) S CHK=1,PSREASON="Number of additives in BCMA & CPRS do not match." Q
 I +$G(^TMP("PSB",$J,900,0))'=+$G(^TMP("PSJNVO",$J,"SOL",0)) S CHK=1,PSREASON="Number of solutions in BCMA & CPRS do not match." Q
 F DRGT="AD","SOL" S FIL=$S(DRGT="AD":52.6,1:52.7) F DRGI=0:0 S DRGI=$O(^TMP("PSB",$J,$S(DRGT="AD":800,1:900),DRGI)) Q:'DRGI  S DRG=$G(^TMP("PSB",$J,$S(DRGT="AD":800,1:900),DRGI,0)) D DRG,@DRGT Q:CHK=1
 I 'OK,'CHK S CHK=1,PSREASON="The Orderable Item does not match any of the additives or solutions in this order" Q
 Q
 ;
AD ;Check additives
 I '$D(^PS(FIL,+DRG,0)) S CHK=1,PSREASON="Additive "_+DRG_" does not exist in the additive file" Q
 ;Naked reference below refers to ^PS(52.6,+DRG,0)
 I $P(^(0),"^",11)=PSITEM S OK=1
 I $$ENU^PSIVUTL(+DRG)'=$P($P(^TMP("PSJNVO",$J,DRGT,+DRGI,0),"^",2)," ",2,99)!(+$P(^TMP("PSJNVO",$J,DRGT,+DRGI,0),"^",2)'>0) S CHK=1,PSREASON="Invalid strength entered for additive "_+DRG Q
 Q
SOL ;Check solutions
 I '$D(^PS(FIL,+DRG,0)) S CHK=1,PSREASON="Solution "_+DRG_" does not exist in the solution file" Q
 ;Naked reference below refers to ^PS(52.7,+DRG,0)
 I $P(^(0),"^",11)=PSITEM S OK=1
 I +$P(^TMP("PSJNVO",$J,DRGT,+DRGI,0),"^",2)>9999!(+$P(^TMP("PSJNVO",$J,DRGT,+DRGI,0),"^",2)'>0) S CHK=1,PSREASON="Volume on "_+DRG_" is an invalid strength" Q
 Q
DRG ;Check to be sure additive/solutions are active
 I $S('$G(^PS(FIL,+DRG,"I")):0,^("I")>DT:0,1:1) S CHK=1,PSREASON="An additive or solution is inactive" Q
 Q
