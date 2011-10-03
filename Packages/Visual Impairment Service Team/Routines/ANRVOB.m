ANRVOB ; HOIFO/CED - Supports VIST GUI OUTCOMES ; [01-07-2003 12:20]
 ;;4.0;VISUAL IMPAIRMENT SERVICE TEAM;**5**;JUN 03, 2002
ADDTXT(RESULTS,SUBREC,TOPREC,STATUS,OTCTXT) ; [Procedure] Uploads section text
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. SUBREC [Literal/Required] No description
 ;  3. TOPREC [Literal/Required] No description
 ;  4. STATUS [Literal/Required] No description
 ;  5. OTCTXT [Literal/Required] No description
 ;
 N UPSTAT
 K ^TMP("OTC",$J)
 M ^TMP("OTC",$J,"OTCTXT")=OTCTXT
 D WP^DIE(2048.01,SUBREC_","_TOPREC_",",1,"K",$NA(^TMP("OTC",$J,"OTCTXT")))
 S ^ANRV(2048,TOPREC,1,SUBREC,0)=SUBREC_U_STATUS ; update status
 I $DATA(DIERR) S RESULTS(0)="-1^"_DIERR
 E  S RESULTS(0)="1^Section Updated"
 K ^TMP("OTC",$J)
 Q
 ;
GETREC(RESULTS,PTDFN) ; [Procedure] Get top record and sub records
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. PTDFN [Literal/Required] No description
 ;
 N X,Y,IEN,IDATE,DATE,TIME,STATUS,TYPE,S1,S1STAT,S2,S2STAT,S3,S3STAT,S4,S4STAT,S5,S5STAT,S6,S6STAT
 K ^TMP($J)
 I '$D(^ANRV(2048,"B",PTDFN)) S RESULTS(0)="^0^No Outcome's On Record" Q
 F IEN=0:0 S IEN=$O(^ANRV(2048,"B",PTDFN,IEN)) Q:'IEN  D
 .S IDATE=$P($G(^ANRV(2048,IEN,0)),U,2,2) ;internal date
 .S STATUS=$P($G(^ANRV(2048,IEN,0)),U,3,3) ;status(incomplete,complete,partial)
 .S TYPE=$P($G(^ANRV(2048,IEN,0)),U,4,4) ;type(Pre or Post)
 .S TIME=$E(IDATE,9,10)_":"_$E(IDATE,11,12) ;time top record created
 .S:TIME=":" TIME="00:00" ;put it in readable format for user
 .S Y=IDATE X ^DD("DD") S DATE=Y ;convertinator
 .S S1=$P($G(^ANRV(2048,IEN,1,1,0)),U,1) ;section 1
 .S S1STAT=$P($G(^ANRV(2048,IEN,1,1,0)),U,2) ;section 1 status
 .S S2=$P($G(^ANRV(2048,IEN,1,2,0)),U,1) ;section 2
 .S S2STAT=$P($G(^ANRV(2048,IEN,1,2,0)),U,2) ;section 2 status
 .S S3=$P($G(^ANRV(2048,IEN,1,3,0)),U,1) ;section 3
 .S S3STAT=$P($G(^ANRV(2048,IEN,1,3,0)),U,2) ;section 3 status
 .S S4=$P($G(^ANRV(2048,IEN,1,4,0)),U,1) ;section 4
 .S S4STAT=$P($G(^ANRV(2048,IEN,1,4,0)),U,2) ;section 4 status
 .S S5=$P($G(^ANRV(2048,IEN,1,5,0)),U,1) ;section 5
 .S S5STAT=$P($G(^ANRV(2048,IEN,1,5,0)),U,2) ;section 5 status
 .S S6=$P($G(^ANRV(2048,IEN,1,6,0)),U,1) ;section 6
 .S S6STAT=$P($G(^ANRV(2048,IEN,1,6,0)),U,2) ;section 6 status
 .S RESULTS(IEN)=1_U_IEN_U_IDATE_U_DATE_U_STATUS_U_TYPE_U_S1_U_S1STAT_U_S2_U_S2STAT_U_S3_U_S3STAT_U_S4_U_S4STAT_U_S5_U_S5STAT_U_S6_U_S6STAT
 I $DATA(DIERR) S @RESULTS@(0)="-1^"_DIERR
 Q
 ;
GETSEC(RESULTS,RECORD) ; [Procedure] Get Outcome Section
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. RECORD [Literal/Required] No description
 ;
 D GETS^DIQ(2048,+RECORD,".01;.02","","RESULTS","DIERR")
 I $DATA(DIERR) S @RESULTS@(0)="-1^["_DIERR_"]"
 Q
 ;
GETTXT(RESULTS,SUBREC,TOPREC) ; [Procedure] Gets the Outcome Text
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. SUBREC [Literal/Required] No description
 ;  3. TOPREC [Literal/Required] No description
 ;
 S RESULTS=$$GET1^DIQ(2048.01,SUBREC_","_TOPREC_",",1,"","RESULTS")
 Q
 ;
MKREC(RESULTS,PTDFN,STATUS,TYPE) ; [Procedure] Creates Outcome record
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. PTDFN [Literal/Required] No description
 ;  3. STATUS [Literal/Required] No description
 ;  4. TYPE [Literal/Required] No description
 ;
 K ^TMP($J)
 N X,Y,I,NEWREC,NOW,NEWIEN,ERR
 D NOW^%DTC S NOW=%
 S NEWREC(2048,"+1,",.01)=PTDFN ; patient ien
 S NEWREC(2048,"+1,",.02)=NOW ; date and time
 S NEWREC(2048,"+1,",.03)=STATUS ; I=inpatient, O=outpatient, Z=other
 S NEWREC(2048,"+1,",.04)=TYPE ; R=Pre or O=Post Outcome
 D UPDATE^DIE("","NEWREC","NEWIEN")
 S ^ANRV(2048,NEWIEN(1),1,0)="^2048.01,.01P^^"
 F X=0:0 S X=$O(^ANRV(2048.1,X)) Q:'X  D
 .S ^ANRV(2048,NEWIEN(1),1,X,0)=X
 .S ^ANRV(2048,NEWIEN(1),1,"B",X,X)=""
 S RESULTS(0)="1"_U_NEWIEN(1)
 I $DATA(DIERR) S RESULTS(0)="-1^"_U_DIERR
 Q
 ;
RPC(RESULTS,OPTION,DATA) ; [Procedure] Main RPC Entry.
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. OPTION [Literal/Required] No description
 ;  3. DATA [Literal/Required] No description
 ;
 S RESULTS=$NA(^TMP("ANRVUSER",$J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 S:'$D(@RESULTS) @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF
 Q
 ;
SNDTXT(RESULTS,ANRVCMD,DATA) ; [Procedure] Send completed Outcome
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. ANRVCMD [Literal/Required] No description
 ;  3. DATA [Literal/Required] No description
 ;
 S RESULTS=$NA(^TMP($J)),^TMP($J,0)="-1^Unknown Error"
 D:ANRVCMD="CREATE"
 .K ^TMP("ANRVMAIL",$J)
 .S ^TMP($J,0)="1^Message '"_$J_"' created."
 D:ANRVCMD="APPEND"
 .D:$G(DATA)]""
 ..S Y=$O(^TMP("ANRVMAIL",$J,"TEXT",""),-1)+1
 ..S ^TMP("ANRVMAIL",$J,"TEXT",Y,0)=DATA
 .S X="DATA"
 .F  S X=$Q(@X) Q:X=""  D
 ..S Y=$O(^TMP("ANRVMAIL",$J,"TEXT",""),-1)+1
 ..S ^TMP("ANRVMAIL",$J,"TEXT",Y,0)=@X
 .S Y=+$O(^TMP("ANRVMAIL",$J,"TEXT",""),-1)
 .S ^TMP("ANRVMAIL",$J,"TEXT",0)="^^"_Y
 .S ^TMP($J,0)="1^Text appended."
 D:ANRVCMD="SUBJECT"
 .S ^TMP("ANRVMAIL",$J,"SUBJECT")=DATA
 .S ^TMP($J,0)="1^Message subject set to '"_DATA_"'"
 D:ANRVCMD="SENDTO"
 .D:$G(DATA)]""
 ..S Y=$O(^TMP("ANRVMAIL",$J,"SENDTO",""),-1)+1
 ..S ^TMP("ANRVMAIL",$J,"SENDTO",Y)=DATA
 .S X="DATA"
 .F  S X=$Q(@X) Q:X=""  D
 ..S Y=$O(^TMP("ANRVMAIL",$J,"SENDTO",""),-1)+1
 ..S ^TMP("ANRVMAIL",$J,"SENDTO",Y)=@X
 .S ^TMP($J,0)="1^Recipients Added."
 D:ANRVCMD="EXECUTE"
 .S XMSUB=$G(^TMP("ANRVMAIL",$J,"SUBJECT"),"No subject")
 .S XMTEXT="^TMP(""ANRVMAIL"",$J,""TEXT"","
 .F X=0:0 S X=$O(^TMP("ANRVMAIL",$J,"SENDTO",X)) Q:'X  D
 ..S XMY(^(X))=""
 .D ^XMD
 .S ^TMP($J,0)="1^Message Sent.  ID:  "_+$G(XMZ)
 Q
 ;
UPREC(RESULTS,TOPREC,STATUS) ; [Procedure] Update Top Record Status
 ; Input parameters
 ;  1. RESULTS [Literal/Required] No description
 ;  2. TOPREC [Literal/Required] No description
 ;  3. STATUS [Literal/Required] No description
 ;
 N MYFDA
 S MYFDA(2048,TOPREC_",",.03)=STATUS
 D FILE^DIE("","MYFDA")
 I $DATA(DIERR) S RESULTS="-1^"_DIERR
 E  S RESULTS="1^SECTION UPDATED"
 Q
 ;
ADD(X) ; [Function] Adds data to @Results@
 ; Input parameters
 ;  1. X [Literal/Required] No description
 ;
 S @RESULTS@(+$O(@RESULTS@(""),-1)+1)=X
 Q
 ;
