XUSNPIX2 ;OAK_BP/CMW - NPI EXTRACT REPORT ;7/7/08  17:17
 ;;8.0;KERNEL;**438,452,453,481,548**; Jul 10, 1995;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Direct access to ^IBE(350.9, fields .02, 1.05, 19;.02, 19;1.01, 19;1.02, 19;1.03, 19;,1.04, 19;1.05 authorized by
 ; Integration Agreement #4964.
 ;
 ;
 ; NPI Extract Report
 ;
 ; Input parameter: N/A
 ;
 ; Other relevant variables:
 ;   XUSRTN="XUSNPIX2" (current routine name, used for ^XTMP and ^TMP
 ;                         storage subscript)
 ; Storage Global:
 ;   ^XTMP("XUSNPIX2",0) = Piece 1^Piece 2^Piece 3^Piece 4^Piece 5^Piece 6
 ;      where:
 ;      Piece 1 => Purge Date - 1 year in future
 ;      Piece 2 => Create Date - Today
 ;      Piece 3 => Description
 ;      Piece 4 => Last Date Compiled
 ;      Piece 5 => $H last run start time
 ;      Piece 6 => $H last run completion time
 ;
 ;   ^XTMP("XUSNPIX2",1) = STATION INFO
 ;   ^XTMP("XUSNPIX2",2) = DATA
 ;               
 ;          NPI => Unique NPI of entry
 ;          LDT => Last Date Run, VA Fileman Format
 ;
 ; Entry Point - ENT called from XUSNPIX1
 ;
 Q
 ;
ENT(XUSPROD,XUSVER) ; ENTRY POINT
 ; Initialize variables
 N XUSRTN
 S XUSRTN="XUSNPIX2"
 S DTTM2=$$HTE^XLFDT($H,"2")
 ; Check to see if report is in use
 L +^XTMP(XUSRTN):5 I '$T G EXIT
 ; Process Institution File
 D INIT(XUSRTN)
 ; Pull Station(Institution) data
 D STAT(XUSRTN)
 ; Process Report
 D PROC2(XUSRTN,XUSPROD,DTTM2)
 ;
 ; Standard EXIT point
EXIT ;
 K ^TMP(XUSRTN,$J),^TMP($J,"XUS59"),^TMP("XUSNPIX",$J)
 ; Log Run Completion Time
 S $P(^XTMP(XUSRTN,0),U,6)=$H
 L -^XTMP(XUSRTN)
 K P,XUSPT,INST,DTTM2,XUSIZE,XUSHDR,XUSTAXID
 Q
 ;
INIT(XUSRTN) ; check/init variables
 N XUSDESC
 ;
 ; Reset Temporary Scratch Global
 K ^TMP(XUSRTN)
 S XUSDESC="NPI EXTRACT TYPE 2 - Do Not Delete"
 S ^XTMP(XUSRTN,0)=(DT+10000)_U_DT_U_XUSDESC_U_DT_U_$H
 ;
 I '$D(^TMP("XUSNPIXU",$J)) D BCBSID^XUSNPIXU
 ;
 ; Create pharmacy institution ^TMP file
 D GETPHARM
 Q
 ;
STAT(XUSRTN) ; Pull station and Institution info 
 N SINFO,DIC4,IBSITE,XUSCITY,XUSSTATE,XUSZIP
 S (XUSCITY,XUSSTATE,XUSZIP)=""
 ; Pull site info
 S SINFO=$$SITE^VASITE
 ; Station Number
 S SITE=$P(SINFO,U,3)
 ; Institution  
 S INST=$P(SINFO,U)
 ;
 ; Get Federal Tax Id
 S XUSTAXID=""
 S IBSITE=0
 F  S IBSITE=$O(^IBE(350.9,IBSITE)) Q:'IBSITE!(XUSTAXID'="")  D
 . S XUSTAXID=$P($G(^IBE(350.9,IBSITE,1)),U,5)
 ;
 ; *** Start XU*8.0*548 - RBN ***
 ; Get header for extracted data NOT email
 I INST D
 . S DIC4=$G(^DIC(4,INST,4))
 . S XUSCITY=$P(DIC4,U,3)
 . S XUSSTATE=$P(DIC4,U,4)
 . I XUSSTATE S XUSSTATE=$P($G(^DIC(5,XUSSTATE,0)),U,2)
 . S XUSZIP=$P(DIC4,U,5)
 S XUSHDR="Station: "_SITE_U_XUSCITY_U_XUSSTATE_U_XUSZIP_U_"TYPE 2"_U_XUSVER
 ;
 Q
 ;
PROC2(XUSRTN,XUSPROD,DTTM2) ;Process all Institution records
 N XUSNPI,XUSNEW,XUSDT,XUSI,XUSIN,XUSTXY,XUSSPC,XUSTAX,XUPHM,XUSDIV
 N XUSFCT,XUSFCN,XUSDATA1,XUSDATA2,XUSDATA3,XUSDATA4,XUSDATA5,XUSSTA,XUSEOL
 N INIEN,DIC0,DIC1,PSIEN,NPIINS,RELINS,PSSTA,COUNT,TOTREC,MSGCNT,MAXSIZE,XUSBFN,I
 ;
 ; Set to 300000 for live
 S MAXSIZE=300000
 ;
 ; Set end of line character
 S XUSEOL="~~"
 ;
 ; set counter
 S COUNT=1,(TOTREC,MSGCNT,XUSIZE)=0
 ; Loop through INSTITUTION NPI records NPI xref
 S XUSNPI=0
 F  S XUSNPI=$O(^DIC(4,"ANPI",XUSNPI)) Q:'XUSNPI  D
 . S INIEN=$O(^DIC(4,"ANPI",XUSNPI,""))
 . ;
 . ; Get Station Number
 . S XUSSTA=$P($G(^DIC(4,INIEN,99)),U)
 . ; Parent of Association
 . I (INIEN'=INST)&('$$POA(INIEN,INST)) Q
 . ; Initialize columns
 . F XUSI=1:1:24 S XUSIN(XUSI)=""
 . ;
 . S XUSIN(1)=XUSNPI
 . S DIC0=$G(^DIC(4,INIEN,0)) Q:DIC0=""
 . ;Organization Name 
 . S XUSIN(2)=$P($G(^DIC(4,INIEN,99)),U,2)
 . S XUSIN(3)=2
 . S XUSDATA1=XUSIN(1)_U_XUSIN(2)_U_XUSIN(3)
 . ;
 . ; Pay to Provider Address
 . S XUSDIV=""
 . I $D(XUSTMP("P2P","DEFAULT")) S XUSDIV=XUSTMP("P2P","DEFAULT")
 . I $D(XUSTMP("P2P",INIEN))=1 S XUSDIV=XUSTMP("P2P",INIEN)
 . I XUSDIV="" F I=1:1:6 S $P(XUSDATA2,U,I)=""
 . I XUSDIV'="" S XUSDATA2=$$P2PEXP^XUSNPIXU(XUSDIV)
 . ;
 . ; Servicing Provider Address
 . S DIC1=$G(^DIC(4,INIEN,1))
 . I DIC1'="" D
 . . S XUSIN(10)=$P(DIC1,U)
 . . S XUSIN(11)=$P(DIC1,U,2)
 . . S XUSIN(12)=$P(DIC1,U,3)
 . . S XUSIN(13)=$P($G(DIC0),U,2)
 . . I XUSIN(13) S XUSIN(13)=$P($G(^DIC(5,XUSIN(13),0)),U,2)
 . . S XUSIN(14)=$P(DIC1,U,4)
 . S XUSDATA3=XUSIN(10)_U_XUSIN(11)_U_XUSIN(12)_U_XUSIN(13)_U_XUSIN(14)
 . ;
 . ;Phone number (place holder)
 . S XUSIN(15)=""
 . ;
 . ; Get Taxonomy and Specialty
 . S XUSTXY=0
 . F  S XUSTXY=$O(^DIC(4,INIEN,"TAXONOMY","B",XUSTXY)) Q:'XUSTXY  D
 . . S XUSSPC=$P($G(^USC(8932.1,XUSTXY,0)),U,9)
 . . S XUSTAX=$P($G(^USC(8932.1,XUSTXY,0)),U,7)
 . . I XUSSPC'="" D
 . . . I XUSIN(16)="" S XUSIN(16)=XUSSPC Q
 . . . S XUSIN(16)=XUSIN(16)_";"_XUSSPC
 . . I XUSTAX'="" D
 . . . I XUSIN(17)="" S XUSIN(17)=XUSTAX Q
 . . . ;S XUSIN(17)=XUSIN(17)_";"_XUSTAX
 . . . ;
 . . . ; *** Start ^XU*8.0*548 - RBN ***
 . . . ;
 . . . S:(XUSIN(17)'[XUSTAX) XUSIN(17)=XUSIN(17)_";"_XUSTAX
 . . . ;
 . . . ; *** End ^XU*8.0*548 - RBN ***
 . ;
 . ; Federal Tax ID
 . S XUSIN(18)=$G(XUSTAXID)
 . ; 
 . ; Medicaid Part A/B
 . S XUSIN(19)=670899
 . S XUSIN(20)="VA"_$E(SITE+10000,2,5)
 . ;
 . S XUSDATA4=XUSIN(15)_U_XUSIN(16)_U_XUSIN(17)_U_XUSIN(18)_U_XUSIN(19)_U_XUSIN(20)
 . ;
 . ; DEA Number
 . S XUSIN(21)=$P($G(^DIC(4,INIEN,"DEA")),U)
 . ;
 . ; get Facility Type and Name 
 . S XUSFCT=$P($G(^DIC(4,INIEN,3)),U)
 . I XUSFCT'="" S XUSFCN=$P($G(^DIC(4.1,XUSFCT,0)),U)
 . I $G(XUSFCN)="PHARM" D
 . . I $D(^TMP("XUSNPIX",$J,INIEN)) D
 . . . S XUPHM=^TMP("XUSNPIX",$J,INIEN)
 . . . ; get NCPDP from ^TMP
 . . . S XUSIN(22)=$P($G(XUPHM),U)
 . . . ; get station number from^TMP
 . . . I $P($G(XUPHM),U,2) S XUSSTA=$P(XUPHM,U,2)
 . ;
 . ; VISN Station Number
 . S XUSIN(23)=XUSSTA
 . ;
 . S XUSDATA5=XUSIN(21)_U_XUSIN(22)_U_XUSIN(23)
 . ;
 . ; Get BCBS Payer ID Array
 . K XUSBXID
 . D INSTID^XUSNPIXU(.XUSBXID)
 . ;
 . ; Update counter and save Entry
 . ;
 . S COUNT=COUNT+1,TOTREC=TOTREC+1
 . S ^TMP(XUSRTN,$J,COUNT)=XUSDATA1_U_XUSDATA2_U_XUSDATA3_U_XUSDATA4_U_XUSDATA5_U_XUSEOL
 . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,COUNT))
 . I $D(XUSBXID) D
 . . S XUSB=""
 . . F  S XUSB=$O(XUSBXID(XUSB)) Q:XUSB=""  D
 . . . S COUNT=COUNT+1,TOTREC=TOTREC+1
 . . . S ^TMP(XUSRTN,$J,COUNT)=XUSDATA1_U_XUSDATA2_U_XUSDATA3_U_XUSDATA4_U_XUSDATA5_U_XUSB_U_XUSBXID(XUSB)_U_XUSEOL
 . . . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,COUNT))
 . K XUSIN,XUSDATA1,XUSDATA2,XUSDATA3,XUSDATA4,XUSDATA5,XUSB,XUSBXID
 . I XUSIZE>MAXSIZE D
 . . D EOF(XUSRTN)
 . . D EMAIL(XUSRTN) ;sending extracted data via MailMan
 . . K ^TMP(XUSRTN,$J)
 . . S ^TMP("XUSNPIXS",$J,2,MSGCNT)="2^"_(COUNT-2)
 . . S ^TMP(XUSRTN,$J,1)=XUSHDR
 . . S COUNT=1,XUSIZE=0
 ;
 D EOF(XUSRTN)
 ;
 ; Send the last message (if it has records)
 I $G(COUNT)>1 D
 .D EMAIL(XUSRTN) ;sending extracted data via MailMan
 .K ^TMP(XUSRTN,$J)
 .S ^TMP("XUSNPIXS",$J,2,MSGCNT)="2^"_(COUNT-2)
 ;
 ; Set Summary totals
 S ^XTMP("XUSNPIXT",2)=MSGCNT_U_TOTREC_U_DTTM2
 ;
 K XUSPT,LDTCMP,SITE,XUSTAXID
 Q
 ;
EOF(XUSRTN) ;
 Q:COUNT=1
 S MSGCNT=MSGCNT+1
 S ^TMP(XUSRTN,$J,1)=XUSHDR_U_"Message Number: "_MSGCNT_U_"Line Count: "_COUNT_U_DTTM2_U_$G(XUSPROD)_U_XUSEOL
 S COUNT=COUNT+1
 S ^TMP(XUSRTN,$J,COUNT)="END OF FILE"_U_XUSEOL
 Q
 ;
 ; Email the message
EMAIL(XUSRTN) ;
 N XMY
 ; Send email to designated recipients for live release
 D MAILTO^XUSNPIX1(.XMY) ;p548
 D ESEND
 Q
 ;
ESEND N XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ,XMMG,DIFROM
 ;
 S XMTEXT="^TMP("""_XUSRTN_""","_$J_","
 S XMSUB=$TR($P($G(^TMP(XUSRTN,$J,1)),U),":")_"("_$G(XUSPROD)_") NPI EXTRACT TYPE 2"
 D ^XMD
 Q
POA(IEN,INST) ; Check Parent of Association for Institution IEN up to VISN level to see if INST is in the chain
 N XUSPOA
 I +$G(INST)=0 Q 0 ; No institution - return false
POA1 ;
 I $G(IEN)="" Q 0 ; No IEN remaining to check - return false
 I $D(XUSPOA(IEN)) Q 0 ; Already reviewed this IEN - possible infinite loop - return false
 S XUSPOA(IEN)=""
 S XUSPOA=$P($G(^DIC(4,IEN,7,2,0)),U,2) ; Get parent of this institution
 I XUSPOA=INST Q 1 ; Found matching institution - return true
 I IEN=XUSPOA Q 0 ; Top level reached - return false
 S IEN=XUSPOA ; Reset IEN to check next level
 G POA1
 ;
GETPHARM ;
 ; this subroutine retrieves data from the OUTPATIENT SITE file
 ; using the supported Pharmacy API PSS^PSO59.
 ; It takes the results and places them into a temporary 
 ; global array that is accessed when processing data
 ; associated with a pharmacy institution.
 N D,DIC,XUS59DA,XUSNPIDA,XUSRELDA,PSSTA,Y,X,XUNCP
 ;
 ;Fix for Remedy Ticket 217164
 ;Quit if Outpatient Site API routine is not loaded
 S X="PSO59" X ^%ZOSF("TEST") Q:'$T
 ;
 K ^TMP($J,"XUS59"),^TMP("XUSNPIX",$J) ; remove any pre-existing nodes
 D PSS^PSO59(,"??","XUS59")  ;IA#4827
 S XUS59DA=0
 ; gather data from each Outpatient site entry stored in the pharmacy 
 ; ^TMP global and build 2nd ^TMP global for later processing
 F  S XUS59DA=$O(^TMP($J,"XUS59",XUS59DA)) Q:'XUS59DA  D
 . ;
 . ;Get Pharmacy NPI institution from API
 . S XUSNPIDA=$P($G(^TMP($J,"XUS59",XUS59DA,101)),U)
 . Q:XUSNPIDA']""  ; NPI institution does not exist
 . ;
 . ; Get Pharmacy Related Institution from API
 . S XUSRELDA=$P($G(^TMP($J,"XUS59",XUS59DA,100)),U)
 . ; get station number off the related institution
 . S PSSTA=$P($G(^DIC(4,XUSRELDA,99)),U)
 . ;
 . ; Get NCPDP number
 . S XUNCP=""   ;prevent previous values being carried over
 . S X=XUSNPIDA S D="C",DIC=9002313.56,DIC(0)="" D IX^DIC
 . I +Y>0 S XUNCP=$$GET1^DIQ(9002313.56,+Y,.02)
 . S:$G(XUNCP)="" XUNCP=$P($G(^TMP($J,"XUS59",XUS59DA,1008)),U)
 . ;
 . ; rebuild the ^TMP global by NPI institution
 . ; collect necessary data used in the 'PHARM' logic
 . S ^TMP("XUSNPIX",$J,XUSNPIDA)=XUNCP_"^"_PSSTA ; ncpdp#^station
 Q
