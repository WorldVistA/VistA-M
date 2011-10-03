XUPSUTL1 ;EDS/GRR - Person Service Utility Routine ;4/9/04  10:08
 ;;8.0;KERNEL;**325**; Jul 10, 1995
 ;;
NMATCH(XUPSIEN,XUPSFNAM) ;
 ;;Match on First Name
 ;;Input Parameters:
 ;;      XUPSIEN - Internal Entry Number of New Person entry
 ;;     XUPSFNAM - Part or all of Person first name
 ;;Output:
 ;;      XUPSOUT - 1 if name matched, 0 if name did not match
 N XUPSA,XUPSHFN,XUPSFN,XUPSNFN,XUPSOUT ;establish new variables
 S XUPSFN=$P($G(^VA(200,XUPSIEN,0)),"^",1) ;get full name
 S XUPSHFN=$$HLNAME^HLFNC(XUPSFN,"~|\/") ;change to HL7 format (last name~first name~middle name)
 S XUPSNFN=$P(XUPSHFN,"~",2) ;get first name
 S XUPSOUT=$S($E(XUPSNFN,1,$L(XUPSFNAM))[XUPSFNAM:1,1:0) ; match first name to first name passed
 Q XUPSOUT  ;return 1 if name matched, 0 if no match
 ;
STNMAT(XUPSIEN,XUPSSTN) ;
 ;;Station Number matching
 ;;Input Parameters:
 ;;     XUPSIEN - Internal Entry Number of New Person entry
 ;;     XUPSSTN - 3-6 character station number to use as screen
 ;;               (i.e. 603 or 528A4)
 ;;Output:
 ;;       XUPSOUT - 1 if station matched, 0 if no station match
 N XUPSOUT,XUPSDIV,%,A,VASITE,XUPSNDT ;establish new variables
 S XUPSDIV=0,XUPSOUT=0 ;initialize new variables
 D NOW^%DTC S XUPSNDT=%\1 ;get current date
 I '$O(^VA(200,XUPSIEN,2,0)) S A=$$ALL^VASITE(XUPSNDT) G STNQ:'$D(VASITE(XUPSSTN)) S XUPSOUT=1 G STNQ ;if user has no division assigned, get default division and check for match
 F  S XUPSDIV=$O(^VA(200,XUPSIEN,2,XUPSDIV)) Q:XUPSDIV'>0  I $P($G(^DIC(4,XUPSDIV,99)),"^",1)=XUPSSTN S XUPSOUT=1 Q  ;loop through all divisions assigned and check for match
STNQ Q XUPSOUT  ;return 1 if match, o if no match
 ;
