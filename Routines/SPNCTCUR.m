SPNCTCUR ;WDE/SD SETS UP TMP WITH CURRENT EPISODE ;6/28/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;
 ; 
CUR(SPNCT,SPNDFN) ;
 ;   spnw is the care start date
 ;   spncdt is the most recent care date on file
 ;   This loop gets the latest care date on file
 ;
 S (SPNW,SPNCDT)=0
 F  S SPNW=$O(^UTILITY($J,SPNCT,SPNW)) Q:(SPNW="")!('+SPNW)  I SPNW>SPNCDT S SPNCDT=SPNW
 D BLD
 Q
 ;
PAST(SPNCT,SPNCDT) ;
 ;   this will be used to build tmp with a past care date
 D BLD
 Q
 ;
BLD ;
 ;NOW SET UP TMP BASED ON A CARE START DATE
 ;
 ;          
 K ^TMP($J)
 ;           spnw is the care start date
 ;           spncdt is the care date we want to build into tmp
 ;
 ;
 S SPNCNT=0
 S (SPNW,SPNX,SPNY)=""
 F  S SPNW=$O(^UTILITY($J,SPNCT,SPNCDT,SPNW)) Q:SPNW=""  S SPNX="" F  S SPNX=$O(^UTILITY($J,SPNCT,SPNCDT,SPNW,SPNX)) Q:SPNX=""  D
 .S SPNCNT=SPNCNT+1
 .S ^TMP($J,SPNCNT,SPNW,SPNX)=SPNX
 .S ^TMP($J,0)=SPNCNT
 .;                   spncedt = care endate if on file
 .I $G(SPNCEDT)="" S SPNCEDT=$P($G(^SPNL(154.1,SPNX,8)),U,2)
 S $P(^TMP($J,0),U,2)=SPNCDT S $P(^TMP($J,0),U,3)=$G(SPNCEDT)
 ;                    set the 4th piece to the care type
 S $P(^TMP($J,0),U,4)=SPNCT
