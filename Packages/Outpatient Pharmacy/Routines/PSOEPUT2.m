PSOEPUT2 ;BIR/TJL - ePCS Broker Utilities ;10/13/21  10:35
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;
EPCSHELP(RESULTS,EPCSARY) ;
 ;
 ;Broker call returns the entries from HELP FILE #9.2
 ;        RPC: PSO EPCS GET HELP
 ;INPUTS   EPCSARY - Contains the following elements
 ;         HELPDA  - Help Frame Name
 ;
 ;OUTPUTS  RESULTS - Array of help text in the HELP FRAME File (#9.2)
 ;
 N HELPDA,DIC,X,Y
 S HELPDA=$G(EPCSARY) I HELPDA="" Q
 D SETENV K ^TMP("EPCSHELP",$J)
 S DIC="^DIC(9.2,",DIC(0)="MN",X=HELPDA
 D ^DIC M ^TMP("EPCSHELP",$J)=^DIC(9.2,+Y,1)
 I $D(^TMP("EPCSHELP",$J)) D
 . S $P(^TMP("EPCSHELP",$J,0),U)=$P(^DIC(9.2,+Y,0),U,2)
 S RESULTS=$NA(^TMP("EPCSHELP",$J))
 Q
 ;
EPCSDATE(RESULTS,EPCSARY) ;
 ;
 ;Broker call returns an FileMan internal date
 ;        RPC: PSO EPCS SYSTEM DATE TIME
 ;INPUTS   EPCSARY - Contains the following elements
 ;         DTSTR  - Date String (e.g., 'N' for 'Now')
 ;
 ;OUTPUTS  RESULTS - A valid FileMan date format^External format
 ;
 N EPCSDATE,DIC,X,Y,DATESTR
 D SETENV
 S DATESTR=$P(EPCSARY,U) I DATESTR="" Q
 S X=DATESTR,%DT="XT",%DT(0)="-NOW" D ^%DT
 I +Y<1 S RESULTS="0^Invalid Date/Time" Q
 S RESULTS=Y D D^DIQ
 S RESULTS=RESULTS_U_Y
 Q
 ;
SRCLST(RESULTS,EPCSARY) ;
 ;
 ; This broker entry returns an array of codes from a file
 ; based on a search string.
 ;        RPC: PSO EPCS GET LIST
 ;
 ;INPUTS    EPCSARY  - Contains the following subscripted elements
 ;          EPCSFILE - File to search
 ;          EPCSSTR  - Search string
 ;          EPCSDIR  - Search order
 ;          EPCSNUM  - (Optional) # records to return [default=44]
 ;OUTPUTS   RESULTS - Array of values based on the search criteria.
 ;
 N EPCSFILE,EPCSSTR,EPCSDIR,EPCSORD,EPCSNUM
 D SETENV
 S EPCSFILE=$P(EPCSARY,U),EPCSSTR=$P(EPCSARY,U,2),EPCSDIR=$P(EPCSARY,U,3)
 S EPCSORD=$S(EPCSDIR=-1:"B",1:"I")
 K ^TMP($J,"EPCSFIND"),^TMP("EPCSSRCH",$J)
 I EPCSFILE="" Q
 S EPCSNUM=$S(+$P(EPCSARY,U,4)>0:$P(EPCSARY,U,4),1:44)
 I EPCSFILE=200 D PROV(EPCSNUM)      ;Providers
 D SORT
EXIT K ^TMP("EPCSSRCH",$J)
 S RESULTS=$NA(^TMP($J,"EPCSFIND"))
 Q
 ;
SORT ;Order the data to be returned by the broker
 N COUNT
 S COUNT=0
 F  S COUNT=$O(^TMP("EPCSSRCH",$J,"DILIST","ID",COUNT)) Q:'COUNT  D
 .S ^TMP($J,"EPCSFIND",COUNT)=$G(^TMP("EPCSSRCH",$J,"DILIST","ID",COUNT,.01))_U_^TMP("EPCSSRCH",$J,"DILIST",2,COUNT)
 Q
 ;
PROV(EPCSNUM) ;Return a set of providers from the NEW PERSON file
 ;Input Variables:-
 ;  EPCSNUM - # of records to return
 ;  FROM    - text to begin $O from
 ;  DATE    - checks for an active person class on this date (optional)
 ;  EPCSDIR - $O direction
 ;  REPORT  - Set to "R" to get all entries from file 200 OR set to blank 
 ;            if only users with a person class should be returned.
 ;
 ;Output Variables:-
 ;  ^TMP($J,"EPCSFIND",1..n - returned array
 ;     IEN of file 200^Provider Name^occupation^specialty^subspecialty
 ;
 N I,IEN,COUNT,FROM,DATE,EPCSUTN,REPORT S I=0,COUNT=$S(+$G(EPCSNUM)>0:EPCSNUM,1:44)
 S FROM=$P(EPCSSTR,"|"),DATE=$P(EPCSSTR,"|",2),REPORT=$P(EPCSSTR,"|",3)
 F  Q:I'<COUNT  S FROM=$O(^VA(200,"B",FROM),EPCSDIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^VA(200,"B",FROM,IEN),EPCSDIR) Q:'IEN  D 
 . . I IEN<1 Q     ; Don't include special users postmaster and sharedmail
 . . I REPORT="R" S I=I+1,^TMP($J,"EPCSFIND",I)=IEN_"^"_FROM_"^" Q
 . . S EPCSUTN=$$GET^XUA4A72(IEN,DATE)
 . . S I=I+1,^TMP($J,"EPCSFIND",I)=IEN_"^"_FROM_"^"_$P(EPCSUTN,"^",2,4)
 Q
SETENV ;
 I '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 Q
