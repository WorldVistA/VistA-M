IBDFBK3 ;ALB/AAS - AICS broker Utilities ;23-May-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**12,38,36**;APR 24, 1997
 ;
LSTDATA(RESULT,PXCA,LCNT) ;
 ; -- expand the PXCA array data into human readable terms for
 ;    display on the workstation
 ;
 ;    Input : Result - (called by reference, see output)
 ;            PXCA   - (by referencethe array of data formated to
 ;                      the PCE device interface specification
 ;            lcnt   - (by reference) a counter for the result array
 ;    Output: RESULT - a new array element result(lcnt) will be
 ;                     created for each piece of data received
 ;
 N I,J,M,X,IBX
 ;
 ; -- noshow, cancel or reschedule checked
 I $D(PXCA("IBD-ABORT")) D
 .S I="" F  S I=$O(PXCA("IBD-ABORT",I)) Q:I=""  S J="" F  S J=$O(PXCA("IBD-ABORT",I,J)) Q:J=""  D
 ..S IBX=PXCA("IBD-ABORT",I,J)
 ..S X="The following Data was NOT Sent to PCE because "_$P(IBX,"^",2)_" was marked!"
 ..D NEWLINE(.RESULT,X,.LCNT)
 .Q
 ;
 ; -- expand the encounter node
 I $D(PXCA("ENCOUNTER")) S IBX=PXCA("ENCOUNTER") D
 .I $P(IBX,"^",14) S X="Checkout Date/Time: "_$$FMTE^XLFDT($P(IBX,"^",14)) D NEWLINE(.RESULT,X,.LCNT)
 .I $P(IBX,"^",4) S X=$S($P(IBX,"^",15)="P":"Primary ",$P(IBX,"^",15)="S":"Secondary ",1:"")_"Provider: "_$P($G(^VA(200,+$P(IBX,"^",4),0)),"^") D NEWLINE(.RESULT,X,.LCNT)
 .;; --change to api cpt ; dhh
 .I $P(IBX,"^",5) S X=$P(IBX,"^",5) D
 .. I X'="" D
 ... N IBVST
 ... S X=$$CPT^ICPTCOD(X)
 ... S (X,IBVST)=$S(+X=-1:"",1:$P(X,"^",2))
 ... S X="Visit Type CPT: "_X D NEWLINE(.RESULT,X,.LCNT)
 ... I $D(PXCA("ENCOUNTER","MODIFIER")) D
 .... S X="    Modifier(s): " D NEWLINE(.RESULT,X,.LCNT)
 .... N IBM S IBM=0
 .... F  S IBM=$O(PXCA("ENCOUNTER","MODIFIER",IBM)) Q:IBM']""  D
 ..... N IBMDESC S IBMDESC=$$MODP^ICPTMOD(IBVST,IBM,"E") Q:+IBMDESC<0
 ..... S X="         "_IBM_"-"_$P(IBMDESC,"^",2)
 ..... D NEWLINE(.RESULT,X,.LCNT)
 .; add sc,ao,ir,ec,mst,eligibility,credit stop (pieces 6-10,13,17)
 .I $P(IBX,"^",6) D NEWLINE(.RESULT,"Visit for SC Condition",.LCNT)
 .I $P(IBX,"^",7) D NEWLINE(.RESULT,"Visit for Agent Orange Condition",.LCNT)
 .I $P(IBX,"^",8) D NEWLINE(.RESULT,"Visit for Ionizing Radiation Condition",.LCNT)
 .I $P(IBX,"^",9) D NEWLINE(.RESULT,"Visit for Environmental Contaminates Condition",.LCNT)
 .I $P(IBX,"^",10) D NEWLINE(.RESULT,"Visit for MST",.LCNT)
 .I $P(IBX,"^",13) D NEWLINE(.RESULT,"Eligibility for Visit: "_$P($G(^DIC(8,+$P(IBX,"^",13),0)),"^"),.LCNT)
 .I $P(IBX,"^",17) D NEWLINE(.RESULT,"Additional Credit Stop: "_$P($G(^DIC(40.7,+$P(IBX,"^",17),0)),"^"),.LCNT)
 ;
 ; -- expand the other nodes
 F M="DIAGNOSIS/PROBLEM","PROVIDER","DIAGNOSIS","PROCEDURE","VITALS","PROBLEM","EXAM","IMMUNIZATION","HEALTH FACTORS","SKIN TEST","PATIENT ED","LOCAL" I $D(PXCA(M)) D
 .S I="" F  S I=$O(PXCA(M,I)) Q:I=""  D:M="PROVIDER" PROV S J="" F  S J=$O(PXCA(M,I,J)) Q:J=""  D
 ..K X S IBX=PXCA(M,I,J) D  D:$D(X) NEWLINE(.RESULT,X,.LCNT)
 ...;
 ...I M="DIAGNOSIS" S X=$S($P(IBX,"^",2)="P":"Primary",$P(IBX,"^",2)="S":"Secondary",1:"")_" Diagnosis: "_$P($G(^ICD9(+$P($G(IBX),"^"),0)),"^")_" - "_$P(IBX,"^",9)_" - "_$P(IBX,"^",8) Q
 ...;
 ...I M="PROCEDURE" D
 ....I +IBX D
 ..... S X=$$CPT^ICPTCOD(+IBX)
 ..... S X=$S(X=-1:"",1:$P(X,"^",2))
 ..... S X="Procedure: "_X_" - "_$P(IBX,"^",7)_" - "_$P(IBX,"^",6)_" - "_$S($P(IBX,"^",2)="P":"Primary ",$P(IBX,"^",2)="S":"Secondary ",1:"Quantity: "_+$P(IBX,"^",2))
 ..... Q
 ....I 'IBX S X="Treatment: "_$P(IBX,"^",6)
 ...;
 ...I M="VITALS" S X="Vital Sign: "_$$VTYPE($P(IBX,"^"))_": "_$P(IBX,"^",2) Q
 ...;
 ...I M="IMMUNIZATION" S X="Immunization: "_$$DSPLYIM^PXAPIIB(+IBX) I $P(IBX,"^",5) S X=X_" - Contraindicated" Q
 ...;
 ...I M="EXAM" S X="Exam: "_$$DSPLYEX^PXAPIIB(+IBX)_$S($P(IBX,"^",2)="A":" Abnormal",$P(IBX,"^",2)="N":" Normal",1:"") Q
 ...;
 ...I M="PROBLEM" S X="Problem List: "_$P(IBX,"^") Q
 ...;
 ...I M="HEALTH FACTORS" S X="Health Factor: "_$$DSPLYHF^PXAPIIB(+IBX) N Y S Y=$P(IBX,"^",2) I Y'="" S X=X_" Level/Severity: "_$S(Y="M":"Minimal",Y="MO":"Moderate",Y="H":"Heavy/Severe",1:"") Q
 ...;
 ...I M="SKIN TEST" S X="Skin Tests: "_$$DSPLYSK^PXAPIIB(+IBX) Q
 ...;
 ...I M="PATIENT ED" S X="Patient Eduction: "_$$DSPLYED^PXAPIIB(+IBX) I $P(IBX,"^",2) S X=X_" , Level of Understanding: "_$S(IBX=1:"Poor",IBX=2:"Fair",IBX=3:"Good",IBX=4:"N/A",IBX=5:"Refused",1:"") Q
 ...;
 ...I M="DIAGNOSIS/PROBLEM" D  S:X="" X="Diagnosis/Problem: unspecified"
 ....N Y S X=""
 ....S Y=$P(IBX,"^",2) S X=$S(Y="P":"Primary ",Y="S":"Secondary ",1:"")_"Diagnosis/Problem"
 ....;I $P(IBX,"^",4) S X=X_$S($P(IBX,"^",6)="I":", Inactive",1:", Active")
 ....I $P(IBX,"^",13)'="" S X=X_" '"_$P(IBX,"^",14)_$S($P(IBX,"^",14)'="":" ",1:"")_$P(IBX,"^",13)_"'"
 ....;I +$P(IBX,"^",3) S X=X_", Clinical Lexicon term: "_$P($G(^GMP(757.01,+$P(IBX,"^",3),0)),"^") ;clinical lexicon term passed
 ....I +$P(IBX,"^",3) S X=X_", Clinical Lexicon term: " D
 .....I $D(^LEX) S X=X_$P($G(^LEX(757.01,+$P(IBX,"^",3),0)),"^") Q
 .....S X=X_$P($G(^GMP(757.01,+$P(IBX,"^",3),0)),"^")
 ....I $P(IBX,"^",5) S X=X_", Added to Problem List "
 ....I +$P(IBX,"^",4) S X=X_", Patient Active Problem: "_$$PROBNAR($P(IBX,"^",4)) ;problem entry passed
 ....I +IBX S IBY=$P($G(^ICD9(+IBX,0)),"^") I IBX'[IBY S X=X_", ICD9: "_IBY
 ....I $P(IBX,"^",9) S X=X_" SC Condition "
 ....I $P(IBX,"^",10) S X=X_" AO Condition "
 ....I $P(IBX,"^",11) S X=X_" IR Condition "
 ....I $P(IBX,"^",12) S X=X_" EC Condition "
 ...I M="LOCAL" S X="Local Data Received: "_IBX Q
 ..I M="PROCEDURE",$D(PXCA(M,I,J)) D MODLIST
LSTQ Q
 ;
MODLIST ; -- expand the modifiers filed
 N IBM,X S IBM=0
 S X="    Modifier(s): " D NEWLINE(.RESULT,X,.LCNT)
 F  S IBM=$O(PXCA(M,I,J,IBM)) Q:IBM']""  D
 . S X="         "_IBM_"-"_$P(PXCA(M,I,J,IBM),"^",3)
 . D NEWLINE(.RESULT,X,.LCNT)
 Q
PROV ; -- expand the additional provider node
 S IBX=$G(PXCA(M,I))
 S X=$S($E(IBX,1)="P":"Primary ",$E(IBX,1)="S":"Secondary ",1:"")_"Provider: "_$P($G(^VA(200,I,0)),"^")_$S($P(IBX,"^",2)=1:" Attending",1:"")
 D NEWLINE(.RESULT,X,.LCNT)
 Q
 ;
NEWLINE(RESULT,X,LCNT) ;
 ; -- increment count and add new line to results array.
 S LCNT=LCNT+1
 S RESULT(LCNT)=X
 Q
 ;
VTYPE(X) ;
 ; -- Vital sign type from codes
 S X=$G(X)
 Q $S(X="BP":"Blood Pressure",X="HT":"Height",X="WT":"Weight",X="TMP":"Temperature",X="PU":"Pulse",1:"Other Vital")
 ;
PROBNAR(IEN) ; -- display problem narrative
 ;
 Q $P($G(^AUTNPOV(+$P($G(^AUPNPROB(+$G(IEN),0)),"^",5),0)),"^")
 ;
PROBDIA(IEN) ; -- return problem diagnosis code pointer
 Q +$P($G(^AUPNPROB(+$G(IEN),0)),"^")
