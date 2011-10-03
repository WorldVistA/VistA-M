SPNCTANN ;WDE/SD ANN/CONT MAIN STARTING POINT ;6/27/02  05:15
 ;;2.0;Spinal Cord Dysfunction;**19,20**;01/02/1997
 ;
 ; 
OTH(SPNCT) ;Starting point called from the option
 ;patient is asked and then spnct is set to 1
 ;  the patients dfn is passed back in SPNFDFN
 D ZAP  ;make sure all is clean before we start
 D PAT1541^SPNFMENU
 Q:SPNFEXIT=1
 Q:$D(SPNFDFN)=""
RESTART ;
 I $D(SPNQUIT) Q:SPNQUIT=1
 S SPNFEXIT=0,SPNEXIT=0
 S SPNDFN=SPNFDFN
 S SPNNEW=""
 D OTHER^SPNCTBLD(SPNCT,SPNDFN)  ;build utility with in patient 
 S SPNHDR=$S(SPNCT=3:"Annual Evaluation",SPNCT=4:"Continuum of Care",1:"NO CARE TYPE")
 D EN^SPNCTSHO(SPNDFN)
 I SPNSEL="" G ZAP^SPNCTINA Q
 I SPNSEL="A" S SPNEXIT=0 D ADD
 I SPNEXIT=1 D ZAP Q
 ;I SPNEXIT=1 D ZAP G RESTART Q
 I SPNEXIT'=1 I $D(SPNFD0) I $D(SPNFTYPE)  D EDIT^SPNFEDT0
 ;
 D ZAP S SPNFDFN=SPNDFN G RESTART
 Q
ZAP ;
 K ^UTILITY($J),^TMP($J)
 K SPNA,SPNB,SPNC,SPNRTN,SPNSEL,SPNFTYPE,SPNFD0,SPNIEN,SPNSCOR,DIR,DA,DIE,SPNFEXIT,SPNSET,SPNDATA
 K SPNCEDT,SPNFIEN,SPNTST
 K SPNCTYP,SPNW,SPNX,SPNY,SPNZ,SPNCNT,SPNXMIT,SPNFIEN,SPNDATE,DIC,DR,SPNLINE,SPNCNT,SPNOUT,SPNOTNE
 Q
ADD ; *** Add a record to the OUTCOMES file (#154.1)
 ;D IN^SPNCTAA  ;prompt for the score type for the new outcome
 I SPNEXIT=1 D ZAP Q
 D REPT^SPNFEDT0(SPNFDFN)
 I $G(SPNFFIM)=0 D ZAP Q
 I SPNFTYPE="" D ZAP Q  ;no fim record type selected
 I SPNEXIT=1 D ZAP Q
 I SPNCT=4 D CONT^SPNCTAA  ;prompt for the score type for the new outcome
 I SPNEXIT=1 D ZAP Q
 K DIR S DIR("A")="Enter a New Record Date: "
 ;D DATES  ;Date range set up of dir(0) set above as saftey
 S DIR(0)="DAO^:NOW"
 D ^DIR
 I '+Y K DIR,Y S SPNFEXIT=1 Q
 S SPNDATE=Y
 K DD,DIC,DINUM,DO
 S SPNFD0=-1
 S DIC="^SPNL(154.1,",DIC(0)="L"
 S DLAYGO=154.1,X=SPNFDFN
 D FILE^DICN W ! S SPNFD0=+Y
 K DA,DIE,DR
 I $G(SPNSCOR)="" S SPNSCOR=""
 S DIE="^SPNL(154.1,",DA=SPNFD0
 S DR=".02///^S X="_SPNFTYPE_";.04///"_SPNDATE_";.021///"_SPNSCOR_";.023///"_$$EN^SPNMAIN(DUZ)_";1003////"_SPNCT
 I SPNEXIT=1 D ZAP Q  ;^ OUT OF THE CLOSE QUESTION
 D ^DIE
 S SPNNEW="YES"
 ;
 Q
DATES ;set up upper and lower boundaries for the new record
 ;     If there is a care stop date that will be the upper
 ;     If there is a care start date that will be the lower
 ;     Note that TMP is 2nd and 3rd piece is the care start
 ;                      and endates
 ;           So if they are adding a outcome to a closed episode
 ;           piece 2 and 3 will be present.
 S (SPNX,SPNY)="",DIR(0)=""
 S SPNX=$P($G(^TMP($J,0)),U,2)
 S SPNY=$P($G(^TMP($J,0)),U,3)
 I SPNY'=""  S DIR(0)="DAO^"_SPNX_":"_SPNY_":EX" Q
 ;spny = close date
 I SPNSCOR'=5 I SPNY="" S DIR(0)="DAO^"_SPNX_":"_DT_":EX" Q
 I SPNSCOR=5 I SPNY="" D
 .S SPNB=""
 .S SPNA=0 F  S SPNA=$O(^TMP($J,SPNA)) Q:SPNA=""  S SPNB="" S SPNB=$O(^TMP($J,SPNA,SPNB)) Q:SPNB=""
 .I $G(SPNB)'="" S DIR(0)="DAO^"_SPNB_":"_DT_":EX" Q
 .Q
 Q
