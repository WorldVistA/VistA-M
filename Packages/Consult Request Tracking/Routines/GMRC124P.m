GMRC124P ;ABV/BL - Patch 124 Post-install;03/28/2019
 ;;3.0;CONSULT/REQUEST TRACKING;**124**;MAR 28, 2019;Build 31
 ;
EN ; Entry point for post install
 ;
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 ;
 K FDA
 S WEBVICE=$O(^XOB(18.02,"B","DST GET ID SERVICE",0))
 S WEBVICE=$S(WEBVICE:WEBVICE,1:"+1")
 S FDA(18.02,WEBVICE_",",.01)="DST GET ID SERVICE"                       ; NAME
 S FDA(18.02,WEBVICE_",",.02)="REST"                                     ; TYPE
 S FDA(18.02,WEBVICE_",",200)="vs/v1/consultFactor"                      ; CONTEXT ROOT
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 K IENROOT,MSGROOT,FDA
 ;
 S WEBVER=$O(^XOB(18.12,"B","DST GET ID SERVER",0))
 S WEBVER=$S(WEBVER:WEBVER,1:"+1")
 S FDA(18.12,WEBVER_",",.01)="DST GET ID SERVER"                         ; NAME
 S FDA(18.12,WEBVER_",",.03)="80"                                        ; PORT
 S FDA(18.12,WEBVER_",",.04)="dst.domain.ext"                                ; SERVER
 S FDA(18.12,WEBVER_",",.06)="ENABLED"                                   ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,WEBVER_",",.07)=60                                          ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,WEBVER_",",1.01)="NO"                                       ; LOGIN REQUIRED
 S FDA(18.12,WEBVER_",",3.01)="TRUE"                                     ; SSL ENABLED
 S FDA(18.12,WEBVER_",",3.02)="encrypt_only_all"                         ; SSL CONFIGURATION
 S FDA(18.12,WEBVER_",",3.03)="443"                                      ; SSL PORT
 ;Need to determine if we are creating a new file, or updating an existing one
 N NEW
 S NEW=1
 I $D(^XOB(18.12,WEBVER,0)) S NEW=0
 I NEW=1 D
 . D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 I NEW=0 D
 . D FILE^DIE("E","FDA","MSGROOT")
 ;
 ;
 S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 ;
 S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 K IENROOT,MSGROOT,FDA
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="DST GET ID SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="DST GET ID SERVICE"       ; WEB SERVICE
 S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"                  ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
SPROT  ;Set protocol GMRC SIGNED CONSULT DST as an item on OR EVSEND GMRC
 ;
 N GMRDGIEN,GMRERR,GMREXIT,GMRFDA,GMRIEN,GMRRTCL,J,PRTCLITM,V,X,Y
 ;
 D MES^XPDUTL($T(+0)_" post-init routine started "_$$HTE^XLFDT($H))
 S V=$$SVDATA D MES^XPDUTL("Old data saved in "_V)
 S GMRRTCL="GMRC SIGNED CONSULT DST",GMRIEN=$O(^ORD(101,"B",GMRRTCL,0))
  ; protocol missing, write message and exit
 I '(GMRIEN>0) D MES^XPDUTL(GMRRTCL_" protocol not found. It must be installed to proceed.") Q
 ;
 S Y="OR EVSEND GMRC",GMRDGIEN=$O(^ORD(101,"B",Y,0))
 ; protocol missing, write message and exit
 I '(GMRDGIEN>0) D MES^XPDUTL(Y_" protocol not found.  No ITEM update performed.") Q
 ; make OR EVSEND GMRC an extended action
 S GMRFDA(101,GMRDGIEN_",",4)="X"
 D UPDATE^DIE("","GMRFDA","","GMRERR")
 I $D(GMRERR) D  Q  ; something went wrong
 . D MES^XPDUTL("FileMan error when editing OR EVSEND GMRC protocol")
 . N V S V="GMRERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ;
 ; is protocol already an item?
 S GMREXIT=$O(^ORD(101,GMRDGIEN,10,"B",GMRIEN,0))
 I GMREXIT D MES^XPDUTL(GMRRTCL_" already an ITEM in "_Y_".  No update needed.") Q
 ;
 ; add protocol as ITEM
 K GMRFDA,GMRERR
 S GMRFDA(101.01,"+1,"_GMRDGIEN_",",.01)=GMRIEN
 D UPDATE^DIE("","GMRFDA","PRTCLITM","GMRERR")
 I $D(GMRERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when adding ITEM to OR EVSEND GMRC protocol")
 .N V S V="GMRERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ; new ITEM sub-file IEN will be in PRTCLITM(1)
 D MES^XPDUTL(GMRRTCL_" protocol update finished "_$$HTE^XLFDT($H))
 ;
 Q
 ;
SVDATA() ; extrinsic variable, save original FileMan data, returns storage node
 ;
 D DT^DICRW
 N FMERRCNT,GMRXTMP,GMRIEN,LN,NTRY,TXT,V,X,Y
 S Y=$$NOW^XLFDT,GMRXTMP=$NA(^XTMP("GMR INSTALL LOG",Y))  ; XTMP storage location
 ; ^XTMP log data expires in 90 days
 S X=$G(@GMRXTMP@(0)) S:X="" @GMRXTMP@(0)=$$FMADD^XLFDT(DT,90)_U_Y_"^GMR installation "_$$FMTE^XLFDT(Y)
 ;
 S FMERRCNT=0  ; FileMan error counter
 ; save entries in FileMan items list
 F LN=1:1 S TXT=$P($T(FMITMS+LN),";;",2,99) Q:TXT=""  D
 .N FLNO,FMARRY,FMERR  ; file #, FileMan returned value and error message arrays
 .S FLNO=+$P(TXT,U),X=$P(TXT,U,2,99)  ; file number and target entry
 .Q:'(FLNO>1)!(X="")  ; file and entry required
 .S GMRIEN=$$FIND1^DIC(FLNO,"","",X,"","","FMERR")  ; lookup value in X is external format
 .I $D(FMERR) D  Q  ; log error message and quit
 ..S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @GMRXTMP@("FM LOOKUP ERROR",FMERRCNT,V)=@V
 .;
 .S:'(GMRIEN>0) FMERRCNT=FMERRCNT+1,@GMRXTMP@("FM ENTRY NOT FOUND",FMERRCNT)=TXT  ; entry
 .S:GMRIEN>0 @GMRXTMP@("ENTRY",FLNO,GMRIEN)="entry found"
 .K FMERR  ; just in case
 .D GETS^DIQ(FLNO,GMRIEN_",","**","EN","FMARRY","FMERR")  ; data including sub-files, ignore null values
 .I $D(FMERR) D  ; log error message
 ..S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @GMRXTMP@("FM DATA ERROR",FMERRCNT,V)=@V
 .; save the data
 .M @GMRXTMP@("ENTRY")=FMARRY
 ;
 Q GMRXTMP  ; return ^XTMP storage location
 ;
FMITMS ; list of FileMan entries: "file # ^ .01 field value"
 ;;101^OR EVSEND GMRC
 ;
