HMP14699 ;ASMR/CK - HMP XU EVENTS Protocol an ITEM - HMP*2.0*3;Aug 24, 2016@11:35:01
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; US14699 - CK - Subscribe HMP XU EVENTS protocol to XU USER CHANGE and XU USER TERMINATE
 ;
 ; External References  ICR
 ; -------------------  -----
 ; ^DIC(19,             10075
 ; DIC(19               10156
 ;
 Q
 ;
POST ; Post-init logic
 N HMPRTCL,HMPIEN,V,X,Y
 D MES^XPDUTL($T(+0)_" post-init routine started "_$$HTE^XLFDT($H))
 S V=$$SVDATA D MES^XPDUTL("Old data saved in "_V)
 S (X,HMPRTCL)="HMP XU EVENTS",DIC(0)="M",DIC=19 D ^DIC  ;ICR 10156
 ; protocol missing, write message and exit
 I '(Y>0) D MES^XPDUTL(HMPRTCL_" protocol not found. It must be installed to proceed.") Q
 S HMPIEN=$P(Y,U)
 D POST1,POST2
 Q
 ;
POST1 ; add HMP XU EVENTS as an ITEM to XU USER CHANGE
 N HMPDGIEN,HMPEXIT,X,Y
 S X="XU USER CHANGE",DIC(0)="M",DIC=19 D ^DIC
 ; protocol missing, write message and exit
 I '(Y>0) D MES^XPDUTL(Y_" protocol not found.  No ITEM update performed.") Q
 S HMPDGIEN=$P(Y,U)
 ;
 ; is protocol already an item?
 S HMPEXIT=$O(^DIC(19,HMPDGIEN,10,"B",HMPIEN,0))
 I HMPEXIT D MES^XPDUTL(HMPRTCL_" already an ITEM in "_Y_".  No update needed.") Q
 ;
 ; add protocol as ITEM
 K HMPFDA,HMPERR,PRTCLITM
 S HMPFDA(19.01,"+1,"_HMPDGIEN_",",.01)=HMPIEN  ; ICR 10075
 D UPDATE^DIE("","HMPFDA","PRTCLITM","HMPERR")
 I $D(HMPERR) D  Q  ; something went wrong
 . D MES^XPDUTL("FileMan error when adding ITEM to XU USER CHANGE protocol")
 . N V S V="HMPERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ; new ITEM sub-file IEN will be in PRTCLITM(1)
 D MES^XPDUTL(HMPRTCL_" was subscribed to "_Y_", protocol update finished "_$$HTE^XLFDT($H))
 Q 
 ;
POST2 ; add HMP XU EVENTS as an ITEM to XU USER TERMINATE
 N HMPDGIEN,HMPEXIT,X,Y
 S X="XU USER TERMINATE",DIC(0)="M",DIC=19 D ^DIC
 ; protocol missing, write message and exit
 I '(Y>0) D MES^XPDUTL(Y_" protocol not found.  No ITEM update performed.") Q
 S HMPDGIEN=$P(Y,U)
 ;
 ; is protocol already an item?
 S HMPEXIT=$O(^DIC(19,HMPDGIEN,10,"B",HMPIEN,0))
 I HMPEXIT D MES^XPDUTL(HMPRTCL_" already an ITEM in "_Y_".  No update needed.") Q
 ;
 ; add protocol as ITEM
 K HMPFDA,HMPERR,PRTCLITM
 S HMPFDA(19.01,"+1,"_HMPDGIEN_",",.01)=HMPIEN
 D UPDATE^DIE("","HMPFDA","PRTCLITM","HMPERR")
 I $D(HMPERR) D  Q  ; something went wrong
 . D MES^XPDUTL("FileMan error when adding ITEM to XU USER TERMINATE protocol")
 . N V S V="HMPERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ; new ITEM sub-file IEN will be in PRTCLITM(1)
 D MES^XPDUTL(HMPRTCL_" was subscribed to "_Y_", protocol update finished "_$$HTE^XLFDT($H))
 Q
 ;
SVDATA() ; extrinsic variable, save original FileMan data, returns storage node
 D DT^DICRW
 N FMERRCNT,HMPXTMP,HMPIEN,LN,NTRY,TXT,V,X,Y
 S Y=$$NOW^XLFDT,HMPXTMP=$NA(^XTMP("HMP INSTALL LOG",Y))  ; XTMP storage location
 ; ^XTMP log data expires in 90 days
 S X=$G(@HMPXTMP@(0)) S:X="" @HMPXTMP@(0)=$$FMADD^XLFDT(DT,90)_U_Y_"^HMP installation "_$$FMTE^XLFDT(Y)
 ;
 S FMERRCNT=0  ; FileMan error counter
 ; save entries in FileMan items list
 F LN=1:1 S TXT=$P($T(FMITMS+LN),";;",2,99) Q:TXT=""  D
 . N FLNO,FMARRY,FMERR  ; file #, FileMan returned value and error message arrays
 . S FLNO=+$P(TXT,U),X=$P(TXT,U,2,99)  ; file number and target entry
 . Q:'(FLNO>1)!(X="")  ; file and entry required
 . S HMPIEN=$$FIND1^DIC(FLNO,"","",X,"","","FMERR")  ; lookup value in X is external format
 . I $D(FMERR) D  Q  ; log error message and quit
 . .  S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @HMPXTMP@("FM LOOKUP ERROR",FMERRCNT,V)=@V
 . ;
 . S:'(HMPIEN>0) FMERRCNT=FMERRCNT+1,@HMPXTMP@("FM ENTRY NOT FOUND",FMERRCNT)=TXT  ; entry
 . S:HMPIEN>0 @HMPXTMP@("ENTRY",FLNO,HMPIEN)="entry found"
 . K FMERR  ; just in case
 . D GETS^DIQ(FLNO,HMPIEN_",","**","EN","FMARRY","FMERR")  ; data including sub-files, ignore null values
 . I $D(FMERR) D  ; log error message
 . . S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @HMPXTMP@("FM DATA ERROR",FMERRCNT,V)=@V
 . ; save the data
 . M @HMPXTMP@("ENTRY")=FMARRY
 ;
 Q HMPXTMP  ; return ^XTMP storage location
 ;
FMITMS ; list of FileMan entries: "file # ^ .01 field value"
 ;;19^XU USER CHANGE
 ;;19^XU USER TERMINATE
 ;
