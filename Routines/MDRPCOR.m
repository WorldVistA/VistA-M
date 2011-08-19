MDRPCOR ; HOIFO/DP - Object RPCs (TMDRecordId) ; [01-10-2003 09:14]
 ;;1.0;CLINICAL PROCEDURES;**17,20**;Apr 01, 2004;Build 9
 ; Description:
 ; This routine manages both the MDVCL components and
 ; the TMDRecordID object
 ;
 ; Integration Agreements:
 ; IA# 2054 [Supported] Call to DILF
 ; IA# 2055 [Supported] Call to DILFD
 ; IA# 2056 [Supported] Call to DIQ
 ; IA# 2263 [Supported] Call to XPAR
 ; IA# 3568 [Subscription] TIUCP call
 ; IA# 3266 [Subscription] Calls to DPTLK1
 ; IA# 3267 [Subscription] Call to DPTLK1
 ; IA# 10003 [Supported] Call to %DT
 ; IA# 10104 [Public] Call to XLFSTR
 ;
CHANGES ; [Procedure] Returns number of changes to save
 S MDCHNG=0,(MDDD,MDIENS)=""
 F  S MDDD=$O(^TMP("MDFDA",$J,MDDD)) Q:MDDD=""  D
 .Q:$E(MDDD,1,$L(DD))'=DD  ; Not even the right DD
 .F  S MDIENS=$O(^TMP("MDFDA",$J,MDDD,MDIENS)) Q:MDIENS=""  D
 ..Q:$E(MDIENS,$L(MDIENS)-$L(IENS)+1,$L(MDIENS))'=IENS
 ..F FLD=0:0 S FLD=$O(^TMP("MDFDA",$J,MDDD,MDIENS,FLD)) Q:'FLD  D
 ...S MDCHNG=MDCHNG+1
 S @RESULTS@(0)=MDCHNG_"^Changes to Save"
 Q
 ;
CHKVER ; [Procedure] 
 S @RESULTS@(0)=+$G(DATA)'<1
 Q
 ;
CLEARFDA ; [Procedure] Discards changes in the FDA
 S MDFDA=$NA(^TMP("MDFDA",$J))
 F  S MDFDA=$Q(@MDFDA) Q:MDFDA=""  Q:$QS(MDFDA,2)'=$J  D
 .S MDDD=$QS(MDFDA,3),MDIENS=$QS(MDFDA,4)
 .I MDIENS'?@(".E1"""_IENS_"""") Q
 .I MDDD'?@("1"""_DD_""".E") Q
 .K ^TMP("MDFDA",$J,MDDD,MDIENS)
 S @RESULTS@(0)="1^FDA CLEARED"
 Q
 ;
DELREC ; [Procedure] Delete a fileman record
 D VAL^DIE(DD,IENS,.01,"FR","@",.MDRET,"MDDEL","MDERR")
 I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 D FILE^DIE("","MDDEL","MDERR")
 I $D(MDERR) D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 D RPC(.X,"CLEARFDA",DD,IENS)
 S @RESULTS@(0)="1^Record Deleted"
 Q
 ;
DT ; [Procedure] Convert date/time via %DT
 S DATA=$G(DATA,"NOW^TS")
 S X=$P(DATA,U,1),%DT=$P(DATA,U,2)
 D ^%DT
 I Y<1 S @RESULTS@(0)=Y_U_"Invalid date/time input '"_X_"'"
 E  S @RESULTS@(0)=1_U_Y D DD^%DT S $P(@RESULTS@(0),U,3)=Y
 Q
 ;
EXISTS ; [Procedure] Verify that a record exists
 S X=$$ROOT^DILFD(DD,IENS)
 S @RESULTS@(0)=$D(@(X_(+IENS)_",0)"))
 Q
 ;
FILENAME ; [Procedure] Return a filename
 I $$VFILE^DILFD(DD) S @RESULTS@(0)="1^"_$$GET1^DID(DD,"","","NAME")
 E  S @RESULTS@(0)="-1^Not a valid file #"
 Q
 ;
GETCODES ; [Procedure] Returns set of codes
 S MDTYPE=$$GET1^DID(DD,FLD,"","TYPE","","MDERR")
 I $D(MDERR) D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 D:MDTYPE="SET"
 .S MDSET=$$GET1^DID(DD,FLD,"","POINTER")
 .F X=1:1:$L(MDSET,";")-1 D
 ..S @RESULTS@(X)=$P(MDSET,";",X)
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_"^Set of Codes"
 D:MDTYPE="POINTER"
 .S MDPTR=$$GET1^DID(DD,FLD,"","POINTER")
 .F X=0:0 S X=$O(@(U_MDPTR_"X)")) Q:'X  D
 ..S Y=$O(@RESULTS@(""),-1)+1
 ..S @RESULTS@(Y)="`"_X_":"_$P(@(U_MDPTR_"X,0)"),U,1)
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_"^Pointers as set of codes"
 Q
 ;
GETDATA ; [Procedure] Returns data for a field
 I $$GET1^DID(DD,FLD,"","TYPE")["WORD" D  Q
 .I $D(^TMP("MDFDA",$J,DD,IENS,FLD)) M ^TMP($J)=^TMP("MDFDA",$J,DD,IENS,FLD)
 .E  S X=$$GET1^DIQ(DD,IENS,FLD,"",$NA(^TMP($J)))
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 I $$GET1^DID(DD,FLD,"","TYPE")["POINTER"&(DD=703.1)&(FLD=.05) D  Q
 .S @RESULTS@(0)=$$GET1^DIQ(DD,IENS,FLD,"I") Q
 I $D(^TMP("MDFDA",$J,DD,IENS,FLD)) S Y=^(FLD) D  Q
 .I $G(DATA) S @RESULTS@(0)=Y Q  ; Internal Format
 .S @RESULTS@(0)=$$EXTERNAL^DILFD(DD,FLD,"",Y)
 S @RESULTS@(0)=$$GET1^DIQ(DD,IENS,FLD,$S($G(DATA):"I",1:""))
 Q
 ;
GETHELP ; [Procedure] Returns fileman help
 D HELP^DIE(DD,IENS,FLD,"D")
 D:'$O(^TMP("DIHELP",$J,0)) HELP^DIE(DD,IENS,FLD,"A")
 I '$O(^TMP("DIHELP",$J,0)) D  Q
 .S @RESULTS@(0)=1
 .S @RESULTS@(1)="SORRY: No help available"
 M ^TMP($J)=^TMP("DIHELP",$J)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
GETIDS ; [Procedure] Returns list of required ID's
 D FILE^DID(DD,"","REQUIRED IDENTIFIERS;NAME;ENTRIES","MDRET")
 S X=$NA(MDRET("REQUIRED IDENTIFIERS",0))
 F  S X=$Q(@X) Q:X=""  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=@X_U_$$GET1^DID(DD,@X,"","LABEL")_U_$$GET1^DID(DD,@X,"","TYPE")
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)_U_MDRET("NAME")_U_MDRET("ENTRIES")
 Q
 ;
GETLABEL ; [Procedure] Get field label/title
 S MDLBL=$$GET1^DID(DD,FLD,"",$S($G(DATA):"TITLE",1:"LABEL"))
 S:$G(DATA)&(MDLBL="") MDLBL=$$GET1^DID(DD,FLD,"","LABEL")
 S @RESULTS@(0)=MDLBL_":"
 Q
 ;
GETLST ; [Procedure] Get list of records
 S IENS=$G(IENS),FLD=$G(FLD,"@;.01")
 S:$P(FLD,";",1)'="@" FLD="@;"_FLD
 D LIST^DIC(DD,IENS,FLD,"P",,,,,$G(DATA))
 F X=0:0 S X=$O(^TMP("DILIST",$J,X))  Q:'X  D
 .S @RESULTS@(X)=DD_";"_^TMP("DILIST",$J,X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 F X=2:1 Q:$P(^TMP("DILIST",$J,0,"MAP"),U,X)=""  D
 .S @RESULTS@(0)=@RESULTS@(0)_U_$$GET1^DID(DD,$P(^TMP("DILIST",$J,0,"MAP"),U,X),"","LABEL")
 Q
 ;
LOCK ; [Procedure] Lock a record
 D LOCK^MDRPCU(.RESULTS,DD,IENS) Q
 ;
LOOKUP ; [Procedure] Lookup on a DD
 I DD=2 D RPC(.RESULTS,"PTLKUP",DD,,,DATA) Q
 D FIND^DIC(DD,IENS,.01,"P",DATA)
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 .S @RESULTS@(X)=DD_";"_$P(^TMP("DILIST",$J,X,0),U,1,2)
 I '$D(^TMP($J)) S @RESULTS@(0)="-1^No entries found matching '"_DATA_"'"
 E  S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
NEWIEN ; [Procedure] Return next available IEN
 S @RESULTS@(0)=$O(@($$ROOT^DILFD(DD,$G(IENS))_"""A"")"),-1)+1
 Q
 ;
NEWREC ; [Procedure] Create a new record
 I $G(DATA)]"" D  Q:MDRET="^"
 .D VAL^DIE(DD,"+1,"_IENS,$P(DATA,U,1),"F",$P(DATA,U,2,250),.MDRET,"MDNEW","MDERR")
 .I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR)
 S MDTMP="DATA"
 F  S MDTMP=$Q(@MDTMP) Q:MDTMP=""  D  Q:MDRET="^"
 .D VAL^DIE(DD,"+1,"_IENS,$P(@MDTMP,U,1),"F",$P(@MDTMP,U,2,250),.MDRET,"MDNEW","MDERR")
 .I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR)
 D:$D(MDNEW) UPDATE^DIE("","MDNEW","MDIEN")
 S @RESULTS@(0)=$G(MDIEN(1),"-1^Unable to create record")
 Q
 ;
PTLKUP ; [Procedure] Patient lookup handled separately for security
 D FIND^DIC(2,,"@;.01;.02;.03;.09","MP",DATA,45,"B^BS^BS5^SSN")
 I $P($G(^TMP("DILIST",$J,0)),U,3) D  Q
 .S @RESULTS@(0)="-1^Too many entries found matching '"_DATA_"', please be more specific."
 F MDX=0:0 S MDX=$O(^TMP("DILIST",$J,MDX)) Q:'MDX  D
 .S @RESULTS@(MDX)="2;"_$P(^TMP("DILIST",$J,MDX,0),U,1,5)
 .S MDIENS=+^TMP("DILIST",$J,MDX,0)_","
 .S $P(@RESULTS@(MDX),U,3)=$$GET1^DIQ(2,MDIENS,.02,"I")
 .S $P(@RESULTS@(MDX),U,4)=$$GET1^DIQ(2,MDIENS,.03,"I")
 .S $P(@RESULTS@(MDX),U,10)=$$DOB^DPTLK1(+MDIENS)
 .S $P(@RESULTS@(MDX),U,11)=$$SSN^DPTLK1(+MDIENS)
 I '$D(^TMP($J)) S @RESULTS@(0)="-1^No entries found matching '"_DATA_"'"
 E  S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
PTRLKUP ; [Procedure] Lookup a pointer field
 S PTRDD=+$P($$GET1^DID(DD,FLD,"","SPECIFIER"),"P",2)
 I PTRDD=8925.1 D  Q  ; Handle TIU Note lookup with TIU API
 .S DATA=$$UP^XLFSTR(DATA)
 .D LNGCP^TIUCP(.MDRET,DATA)
 .I '$O(MDRET(0)) S @RESULTS@(0)=0 Q
 .I $D(MDRET(44)),$P($P(MDRET(44),U,2),DATA)="" S @RESULTS@(0)=0 Q
 .F X=0:0 S X=$O(MDRET(X)) Q:'X  D:$P($P(MDRET(X),U,2),DATA)=""
 ..S @RESULTS@(X)="8925.1;"_MDRET(X)
 .S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 D FIND^DIC(PTRDD,"","","PM",DATA,151,"",$G(PTRSCRN))
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  D
 .S @RESULTS@(X)=PTRDD_";"_^TMP("DILIST",$J,X,0)
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
RENAME ; [Procedure] Rename a record
 I DATA=""!(DATA="@") S @RESULTS@(0)="-1^Deletion Not Supported" Q
 I $$DUPS^MDRPCU(DD,+IENS,DATA) D  Q
 .S @RESULTS@(0)="-1",@RESULTS@(1)="Duplicates not allowed"
 D VAL^DIE(DD,IENS,.01,"EFHR",DATA,.MDRET,"MDRENAME","MDERR")
 I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 D FILE^DIE("","MDRENAME")
 S @RESULTS@(0)="1^"_MDRET(0)
 K ^TMP("MDFDA",$J,DD,IENS,.01) ; In case of editing
 Q
 ;
RPC(RESULTS,OPTION,DD,IENS,FLD,DATA) ; [Procedure] RPC call tag
 NEW MDCHNG,MDDD,MDDEL,MDERR,MDFDA,MDGBL,MDIENS,MDIEN,MDLBL,MDNEW,MDPTR,MDRENAME,MDRET,MDSET,MDTYPE,MDUTL,PTRDD,PTRSCRN
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDRECORDID","MDRPCOR",OPTION)
 D CLEAN^DILF
 Q
 ;
SAVEFDA ; [Procedure] Save changes to the VistA database
 K ^TMP("MDSAVE",$J)
 S MDFDA=$NA(^TMP("MDFDA",$J))
 F  S MDFDA=$Q(@MDFDA) Q:MDFDA=""  Q:$QS(MDFDA,2)'=$J  D
 .S MDDD=$QS(MDFDA,3),MDIENS=$QS(MDFDA,4)
 .I MDIENS'?@(".E1"""_IENS_"""") Q
 .I MDDD'?@("1"""_DD_""".E") Q
 .M ^TMP("MDSAVE",$J,MDDD,MDIENS)=^TMP("MDFDA",$J,MDDD,MDIENS)
 .K ^TMP("MDFDA",$J,MDDD,MDIENS)
 I '$D(^TMP("MDSAVE",$J)) S @RESULTS@(0)="1^No changes to save" Q
 D:IENS?1"+1,".NP  ; New record
 .D UPDATE^DIE("",$NA(^TMP("MDSAVE",$J)),"MDIEN","MDERR")
 .I '$D(MDERR) S @RESULTS@(0)="1^New Record Created^"_MDIEN(1) Q
 .D ERROR^MDRPCU($NA(^TMP($J)),.MDERR)
 .M ^TMP("MDFDA",$J)=^TMP("MDSAVE",$J)
 D:IENS'?1"+1,".NP  ; Existing record
 .D FILE^DIE("",$NA(^TMP("MDSAVE",$J)),"MDERR")
 .I '$D(MDERR) S @RESULTS@(0)="1^FDA Saved" Q
 .D ERROR^MDRPCU($NA(^TMP($J)),.MDERR)
 .M ^TMP("MDFDA",$J)=^TMP("MDSAVE",$J)
 K ^TMP("MDSAVE",$J)
 I DD<702!(DD>703.1999) D  Q
 .S @RESULTS@(0)="-1^Non CLINICAL PROCEDURES DD number space"
 I DD=702.09&(+$$GET^XPAR("SYS","MD DEVICE SURVEY TRANSMISSION",1)) D COL^MDDEVCL
 Q
 ;
SETFDA ; [Procedure] Validate data and store in FDA
 D VAL^DIE(DD,IENS,FLD,"F",.DATA,.MDRET,$NA(^TMP("MDFDA",$J)),"MDERR")
 I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 S @RESULTS@(0)="1^FDA Set"
 Q
 ;
UNLOCK ; [Procedure] Unlock a record
 D UNLOCK^MDRPCU(.RESULTS,DD,IENS) Q
 ;
VALIDATE ; [Procedure] Validate data for a field
 I ($G(DATA)="@"!($G(DATA)=""))&(FLD=.01) D  Q
 .S @RESULTS@(0)="-1^Record Deletion Not Allowed Here."
 I FLD=.01 I $$DUPS^MDRPCU(DD,+IENS,DATA) D  Q
 .S @RESULTS@(0)="-1",@RESULTS@(1)="Duplicates not allowed"
 S:$G(DATA)="@" DATA=""
 I $$GET1^DID(DD,FLD,"","TYPE")["WORD" D  Q
 .S MDGBL=$NA(^TMP("MDFDA",$J,DD,IENS,FLD))
 .K @MDGBL
 .I $O(DATA(""))="" S @MDGBL="@",@RESULTS@(0)="1^OK" Q
 .I $O(DATA(""),-1)=1&($G(DATA(1)))="" S @MDGBL="@",@RESULTS@(0)="1^OK" Q
 .S X=""  F  S X=$O(DATA(X)) Q:X=""  D
 ..S Y=$O(@MDGBL@(""""),-1)+1
 ..S @MDGBL@(Y)=DATA(X)
 .S @MDGBL=$NA(^TMP("MDSAVE",$J,DD,IENS,FLD))
 .S RESULTS(0)="1^WP"
 D VAL^DIE(DD,IENS,FLD,"EF",$G(DATA),.MDRET,$NA(^TMP("MDFDA",$J)),"MDERR")
 I MDRET="^" D ERROR^MDRPCU($NA(^TMP($J)),.MDERR) Q
 S @RESULTS@(0)="1^"_MDRET(0)
 Q
 ;
