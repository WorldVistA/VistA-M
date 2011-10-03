IBDFRPC5 ;ALB/AAS - AICS Pass data to PCE, Broker Call ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,38**;APR 24, 1997
 ;
GETALL(RESULT,IBDATA) ; -- called by RPC and by write
 ; -- get all encounter data
 ; -- input  Result (called by reference)
 ;           IBDATA (called by reference)
 ;           IBDATA("CLINIC")   := pointer to hospital location file (44)
 ;           IBDATA("DFN")      := pointer to Patient file (2)
 ;           IBDATA("APPT")     := date/time of encounter in FM format
 ;           IBDATA("UNFORMAT") := (optional, default :=0) return piece
 ;                                  as displayable
 ; -- output Results Array
 ;           A sequential array of all data found for encounters for
 ;             patient/clinic/appt
 ;           if ibdata(unformat) is false then data is preformatted
 ;              suitable for display to a crt.
 ;           if ibdata(unformat) is true then a record as follows:
 ;              P1  :=  data qualifier (ie primary or secondary)
 ;              P2  :=  type of data
 ;              p3  :=  Narrative or Description (Textual name)
 ;              P4  :=  value (code or date/time)
 ;              P5  :=  source of data (aics, pce, scheduling)
 ;              P6  :=  Quantity (cpt codes only)
 ;                      The next 4 pieces only set if answered
 ;              P7  :=  sc (null, 1 or 0) encounter node only
 ;              P8  :=  ao (null, 1 or 0) encounter node only
 ;              P9  :=  ir (null, 1 or 0) encounter node only
 ;              P10 :=  ec (null, 1 or 0) encounter node only
 ;
 N CNT,IBDI,ENCTRS,L
 S CNT=0,ENCTRS=""
 D GETDATA(.RESULT,.IBDATA,.ENCTRS)
 S L="                             "
 I +RESULT(0) S RESULT(0)="The following data was found: " D FINDALL^IBDFRPC6(.RESULT)
 ;F IBDI="VST","PRV","POV","CPT","HF","PED","XAM","SK","IMM","TRT" D @(IBDI_"^IBDFRPC6")
GETALLQ Q
 ;
GETDATA(RESULT,IBDATA,ENCTRS) ; -- return all data for an encounter date time
 ;
 N IBDJ,IBDY
 K ^TMP("PXKENC",$J)
 I +IBDATA("CLINIC")'=IBDATA("CLINIC"),IBDATA("CLINIC")'="" S IBDATA("CLINIC")=$O(^SC("B",IBDATA("CLINIC"),0))
 S RESULT(0)="Nothing Processed, Perhaps an Error Occurred"
 I $G(IBDATA("DFN"))<1!($G(IBDATA("APPT"))<1)!($G(IBDATA("CLINIC"))<1) S RESULT(0)="Insufficient Data Passed to find encounter data" G GETQ
 ;
 ; -- first get visit iens
 S ENCTRS=$$GETENC^PXAPI(IBDATA("DFN"),IBDATA("APPT"),IBDATA("CLINIC"))
 I ENCTRS=-1 S RESULT(0)="No encounter Data on file." G GETQ
 I ENCTRS=-2 S RESULT(0)="Error in calling routine, file a NOIS" G GETQ
 ;
 ; -- then get all visit data
 S RESULT(0)="Attempting to Retieve Data"
 F IBDJ=1:1 S IBDY=$P(ENCTRS,"^",IBDJ) Q:IBDY=""  D ENCEVENT^PXAPI(IBDY,1)
 ;
 S RESULT(0)="1"
GETQ Q
 ;
WRITE ; -- called by DIR as executable help from IBDFDE
 N RESULT,IBQUIT,I,CNT
 W !,"Retrieving Encounter Data from PCE..."
 D GETALL(.RESULT,.IBDF)
 W !
 S I="",IBQUIT=0,CNT=0
 F  S I=$O(RESULT(I)) Q:I=""  S CNT=CNT+1 D:'(CNT#10) PAUSE^IBDFDE Q:IBQUIT  W !,RESULT(I)
 Q
 ;
APPTLST(RESULT,IBDF) ; -- return past appointment list, called by rpc
 N I,J,CNT,DFN,VASD,VAERR,VAROOT
 S RESULT(0)="No Past Appointments Found^^"
 K ^UTILITY("VASD",$J)
 ;
 S DFN=+$G(IBDF("DFN"))
 S VASD("F")=$S($G(IBDF("F"))>2840000:IBDF("F"),1:DT-10000)
 S VASD("T")=$S($G(IBDF("T"))>2840000:IBDF("T"),1:DT+.24)
 S VASD("W")=$S($G(IBDF("W"))'="":IBDF("W"),1:"129")
 ;
 D SDA^VADPT
 ;
 I $O(^UTILITY("VASD",$J,"")) S CNT=0
 S I="" F  S I=$O(^UTILITY("VASD",$J,I),-1) Q:I=""  S RESULT(CNT)=$G(^UTILITY("VASD",$J,I,"E"))_"^"_$G(^UTILITY("VASD",$J,I,"I")),CNT=CNT+1
 ;
 I VAERR=1 S RESULT(0)="Invalid Patient Identifier^^"
 K ^UTILITY("VASD",$J)
 Q
 ;
TEST ;
 K IBDF,ALAN
 S IBDF("DFN")=7169761
 S IBDF("CLINIC")=300
 S IBDF("APPT")=2970902.0849
 S IBDF("UNFORMAT")=1
 D GETALL(.ALAN,.IBDF)
 Q
TESTW ;
 K IBDF
 S IBDF("DFN")=7169761
 S IBDF("CLINIC")=300
 S IBDF("APPT")=2970902.0849
 D WRITE
 K IBDF
 Q
 ;
TESTA ;
 K ALAN,IBDF
 S IBDF("DFN")=7169761
 D APPTLST(.ALAN,.IBDF)
 Q
