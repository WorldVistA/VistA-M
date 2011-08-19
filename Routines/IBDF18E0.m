IBDF18E0 ;ALB/CJM - ENCOUNTER FORM - PCE DEVICE INTERFACE utilities ;04-OCT-94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**11,25,38,36,23,62**;APR 24, 1997;Build 9
 ;
SETPXCA ;set values from TEMP() into the PXCA()
 ;
 N NODE,NUMBER,IBQUIT,Y,Y1,X
 S PROVIDER=+$P(PXCA("ENCOUNTER"),"^",4)
 I PROVIDER,"^P^S^"'[("^"_$P(PXCA("ENCOUNTER"),"^",15)_"^") S $P(PXCA("ENCOUNTER"),"^",15)="S" D LOGERR^IBDF18E2(3579603,.FORMID,"",PROVIDER)
 ;
 S NODE="" F  S NODE=$O(TEMP(NODE)) Q:NODE=""  S NUMBER=0,FID="" F  S FID=$O(TEMP(NODE,FID)) Q:FID=""  S ITEM="" F  S ITEM=$O(TEMP(NODE,FID,ITEM)) Q:ITEM=""  D
 .S IBQUIT=0
 .I NODE="PROCEDURE" S X=TEMP(NODE,FID,ITEM) D
 ..I $P(X,"^",2)="" S $P(X,"^",2)=1
 ..S Y=0 F  S Y=$O(PXCA(NODE,PROVIDER,Y)) Q:'Y!(IBQUIT)  D
 ...S Y1=$G(PXCA(NODE,PROVIDER,Y))
 ...I $P(X,"^")=$P(Y1,"^"),$P(X,"^",3,7)=$P(Y1,"^",3,7) S $P(PXCA(NODE,PROVIDER,Y),"^",2)=$P(PXCA(NODE,PROVIDER,Y),"^",2)+$P(X,"^",2),IBQUIT=1
 ..Q:IBQUIT
 ..S TEMP(NODE,FID,ITEM)=X
 .I IBQUIT K TEMP(NODE,FID,ITEM) Q
 .S NUMBER=NUMBER+1
 .S PXCA(NODE,PROVIDER,NUMBER)=TEMP(NODE,FID,ITEM)
 .I $D(TEMP(NODE,FID,ITEM,"MODIFIER")) D MODPXCA
 .K TEMP(NODE,FID,ITEM)
 ;
 ; -- default c/o date time to now if not passed
 I '$P($G(^IBD(357.09,1,1)),"^",2) D  ;cont only if s/p not answerred
 .I $D(PXCA("ENCOUNTER")) I $P(PXCA("ENCOUNTER"),"^",14)="" D  ;quit if we are already passing c/o date/time
 ..N SDOE S SDOE=$$FNDSDOE^IBDFDE($S(+$G(FORMID("DFN")):+$G(FORMID("DFN")),+$G(IBDF("DFN")):+$G(IBDF("DFN")),1:$G(DFN)),$S(+$G(FORMID("APPT")):+$G(FORMID("APPT")),+$G(IBDF("APPT")):+$G(IBDF("APPT")),1:$G(APPT)))
 ..Q:$$COMDT^SDCOU(+SDOE)  ;c/o already performed, don't overwrite
 ..N IBDDFN,IBDAPPT,IBDCLN,IBDCOST
 ..S IBDDFN=$S(+$G(FORMID("DFN")):+$G(FORMID("DFN")),+$G(IBDF("DFN")):+$G(IBDF("DFN")),1:$G(DFN))
 ..S IBDAPPT=$S(+$G(FORMID("APPT")):+$G(FORMID("APPT")),+$G(IBDF("APPT")):+$G(IBDF("APPT")),1:$G(APPT))
 ..S IBDCLN=$S(+$G(FORMID("CLINIC")):+$G(FORMID("CLINIC")),+$G(IBDF("CLINIC")):+$G(IBDF("CLINIC")),1:$G(CLN))
 ..S IBDCOST=$$STATUS^SDAM1(IBDDFN,IBDAPPT,IBDCLN,$G(^DPT(IBDDFN,0))) Q:$P(IBDCOST,";",5)
 ..S $P(PXCA("ENCOUNTER"),"^",14)=$E($$HTFM^XLFDT($H),1,12)
 ;
 D OTHRBUB
 Q
 ;
 ;
OTHRBUB ; -- check procedure and diagnosis node for other bubble, but no data
 N NODE,CODE,OUT,X,XX
 S I=0 F  S I=$O(PXCA("PROCEDURE",I)) Q:I=""  S J=0 F  S J=$O(PXCA("PROCEDURE",I,J)) Q:J=""  D
 .I +$G(PXCA("PROCEDURE",I,J))<1 D  ;no code, may be treatment
 ..I $P($G(PXCA("PROCEDURE",I,J)),"^",6)["OTHER#" D  ;no code, narr=other
 ...D LOGERR^IBDF18E2(3579612,.FORMID)
 ...K PXCA("PROCEDURE",I,J)
 .I +$G(PXCA("PROCEDURE",I,J)),$P($G(PXCA("PROCEDURE",I,J)),"^",6)["OTHER#" D
 ..;; --change to api cpt ; dhh
 ..S CODE=$$CPT^ICPTCOD(CODE)
 ..S $P(PXCA("PROCEDURE",I,J),"^",6)=$S(+CODE'=-1:$E($P((CODE),"^",3),1,80),1:"")
 ;
 S I=0 F  S I=$O(PXCA("DIAGNOSIS/PROBLEM",I)) Q:I=""  S J=0 F  S J=$O(PXCA("DIAGNOSIS/PROBLEM",I,J)) Q:J=""  D
 .I $P($G(PXCA("DIAGNOSIS/PROBLEM",I,J)),"^",13)="" K OUT D
 ..S X=$P($$ICDDX^ICDCODE(+$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^"),$G(DT),"",1),"^",2) D
 ...S XX=$$ICDD^ICDCODE(X,"OUT"),$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",13)=$E($G(OUT(1)),1,79)
 .I $P($G(PXCA("DIAGNOSIS/PROBLEM",I,J)),"^",13)["OTHER#" K OUT D
 ..S X=$P($$ICDDX^ICDCODE(+$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^"),$G(DT),"",1),"^",2) D
 ...S XX=$$ICDD^ICDCODE(X,"OUT"),$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",13)=$E($G(OUT(1)),1,79)
 Q
 ;
PRO ; -- make sure diagnosis code is added to DIAGNOSIS/PROBLEM node
 S I=0 F  S I=$O(PXCA("DIAGNOSIS/PROBLEM",I)) Q:I=""  S J=0 F  S J=$O(PXCA("DIAGNOSIS/PROBLEM",I,J)) Q:J=""  D
 .I $TR($P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",5,8),"^","")']"",($P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",2)="") S $P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",2)="S" D
 ..D LOGERR^IBDF18E2(3579505,.FORMID,"",+PXCA("DIAGNOSIS/PROBLEM",I,J),"","","",$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",13))
 .Q:+$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^")
 .I +$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",3) D
 ..S IBX=$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",3) D
 ...I $D(^LEX)>1 S X="LEXU" X ^%ZOSF("TEST") I $T S IBX=$$ICDONE^LEXU(IBX) S:$L(IBX)<1 IBX=799.9 Q  ; clinical lexicon next version to be in ^LEX
 ...S X="GMPTU" X ^%ZOSF("TEST") I $T S IBX=$$ICDONE^GMPTU(IBX) S:$L(IBX)<1 IBX=799.9 Q
 ...S IBX=799.9
 ...Q
 ..S IBXI=+$O(^ICD9("BA",IBX_" ",0)) I +IBXI<1 S IBXI=+$O(^ICD9("BA",799.9_" ",0))
 ..I +IBXI<1 D LOGERR^IBDF18E2(3579506,.FORMID,"",$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",3),"","","",$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",13)) Q
 ..S $P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^")=IBXI
 ..Q
 .;
 .; -- set diagnosis code from problem list into piece 1 of array
 .I +$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",4) S $P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^")=$$PROBDIA^IBDFBK3(+$P(PXCA("DIAGNOSIS/PROBLEM",I,J),"^",4))
 Q
 ;
CODES ; -- if addt'l codes to pass and qual is prim or sec, send 2nd code
 N VALUE,IBI,OQLFR
 S OQLFR=QLFR
 Q:$G(QLFR)']""
 Q:"PRIMARYSECONDARYADD TO PROBLEM LIST"'[$P($G(^IBD(357.98,QLFR,0)),"^")
 F IBI=3,4 S VALUE=$P($G(^IBD(357.95,FORMTYPE,1,BUB,2)),"^",IBI) Q:'$G(VALUE)  D
 .N QLFR,TEXT,X,Y
 .D
 ..S X=VALUE
 ..I $G(^ICD9($G(X),0))="" K X S Y="" Q
 ..E  S Y=$$ICDDX^ICDCODE(+X,$G(DT),"",1),Y=$P(Y,"^",4)
 .S TEXT=Y
 .S QLFR=$O(^IBD(357.98,"B",$S($E(OQLFR)="S":"SECONDARY",1:"ADD TO PROBLEM LIST"),0))
 .S ITEM=ITEM_"."_IBI
 .D SETTEMP^IBDF18E1
 .S ITEM=$P(ITEM,".")
 Q
 ;
TRACKING(FORMID) ;get form tracking info,sets FORMID array, which should be pass
 ;
 S NODE=$G(^IBD(357.96,FORMID,0))
 Q:NODE="" 0
 S FORMID("APPT")=$P(NODE,"^",3),FORMID("CLINIC")=$P(NODE,"^",10),FORMID("DFN")=$P(NODE,"^",2),FORMID("SOURCE")=$P(NODE,"^",7)
 Q 1
 ;
SC ; -- if SC answered yes then all other classifications = null
 I $P(PXCA("ENCOUNTER"),"^",6) S $P(PXCA("ENCOUNTER"),"^",7,9)="^^"
 ;
 ; - If 'no classifications' was bubbled in then all other
 ;   classifications = null
 I $P($G(PXCA("IBD NOCLASSIFICATION")),"^",3) S $P(PXCA("ENCOUNTER"),"^",6,10)="^^^^"
 Q
 ;
INPT(DFN,APPT) ; -- determine inpatient status
 N INPT
 S INPT=$P($G(^DPT(+$G(DFN),"S",+$G(APPT),0)),"^",2)="I"
 Q:'INPT
 ;
 ; -- kill erroneous warnings for inpatients
 I $G(PXCA("WARNING","ENCOUNTER",0,0,6))["SC flag is missing" K PXCA("WARNING","ENCOUNTER",0,0,6)
 I $G(PXCA("WARNING","ENCOUNTER",0,0,7))["AO flag is missing" K PXCA("WARNING","ENCOUNTER",0,0,7)
 I $G(PXCA("WARNING","ENCOUNTER",0,0,8))["IR flag is missing" K PXCA("WARNING","ENCOUNTER",0,0,8)
 I $G(PXCA("WARNING","ENCOUNTER",0,0,9))["EC flag is missing" K PXCA("WARNING","ENCOUNTER",0,0,9)
 Q
MODPXCA ; -- copy CPT Modifier information from TEMP to PXCA
 ;
 N MOD,MODX,MODNODE,CODE
 S CODE=$P($G(TEMP(NODE,FID,ITEM)),"^")
 S MOD=0 F  S MOD=$O(TEMP(NODE,FID,ITEM,"MODIFIER",MOD)) Q:MOD']""  D
 . S MODX=TEMP(NODE,FID,ITEM,"MODIFIER",MOD)
 . S MODNODE=$$MODP^ICPTMOD(CODE,MODX)
 . S:+MODNODE>0 PXCA(NODE,PROVIDER,NUMBER,MODX)=$$MOD^ICPTMOD(+MODNODE,"I")
 Q
VSTPXCA ; -- copy CPT Modifier information from TEMP to PXCA for Visit
 ;
 N I,J,MOD,MODX
 S I=0 F  S I=$O(TEMP("ENCOUNTER",I)) Q:I']""  D
 . S J=0 F  S J=$O(TEMP("ENCOUNTER",I,J)) Q:'J  D
 .. S MOD=0 F  S MOD=$O(TEMP("ENCOUNTER",I,J,"MODIFIER",MOD)) Q:MOD']""  D
 ... S MODX=TEMP("ENCOUNTER",I,J,"MODIFIER",MOD)
 ... S PXCA("ENCOUNTER","MODIFIER",MODX)=""
 K TEMP("ENCOUNTER")
 Q
