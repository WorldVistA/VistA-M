PSOERXZ1 ;ALB/BWF - patch 508 post-install support ; 2/27/2018 1:43pm
 ;;7.0;OUTPATIENT PHARMACY;**508**;DEC 1997;Build 295
 ;
 Q
 ; error codes
ERR ;
 ;;001^Sender ID not on file.
 ;;002^Receiver ID not on file.
 ;;003^Invalid password for sender.
 ;;004^Invalid password for receiver
 ;;005^No password on file for sender.
 ;;006^No password on file for receiver.
 ;;007^Internal processing error has occurred.
 ;;008^Request timed out before response could be received.
 ;;009^Required segment UIB is missing.
 ;;010^Required segment UIH is missing.
 ;;011^Required segment UIT is missing.
 ;;012^Required segment UIZ is missing.
 ;;013^Unknown segment has been encountered.
 ;;014^Too many UIB segments. CODE DESCRIPTION
 ;;015^Too many UIH segments.
 ;;016^Too many UIT segments.
 ;;017^Too many UIZ segments.
 ;;018^Password is blank.
 ;;019^Too many segments.
 ;;020^Unknown data element encountered.
 ;;021^Unsupported version in message.
 ;;022^Unsupported release in message.
 ;;023^Error found in an unused field.
 ;;024^Message ending problem.
 ;;025^UIB trace number is invalid.
 ;;026^UIB initiator reference is invalid.
 ;;027^UIB control agency is invalid.
 ;;028^UIB sender identification is invalid.
 ;;029^UIB date is invalid.
 ;;030^UIB time is invalid.
 ;;031^UIB time offset is invalid.
 ;;032^UIB duplicate flag is invalid.
 ;;033^UIB test flag is invalid.
 ;;034^UIH message type is invalid.
 ;;035^UIH function is invalid.
 ;;036^UIH association code is invalid.
 ;;037^UIH prescription number is invalid.
 ;;038^UIH initiator reference is invalid.
 ;;039^UIH initiator reference identifier is invalid.
 ;;040^UIH control agency is invalid.
 ;;041^UIH responder control reference is invalid.
 ;;042^REQ message function is invalid.
 ;;043^REQ reason code is invalid.
 ;;044^REQ reference is invalid.
 ;;045^REQ old password is invalid.
 ;;046^REQ new password is invalid.
 ;;047^RES response type is invalid.
 ;;048^RES response code is invalid.
 ;;049^RES reference is invalid.
 ;;050^RES free text is invalid.
 ;;051^STS status code is invalid.
 ;;052^STS reject code is invalid.
 ;;053^STS free text is invalid.
 ;;054^PVD provider type is invalid.
 ;;055^PVD reference is invalid.
 ;;056^PVD reference qualifier is invalid.
 ;;057^PVD agency qualifier is invalid.
 ;;058^PVD specialty, coded is invalid.
 ;;059^PVD prescriber last name is invalid.
 ;;060^PVD prescriber first name is invalid.
 ;;061^PVD prescriber middle name is invalid.
 ;;062^PVD prescriber name suffix is invalid.
 ;;063^PVD prescriber name prefix is invalid.
 ;;064^PVD prescriber postal code is invalid.
 ;;065^PVD clinic name is invalid.
 ;;066^PVD clinic street is invalid.
 ;;067^PVD clinic city is invalid.
 ;;068^PVD clinic country is invalid.
 ;;069^PVD clinic postal code is invalid.
 ;;070^PVD clinic place qualifier is invalid.
 ;;071^PVD clinic place name is invalid.
 ;;072^PVD communication reference is invalid.
 ;;073^PVD communication qualifier is invalid.
 ;;074^PVD agent last name is invalid.
 ;;075^PVD agent first name is invalid.
 ;;076^PVD agent middle name is invalid.
 ;;077^PVD agent name suffix is invalid.
 ;;078^PVD agent name prefix is invalid.
 ;;079^PTT patient relationship is invalid.
 ;;080^PTT patient birth date is invalid.
 ;;081^PTT patient last name is invalid.
 ;;082^PTT patient first name is invalid.
 ;;083^PTT patient middle name is invalid.
 ;;084^PTT patient name suffix is invalid.
 ;;085^PTT patient name prefix is invalid.
 ;;086^PTT patient gender is invalid.
 ;;087^PTT patient reference is invalid.
 ;;088^PTT patient reference qualifier is invalid.
 ;;089^PTT patient street is invalid.
 ;;090^PTT patient city is invalid.
 ;;091^PTT patient country is invalid.
 ;;092^PTT patient postal code is invalid.
 ;;093^PTT patient place qualifier is invalid.
 ;;094^PTT patient place name is invalid.
 ;;095^PTT communication reference is invalid.
 ;;096^PTT communication reference qualifier is invalid.
 ;;097^COO payer reference is invalid.
 ;;098^COO payer reference qualifier is invalid.
 ;;099^COO payer name is invalid.
 ;;100^COO service type is invalid.
 ;;101^COO cardholder reference is invalid.
 ;;102^COO cardholder reference qualifier is invalid.
 ;;103^COO cardholder name is invalid.
 ;;104^COO group reference is invalid.
 ;;105^COO group name is invalid.
 ;;106^COO group street is invalid.
 ;;107^COO group city is invalid.
 ;;108^COO group country is invalid.
 ;;109^COO group postal code is invalid.
 ;;110^COO group place qualifier is invalid.
 ;;111^COO group place name is invalid.
 ;;112^COO datetime qualifier is invalid.
 ;;113^COO datetime is invalid.
 ;;114^COO datetime format qualifier is invalid.
 ;;115^COO insurance type is invalid.
 ;;116^COO holder street is invalid.
 ;;117^COO holder city is invalid.
 ;;118^COO holder country is invalid.
 ;;119^COO holder postal code is invalid.
 ;;120^COO holder place qualifier is invalid.
 ;;121^COO holder place name is invalid.
 ;;122^COO holder reference is invalid.
 ;;123^COO holder reference qualifier is invalid.
 ;;124^COO response code is invalid.
 ;;125^DRU drug disposition code is invalid.
 ;;126^DRU drug name is invalid.
 ;;127^DRU drug item number is invalid.
 ;;128^DRU drug agency is invalid.
 ;;129^DRU drug agency qualifier is invalid.
 ;;130^DRU drug strength is invalid.
 ;;131^DRU drug strength qualifier is invalid.
 ;;132^DRU drug reference is invalid.
 ;;133^DRU drug reference qualifier is invalid.
 ;;134^DRU dosage quantity qualifier is invalid.
 ;;135^DRU dosage quantity is invalid.
 ;;136^DRU dosage info qualifier is invalid.
 ;;137^DRU dosage info is invalid.
 ;;138^DRU dosage free text is invalid.
 ;;139^DRU datetime qualifier is invalid.
 ;;140^DRU datetime is invalid.
 ;;141^DRU datetime format qualifier is invalid.
 ;;142^DRU substitution code is invalid.
 ;;143^DRU refill quantity qualifier is invalid.
 ;;144^DRU refill quantity is invalid.
 ;;145^DRU clinical info qualifier is invalid.
 ;;146^DRU clinical info level1 reference is invalid
 ;;147^DRU clinical info level1 qualifier is invalid.
 ;;148^DRU clinical info level2 reference is invalid.
 ;;149^DRU clinical info level2 qualifier is invalid.
 ;;150^DRU prior authorization reference is invalid.
 ;;151^DRU prior authorization qualifier is invalid.
 ;;152^DRU free text is invalid.
 ;;153^OBS measurement dimension is invalid.
 ;;154^OBS measurement value is invalid.
 ;;155^OBS measurement qualifier is invalid.
 ;;156^OBS datetime is invalid.
 ;;157^OBS datetime qualifier is invalid.
 ;;158^OBS free text is invalid.
 ;;159^UIT reference number is invalid.
 ;;160^UIT segment count is invalid.
 ;;161^UIZ dial reference is invalid.
 ;;162^UIZ dial identifier is invalid.
 ;;163^UIZ control agency is invalid.
 ;;164^UIZ responder control ref is invalid.
 ;;165^UIZ message count is invalid.
 ;;166^Too many elements in COO segment.
 ;;167^Too many elements in DRU segment.
 ;;168^Too many elements in OBS segment.
 ;;169^Too many elements in PTT segment.
 ;;170^Too many elements in PVD segment.
 ;;171^Too many elements in REQ segment.
 ;;172^Too many elements in RES segment.
 ;;173^Too many elements in STS segment.
 ;;174^Too many elements in UIB segment.
 ;;175^Too many elements in UIH segment.
 ;;176^Too many elements in UIT segment.
 ;;177^Too many elements in UIZ segment.
 ;;178^Too many COO segments.
 ;;179^Too many DRU segments.
 ;;180^Too many OBS segments.
 ;;181^Too many PTT segments.
 ;;182^Too many PVD segments.
 ;;183^Too many REQ segments.
 ;;184^Too many RES segments.
 ;;185^Too many STS segments.
 ;;186^Too many UNA segments.
 ;;187^Too many COO element repetitions.
 ;;188^Too many DRU element repetitions.
 ;;189^Too many OBS element repetitions.
 ;;190^Too many PTT element repetitions.
 ;;191^Too many PVD element repetitions.
 ;;192^Too many REQ element repetitions.
 ;;193^Too many RES element repetitions.
 ;;194^Too many STS element repetitions.
 ;;195^Too many UIB element repetitions.
 ;;196^Too many UIH element repetitions.
 ;;197^Too many UIT element repetitions.
 ;;198^Too many UIZ element repetitions.
 ;;199^Segment count mismatch in UIT.
 ;;200^Message missing required REQ segment.
 ;;201^Message missing required RES segment.
 ;;202^Message missing required STS segment.
 ;;203^Message missing required PVD segment.
 ;;204^Message missing required PTT segment.
 ;;205^Message missing required COO segment.
 ;;206^Message missing required DRU segment.
 ;;207^Message missing required OBS segment.
 ;;208^Sender no longer active.
 ;;209^Receiver no longer active.
 ;;210^Unable to process transaction. Please resubmit.
 ;;211^DUE Reason For Service Code is invalid.
 ;;212^DUE Professional Service Code is invalid.
 ;;213^DUE Result Of Service Code is invalid.
 ;;214^DUE Co-Agent ID is invalid.
 ;;215^DUE Co-Agent ID Qualifier is invalid.
 ;;216^Drug Coverage Status Code is invalid.
 ;;217^COO Date/Time/Period Expiration date - of needed history is less than Effective Date (Begin) of needed history
 ;;218^COO Patient Identifier is invalid
 ;;219^COO Cannot process Medication History due to value of Condition/Response, coded (Patient Consent Indicator)
 ;;220^Message is a duplicate
 ;;221^Needed No Later Than Reason Date/Time Period Qualifier is invalid
 ;;222^Needed No Later Than Reason Date/Time/Period is invalid
 ;;223^Needed No Later Than Reason Date/Time/Period Format Qualifier is invalid
 ;;224^DRU Time Zone Identifier is invalid
 ;;225^DRU Time Zone Difference Quantity is invalid
 ;;226^Needed No Later Than Reason is invalid
 ;;227^Message missing required SRC Segment
 ;;228^SRC Source Qualifier is invalid
 ;;229^SRC Source Description is invalid
 ;;230^SRC Source Reference Number is invalid
 ;;231^SRC Source Reference Qualifier is invalid
 ;;232^SRC Reference Number is invalid
 ;;233^SRC Fill Number is invalid
 ;;234^Too many SRC Segments
 ;;235^Too many SRC element repetitions
 ;;236^Too many elements in SRC Segment
 ;;237^SIG Sig Sequence Position Number is invalid
 ;;238^SIG Multiple Sig Modifier is invalid
 ;;239^SIG SNOMED Version is invalid
 ;;240^SIG FMT Version is invalid
 ;;241^SIG Sig Free Text String Indicator is invalid CODE DESCRIPTION
 ;;242^SIG Sig Free Text is invalid
 ;;243^SIG Dose Composite Indicator is invalid
 ;;244^SIG Dose Delivery Method Text is invalid
 ;;245^SIG Dose Delivery Method Code Qualifier is invalid
 ;;246^SIG Dose Delivery Method Code is invalid
 ;;247^SIG Dose Delivery Method Modifier Text is invalid
 ;;248^SIG Dose Delivery Method Modifier Code Qualifier is invalid
 ;;249^SIG Dose Delivery Method Modifier Code is invalid
 ;;250^SIG Dose Quantity is invalid
 ;;251^SIG Dose Form Text is invalid
 ;;252^SIG Dose Form Code Qualifier is invalid
 ;;253^SIG Dose Form Code is invalid
 ;;254^SIG Dose Range Modifier is invalid
 ;;255^SIG Dosing Basis Numeric Value is invalid
 ;;256^SIG Dosing Basis Unit of Measure Text is invalid
 ;;257^SIG Dosing Basis Unit of Measure Code Qualifier is invalid
 ;;258^SIG Dosing Basis Unit of Measure Code is invalid
 ;;259^SIG Body Metric Qualifier is invalid
 ;;260^SIG Body Metric Value is invalid
 ;;261^SIG Calculated Dose Numeric is invalid
 ;;262^SIG Calculated Dose Unit of Measure Text is invalid
 ;;263^SIG Calculated Dose Unit of Measure Code Qualifier is invalid
 ;;264^SIG Calculated Dose Unit of Measure Code is invalid
 ;;265^SIG Dosing Basis Range Modifier is invalid
 ;;266^SIG Vehicle Name is invalid
 ;;267^SIG Vehicle Name Code Qualifier is invalid
 ;;268^SIG Vehicle Name Code is invalid
 ;;269^SIG Vehicle Quantity is invalid
 ;;270^SIG Vehicle Unit Of Measure Text is invalid
 ;;271^SIG Vehicle Unit Of Measure Code Qualifier is invalid
 ;;272^SIG Vehicle Unit Of Measure Code is invalid
 ;;273^SIG Multiple Vehicle Modifier is invalid
 ;;274^SIG Route of Administration Text is invalid
 ;;275^SIG Route of Administration Code Qualifier is invalid
 ;;276^SIG Route of Administration Code is invalid
 ;;277^SIG Multiple Route of Administration Modifier is invalid
 ;;278^SIG Site of Administration Text is invalid
 ;;279^SIG Site of Administration Code Qualifier is invalid
 ;;280^SIG Site of Administration Code is invalid
 ;;281^SIG Multiple Administration Timing Modifier is invalid
 ;;282^SIG Administration Timing Text is invalid
 ;;283^SIG Administration Timing Code Qualifier is invalid
 ;;284^SIG Administration Timing Code is invalid
 ;;285^SIG Multiple Administration Timing Modifier is invalid
 ;;286^SIG Rate of Administration is invalid
 ;;287^SIG Rate Unit of Measure Text is invalid
 ;;288^SIG Rate Unit of Measure Code Qualifier is invalid
 ;;289^SIG Rate Unit of Measure Code is invalid
 ;;290^SIG Time Period Basis Text is invalid
 ;;291^SIG Time Period Basis Code Qualifier is invalid
 ;;292^SIG Time Period Basis Code is invalid
 ;;293^SIG Frequency Numeric Value is invalid
 ;;294^SIG Frequency Units Text is invalid
 ;;295^SIG Frequency Units Code Qualifier is invalid
 ;;296^SIG Frequency Units Code is invalid
 ;;297^SIG Variable Frequency Modifier is invalid
 ;;298^Interval Numeric Value is invalid
 ;;299^SIG Interval Units Text is invalid
 ;;300^SIG Interval Units Code Qualifier is invalid
 ;;301^SIG Interval Units Code is invalid
 ;;302^SIG Variable Interval Modifier is invalid
 ;;303^SIG Duration Numeric Value is invalid
 ;;304^SIG Duration Text is invalid
 ;;305^SIG Duration Text Code Qualifier is invalid
 ;;306^SIG Duration Text Code is invalid
 ;;307^SIG Maximum Dose Restriction Numeric Value is invalid
 ;;308^SIG Maximum Dose Restriction Units Text is invalid
 ;;309^SIG Maximum Dose Restriction Code Qualifier is invalid
 ;;310^SIG Maximum Dose Restriction Units Code is invalid
 ;;311^SIG Maximum Dose Restriction Variable Numeric Value is invalid
 Q
