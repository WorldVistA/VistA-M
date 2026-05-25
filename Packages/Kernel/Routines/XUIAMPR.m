XUIAMPR ;BHM/DLR,DRI - IAM PROVISIONING - ADD/UPDATE OF A NEW PERSON ;1/26/23  09:01
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
ENTERPRISE(XUREQTYP,XUTERMDT) ;iam enterprise new person search and add to VistA ;**663 - STORY 783347 (dri)
 ;**799 VAMPI-22625
 ; Input:
 ;   XUREQTYP = 'ADD' or 'MODIFY' of a new person
 ;   XUTERMDT = the optional termination date when doing batch entry of
 ;              new persons through 'Grant Access by Profile' option
 ;
 ; Output:
 ;   IEN (DUZ) from file #200 if successfully added
 ;  -1^error message = there's a problem, can't continue
 ;   0 = can't perform enterprise search, possibly due to network
 ;       issue or non-production account, optionally continue with
 ;       legacy functionality
 ;
 ; Reference to WEB SERVER (#18.12) file allowed with supported IA #6408
 ; Reference to OP^XQCHK supported by IA #10078
 ;
 ;
 N PROD,XUIAM,XUOPT,XURET,XUSRCH
 ;
 I $$GET1^DIQ(18.12,+$$FIND1^DIC(18.12,,"BX","MPI_PSIM_NEW EXECUTE")_",",.04,"E")="" Q 0 ;don't use enterprise search functionality if web service server doesn't exist
 ;
 S XUOPT=$$OPTION() ;what option is the user in
 ;
 S Y=$$CHKUSER(.DUZ) I Y'=1 D  Q +Y ;does user performing 'add' have a secid at enterprise
 .W !!,"Sorry ... I can't verify your credentials."
 .W !,$P(Y,"^",2) ;returned error message
 .I +Y=0 S Y=$$LEGACY() S Y=$S(Y=1:0,1:-1) Q  ;communication issue, allow legacy add
 .I +Y<0 W !!,"You can attempt to use Link My Account to resolve the issue and retry.",!,"If you need assistance or the problem persists, please log a service ticket." ;problem with user
 ;
 ;S Y=$$ASKSRCH() I Y'=1 Q Y ;perform an enterprise search? ;not implementing
 ;
 S XUSRCH=$$ASKCRIT() I XUSRCH<0 Q XUSRCH ;lookup by email address, network username or traits
 ;
 S Y=$$RETCRIT(XUSRCH,.XUIAM) I Y<0 Q Y  ;return email address or network username
 ;
 I (XUSRCH'="T"),($$SRCH(.XURET,.XUIAM)'=1) Q -1 ;perform an initial query of psim to find person, unless by Traits
 ;
 I '$O(XURET(0)) I $$XSRCH(.XURET,.XUIAM,XUSRCH)'=1 Q -1 ;if initial search didn't find anyone, add more traits and perform an enhanced query of psim to find person
 ;
 S PROD=$$PROD^XUPROD() ;0-test, 1-production
 I 'PROD,$S($G(XURET)<0:1,$G(XURET("errorMessage"))'="":1,1:0) D  Q Y ;if a test account and issues
 .I $G(XURET)<0 W !!,"... ",$P(XURET,"^",2) S Y=$$LEGACY() S Y=$S(Y=1:0,1:-1) Q  ;and a communication issue with enterprise, fall into legacy functionality
 .I $G(XURET("errorMessage"))'="" W !!,"... ",XURET("errorMessage") S Y=$$LEGACY() S Y=$S(Y=1:0,1:-1) Q  ;and person not found at enterprise, fall into legacy functionality
 I PROD,$S($G(XURET)<0:1,$G(XURET("errorMessage"))'="":1,1:0) D  Q Y ;if a production account and issues
 .I $G(XURET)<0 W !!,"... ",$P(XURET,"^",2) D  S Y=$$LEGACY() S Y=$S(Y=1:0,1:-1) Q  ;and a communication issue with enterprise, fall into legacy functionality
 ..W !!,"... ","Enterprise Search is currently unavailable.  You can exit and try",!?4,"again later or proceed using the legacy '",$G(XUOPT),"'."
 .I $G(XURET("errorMessage"))'="" W !!,"... ",XURET("errorMessage") D  S Y=-1 Q  ;and person is not found at enterprise, try again
 ..W !!,"... User was not found but should already be known at Enterprise.",!?4,"Please review the criteria and try again.  If you are still unable",!?4,"to look them up please log a service ticket for assistance."
 ;
 Q $$FINDUSER^XUIAMPR1(.XURET,XUREQTYP,XUTERMDT) ;return duz of user to ^xusernew
 ;
 ;
OPTION() ;return option being executed
 N XQORNOD,XQOPT,XUOPT
 S XUOPT="Add a New User to the System" ;default if in programmer mode
 D OP^XQCHK I +XQOPT'=-1 S XUOPT=$P(XQOPT,"^",2)
 Q XUOPT
 ;
CHKUSER(DUZ) ;user must have secid at enterprise to perform enterprise search
 ; Input:
 ;   DUZ = User's IEN in File #200
 ;
 ; Output:
 ;   1 = secid was found at enterprise
 ;   0 = could not communicate with enterprise
 ;  -1 = error condition
 ;
 N XUARR,XUIAM,XURET
 I $G(DUZ("LOA"))<2 Q "-1^Insufficient Level of Assurance"
 D GETS^DIQ(200,+DUZ_",","205.5;501.1","E","XUARR")
 S XUIAM("VAemail")=XUARR(200,+DUZ_",",205.5,"E") ;adupn/email address" ;adupn/email address
 S XUIAM("samacctnm")=XUARR(200,+DUZ_",",501.1,"E") ;SaMaccountName/network username
 I XUIAM("VAemail")=""&(XUIAM("samacctnm")="") Q "-1^Network Username or ADUPN must be defined in the NEW PERSON (#200) file."
 D USER^XUIAMXML(.XURET,.XUIAM) ;is person adding new persons known at enterprise
 I $G(XURET)<0 Q "0^"_$P(XURET,"^",2) ;communication issue with enterprise, continue with legacy functionality
 I $G(XURET("errorMessage"))'="" Q "-1^"_XURET("errorMessage")
 I $G(XURET("secId"))="" Q "-1^secID not defined at Enterprise."
 Q $G(XURET("secId"))'=""
 ;
ASKSRCH() ;enterprise search by email address or network username
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to do an Enterprise Search" D ^DIR I $D(DIRUT) S Y=-1_"^Enterprise Search Rejected"
 Q Y
 ;
ASKCRIT() ;enterprise search by email address, network username or traits
 W !!,"Utilizing Enterprise User Search ..."
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="SA^E:Email Address;N:Network Username;T:Traits",DIR("A")="Enter an 'E'mail Address, 'N'etwork Username or 'T'raits: ",DIR("B")="E" D ^DIR I $D(DIRUT) S Y=-1_"^Search Criteria not Entered"
 Q Y
 ;
RETCRIT(XUSRCH,XUIAM) ;return search criteria
 I XUSRCH="E" D  I Y<0 Q Y ;email address
 .;K DIR S DIR(0)="200,.151^r" D ^DIR I Y'["@" S Y="-1^Invalid EMAIL ADDRESS" Q  ;email address input transform is stronger that adupn's
 .K DIR S DIR(0)="FAO^7:50^K:$L(X)>50!($L(X)<7)!'(X?1.E1""@""1.E) X I $D(X) K:X["",""!(X["" "") X"
 .S DIR("A")="Enter EMAIL ADDRESS: ",DIR("?")="Enter valid internet address in xxx@domain format, 7-50 characters in length, no commas or spaces."
 .D ^DIR I Y'["@" S Y="-1^Invalid EMAIL ADDRESS" Q  ;email address/adupn
 .S XUIAM("VAemail")=$TR(Y,"&","") ;strip off any '&', throws off the spml
 ;
 I XUSRCH="N" D  I Y<0 Q Y ;network username
 .;K DIR S DIR(0)="200,501.1^r" D ^DIR I Y'["@" S Y="-1^Invalid NETWORK USERNAME" Q  ;network username input transform too strong
 .K DIR S DIR(0)="FAO^9:15"
 .S DIR("A")="Enter NETWORK USERNAME: ",DIR("?")="Enter the Active Directory Username (9-15 characters)."
 .D ^DIR I $D(DIRUT)!(Y="") S Y="-1^Invalid NETWORK USERNAME" Q  ;network username
 .S XUIAM("samacctnm")=$$UP^XLFSTR($TR(Y,"&","")) ;strip off any '&', throws off the spml
 Q 1
 ;
LEGACY() ;ask to perform legacy add of new person
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="Y",DIR("A")="Continue with the Legacy '"_$G(XUOPT)_"' option",DIR("B")="No",DIR("?")="Enter 'YES' to use the legacy functionality to add the new user." D ^DIR I Y Q Y
 Q +Y
 ;
SRCH(XURET,XUIAM) ;perform initial enterprise search
 N XURET2
 K XURET ;we'll come out of here with either returned traits or nothing if an error condition
 ;
 W !!,"Searching Enterprise ..."
 D USER^XUIAMXML(.XURET,.XUIAM) ;is person known at enterprise
 I $S($G(XURET)<0:1,$G(XURET("errorMessage"))'="":1,$G(XURET("lastName"))="":1,1:0) K XURET Q 1 ;if error or traits not returned continue to enhanced search
 S CNT=1 M XURET2=XURET K XURET M XURET(CNT)=XURET2 ;person found, merge traits into subscripted array 
 D XDISP(.XURET,CNT) ;display extended traits
 Q $$ASKCONT()
 ;
XSRCH(XURET,XUIAM,XUSRCH) ;perform an enhanced enterprise search by including more traits
 N CONT,XURET2
 K XURET ;we'll come out of here with returned traits or error condition
 S CONT=0 ;initialize continue prompt
 S:(XUSRCH="T") XUIAM("VAemail")="NOT_PROVIDED@DOMAIN.EXT"  ;PSIM keyword to perform TRAITS ONLY search
 W !!,$S((XUSRCH="T"):"Enter traits to search on ...",1:"User not found, let's gather a few additional traits and try again ...")
 I $$ASKTRTS(.XUIAM)<0 Q -1 ;pass through previously entered VAemail or samacctnm for search
 W !!,"Searching Enterprise with the ",$S((XUSRCH="T"):"",1:"additional "),"traits ..."
 D QRYUSER^XUIAMXML(.XURET2,.XUIAM) ;is person(s) known at enterprise
 I $S($G(XURET2)<0:1,$G(XURET2("errorMessage"))'="":1,1:0) M XURET=XURET2 Q 1 ;return error and fall into test/prod prompting
 I '$O(XURET2(0)) K XURET2 S XURET("errorMessage")="User NOT FOUND" Q 1 ;should have returned traits but possibly an unforseen xml error returned, fall into test/prod prompting
 S CNT=$O(XURET2(0)) ;find first person in list
 ;if more than one person returned
 I $O(XURET2(CNT)) D  Q CONT
 .F  D  I CONT Q
 ..D DISP(.XURET2) ;display list of returned persons
 ..S CNT=$$ASKPRSN(.XURET2) I CNT<0 S CONT=-1 Q  ;choose which person to display
 ..D XDISP(.XURET2,CNT) ;display extended traits
 ..S CONT=$$ASKCONT() I CONT'=1 Q  ;person was not selected
 ..I $G(XURET2(CNT,"note"))["Mismatch" W !!,"User isn't selectable due to:",!?5,XURET2(CNT,"note"),!?5,"If assistance is required, please log a service ticket." S CONT=0 Q
 ..I $G(XURET2(CNT,"note"))["Orchestration" D ORCH(.XURET,.XURET2,CNT) ;selected person needs orchestrated
 ..M XURET(CNT)=XURET2(CNT)
 ;only one person returned
 D XDISP(.XURET2,CNT) ;display extended traits
 S CONT=$$ASKCONT() I CONT'=1 Q CONT ;person was not selected
 I $G(XURET2(CNT,"note"))["Mismatch" W !!,"User isn't selectable due to:",!?5,XURET2(CNT,"note"),!?5,"If assistance is required, please log a service ticket." S CONT=0 Q CONT
 I $G(XURET2(CNT,"note"))["Orchestration" D ORCH(.XURET,.XURET2,CNT) ;selected person needs orchestrated
 M XURET=XURET2
 Q CONT
 ;
ASKTRTS(XUIAM) ;prompt for additional traits and perform additional psim lookup
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="200,.01",DIR("A")="NAME (last,first middle)" D ^DIR I $D(DIRUT)!(Y="") Q -1 ;name required
 D NAMECOMP^XLFNAME(.Y)
 S XUIAM("firstName")=Y("GIVEN")
 S XUIAM("middleName")=Y("MIDDLE")
 S XUIAM("lastName")=Y("FAMILY")
 K DIR,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="FA^0:999999999^K:'(X?9N) X",DIR("A")="SSN (No Dashes): ",DIR("?")="SSN should be 9 numbers" D ^DIR I $D(DIRUT)!(Y="") Q -1 ;ssn required
 S XUIAM("pnid")=Y
 K DIR,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="200,5" D ^DIR I $D(DTOUT)!$D(DUOUT) Q -1 ;dob optional
 I Y'="" S XUIAM("dob")=$$FMTHL7^XLFDT(Y)
 K DIR,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="200,4" D ^DIR I $D(DTOUT)!$D(DUOUT) Q -1 ;gender optional
 I Y'="" S XUIAM("gender")=Y
 S XUIAM("WHO")=DUZ_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA" ;requestor
 Q 0
 ;
DISP(XURET) ;display returned persons
 W !!!,"Users found at Enterprise ...",!!?2,"#",?4,"ICN",?23,"NAME",?54,"SSN",?65,"DOB",?75,"SEX"
 S CNT=0 F  S CNT=$O(XURET(CNT)) Q:'CNT  D
 .W !,$J(CNT,3),?4,$G(XURET(CNT,"icn")),?23,$G(XURET(CNT,"lastName")),",",$G(XURET(CNT,"firstName"))," ",$G(XURET(CNT,"middleName")),?54,$G(XURET(CNT,"pnid"))
 .W ?65,$E($G(XURET(CNT,"dob")),5,6)_"/"_$E($G(XURET(CNT,"dob")),7,8)_"/"_$E($G(XURET(CNT,"dob")),3,4),?76,$G(XURET(CNT,"gender"))
 Q
 ;
ASKPRSN(XURET) ;ask for person
 N BC,EC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S BC=+$O(XURET(0)),EC=+$O(XURET("@"),-1) ;beginning and ending count
 W ! S DIR(0)="NA^"_BC_":"_EC,DIR("A")="Display additional traits for user # ",DIR("?")="Enter a number between "_BC_" and "_EC D ^DIR K DIR I $D(DIRUT) Q -1
 Q Y
 ;
XDISP(XURET,CNT) ;display extended traits
 W !!,"Traits for user from Enterprise ...",!
 I $G(XURET(CNT,"icn"))'="" W !?4,"ICN:",?17,$G(XURET(CNT,"icn"))
 W !?4,"Name:",?17,$G(XURET(CNT,"lastName")),",",$G(XURET(CNT,"firstName"))," ",$G(XURET(CNT,"middleName"))
 W !?4,"Email: ",?17,$G(XURET(CNT,"email"))
 W !?4,"NT Username:",?17,$S($G(XURET(CNT,"samAccountName"))'="":XURET(CNT,"samAccountName"),$G(XURET(CNT,"samacctnm"))'="":XURET(CNT,"samacctnm"),1:"")
 W !?4,"SSN:",?17,$G(XURET(CNT,"pnid"))
 W !?4,"DOB:",?17,$E($G(XURET(CNT,"dob")),5,6)_"/"_$E($G(XURET(CNT,"dob")),7,8)_"/"_$E($G(XURET(CNT,"dob")),3,4) ;$$FMTE^XLFDT($$HL7TFM^XLFDT($G(XURET("dob"))))
 W !?4,"Sex:",?17,$G(XURET(CNT,"gender"))
 W !!?4,"Address:"
 I $G(XURET(CNT,"street_1"))'="" W ?17,XURET(CNT,"street_1"),!
 I $G(XURET(CNT,"street_2"))'="" W ?17,XURET(CNT,"street_2"),!
 I $G(XURET(CNT,"street_3"))'="" W ?17,XURET(CNT,"street_3"),!
 W ?17,$G(XURET(CNT,"city"))_", "_$G(XURET(CNT,"state"))_"  "_$G(XURET(CNT,"postalCode")),!
 W !?4,"Phone:",?17,$G(XURET(CNT,"phone"))
 W !?4,"SECID:",?17,$G(XURET(CNT,"secId"))
 W !?4,"NPI:",?17,$G(XURET(CNT,"npi"))
 Q
 ;
ASKCONT() ;ask whether to continue with selected person
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Proceed with this user" D ^DIR I $D(DIRUT) Q -1
 Q Y
 ;
ORCH(XURET,XURET2,CNT) ;orchestrate person
 K XUIAM M XUIAM=XURET2(CNT) K XURET2
 S XUIAM("WHO")=DUZ_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA" ;requestor
 D ORCHUSER^XUIAMXML(.XURET2,.XUIAM) ;orchestrate person
 I $G(XURET2(CNT,"secId"))="" S XURET2("errorMessage")="Problem with Orchestration" ;shouldn't occur, means something went wrong with orchestration
 M XURET=XURET2 ;merge selected person's traits back into xuret
 Q
 ;
