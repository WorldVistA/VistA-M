TIUCCRHL7P2 ; CCRA/PB - TIUHL7 Msg Processing; March 23, 2005
 ;;1.0;TEXT INTEGRATION UTILITIES;**337,348,349,352,354**;Jun 20, 1997;Build 24
 ; Reference to CMT^GMRCGUIB in ICR #2980
 ; Reference to SETCOM^GMRCGUIB, SETDA^GMRCGUIB in ICR #7223
 ; Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ; Reference to ^GMR(123 supported by DBIA #7342 
 ; Reference to ^GMR(123 supported by DBA #3983
 ;
 ;PB - Patch 348 modification to parse the note text from NTE segments rather than the OBX segment
 ;PB - Patch 349 modification to parse and file the consult factor from the note and file as a comment with the consult
 ;PB - Patch 352 modifications to set field 1205 in file 8925 to the value in field 2 in file 123 for the consult
 ;PB - Patch 354 modifications to keep the status of the consult after the note/addendum is filed whether the note/addendum
 ;     originates in CPRS or in HSRM.  
 Q
CONTINUE ; data verification
 ;
 ; DOCUMENT TEXT
 N STOP,TIUI,TIUIF
 S (TIUIF,STOP)=0
 D
 . I '$D(TIUZ("TEXT")) S MSGTEXT="Missing DOCUMENT TEXT.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,VNUM,MSGTEXT),ANAK^TIUCCHL7UT(MSGID,MSGTEXT,VNUM)
 . Q:$G(STOP)=1
 . ;S TIUTMP=0 F  S TIUTMP=$O(TIUZ("TEXT",TIUTMP)) Q:'TIUTMP  I $G(TIUZ("TEXT",TIUTMP,0))="" S TIUIF=1
 . ;I +$G(TIUIF)=1 S MSGTEXT="Missing DOCUMENT TEXT.",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,VNUM,MSGTEXT),ANAK^TIUCCHL7UT(MSGID,MSGTEXT,VNUM)
 Q:$G(STOP)=1
 ;
 ; DOCUMENT TITLE
 I +TIU("TDA")'>0 S MSGTEXT="Could not resolve the document title "_TIU("TITLE"),STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,VNUM,MSGTEXT),ANAK^TIUCCHL7UT(MSGID,MSGTEXT,VNUM) Q
 I +$$GET1^DIQ(8925.1,TIU("TDA"),.07,"I")'=11 S MSGTEXT="The document title "_TIU("TITLE")_" must be ACTIVE before use",STOP=1 D MESSAGE^TIUCCRHL7P3(MSGID,VNUM,MSGTEXT),ANAK^TIUCCHL7UT(MSGID,MSGTEXT,VNUM) Q
 ;
 Q:+$G(TIU("TDA"))'>0!(+$$GET1^DIQ(8925.1,TIU("TDA"),.07,"I")'=11)
 S TIU("ELSIG")=$$GET1^DIQ(200,$G(TIU("AUIEN")),20.4)
 I $G(TIU("ELSIG"))="" D
 .N MSGTEXT ;I '$D(^VA(200,TIU("AUIEN"))) D
 .S MSGTEXT="No valid Electronic Signature for "_$G(TIU("AUNAME"))_" Note is not signed." D MESSAGE^TIUCCRHL7P3(MSGID,VNUM,MSGTEXT) ;
 .K TIU("SIGNED"),TIU("CSIGNED")
 I $$MEMBEROF^TIUHL7U1(TIU("TITLE"),"CONSULTS") S TIU("VSTR")=$$VSTRBLD^TIUSRVP(TIU("VNUM")) ;D
 D CONTINUE^TIUCCRHL7P3
 Q
MAKE(SUCCESS,DFN,TITLE,VDT,VLOC,VSIT,TIUX,VSTR,SUPPRESS,NOASF) ; New Document
 ; SUCCESS = (by ref) TIU DOCUMENT # (PTR to 8925)
 ;         = 0^Explanatory message if no SUCCESS
 ; DFN     = Patient (#2)
 ; TITLE   = TIU Document Definition (#8925.1)
 ; [VDT]   = Date(/Time) of Visit
 ; [VLOC]  = Visit Location (HOSPITAL LOCATION)
 ; [VSIT]  = Visit file ien (#9000010)
 ; [VSTR]  = Visit string (i.e., VLOC;VDT;VTYPE)
 ; [NOASF] = if 1=Do Not Set ASAVE cross-reference
 ; TIUX    = (by ref) array containing field data and document body
 ;
 N TIU,TIUDA,LDT,NEWREC
 S SUCCESS=0
 I +$G(VSIT) S VSTR=$$VSTRBLD(+VSIT)
 I $L($G(VSTR)) D
 . S VDT=$S(+$G(VDT):+$G(VDT),1:$P(VSTR,";",2))
 . S LDT=$S(+$G(VDT):$$FMADD^XLFDT(VDT,"","",1),1:"")
 . S VLOC=$S(+$G(VLOC):+$G(VLOC),1:$P(VSTR,";"))
 . ; If note is for Ward Location, call MAIN^TIUMOVE
 . I $P($G(^SC(+VLOC,0)),U,3)="W" D MAIN^TIUMOVE(.TIU,DFN,"",VDT,LDT,1,"LAST",0,+VLOC) Q
 . ; Otherwise, call PATVADPT^TIULV
 . D PATVADPT^TIULV(.TIU,DFN,"",VSTR)
 I '+$G(VSIT),'$L($G(VSTR)),+$G(VDT),+$G(VLOC) D
 . S VDT=$G(VDT),LDT=$S(+$G(VDT):$$FMADD^XLFDT(VDT,"","",1),1:"")
 . ; If note is for Ward Location, call MAIN^TIUMOVE
 . I $P($G(^SC(+VLOC,0)),U,3)="W" D MAIN^TIUMOVE(.TIU,DFN,"",VDT,LDT,1,"LAST",0,+VLOC) Q
 . ; Otherwise, call MAIN^TIUVSIT
 . D MAIN^TIUVSIT(.TIU,DFN,"",VDT,LDT,"LAST",0,VLOC)
 I '+$G(TIU("VSTR")) D
 . D EVENT^TIUSRVP1(.TIU,DFN)
 S TIU("INST")=$$DIVISION^TIULC1(+TIU("LOC"))
 I $S($D(TIU)'>9:1,+$G(DFN)'>0:1,1:0) S SUCCESS="0^"_$$EZBLD^DIALOG(89250001) Q
 ;
 S TIUDA=$$GETREC(DFN,.TIU,TITLE,.NEWREC)
 I +TIUDA'>0 S SUCCESS="0^"_$$EZBLD^DIALOG(89250002) Q
 S SUCCESS=+TIUDA
 D STUFREC^TIUSRVP1(+TIUDA,.TIUX,DFN,,TITLE,.TIU)
 S:'+$G(NOASF) ^TIU(8925,"ASAVE",DUZ,TIUDA)=""
 K ^TIU(8925,+TIUDA,"TEMP")
 M ^TIU(8925,+TIUDA,"TEMP")=TIUX("TEXT") K TIUX("TEXT")
 D SETXT0(TIUDA)
 D FILE(.SUCCESS,+TIUDA,.TIUX,+$G(SUPPRESS))
 I +SUCCESS'>0 D DIK^TIURB2(TIUDA) Q
 I +$O(^TIU(8925,+TIUDA,"TEMP",0)) D MERGTEXT^TIUEDI1(+TIUDA,.TIU)
 I +$G(TIU("STOP")) D DEFER^TIUVSIT(TIUDA,TIU("STOP")) I 1
 E  D QUE^TIUPXAP1
 I '+$G(SUPPRESS) D
 . D RELEASE^TIUT(TIUDA,1)
 . D UPDTIRT^TIUDIRT(.TIU,TIUDA)
 ;Patch 352 - PB update field 1205 to be the FROM field (#2) in file 123
 I $G(TIUDA)>0 D
 .N FDA
 .S FDA(1,8925,TIUDA_",",1205)=$$GET1^DIQ(123,VNUM_",",2,"I")
 .D UPDATE^DIE("","FDA(1)","ZERR")
 K ^TIU(8925,+TIUDA,"TEMP")
 Q
FILE(SUCCESS,TIUDA,TIUX,SUPPRESS,TIUCPF) ; Call FM Filer & commit
 N FDA,FDARR,IENS,FLAGS,TIUMSG,TIUCMMTX
 S IENS=""""_TIUDA_",""",FDARR="FDA(8925,"_IENS_")",FLAGS=""
 I +$G(TIUX(1202)) S TIUX(1204)=+$G(TIUX(1202))
 I +$G(TIUX(1209)) S TIUX(1208)=+$G(TIUX(1209))
 ;I +$G(TIUX(1405)) S TIUX(1405)=TIU("CNCN")_";GMR(123,"
 ;If the document is a member of the Clinical Procedures Class, set the
 ;Entered By field to the Author/Dictator field
 I $G(TIUCPF),+$G(TIUX(1202)) S TIUX(1302)=+$G(TIUX(1202))
 ;*271 Prevent string date in 1301
 S:$G(TIUX(1301)) TIUX(1301)=+TIUX(1301)
 M @FDARR=TIUX
 D FILE^DIE(FLAGS,"FDA","TIUMSG") ; File record
 I $D(TIUMSG)>9 S SUCCESS=0_U_$G(TIUMSG("DIERR",1,"TEXT",1)) Q
 S SUCCESS=TIUDA
 I '+$G(SUPPRESS) D
 . N DA
 . S DA=TIUDA
 . S TIUCMMTX=$$COMMIT^TIULC1(+$G(^TIU(8925,+TIUDA,0)))
 . ;I TIUCMMTX]"" X TIUCMMTX
 . K ^TIU(8925,"ASAVE",DUZ,TIUDA)
 Q
SETXT0(TIUDA) ; Set root node of "TEMP" WP-field
 N TIUC,TIUI S (TIUC,TIUI)=0
 F  S TIUI=$O(^TIU(8925,TIUDA,"TEMP",TIUI)) Q:+TIUI'>0  D
 . S:$D(^TIU(8925,TIUDA,"TEMP",TIUI,0)) TIUC=TIUC+1
 S ^TIU(8925,TIUDA,"TEMP",0)="^^"_TIUC_U_TIUC_U_DT_"^^"
 Q
VSTRBLD(VSIT) ; Given Visit ien, build Visit-Descriptor String
 N TIUY,VSIT0,VLOC,VDT,VSVCAT
 S VSIT0=$G(^AUPNVSIT(+VSIT,0)),VDT=+$P(VSIT0,U),VLOC=+$P(VSIT0,U,22)
 S VSVCAT=$P(VSIT0,U,7)
 S TIUY=VLOC_";"_VDT_";"_VSVCAT
 Q TIUY
GETREC(DFN,TIU,TITLE,TIUNEW) ; Get/create document record
 N DA,DIC,DIE,DLAYGO,DR,X,Y,TIUDPRM,TIUFPRIV,TIUHIT,TIUSCAT
 S (TIUHIT,DA)=0,TIUFPRIV=1
 S (DIC,DLAYGO)=8925,DIC(0)="FL"
 S X=""""_"`"_+TITLE_"""" D ^DIC K DIC("S")
 I +Y'>0 Q Y_U_" Insufficient data to create a new record."
 S DA=+Y,TIUNEW=+$P(Y,U,3)
 N DIE,DR,TIUVISIT S DIE=8925
 S TIUVISIT=$S(+$G(TIU("VISIT")):+$G(TIU("VISIT")),1:"")
 S TIUSCAT=$S(+$L($P($G(TIU("CAT")),U)):$P($G(TIU("CAT")),U),+$L($P($G(TIU("VSTR")),";",3)):$P($G(TIU("VSTR")),";",3),1:"")
 S DR=".04////"_$$DOCCLASS^TIULC1(+$P(Y,U,2))_";.13////"_TIUSCAT_";1205////"_$P($G(TIU("LOC")),U)_";1211////"_$P($G(TIU("VLOC")),U)_";1212////"_$P($G(TIU("INST")),U)
 D ^DIE
 Q +$G(DA)
SIGNDOC(TIUDA) ;
 N TIUDEL
 I $G(TIU("COMP"))="LA",'+TIU("EC") D
 . I '+$G(TIU("SIGNED")),'+$G(TIU("CSIGNED")) D  Q
 . . I TIU("AVAIL")'="AV" D DELDOC(TIUDA),ERR("TIU","","2100.040","SIGNATURE DATE[TIME] missing from HL7 message & availability not 'AV'; document has been deleted.")
 . I +TIU("SIGNED") D
 . . N TIUACT,TIUAUTH,TIUES,TIUSTAT S TIUACT="SIGNATURE",TIUAUTH=$$CANDO^TIULP(TIUDA,TIUACT,TIU("AUDA")) I '+TIUAUTH D
 . . . D ERR("TIU","15","0000.000",$P(TIUAUTH,U,2)) I TIU("AVAIL")="AV" Q
 . . . S TIUDEL=1 D ERR("TIU","","0000.000","Legal authentication failed & availability not 'AV'; document has been deleted.")
 . . I '+$G(TIUDEL) S TIUES=1_U_$$GET1^DIQ(200,TIU("AUDA"),20.2)_U_$$GET1^DIQ(200,TIU("AUDA"),20.3)
 . . ;I '+$G(TIUDEL) D ES^TIUHL7U2(TIUDA,TIUES,"",TIU("AUDA"))
 . . I '+$G(TIUDEL) D ES(TIUDA,TIUES,"",TIU("AUDA"))
 . . I '+$G(TIUDEL) S TIUSTAT=$P($G(^TIU(8925,TIUDA,0)),U,5) I TIUSTAT<6,TIU("AVAIL")'="AV" D
 . . . S TIUDEL=1 D ERR("TIU","","0000.000","Legal authentication failed & availability not 'AV'; document has been deleted.")
 . I +TIU("CSIGNED") D
 . . N TIUACT,TIUAUTH,TIUES,TIUSTAT S TIUACT="COSIGNATURE",TIUAUTH=$$CANDO^TIULP(TIUDA,TIUACT,TIU("CSDA")) I '+TIUAUTH D
 . . . D ERR("TIU","29","0000.000",$P(TIUAUTH,U,2)) I TIU("AVAIL")="AV" Q
 . . . S TIUDEL=1 D ERR("TIU","29","0000.000","Legal authentication failed & availability not 'AV'; document has been deleted.")
 . . I '+$G(TIUDEL) S TIUES=1_U_$$GET1^DIQ(200,TIU("CSDA"),20.2)_U_$$GET1^DIQ(200,TIU("CSDA"),20.3)
 . . I '+$G(TIUDEL) D ES^TIURS(TIUDA,TIUES,"",TIU("CSDA"))
 . . I '+$G(TIUDEL) S TIUSTAT=$P($G(^TIU(8925,TIUDA,0)),U,5) I TIUSTAT'=7,TIU("AVAIL")'="AV" D
 . . . S TIUDEL=1 D ERR("TIU","29","0000.000","Legal authentication failed & availability not 'AV'; document has been deleted.")
 I +$G(TIUDEL) D DELDOC(TIUDA)
 Q
DELDOC(TIUDA) ;
 N ERR
 D DELETE^TIUSRVP(.ERR,TIUDA,"",1)
 Q
ERR(TIUSEG,TIUP,TIUNUM,TIUTXT) ;
 S TIU("EC")=TIU("EC")+1
 S @TIUNAME@("MSGERR",TIU("EC"))="ERR"_TIUFS_TIUSEG_TIUFS_TIUP_TIUFS_TIUFS_TIUNUM_TIUCS_TIUTXT
 Q
ES(DA,TIUES,TIUI,TIUESIG) ; ^DIE call for /es/
 N SIGNER,DR,DIE,ESDT,TIUSTAT,TIUSTNOW,COSIGNER,SVCHIEF,CSREQ,TIUPRINT
 N CSNEED,TIUTTL,TIUPSIG,TIUDPRM,DAO,TIUSTWAS,TIUSTIS,DAORIG,TIUCHNG
 S TIUSTWAS=$P($G(^TIU(8925,DA,0)),U,5) S:'+$G(TIUESIG) TIUESIG=DUZ
 D DOCPRM^TIULC1(+$G(^TIU(8925,+DA,0)),.TIUDPRM,DA)
 S TIUSTAT=$P($G(^TIU(8925,+DA,0)),U,5),ESDT=$$NOW^TIULC
 S SVCHIEF=+$$ISA^USRLM(TIUESIG,"CLINICAL SERVICE CHIEF")
 S SIGNER=$P(^TIU(8925,+DA,12),U,4),COSIGNER=$P(^(12),U,8),CSREQ=0
 S CSNEED=+$P($G(^TIU(8925,+DA,15)),U,6)
 I +CSNEED,(TIUESIG'=COSIGNER),'+$G(SVCHIEF),(TIUSTAT'=6) S CSREQ=1
 I TIUSTAT=5 D
 . S DR=".05////"_$S(+CSREQ:6,1:7)_";1501////"_ESDT_";1502////"_+TIUESIG
 . I '+$G(CSREQ),+CSNEED,$S(TIUESIG=COSIGNER:1,+$G(SVCHIEF):1,1:0) D
 . . S DR=DR_";1506////0;1507////"_ESDT_";1508////"_+TIUESIG_";1509///^S X=$P(TIUES,U,2);1510///^S X=$P(TIUES,U,3);1511////E"
 I TIUSTAT=6 S DR=".05////7;1506////0;1507////"_ESDT_";1508////"_+TIUESIG
 Q:'$D(DR)
 S DIE=8925 D ^DIE
 I TIUSTAT=5 S DR="1503///^S X=$P(TIUES,U,2);1504///^S X=$P(TIUES,U,3);1505////E"
 I TIUSTAT=6 D
 . N TIUSBY S DR="",TIUSBY=$P($G(^TIU(8925,+DA,15)),U,2)
 . I +TIUSBY>0 S DR="1503///^S X=$$SIGNAME^TIULS("_TIUSBY_");1504///^S X=$$SIGTITL^TIULS("_TIUSBY_");"
 . S DR=$G(DR)_"1509///^S X=$P(TIUES,U,2);1510///^S X=$P(TIUES,U,3);1511////E"
 S DIE=8925 D ^DIE S:'+$G(TIUCHNG) TIUCHNG=1
 D SEND^TIUALRT(DA),SIGNIRT^TIUDIRT(+DA)
 S DAORIG=DA
 I +$$ISADDNDM^TIULC1(DA) S DA=+$P($G(^TIU(8925,+DA,0)),U,6)
 I +$G(CSREQ)'>0 D MAIN^TIUPD(DA,"S") I 1
 I +$P(^TIU(8925,+DA,0),U,11) D REMFLAG^TIUVSIT(+DA)
 I $D(^TIU(8925,+DA,0)),$P(^(0),U,3)'>0,($P(^(0),U,13)="E"!($$BROKER^XWBLIB)) D
 . N D0,DFN,TIU,TIUVSIT
 . ;Try to link docmt to an existing visit, quit if successful
 . I $$LNKVST^TIUPXAP3(DA,.TIUVSIT) Q
 . ;Otherwise set TIU array and DFN to use TIU API which calls PCE
 . ;to resolve multiple visits or creates a new visit
 . D GETTIU^TIULD(.TIU,DA)
 . S DFN=$P($G(^TIU(8925,+DA,0)),U,2)
 . D QUE^TIUPXAP1
 ; post-signature action
 N TIUCONS S TIUCONS=-1
 D ISCNSLT^TIUCNSLT(.TIUCONS,+$G(^TIU(8925,DA,0)))
 I TIUCONS S DA=DAORIG
 S TIUSTIS=$P($G(^TIU(8925,DA,0)),U,5)
 S TIUTTL=+$G(^TIU(8925,+DA,0)),TIUPSIG=$$POSTSIGN^TIULC1(TIUTTL)
 I +$L(TIUPSIG),'+$G(CSREQ) X TIUPSIG
 I TIUCONS,TIUSTIS=7,TIUSTWAS<7,$$HASKIDS^TIUSRVLI(DA) D
 . N SEQUENCE,TIUKIDS,TIUINT,TIUK
 . S SEQUENCE="D",TIUKIDS="TIUKIDS",TIUINT=0,TIUK=0
 . D SETKIDS^TIUSRVLI(TIUKIDS,DA,TIUINT)
 . F  S TIUK=$O(TIUKIDS(TIUK)) Q:'TIUK  D
 . . I $P(TIUKIDS(TIUK),U,7)="completed" X TIUPSIG
 N GMRCA,GMRCAD,GMRCDUZ,GMRCMT,GMRCO,GMRCSTS,GMRCDA
 ;Patch 354 - PB - link the note or addendum to the consult then update the status of the consult to the original status
 D POST^TIUCNSLT(+DA,"ACTIVE")
 S GMRCO=VNUM,GMRCSTS=ORIGSTAT,GMRCA=3
 D STATUS^GMRCP
 S GMRCAD=$$NOW^XLFDT
 S DA=$$SETDA^GMRCGUIB  ;7223
 S GMRCMT(1)="HSRM added a note and reset the status.",GMRCDUZ=$G(TIU("AUDA")),GMRCAD=""
 D SETCOM^GMRCGUIB(.GMRCMT,GMRCDUZ) ;ICR 7223
 ;PB - Feb 16, 2022 - patch 349 added code to add a comment to the consult activity log
 N COMMENT,NOTEDT
 S COMMENT(1)=$G(CFNOTE),NOTEDT=$$NOW^XLFDT,GMRCDA=VNUM
 D CMT^GMRCGUIB(GMRCDA,.COMMENT,GMRCDUZ,NOTEDT,GMRCDUZ)  ;icr 2980
 Q
POST(TIUDA) ;Patch 354 - PB - link the note or addendum to the consult then update the status of the consult to the original status
 N GMRCO,GMRCSTS,GMRCA
 S GMRCA=3,GMRCO=$P($P(^TIU(8925,TIUDA,14),"^",5),";",1)
 S GMRCSTS=$$GET1^DIQ(123,GMRCO_",",8,"I")    ;ICR 3983
 D STATUS^GMRCP
 S DA=TIUDA
 Q
POST1(TIUDA) ;Patch 354 - PB - link the note or addendum to the consult then update the status of the consult to the original status
 N GMRCO,GMRCSTS,GMRCA
 S GMRCO=+$P($G(^TIU(8925,+TIUDA,14)),U,5),GMRCSTS=$$GET1^DIQ(123,GMRCO_",",8,"I"),GMRCA=3    ;ICR 3983
 D POST^TIUCNSLT(DA,"INCOMPLETE")
 D STATUS^GMRCP
 Q
