RAIPS196 ;WOIFO/KLM - PostInit 196 ; Dec 08, 2022@11:47:48
 ;;5.0;Radiology/Nuclear Medicine;**196**;Mar 16, 1998;Build 1
 ;
 ; This post-install routine will loop through all HELD,
 ; COMPLETED, and DISCONTINUED Radiology orders and determine
 ; if they've been referred to community care via the auto
 ; referral option. If so, the REFERRED TO COMMUNITY CARE?
 ; field (#201) will be set to YES.
 ;
 ;
 ; Field #201 in file #75.1 is new with patch RA*5*196
 ;
 ; File/API            IA          Type
 ; -------------------------------------
 ; ^OR(100,D0,8,D1    6475        (P)
 ; ^GMR(123           6116        (C)
 ; INSTALDT^XPDUTL    10141       (S)
 ; SENDMSG^XMXAPI     2729        (S)
 ;
EN1 ;entry point from KIDS
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE S ZTIO=""
 S ZTRTN="TASK^RAIPS196",(ZTDESC,RATXT(1))="RA196: Identify auto referred orders to community care"
 S ZTDTH=$H D ^%ZTLOAD S RATXT(2)="Task: "_$S($G(ZTSK)>0:ZTSK,1:"in error")
 D BMES^XPDUTL(.RATXT)
 Q
 ;
TASK ;Task entry point
 N RATEXT
 D ORDERCHK ;Check referred order
 D MSG
 Q
ORDERCHK ;search for held, completed and discontinued referred orders
 N RA148DT,RAODD,RAR,RAOIEN,RAORDA,RAERR,RARC,RAEC,RATC,RAIENS,RAFDA,RAORACT
 N RASQ,RASPACE,RACODE,RAEIEN,RAERTX,RAL
 F RASQ=1:1:50 S RASPACE=$G(RASPACE)_" "
 S (RARC,RAEC,RATC)=0
 D INSTALDT^XPDUTL("RA*5.0*148",.RAR)
 Q:RAR<1  ;148 not installed
 S RA148DT=$P($O(RAR(0)),".") Q:RA148DT=""  ;no install date
 S RAODD=RA148DT F  S RAODD=$O(^RAO(75.1,"BDD",RAODD)) Q:RAODD=""  D
 .S RAOIEN="" F  S RAOIEN=$O(^RAO(75.1,"BDD",RAODD,RAOIEN)) Q:RAOIEN=""  D
 ..I "^1^2^3^"'[$P(^RAO(75.1,RAOIEN,0),U,5) Q
 ..S RAORDA=$P(^RAO(75.1,RAOIEN,0),U,7) Q:RAORDA=""
 ..S RAORDA=RAORDA_",",RATC=RATC+1 ;increment total counter
 ..K RAORACT D GETS^DIQ(100,RAORDA,".8*","N","RAORACT") ;order actions
 ..I '$D(RAORACT) Q
 ..I $$CHKORACT(.RAORACT) D
 ...K RAIENS,RAFDA
 ...S RAIENS=RAOIEN_"," S RAFDA(75.1,RAIENS,201)="YES"
 ...K RAERR D FILE^DIE("EK","RAFDA","RAERR")
 ...I $D(RAERR) S RATEXT(10)="There was a problem updating some orders:" D
 ....S RATEXT(12)="ORDER IEN         ERROR"
 ....S RATEXT(13)="----------------  ------------------------------------------"
 ....S RAEIEN=+$G(RAERR("DIERR",1,"PARAM","IENS")),RAL=$L(RAEIEN),RAEC=RAEC+1
 ....S RAERTX=$E($G(RAERR("DIERR",1,"TEXT",1)),1,42)
 ....S RACODE=$G(RAERR("DIERR",1))
 ....S RATEXT(13+RAEC)=RAEIEN_$E(RASPACE,1,18-RAL)_"("_RACODE_") "_RAERTX
 ....Q
 ...E  S RARC=RARC+1 ;increment referred counter
 ...Q
 ..Q
 .Q
 S RATEXT(8)="Total orders checked: "_RATC
 I RARC>0 S RATEXT(9)="Total orders updated: "_RARC
 E  S RATEXT(9)="There were no auto referred orders found to update."
 ;ZW RATEXT
 Q
CHKORACT(RAORACT) ;Check if order was referred using our option
 N RACOM,RAIENS,RAQ,RA123 S RAQ=0
 S RAIENS="" F  S RAIENS=$O(RAORACT(100.008,RAIENS)) Q:RAIENS=""  D
 .S RACOM=$G(RAORACT(100.008,RAIENS,1))
 .I RACOM["Placed on hold due to transfer to Community Care with UCID" D
 ..S RA123=$P(RACOM,"UCID",2) Q:'$D(RA123) 
 ..S RA123=$P(RA123,"_",2) I RA123?1.N,$D(^GMR(123,RA123)) S RAQ=1
 ..Q
 .Q
 Q RAQ
MSG ;send results via Mailman
 N RAID,RASUB,RAREC,RAINSTR
 I '$D(RATEXT) S RATEXT(8)="*** No referred orders found! ***"
 ;Mail message introductory blurb...
 S RATEXT(1)="The Post-Init task for RA*5.0*196 searched for radiology"
 S RATEXT(2)="orders in a complete, discontinued or held status that"
 S RATEXT(3)="have previously been referred to community care using"
 S RATEXT(4)="the Refer Selected Requests to COMMUNITY CARE Provider"
 S RATEXT(5)="option. Orders previously referred using this option"
 S RATEXT(6)="had the new Referred to Community Care? field set to YES."
 S RATEXT(7)="",RATEXT(11)=""
 ;XMTEXT for message text
 ;S XMTEXT="RATEXT("
 S RASUB="RAD/NUC MED RA*5.0*196 Post-Install Information"
 S RAID=+$G(DUZ)
 S RAREC(RAID)="" ;send to installer
 S RAINSTR("FROM")="RA*5.0*196 Post-Install"
 D SENDMSG^XMXAPI(RAID,RASUB,"RATEXT",.RAREC,.RAINSTR,,)
 Q
