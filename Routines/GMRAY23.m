GMRAY23 ;SLC/DAN Installation Utilities ;7/18/05  08:06
 ;;4.0;Adverse Reaction Tracking;**23**;Mar 29, 1996
 ;
 ;DBIA SECTION
 ;3744  - $$TESTPAT^VADPT
 ;10061 - VADPT
 ;2916  - DDMOD
 ;10013 - DIK
 ;2056  - DIQ
 ;10018 - DIE
 ;10070 - XMD
 ;10103 - XLFDT
 ;2051  - DIC
 ;2232  - XUDHSET
 ;
PRETRAN ;Load descriptions for files 120.82 and 120.83
 M @XPDGREF@("GMRADD82")=^DIC(120.82,"%D")
 M @XPDGREF@("GMRADD83")=^DIC(120.83,"%D")
 Q
 ;
GETERMS ;Make the request for the allergy standardized terms to be pushed to the site
 N TMP,GMRADOM
 S TMP=$$GETIEN^HDISVF09("ALLERGIES",.GMRADOM)
 D EN^HDISVCMR(GMRADOM,"")
 Q
 ;
POST ;Post installation processes
 N ERR,GMRADONT
 D RESFILE
 D RESDEV
 D FIXREF
 D ^GMRAY23A,^GMRAY23B,^GMRAY23C ;Set up new style xrefs
 ;S GMRADONT=1 ;When GMRADONT is defined, messages are NOT sent to HDR
 D CLN85
 D FIXALG
 D GETERMS
 D MAIL
 Q
 ;
CLN85 ;Clean up erroneous date/times that are in the STOP DATE OF ADMINISTRATION field of CONCOMITANT DRUG multiple
 N GMRAI,GMRAJ,ENDT
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.85,GMRAI)) Q:'+GMRAI  I $D(^GMR(120.85,GMRAI,13)) D
 .S GMRAJ=0 F  S GMRAJ=$O(^GMR(120.85,GMRAI,13,GMRAJ)) Q:'+GMRAJ  D
 ..S ENDT=$P($G(^GMR(120.85,GMRAI,13,GMRAJ,0)),U,3) Q:ENDT=""
 ..I ENDT\1'=ENDT S $P(^GMR(120.85,GMRAI,13,GMRAJ,0),U,3)=ENDT\1 ;If value is date/time strip time
 Q
 ;
FIXALG ;Loop through 120.8, fix database issues
 N GMRAI,FREE,REACTANT,ENTRY
 S FREE=$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0)) S:'+FREE ERR=1 S:FREE FREE=FREE_";GMRD(120.82," Q:$G(ERR)
 S GMRAI=0 F  S GMRAI=$O(^GMR(120.8,GMRAI)) Q:'+GMRAI  D
 .I '$D(^GMR(120.8,GMRAI,0))!($L(^GMR(120.8,GMRAI,0),"^")=1) D DEL Q
 .Q:$$TESTPAT^VADPT($P(^GMR(120.8,GMRAI,0),U))  ;stop if test patient
 .I $D(^GMR(120.8,GMRAI,10)) D CHECKSS ;Check signs/symptoms for broken pointers
 .D CHECK23(.DELETED) Q:$G(DELETED)  ;If pieces 2 and 3 cannot be resolved, delete entry
 Q
 ;
DEL ;No zero node, remove entry
 N DIK,DA
 S DIK="^GMR(120.8,",DA=GMRAI
 D ^DIK
 Q
 ;
CHECKSS ;Check Signs/Symptoms for broken pointers, delete if necessary
 N GMRAJ,REF,DIK,DA,RIEN
 S GMRAJ=0 F  S GMRAJ=$O(^GMR(120.8,GMRAI,10,GMRAJ)) Q:'+GMRAJ  D
 .S REF=$P($G(^GMR(120.8,GMRAI,10,GMRAJ,0)),U) ;Pointer to 120.83
 .I REF I $D(^GMRD(120.83,REF)) Q  ;Pointer isn't broken - done
 .S DA(1)=GMRAI,DA=GMRAJ,DIK="^GMR(120.8,DA(1),10," D ^DIK ;Remove S/S with broken pointer
 .;If observed reaction then there should be a broken pointer in 120.85
 .S RIEN=$O(^GMR(120.85,"C",GMRAI,0)) Q:'+RIEN
 .S DA(1)=RIEN
 .S DA=$O(^GMR(120.85,RIEN,2,"B",REF,0)) Q:'+DA  ;S/S not found
 .S DIK="^GMR(120.85,DA(1),2," D ^DIK ;Remove S/S from obs entry
 Q
 ;
CHECK23(DELETED) ;Check REACTANT (piece 2) and GMR ALLERGY (piece 3) to make sure they are present and valid
 N REACTANT,ALLPTR,GMRA0,IEN,FILE,DIE,DA,DR,BROKEN
 S DELETED=0
 S GMRA0=$G(^GMR(120.8,GMRAI,0))
 S REACTANT=$P(GMRA0,U,2)
 S ALLPTR=$P(GMRA0,U,3)
 S FILE=$P(ALLPTR,";",2)
 S IEN=$P(ALLPTR,";")
 S BROKEN=$S(ALLPTR="":1,FILE="":1,IEN="":1,1:$G(@("^"_FILE_IEN_",0)"))="")
 I ALLPTR=""!(BROKEN) D  Q  ;If no pointer present or pointer is broken
 .I REACTANT'="" S $P(^GMR(120.8,GMRAI,0),U,3)=FREE Q  ;If REACTANT field has a value then set GMR ALLERGY to "free text" entry
 .I REACTANT="" D DEL S DELETED=1 Q  ;If no pointer or broken pointer and no value in REACTANT then delete entry
 Q:DELETED
 I ALLPTR'="",REACTANT="" D  ;Pointer exists but no value in REACTANT field
 .S FILE=+$P(@("^"_FILE_"0)"),U,2) ;Get file number
 .S REACTANT=$$GET1^DIQ(FILE,IEN,$S(FILE'=50.67:.01,1:4))
 .S DIE="^GMR(120.8,",DA=GMRAI,DR=".02////"_REACTANT D ^DIE
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT,CNT,VADM,DFN,REACTANT,LOOP,DIFROM
 S XMDUZ="PATCH GMRA*4*23 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*23"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=3
 I $G(ERR)=1 D
 .S GMRATXT(4)="**NOTE: There was a problem with the installation!"
 .S GMRATXT(5)="Required entry missing from file 120.82 - CONVERSION ABORTED.",GMRATXT(6)="Contact the National Help Desk for Immediate assistance."
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*23 Post Install COMPLETED"
 D ^XMD
 Q
 ;
RESFILE ;Restrict file access and update description
 N FILE,J,GMRASEC
 M ^DIC(120.82,"%D")=@XPDGREF@("GMRADD82")
 M ^DIC(120.83,"%D")=@XPDGREF@("GMRADD83")
 F J="DD","WR","DEL","LAYGO","AUDIT" S GMRASEC(J)="@"
 F FILE=120.82,120.83 D
 .S ^DD(FILE,.01,"LAYGO",1,0)="D:'$D(XUMF) EN^DDIOL(""Entries must be added via the Master File Server (MFS)."","""",""!?5,$C(7)"") I $D(XUMF)"
 .S ^DD(FILE,.01,7.5)="I $G(DIC(0))[""L"",'$D(XUMF) K X D EN^DDIOL(""Entries must be edited via the Master File Server (MFS)."","""",""!?5,$C(7)"")"
 .S ^DD(FILE,.01,"DEL",1,0)="D:'$D(XUMF) EN^DDIOL(""Entries must be inactivated via the Master File Server (MFS)."","""",""!?5,$C(7)"") I $D(XUMF)"
 .D FILESEC^DDMOD(FILE,.GMRASEC) ;Force security update to file
 F J=.01,1,2,99.98,99.99 S ^DD(120.82,J,9)="^",^DD(120.83,J,9)="^"
 F J=120.821,120.831 S ^DD(J,.01,9)="^",^DD(J,.02,9)="^"
 F J=120.823,120.824,120.8205 S ^DD(J,.01,9)="^"
 Q
 ;
RESDEV ;Set up resource device
 N X
 S X=$$RES^XUDHSET("GMRA UPDATE RESOURCE",,1,"Allergy update control")
 Q
 ;
FIXREF ;Fix new style xrefs so they fire when using DIK to set xrefs for an entry in the file
 N LCV,DIE,DR,DA
 S LCV=0 F  S LCV=$O(^DD("IX","IX","AHDR",LCV)) Q:'+LCV  S DIE="^DD(""IX"",",DA=LCV,DR=".41///"_"R" D ^DIE
 Q
