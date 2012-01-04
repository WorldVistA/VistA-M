ECXPRO2 ;ALB/GTS - Prosthetics Extract for DSS (Continued) ; 15 Apr 2011  1:49 PM
 ;;3.0;DSS EXTRACTS;**9,15,21,24,33,127,132**;Dec 22, 1997;Build 18
 ;
ECXBUL(ECXLNE,ECXEBDT,ECXEEDT,ECNUM) ;* Set up the header for the exception msg
 ;
 ;   Input
 ;    ECXLNE  - The line number variable (passed by reference)
 ;    ECXEBDT - The Externally formatted beginning date
 ;    ECXEEDT - The Externally formatted ending date
 ;    ECNUM   - The Extract reference number
 ;
 ;   Output
 ;    ^TMP("ECX-PRO EXC",$J) - Array for the exception message
 ;    ECXLNE                 - The number of the next line in the msg
 ;
 S ^TMP("ECX-PRO EXC",$J,1)=" "
 S ^TMP("ECX-PRO EXC",$J,2)="The DSS-Prosthetic Extract #"_ECNUM_" for "_ECXEBDT_" through "_ECXEEDT
 S ^TMP("ECX-PRO EXC",$J,3)="has completed.  The following is a list of Prosthetics records that were NOT"
 S ^TMP("ECX-PRO EXC",$J,4)="extracted due to missing information in the Record of Pros Appliance/Repair"
 S ^TMP("ECX-PRO EXC",$J,5)="file (#660).  The Prosthetics record may be reviewed and the missing"
 S ^TMP("ECX-PRO EXC",$J,6)="information completed.  Once the missing information has been entered, it"
 S ^TMP("ECX-PRO EXC",$J,7)="will be necessary to re-generate the Prosthetics Extract for the above noted"
 S ^TMP("ECX-PRO EXC",$J,8)="date range."
 S ^TMP("ECX-PRO EXC",$J,9)=" "
 S ^TMP("ECX-PRO EXC",$J,10)="If you do not intend to transmit Prosthetics Extract #"_ECNUM_", then please"
 S ^TMP("ECX-PRO EXC",$J,11)="purge it before generating a new extract for the same date range."
 S ^TMP("ECX-PRO EXC",$J,12)=" "
 S ^TMP("ECX-PRO EXC",$J,13)=" "
 S ^TMP("ECX-PRO EXC",$J,14)=" PROSTHETICS FILE (#660)         MISSING DATA"
 S ^TMP("ECX-PRO EXC",$J,15)="       IEN                         ELEMENTS"
 S ^TMP("ECX-PRO EXC",$J,16)=" "
 S ECXLNE=15
 Q
 ;
ECXMISLN(ECXMISS,ECXLNE,ECXPIEN) ;** Report Missing Lines
 N ECXPCE,ECXFIRST,ECXFIELD
 S ECXFIRST=1
 F ECXPCE=1:1:11 DO
 .I +$P(ECXMISS,"^",ECXPCE) DO
 ..S ECXFIELD=$P($T(ECXFLD+ECXPCE),";;",2)
 ..I 'ECXFIRST S ^TMP("ECX-PRO EXC",$J,ECXLNE)="                                   "_ECXFIELD
 ..I ECXFIRST DO
 ...S ^TMP("ECX-PRO EXC",$J,ECXLNE)="       "_ECXPIEN_"                          "_ECXFIELD
 ...S ECXFIRST=0
 ..S ECXLNE=ECXLNE+1
 S ^TMP("ECX-PRO EXC",$J,ECXLNE)=" "
 S ECXLNE=ECXLNE+1
 Q
 ;
ECXFLD ;* Missing Required fields
 ;;STATION
 ;;PATIENT NAME (Invalid)
 ;;SSN
 ;;NAME (In Patient file - #2)
 ;;DELIVERY DATE
 ;;TYPE OF TRANSACTION
 ;;SOURCE
 ;;HCPCS
 ;;REQUESTING STATION
 ;;FORM REQUESTED ON
 ;;RECEIVING STATION
 Q
 ;
FEEDINFO(ECXSRCE,ECXHCPCS,ECXTYPE,ECXSTAT2,ECXRQST,ECXRCST,ECXLAB,ECXNPPDC) ;Get Feeder Key and Feeder Location
 ;   Input
 ;    ECXSTAT2   - Station Number for extract
 ;    ECXTYPE   - Type of Transaction work performed
 ;    ECXSRCE   - Source of prosthesis
 ;    ECXHCPCS  - HCPCS code for prosthesis
 ;    ECXRQST   - Requesting Station
 ;    ECXRCST   - Receiving Station
 ;    ECXLAB    - Lab or non-Lab
 ;    ECXNPPDC  - NPPD Code
 ;   Output (to be KILLed by calling routine)
 ;    ECXFELOC  - Feeder Location
 ;    ECXFEKEY  - Feeder Key
 ;
 ;* NOTE: If a Station # <> Requesting Station
 ;*         AND
 ;*       Station # <> Receiving Station,
 ;*       then Feeder Location will be NULL.  
 ;
 S ECXFELOC=""
 S ECXFEKEY=ECXHCPCS_$S(ECXTYPE="X":"X",ECXTYPE=5:"R",1:"N")_ECXSRCE
 ;
 ;* If processing a Non-Lab Transaction
 I ECXLAB="NONL" S ECXFELOC=ECXSTAT2_$S(ECXNPPDC[800:"HO2",1:"NONL")
 ;
 ;* If processing a Lab Transaction
 I ECXLAB="LAB" D  Q
 .I ECXSTAT2=ECXRCST D
 ..S ECXFELOC=ECXRCST_"LAB"
 ..S ECXFEKEY=ECXFEKEY_ECXRQST_"REQ"
 I ECXLAB="ORD" D  Q
 .I ECXSTAT2=ECXRQST D
 ..S ECXFELOC=ECXRQST_"ORD"
 ..S ECXFEKEY=ECXFEKEY_ECXRCST_"REC"
 ;
 Q
