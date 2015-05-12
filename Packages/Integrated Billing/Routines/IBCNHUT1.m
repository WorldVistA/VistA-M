IBCNHUT1 ;ALB/GEF - HPID/OEID UTILITIES ;11-MAR-14
 ;;2.0;INTEGRATED BILLING;**519,521**;21-MAR-94;Build 33
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; this routine contains various utilities for the HPID project.
 Q
 ;
HOD(ID,INS,IBHD) ; function to determine if the data is an HPID, an OEID, or an invalid ID
 ; HPID/OEID is a 10 character string with the 1st digit being 7 for HPID & 6 for OEID
 ; and the 10th digit being a LUHN Check digit. If the optional INS value is passed, an 
 ; additional validation check will be done, comparing the ID to what is currently on file 
 ; for that insurance company ien. 
 ;
 ; returns data string:    H for HPID, O for OEID, -1 for Invalid ID                   
 ; to call:  W $$HOD^IBCNHUT1(X,INS) or I $$HOD^IBCNHUT1(X,INS) it is not a valid ID
 ;
 ; ID = data string to validate (required)
 ; INS = insurance co. ien (optional)
 ; IBHD = Insurance co HPID in file 36 (optional)
 ;
 Q:ID'?10N "-1^HPID/OEID^*"
 ; verify the 10th digit is the Luhn check-digit
 Q:$E(ID,10)'=$$CKDGT($E(ID,1,9)) "-1^HPID/OEID^*"
 ; verify the ID matches what is in the insurance file
 I $G(INS)'="",$G(IBHD)="" S IBHD=$$HPD(INS)
 I $G(IBHD)>0,IBHD'=ID Q "-1^HPID/OEID^*"
 Q:$E(ID)=7 "H^     HPID^"
 Q:$E(ID)=6 "O^     OEID^"
 Q "-1^HPID/OEID^*"
 ;
HPD(INS,V) ; this function returns the HPID/OEID for an insurance company
 ; The user must pass INS = Insurance Company ien in file 36
 ; V = 1 means run validation checks (not required).  Will append an '*'  to the HPID if it does NOT pass validation checks
 ;
 N IBHPD
 Q:$G(INS)="" ""
 S IBHPD=$P($G(^DIC(36,INS,8)),U) Q:IBHPD="" ""
 Q $S($G(V)=1:IBHPD_$P($$HOD(IBHPD,INS,IBHPD),U,3),1:IBHPD)
 Q ""
 ;
INS(ID,TYP,IBID) ; this function finds the ien of the insurance company entry in file 36 using the NIF ID or the HPID/OEID
 ; TYPE=N for NIF or H for HPID/OEID
 ; returns data array:  IBID(0)=number of entries with this ID, IBID(n)=IEN^ID^Insurance Company name
 ; TO CALL:  $$INS^IBCNHUT1(ID,TYP,.ARRAY NAME)
 ; 11/7/14 - cross-reference format changed with HPID Build 2, now AHOD & ANIF
 N C,IEN
 S IBID(0)=0,IBID=""
 Q:$G(ID)<1 IBID
 I $E(TYP)="N" D
 .S IEN=0,C=0 F  S IEN=$O(^DIC(36,"ANIF",ID,IEN)) Q:'IEN  D
 ..S C=C+1,IBID(0)=C,IBID(C)=IEN_U_ID_U_$P($G(^DIC(36,IEN,0)),U)
 I $E(TYP)="H" D
 .S IEN=0,C=0 F  S IEN=$O(^DIC(36,"AHOD",ID,IEN)) Q:'IEN  D
 ..S C=C+1,IBID(0)=C,IBID(C)=IEN_U_ID_U_$P($G(^DIC(36,IEN,0)),U)
 Q IBID
 ;
NIF(INS) ; this function finds the NIF ID for an insurance company using the ien 
 ; INS=Insurance Company ien in file 36
 ;
 Q:$G(INS)="" ""
 Q $P($G(^DIC(36,INS,8)),U,4)
 Q ""
 ;
SHP(INS) ; this function determines if the entry is a CHP or SHP
 ; INS = insurance company ien in file 36.  Returns C for CHP (Controlling Health Plan) and S for SHP (Sub-Health Plan)
 ;
 Q:$G(INS)="" ""
 Q $P($G(^DIC(36,INS,8)),U,2)
 Q ""
 ;
PHP(INS) ; this function returns the parent HPID insurance company if applicable
 ;
 Q:$G(INS)="" ""
 Q $P($G(^DIC(36,INS,8)),U,3)
 Q ""
 ;
VID(INS) ; this function gets the VA National ID for the insurance company/payer
 ; 
 N IBAPP,IBPYR,IBPY0
 ; get the ien of the IIV payer application
 S IBAPP=$O(^IBE(365.13,"B","IIV","")) Q:IBAPP="" ""
 ; find the payer
 S IBPYR=$P($G(^DIC(36,INS,3)),U,10) Q:IBPYR="" ""
 S IBPY0=$G(^IBE(365.12,IBPYR,1,IBAPP,0)) I $P(IBPY0,U,2)=1,$P(IBPY0,U,3)=1 Q $P($G(^IBE(365.12,IBPYR,0)),U,2)
 Q ""
 ;
UID(INS) ; this function creates the Vista Unique Site ID to send to the NIF
 ; returns station#_"."_insurance company ien
 Q:INS="" ""
 Q $P($$SITE^VASITE(),U,3)_"."_INS
 ;
TRG1(IEN,ST) ; this function sets the trigger for the DATE OF FUTURE PURGE (.1) field in file #367.1 
 ;(HPID/OEID TRANSMISSION QUEUE).  If the PROCESSING STATUS (.05) = R for Response Recieved or EXR
 ; for Exception Report Reject and the response included a NIF ID, set the purge date to T+14
 ; called from field .05 (PROCESSING STATUS ) of file 367 (HPID/OEID RESPONSE).
 ; IEN = entry number in file 367, ST=Transmission status being set
 ;
 N RSP,ID
 ; as of 6/23/14, no longer purging EXR
 ;I $E(ST)'="R"&(ST'="EXR") Q ""
 Q:$E(ST)'="R" ""
 ; if response type is UNSOLICITED, set purge date (don't care about NIF ID for these)
 Q:$P($G(^IBCNH(367,IEN,0)),U,3)="U" $$FMADD^XLFDT($$NOW^XLFDT,+14)
 ; also don't care about NIF ID if EXR
 ; as of 6/23/14, don't set purge data for EXR
 ;Q:ST="EXR" $$FMADD^XLFDT($$NOW^XLFDT,+14)
 ; check response in file 367 for NIF ID, if response contains NIF ID, set future purge date
 ; format of D xref:  ^IBCNH(367,"D",8 (for NIF ID),ien in file 367,ID multiple ien)=""
 Q:'$D(^IBCNH(367,"D",8,IEN)) ""
 S ID=$O(^IBCNH(367,"D",8,IEN,"")) Q:$P($G(^IBCNH(367,IEN,1,ID,0)),U,2)="" ""
 Q $$FMADD^XLFDT($$NOW^XLFDT,+14)
 ;
UNSOL(HLID,RTY,ID,DATA) ; this code handles unsolicited responses which only have the NIF ID, no insurance ien
 ; If there are multiple entries in file 36 with the same NIF ID, this code will update all of them.
 ;
 N DIC,X,Y,DIE,DA,DR,I,C,INS,PS,ARRAY,DLAYGO
 Q:RTY'="U" "-1^ED^Error:  Not an unsolicited response!"
 ; create new entry in 367 for unsolicited responses
 S DIC="^IBCNH(367,",DIC(0)="LS",X=HLID,DLAYGO=367 D ^DIC S IEN=+Y Q:Y=-1 "-1^ED^DATABASE Error:  HPID RESPONSE entry NOT added!"
 S DIE=DIC,DA=IEN,DR=".01///"_HLID_";.03///"_RTY K DIC D ^DIE
 ; Now find every entry in file 36 that has this NIF ID and update it
 S X=$$INS($P(ID,U,8),"N",.ARRAY)
 ; loop through each entry and update file 36
 S C=$G(ARRAY(0)) S:C<1 PS=IEN_"^ED^DATABASE Error:  NIF ID does not exist at this site!"
 F I=1:1:C S INS=$P($G(ARRAY(I)),U),PS=$$FM36^IBCNHUT2(INS,$P(ID,U,9)_U_$P(DATA,U,9)_U_$P(DATA,U,8)_U_$P(ID,U,8))
 ; update field .05 in file 367 (PROCESSING STATUS)
 Q $$STAT(IEN,$P(PS,U,2))
 ;
STAT(IEN,STAT) ; updates field .05 in file 367 (PROCESSING STATUS)
 N DIC,DA,DR
 S DIE="^IBCNH(367,",DA=IEN,DR=".05///"_STAT D ^DIE
 K DIC,DA,DR
 Q IEN
 ;
CKDGT(ID) ; Function to calculate and return the check digit of an HPID
 ;  The check digit is calculated using the Luhn Formula for
 ;  Modulus 10 "double-add-double" Check Digit.  A value of 24 is
 ;  added to the total to account for the implied USA (80840) prefix.
 ;
 N IBCTOT,IBCN,IBCDIG,IBI
 S IBCTOT=24
 F IBI=9:-2:1 S IBCN=2*$E(ID,IBI),IBCTOT=IBCTOT+$E(IBCN)+$E(IBCN,2)+$E(ID,IBI-1)
 S IBCDIG=150-IBCTOT
 Q $E(IBCDIG,$L(IBCDIG))
 ;
EXR(INS) ; Purge EXR records if the EDI numbers get updated.
 ; if the insurance company has an EXR response (Exception Report Reject), and the EDI#'s
 ; get updated, purge the EXR response.
 Q:INS=""
 N DA,TQIEN,RSIEN,DIK
 S TQIEN="" F  S TQIEN=$O(^IBCNH(367.1,"INS",INS,TQIEN)) Q:'TQIEN  D
 .S RSIEN=$P($G(^IBCNH(367.1,TQIEN,0)),U,7) Q:RSIEN=""
 .Q:$P($G(^IBCNH(367,RSIEN,0)),U,5)'="EXR"
 .S DA=TQIEN,DIK="^IBCNH(367.1," D ^DIK
 .S DA=RSIEN,DIK="^IBCNH(367," D ^DIK
 K DA,TQIEN,RSIEN,DIK
 Q
