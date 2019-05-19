PSSMIGRT ;AJF -  Process Migration Sync XML message from PEPS; 06/11/2012 1605
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;7/11/2008;Build 35
 ;;
 ; Migration Sync continued
 ;;
EN(PSS) ;Entry point into routine
 ;FL - File Number
 ;IEN - The starting IEN
 ;RCNT - Number of records desired
 ;TYPE - 1
 ;
 ;
 S FNAME="MigrationSyncResponse.XML"
 S FL=$G(PSS("FILE"))
 I FL="" D OUT^PSSMIGRS(" Error... Missing required data") Q
 N XST,CNT,PS5
 S CNT=0,XST=0
 I FL=55.95 D MAN Q  ;Manufacturer
 I FL=50.608 D PTYP Q  ;Package Type
 I FL=50.67 D NDC Q  ;NDC 
 ;File Error Process
 D OUT^PSSMIGRS(" Error... Invalid File Number")
 Q
 ;
MAN ; Migration Synch for Manufacturer file
 ;
 K ^TMP($J,55.95)
 S CNT=0,^TMP($J,55.95,"EOF")=0
 S FNAME="MigrationSyncResponse_Manufacturer.XML",FNUM=55.95
 S FNAME1="Manufacturer"
 ;
 S:PSS("NAME")'="" PSS("IEN")=$O(^PS(55.95,"B",PSS("NAME"),""))
 ;
 I $G(PSS("IEN"))="" L +^PS(55.95,0):0 I $T D
 .S PS0=^PS(55.95,0),PSCNT=$P(PS0,"^",3)+1,PSNUM=$P(PS0,"^",4)+1
 .S $P(^PS(55.95,0),"^",3)=PSCNT,$P(^PS(55.95,0),"^",4)=PSNUM
 .L -^PS(55.95,0)
 .S MIEN=PSCNT
 .S PSS("IEN")=MIEN
 ;
 S DA=PSS("IEN"),DIE="^PS(55.95,",IDATE=$TR($P($G(PSS("IDATE")),""),"-","")
 S NAME=$G(PSS("NAME")),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S PS5=$G(^PS(55.95,DA,0)),DR="",PQ=""
 S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 S DR=DR_PQ_"2///^S X=IDATE"
 D ^DIE
 S XMESS="<message><![CDATA[  Updated Manufacturer: "_NAME_" ]]></message>"
 S XIEN="<manufacturerIen>"_PSS("IEN")_"</manufacturerIen>"
 Q
 ;
PTYP ; Migration Synch for PACKAGE TYPE file
 ;
 K ^TMP($J,50.608)
 S CNT=0,^TMP($J,50.608,"EOF")=0
 S FNAME="MigrationSyncResponse_packageType.XML",FNUM=50.608
 S FNAME1="packageType"
 ;
 S:PSS("NAME")'="" PSS("IEN")=$O(^PS(50.608,"B",PSS("NAME"),""))
 ;
 I $G(PSS("IEN"))=""  L +^PS(50.608,0):0 I $T D
 .S PS0=^PS(50.608,0),PSCNT=$P(PS0,"^",3)+1,PSNUM=$P(PS0,"^",4)+1
 .S $P(^PS(50.608,0),"^",3)=PSCNT,$P(^PS(50.608,0),"^",4)=PSNUM
 .L -^PS(50.608,0)
 .S TIEN=PSCNT
 .S PSS("IEN")=TIEN
 ;
 S DA=PSS("IEN"),DIE="^PS(50.608,",IDATE=$TR($P($G(PSS("IDATE")),""),"-","")
 S NAME=$G(PSS("NAME")),IDATE=$$HL7TFM^XLFDT(IDATE,"L")
 S PS5=$G(^PS(50.608,DA,0)),DR="",PQ=""
 S:$P(PS5,"^",1)'=NAME DR=".01///^S X=NAME" S:$L(DR) PQ=";"
 S DR=DR_PQ_"1///^S X=IDATE"
 D ^DIE
 S XMESS="<message><![CDATA[  Updated Package Type: "_NAME_"  ]]></message>"
 S XIEN="<packageTypeIen>"_PSS("IEN")_"</packageTypeIen>"
 Q
 ;
 ;
NDC ;  Migration Synch for NDC
 ;
 N NIEN,PIEN1,MIEN1,PKIEN1,PSPNAME1,PSTYPE1,PSMAN1,SCK
 S PSNDC1=$TR($G(PSNDC),"-",""),(NIEN,PIEN1,MIEN1,PKIEN1,PSPNAME1,PSTYPE1,PSMAN1)=""
 D DT^DICRW
 ;
 ; Match Product IEN and Name
 S:$G(PIEN)'="" PSPNAME1=$P($G(^PSNDF(50.68,PIEN,0)),"^")
 S PSPNAME1=$$UPC(PSPNAME1)
 I PSPNAME'=PSPNAME1 D OUT^PSSMIGRS(" Error... Product Names Don't Match") Q
 ;
 ; Match Manufacturer IEN and Name
 S:$G(MIEN)'="" PSMAN1=$P($G(^PS(55.95,MIEN,0)),"^")
 S PSMAN1=$$UPC(PSMAN1)
 I PSMAN'=PSMAN1 D OUT^PSSMIGRS(" Error... Manufacturer Names Don't Match") Q
 ;
 ; Match Package Type IEN and Name
 S:$G(PKIEN)'="" PSTYPE1=$P($G(^PS(50.608,PKIEN,0)),"^")
 S PSTYPE1=$$UPC(PSTYPE1)
 I PSTYPE'=PSTYPE1 D OUT^PSSMIGRS(" Error... Package Type Names Don't Match") Q
 ;
 ; Package Size
 I PSSIZE'="" S SIEN="",SCK=0 D
 .F  S SIEN=$O(^PS(50.609,"B",PSSIZE,SIEN)) Q:SIEN=""  D  Q:+SCK
 ..S:$P(^PS(50.609,SIEN,0),"^",2)="" SCK=1
 I SIEN="" L +^PS(50.609,0):0 I $T D
 .S PS0=^PS(50.609,0),PSCNT=$P(PS0,"^",3)+1,PSNUM=$P(PS0,"^",4)+1
 .S $P(^PS(50.609,0),"^",3)=PSCNT,$P(^PS(50.609,0),"^",4)=PSNUM
 .L -^PS(50.609,0)
 .S SIEN=PSCNT
 .;S ^PS(50.609,SIEN,0)=PSSIZE
 .;S ^PS(50.609,"B",PSSIZE,SIEN)=""
 .;
 .S DA=SIEN,DIE="^PS(50.609,"
 .S DR=".01///^S X=PSSIZE"
 .D ^DIE
 ;
 ; 
 ; NDC Lookup
 I NIEN="" S NIEN=$O(^PSNDF(50.67,"NDC",PSNDC1,""))
 ;
 ; Create new NDC entry
 I NIEN="" D
 .L +^PSNDF(50.67,0):0 I $T D
 ..S PS0=^PSNDF(50.67,0),PSCNT=$P(PS0,"^",3)+1
 ..S $P(^PSNDF(50.67,0),"^",3)=PSCNT
 ..L -^PSNDF(50.67,0)
 ..S X=PSCNT,DIC=50.67,DIC(0)="LMXZ"
 ..D ^DIC
 ..S:Y'="-1" NIEN=$P(Y,"^")
 ;
 I NIEN="" D OUT^PSSMIGRS(" Error... Unable To Create NEW IEN") Q 
 ;
 I PSIADT="" S $P(^PSNDF(50.67,NIEN,0),"^",7)=""
 ;
 ;
 ; Date conversion
 S PSIADT=$TR($P(PSIADT,"T",1),"-","")
 S PSIADT=$$HL7TFM^XLFDT(PSIADT)
 ;
 ;
 ;
 S NDF0=$G(^PSNDF(50.67,NIEN,0))
 S DA=NIEN,DIE="^PSNDF(50.67,",DR="",PQ=""
 S:$P(NDF0,"^",2)'=PSNDC DR="1///^S X=PSNDC" S:$L(DR) PQ=";"
 S:$P(NDF0,"^",3)'=PSUPN DR=DR_PQ_"2///"_$S(PSUPN]"":"^S X=PSUPN",1:"@") S:$L(DR) PQ=";"
 S:$P(NDF0,"^",4)'=MIEN DR=DR_PQ_"3///^S X=MIEN" S:$L(DR) PQ=";"
 S:$P(NDF0,"^",5)'=PSTNAME DR=DR_PQ_"4///"_$S(PSTNAME]"":"^S X=PSTNAME",1:"@") S:$L(DR) PQ=";"
 S:$P(NDF0,"^",6)'=PIEN DR=DR_PQ_"5///^S X=PIEN" S:$L(DR) PQ=";"
 S:$P(NDF0,"^",7)'=PSIADT DR=DR_PQ_"7///"_$S(PSIADT]"":"^S X=PSIADT",1:"@") S:$L(DR) PQ=";"
 S:$P(NDF0,"^",8)'=SIEN DR=DR_PQ_"8///"_$S(SIEN]"":"^S X=SIEN",1:"@") S:$L(DR) PQ=";"
 S:$P(NDF0,"^",9)'=PKIEN DR=DR_PQ_"9///"_$S(PKIEN]"":"^S X=PKIEN",1:"@") S:$L(DR) PQ=";"
 S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 S:$P(NDF0,"^",10)'=PSOT DR=DR_PQ_"10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 D ^DIE
 ;
 I '$D(^PSNDF(50.67,NIEN,1,0)) D
 .; Stuff ROUTE OF ADMINISTRATION entries
 .S DIC="^PSNDF(50.67,"_NIEN_",1,",DIC(0)="L",DIC("P")="50.676A"
 .S DA(1)=NIEN,DA=1,X="N/A" D FILE^DICN
 .;
 S NIEN2=NIEN
 F  S NIEN2=$O(^PSNDF(50.67,"NDC",PSNDC1,NIEN2)) Q:NIEN2=""  D
 . D DT^DICRW S DA=NIEN2,DIE=50.67,PSIADT=DT
 . S NDF0=$G(^PSNDF(50.67,NIEN2,0))
 . S DR="7///^S X=PSIADT"
 . S:$P(NDF0,"^",2)'=PSNDC DR=DR_";1///^S X=PSNDC"
 . S:$P(NDF0,"^",3)'=PSUPN DR=DR_";2///"_$S(PSUPN]"":"^S X=PSUPN",1:"@")
 . S:$P(NDF0,"^",4)'=MIEN DR=DR_";3///^S X=MIEN"
 . S:$P(NDF0,"^",5)'=PSTNAME DR=DR_";4///"_$S(PSTNAME]"":"^S X=PSTNAME",1:"@")
 . S:$P(NDF0,"^",6)'=PIEN DR=DR_";5///^S X=PIEN"
 . S:$P(NDF0,"^",8)'=SIEN DR=DR_";8///"_$S(SIEN]"":"^S X=SIEN",1:"@")
 . S:$P(NDF0,"^",9)'=PKIEN DR=DR_";9///"_$S(PKIEN]"":"^S X=PKIEN",1:"@")
 . S PSOT=$S(PSOTC="Prescription":"R",PSOTC="Over the Counter":"O",1:"")
 . S:$P(NDF0,"^",10)'=PSOT DR=DR_";10///"_$S(PSOTC]"":"^S X=PSOTC",1:"@")
 . D ^DIE
 ;
 S XMESS="<message>  Updated ndcName: "_PSNDC_" </message>"
 S XIEN="<ndcIen>"_NIEN_"</ndcIen>"
 ;
 ;
 K ^TMP($J,"NDC",NIEN)
 ;
 Q
UPC(X) ;convert lower case to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
