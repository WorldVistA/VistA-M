IBCIUT4 ;DSI/SLM - MISC UTILITIES ;29-JAN-2001
 ;;2.0;INTEGRATED BILLING;**161,226,348**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
COMERR ;create msg for comm error
 NEW L,L1,MGROUP,TEXT,IBCISMG,IBCIERR
 I '$D(IBCICLNP) S IBCICLNP=$P(^DGCR(399,IBIFN,0),U)
 S MGROUP=$P(^IBE(350.9,1,50),U,4),MGROUP=$P(^XMB(3.8,MGROUP,0),U),L1=1
 S IBCIERR=$$P1(PROBLEM)
 D SNTMSG
 S TEXT(L1)="        ** CLAIMSMANAGER COMMUNICATIONS ERROR **",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="While attempting to send claim # "_IBCICLNP_", Error Code # "_$P(IBCIERR,U,1),L1=L1+1
 S TEXT(L1)="was generated.",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="User attempted "_IBCISMG,L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="Error Description:",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=$P(IBCIERR,U,2),L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 I $P(IBCIERR,U,3)'="" D
 . S TEXT(L1)="ClaimsManager Error Message:",L1=L1+1
 . S TEXT(L1)=" ",L1=L1+1
 . S TEXT(L1)=$P($P(IBCIERR,U,3)," - ",1),L1=L1+1
 . S TEXT(L1)=$P($P(IBCIERR,U,3,99)," - ",2,99),L1=L1+1
 . S TEXT(L1)=" ",L1=L1+1
 . Q
 ;
 ; esg - 10/29/01 - Direct the reader to the Clear CM Results Queue
 ;       option if the problem does not go away.
 ;
 I PROBLEM=99 S TEXT(L1)="Please correct the problem and send again.",L1=L1+1
 E  D
 . S TEXT(L1)="If this problem persists, then please try running the",L1=L1+1
 . S TEXT(L1)="option to clear out the ClaimsManager results queue.",L1=L1+1
 . S TEXT(L1)="This option name is IBCI CLEAR CLAIMSMANAGER QUEUE.",L1=L1+1
 . Q
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)="Bill Sent By: "_$P(^VA(200,DUZ,0),U)
 S XMSUB="ClaimsManager Communications Error sending "_IBCICLNP
 S XMDUZ="ClaimsManager Interface",XMTEXT="TEXT(",XMY("G."_MGROUP)=""
 D ^XMD
 K XMSUB,XMDUZ,XMTEXT,TEXT
 Q
GENERR(IBIFN,IBCIETP) ;create msg for general error
 Q:IBCISNT'=2
 NEW L,L1,L2,L3,MGROUP,TEXT,XMTEXT,XMY,XMSUB,XMDUZ,USER,IBCISMG,IBCIE1
 I '$D(IBCICLNP) S IBCICLNP=$P(^DGCR(399,IBIFN,0),U)
 S MGROUP=$P(^IBE(350.9,1,50),U,3),MGROUP=$P(^XMB(3.8,MGROUP,0),U),L1=1
 D SNTMSG
 S TEXT(L1)="User attempted "_IBCISMG,L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 ;pull error msg from 351.9 based on mnemonic (IBCIETP) error type
 S IBCIE1=0 F  S IBCIE1=$O(^IBA(351.9,IBIFN,1,"B",IBCIETP,IBCIE1)) Q:'IBCIE1  D
 .S TEXT(L1)="Line Item: "_+$P(^IBA(351.9,IBIFN,1,IBCIE1,0),U,2),L1=L1+1
 .S TEXT(L1)="Error Mnemonic: "_$P(^IBA(351.9,IBIFN,1,IBCIE1,0),U),L1=L1+1
 .S TEXT(L1)="Error Level: "_$P(^IBA(351.9,IBIFN,1,IBCIE1,0),"~",2),L1=L1+1
 .S TEXT(L1)=" ",L1=L1+1
 .S TEXT(L1)="Error Message:",L1=L1+1
 .S L2=0 F  S L2=$O(^IBA(351.9,IBIFN,1,IBCIE1,L2)) Q:'L2  D
 ..S L3=0 F  S L3=$O(^IBA(351.9,IBIFN,1,IBCIE1,L2,L3)) Q:'L3  D
 ...S TEXT(L1)=^IBA(351.9,IBIFN,1,IBCIE1,L2,L3,0),L1=L1+1
 .S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=" ",XMTEXT="TEXT("
 S XMY(DUZ)="",XMY("G."_MGROUP)=""
 ;
 ; Additionally, send this MailMan message to the biller, the 
 ; assigned to person, the person who last edited this bill, and 
 ; the person who last sent it to ClaimsManager.
 ; esg - 9/5/01 & 9/27/01
 ;
 S USER=+$$BILLER^IBCIUT5(IBIFN) I USER S XMY(USER)=""
 S USER=+$P($G(^IBA(351.9,IBIFN,0)),U,12) I USER S XMY(USER)=""
 S USER=+$P($G(^IBA(351.9,IBIFN,0)),U,9) I USER S XMY(USER)=""
 S USER=+$P($G(^IBA(351.9,IBIFN,0)),U,5) I USER S XMY(USER)=""
 ;
 S XMSUB="ClaimsManager Claim "_IBCICLNP_" Returned with Errors"
 S XMDUZ="ClaimsManager Interface"
 D ^XMD
 Q
SNTMSG ;determine what user was doing for message
 ;
 I IBCISNT=1 S IBCISMG="a Normal Send after Editing."
 I IBCISNT=2 S IBCISMG="a Normal Send from the Multiple Send Option."
 I IBCISNT=3 S IBCISMG="a Test Send from the Edit Screens."
 I IBCISNT=4 S IBCISMG="to Cancel the Claim."
 I IBCISNT=5 S IBCISMG="to Override the Errors."
 I IBCISNT=6 S IBCISMG="to Send an Authorized Claim from the Multiple Send Option."
 I IBCISNT=7 S IBCISMG="to delete the lines on this bill which is no longer a CMS-1500."
 Q
 ;
 ;TCK CALL check text for ClaimsManager delimiters and strip if found
 ;Input variable
 ;  x
TCK() ;check text for characters used as delimiters and strip them out
 Q:$G(X)=""  S X=$TR(X,$C(28,29,30)_"'%")
 Q
CCK() ;check codes for decimal points and strip them out
 Q:$G(X)=""  S X=$TR(X,".")
 Q
Z1AR ;converts ibciz array to ibciz1 array and import into error field
 Q:'$D(IBCIZ)  K IBCIZ1
 S ERNUM=0 F  S ERNUM=$O(IBCIZ("RL",ERNUM)) Q:'ERNUM  D
 .I $P(IBCIZ("RL",ERNUM,0),U,2)="" Q
 .S IBCIZ1(ERNUM,0)=$P(IBCIZ("RL",ERNUM,0),U,2)_U_$P(IBCIZ("RL",ERNUM,0),U)_U_$P(IBCIZ("RL",ERNUM,0),U,3,999)
 .S LINE=0 F  S LINE=$O(IBCIZ("RL",ERNUM,"E",LINE)) Q:'LINE  D
 ..S IBCIZ1(ERNUM,LINE)=IBCIZ("RL",ERNUM,"E",LINE)
 I IBCISNT>2 G Z1Q
 I $P($G(^IBA(351.9,IBIFN,1,0)),U,4) D DELER
 S IBCIN1=0 F  S IBCIN1=$O(IBCIZ1(IBCIN1)) Q:'IBCIN1  D ADDSUB1
Z1Q K DIC,DIE,DA,L1,LINE,ERDT,IBCIN1,ERNUM
 Q
PROC() ;convert procedure code
 Q:$G(X)=""  N DA,GNODE
 S DA=$P(X,";"),GNODE="^"_$P(X,";",2)_DA_",0)",X=$P(@GNODE,U)
 Q
ADDSUB1 ;create the subfile for errors and add data
 S DIC="^IBA(351.9,"_IBIFN_",1,",DA(1)=IBIFN,DIC(0)="LMN"
 S X=$P(IBCIZ1(IBCIN1,0),U) D FILE^DICN Q:Y<1  S DA=+Y
 S ERDT=$P(IBCIZ1(IBCIN1,0),U,2,999),ERDT=$TR(ERDT,"^","~")
 S DIE=DIC,DR=".02////"_ERDT D ^DIE
 S L1=0 F  S L1=$O(IBCIZ1(IBCIN1,L1)) Q:'L1  D
 .S IBCIZ1(IBCIN1,L1)=$TR(IBCIZ1(IBCIN1,L1),";",",")
 .S DR=".03///+"_IBCIZ1(IBCIN1,L1) D ^DIE
 Q
DELER ;delete the error information in 351.9
 Q:'IBIFN
 Q:'$P($G(^IBA(351.9,IBIFN,1,0)),U,4)
 S DIK="^IBA(351.9,"_IBIFN_",1,",DA(1)=IBIFN
 S DA=0 F  S DA=$O(^IBA(351.9,IBIFN,1,DA)) Q:'DA  D ^DIK
 K DIK,DA
 Q
DELTI ;delete temporary information in 351.9
 N IBCIX4,TMPDATA,NODE
 S DIE="^IBA(351.9,"_IBIFN_",5,"
 F IBCIX4=$P($G(^IBA(351.9,IBIFN,5,0)),U,4):-1:1 S DA=IBCIX4 D
 .S DA(1)=IBIFN,DR=".01////@" D ^DIE
 K DIE,DR,DA
 I $D(^IBA(351.9,IBIFN,4)) D
 .S DIE="^IBA(351.9,",DA=IBIFN
 .S DR="4.01////@;4.02////@;4.03////@;4.04////@" D ^DIE
 K DIE,DR,DA
 I $D(^IBA(351.9,IBIFN,3)) D
 .S DIE="^IBA(351.9,",DA=IBIFN
 .S DR="3.01////@;3.02////@;3.03////@;3.04////@;3.05////@;3.06////@;"
 .S DR=DR_"3.07////@;3.08////@;3.09////@;3.1////@;3.11////@;3.12////@"
 .D ^DIE K DIE,DR,DA
 F NODE=3,4,5 S TMPDATA="^IBA(351.9,IBIFN,NODE)" K @TMPDATA
 Q
 ;
DCOM(IBIFN) ;delete whatever's in the comment field in 351.9
 S DIE="^IBA(351.9,",DA=IBIFN,DR="2.01///@;.13///@;.14///@"
 D ^DIE K DIE,DA,DR
 Q
 ;
P1(PROBLEM) ;comm error handling with problem variable
 ;Input variable
 ;  PROBLEM
 ;Returns
 ;  error code^error desc^msg returned from ClaimsManager
 N IBCIY,IBCICODE,IBCIDESC,IBCIMSG S IBCICODE=PROBLEM
 I IBCICODE=1 S IBCIDESC="TCP/IP time-out during 1st read." D
 .S IBCIMSG=$G(IBCIZ)_" - "_$G(IBCIZ(1,1))
 I IBCICODE=2 S IBCIDESC="Local Symbol Size Storage Problems during 1st read."
 I IBCICODE=3 S IBCIDESC="1st read was NOT a ClaimsManager ACK message." D
 .S IBCIMSG=$G(IBCIZ)_" - "_$G(IBCIZ(1,1))
 I IBCICODE=4 S IBCIDESC="TCP/IP Time-out during 2nd read." D
 .S IBCIMSG=$G(IBCIZ)_" - "_$G(IBCIZ(1,1))
 I IBCICODE=5 S IBCIDESC="Local Symbol Size Storage Problems during 2nd read."
 I IBCICODE=6 S IBCIDESC="2nd read was NOT a RESULTREC message type." D
 .S IBCIMSG=$G(IBCIZ)_" - "_$G(IBCIZ(1,1))
 I IBCICODE=7 S IBCIDESC="Fatal System Error",IBCIMSG=$G(IBCIZ)_" - "_$G(IBCIZ(1,1)) ; ib*226
 I IBCICODE=99 S IBCIDESC="Unable to Open Port." D
 .S IBCIMSG="Please restart the Ingenix Event Manager services."
 I "^1^2^3^4^5^6^7^99^"'[IBCICODE S IBCIDESC="Unknown Error Type."
 S IBCIY=IBCICODE_"^"_IBCIDESC_"^"_$G(IBCIMSG)
 Q IBCIY
 ;
