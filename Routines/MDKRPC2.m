MDKRPC2 ; HOIFO/DP - RPC Calls (Cont.) ;11/27/07  09:42
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ;
 ; Reference IA #1625 [Supported] Use routine XUA4A72
 ;              #10060 [Supported] FILE 200 references
 ;              #10112 [Supported] VASITE calls
 ;              #10090 [Supported] Institution File (#4) Read w/FM
 ;              #2263 [Supported] XPAR calls
 ;              #4440 [Supported] XUPROD calls
 ;              #3065 [Supported] XLFNAME calls
 ;              #4815 [Controlled] GMVDCSAV call
 ;              #4866 [Private] File 120.51
 ;              #4867 [Private] File 120.5
 ;              #4868 [Private] - VA(200,"AUSER"
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6,P7,P8,P9) ; Generic RPC tag
 S RESULTS=$NA(^TMP($J,"MDKRPC2")) K @RESULTS
 D @OPTION
 S:'$D(@RESULTS) @RESULTS@(0)="-1^No Results"
 Q
 ;
ACTIVE ; Return all active dialysis treatments
 N MDAS,MDFLD,MDLP,MDLIST,MDMORE K ^TMP("MDAS",$J)
 F MDLP=1,2 S MDLIST=0 F  S MDLIST=$O(^MDK(704.202,"AS",MDLP,MDLIST)) Q:MDLIST<1  S ^TMP("MDAS",$J,MDLIST)=""
 S MDMORE=".03;;STUDY_CHECKIN^.05;;USER_ID^.06;;DATETIME_ACCESSED^.07;;WORKSTATION_ID"
 D BLDFLD^MDXMLFM(.MDFLD,704.202,".01;I;STUDY_ID^.02;I;PATIENT_ID^.02:.01;;PATIENT_NAME^.02:.09;;PATIENT_SSN^.09;E;STATUS^.02:.02;I;PATIENT_SEX^.02:.03;I;PATIENT_DOB;DATE^.02:.033;;PATIENT_AGE^.04;;STUDY_LOCATION^"_MDMORE)
 D LOADALL^MDXMLFM($NA(^TMP("MDAS",$J)),704.202,.MDFLD)
 K ^TMP("MDAS",$J)
 Q
 ;
ALLBYPT ; Return all treatments for a patient
 N MDFLD
 D BLDFLD^MDXMLFM(.MDFLD,704.202,".01;I;STUDY_ID^.02;I;PATIENT_ID^.03;I;STUDY_DATETIME^.09;I;STATUS")
 D LOADALL^MDXMLFM($NA(^MDK(704.202,"C",+P1)),704.202,.MDFLD)
 Q
 ;
ALLRSLT ; Get all available results for a study
 ;
 ; If P2=1 then whole list is forced, otherwise, only Unmatched
 ;
 N MDFLD,MDFDA,MDLIST
 D BLDFLD^MDXMLFM(.MDFLD,703.1,".001;;ID^.05;;STUDY_ID")
 ;D:'$G(P3) LOADALL^MDXMLFM($NA(^MDD(703.1,"ASTUDYID",+P1)),703.1,.MDFLD)
 ;
 ; Remove the P3 reference once it's working!
 ;
 ; Prepare the lists
 S MDLIST=$NA(^TMP("MDTEMP",$J)) K @MDLIST
 S MDFDA=$NA(^TMP("MDFDA",$J)) K @MDFDA
 ; Scan results by study id
 F X=0:0 S X=$O(^MDD(703.1,"ASTUDYID",+P1,X)) Q:'X  D
 .Q:$P(^MDD(703.1,X,0),U,9)="P"  ; Skip pendings being filed now
 .Q:'$G(P2)&($P(^MDD(703.1,X,0),U,9)="M")  ; Only new results requested
 .S ^TMP("MDTEMP",$J,X)=""  ; Add this study to the list
 D LOADALL^MDXMLFM(.MDLIST,703.1,.MDFLD)
 Q
 ;
CCOW ; Return CCOW site and production indicator
 S @RESULTS@(0)=$P($$SITE^VASITE(),"^",3)_"^"_$$PROD^XUPROD()
 Q
 ;
GETRSLT ; Get instrument XML Result
 I '$D(^MDD(703.1,P1,.4)) S @RESULTS@(0)="0" Q
 M @RESULTS=^MDD(703.1,P1,.4)
 S @RESULTS@(0)=+$O(^MDD(703.1,P1,.4,""),-1)
 ; Set to matched
 N MDFDA S MDFDA(703.1,P1_",",.09)="M" D FILE^DIE("","MDFDA")
 Q
 ;
GETXML ; Get a single XML field
 S X=$$GET1^DIQ(P1,P2,P3,,RESULTS)
 Q
 ;
SETXML ; Set a single XML field
 S @RESULTS@(0)=$$XMLFILER(P1,P2,P3,"P4")
 Q
 ;
UPDUSER ; Update User Access Information
 Q:$G(P1)=""
 Q:$G(P2)=""
 Q:$G(P3)=""
 N MDFDA S P1=P1_","
 S:+P2 MDFDA(704.202,P1,.05)=P2
 S:P3'="" MDFDA(704.202,P1,.06)=P3
 S:P4'="" MDFDA(704.202,P1,.07)=P4
 S:+P5 MDFDA(704.202,P1,.09)=P5
 D FILE^DIE("","MDFDA")
 K MDFDA
 S @RESULTS@(0)="1^Information Filed"
 ;
GETOPT ; Get option from the Parameters File
 ;
 ; P1=Setting Name
 ; P2=Owner
 ;
 N MDOPT
 S MDOPT=$$FIND1^DIC(704.209,,"X",P1,"B","I $P(^(0),U,2)=P2")
 I MDOPT<0 S @RESULTS@(0)="-1^No such setting" Q
 S X=$$GET1^DIQ(704.209,MDOPT_",",.1,,RESULTS)
 Q
 ;
LOCKOPT ; Lock/Unlock an option for update
 ;
 ; P1=Setting Name
 ; P2=0:Unlock;1:Lock
 ;
 N MDOPT
 S MDOPT=$$FIND1^DIC(704.209,,"X",P1,"B","I $P(^(0),U,2)=.5")
 I 'MDOPT S @RESULTS@(0)="-1^No such setting." Q
 I 'P2 D  Q
 .L -(^MDK(704.209,+MDOPT,0)) S @RESULTS@(0)="1^Option Unlocked"
 .N MDFDA
 .S MDFDA(704.209,+MDOPT_",",.03)=""
 .S MDFDA(704.209,+MDOPT_",",.04)=""
 .S MDFDA(704.209,+MDOPT_",",.05)=""
 .D FILE^DIE("","MDFDA")
 .Q
 I +P2 L +(^MDK(704.209,+MDOPT,0)):0 I '$T S @RESULTS@(0)="-1^Unable to lock"_"^"_$P($G(^MDK(704.209,+MDOPT,0)),"^",3,5) Q
 N MDFDA D NOW^%DTC
 S MDFDA(704.209,+MDOPT_",",.03)=DUZ
 S MDFDA(704.209,+MDOPT_",",.04)=%
 S MDFDA(704.209,+MDOPT_",",.05)=$J
 D FILE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Option locked"
 Q
 ;
DELOPT ; Delete option from the RENAL SETTING file(#704.209)
 ;
 ; P1=Setting Name
 ; P2=Owner
 ;
 N DA,DIK,MDOPT
 S MDOPT=$$FIND1^DIC(704.209,,"X",P1,"B","I $P(^(0),U,2)=P2")
 I 'MDOPT S @RESULTS@(0)="1^No such setting." Q
 S DA=MDOPT,DIK="^MDK(704.209," D ^DIK
 S @RESULTS@(0)="1^Setting deleted."
 Q
 ;
SETOPT ; Set option into RENAL SETTING file (#704.209)
 ;
 ; P1=Setting Name
 ; P2=Owner
 ; P3=Array of text
 ;
 N MDOPT
 S MDOPT=$$FIND1^DIC(704.209,,"X",P1,"B","I $P(^(0),U,2)=P2")
 D:'MDOPT  ; Try to create a new entry
 .N MDFDA,MDIEN
 .S MDFDA(704.209,"+1,",.01)=P1
 .S MDFDA(704.209,"+1,",.02)=P2
 .D UPDATE^DIE("","MDFDA","MDIEN")
 .S MDOPT=+$G(MDIEN(1),-1)
 I 'MDOPT S @RESULTS@(0)="-1^Unable to create entry" Q
 S @RESULTS@(0)=$$XMLFILER(704.209,MDOPT_",",.1,"P3")
 Q
 ;
ALLOPT ; Get all options by user
 N MDFLD
 D BLDFLD^MDXMLFM(.MDFLD,704.209,".001;;NUMBER^.01;;SETTING NAME")
 K ^TMP("DILIST",$J)
 D LIST^DIC(704.209,,"@;.01","P","*",,,"B","I $P(^(0),U,2)=P2")
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S ^TMP("DILIST",$J,"B",+^(X,0),X)=""
 D LOADALL^MDXMLFM($NA(^TMP("DILIST",$J,"B")),704.209,.MDFLD)
 Q
 ;
XMLFILER(DD,IENS,FLD,ROOT) ; This files UUEncoded XML into Fileman WP
 N MDFLAG,MDERR,MDL,MDXL ; Set to control appending
 K ^TMP("MDKXML",$J)
 S MDXL="",MDL=0
 F  S MDXL=$O(@ROOT@(MDXL)) Q:MDXL=""  S MDL=MDL+1,^TMP("MDKXML",$J,MDL)=@ROOT@(MDXL)
 S MDFLAG=$S(@ROOT@(0)["-- Begin UUEncoded Data --":"",1:"A")
 D WP^DIE(DD,IENS,FLD,MDFLAG,$NA(^TMP("MDKXML",$J)),"MDERR")
 I $D(MDERR) Q "-1^"_$G(MDERR("DIERR",1,"TEXT",1),"Unknown Error")
 Q "1^Filed"_"^"_MDL
 ;
GETPROV ; Get list of available providers with name starting with P1
 N MDFLD,MDDATE,MDDUP,MDRI,MDI1,MDI2,MDLAST,MDMAX,MDPREV,MDTTL,X,X1,X2
 D BLDFLD^MDXMLFM(.MDFLD,200,".001;;ID^.01;;PROV_NAME^8;;TITLE")
 S MDRI=0,MDMAX=44,(MDLAST,MDPREV)="",X1=DT,MDFROM=P1,X2=-30 D C^%DTC S MDDATE=DT K X
 S RESULTS=$NA(^TMP("MDPLIST",$J)) K @RESULTS K ^TMP("DILIST",$J)
 F  Q:MDRI'<MDMAX  S MDFROM=$O(^VA(200,"AUSER",MDFROM),1) Q:MDFROM=""  D
 .S MDI1=""
 .F  S MDI1=$O(^VA(200,"AUSER",MDFROM,MDI1),1) Q:'MDI1  D
 ..I MDDATE>0,$$GET^XUA4A72(MDI1,MDDATE)<1 Q    ; Check date?
 ..S MDDUP=0                            ; Init flag, check dupe.
 ..I ($P(MDPREV_" "," ")=$P(MDFROM_" "," ")) S MDDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'MDDUP D
 ...S MDI2=MDI1
 ...D TITLE                            ; Get Title. 
 ...S MDRI=MDRI+1,^TMP("DILIST",$J,MDRI)=MDI1_U_$$NAMEFMT^XLFNAME(MDFROM,"F","DcMPC")_$S(MDTTL'="":U_"- "_MDTTL,1:"")
 ;F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S ^TMP("DILIST",$J,"B",+^(X),X)=""
 D LOADALL^MDXMLFM1($NA(^TMP("DILIST",$J)),200,.MDFLD)
 Q
 ;
TITLE ; Retrieve Title or Title and Service/Section.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 S MDTTL=""                            ; Init each time.
 ; DBIA# 4329:
 S MDTTL=$P($G(^VA(200,MDI2,0)),U,9)         ; Get Title pointer.
 I MDTTL<1 S MDTTL=""                          ; Reset var if none.
 ; DBIA# 1234:
 I MDTTL>0 S MDTTL=$G(^DIC(3.1,MDTTL,0))       ; Actual Title value.
 Q
 ;
VITALS ; File a vitals sign
 S P3=$$FIND1^DIC(120.51,,"MX",P3)
 I P3<1 S @RESULTS@(0)="-1^Unknown Vital Type" Q
 S X=P1_U_P2_U_P3_";"_P4_U_P5_U_P6
 L +^GMR(120.5,0)
 D EN1^GMVDCSAV(.ZZZ,X)
 S @RESULTS@(0)=+$O(^GMR(120.5,"A"),-1)
 S @RESULTS@(1)=X
 L -^GMR(120.5,0)
 Q
 ;
GETINST ; Get list of Institutions with name starting with P1
 N MDFLD
 D BLDFLD^MDXMLFM(.MDFLD,4,".001;;STATION NUMBER^.01;;STATION NAME")
 K ^TMP("DILIST",$J)
 D FIND^DIC(4,,"@;.01","P",P1,"*")
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S ^TMP("DILIST",$J,"B",+^(X,0),X)=""
 D LOADALL^MDXMLFM($NA(^TMP("DILIST",$J,"B")),4,.MDFLD)
 Q
GETADM ; Get Administrators
 N MDFLD
 D BLDFLD^MDXMLFM(.MDFLD,200,".001;;NUMBER^.01;;NAME")
 K ^TMP("DILIST",$J)
 D FIND^DIC(200,,"@;.01","P",P1,"*")
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S ^TMP("DILIST",$J,"B",+^(X,0),X)=""
 D LOADALL^MDXMLFM($NA(^TMP("DILIST",$J,"B")),200,.MDFLD)
 Q
GUI ; Returns Hemodialysis version check
 ; Returns yes or no  
 S @RESULTS@(0)=$$GET^XPAR("SYS","MDK GUI VERSION",P1,"E")
 S:@RESULTS@(0)="" @RESULTS@(0)="NO"
 Q
CURRENT ; Current Version
 N MDKLST,MDK,MDKY,MDKY1 S @RESULTS@(0)=""
 D GETLST^XPAR(.MDKLST,"SYS","MDK GUI VERSION")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:MDK<1  S MDKY=$G(MDKLST(MDK)) D
 . S MDKY1=$P(MDKY,"^")
 . I $$GET^XPAR("SYS","MDK GUI VERSION",MDKY1,"I") S:@RESULTS@(0)="" @RESULTS@(0)=MDKY1
 . Q
 S:@RESULTS@(0)="" @RESULTS@(0)="No Current Version Recorded."
 Q
USERINF ; Current User Information
 N MDUSER
 S MDUSER(0)=DUZ
 S MDUSER(1)=$$GET1^DIQ(200,+MDUSER(0)_",",.01)
 S MDUSER(2)=MDUSER(1)
 S MDUSER(3)=""
 S MDUSER(4)=$$GET1^DIQ(200,+MDUSER(0)_",",8)
 S MDUSER(5)=$$GET1^DIQ(200,+MDUSER(0)_",",29)
 S MDUSER(6)=$$GET1^DIQ(200,+MDUSER(0)_",",200.07)
 S MDUSER(7)=$$GET1^DIQ(200,+MDUSER(0)_",",200.1)
 M @RESULTS=MDUSER K MDUSER
 Q
