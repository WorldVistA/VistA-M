IBDF1B5 ;ALB/CJM - ENCOUNTER FORM - (prints reports defined by print manager); 5/15/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
PRNTOTHR(CLINIC,APPT,DFN) ;prints reports defined for CLINIC/DIVISION
 ; -- input CLINIC = ien file 44
 ; --       APPT = pts appointment date in fm format
 ; --       DFN = ptr to pt file
 Q:'CLINIC!('APPT)!('DFN)
 N DIVISION,RPT,IBDIV,IBCLIN
 S DIVISION=+$$DIVISION(CLINIC)
 ; -- build arrays of reports to print
 D DIV(DIVISION,.IBDIV),CLIN(CLINIC,.IBCLIN)
 ; -- go through clinic reports and print
 S RPT=0 F  S RPT=$O(IBCLIN(RPT)) Q:'RPT  I '$$EXCLUDE(CLINIC,RPT) D PRINT(RPT,$P(IBCLIN(RPT),"^",2))
 ; -- go through division reports
 S RPT=0 F  S RPT=$O(IBDIV(RPT)) Q:'RPT  I '$$EXCLUDE(CLINIC,RPT) D
 .N RULE,RNAR
 .Q:$D(IBCLIN(RPT))  ; already defined for clinic (clinic overrides div)
 .S RULE=+IBDIV(RPT),RNAR=$G(^IBE(357.92,+RULE,0)) ; set rule and narrative
 .I RNAR["MULTIPLE",'$$MULTIPLE^IBDF1B1A(DFN,$E(IBAPPT,1,7)) Q  ; if rule=print for multiple appts and pt does not have multiple appts that day, quit
 .I RNAR["EARLIEST",'$$EARLIEST(DFN,DIVISION,IBAPPT,RPT) Q  ;if rule=print for earliest appt that does not exclude, and this is not the earliest appt that includes the rpt, quit
 .D PRINT(RPT,$P(IBDIV(RPT),"^",2))
 Q
 ;
DIV(DIVISION,DIV) ; -- builds array of reports to print for division
 ; -- input DIVISION = ien from 40.8
 ; --       DIV = name of array to pass back
 ; -- output array in format DIV(ien of report)=""
 N TYPE,RTN,SETUP,RPT
 Q:'DIVISION
 F TYPE=0:0 S TYPE=$O(^SD(409.96,"A",DIVISION,TYPE)) Q:'TYPE  F RTN=0:0 S RTN=$O(^SD(409.96,"A",DIVISION,TYPE,RTN)) Q:'RTN  F SETUP=0:0 S SETUP=$O(^SD(409.96,"A",DIVISION,TYPE,RTN,SETUP)) Q:'SETUP  D
 .S RPT=0 F  S RPT=$O(^SD(409.96,"A",DIVISION,TYPE,RTN,SETUP,RPT)) Q:'RPT  S DIV(+$G(^SD(409.96,SETUP,1,RPT,0)))=$P($G(^SD(409.96,SETUP,1,RPT,0)),"^",2,3)
 Q
 ;
CLIN(CLINIC,CLIN) ; -- builds array of reports to print for clinic
 ; -- input CLINIC = ien from 44
 ; --       CLIN = name of array to pass back
 ; -- output array in format CLIN(ien of report)=""
 N TYPE,RTN,SETUP,RPT
 Q:'CLINIC
 F TYPE=0:0 S TYPE=$O(^SD(409.95,"A",CLINIC,TYPE)) Q:'TYPE  S RTN="" F  S RTN=$O(^SD(409.95,"A",CLINIC,TYPE,RTN)) Q:'RTN  F SETUP=0:0 S SETUP=$O(^SD(409.95,"A",CLINIC,TYPE,RTN,SETUP)) Q:'SETUP  D
 .S RPT=0 F  S RPT=$O(^SD(409.95,"A",CLINIC,TYPE,RTN,SETUP,RPT)) Q:'RPT  S CLIN(+$G(^SD(409.95,SETUP,1,RPT,0)))=$P($G(^SD(409.95,SETUP,1,RPT,0)),"^",2,3)
 Q
 ;
EXCLUDE(CLINIC,RPT) ;deterine if report is excluded for specified clinic
 ; -- input CLINIC = ien from file 44
 ; --       RPT = ien of report
 ; -- output 1 if report is excluded, 0 if not excluded
 I 'CLINIC!('RPT) Q 0
 ;print all the reports defined for the entire division,unless excluded for the clinic
 Q $S($D(^SD(409.95,"AE",CLINIC,RPT)):1,1:0)
 ;
EARLIEST(DFN,DIV,APPT,RPT) ;determine if appt is earliest appt that does
 ; -- not exclude the report
 ; -- input DFN = ien file 2
 ; --       DIV = ien 40.8
 ; --       APPT = appt we have printed EF for
 ; --       RPT = ien of report
 N PRN,APT
 Q:'DFN!('DIV)!('APPT)!('RPT)
 K ^TMP("IBDF",$J,"APPT LIST")
 D GETLIST^IBDF1B1A(DFN,$E(APPT,1,7),DIV)
 S APT=0 F  S APT=$O(^TMP("IBDF",$J,"APPT LIST",DIV,DFN,APT)) Q:'APT  S CLINIC=^(APT) D  Q:$D(PRN)
 .Q:$D(^SD(409.95,"AE",CLINIC,RPT))
 .I APT=APPT S PRN=1 Q
 .S PRN=0
 Q $S($D(PRN):PRN,1:1)
 ;
PRINT(PI,SIDES) ;fetches the package interface record,prints the report
 ; -- input PI = ien of report
 ; --       SIDES=0-simplex, 1-duplex long-edge, 2-duplex short-edge
 N IBRTN S IBRTN=PI N RTN,RPT
 D RTNDSCR^IBDFU1B(.IBRTN) ;get the interface description
 Q:IBRTN("ACTION")'=4  ;quit if the interface isn't the type that prints a report
 ;health summaries always use the same rtn to print
 I IBRTN("HSMRY?")=1 Q:'IBRTN("HSMRY")  S IBRTN("RTN")="PRNTSMRY^IBDFN5("_IBRTN("HSMRY")_")"
 N TYPE,DIVISION,CLINIC,QUIT,CLNCNAME,PNAME,PTYPE,TDIGIT
 ;go to duplex?
 D
 .I SIDES=1,IBDEVICE("DUPLEX_LONG")]"" W IBDEVICE("DUPLEX_LONG") Q
 .I SIDES=2,IBDEVICE("DUPLEX_SHORT")]"" W IBDEVICE("DUPLEX_SHORT") Q
 .I IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX") Q
 .I $Y W @IOF
 .I SIDES=0,IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX")
 N A S A=$$DORTN^IBDFU1B(.IBRTN)
 ;go back to simplex
 D
 .I SIDES=1,IBDEVICE("DUPLEX_LONG")]"",IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX") Q
 .I SIDES=2,IBDEVICE("DUPLEX_SHORT")]"",IBDEVICE("SIMPLEX")]"" W IBDEVICE("SIMPLEX") Q
 Q
DIVISION(CLINIC) ;returns the clinic's division - format is IEN^division's name
 N DIV,NAME
 Q:'$G(CLINIC) ""
 S DIV=+$P($G(^SC(CLINIC,0)),"^",15)
 I DIV S NAME=$P($G(^DG(40.8,DIV,0)),"^")
 I $L($G(NAME)) S DIV=DIV_"^"_NAME
 E  S DIV=""
 Q DIV
IFOTHR(CLINIC,TYPE) ; -- returns a 1 if there are reports defined for CLINIC for print condition=TYPE,0 if otherwise
 N RTN,DIVISION,COUNT
 S COUNT=0
 S TYPE=$O(^IBE(357.92,"B",TYPE,"")) Q:'TYPE 0 ;get ien of TYPE
 S DIVISION=+$$DIVISION(CLINIC)
 ;counts all the reports defined for the entire division
 I DIVISION S RTN="" F  S RTN=$O(^SD(409.96,"A",DIVISION,TYPE,RTN)) Q:'RTN  S:'$D(^SD(409.95,"AE",CLINIC,RTN)) COUNT=COUNT+1 Q:COUNT
 ;counts all the reports defined for the clinic
 S RTN="" F  S RTN=$O(^SD(409.95,"A",CLINIC,TYPE,RTN)) Q:'RTN  S COUNT=COUNT+1 Q:COUNT
 Q COUNT
