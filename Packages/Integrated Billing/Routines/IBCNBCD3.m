IBCNBCD3 ;ALB/AWC - MCCF FY14 IB Annual Benefits/Coverage Limitations Display Screens ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Input Parameters:
 ;  See routine IBCNBCD1
 ;
ABDISP(IBIEN,IBDATA,IBPOL) ; Annual Benefits Display screen - Called from ABDSEL^IBCNBCD1 and ABDLC^IBCNBCD1
 N Y,IBI,IBW,IBEX,IBN
 ;
 W @IOF
 ;
 ; -- header annual benefits
 D WRTFLD^IBCNBCD("                           Annual Benefits Data                                 ",0,80,"BU") W !
 ;
 S IBN=IBIEN_","
 S IBEX=0
 F IBI=1:1:59 Q:IBEX  D
 . ;
 . I $Y+5>IOSL D PAUSE^VALM1 W @IOF I 'Y S IBEX=1 Q
 . ;
 . I IBI=1 S IBW=$G(@IBDATA@(355.4,IBN,.01,"E")) D WRTFLD^IBCNBCD("  Benefit Year            :  "_IBW,0,80,"") W ! Q
 . I IBI=2 S IBW=$G(IBPOL) D WRTFLD^IBCNBCD("  Policy Information      :  "_IBW,0,80,"") W ! Q
 . I IBI=3 S IBW=$G(@IBDATA@(355.4,IBN,.05,"E")) D WRTFLD^IBCNBCD("  Max Out of Pocket       :  "_IBW,0,80,"") W ! Q
 . I IBI=4 S IBW=$G(@IBDATA@(355.4,IBN,.06,"E")) D WRTFLD^IBCNBCD("  Ambulance Coverage(%)   :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- inpatient
 . I IBI=5 D WRTFLD^IBCNBCD("Inpatient:",0,10,"") W ! Q
 . I IBI=6 S IBW=$G(@IBDATA@(355.4,IBN,5.01,"E")) D WRTFLD^IBCNBCD("  Annual Deduct           :  "_IBW,0,80,"") W ! Q
 . I IBI=7 S IBW=$G(@IBDATA@(355.4,IBN,5.02,"E")) D WRTFLD^IBCNBCD("  Per Admis Deduct        :  "_IBW,0,80,"") W ! Q
 . I IBI=8 S IBW=$G(@IBDATA@(355.4,IBN,5.03,"E")) D WRTFLD^IBCNBCD("  Inpt. Lifetime Max      :  "_IBW,0,80,"") W ! Q
 . I IBI=9 S IBW=$G(@IBDATA@(355.4,IBN,5.04,"E")) D WRTFLD^IBCNBCD("  Inpt. Annual Max        :  "_IBW,0,80,"") W ! Q
 . I IBI=10 S IBW=$G(@IBDATA@(355.4,IBN,5.09,"E")) D WRTFLD^IBCNBCD("  Room & Board (%)        :  "_IBW,0,80,"") W ! Q
 . I IBI=11 S IBW=$G(@IBDATA@(355.4,IBN,5.07,"E")) D WRTFLD^IBCNBCD("  Drug/Alcohol Lifet. Max :  "_IBW,0,80,"") W ! Q
 . I IBI=12 S IBW=$G(@IBDATA@(355.4,IBN,5.08,"E")) D WRTFLD^IBCNBCD("  Drug/Alcohol Annual Max :  "_IBW,0,80,"") W ! Q
 . I IBI=13 S IBW=$G(@IBDATA@(355.4,IBN,5.1,"E")) D WRTFLD^IBCNBCD("  Nursing Home (%)        :  "_IBW,0,80,"") W ! Q
 . I IBI=14 S IBW=$G(@IBDATA@(355.4,IBN,5.12,"E")) D WRTFLD^IBCNBCD("  Other Inpt. Charges (%) :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- outpatient
 . I IBI=15 D WRTFLD^IBCNBCD("Outpatient:",0,11,"") W ! Q
 . I IBI=16 S IBW=$G(@IBDATA@(355.4,IBN,2.01,"E")) D WRTFLD^IBCNBCD("  Annual Deductible       :  "_IBW,0,80,"") W ! Q
 . I IBI=17 S IBW=$G(@IBDATA@(355.4,IBN,2.02,"E")) D WRTFLD^IBCNBCD("  Per Visit Deductible    :  "_IBW,0,80,"") W ! Q
 . I IBI=18 S IBW=$G(@IBDATA@(355.4,IBN,2.03,"E")) D WRTFLD^IBCNBCD("  Lifetime Max            :  "_IBW,0,80,"") W ! Q
 . I IBI=19 S IBW=$G(@IBDATA@(355.4,IBN,2.04,"E")) D WRTFLD^IBCNBCD("  Annual Max              :  "_IBW,0,80,"") W ! Q
 . I IBI=20 S IBW=$G(@IBDATA@(355.4,IBN,2.09,"E")) D WRTFLD^IBCNBCD("  Visit (%)               :  "_IBW,0,80,"") W ! Q
 . I IBI=21 S IBW=$G(@IBDATA@(355.4,IBN,2.15,"E")) D WRTFLD^IBCNBCD("  Max Visits Per Year     :  "_IBW,0,80,"") W ! Q
 . I IBI=22 S IBW=$G(@IBDATA@(355.4,IBN,2.13,"E")) D WRTFLD^IBCNBCD("  Surgery (%)             :  "_IBW,0,80,"") W ! Q
 . I IBI=23 S IBW=$G(@IBDATA@(355.4,IBN,2.1,"E")) D WRTFLD^IBCNBCD("  Emergency (%)           :  "_IBW,0,80,"") W ! Q
 . I IBI=24 S IBW=$G(@IBDATA@(355.4,IBN,2.12,"E")) D WRTFLD^IBCNBCD("  Prescription (%)        :  "_IBW,0,80,"") W ! Q
 . I IBI=25 S IBW=$G(@IBDATA@(355.4,IBN,2.17,"E")) D WRTFLD^IBCNBCD("  Adult Day Health Care?  :  "_IBW,0,80,"") W ! Q
 . I IBI=26 S IBW=$G(@IBDATA@(355.4,IBN,2.07,"E")) D WRTFLD^IBCNBCD("  Dental Coverage Type    :  "_IBW,0,80,"") W ! Q
 . I IBI=27 D
 . . I $G(IBW)="PER VISIT AMOUNT" D  Q
 . . . S IBW=$G(@IBDATA@(355.4,IBN,2.08,"E")) D WRTFLD^IBCNBCD("  Dental Coverage ($)     :  "_IBW,0,80,"") W !,! Q
 . . ;
 . . I $G(IBW)="PERCENTAGE AMOUNT" D  Q
 . . . S IBW=$G(@IBDATA@(355.4,IBN,2.08,"E")) D WRTFLD^IBCNBCD("  Dental Coverage (%)     :  "_IBW,0,80,"") W !,! Q
 . . ;
 . . I $G(IBW)="NONE" D
 . . . S IBW=$G(@IBDATA@(355.4,IBN,2.08,"E")) D WRTFLD^IBCNBCD("  Dental Coverage         :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- mental health inpatient
 . I IBI=28 D WRTFLD^IBCNBCD("Mental Health Inpatient:",0,25,"") W ! Q
 . I IBI=29 S IBW=$G(@IBDATA@(355.4,IBN,5.14,"E")) D WRTFLD^IBCNBCD("  MH Inpt. Max Days/Year  :  "_IBW,0,80,"") W ! Q
 . I IBI=30 S IBW=$G(@IBDATA@(355.4,IBN,5.05,"E")) D WRTFLD^IBCNBCD("  MH Lifetime Inpt. Max   :  "_IBW,0,80,"") W ! Q
 . I IBI=31 S IBW=$G(@IBDATA@(355.4,IBN,5.06,"E")) D WRTFLD^IBCNBCD("  MH Annl Inpt Max        :  "_IBW,0,80,"") W ! Q
 . I IBI=32 S IBW=$G(@IBDATA@(355.4,IBN,5.11,"E")) D WRTFLD^IBCNBCD("  Mental Health Inpt. (%) :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- mental health outpatient
 . I IBI=33 D WRTFLD^IBCNBCD("Mental Health Outpatient:",0,25,"") W ! Q
 . I IBI=34 S IBW=$G(@IBDATA@(355.4,IBN,2.14,"E")) D WRTFLD^IBCNBCD("  MH Opt. Max Days/Year   :  "_IBW,0,80,"") W ! Q
 . I IBI=35 S IBW=$G(@IBDATA@(355.4,IBN,2.05,"E")) D WRTFLD^IBCNBCD("  MH Lifetime Opt. Max    :  "_IBW,0,80,"") W ! Q
 . I IBI=36 S IBW=$G(@IBDATA@(355.4,IBN,2.06,"E")) D WRTFLD^IBCNBCD("  MH Annual Opt. Max      :  "_IBW,0,80,"") W ! Q
 . I IBI=37 S IBW=$G(@IBDATA@(355.4,IBN,2.11,"E")) D WRTFLD^IBCNBCD("  Mental Health Opt. (%)  :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- home health care
 . I IBI=38 D WRTFLD^IBCNBCD("Home Health Care:",0,17,"") W ! Q
 . I IBI=39 S IBW=$G(@IBDATA@(355.4,IBN,3.01,"E")) D WRTFLD^IBCNBCD("  Care Level              :  "_IBW,0,80,"") W ! Q
 . I IBI=40 S IBW=$G(@IBDATA@(355.4,IBN,3.02,"E")) D WRTFLD^IBCNBCD("  Visits Per Year         :  "_IBW,0,80,"") W ! Q
 . I IBI=41 S IBW=$G(@IBDATA@(355.4,IBN,3.03,"E")) D WRTFLD^IBCNBCD("  Max. Days Per Year      :  "_IBW,0,80,"") W ! Q
 . I IBI=42 S IBW=$G(@IBDATA@(355.4,IBN,3.04,"E")) D WRTFLD^IBCNBCD("  Med. Equipment (%)      :  "_IBW,0,80,"") W ! Q
 . I IBI=43 S IBW=$G(@IBDATA@(355.4,IBN,3.05,"E")) D WRTFLD^IBCNBCD("  Visit Definition        :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- hospice
 . I IBI=44 D WRTFLD^IBCNBCD("Hospice:",0,8,"") W ! Q
 . I IBI=45 S IBW=$G(@IBDATA@(355.4,IBN,4.01,"E")) D WRTFLD^IBCNBCD("  Annual Deductible       :  "_IBW,0,80,"") W ! Q
 . I IBI=46 S IBW=$G(@IBDATA@(355.4,IBN,4.02,"E")) D WRTFLD^IBCNBCD("  Inpatient Annual Max.   :  "_IBW,0,80,"") W ! Q
 . I IBI=47 S IBW=$G(@IBDATA@(355.4,IBN,4.03,"E")) D WRTFLD^IBCNBCD("  Inpatient Lifetime Max. :  "_IBW,0,80,"") W ! Q
 . I IBI=48 S IBW=$G(@IBDATA@(355.4,IBN,4.04,"E")) D WRTFLD^IBCNBCD("  Room and Board (%)      :  "_IBW,0,80,"") W ! Q
 . I IBI=49 S IBW=$G(@IBDATA@(355.4,IBN,4.05,"E")) D WRTFLD^IBCNBCD("  Other Inpt. Charges (%) :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- rehabilitation
 . I IBI=50 D WRTFLD^IBCNBCD("Rehabilitation:",0,15,"") W ! Q
 . I IBI=51 S IBW=$G(@IBDATA@(355.4,IBN,3.06,"E")) D WRTFLD^IBCNBCD("  Occu. Therapy # Visits  :  "_IBW,0,80,"") W ! Q
 . I IBI=52 S IBW=$G(@IBDATA@(355.4,IBN,3.07,"E")) D WRTFLD^IBCNBCD("  Phys. Therapy # Visits  :  "_IBW,0,80,"") W ! Q
 . I IBI=53 S IBW=$G(@IBDATA@(355.4,IBN,3.08,"E")) D WRTFLD^IBCNBCD("  Spch. Therapy # Visits  :  "_IBW,0,80,"") W ! Q
 . I IBI=54 S IBW=$G(@IBDATA@(355.4,IBN,3.09,"E")) D WRTFLD^IBCNBCD("  Med Cnslg. # Visits     :  "_IBW,0,80,"") W !,! Q
 . ;
 . ; -- iv management
 . I IBI=55 D WRTFLD^IBCNBCD("IV Management:",0,14,"") W ! Q
 . I IBI=56 S IBW=$G(@IBDATA@(355.4,IBN,4.06,"E")) D WRTFLD^IBCNBCD("  IV Infusion Opt?        :  "_IBW,0,80,"") W ! Q
 . I IBI=57 S IBW=$G(@IBDATA@(355.4,IBN,4.07,"E")) D WRTFLD^IBCNBCD("  IV Infusion Inpt?       :  "_IBW,0,80,"") W ! Q
 . I IBI=58 S IBW=$G(@IBDATA@(355.4,IBN,4.08,"E")) D WRTFLD^IBCNBCD("  IV Antibiotics Opt?     :  "_IBW,0,80,"") W ! Q
 . I IBI=59 S IBW=$G(@IBDATA@(355.4,IBN,4.09,"E")) D WRTFLD^IBCNBCD("  IV Antibiotics Inpt?    :  "_IBW,0,80,"") W !
 Q IBEX
 ;
CVDISP(IBDATA,IBPLAN) ; Display Insurance Group Coverage Limitations - Called from CVDSEL^IBCNBCD2 and CVDCRE^IBCNBCD2
 N IBI,IBJ,IBEX,IBSP,IBH,IBOUT,DTOUT
 S IBH="D WRTFLD^IBCNBCD(""                         Coverage Limitations Data                              "",0,80,""BU"") W !"
 S IBSP="                         "
 ;
 ; -- header
 W @IOF
 X IBH
 ;
 S IBEX=0
 F IBI=1:1:60 Q:IBEX  D
 . ;
 . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . ;
 . ; -- inpatient
 . I IBI=1 W ! Q
 . I IBI=2 D WRTFLD^IBCNBCD("INPATIENT:",0,10,"") Q
 . I IBI=3 W ! Q
 . I IBI=4 D WRTFLD^IBCNBCD("  Inpatient Coverage          :  "_$G(@IBDATA@("INPATIENT",.04,"E")),0,80,"") Q
 . I IBI=5 W ! Q
 . I IBI=6 D WRTFLD^IBCNBCD("  Inpatient Date of Coverage  :  "_$G(@IBDATA@("INPATIENT",.03,"E")),0,80,"") Q
 . I IBI=7 S IBJ=$O(@IBDATA@("INPATIENT","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=8 D WRTFLD^IBCNBCD("  Inpatient Limit Comments    :  "_$G(@IBDATA@("INPATIENT","COMM",IBJ)),0,80,"") Q
 . I IBI=9 W ! Q
 . I IBI=10,$O(@IBDATA@("INPATIENT","COMM",IBJ)) D  Q
 . . F IBJ=IBJ:0 S IBJ=$O(@IBDATA@("INPATIENT","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("INPATIENT","COMM",IBJ),0,80,"") W !
 . ;
 . ; -- outpatient
 . I IBI=11 W ! Q
 . I IBI=12 D WRTFLD^IBCNBCD("OUTPATIENT:",0,11,"") Q
 . I IBI=13 W ! Q
 . I IBI=14 D WRTFLD^IBCNBCD("  Outpatient Coverage         :  "_$G(@IBDATA@("OUTPATIENT",.04,"E")),0,80,"") Q
 . I IBI=15 W ! Q
 . I IBI=16 D WRTFLD^IBCNBCD("  Outpatient Date of Coverage :  "_$G(@IBDATA@("OUTPATIENT",.03,"E")),0,80,"") Q
 . I IBI=17 S IBJ=$O(@IBDATA@("OUTPATIENT","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=18 D WRTFLD^IBCNBCD("  Outpatient Limit Comments   :  "_$G(@IBDATA@("OUTPATIENT","COMM",IBJ)),0,80,"") Q
 . I IBI=19 W ! Q
 . I IBI=20,$O(@IBDATA@("OUTPATIENT","COMM",IBJ)) D  Q
 . . F IBJ=IBJ:0 S IBJ=$O(@IBDATA@("OUTPATIENT","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("OUTPATIENT","COMM",IBJ),0,80,"") W !
 . ;
 . ; -- pharmacy
 . I IBI=21 W ! Q
 . I IBI=22 D WRTFLD^IBCNBCD("PHARMACY:",0,11,"") Q
 . I IBI=23 W ! Q
 . I IBI=24 D WRTFLD^IBCNBCD("  Pharmacy Coverage           :  "_$G(@IBDATA@("PHARMACY",.04,"E")),0,80,"") Q
 . I IBI=25 W ! Q
 . I IBI=26 D WRTFLD^IBCNBCD("  Pharmacy Date of Coverage   :  "_$G(@IBDATA@("PHARMACY",.03,"E")),0,80,"") Q
 . I IBI=27 S IBJ=$O(@IBDATA@("PHARMACY","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=28 D WRTFLD^IBCNBCD("  Pharmacy Limit Comments     :  "_$G(@IBDATA@("PHARMACY","COMM",IBJ)),0,80,"") Q
 . I IBI=29 W ! Q
 . I IBI=30,$O(@IBDATA@("PHARMACY","COMM",IBJ)) D  Q
 . . F IBJ=IBJ:0 S IBJ=$O(@IBDATA@("PHARMACY","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("PHARMACY","COMM",IBJ),0,80,"") W !
 . ;
 . ; -- dental
 . I IBI=31 W ! Q
 . I IBI=32 D WRTFLD^IBCNBCD("DENTAL:",0,7,"") Q
 . I IBI=33 W ! Q
 . I IBI=34 D WRTFLD^IBCNBCD("  Dental Coverage             :  "_$G(@IBDATA@("DENTAL",.04,"E")),0,80,"") Q
 . I IBI=35 W ! Q
 . I IBI=36 D WRTFLD^IBCNBCD("  Dental Date of Coverage     :  "_$G(@IBDATA@("DENTAL",.03,"E")),0,80,"") Q
 . I IBI=37 S IBJ=$O(@IBDATA@("DENTAL","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=38 D WRTFLD^IBCNBCD("  Dental Limit Comments       :  "_$G(@IBDATA@("DENTAL","COMM",IBJ)),0,80,"") Q
 . I IBI=39 W ! Q
 . I IBI=40,$O(@IBDATA@("DENTAL","COMM",IBJ)) D   Q
 . . F IBJ=IBJ:0 S IBJ=$O(@IBDATA@("DENTAL","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("DENTAL","COMM",IBJ),0,80,"") W !
 . ;
 . ; -- mental health
 . I IBI=41 W ! Q
 . I IBI=42 D WRTFLD^IBCNBCD("MENTAL HEALTH:",0,14,"") Q
 . I IBI=43 W ! Q
 . I IBI=44 D WRTFLD^IBCNBCD("  MH Health Coverage          :  "_$G(@IBDATA@("MENTAL HEALTH",.04,"E")),0,80,"") Q
 . I IBI=45 W ! Q
 . I IBI=46 D WRTFLD^IBCNBCD("  MH Health Date of Coverage  :  "_$G(@IBDATA@("MENTAL HEALTH",.03,"E")),0,80,"") Q
 . I IBI=47 S IBJ=$O(@IBDATA@("MENTAL HEALTH","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=48 D WRTFLD^IBCNBCD("  MH Health Limit Comments    :  "_$G(@IBDATA@("MENTAL HEALTH","COMM",IBJ)),0,80,"") Q
 . I IBI=49 W ! Q
 . I IBI=50,$O(@IBDATA@("MENTAL HEALTH","COMM",IBJ)) D  Q
 . . F IBJ=IBJ:0 S IBJ=$O(@IBDATA@("MENTAL HEALTH","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("MENTAL HEALTH","COMM",IBJ),0,80,"") W !
 . ;
 . ; -- long term
 . I IBI=51 W ! Q
 . I IBI=52 D WRTFLD^IBCNBCD("LONG TERM CARE:",0,15,"") Q
 . I IBI=53 W ! Q
 . I IBI=54 D WRTFLD^IBCNBCD("  Long Term Coverage          :  "_$G(@IBDATA@("LONG TERM CARE",.04,"E")),0,80,"") Q
 . I IBI=55 W ! Q
 . I IBI=56 D WRTFLD^IBCNBCD("  Long Term Date of Coverage  :  "_$G(@IBDATA@("LONG TERM CARE",.03,"E")),0,80,"") Q
 . I IBI=57 S IBJ=$O(@IBDATA@("LONG TERM CARE","COMM",0)),IBJ=$S(+IBJ:IBJ,1:0) W ! Q
 . I IBI=58 D WRTFLD^IBCNBCD("  Long Term Limit Comments    :  "_$G(@IBDATA@("LONG TERM CARE","COMM",IBJ)),0,80,"") Q
 . I IBI=59 W ! Q
 . I IBI=60,$O(@IBDATA@("LONG TERM","COMM",IBJ)) D
 . . F IBJ=1=IBJ:0 S IBJ=$O(@IBDATA@("LONG TERM CARE","COMM",IBJ)) Q:IBJ'>0!(IBEX)  D
 . . . I $Y+4>IOSL D PAUSE^VALM1 S:'Y!($D(DTOUT)) IBEX=1 Q:IBEX  W @IOF X IBH
 . . . D WRTFLD^IBCNBCD(IBSP_@IBDATA@("LONG TERM CARE","COMM",IBJ),0,80,"") W !
 Q IBEX
