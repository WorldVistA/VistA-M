XUIAMPR1 ;BHM/DLR,DRI - IAM PROVISIONING - ADD/UPDATE OF A NEW PERSON (CONT) ;1/25/23  18:01
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
FINDUSER(XURET,XUREQTYP,XUTERMDT) ;search vista instance to find user ;**663 - STORY 783347 (dri) **799 VAMPI-22625
 ; Input:  XURET(#) = Array containing person's attributes
 ;         XUREQTYP = 'ADD' or 'MODIFY' of a new person
 ;         XUTERMDT = the optional termination date when doing batch entry of
 ;                    new persons through 'Grant Access by Profile' option
 ;
 ; Return: Fail     = "-1^Error Message"
 ;         Success  = IEN (DUZ) from file #200 if successfully added
 ;
 ;
 N CNT,ERRMSG,I,NAME,SOURCEID,VISTAID,XATR,XUATTRTYPE,XUCNT,XUIAMDUZ
 ;
 S CNT=$O(XURET(0)) ;count of person selected
 I '$D(XURET(CNT,"adupn")) S XURET(CNT,"adupn")=$$LOW^XLFSTR($G(XURET(CNT,"email"))) ;default email for adupn if the adupn is not returned by psim
 ;
 I $L($G(XURET(CNT,"vistaid")),"|")>1 D  ;find person's duz known at enterprise
 .;VISTAID should look like 12596^PN^200M^USDVA [userid/duz^source id type^station number^assigning authority].
 .F I=2:3:$L(XURET(CNT,"vistaid"),"|") S VISTAID=$P(XURET(CNT,"vistaid"),"|",I) I $P(VISTAID,"^",3)=$P($$SITE^VASITE(),"^",3),($P(VISTAID,"^",2)="PN"),($P(VISTAID,"^",1)'="") S SOURCEID=$P(VISTAID,"^",1) Q
 ;
 ;don't default in subjectOrg or orgId, should be returned by psim
 S XATR(1)=$G(XURET(CNT,"subjectOrg")) ;$$TITLE^XLFSTR($E("Department Of Veterans Affairs",1,50)) ;subject organization
 S XATR(2)=$G(XURET(CNT,"orgId")) ;$$LOW^XLFSTR($E("urn:oid:2.16.840.1.113883.4.349",1,50)) ;subject organization id
 S XATR(3)=$TR($$LOW^XLFSTR($E($G(XURET(CNT,"secId")),1,40)),"^","%") ;unique user id
 S NAME=$G(XURET(CNT,"lastName"))_"," I $G(XURET(CNT,"firstName"))'="" S NAME=NAME_XURET(CNT,"firstName") I $G(XURET(CNT,"middleName"))'="" S NAME=NAME_" "_XURET(CNT,"middleName")
 S XATR(4)=$$FORMAT^XLFNAME7(.NAME,3,35,,0,,,2) ;subject id converted to standard format: name  last, first  middle
 I $G(XATR(4))'?1U.E1","1U.E Q "-1^Subject ID could not be converted to 'LAST,FIRST MIDDLE SUFFIX' VistA standard format"
 ;S XATR(5)= ;security phrase to establish context option (not implemented)
 S XATR(6)=$$UP^XLFSTR($E($G(XURET(CNT,"samacctnm")),1,50)) ;active directory network username
 S XATR(7)=$TR($$LOW^XLFSTR($E($G(XURET(CNT,"secId")),1,40)),"^","%") ;security id
 S XATR(8)=$G(XURET(CNT,"npi")) ;npi
 S XATR(9)=$G(XURET(CNT,"pnid")) ;ssn
 S XATR(10)=$$LOW^XLFSTR($G(XURET(CNT,"adupn"))) ;adupn - active directory user principle name
 S XATR(11)=$$LOW^XLFSTR($G(XURET(CNT,"email"))) ;va or external email
 S XATR(12)=$G(XURET(CNT,"gender")) ;sex/gender
 S XATR(13)=$G(XURET(CNT,"dob")) ;date of birth (yyyymmdd)
 S XATR(14)=$G(XURET(CNT,"street_1"))  ;Street Address 1
 S XATR(15)=$G(XURET(CNT,"street_2"))  ;Street Address 2
 S XATR(16)=$G(XURET(CNT,"street_3"))  ;Street Address 3
 S XATR(17)=$G(XURET(CNT,"city"))  ;City
 S XATR(18)=$G(XURET(CNT,"state"))  ;State
 S XATR(19)=$G(XURET(CNT,"postalCode"))  ;Zip
 ;
 ; Check for unique identifier (SecID, NPI, SSN, or OID+UID)
 I ($G(XATR(7))="")&($G(XATR(8))="")&($G(XATR(9))="")&(($G(XATR(2))="")&($G(XATR(3))="")) Q "-1^Array does not contain a unique identifier"
 ;
 N OID,UID,SECID,NPI,SSN,AOIUID,Y
 S OID=$G(XATR(2))
 S UID=$G(XATR(3))
 S SECID=$G(XATR(7))
 S NPI=$G(XATR(8))
 S SSN=$G(XATR(9))
 S Y=0
 ;
 I $G(SECID)'="" S Y=+$O(^VA(200,"ASECID",$E(SECID,1,30),Y)) I Y S XATR("DUZ",Y,"ASECID")=$E(SECID,1,30)
 I $G(NPI)'="" S Y=+$O(^VA(200,"ANPI",NPI,0)) I Y S XATR("DUZ",Y,"NPI")=NPI
 I $G(SSN)'="" S Y=+$O(^VA(200,"SSN",SSN,0)) I Y S XATR("DUZ",Y,"SSN")=SSN
 I $G(OID)'="",($G(UID)'="") S Y=+$$AOIUID^XUESSO2(OID,UID) I Y S XATR("DUZ",Y,"OIDUID")=OID_"_"_UID
 ;
 ;
 ;multiple users found in vista
 I $O(XATR("DUZ",+$O(XATR("DUZ",0)))) D  S XUIAMDUZ=-1_"^Possible Duplicate Users" Q XUIAMDUZ
 .W !!,"Warning: Multiple users exist in the local VistA instance with the"
 .W !?9,"above traits.  Please log a Help Desk Ticket and provide the"
 .W !?9,"following information to resolve."
 .S XUCNT=0
 .S XUIAMDUZ="" F  S XUIAMDUZ=$O(XATR("DUZ",XUIAMDUZ)) Q:'XUIAMDUZ  S XUCNT=XUCNT+1 D
 ..W !!,XUCNT,".",?3,"Name: ",$$GET1^DIQ(200,XUIAMDUZ_",",.01,"E"),?42,"DISUSER: ",$$GET1^DIQ(200,XUIAMDUZ_",",7,"E"),?57,"Term Date: ",$$GET1^DIQ(200,XUIAMDUZ_",",9.2,"E")
 ..W !?3,"DUZ: ",XUIAMDUZ
 ..S XUATTRTYPE="" F  S XUATTRTYPE=$O(XATR("DUZ",XUIAMDUZ,XUATTRTYPE)) Q:XUATTRTYPE=""  D
 ...W !?3,$S(XUATTRTYPE="ASECID":"SECID",XUATTRTYPE="NPI":"NPI",XUATTRTYPE="SSN":"SSN",XUATTRTYPE="OIDUID":"OID_UID",1:""),": ",$P(XATR("DUZ",XUIAMDUZ,XUATTRTYPE),"^",1)
 ;
 ;
 ;one user found in vista
 I $O(XATR("DUZ",0)) S XUIAMDUZ=+$O(XATR("DUZ",0)) D  I XUIAMDUZ<0 Q XUIAMDUZ
 .I $G(SOURCEID),(XUIAMDUZ'=SOURCEID) D  S XUIAMDUZ=-1_"^Multiple DUZ Issue" Q
 ..W !!,"Warning: The DUZ of the user at the local VistA instance does not match"
 ..W !?9,"the DUZ of the user at the Enterprise.  Please log a Help Desk"
 ..W !?9,"Ticket and provide the following information to resolve."
 ..W !!,"Local VistA User:"
 ..W !,?3,"Name: ",$$GET1^DIQ(200,XUIAMDUZ_",",.01,"E"),?42,"DISUSER: ",$$GET1^DIQ(200,XUIAMDUZ_",",7,"E"),?57,"Term Date: ",$$GET1^DIQ(200,XUIAMDUZ_",",9.2,"E")
 ..W !?3,"DUZ: ",XUIAMDUZ
 ..W !!,"Local VistA User (using DUZ found at Enterprise):"
 ..W !,?3,"Name: ",$$GET1^DIQ(200,SOURCEID_",",.01,"E"),?42,"DISUSER: ",$$GET1^DIQ(200,SOURCEID_",",7,"E"),?57,"Term Date: ",$$GET1^DIQ(200,SOURCEID_",",9.2,"E")
 ..W !?3,"DUZ: ",SOURCEID
 .;
 .W !!,"... user is already known to VistA.",!!,"... updating VistA with traits from Enterprise."
 .N XUIAMNPF S XUIAMNPF=1 ;**663 - STORY 1203246 (dri) don't set 'AVIAM' x-ref, only edits outside of this process should appear in NEW PERSON FIELD MONITOR File (#8933.1)
 .S ERRMSG=$$UPDU^XUESSO2(.XATR,XUIAMDUZ) ;update local vista fields if differences
 .S:(+$G(DUZ)&('+ERRMSG)) ^DISV(DUZ,"^VA(200,")=XUIAMDUZ  ;IA #859 (Allow for Space-Bar functionality if record updated by valid user)
 ;
 ;
 ;user isn't known to vista and needs added
 I '$O(XATR("DUZ",0)) D
 .W !!,"... adding user to VistA."
 .N XUIAMNPF S XUIAMNPF=1 ;**663 - STORY 1203246 (dri) don't set 'AVIAM' x-ref when new person is initially added, only edits outside of this process should appear in NEW PERSON FIELD MONITOR File (#8933.1)
 .S XUIAMDUZ=$$ADDUSER^XUESSO2(.XATR) ;add person to vista
 .I +XUIAMDUZ<0 D  W !
 ..W !!,"... problem adding user to VistA, please log a service ticket for assistance."
 ..I $P(XUIAMDUZ,"^",2)'="" W !?4,$P(XUIAMDUZ,"^",2) ;error message
 .I +XUIAMDUZ'=-1 S XUIAMDUZ=+XUIAMDUZ_"^"_NAME_"^1" ;simulate Fileman return of 'y' with "ien^value of .01^new entry just added"
 ;
 ;
 ;we have a duz, update the enterprise with this site/duz
 I XUIAMDUZ>0 D
 .;reset "vistaid" to be the newly created vistaid, example format: 112233^PN^463^USDVA
 .S XURET(CNT,"vistaid")=+XUIAMDUZ_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA"
 .;
 .S XURET(CNT,"WHO")=DUZ_"^PN^"_$P($$SITE^VASITE(),"^",3)_"^USDVA" ;added by
 .I $G(XUTERMDT)'="" S XURET(CNT,"termDate")=$$FMTHL7^XLFDT(XUTERMDT) ;optional termination date when doing batch entry
 .S XURET(CNT,"REQTYPE")=XUREQTYP ;passing 'add' or 'modify' to ^xuiamxml
 .;
 .K XUIAM M XUIAM=XURET(CNT) K XURET ;merge traits back to unsubscripted value to pass to psim
 .W !!,"... updating Enterprise with traits from VistA.",!
 .D SNDUSER^XUIAMXML(.XURET,.XUIAM) ;add person to the enterprise, at this point an error returned in xuret is handled by psim
 ;
 Q XUIAMDUZ
 ;
