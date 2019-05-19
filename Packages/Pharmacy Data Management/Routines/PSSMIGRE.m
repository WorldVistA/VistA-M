PSSMIGRE ;AJF - Process Sync XML message from PEPS;  6/19/2012 0840
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;7/11/2008;Build 36
 ;;
 ; Process Sync request 
 ; Called from ^PSSMIGRD
 ;;
 Q
 ;
MAN ; Manufacturer file Sync
 ;
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE
 I PSS("NAME")="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 S NAME=$G(PSS("NAME")),IEN=$G(PSS("IEN")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("IDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE)
 S FNAME="syncResponse.XML",FNUM=55.95
 S FNAME1="Manufacturer"
 ;
 ;Add the Manufacturer to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PS(55.95):5 E  D OUT^PSSMIGRC(" Another USER editing Manufacturer file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(55.95,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(55.95,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=55.95,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"))=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q:'$L(DA)
 . . S DA=$O(^PS(55.95,"B",NAME,""))
 . . Q:$L(DA)
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for "_NAME)
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(55.95,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S PSS("IEN")=DA,DIE=DIC K DIC
 . S DR="2///^S X=IDATE"
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(55.95,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PS(55.95)
 ;
 Q:$G(ERORR)=1
 D:RTYPE="MODIFY"
 .S DA=PSS("IEN"),DIE=55.95
 .S PS5=$G(^PS(55.95,DA,0)),DR="",PQ=""
 .S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 .S DR=DR_PQ_"2///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .;S DR=".01///^S X=NAME;2///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .D ^DIE
 ;
 S XMESS="<message>  Updated Manufactrer: "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
PTYP ; PACKAGE TYPE file Synch
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE
 I PSS("NAME")="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 S NAME=$G(PSS("NAME")),IEN=$G(PSS("IEN")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("IDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S FNAME="syncResponse.XML",FNUM=50.608
 S FNAME1="packageType"
 ;
 ;Add the PACKAGE TYPE to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PS(50.608):5 E  D OUT^PSSMIGRC(" Another USER editing PACKAGE TYPE file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.608,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.608,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.608,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"))=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for NAME")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.608,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S PSS("IEN")=DA,DIE=DIC K DIC
 . ;S DR=".01///^S X=NAME;1///^S X=IDATE"
 . S DR="1///^S X=IDATE"
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.608,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PS(50.608)
 ;
 D:RTYPE="MODIFY"
 .S DA=PSS("IEN"),DIE=50.608
 .S PS5=$G(^PS(50.608,DA,0)),DR="",PQ=""
 .S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 .S DR=DR_PQ_"1///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .;S DR=".01///^S X=NAME;1///"_$S(IDATE]"":"^S X=IDATE",1:"@")
 .D ^DIE
 ;
 S XMESS="<message>  Updated Package Type: "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
NDC ;  Synch for NDC
 ;
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE,TNAME,MNAME,MIEN,PNAME,PIEN,PSIZE,PTYPE,PTIEN
 N PSOTC,NIEN,PSO,SCK,SIEN,UPN,VAPRO
 ;
 I PSS("NAME")="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 S NAME=$G(PSS("NAME")),IEN=$G(PSS("IEN")),RTYPE=$G(PSS("RTYPE")),TNAME=$G(PSS("TNAME"))
 S IDATE=$TR($P($G(PSS("IDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S MNAME=$G(PSS("MNAME")),MIEN=$G(PSS("MIEN")),PNAME=$G(PSS("PNAME")),PIEN=$G(PSS("PIEN"))
 S PSIZE=$G(PSS("PSIZE")),PTYPE=$G(PSS("PTYPE")),PTIEN=$G(PSS("PTIEN"))
 S PSOTC=$G(PSS("PSOTC")),UPN=$G(PSS("UPN"))
 S FNAME="syncResponse.XML",FNUM=50.67
 S FNAME1="NDC",NAME=$TR(NAME,"-","")
 ;
 ;
 ; Adding Package Size
 I PSIZE'="" S SIEN="",SCK=0 D
 .F  S SIEN=$O(^PS(50.609,"B",PSIZE,SIEN)) Q:SIEN=""  D  Q:+SCK
 ..S:$P(^PS(50.609,SIEN,0),"^",2)="" SCK=1
 I SIEN="" N PSNUM,PSCNT L +^PS(50.609,0):0 I $T D
 .S PS0=^PS(50.609,0),PSCNT=$P(PS0,"^",3)+1,PSNUM=$P(PS0,"^",4)+1
 .S $P(^PS(50.609,0),"^",3)=PSCNT,$P(^PS(50.609,0),"^",4)=PSNUM
 .L -^PS(50.609,0)
 .S SIEN=PSCNT
 .;S ^PS(50.609,SIEN,0)=PSIZE
 .;S ^PS(50.609,"B",PSIZE,SIEN)=""
 .S DA=SIEN,DIE="^PS(50.609,"
 .S DR=".01///^S X=PSIZE"
 .D ^DIE
 ;
 ;
 ;Add NDC to the Database
 D:RTYPE="ADD"  Q:ERROR=1
 . S NIEN=$O(^PSNDF(50.67,"NDC",NAME,""))
 . ; Create new NDC entry
 . I NIEN="" D
 .. ; Lock the Global
 .. L +^PSNDF(50.67):5 E  D OUT^PSSMIGRC(" Another USER editing NDC file") Q
 .. ;S PS0=^PSNDF(50.67,0),PSCNT=$P(PS0,"^",3)+1,PSNUM=$P(PS0,"^",4)+1
 .. ;S $P(^PSNDF(50.67,0),"^",3)=PSCNT,$P(^PSNDF(50.67,0),"^",4)=PSNUM
 .. ;L -^PSNDF(50.67,0)
 .. ;S NIEN=PSCNT
 .. ;S ^PSNDF(50.67,NIEN,0)=NIEN
 .. ;S ^PSNDF(50.67,"NDC",NAME,NIEN)=""
 .. ;
 .. S PS0=^PSNDF(50.67,0),PSCNT=$P(PS0,"^",3)+1
 .. S $P(^PSNDF(50.67,0),"^",3)=PSCNT
 .. L -^PSNDF(50.67,0)
 .. S X=PSCNT,DIC=50.67,DIC(0)="LMXZ"
 .. D ^DIC
 .. S:Y'="-1" NIEN=$P(Y,"^")
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.67,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.67,.01,"LAYGO",.01,0)
 . ;
 . I NIEN="" D OUT^PSSMIGRC(" Error... Unable To Create NEW IEN") Q 
 . ;
 . ;
 . ;
 . ; Set Database Variables
 . ;
 . ;
 . S NDF0=$G(^PSNDF(50.67,NIEN,0))
 . S (DA,PSS("IEN"))=NIEN,DIE="^PSNDF(50.67,",DR="",PQ=""
 . S:$P(NDF0,"^",2)'=NAME DR="1///^S X=NAME" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",3)'=UPN DR=DR_PQ_"2///"_$S(UPN]"":"^S X=UPN",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",4)'=MIEN DR=DR_PQ_"3///^S X=MIEN" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",5)'=TNAME DR=DR_PQ_"4///"_$S(TNAME]"":"^S X=TNAME",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",6)'=PIEN DR=DR_PQ_"5///^S X=PIEN" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",7)'=IDATE DR=DR_PQ_"7///"_$S(IDATE]"":"^S X=IDATE",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",8)'=SIEN DR=DR_PQ_"8///"_$S(SIEN]"":"^S X=SIEN",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",9)'=PTIEN DR=DR_PQ_"9///"_$S(PTIEN]"":"^S X=PTIEN",1:"@") S:$L(DR) PQ=";"
 . S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 . S:$P(NDF0,"^",10)'=PSOT DR=DR_PQ_"10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ;
 . I '$D(^PSNDF(50.67,NIEN,1,0)) D
 .. ; Stuff ROUTE OF ADMINISTRATION entries
 .. S DIC="^PSNDF(50.67,"_NIEN_",1,",DIC(0)="L",DIC("P")="50.676A"
 .. S DA(1)=NIEN,DA=1,X="N/A" D FILE^DICN
 .. ;
 . ;
 . S NIEN2=NIEN
 . F  S NIEN2=$O(^PSNDF(50.67,"NDC",NAME,NIEN2)) Q:NIEN2=""  D
 .. D DT^DICRW S DA=NIEN2,DIE=50.67,IDATE=DT,DR=""
 .. S DR="7///^S X=IDATE"
 .. S:$P(NDF0,"^",2)'=NAME DR=";1///^S X=NAME"
 .. S:$P(NDF0,"^",3)'=UPN DR=DR_";2///"_$S(UPN]"":"^S X=UPN",1:"@")
 .. S:$P(NDF0,"^",4)'=MIEN DR=DR_";3///^S X=MIEN"
 .. S:$P(NDF0,"^",5)'=TNAME DR=DR_";4///"_$S(TNAME]"":"^S X=TNAME",1:"@")
 .. S:$P(NDF0,"^",6)'=PIEN DR=DR_";5///^S X=PIEN"
 .. S:$P(NDF0,"^",8)'=SIEN DR=DR_";8///"_$S(SIEN]"":"^S X=SIEN",1:"@")
 .. S:$P(NDF0,"^",9)'=PTIEN DR=DR_";9///"_$S(PTIEN]"":"^S X=PTIEN",1:"@")
 .. S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 .. S:$P(NDF0,"^",10)'=PSOT DR=DR_";10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 .. D ^DIE
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.67,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PSNDF(50.67)
 ;
 Q:$G(ERORR)=1
 ;
 D:RTYPE="MODIFY"
 . S DA=PSS("IEN"),DIE=50.67
 . S NAME1=$P($G(^PSNDF(50.67,DA,0)),"^",2)
 . I NAME'=NAME1 D OUT^PSSMIGRC(" Error... NDC Numbers Don't Match") S ERORR=1 Q
 . S NDF0=$G(^PSNDF(50.67,DA,0)),DR="",PQ=""
 . S:$P(NDF0,"^",2)'=NAME DR="1///^S X=NAME" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",3)'=UPN DR=DR_PQ_"2///"_$S(UPN]"":"^S X=UPN",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",4)'=MIEN DR=DR_PQ_"3///^S X=MIEN" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",5)'=TNAME DR=DR_PQ_"4///"_$S(TNAME]"":"^S X=TNAME",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",6)'=PIEN DR=DR_PQ_"5///^S X=PIEN" S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",7)'=IDATE DR=DR_PQ_"7///"_$S(IDATE]"":"^S X=IDATE",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",8)'=SIEN DR=DR_PQ_"8///"_$S(SIEN]"":"^S X=SIEN",1:"@") S:$L(DR) PQ=";"
 . S:$P(NDF0,"^",9)'=PTIEN DR=DR_PQ_"9///"_$S(PTIEN]"":"^S X=PTIEN",1:"@") S:$L(DR) PQ=";"
 . S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 . S:$P(NDF0,"^",10)'=PSOT DR=DR_PQ_"10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 . D ^DIE
 . S NIEN2=DA
 . F  S NIEN2=$O(^PSNDF(50.67,"NDC",NAME,NIEN2)) Q:NIEN2=""  D
 .. D DT^DICRW S DA=NIEN2,DIE=50.67,IDATE=DT
 .. S DR="7///^S X=IDATE"
 .. S:$P(NDF0,"^",2)'=NAME DR=";1///^S X=NAME"
 .. S:$P(NDF0,"^",3)'=UPN DR=DR_";2///"_$S(UPN]"":"^S X=UPN",1:"@")
 .. S:$P(NDF0,"^",4)'=MIEN DR=DR_";3///^S X=MIEN"
 .. S:$P(NDF0,"^",5)'=TNAME DR=DR_";4///"_$S(TNAME]"":"^S X=TNAME",1:"@")
 .. S:$P(NDF0,"^",6)'=PIEN DR=DR_";5///^S X=PIEN"
 .. S:$P(NDF0,"^",8)'=SIEN DR=DR_";8///"_$S(SIEN]"":"^S X=SIEN",1:"@")
 .. S:$P(NDF0,"^",9)'=PTIEN DR=DR_";9///"_$S(PTIEN]"":"^S X=PTIEN",1:"@")
 .. S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 .. S:$P(NDF0,"^",10)'=PSOT DR=DR_";10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 .. D ^DIE
 ;
 Q:$G(ERORR)=1
 ;
 S XMESS="<message>  Updated NDC: "_NAME_" </message>"
 S XIEN="<ien>"_PSS("IEN")_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
 ;
 ;
VAGN ; VA Generic Sync
 N X,Y,DIC,DA,DR,DIE,IEN,NAME,RTYPE,IDATE,MVUID,VUID,EFFDT,STATUS,CMVUID
 S NAME=$G(PSS("NAME")),IEN=$G(PSS("IEN")),RTYPE=$G(PSS("RTYPE"))
 S IDATE=$TR($P($G(PSS("INACTDATE")),"T"),"-",""),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S MVUID=$G(PSS("MASTERVUID")),VUID=$G(PSS("VUID")),EFFDT=$G(PSS("EFFDATE")),STATUS=$G(PSS("STATUS"))
 S FNUM=50.6,FNAME="syncResponse.XML",FNAME1="vaGenericName"
 ;
 ; Quit if REQUIRED DATA is Missing
 I NAME="" D OUT^PSSMIGRC(" Error...Missing Required NAME") Q
 I MVUID="" D OUT^PSSMIGRC(" Error...Missing Required MASTER VUID") Q
 I VUID="" D OUT^PSSMIGRC(" Error...Missing Required VUID") Q
 I EFFDT="" D OUT^PSSMIGRC(" Error...Missing Required EFFECTIVE DATE") Q
 I STATUS="" D OUT^PSSMIGRC(" Error...Missing Required STATUS") Q
 ;
 S EFFDT=$$DATE^PSSMIGRD($G(PSS("EFFDATE")))
 ;Q
 ;Add the VA Generic Name to the Database
 D:RTYPE="ADD"
 . ; Lock the Global
 . L +^PSNDF(50.6):5 E  D OUT^PSSMIGRC(" Another USER editing VA Generic Name file") Q
 . ;
 . ; Cheating - Remove LAYGO temporarly
 . S ^TMP("AJF LAYGO",$J)=$G(^DD(50.6,.01,"LAYGO",.01,0))
 . I ^TMP("AJF LAYGO",$J)]"" K ^DD(50.6,.01,"LAYGO",.01,0)
 . ;
 . ; Get the IEN
 . S X=NAME,DIC=50.6,DIC(0)="LMXZ"
 . D ^DIC
 . S (DA,PSS("IEN"),PIEN)=+Y
 . ;
 . ; Quit if cannot get IEN
 . I Y<1 D  Q
 . . D OUT^PSSMIGRC(" Error...Cannot obtain an IEN for NAME")
 . . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.6,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . ;
 . ; Set Database Variables
 . S DIE=DIC K DIC
 . S DR="1///^S X=IDATE;99.98///^S X=MVUID;99.99///^S X=VUID"
 . ;S DR(2,50.6009)=".01///^S X=EFFDT;.02///^S X=STATUS"
 . ;
 . ; Update Database
 . D ^DIE
 . S DIC="^PSNDF(50.6,"_PIEN_",""TERMSTATUS"",",DIC(0)="L",DIC("P")="50.6009DA"
 . S DA(1)=PIEN,DA=1,X=EFFDT
 . D FILE^DICN
 . S DIE=DIC,DR=".02///^S X=STATUS"
 . D ^DIE
 . ;
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS",0)="^50.6009^1^1"
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS",1,0)=EFFDT_"^"_STATUS
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS","B",EFFDT,1)=""
 . ;
 . ; Put LAYGO back
 . S:^TMP("AJF LAYGO",$J)]"" ^DD(50.416,.01,"LAYGO",.01,0)=^TMP("AJF LAYGO",$J)
 . L -^PSNDF(50.6)
 . ;
 ;
 D:RTYPE="MODIFY"
 . S DA=PSS("IEN"),DIE=50.6
 . S PS5=$G(^PSNDF(50.6,DA,0)),PSMV=$G(^PSNDF(50.6,DA,"VUID")),DR="",PQ=""
 . S:$P(PS5,"^",2)'=IDATE DR=DR_PQ_"1///"_$S(IDATE]"":"^S X=IDATE",1:"@") S:$L(DR) PQ=";"
 . ;S CMVUID=$P(PSMV,"^",2),CMVUID=$S(CMVUID=1:"YES",CMVUID=0:"NO",1:"")
 . S:$P(PSMV,"^",2)'=MVUID DR=DR_PQ_"99.98///^S X=MVUID" S:$L(DR) PQ=";"
 . S:$P(PSMV,"^",1)'=VUID DR=DR_PQ_"99.99///^S X=VUID" S:$L(DR) PQ=";"
 . ;S DR="1///"_$S(IDATE]"":"^S X=IDATE",1:"@")_";99.98///^S X=MVUID;99.99///^S X=VUID"
 . ;S DR(2,50.6009)=".01///^S X=EFFDT;.02///^S X=STATUS"
 . ;
 . ; Update Database
 . D ^DIE
 . ;
 . ; Stuff EFFECTIVE DATE/TIME entries
 . ;K ^PSNDF(50.6,DA,"TERMSTATUS")
 . ;S DIC="^PSNDF(50.6,"_PIEN_",""TERMSTATUS"",",DIC(0)="L",DIC("P")="50.6009DA"
 . ;S DA(1)=PIEN,DA=1,X=EFFDT
 . ;D FILE^DICN
 . ;S DIE=DIC,DR=".02///^S X=STATUS"
 . ;D ^DIE
 . ;
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS",0)="^50.6009^1^1"
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS",1,0)=EFFDT_"^"_STATUS
 . ;S ^PSNDF(50.6,DA,"TERMSTATUS","B",EFFDT,1)=""
 . ;
 . ; Updating ^NDFK files
 . ;
 . I IDATE]"" D
 . . S X=NAME,DIC=5000.3,DIC(0)="LMXZ" D ^DIC
 . . S VAPRO=""
 . . F  S VAPRO=$O(^PSNDF(50.6,"APRO",DA,VAPRO)) Q:VAPRO=""  D
 . . .S X=VAPRO,DIC=5000.2,DIC(0)="LMXZ" D ^DIC
 ;
 ;
 S XMESS="<message>  Updated VA Generic: "_NAME_" </message>"
 S XIEN="<ien>"_$G(PSS("IEN"))_"</ien>"
 K DIC,DA,DR,DIE,^TMP("AJF LAYGO",$J)
 Q
