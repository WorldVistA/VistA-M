RGRSBULL ;ALB/RJS,CML-RGRSTEXT BULLETIN ROUTINE ;07/24/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19**;30 Apr 99
BULL(XMB,XMTEXT) ;
 ;Entry point generates a bulletin when a notification
 ;from the MPI/PD package has been generated
 ;
 ;Input:Required variables
 ;  
 ;      XMB    - Bulletin name e.g. ("RG CIRN DEMOGRAPHIC ISSUES")
 ;      XMTEXT - global or array root (EX. "^TMP("), location of 
 ;               error message(s)
 ;
 ;If XMY is defined, the call to ^XMB will process accordingly.
 ;XMY is used to pass additional recipients.
 ;
 Q:$G(XMB)=""!($G(XMTEXT)="")
 D NOW^%DTC S XMDT=X K X
 S XMDUZ="MPI/PD PACKAGE"
 D ^XMB
 K XMDT,XMDUZ
 Q
BULL2(XMSUB,XMTEXT) ;
 N XMY,XMDUZ
 S XMY("G.RG CIRN DEMOGRAPHIC ISSUES")=""
 S XMDUZ="MPI/PD PACKAGE"
 D ^XMD
 Q
 ;
ADDRESS(DFN,NAME,LINE1,LINE2,LINE3,SENDSITE,CITY,COUNTY,STATE,ZIP) ;
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group about changes to the address of a given patient.
 ;
 ;Input:  Required Variables
 ;
 ;   DFN   - IEN in the PATIENT file (#2)
 ;   NAME  - Patient's Name
 ;   LINE1,LINE2,LINE3 - Lines of the Address
 ; SENDSITE- The station number of the site that initiated the change
 ;    CITY - city
 ;  COUNTY - county
 ;   STATE - state
 ;     ZIP - zip
 ;
 Q:$G(DFN)=""!($G(NAME)="")
 Q:$G(^DPT(DFN,0))=""
 N RGADRES,DA,DIC,DR,DIQ,ADDR1,ADDR11,ADDR2,ADDR22,ADDR3,ADDR33,LINE11,LINE22,LINE33,ADDR4,ADDR44,ADDR5,ADDR55,ADDR6,ADDR66,ADDR7,ADDR77,DELFLG
 S DIC=2,DR=".111;.112;.113;.114;.115;.117;.1112",DA=DFN,DIQ="RGADRES",DIQ(0)="E" D EN^DIQ1
 S ADDR1=$G(RGADRES(2,DFN,.111,"E")),ADDR2=$G(RGADRES(2,DFN,.112,"E")),ADDR3=$G(RGADRES(2,DFN,.113,"E")),ADDR4=$G(RGADRES(2,DFN,.114,"E")),ADDR5=$G(RGADRES(2,DFN,.115,"E")),ADDR6=$G(RGADRES(2,DFN,.117,"E")),ADDR7=$G(RGADRES(2,DFN,.1112,"E"))
 ;
 S ADDR6=$$COUNTY^RGRSPARS(ADDR5,ADDR6)
 ;
 ;Check for null or deleted address fields from remote site
 ;
 S DELFLG=0
 ;
 I $S(LINE1="@":1,LINE1="""@""":1,LINE1="""""":1,1:LINE1="") D
 .I ADDR1'="" S DELFLG=1,LINE1="<<DELETED>>" Q
 .S LINE1=""
 ;
 I $S(LINE2="@":1,LINE2="""@""":1,LINE2="""""":1,1:LINE2="") D
 .I ADDR2'="" S LINE2="<<DELETED>>" Q
 .S LINE2=""
 ;
 I $S(LINE3="@":1,LINE3="""@""":1,LINE3="""""":1,1:LINE3="") D
 .I ADDR3'="" S LINE3="<<DELETED>>" Q
 .S LINE3=""
 ;
 I $S(CITY="@":1,CITY="""@""":1,CITY="""""":1,1:CITY="") D
 .I ADDR4'="" S DELFLG=1,CITY="<<DELETED>>" Q
 .S CITY=""
 ;
 I $S(STATE="@":1,STATE="""@""":1,STATE="""""":1,1:STATE="") D
 .I ADDR5'="" S DELFLG=1,STATE="<<DELETED>>" Q
 .S STATE=""
 ;
 I $S(COUNTY="@":1,COUNTY="""@""":1,COUNTY="""""":1,1:COUNTY="") D
 .I ADDR6'="" S DELFLG=1,COUNTY="<<DELETED>>" Q
 .S COUNTY=""
 ;
 I $S(ZIP="@":1,ZIP="""@""":1,ZIP="""""":1,1:ZIP="") D
 .I ADDR7'="" S DELFLG=1,ZIP="<<DELETED>>" Q
 .S ZIP=""
 ;
 I DELFLG G SENDADD
 ;
EXITADD ;
 Q
SENDADD ;
 N RGRSTEXT,XMSUB
 S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 S RGRSTEXT(2)=$$INST^RGRSBUL1(SENDSITE)
 S RGRSTEXT(3)="This message deleted address information for Patient:"
 S RGRSTEXT(4)=NAME
 S RGRSTEXT(5)="               "
 S RGRSTEXT(6)="                         <<OLD ADDRESS>>         <<NEW ADDRESS>>"
 S RGRSTEXT(7)="       "
 S RGRSTEXT(8)="STREET ADDRESS [LINE 1]: "_$$FORMAT^RGRSBUL1(ADDR1,LINE1)
 S RGRSTEXT(9)="STREET ADDRESS [LINE 2]: "_$$FORMAT^RGRSBUL1(ADDR2,LINE2)
 S RGRSTEXT(10)="STREET ADDRESS [LINE 3]: "_$$FORMAT^RGRSBUL1(ADDR3,LINE3)
 S RGRSTEXT(11)="                   CITY: "_$$FORMAT^RGRSBUL1(ADDR4,CITY)
 S RGRSTEXT(12)="                 COUNTY: "_$$FORMAT^RGRSBUL1(ADDR6,COUNTY)
 S RGRSTEXT(13)="                  STATE: "_$$FORMAT^RGRSBUL1(ADDR5,STATE)
 S RGRSTEXT(14)="                  ZIP+4: "_$$FORMAT^RGRSBUL1(ADDR7,ZIP)
 D BULL2($P(NAME,",",1)_" **MPI/PD ADDRESS DELETION**","RGRSTEXT(")
 G EXITADD
 ;
SKIPBULL(ARRAY) ;
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group about missing required data for a given patient.
 ;
 ;Input:  Required Variables
 ;
 ;  ARRAY  - Array of information regarding missing required data
 ;
 Q:'$D(@ARRAY)
 N RGRSTEXT,INDEX,COUNTER
 S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 S RGRSTEXT(2)=$$INST^RGRSBUL1(@ARRAY@("SENDING SITE"))
 S RGRSTEXT(3)="This message was missing required data"
 S RGRSTEXT(4)="    "
 S INDEX=0,COUNTER=5
 F  S INDEX=$O(@ARRAY@(INDEX)) Q:INDEX']""  D
 . S RGRSTEXT(COUNTER)="FIELD: "_INDEX_" = "_@ARRAY@(INDEX)
 . S COUNTER=COUNTER+1
 D BULL2("MPI/PD - MISSING DATA","RGRSTEXT(")
 Q
 ;
MTCHBULL(DFN,ARRAY,NAME,SSN,ICN,CMOR,BULSUB) ;
 ;Entry point generates a bulletin to the RG CIRN DEMOGRAPHIC
 ;ISSUES mail group about differences in the data of a given patient.
 ;
 ;Input:  Required Variables
 ;
 ;   DFN   - IEN in the PATIENT file (#2)
 ;  ARRAY  - Array of data containing sending sites station number
 ;   NAME  - Patient's Name
 ;   SSN   - Patient's SSN
 ;   ICN   - Patient's ICN (Integration Control Number) 
 ;   CMOR  - Patient's CMOR (Coordinating Master of Record)
 ;  BULSUB - Bulletin subject (Ex. ICN)
 ;
 Q:$G(DFN)=""!($G(ARRAY)="")
 N LOCDATA,RGRSTEXT,INDEX,COUNTER
 S RGRSTEXT(1)="The MPI/PD Package has received a message from:"
 S RGRSTEXT(2)=$$INST^RGRSBUL1(@ARRAY@("SENDING SITE"))
 S RGRSTEXT(3)="This message contains "_$P(BULSUB,"(")_" data that is"
 S RGRSTEXT(4)="inconsistent with your site's data."
 S RGRSTEXT(5)="           "
 S RGRSTEXT(6)="=> "_$P($$SITE^VASITE(),"^",2)_" local data:"
 S RGRSTEXT(7)="NAME: "_NAME
 S RGRSTEXT(8)="SSN: "_SSN
 S RGRSTEXT(9)="ICN: "_ICN
 S RGRSTEXT(10)="CMOR: "_CMOR
 S RGRSTEXT(11)="--------------------------------------------------------"
 S RGRSTEXT(12)="=> "_$P($$INST^RGRSBUL1(@ARRAY@("SENDING SITE"))," -->")_" data:"
 S COUNTER=12
 F INDEX="NAME","SSN","ICN","CMOR" D
 . I $D(@ARRAY@(INDEX)) S COUNTER=COUNTER+1,RGRSTEXT(COUNTER)=INDEX_": "_@ARRAY@(INDEX)
 D BULL2("MPI/PD - INCONSISTENT "_BULSUB,"RGRSTEXT(")
 Q
