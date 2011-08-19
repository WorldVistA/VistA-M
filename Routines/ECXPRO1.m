ECXPRO1 ;ALB/GTS - Prosthetics Extract for DSS (Continued) ; 4/14/08 4:07pm
 ;;3.0;DSS EXTRACTS;**9,11,13,15,21,24,33,37,39,100,105,112**;Dec 22, 1997;Build 26
 ;
NTEG(ECXDFN,ECXLNE,ECXPIEN,ECXN0,ECXNLB,ECINST,ECXFORM) ;** Check for required fields
 ;   Input
 ;    ECXDFN   - ien in file #2
 ;    ECXLNE   - line number variable (passed by reference)
 ;    ECXPIEN  - IEN for the Prosthetics record
 ;    ECXN0    - zero node of the Prosthetics record
 ;    ECXNLB   - LB node of the Prosthetics record
 ;    ECINST   - station number being extracted
 ;    ECXFORM  - Form Requested On
 ;   Output (to be KILLed by calling routine)
 ;    ^TMP("ECX-PRO EXC",$J) - Array for the exception message       
 ;    ECXLNE                 - The number of the next line in the msg
 ;    ECXSTAT2               - Patient Station Number
 ;    ECXDATE                - Delivery Date of Prosthesis
 ;    ECXTYPE                - Type of Transaction work performed
 ;    ECXSRCE                - Source of prosthesis
 ;    ECXHCPCS               - CPT/HCPCS code for prosthesis
 ;    ECXRQST                - Requesting Station
 ;    ECXRCST                - Receiving Station
 ;    ECXPHCPC               - PSAS HCPCS code; if 'unknown', then use CPT/HCPCS code 
 ;    ECXNPPDC               - NPPD code for repairs or new issues
 ;   Output (KILLed by NTEG)
 ;    ECXMISS                - 1 indicates missing information
 ;    ECXGOOD                - 0 indicates record should not be extracted
 ;
 N ECXGOOD,ECXMISS
 S (ECXRCST,ECXRQST,ECXNPPDC)="",ECXGOOD=1,ECXSTAT2=$P(ECXN0,U,10)
 I ECXSTAT2]"" D
 .K ECXDIC
 .S DA=ECXSTAT2,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECXSTAT2=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 .S:(ECINST'=$E(ECXSTAT2,1,3)) ECXGOOD=0 ;*Screen for incorrect Station
 ;
 ;** Screen out records
 S:($P(ECXN0,U,17)'="") ECXGOOD=0 ;*SHIP/DEL is not NULL
 S:($P(ECXN0,U,26)'="") ECXGOOD=0 ;*PICKUP/DEL is not NULL
 S:(+($P($G(^RMPR(660,ECXPIEN,"AM")),U,2))=1) ECXGOOD=0 ;*NO ADMIN CT=1
 S:(($P(ECXN0,U,15))'="") ECXGOOD=0 ;*HISTORICAL DATA is not NULL
 ;
 S ECXDATE=$P(ECXN0,U,12),ECXTYPE=$P(ECXN0,U,4),ECXSRCE=$P(ECXN0,U,14)
 S ECXHCPCS=$P($G(^ICPT(+$P(ECXN0,U,22),0)),U,1),ECXCMOD=""
 S ECXHCPCS=$$CPT^ECXUTL3(ECXHCPCS,ECXCMOD)
 ;get psas hcpcs code from file #661.1
 S ECXPHCPC=$P($G(^RMPR(660,ECXPIEN,1)),U,4) D
 .;get nppd code for repairs and new issues 10 characters in length.
 .I "X5"[ECXTYPE S ECXNPPDC=$TR($$GET1^DIQ(661.1,ECXPHCPC_",",5)," ","_")
 .I "ISR"[ECXTYPE S ECXNPPDC=$TR($$GET1^DIQ(661.1,ECXPHCPC_",",6)," ","_")
 .I +ECXPHCPC S ECXPHCPC=$E($P($G(^RMPR(661.1,ECXPHCPC,0)),U,1),1,5)
 .I ECXPHCPC="UNKNOWN" S ECXPHCPC=$E(ECXHCPCS,1,5)
 ;
 ;* Get Requesting Station Number
 I ECXFORM["-3" D
 .S ECXRQST=$P(ECXNLB,U,1)
 .I ECXRQST]"" D
 ..S DA=ECXRQST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXRQST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S:(ECXFORM'["-3") ECXRQST=""
 ;
 ;* Screen out records
 S:(+$P(ECXFORM,U,2)=13) ECXGOOD=0 ;*FORM REQUESTED ON = 13
 ;
 ;* Get Receiving Station Number
 I ECXFORM["-3" D
 .S ECXRCST=$P(ECXNLB,U,4)
 .I ECXRCST]"" D
 ..S DA=ECXRCST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 ..D EN^DIQ1 S ECXRCST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S:(ECXFORM'["-3") ECXRCST=""
 ;
 ;** Check for integrity and set up the problem variable if right DIV
 I ECXGOOD D CHK
 Q ECXGOOD
 ;
CHK ;*Check variables
 ; Input
 ;  Variables set in and Output from NTEG^ECXPRO1
 ; Output
 ;  ^TMP("ECX-PRO EXC",$J,   - Global of records with integrity problems
 ;
 S ECXMISS=""
 I ECXSTAT2']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXDFN=0 S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 ;I ECXSSN']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 ;I ECXNA="    " S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXDATE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXTYPE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXSRCE']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXHCPCS']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXFORM["-3" D
 .I ECXRQST']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXFORM']"" S ECXMISS=ECXMISS_"1"
 S ECXMISS=ECXMISS_U
 I ECXFORM["-3" D
 .I ECXRCST']"" S ECXMISS=ECXMISS_"1"
 I ECXMISS'="^^^^^^^^^^" D
 .S ECXGOOD=0
 .D ECXMISLN^ECXPRO2(ECXMISS,.ECXLNE,ECXPIEN)
 Q
 ;
PROSINFO(ECXDA,ECXLB,ECX0,ECXFORM) ;*Get Prosthetics Information
 ;
 ;  Input
 ;    ECDA    - The IEN for the Prosthetics record
 ;    ECX0    - The zero node of the Prosthetics record
 ;    ECXLB   - The LB node of the Prosthetics record
 ;    ECXFORM - The Form Requested On (to determine Lab transactions)
 ;
 ;  Output (to be KILLed by calling routine)
 ;    ECXCTAMT   - The Cost of Transaction
 ;    ECXLLC     - The Lab Labor Cost
 ;    ECXLMC     - The Lab Material Cost
 ;    ECXGRPR    - The AMIS Grouper number
 ;    ECXBILST   - The Billing Status
 ;    ECXQTY     - The Quantity
 ;
 S (ECXLLC,ECXLMC,ECXCTAMT)="",ECXBILST=$P($G(^RMPR(660,ECXDA,"AM")),U,3)
 S ECXQTY=$P(ECX0,U,7)
 S:(+ECXQTY=0) ECXQTY=1
 ;
 ;- Set Quantity field to 8 chars (right-justified & padded w/zeros)
 S ECXQTY=$$RJ^XLFSTR(ECXQTY,8,0)
 S ECXGRPR=$P($G(^RMPR(660,ECXDA,"AMS")),U,1),ECXCTAMT=$P(ECX0,U,16)
 I ECXFORM["-3" D
 .S ECXCTAMT=$P(ECXLB,U,9),ECXLLC=$P(ECXLB,U,7),ECXLMC=$P(ECXLB,U,8)
 ;
 ;- If Stock Issue or Inventory Issue, Cost of Transaction=0
 I $P(ECXFORM,U,2)=11!($P(ECXFORM,U,2)=12) S ECXCTAMT=0
 S:ECXCTAMT="" ECXCTAMT=0 S:ECXCTAMT>999999 ECXCTAMT=999999
 S:ECXLLC="" ECXLLC=0 S:ECXLLC>999999 ECXLLC=999999
 S:ECXLMC="" ECXLMC=0 S:ECXLMC>999999 ECXLMC=999999
 ;
 ;- Round to next dollar amount
 I (ECXCTAMT#1)>.50 S ECXCTAMT=(ECXCTAMT+1)\1
 I (ECXLLC#1)>.50 S ECXLLC=(ECXLLC+1)\1
 I (ECXLMC#1)>.50 S ECXLMC=(ECXLMC+1)\1
 Q
