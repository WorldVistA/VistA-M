ORQ21 ; SLC/MKB/GSS - Detailed Order Report cont ; 12/28/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,190,195,215,243**;Dec 17, 1997;Build 242
 ;
 ; DBIA 2400   OEL^PSOORRL   ^TMP("PS",$J)
 ; DBIA 2266   EN30^RAO7PC1  ^TMP($J,"RAE2")
 ; 
RAD(TCOM) ; -- add RA data for 2.5 orders
 N RAIFN,CASE,PROC,ORD,ORI,X,ORTTL,ORB
 S RAIFN=$G(^OR(100,ORIFN,4)) Q:RAIFN'>0
 D EN30^RAO7PC1(RAIFN) Q:'$D(^TMP($J,"RAE2",+ORVP))  ;DBIA 2266
 S ORD=$G(^TMP($J,"RAE2",+ORVP,"ORD")),CASE=$O(^(0)) Q:'CASE  S PROC=$O(^(CASE,""))
 I '$G(TCOM) D  ;else add only Tech Comments
 . S CNT=CNT+1,@ORY@(CNT)=$$LJ^XLFSTR("Procedure:",30)_$S($L(ORD):ORD,1:PROC)
 . S ORI=0,ORTTL="Procedure Modifiers:          ",ORB=1
 . F  S ORI=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"M",ORI)) Q:ORI'>0  S CNT=CNT+1,@ORY@(CNT)=ORTTL_^(ORI),ORTTL=$$REPEAT^XLFSTR(" ",30)
 . S CNT=CNT+1,@ORY@(CNT)="History and Reason for Exam:"
 . F  S ORI=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"H",ORI)) Q:ORI'>0  S CNT=CNT+1,@ORY@(CNT)="  "_^(ORI)
RAD1 I $L($G(^TMP($J,"RAE2",+ORVP,CASE,PROC,"TCOM",1))) S X=^(1) D
 . N DIWL,DIWR,DIWF,I K ^UTILITY($J,"W")
 . S DIWL=1,DIWR=72,DIWF="C72" D ^DIWP
 . S CNT=CNT+1,@ORY@(CNT)="Technologist's Comment:",ORB=1
 . S I=0 F  S I=$O(^UTILITY($J,"W",DIWL,I)) Q:I'>0  S CNT=CNT+1,@ORY@(CNT)="  "_^(I,0)
 I $D(^TMP($J,"RAE2",+ORVP,CASE,PROC,"CM")) D
 . S ORTTL="Contrast Media used:          ",ORI=0,ORB=1
 . F  S ORI=$O(^TMP($J,"RAE2",+ORVP,CASE,PROC,"CM",ORI)) Q:ORI<1  S CNT=CNT+1,@ORY@(CNT)=ORTTL_$P(^(ORI),U,2),ORTTL=$$REPEAT^XLFSTR(" ",30)
 K ^TMP($J,"RAE2",+ORVP),^UTILITY($J,"W")
 S:$G(ORB) CNT=CNT+1,@ORY@(CNT)="   " ;blank
 Q
 ;
MED ; -- Add Pharmacy order data
 Q:$G(^OR(100,ORIFN,4))["N"  ;non-VA med -- no refill history
 N TYPE,NODE,RXN,OR5,STAT S TYPE=$P(OR0,U,12)
 I '$D(^TMP("PS",$J,0)) D  ;get PS data / DBIA 2400
 . N PSIFN S PSIFN=$G(^OR(100,ORIFN,4))
 . S:TYPE="O" PSIFN=$TR(PSIFN,"S","P")_$S(PSIFN?1.N:"R",1:"")
 . D OEL^PSOORRL(+ORVP,PSIFN_";"_TYPE)  ;DBIA 2400
 S NODE=$G(^TMP("PS",$J,0)),RXN=$G(^("RXN",0)),STAT=$P(NODE,U,6)
 I '$L(NODE) K ^TMP("PS",$J) Q  ;error
 I $O(^TMP("PS",$J,"DD",0)) D  ;Disp Drugs
 . N I,X,Y S X="Dispense Drugs (units/dose):  ",I=0
 . F  S I=$O(^TMP("PS",$J,"DD",I)) Q:I'>0  S Y=$G(^(I,0)) S:Y CNT=CNT+1,@ORY@(CNT)=X_$$GET1^DIQ(50,+Y_",",.01)_" ("_$P(Y,U,2)_")"
 S:$P(NODE,U,9) CNT=CNT+1,@ORY@(CNT)="Total Dose:                   "_$P(NODE,U,9)
M1 I TYPE="I" D  ;admin data
 . N I,X,Y I $O(^TMP("PS",$J,"B",0)) D
 .. S X="IV Print Name:                ",I=0
 .. F  S I=$O(^TMP("PS",$J,"B",I)) Q:I<1  S Y=$G(^(I,0)) S:$L(Y) CNT=CNT+1,@ORY@(CNT)=X_$P(Y,U),X=$$REPEAT^XLFSTR(" ",30) I $L($P(Y,U,3)) S CNT=CNT+1,@ORY@(CNT)=X_" "_$P(Y,U,3)
 . S I=+$O(^TMP("PS",$J,"SCH",0)),X=$P($G(^(I,0)),U,2)
 . S:$L(X) CNT=CNT+1,@ORY@(CNT)="Schedule Type:                "_X
 . S X="Administration Times:         ",I=0
 . F  S I=$O(^TMP("PS",$J,"ADM",I)) Q:I'>0  S Y=$G(^(I,0)) S:$L(Y) CNT=CNT+1,@ORY@(CNT)=X_Y,X=$$REPEAT^XLFSTR(" ",30)
M2 I TYPE="O" D  ;fill history
 . N FILLD,RET,X,Y,I
 . S:$P(NODE,U,12) CNT=CNT+1,@ORY@(CNT)="Last Filled:                  "_$$FMTE^XLFDT($P(NODE,U,12),2)
 . S CNT=CNT+1,@ORY@(CNT)="Refills Remaining:            "_$P(NODE,U,4)
 . I $P(RXN,U,6)!$G(^TMP("PS",$J,"REF",0)) S X="Filled:                       " D
 .. I $P(RXN,U,6) S FILLD=$P(RXN,U,6)_"^^^"_$P(RXN,U,7)_U_$P(RXN,U,3,4) D FILLED("R")
 .. S RET=$G(^TMP("PS",$J,"RXN","RSTC")) I RET'="" D RETURNS(RET)
 .. S I=0 F  S I=$O(^TMP("PS",$J,"REF",I)) Q:I'>0  D
 ... S FILLD=$G(^(I,0)) D FILLED("R")
 ... S RET=$G(^TMP("PS",$J,"REF",I,"RSTC")) I RET'="" D RETURNS(RET)
 . I $G(^TMP("PS",$J,"PAR",0)) S I=0,X="Partial Fills:      " F  S I=$O(^TMP("PS",$J,"PAR",I)) Q:I'>0  S FILLD=$G(^(I,0)) D FILLED("P")
 . S:RXN CNT=CNT+1,@ORY@(CNT)="Prescription#:                "_$P(RXN,U)
M3 S:$P(RXN,U,5) CNT=CNT+1,@ORY@(CNT)="Pharmacist:                   "_$P($G(^VA(200,+$P(RXN,U,5),0)),U)
    I $G(STAT)="ACTIVE/SUSP" S CNT=CNT+1,@ORY@(CNT)="Prescription Status:          "_STAT_" - Order is active. Fill or Refill has been requested."
 S:$P(NODE,U,13) CNT=CNT+1,@ORY@(CNT)="NOT TO BE GIVEN" K ^TMP("PS",$J)
 S CNT=CNT+1,@ORY@(CNT)="   " ;blank
 S OR5=$G(^OR(100,ORIFN,5)) I $L(OR5) D  ;SC data
 . N X,Y,I
 . S CNT=CNT+1,@ORY@(CNT)="   " ;blank line
 . S CNT=CNT+1,@ORY@(CNT)="First Party Pay Exemptions"
 . S X="For conditions related to:    "
 . F I=1:1:8 S Y=$P(OR5,U,I) I Y S CNT=CNT+1,@ORY@(CNT)=X_$$SC(I),X=$$REPEAT^XLFSTR(" ",30)
 Q
 ;
BA ;Billing Aware data display
 N DXIEN,DXV,ICD9,ICDR,OCT,ORFMDAT
 S OCT=0,X=""
 ; Get the date of the order for CSV/CTD usage
 S ORFMDAT=$$ORFMDAT^ORWDBA3(ORIFN)
 ; $O through diagnoses for an order
 F  S OCT=$O(^OR(100,ORIFN,5.1,OCT)) Q:OCT'?1N.N  D
 . ; DXIEN=Dx IEN
 . S DXIEN=+^OR(100,ORIFN,5.1,OCT,0)
 . ; Get Dx record for date ORFMDAT
 . S ICDR=$$ICDDX^ICDCODE(DXIEN,ORFMDAT)
 . ; Get Dx verbiage and ICD code
 . S DXV=$P(ICDR,U,4),ICD9=$P(ICDR,U,2)
 . S X="               "
 . I OCT=1 D
 .. S CNT=CNT+1,@ORY@(CNT)="   " ;blank line
 .. S CNT=CNT+1,@ORY@(CNT)="Clinical Indicators"
 .. S X="Diagnosis of:  "
 . S X=X_ICD9_" - "_DXV,CNT=CNT+1,@ORY@(CNT)=X
 I OCT'="" D  ;if there are diagnoses show Treatment Factors
 . S X="For conditions related to:    "
 . F I=1:1:8 S Y=$P(^OR(100,ORIFN,5.2),U,I) I Y D
 .. S CNT=CNT+1,@ORY@(CNT)=X_$$SC(I),X=$$REPEAT^XLFSTR(" ",30)
 Q
 ;
FILLED(TYPE) ; -- add FILLD data
 N Y S Y=$$FMTE^XLFDT($P(FILLD,U),2)_" ("_$$ROUTING($P(FILLD,U,5))_")"
 S:TYPE="R"&$P(FILLD,U,4) Y=Y_" released "_$$FMTE^XLFDT($P(FILLD,U,4),2)
 S:TYPE="P"&$P(FILLD,U,3) Y=Y_" Qty: "_$P(FILLD,U,3)
 S CNT=CNT+1,@ORY@(CNT)=X_Y,X=$$REPEAT^XLFSTR(" ",30)
 S:$L($P(FILLD,U,6)) CNT=CNT+1,@ORY@(CNT)=X_$P(FILLD,U,6)
 Q
RETURNS(NODE) ; add Return to Stock Data
 N DATE,NAME,TEXT,X
 S DATE=$$FMTE^XLFDT($P(NODE,U))
 S NAME=$P(^VA(200,$P(NODE,U,2),0),U)
 S X=$$REPEAT^XLFSTR(" ",13)
 S TEXT="Return to Stock: "_X_DATE_" by "_NAME
 S CNT=CNT+1,@ORY@(CNT)=TEXT
 S X=$$REPEAT^XLFSTR(" ",30)
 S TEXT=X_"Comments: "_$P(NODE,U,3)
 S CNT=CNT+1,@ORY@(CNT)=TEXT
 Q
 ;
ROUTING(X) ; -- Returns external form
 N Y S Y=$S($G(X)="M":"Mail",$G(X)="W":"Window",1:$G(X))
 Q Y
 ;
SC(J) ; -- Returns name of SC field by piece number
 I '$G(J) Q ""
 I J=1 Q "SERVICE CONNECTED CONDITION"
 I J=2 Q "MILITARY SEXUAL TRAUMA"
 I J=3 Q "AGENT ORANGE EXPOSURE"
 I J=4 Q "IONIZING RADIATION EXPOSURE"
 I J=5 Q "ENVIRONMENTAL CONTAMINANTS"
 I J=6 Q "HEAD OR NECK CANCER"
 I J=7 Q "COMBAT VETERAN"
 I J=8 Q "SHIPBOARD HAZARD AND DEFENSE"
 Q ""
