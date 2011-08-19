GMVRPCM ; HOIFO/DP - RPC for Vitals Manager ;07/25/05 9:10am
 ;;5.0;GEN. MED. REC. - VITALS;**1,8,13,3,22**;Oct 31, 2002;Build 22
 ; Integration Agreements:
 ; #10040 [Supported] File 44 references
 ; #10076 [Supported] XUSEC Calls
 ; #2263 [Supported] XPAR Calls
 ; #2541 [Supported] XUPARAM Calls
 ; #2692 [Controlled] ORQPTQ1
 ; #3227 [Private] NURAPI Calls
 ; #4084 [Private] File 44 AC x-ref
 ; #4360 [Private] GMV MANAGER RPC
ADDQUAL ; [P] Add qualifier to vital/category
 S GMVVIT=+$P(DATA,";",1),GMVCAT=+$P(DATA,";",2),GMVQUAL=+$P(DATA,";",3)
 I $O(^GMRD(120.52,GMVQUAL,1,"B",GMVVIT,0)) D  Q
 .S @RESULTS@(0)="1^Qualifier already assigned."
 S GMVFDA(120.521,"+1,"_GMVQUAL_",",.01)=GMVVIT
 S GMVFDA(120.521,"+1,"_GMVQUAL_",",.02)=GMVCAT
 D UPDATE^DIE("","GMVFDA","GMVIEN","GMVERR")
 I $G(GMVIEN(1)) S @RESULTS@(0)=+GMVIEN(1)_"^Qualifier Assigned"
 E  S @RESULTS@(0)="-1^Unable to assign qualifier"
 Q
DELQUAL ; [P] Delete qualifier from vital/category
 S GMVVIT=+$P(DATA,";",1),GMVCAT=+$P(DATA,";",2),GMVQUAL=+$P(DATA,";",3)
 S X=$O(^GMRD(120.52,GMVQUAL,1,"B",GMVVIT,0))
 S GMVFDA(120.521,X_","_GMVQUAL_",",.01)="@"
 D FILE^DIE("","GMVFDA","GMVERR")
 I $D(GMVERR) S @RESULTS@(0)="-1^Unable to remove qualifier."
 E  S @RESULTS@(0)="1^Qualifier removed."
 Q
DELTEMP ; [P] Delete Template
 S GMVENT=$P(DATA,U,1),GMVNAME=$P(DATA,U,2)
 I $$GET^XPAR(GMVENT,"GMV TEMPLATE DEFAULT")=GMVNAME D
 .D DEL^XPAR(GMVENT,"GMV TEMPLATE DEFAULT",1)
 D DEL^XPAR(GMVENT,"GMV TEMPLATE",GMVNAME,.GMVERR)
 I '$G(GMVERR) S @RESULTS@(0)="1^Template Removed."
 E  S @RESULTS@(0)="-1^"_GMVERR
 Q
GETCATS ; [P] Return Listing of categories
 N GMVQI
 F GMVCAT=0:0 S GMVCAT=$O(^GMRD(120.52,"AA",DATA,GMVCAT)) Q:'GMVCAT  D
 .Q:$$ACTIVE^GMVUID(120.53,"",GMVCAT_",","")
 .S GMVQUAL="",X="" F  S X=$O(^GMRD(120.52,"AA",DATA,GMVCAT,X)) Q:X=""  D
 ..S GMVQI=$O(^GMRD(120.52,"AA",DATA,GMVCAT,X,0))
 ..Q:$$ACTIVE^GMVUID(120.52,"",GMVQI_",","")
 ..S GMVQUAL=GMVQUAL_$S(GMVQUAL]"":", ",1:"")_X
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=GMVCAT_U_$P(^GMRD(120.53,GMVCAT,0),U)_U_GMVQUAL
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_U_$P(^GMRD(120.51,DATA,0),U)
 Q
GETDATA ; [P] Generic fileman data call
 ; Variable DATA = File#^IENS^Field#
 S @RESULTS@(0)=$$GET1^DIQ($P(DATA,U,1),$P(DATA,U,2),$P(DATA,U,3))
 Q
GETDEF ; [P] Get Default Template
 I $G(DATA)]"" D  Q
 .S X=$$GET^XPAR($P(DATA,U),"GMV TEMPLATE DEFAULT")
 .I X="" S @RESULTS@(0)="-1^No Default Template"
 .E  S @RESULTS@(0)=X
 D ENVAL^XPAR(.GMV,"GMV TEMPLATE DEFAULT")
 S X="" F  S X=$O(GMV(X)) Q:X=""  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=X_U_GMV(X,1)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
GETHILO ; [P] Returns an abnormal value
 S @RESULTS@(0)=+$$GET1^DIQ(120.57,"1,",DATA)
 Q
GETLIST ; [P] Return listing of file
 K GMVCNT,GMVLOOP,GMVRET,^TMP("DILIST",$J)
 S GMVSCRN=""
 I +DATA=44 S DATA2=$P(DATA,U,2),DATA=+DATA
 I DATA=120.51 D  ; Set screen for vitals list
 .S GMVSCRN="I $$VITALIEN^GMVUTL8()[("",""_+Y_"","")"
 I DATA=42 D  ; Screen for ward location
 .S GMVSCRN="I '$$INACT42^GMVUT2(+Y)"
 I DATA=44 D  Q  ; Clinics
 .N CNT S X=DATA2,CNT=0
 .F  S X=$O(^SC("AC","C",X)) Q:'X!(CNT>100)  D
 ..Q:+$G(^SC(X,"OOS"))
 ..S Y=$G(^SC(X,"I"))
 ..I Y Q:DT>+Y&($P(Y,U,2)=""!(DT<$P(Y,U,2)))
 ..S @RESULTS@($O(@RESULTS@(""),-1)+1)=DATA_";"_X_U_$P(^SC(X,0),U),CNT=CNT+1
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 I DATA=100.21 D  Q  ; CPRS Teams
 .D TEAMS^ORQPTQ1(.GMVRET)
 .F X=0:0 S X=$O(GMVRET(X)) Q:'X  S @RESULTS@(X)=DATA_";"_GMVRET(X)
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 I DATA=211.4 D  Q  ; NURS Locations
 .D ACTLOCS^NURAPI(.GMVRET)
 .F X=0:0 S X=$O(GMVRET(X)) Q:'X  S @RESULTS@(X)=DATA_";"_GMVRET(X)
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 I DATA=120.52 D  S @RESULTS@(0)=GMVCNT_U_$$GET1^DID(DATA,"","","NAME") Q  ;qualifiers
 .S GMVCNT=0,GMVLOOP=""
 .F  S GMVLOOP=$O(^GMRD(120.52,"B",GMVLOOP)) Q:GMVLOOP=""  D
 ..S GMVIEN=0
 ..F  S GMVIEN=$O(^GMRD(120.52,"B",GMVLOOP,GMVIEN)) Q:'GMVIEN  D
 ...S GMVNAME=$P($G(^GMRD(120.52,GMVIEN,0)),U,1)
 ...Q:GMVNAME=""
 ...Q:$$ACTIVE^GMVUID(120.52,.01,GMVIEN_",","")  ;inactive vuid
 ...S GMVCNT=GMVCNT+1
 ...S @RESULTS@(GMVCNT)="120.52;"_GMVIEN_U_GMVNAME
 D LIST^DIC(DATA,"","@;.01","P","","","","",GMVSCRN)
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 .S @RESULTS@(X)=DATA_";"_^TMP("DILIST",$J,X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_U_$$GET1^DID(DATA,"","","NAME")
 K ^TMP("DILIST",$J)
 Q
GETQUAL ; [P] Return qualifiers list
 ; DATA=VitalIEN;CatIEN
 ; Uses X-ref of ^GMRD(120.52,"AA",VitalIEN,CategoryIEN,QName,QIEN)
 S GMVIT=+$P(DATA,";",1),GMVCAT=+$P(DATA,";",2)
 I '$D(^GMRD(120.53,GMVCAT,0)) S @RESULTS@(0)="-1^No such category" Q
 I $$ACTIVE^GMVUID(120.53,"",GMVCAT_",","") S @RESULTS@(0)="-1^Inactive category" Q
 I '$D(^GMRD(120.51,GMVIT,0)) S @RESULTS@(0)="-1^No such vital" Q
 I $$ACTIVE^GMVUID(120.51,"",GMVIT_",","") S @RESULTS@(0)="-1^Inactive vital type" Q
 S GMVNAM=""
 F  S GMVNAM=$O(^GMRD(120.52,"AA",GMVIT,GMVCAT,GMVNAM)) Q:GMVNAM=""  D
 .S GMVIEN=$O(^GMRD(120.52,"AA",GMVIT,GMVCAT,GMVNAM,0))  ; Assume only one of this name
 .Q:$$ACTIVE^GMVUID(120.52,"",GMVIEN_",","")
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=GMVIEN_U_GMVNAM
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_U_$P(^GMRD(120.53,GMVCAT,0),U)
 Q
GETTEMP ; [P] Get Template List
 I $G(DATA)]"" D
 .S GMVENT=$$ENTITY($P(DATA,U,1)),GMVNAME=$P(DATA,U,2)
 .I GMVNAME="" D
 ..D GETLST^XPAR(.GMVTMP,GMVENT,"GMV TEMPLATE")
 ..F X=0:0 S X=$O(GMVTMP(X)) Q:'X  D
 ...S GMV(GMVENT,$P(GMVTMP(X),U,1))=$P(GMVTMP(X),U,2,10)
 .I GMVNAME]"" S GMV(GMVENT,GMVNAME)=$$GET^XPAR(GMVENT,"GMV TEMPLATE",GMVNAME)
 I $G(DATA)="" D ENVAL^XPAR(.GMV,"GMV TEMPLATE")
 S GMVENT="",GMVNAME=""
 F  S GMVENT=$O(GMV(GMVENT)) Q:GMVENT=""  D
 .S GMVROOT=$P(GMVENT,";",2),GMVTYPE=$$TYPE(GMVROOT),GMVIEN=+GMVENT
 .Q:GMVTYPE=0  ;unknown template type
 .Q:GMVROOT="VA(200,"&('$$GET^XPAR("SYS","GMV ALLOW USER TEMPLATES"))
 .I GMVROOT="VA(200,"&(GMVIEN'=DUZ) Q:'$D(^XUSEC("GMV MANAGER",DUZ))
 .F  S GMVNAME=$O(GMV(GMVENT,GMVNAME)) Q:GMVNAME=""  D
 ..S GMVOWNER=$P($G(@(U_GMVROOT_(+GMVIEN)_",0)"),"Unk"),U)
 ..S Y=$O(@RESULTS@(""),-1)+1
 ..S @RESULTS@(Y)=GMVTYPE_U_GMVENT_U_GMVOWNER_U_GMVNAME_U_GMV(GMVENT,GMVNAME)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
LOOKUP ; [P] Does a lookup on a file
 N GMVSCRN
 S GMVSCRN=$S(+DATA=44:"I "_"""^C^W^"""_"[$P(^(0),U,3)",1:"")
 I $P(DATA,"^",3)="" S GMVFLD="@;.01"
 E  S GMVFLD="@;"_$P(DATA,"^",3)
 S GMVFLD=$P(GMVFLD,";",1,5) ; Limit lookup to 4 display fields
 D FIND^DIC(+DATA,"",GMVFLD,"P",$P(DATA,"^",2),61,,GMVSCRN)
 I ^TMP("DILIST",$J,0)<1 D  Q
 .S @RESULTS@(0)="-1^No entries found matching '"_$P(DATA,U,2)_"'."
 I ^TMP("DILIST",$J,0)>60 D  Q
 .S @RESULTS@(0)="-1^Too many matches found, please be more specific."
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 .S @RESULTS@(X)=+DATA_";"_^TMP("DILIST",$J,X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
NEWQUAL ; [P] Create New Qualifier
 S @RESULTS@(0)="-1^Use the New Term Rapid Turnaround (NTRT) process to add qualifiers"
 Q
NEWTEMP ; [P] New Template
 S GMVENT=$P(DATA,"^",1),GMVNAME=$P(DATA,"^",2),GMVDESC=$P(DATA,"^",3)
 S GMVENT=$$ENTITY(GMVENT)
 S GMVTYPE=$$TYPE($P(GMVENT,";",2))
 S GMVOWN=$P($G(@(U_$P(GMVENT,";",2)_+GMVENT_",0)"),"Unk"),U)
 S:GMVDESC="" GMVDESC="No Description"
 D ADD^XPAR(GMVENT,"GMV TEMPLATE",GMVNAME,GMVDESC,.GMVERR)
 I 'GMVERR S @RESULTS@(0)=GMVTYPE_U_GMVENT_U_GMVOWN_U_GMVNAME
 E  S @RESULTS@(0)="-1^"_GMVERR
 Q
RENTEMP ; [P] Rename a Template
 S GMVENT=$P(DATA,U,1),GMVOLD=$P(DATA,U,2),GMVNEW=$P(DATA,U,3)
 D REP^XPAR(GMVENT,"GMV TEMPLATE",GMVOLD,GMVNEW,.GMVERR)
 I 'GMVERR S @RESULTS@(0)="1^Renamed"
 E  S @RESULTS@(0)="-1^"_GMVERR Q
 ; Reset default template if this was a default template
 D:$$GET^XPAR(GMVENT,"GMV TEMPLATE DEFAULT")=GMVOLD
 .D EN^XPAR(GMVENT,"GMV TEMPLATE DEFAULT",1,GMVNEW)
 Q
RPC(RESULTS,OPTION,DATA) ; [Procedure] Main RPC call tag
 ; RPC: [GMV MANAGER]
 ;
 ; Input parameters
 ;  1. RESULTS [Reference/Required] RPC Return array
 ;  2. OPTION [Literal/Required] RPC Option to execute
 ;  3. DATA [Literal/Required] Other data as required for call
 ;
 N GMV,GMVCAT,GMVDESC,GMVENT,GMVERR,GMVFDA,GMVFLD,GMVIEN,GMVIT,GMVNAM,GMVNAME,GMVNEW,GMVOLD,GMVOWN,GMVOWNER,GMVQUAL,GMVROOT,GMVTYPE,GMVVAL,GMVVIT,GMVSCRN
 S RESULTS=$NA(^TMP("GMVMGR",$J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 S:'$D(@RESULTS) @RESULTS@(0)="-1^No results returned"
 D CLEAN^DILF
 Q
SETDATA ; [P] Save New Qualifier Name/Abbv
 S @RESULTS@(0)="-1^Use the New Term Rapid Turnaround (NTRT) process to add qualifiers"
 Q
SETDEF ; [P] Set Default Template
 D EN^XPAR($P(DATA,U),"GMV TEMPLATE DEFAULT",1,$P(DATA,U,2),.GMVERR)
 I '$G(GMVERR) S @RESULTS@(0)="1^Set As Default."
 E  S @RESULTS@(0)="-1^"_GMVERR
 Q
SETHILO ; [P] Set abnormal value
 L +(^GMRD(120.57,0)):5
 E  S @RESULTS@(0)="-1^Site File In Use." Q
 S GMVFLD=$P(DATA,"^",1),GMVVAL=$P(DATA,"^",2)
 S GMVFDA(120.57,"1,",GMVFLD)=GMVVAL
 D FILE^DIE("","GMVFDA","GMVERR")
 L -(^GMRD(120.57,0))
 S @RESULTS@(0)="1^Update Complete."
 Q
SETTEMP ; [P] Set Template data
 D EN^XPAR($P(DATA,U),"GMV TEMPLATE",$P(DATA,U,2),$P(DATA,U,3),.GMVERR)
 I '$G(GMVERR) S @RESULTS@(0)="1^Template Saved."
 E  S @RESULTS@(0)="-1^"_GMVERR
 Q
VALID ; [P] Verify data validity against fileman
 D VAL^DIE($P(DATA,U,1),$P(DATA,U,2),$P(DATA,U,3),"H",$P(DATA,U,4),.GMVRET)
 I GMVRET'="^" S @RESULTS@(0)="1^Valid Data"
 E  S @RESULTS@(0)="-1^"_^TMP("DIERR",$J,1,"TEXT",1)
 Q
ENTITY(X) ; [Function] Convert USR, SYS, and DIV entities
 ; Input parameters
 ;  1. X [Literal/Required] XPAR generic entity to transform to variable pointer format
 ;
 Q:X="USR" DUZ_";VA(200,"
 Q:X="SYS" $$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE"))_";DIC(4.2,"
 Q:X="DIV" DUZ(2)_";DIC(4,"
 Q X
 ;
TYPE(X) ; [F] Returns the type of template
 ; Input parameters
 ;  1. X [Literal/Required] Variable pointer to evaluate
 ;
 Q:X="DIC(4.2," 1 ;Domain
 Q:X="DIC(4," 2 ;  Institution
 Q:X="SC(" 3 ;     Hospital Location
 Q:X="VA(200," 4 ; New Person
 Q 0 ;             Unknown
 ;
VT ;VitalTypeIENS
 N X,Y,Z
 S Y=0,@RESULTS@(0)="-1"
 F X="T","P","R","BP","HT","WT","PN","PO2","CVP","CG" D
 .S Z=$O(^GMRD(120.51,"C",X,0))
 .Q:'Z
 .S Y=Y+1,@RESULTS@(Y)=Z
 Q
