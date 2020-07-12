OROTHCL ;SLC/SS/RM - OTHD CLOCK INTERFACE ;06/13/19  09:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 ;
 ;
 ;Functionality:
 ;This function is called from the "OROTHCL GET" RPC
 ;
 ;ICR:
 ; Supports the ICR# 6873
 ; between DG (custodial) and OR (subscriber) namespaces
 ;
 ;Input parameters:
 ; RET - reference type parameter to return data
 ; DFN - patient's IEN in the file (#2)
 ; ORDATE - the date to calculate status
 ;          default = DT (today)
 ;
 ;Return array:
 ;If RET(0)<0 : error code less than zero ^ error message - it is an error, and do not display anything
 ;If RET(0)=0 : then do not display anything
 ;
 ;RET(0) - number of lines to return
 ;    Example for OTH-90: RET(0)=5
 ;    Example for OTH-EXT: RET(0)=5
 ;
 ;RET(1)= Text for the 1st line on the button ^ Text to display when hover over the 1st line on the button
 ; Example for OTH-EXT: RET(1)="OTH-EXT^Other than Honorable, click for details"
 ; Example for OTH-90: RET(1)="OTH^Other than Honorable,click for details"
 ;
 ;RET(2)= Text for the 2nd line on the button^Text to display when hover over the 2nd line on the button
 ; Example for OTH-EXT: RET(2)=""
 ; Example for OTH-90: RET(2)="70D,P2^70 days left in period 2"
 ; Example for OTH-90: RET(2)="4D,P2^4 days left in period 2"
 ;
 ;RET(3)= Text for the 1st line of the button-click message ^ Text for the 1st line of the warning popup message
 ; Example for OTH-EXT: RET(3)="Other than Honorable"
 ; Example for OTH-90: RET(3)="70 days left in period 2"
 ; Example for OTH-90: RET(3)="4 days left in period 2^you have only 4 days left in the current period"
 ;
 ;RET(4)= Text for the 2nd line on the popup message^Text for the 2nd line of the warning popup message
 ; Example for OTH-EXT: RET(4)="Eligible for Mental Health care only"
 ; Example for OTH-90: RET(4)="Authorization is required for the further care"
 ; Example for OTH-90: RET(4)="Authorization is required for the further care^Authorization is required for the next period"
 ;
 ;RET(5)= Text for the 3rd line on the popup message^Text for the 3nd line of the warning popup message
 ; Example for OTH-EXT: RET(5)="Not time limited"
 ; Example for OTH-90: RET(5)="Call registration for details"
 ;
 ;
GET(RET,DFN,ORDATE) ;
 K RET
 ;insert the check for
 I $T(OTHBTN^DGOTHBTN)="" S RET(0)="-2^OTHD clock functionality is not available" Q
 I $G(DFN)'>0 S RET(0)="-1^patient IEN is not defined" Q
 S ORDATE=$S($G(ORDATE)>0:ORDATE,1:DT)
 D OTHBTN^DGOTHBTN(DFN,ORDATE,.RET)
 Q
 ;
