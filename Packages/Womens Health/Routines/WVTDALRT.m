WVTDALRT ;ISP/RFR - TDRUGS STATUS CHANGE ALERTS;Mar 15, 2018@11:53
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 Q
ALERT(WVDFN,WVRECIP,WVMSG,WVCOUN,WVORDERS) ;Create and send alert
 ; EN^ORB3 (IA #1362): This component generates the CPRS alert
 ; INPUT: WVDFN - Patient IEN file #2
 ;        WVRECIP - Array of alert recipients IEN file #200
 ;                  WVRECIP(IEN)=""
 ;        WVMSG - Text of the alert
 ;        WVCOUN - 1 to include "Counsel rist/benefit." in alert text
 ;                 0 (default) to not include the text
 ;        WVORDER - Caret-delimited list of orders to display
 I ($G(WVDFN)=""!($D(WVRECIP)<10)!($G(WVMSG)="")!($G(WVORDERS)="")) Q
 N WVORIEN
 S WVCOUN=$G(WVCOUN,0),WVORIEN=$$GETNOTID^ORBSMART("PREG/LACT UNSAFE ORDERS")
 D:WVORIEN>0 EN^ORB3(WVORIEN,WVDFN,"",.WVRECIP,WVMSG_$S(WVCOUN:" Counsel risk/benefit.",1:""),";"_WVORDERS)
 Q
 ;
DELALERT(WVMSG,WVDFN) ;Delete existing alerts containing a specific message
 ; DELETE^XQALERT (IA #10081): This component deletes a single alert
 ; INPUT: WVMSG - Partial text of the alert
 ;        WVDFN - Patient IEN file #2
 N WVNUM,WVALERTS,XQAID
 D GETALRTS(.WVALERTS,$G(WVMSG),$G(WVDFN))
 F WVNUM=1:1:WVALERTS(0)  S XQAID=$G(WVALERTS(WVNUM)) D:XQAID'="" DELETE^XQALERT
 Q
 ;
GETALRTS(WVRETURN,WVMSG,WVDFN) ;Return alert IDs that contain a specific message
 ; PATIENT^XQALERT (IA #10081): This component retrieves all alerts for a patient
 ; INPUT: WVRETURN - reference to array in which to return alert IDs
 ;        WVMSG - Partial text of the alert
 ;        WVDFN - Patient IEN file #2
 ; RETURN: WVRETURN(0)=Number of alert IDs found
 ;         WVRETURN(N)=Alert ID
 ;             where N is a whole number starting at 1 and incrementing by 1
 S WVRETURN(0)=0
 I $G(WVMSG)=""!($G(WVDFN)<1) Q
 N WVNUM
 K ^TMP($J,"WVALERTS")
 D PATIENT^XQALERT($NA(^TMP($J,"WVALERTS")),WVDFN)
 S WVNUM=0 F  S WVNUM=$O(^TMP($J,"WVALERTS",WVNUM)) Q:'WVNUM  D
 .I $P(^TMP($J,"WVALERTS",WVNUM),U)[WVMSG,$P($P(^(WVNUM),U,2),";")="OR,"_WVDFN_",79" D
 ..S WVRETURN(0)=1+WVRETURN(0),WVRETURN(WVRETURN(0))=$P(^TMP($J,"WVALERTS",WVNUM),U,2)
 K ^TMP($J,"WVALERTS")
 Q
LACT(WVDFN,WVLASTAT) ;Entry point for processing lactation status change
 ; CALLED BY: LACTATION STATUS field (#21) of the LACTATIONS multiple field
 ;            (#50) in the WV PATIENT file (#790)
 ; INPUT: WVDFN - Patient IEN file #2
 ;        WVLASTAT - New lacation status
 Q:$G(WVNOALRT)
 I $G(WVDFN)<1!("^1^0^"'[(U_$G(WVLASTAT)_U)) Q
 I WVLASTAT D
 .D REVIEW(WVDFN,"Lactating.",,1)
 I 'WVLASTAT D DELALERT("Lactating.",WVDFN)
 Q
 ;
METHOD(WVDFN,WVDA,WVNEWREC,WVNCON)  ;Entry point for saving contraceptive method(s)
 ; FILE^DIE (IA #2053): This component updates an existing record in a file
 ; UPDATE^DIE (IA #2053): This component creates a new record in a file
 ; INPUT: WVDFN - IEN of the patient in the WV PATIENT file (#790)
 ;        WVDA - reference to FileMan DA array of parent internal entry
 ;               numbers
 ;        WVNEWREC - flag indicating whether parent is new record (1) or existing
 ;                   record (0)
 ;        WVNCON - Reference to array containing new methods used in FileMan
 ;                 FDA format
 ; OUTPUT: -1 - Error; error message returned in second caret piece
 ;         1 - Successfully saved new contraceptive method(s)
 N WVFILE,WVOLESS,WVERROR,WVNLESS,WVENTRY,WVIEN,WVECON,WVPIEN,WVALERTS
 I $G(WVDFN)="" Q -1_U_"Invalid patient identifier"
 I '$D(^WV(790,WVDFN,0)) Q -1_U_"Invalid patient identifier"
 I ('+$G(WVDA))!('+$G(WVDA(1))) Q -1_U_"Invalid parent record identifier"
 S WVPIEN=WVDA,WVPIEN("PREVIOUS")=$S($G(WVNEWREC)=1:$O(^WV(790,WVDFN,4,WVPIEN),-1),1:0)
 S WVOLESS=$$COBP^WVUTL11(WVDFN,$S(WVPIEN("PREVIOUS")>0:WVPIEN("PREVIOUS"),1:WVPIEN))
 Q:$P($G(WVOLESS),U)=-1 WVOLESS
 ;Mark existing methods not in WVNCON for deletion
 S WVIEN=0 F  S WVIEN=$O(^WV(790,WVDFN,4,WVPIEN,3,WVIEN)) Q:'+WVIEN  I '$D(WVNCON(790.17,WVIEN_","_WVPIEN_","_WVDFN_",")) D
 .S WVECON(790.17,WVIEN_","_WVPIEN_","_WVDFN_",",.01)="@"
 ;Move non-new entries from WVNCON into WVECON
 S WVIEN="" F  S WVIEN=$O(WVNCON(790.17,WVIEN)) Q:WVIEN=""  D
 .I $E(WVIEN,1)'="+" M WVECON(790.17,WVIEN)=WVNCON(790.17,WVIEN) K WVNCON(790.17,WVIEN)
 S WVFILE=1
 ;Delete existing methods and save the new/update the existing method(s)
 I $D(WVECON) D FILE^DIE("EK","WVECON","WVERROR")
 I $D(WVERROR) Q "-1"_U_"Unable to update the existing contraceptive methods: "_$$FMERROR^WVUTL11(.WVERROR)
 I $D(WVNCON) D UPDATE^DIE("E","WVNCON",,"WVERROR")
 I $D(WVERROR) Q "-1"_U_"Unable to save the new contraceptive methods: "_$$FMERROR^WVUTL11(.WVERROR)
 ;Pregnant status cannot have contraceptive methods
 I $P($G(^WV(790,WVDFN,4,WVDA,2)),U)=1 D DELALERT($$MTEXT,WVDFN) Q 1
 S WVNLESS=$$COBP^WVUTL11(WVDFN,WVPIEN)
 Q:$P(WVNLESS,U)=-1 WVNLESS
 ; If new method of contraception is less effective then existing method send alert
 I ((WVNLESS<$G(WVOLESS))&(WVNLESS>0))!(+$G(WVOLESS)=0&(WVNLESS=1)) D
 .;Don't send alert if pregnancy is desired
 .I $G(WVNOALRT)!($P($G(^WV(790,WVDFN,4,WVPIEN,2)),U,4)) Q
 .D REVIEW(WVDFN,$$MTEXT,1,,1)
 I (WVNLESS>$G(WVOLESS))!((WVNLESS=0)&(WVOLESS=1)) D DELALERT($$MTEXT,WVDFN)
 Q 1
 ;
MTEXT() ;Entry point to return starting text of notifications sent when the likelihood of
 ;       becoming pregnant changes
 Q "Pregnancy risk high."
PREG(WVDFN,WVPGSTAT) ;Entry point for processing pregnancy status change
 ; CALLED BY: PREGNANCY STATUS field (#11) of the PREGNANCIES multiple field
 ;            (#40) in the WV PATIENT file (#790)
 ; INPUT: WVDFN - Patient IEN file #2
 ;        WVPGSTAT - New pregnancy status
 Q:$G(WVNOALRT)
 I $G(WVDFN)<1!("^1^0^2^"'[(U_$G(WVPGSTAT)_U)) Q
 I WVPGSTAT=1 D REVIEW(WVDFN,"Pregnant.",1,,1)
 I WVPGSTAT'=1 D DELALERT("Pregnant.",WVDFN)
 Q
 ;
REVIEW(WVDFN,WVTEXT,WVCOUN,WVLAC,WVPRG) ;Entry point for reviewing patient's orders
 ; INPUT: WVDFN - Patient IEN file #2
 ;        WVTEXT - The first sentence of the alert text.
 ;        WVCOUN - 1 to include "Counsel rist/benefit." in alert text
 ;                 0 (default) to not include the text
 ;        WVLAC - 1 to indicate calling context is lactation
 ;                0 (default) to indicate calling context is not lactation
 ;        WVPRG - 1 to indicate calling context is pregnancy
 ;                0 (default) to indicate calling context is not pregnancy
 I $G(WVDFN)<1!($G(WVTEXT)="") Q
 S WVTEXT=$G(WVTEXT),WVCOUN=+$G(WVCOUN),WVLAC=+$G(WVLAC),WVPRG=+$G(WVPRG)
 N INPUT,WVRETURN,WVORDCHK,WVORN,WVCMUSED,WVOIN,WVALERTS,WVTXT,WVPROV
 S WVRETURN=$$GETORDRS^WVUTL11(WVDFN,WVLAC)
 S WVORN=0 F  S WVORN=$O(@WVRETURN@(WVORN)) Q:'+WVORN  S WVORDCHK="" F  S WVORDCHK=$O(@WVRETURN@(WVORN,"RULES",WVORDCHK)) Q:WVORDCHK=""  D
 .S WVTXT=WVTEXT
 .I WVLAC Q:WVORDCHK["IMAGING "!(WVORDCHK["PREG ")  D
 ..I $G(@WVRETURN@(WVORN,"IMGAGNT"))=1 S WVCOUN=0,WVTXT=WVTXT_" Imaging agent ordered. Counsel about express/discard milk." Q
 ..S WVCOUN=1,WVTXT=WVTXT_$S(WVORDCHK[1:" Potentially harmful medication.",1:" Medication with undefined risk.")
 .I WVPRG Q:WVORDCHK["LACT "  D
 ..I WVORDCHK["IMAGING" S WVTXT=WVTXT_" Imaging test ordered." Q
 ..S WVTXT=WVTXT_" Potentially harmful medication."
 .S WVPROV=$P($G(@WVRETURN@(WVORN)),U,8) Q:WVPROV=""
 .S WVALERTS(WVTXT,"PROVIDERS",WVPROV)=$S($G(WVALERTS(WVTXT,"PROVIDERS",WVPROV))'="":WVALERTS(WVTXT,"PROVIDERS",WVPROV)_U,1:"")_WVORN
 .S WVALERTS(WVTXT,"WVCOUN")=WVCOUN
 Q:'$D(WVALERTS)
 D DELALERT(WVTEXT,WVDFN)
 S WVTXT="" F  S WVTXT=$O(WVALERTS(WVTXT)) Q:WVTXT=""  S WVPROV=0 F  S WVPROV=$O(WVALERTS(WVTXT,"PROVIDERS",WVPROV)) Q:'+WVPROV  D
 .N WVPROVS S WVPROVS(WVPROV)=""
 .D ALERT(WVDFN,.WVPROVS,WVTXT,WVALERTS(WVTXT,"WVCOUN"),WVALERTS(WVTXT,"PROVIDERS",WVPROV))
 K @WVRETURN
 Q
 ;
TRY(WVDFN,WVTSTAT)  ;Entry point for processing trying to become pregnant
 ; status change
 ; CALLED BY: TRYING TO BECOME PREGNANT field (#14) of the PREGNANCIES multiple field
 ;            (#40) in the WV PATIENT file (#790)
 ; INPUT: WVDFN - Patient IEN file #2
 ;        WVTSTAT - New trying to become pregnant status
 Q:$G(WVNOALRT)
 I $G(WVDFN)<1!("^1^0^"'[(U_$G(WVTSTAT)_U)) Q
 I WVTSTAT D REVIEW(WVDFN,"Pregnancy desired.",1,,1)
 I 'WVTSTAT D DELALERT("Pregnancy desired.",WVDFN)
 Q
 ;
