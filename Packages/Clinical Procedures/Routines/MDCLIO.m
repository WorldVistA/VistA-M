MDCLIO ;HINES OIFO/DP - CliO backend driver;02 Feb 2005
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 3027       - PTSEC^DGSEC4                 Registration                   (supported)
 ;  # 2701       - $$GETICN^MPIF001             Master Patient Index VistA     (supported)
 ;  #10112       - $$SITE^VASITE() call         Registration                   (supported)
 ;  #10070       - ^XMD call                    MailMan                        (supported)
 ;  # 2263       - $$GET^XPAR                   Toolkit                        (supported)
 ;  # 2263       - GETWP^XPAR                   Toolkit                        (supported)
 ;  # 4440       - $$PROD^XUPROD call           Kernel                         (supported)
 ;  #10076       - access ^XUSEC(               Kernel                         (supported)
 ;  #1381        - GMRV VITAL MEASUREMENT       Vitals                         (controlled subscription)
 ;
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6,P7,P8,P9) ; Generic RPC tag
 N MD,MDD,MDCMD,MDIEN,MDERR,MDIENS,MDFLD,MDFLAG,MDOBS,MDVUID,MDRET,MDLIST,MDTMP,MDVAL,MDRTN,MDQRY,MDIDX,MDCACHED,MDNAME,MDCMT,MDROOT,MDXROOT
 K ^TMP("MDCLIO",$J) ; Default scratch space for all calls
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 I '($T(@OPTION)]"") S @RESULTS@(0)="-1^Option '"_OPTION_"' not found in routine "_$T(+0)_"." Q
 D @OPTION
 I '$D(@RESULTS) S @RESULTS@(0)="-1^Unspecified Error"
 K ^TMP("MDCLIO",$J) ; Default scratch space for where clauses
 Q
 ;
EXECUTE ; Executes the command in P1
 D GETWP^XPAR(.MDCMD,"SYS","MD COMMANDS",P1,.MDERR)
 S MDNAME=P1,Y=MDCMD(1,0),MDCMD=$P(Y,";",1),MDFILE=$P(Y,";",2),MDRTN=$P(Y,";",3),MDROOT=$P(Y,";",4),MDWHERE=$P(Y,";",5),MDIDX=$P(Y,";",6)
 S MDCACHED=$P(Y,";",7)&($$GET^XPAR("SYS","MD PARAMETERS","ALLOW_CACHED_QUERIES")=1)&('$D(P2))
 D FLDS(.MDCMD)
 I MDRTN="" S MDRTN=MDCMD ; Custom routine to perform the whole command
 I MDWHERE]"" D @MDWHERE ; Custom where clause
 D @MDRTN
 K MDWHERE
 Q
 ;
FLDS(MDTXT) ; Builds MDFLD() from a command wp-text
 F Y=1:0 S Y=$O(MDTXT(Y)) Q:'Y  D
 .S X=MDTXT(Y,0)
 .I $E(X,1)=";" Q
 .I $E(X,1)="@" D FLDS($E($P(X,";",1),2,250)) Q  ; Warning, recursion is an evil thing :)
 .S MDFLD(+$O(MDFLD(""),-1)+1)=X
 Q
 ;
IENLIST ; Builds MDROOT from P2(0..n) as IEN list
 S MDROOT=$NA(^TMP("MDCLIO",$J)) K @MDROOT
 S MDIEN=""
 F  S MDIEN=$O(P2(MDIEN)) Q:MDIEN=""  S @MDROOT@(P2(MDIEN))=""
 Q
 ;
IMPORT ; Import a record for the TDBConnection_Vista object
 N MDFILE,MDIENS,MDX,MDVAL,MDFDA,MDRET
 S MDFILE=$$TABLE(P1),MDIENS=P2
 F MDX=0:2 Q:'$D(P3(MDX))  D
 .S MDFLD=$$FLDNUM^DILFD(MDFILE,P3(MDX))
 .D VAL^DIE(MDFILE,MDIENS,MDFLD,"FU",$G(P3(MDX+1)),.MDVAL,"MDFDA","MDRET") Q:'$D(MDRET)
 S X="MDFDA" F  S X=$Q(@X) Q:X=""  D
 .S Y=$O(@RESULTS@(99999,""),-1)+1
 .S @RESULTS@(99999,Y)=X_"="_@X
 D:MDIENS?1"+1," UPDATE^DIE("K","MDFDA",,"MDERR")
 D:MDIENS'?1"+1," FILE^DIE("K","MDFDA","MDERR")
 I '$D(MDERR) S @RESULTS@(0)="WOO HOO, IT'S FILED!" Q
 S @RESULTS@(0)="OH POOP",X="MDERR"
 F  S X=$Q(@X) Q:X=""  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=X_"="_@X
 Q
 ;
GETIEN ; Returns the ien of a record for generic updates **pk only**
 N MDVAL F X=0:1 Q:'$D(P2(X))  S MDVAL(X+1)=P2(X)
 S @RESULTS@(0)=+$$FIND1^DIC($$TABLE(P1),,"KXP",.MDVAL)
 Q
 ;
QUERY ; Executes a standard query
 N MDXTMP S MDXTMP="MDCACHE_"_MDNAME
 I MDCACHED,$D(^XTMP(MDXTMP)) L +(^XTMP(MDXTMP)):5 I $T D  Q  ; Returning the cached copy
 .M @RESULTS=^XTMP(MDXTMP,1)
 .L -(^XTMP(MDXTMP))  ; Later Gater!
 D NEWDOC("RESULTS")
 I $$ROOT^DILFD(MDFILE,"",1)=MDROOT D  D ENDDOC("RESULTS") Q
 .I '$D(P2(0))!($G(P2(0))="*") D  Q  ; Load whole file
 ..F MDREC=0:0 S MDREC=$O(@MDROOT@(MDREC)) Q:'MDREC  D XMLREC(MDFILE,MDREC)
 .S MDVAL=$G(P2(0)) F X=0:1 Q:'$D(P2(X))  D
 ..I P2(X)?4N1"-"2N1"-"2N1" "2N1":"2N1":"2N S P2(X)=$$FMDT(P2(X))
 ..S MDVAL(X+1)=P2(X)
 .D FIND^DIC(MDFILE,"","@","KP",.MDVAL,"*",MDIDX) Q:'$O(^TMP("DILIST",$J,0))
 .F MDREC=0:0 S MDREC=$O(^TMP("DILIST",$J,MDREC)) Q:'MDREC  D XMLREC(MDFILE,+^(MDREC,0))
 S MDROOT=$NA(@MDROOT),MDIDX=$$OREF^DILF(MDROOT)
 F  S MDROOT=$Q(@MDROOT) Q:MDROOT=""  Q:$P(MDROOT,MDIDX,1)'=""  D
 .S MDREC=$QS(MDROOT,$QL(MDROOT)) D XMLREC(MDFILE,MDREC)
 D ENDDOC("RESULTS")
 K MDREC
 Q
 ;
STPROC ; Place holder for no routine entered into a stored procedure type
 D NEWDOC("RESULTS")
 D XMLADD("NO PROCEDURE SPECIFIED")
 D ENDDOC("RESULTS")
 Q
 ;
ROLES ; Temporary Role Based Query
 D NEWDOC("RESULTS","USER ROLES")
 S X="A" F  S X=$O(^XUSEC(X)) Q:X=""  D:$D(^XUSEC(X,DUZ))
 .D XMLHDR("RECORD"),XMLDATA("ROLE_ID",X),XMLFTR("RECORD")
 D ENDDOC("RESULTS")
 Q
 ;
XQUERY ; Runs the standard query after a pre-process routine has prepared the entries into @MDXROOT@(ien...)
 D NEWDOC("RESULTS","FILEMAN FILE #"_MDFILE_" "_MDCMT)
 F MD=0:0 S MD=$O(@MDXROOT@(MD)) Q:'MD  D XMLREC(MDFILE,@MDXROOT@(MD))
 K @MDXROOT
 D ENDDOC("RESULTS")
 Q
 ;
INSERT ; Performs an insert
 K MDERR
 F Y=0:0 S Y=$O(MDFLD(Y)) Q:'Y  D
 .Q:$G(P2(Y-1))=""
 .I $P(MDFLD(Y),";",4)["DATE" S @$$FDA(MDFILE)@($P(MDFLD(Y),";"))=$$FMDT(P2(Y-1)) Q
 .I $P(MDFLD(Y),";",3)="I"!($G(P2(Y-1))="") S @$$FDA(MDFILE)@($P(MDFLD(Y),";"))=$G(P2(Y-1)) Q  ; RPC Broker sends 0..n array
 .D CHK^DIE(MDFILE,$P(MDFLD(Y),";"),"",$G(P2(Y-1)),.MDVAL,"MDERR")
 .I MDVAL="^" M @RESULTS@(Y)=MDERR("DIERR",1,"TEXT") K MDERR,MDVAL Q
 .S @$$FDA(MDFILE)@($P(MDFLD(Y),";"))=MDVAL
 I $O(@RESULTS@(0)) S @RESULTS@(0)="-1^Errors found validating data" Q
 D UPDATE^DIE("",$$FDA(),,"MDERR")
 I $D(MDERR) D  Q
 .F Y=0:0 S Y=$O(MDERR("DIERR",Y)) Q:'Y  M @RESULTS@(Y)=MDERR("DIERR",Y,"TEXT")
 .S @RESULTS@(0)="-1^Insert Error"
 S @RESULTS@(0)="1^Insert complete"
 Q
 ;
UPDATE ; Performs an update
 ; Must find an EXACT match - Need to re-evaluate later for an update where like SQL statement
 S MDIEN=$$FIND1^DIC(MDFILE,,"KXP",P2(0))
 I MDIEN'>0 S @RESULTS@(0)="-1^No such record '"_P2(0)_"'" Q
 F Y=0:0 S Y=$O(MDFLD(Y)) Q:'Y  D
 .I $G(P2(Y))="" S @$$FDA(MDFILE,MDIEN)@($P(MDFLD(Y),";"))="" Q
 .I $P(MDFLD(Y),";",4)["DATE" S @$$FDA(MDFILE,MDIEN)@($P(MDFLD(Y),";"))=$$FMDT(P2(Y)) Q
 .I $P(MDFLD(Y),";",3)="I" S @$$FDA(MDFILE,MDIEN)@($P(MDFLD(Y),";"))=P2(Y) Q  ; Notice P2 offset matches here
 .K MDERR,MDHELP,MDVAL D VAL^DIE(MDFILE,MDIEN,$P(MDFLD(Y),";"),"",P2(Y),.MDVAL,"","MDERR")
 .I MDVAL="^" M @RESULTS@(Y)=MDERR("DIERR",1,"TEXT") Q
 .S @$$FDA(MDFILE,MDIEN)@($P(MDFLD(Y),";"))=MDVAL ; Set the internal value for filing !!!
 I $O(@RESULTS@(0)) S @RESULTS@(0)="-1^Errors found validating data" Q
 K MDERR D FILE^DIE("K",$$FDA(),"MDERR")
 I $O(MDERR(""))]"" M @RESULTS@(1)=MDERR S @RESULTS@(0)="-1^Error" Q
 S @RESULTS@(0)="1^Update complete!"
 Q
 ;
DELETE ; Performs standard Delete command
 ; Will find records like the update but can return multiple entries
 S X="" F  S X=$O(P2(X)) Q:X=""  S MDVAL($O(MDVAL(""),-1)+1)=P2(X)
 D FIND^DIC(MDFILE,"","@;.01","PK",.MDVAL,"*",MDIDX)
 I '$O(^TMP("DILIST",$J,0)) S @RESULTS@(0)="1^No records found to delete" Q
 F X=0:0 S X=$O(^TMP("DILIST",$J,X)) Q:'X  S MDIEN=+^(X,0),@$$FDA(MDFILE,MDIEN)@(.01)="@"
 D FILE^DIE("",$$FDA(),"MDERR")
 I $O(MDERR(""))]"" M @RESULTS@(1)=MDERR S @RESULTS@(0)="-1^Error" Q
 S @RESULTS@(0)="1^Records successfully deleted."
 Q
 ;
DELALL ; Used to purge entire file ** XML Import calls ONLY!!!! **
 S MDROOT=$$ROOT^DILFD(MDFILE,"",1)
 F X=0:0 S X=$O(@MDROOT@(X)) Q:'X  S @$$FDA(MDFILE,X)@(.01)="@"
 D:$D(@$$FDA()) FILE^DIE("",$$FDA(),"MDERR")
 I $O(MDERR(""))]"" M @RESULTS@(1)=MDERR S @RESULTS@(0)="-1^Error" Q
 S @RESULTS@(0)="1^Records successfully deleted."
 Q
 ;
XMLREC(DD,IEN) ; Builds an XML Record based on DD, IEN & values in MDFLD(1..n)
 N MD,MDIENS,MDTAG,MDFMT,MDTYP,X,Y
 D XMLHDR("RECORD")
 S MDIENS=+IEN_","
 F MD=0:0 S MD=$O(MDFLD(MD)) Q:'MD  D
 .S MDFLD=$P(MDFLD(MD),";",1)
 .S MDTAG=$P(MDFLD(MD),";",2)
 .S MDFMT=$P(MDFLD(MD),";",3)
 .S MDTYP=$P(MDFLD(MD),";",4)
 .I MDFLD?1"$$".E D @("XMLDATA(MDTAG,"_MDFLD_")") Q
 .I MDFLD?1"D ".E X MDFLD Q
 .I MDTYP["DATE" S Y=$$GET1^DIQ(DD,MDIENS,MDFLD,"I") D:Y]"" XMLDT(MDTAG,Y) Q
 .D XMLDATA(MDTAG,$$GET1^DIQ(DD,MDIENS,MDFLD,MDFMT))
 D XMLFTR("RECORD")
 Q
 ;
SETACL ; Sets the ACL for an Item
 ; P2(0)=Item
 ; P2(1)=User ID (DUZ)
 ; P2(2)=Access Level
 N MDIEN,MDFDA
 S MDIEN=$O(^MDC(704.001,"PK",P2(0),P2(1),0))
 D:'MDIEN
 .S MDFDA(704.001,"+1,",.01)=P2(0)
 .S MDFDA(704.001,"+1,",.02)=P2(1)
 .S MDIEN="+1"
 S MDFDA(704.001,MDIEN_",",.03)=$G(P2(2),0)
 D UPDATE^DIE("","MDFDA")
 S @RESULTS@(0)="1^ACL Updated."
 Q
 ;
DELACL ; Removes and item from ACL
 ; P2(0)=Item
 ; P2(1)=User ID (DUZ) - if blank or undefined deletes all record for P2(0)
 N MDIEN,MDFDA,MDUSER
 D:$G(P2(1))]""
 .S MDIEN=$O(^MDC(704.001,"PK",P2(0),P2(1),0))
 .D:MDIEN
 ..S MDFDA(704.001,MDIEN_",",.01)="@"
 D:$G(P2(1))=""
 .S MDUSER=""
 .F  S MDUSER=$O(^MDC(704.001,"PK",P2(0),MDUSER)) Q:MDUSER=""  D
 ..S MDIEN=$O(^MDC(704.001,"PK",P2(0),MDUSER,0))
 ..S MDFDA(704.001,MDIEN_",",.01)="@"
 D:$D(MDFDA) UPDATE^DIE("","MDFDA")
 S @RESULTS@(0)="1^ACL Updated."
 Q
 ;
SENDMAIL ; Sends an EMail Message
 ; Example of the P2(0..n) array
 ; P2(0)="SUB:Message Subject"
 ; P2(1)="TEXT:THIS IS LINE 1"
 ; P2(2)="TEXT:THIS IS LINE 2"
 ; P2(3)="TO:user.one@va.gov;user.two@va.gov"
 N MDTO,MDTEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ="Clinical Procedure Notification System"
 S XMTEXT="MDTEXT("
 S X="" F  S X=$O(P2(X)) Q:X=""  D
 .I P2(X)?1"SUB:".E S XMSUB=$P(P2(X),":",2,250) Q
 .I P2(X)?1"TO:".E D  Q
 ..S MDTO=$P(P2(X),"TO:",2,250) ; We can store recipient lists as ';' delimited strings - Just like Outlook :)
 ..I MDTO]"" F Y=1:1:$L(MDTO,";") S XMY($P(MDTO,";",Y))=""
 .I P2(X)?1"TEXT:".E D  Q
 ..S Y=$O(MDTEXT(""),-1)+1,MDTEXT(Y,0)=$P(P2(X),"TEXT:",2,250)
 S MDTEXT(0)="^^"_$O(MDTEXT(""),-1)_U_DT
 D ^XMD
 S @RESULTS@(0)="1^E-Mail Sent"
 Q
 ;
 ; Special extrinsic field calls
ID() Q "`"_IEN
ROWID() Q IEN
ICN() Q:MDFILE'=2 ""  Q $$GETICN^MPIF001(IEN)
NAME() Q $$GET1^DIQ(MDFILE,IEN,.01,"E")
SNSTV() N MDRET D PTSEC^DGSEC4(.MDRET,IEN) Q ($G(MDRET(1))'=0)
CCOW() S X="patient.id.mrn.dfn_"_$P($$SITE^VASITE(),U,3) S:'$$PROD^XUPROD() X=X_"_test" Q X  ; IUser.getCCOWDFNItemName
VITALSID() Q "{GMRV-"_IEN_"}"
VSTATUS() Q $S(+$$GET1^DIQ(120.5,IEN_",",2,"I"):4,1:1)
 ;
XMLCMT(COMMENT) ; Add a comment to a document
 D XMLADD("<!-- "_COMMENT_" -->")
 Q
 ;
XMLHDR(TAG) ; Add a header tag to the global
 S TAG=$$TAGSAFE(TAG)
 D XMLADD("<"_TAG_">")
 Q
 ;
XMLFTR(TAG) ; Add a footer tag to the global
 D XMLHDR("/"_TAG)
 Q
 ;
XMLDATA(TAG,X) ; Add a data element to the global
 S TAG=$$TAGSAFE(TAG)
 S X=$$XMLSAFE(X)
 Q:X=""
 D XMLADD("<"_TAG_">"_X_"</"_TAG_">")
 Q
 ;
XMLFLDS(FLDLST,DD,FLDS) ; Build FLDS into an array of FLDS
 K FLDLST
 F X=1:1:$L(FLDS,";") D
 .S FLDLST($P(FLDS,";",X),"TAG")=$$GET1^DID(DD,$P(FLDS,";",X),"","LABEL")
 .S FLDLST($P(FLDS,";",X),"TYPE")=$$GET1^DID(DD,$P(FLDS,";",X),"","TYPE")
 Q
 ;
XMLDT(TAG,X) ; Add date or date/time to the global
 S TAG=$$TAGSAFE(TAG)
 I $G(X)="" D XMLADD("<"_TAG_" />") Q  ; No data
 S Y=(1700+$E(X,1,3))_"-"_$E(X,4,5)_"-"_$E(X,6,7)
 D:X]"."
 .S X=X+.0000001
 .S Y=Y_" "_$E(X,9,10)_":"_$E(X,11,12)_":"_$E(X,13,14)
 D XMLDATA(TAG,Y)
 Q
 ;
XMLIDS(TAG,IDS,CLOSE) ; Add a data element to the global with ids
 N X,Y
 S TAG="<"_$$TAGSAFE(TAG)
 F X=0:0 S X=$O(IDS(X)) Q:'X  D
 .S Y="" F  S Y=$O(IDS(X,Y)) Q:Y=""  D
 ..S TAG=TAG_" "_Y_"="""_$$XMLSAFE(IDS(X,Y))_""""
 S:$G(CLOSE) TAG=TAG_" /" ; Close out the tag element
 S TAG=TAG_">"
 D XMLADD(TAG)
 Q
 ;
XMLADD(X) ; Add to the global
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=$G(X)
 Q
 ;
XMLSAFE(X) ; Transform X into XML safe data
 ; Strip off the spaces and make life easier
 D STRIP(.X)
 S X=$$TRNSLT(X,"&","&amp;")
 S X=$$TRNSLT(X,"<","&lt;")
 S X=$$TRNSLT(X,">","&gt;")
 S X=$$TRNSLT(X,"'","&apos;")
 S X=$$TRNSLT(X,"""","&quot;")
 S X=$$TRNSLT(X,":","&#58;")
 Q X
 ;
TAGSAFE(X) ; Transform X into XML tag
 S:X?1N.E X="_"_X  ; Remove starting numeric
 Q $TR(X," '`()<>*[]","__________")
 ;
STRIP(X) ; Strip off leading and trailing spaces
 F  Q:$E(X)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 Q
 ;
NEWDOC(ROOT,COMMENT) ; Start a new document
 K @RESULTS
 D XMLADD("<?xml version=""1.0"" standalone=""yes""?>")
 D XMLCMT("OPTION = "_$G(OPTION,"NULL"))
 I $G(COMMENT)]"" D XMLCMT(COMMENT)
 D XMLCMT("P1 = "_$G(P1,"NULL"))
 I $D(P2)#2 D XMLCMT("P2 = "_P2)
 S X="" F  S X=$O(P2(X)) Q:X=""  D XMLCMT("P2("_X_") = "_P2(X))
 D XMLHDR($G(ROOT,"RESULTS"))
 Q
 ;
ENDDOC(ROOT) ; End this document
 D XMLFTR($G(ROOT,"RESULTS"))
 Q
 ;
QUICKDOC(TAG,VALUE) ; Builds a single record, single field document
 D NEWDOC()
 D XMLHDR("RECORD")
 D XMLDATA(TAG,VALUE)
 D XMLFTR("RECORD")
 D ENDDOC()
 Q
 ;
SRVRDT ; Returns Server Date/Time
 D QUICKDOC("SERVER_DATE_TIME",$$NOW)
 Q
 ;
TRNSLT(X,X1,X2) ; Translate every Y to Z in X
 N Y
 Q:X'[X1 X  ; Nothing to translate
 S Y="" F  Q:X=""  D
 .I X[X1 S Y=Y_$P(X,X1)_X2,X=$P(X,X1,2,250) Q
 .S Y=Y_X,X=""
 Q Y
 ;
 ; Extrinsic Functions
 ;
FDA(DD,IEN) ; Construct a standard FDA
 ; Returns ^TMP("MDCLIO",$J,{DD},{IEN:+1})
 Q $S($G(DD):$NA(^TMP("MDCLIO",$J,DD,$G(IEN,"+1")_",")),1:$NA(^TMP("MDCLIO",$J)))
 ;
SQLDATE(X) ; Returns SQL standard XML Date/Time string from FM
 S X=X+.0000001
 Q ($E(X,1,3)+1700)_"-"_$E(X,4,5)_"-"_$E(X,6,7)_" "_$E(X,9,10)_":"_$E(X,11,12)_":"_$E(X,13,14)
 ;
FMDT(X) ; Returns FM standard date/time from SQL style
 N Y S Y=X
 S X=($E(X,1,4)-1700)_$E(X,6,7)_$E(X,9,10)_"."_$E(X,12,13)_$E(X,15,16)_$E(X,18,19)
 Q +X
 ;
NOW() ; Returns Date/Time
 D NOW^%DTC
 Q $$SQLDATE(%)
 ;
TABLE(X) ; Return file number from the name
 Q $$FIND1^DIC(1,,"KXP",X)
 ;
