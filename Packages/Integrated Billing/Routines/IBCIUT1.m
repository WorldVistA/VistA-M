IBCIUT1 ;DSI/SLM - MISC UTILITIES FOR CLAIMSMANAGER INTERFACE ;21-DEC-2000
 ;;2.0;INTEGRATED BILLING;**161,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
NOW ;get current (or specific) date/time and convert to ClaimsManager format
 ;
 ;Input variable
 ;  x = date or date/time (for date/time other than now)
 ;Output variable
 ;  y = date or date/time in claimsmanager format
 ;  (yyyymmdd) or (yyyymmddhhmmss)
 ;
 NEW YEAR,MON,DAY,HOUR,MIN,SEC
 I '$G(X) S X=$$NOW^XLFDT
 S YEAR=$E(X,1,3)+1700,MON=$E(X,4,5),DAY=$E(X,6,7)
 I MON="00" S MON="01"
 I DAY="00" S DAY="01"
 I +$P(X,".",2) D
 .S HOUR=$E($P(X,".",2),1,2),MIN=$E($P(X,".",2),3,4),SEC=$E($P(X,".",2),5,6)
 .S Y=YEAR_MON_DAY_HOUR_MIN_SEC
 E  S Y=YEAR_MON_DAY
 Q
NOW1(X) ;change date from mmddyyyy to yyyymmdd
 N DATE,MM,DD,YY
 S MM=$E(X,1,2),DD=$E(X,3,4),YY=$E(X,5,8)
 S DATE=YY_MM_DD
 Q DATE
NAMSP ;split name into three pieces LAST^FIRST^MIDDLE
 ;Input variable
 ;  x = LAST,FIRST MIDDLE
 ;Output variable
 ;  y = LAST^FIRST^MIDDLE
 ;
 N NAME S Y=""
 S NAME(1)=$P(X,","),NAME(2)=$P(X,",",2,999)
 S NAME(3)=$P(NAME(2)," ",2,999)
 S NAME(2)=$P(NAME(2)," ",1)
 S Y=NAME(1)_"^"_NAME(2)_"^"_NAME(3)
 Q
 ;
CM(IBIFN) ;
 ; ClaimsManager environment check for IB routines.  Checks to make
 ; sure CM is running and that the bill is a HCFA 1500 form type bill.
 ; Any other condition will return false.
 ;
 N Y
 S Y=0
 I $G(IBIFN),$$CK0(),'$$CK1(IBIFN) S Y=1
 Q Y
 ;
CK0() ;checks to see if running ClaimsManager
 ;returns a 1 if running ClaimsManager
 N Y
 S Y=$S($P($G(^IBE(350.9,1,50)),U)=1:1,1:0)
 Q Y
 ;
CK1(IBIFN) ;checks to see if it's a HCFA 1500 claim form
 ;returns 0 if HCFA 1500, returns 1 if any other form type
 ;
 N IBX,IBY
 S IBY=$P($G(^DGCR(399,IBIFN,0)),U,19)
 S IBX=$S(IBY=2:0,1:1)
 Q IBX
 ;
CK2() ;checks to see if ClaimsManager is working ok
 ;returns a 1 if running ok
 ;
 N Y
 S Y=$S($P($G(^IBE(350.9,1,50)),U,2)=1:1,1:0)
 Q Y
 ;
ST(IBCIST) ;set status field to ibcist
 ;
 ;input variables
 ;  ibifn
 ;  ibcist
 I '$D(IBIFN) Q
 I '$D(IBCIST) Q
 S IENS=IBIFN_",",FDA(351.9,IENS,.02)=IBCIST
 D FILE^DIE("K","FDA")
 K FDA,IENS
 Q
 ;
STAT(IBIFN) ;return value of status field in 351.9
 N IBCIST1
 S IBCIST1=$P(^IBA(351.9,IBIFN,0),U,2)
 Q IBCIST1
 ;
 ;
LITMS(IBIFN) ; Returns the number of line items
 NEW IBXARRAY,IBXARRY,IBXDATA,IBXERR
 KILL ^TMP("IBXSAVE",$J)
 D F^IBCEF("N-HCFA 1500 SERVICES (PRINT)",,,IBIFN)
 Q +$O(IBXDATA(""),-1)
 ;
 ;
LSTA(IBCISNT) ; return the correct Ingenix line status based on the value
 ;         of IBCISNT - where is the interface called from?
 Q $S(IBCISNT=5:"P",IBCISNT=4:"D",IBCISNT=7:"D",1:"A")
 ;
RPHY(IBIFN) ; Attending/rendering physician information
 ;
 ; This function returns the physician information for bill# IBIFN.
 ; Data is returned in a pieced string:
 ;
 ;   [1] Name
 ;        for non-VA, this may be a facility (if no comma in Name)
 ;   [2] ID#
 ;        File 200 ien# for VA; "NVA"_ien# for non-VA
 ;   [3] Department
 ;        Service/Section file ien# for VA; "NVA" for non-VA
 ;   [4] Specialty
 ;
 NEW IBXDATA,IBXARRAY,IBXARRY,IBXERR,Y,IBPRV
 S Y=""
 D F^IBCEF("N-ATT/REND PHYSICIAN NAME",,,IBIFN)
 S IBPRV=$P($G(IBXDATA),U,2)
 I 'IBPRV G RPHYX
 S $P(Y,U,1)=$P(IBXDATA,U,1)
 S $P(Y,U,4)=$$BILLSPEC^IBCEU3(IBIFN,IBPRV)
 ;
 ; Check for VA provider first and then get out
 I IBPRV'["IBA(355.93" D  G RPHYX
 . S $P(Y,U,2)=+IBPRV
 . S $P(Y,U,3)=$P($G(^VA(200,+IBPRV,5)),U,1)
 . Q
 ;
 ; Now we're dealing with a Non-VA provider
 S $P(Y,U,2)="NVA"_+IBPRV
 S $P(Y,U,3)="NVA"
RPHYX ;
 Q Y
 ;
CKNER() ;check for no errors
 ;returns 1 if no errors, 0 if errors were found
 N IBCIY,LSEG S LSEG=0,IBCIY=1
 F  S LSEG=$O(IBCIZ("RL",LSEG)) Q:'LSEG  D
 .I $P(IBCIZ("RL",LSEG,0),U,2)]"" S IBCIY=0
 Q IBCIY
CKLI(IBIFN) ;check for line items
 N LITEM
 I '$P($G(^IBA(351.9,IBIFN,3)),U,1) D UPDT^IBCIADD1     ; build if not there
 S LITEM=$S(+$P($G(^IBA(351.9,IBIFN,5,0)),U,4)>0:1,1:0)
 Q LITEM
 ;
 ;
CKFT(IBIFN) ; Check for a form type change by the user
 NEW D0,DA,DB,DC,DE,DH,DI,DIC,DIE,DIEL,DIFLD,DIG,DIH
 NEW DIK,DIPA,DIV,DK,DL,DM,DP,DQ,DR,X,Y
 NEW IBCISNT,IBCISTAT,IBCIREDT,IBCIERR
 I '$$CK0() Q        ; esg - 7/17/01 - bug fix
 ;
 ; If it's not there, but it is a hcfa 1500, then add it
 I '$D(^IBA(351.9,IBIFN)),'$$CK1(IBIFN) D ST1^IBCIST G CKFTX
 ;
 ; If it's there, but no longer a hcfa 1500, then delete it.
 ; esg - 1/3/2002 - If it has been sent to CM previously, then
 ;       we need to send it with new send type 7.
 I $D(^IBA(351.9,IBIFN)),$$CK1(IBIFN) D
 . I $P($G(^IBA(351.9,IBIFN,0)),U,15) S IBCISNT=7 D ST2^IBCIST
 . S DIK="^IBA(351.9,",DA=IBIFN D ^DIK
 . Q
CKFTX ;
 Q
 ;
 ;
DIAG(IBIFN) ;return array of diagnosis codes for each line item
 NEW IBXDATA,IBXARRAY,IBXARRY,IBXERR
 NEW IBZDC1,SUB1,LITM,CODES,DNUM,DC,ICDIEN,CT
 K ^TMP("IBXSAVE",$J,"DX")
 S SUB1=$S($G(IBCIMSG)=1:"IBCIMSG",1:"DISPLAY")
 K ^TMP(SUB1,$J,IBIFN,"ICD")
 D F^IBCEF("N-HCFA 1500 SERVICES (PRINT)",,,IBIFN)
 D F^IBCEF("N-DIAGNOSES","IBZDC1",,IBIFN)
 ;
 ; if IBCIMSG is on, need to count up the line items for the set below
 I $G(IBCIMSG) S (CT,LITM)=0 F  S LITM=$O(IBXDATA(LITM)) Q:'LITM  S CT=CT+1
 S LITM=0 F  S LITM=$O(IBXDATA(LITM)) Q:'LITM  D
 .S CODES=$P(IBXDATA(LITM),U,7)
 .S DNUM=0 F  S DNUM=DNUM+1 Q:$P(CODES,",",DNUM)=""  D
 ..S DC(DNUM)=$P(CODES,",",DNUM)
 ..S ICDIEN=$P(IBZDC1(DC(DNUM)),U,1)
 ..S ^TMP(SUB1,$J,IBIFN,"ICD",LITM,DNUM)=$P($$ICD9^IBACSV(ICDIEN),U)
 .I $G(IBCIMSG) S ^TMP(SUB1,$J,IBIFN,"ICD",LITM,0)=CT_U_(DNUM-1)
 K ^TMP("IBXSAVE",$J,"DX")
 Q
 ;
 ;
EDATP(IBIFN,COMMCHG) ;edit assigned to person (ATP)
 ;
 ; This procedure reads in the Assigned to person from the user and
 ; makes sure that some user gets assigned to the bill (IBIFN).  The
 ; parameter COMMCHG indicates whether or not the current user 
 ; modified the ClaimsManager comments in any way.
 ;
 ; This procedure also determines if a MailMan message should get
 ; sent to the new assigned to person and invokes the procedure if
 ; it should.
 ;
 NEW D,D0,DA,DIC,DIE,DR,I,IBCIATPO,IBCIATPN,IBCIDEF,X,Y
 NEW IBCIGRP,IBCIGRPN,GRPONLY,CONMSG
 S IBCIATPO=$P($G(^IBA(351.9,IBIFN,0)),U,12)   ; original ATP
 W !!!,?2,"Please enter the person to whom this bill should be assigned.",!
 S IBCIDEF=IBCIATPO            ; default the current ATP, but ...
 I 'IBCIDEF S IBCIDEF=DUZ      ; if not there, default the current user
 S DA=IBIFN,DIE="^IBA(351.9,"
 S DR=".12ASSIGNED TO PERSON//"_$P($G(^VA(200,IBCIDEF,0)),U,1)
 D ^DIE
 ;
 ; Make sure someone got assigned.  Stuff in the current user if
 ; nobody got assigned.  Set a variable indicating the new assigned
 ; to person.
 ;
 I '$P($G(^IBA(351.9,IBIFN,0)),U,12) D
 . S DIE="^IBA(351.9,",DA=IBIFN,DR=".12////"_DUZ D ^DIE
 . Q
 S IBCIATPN=$P($G(^IBA(351.9,IBIFN,0)),U,12)         ; new ATP
 ;
 ; Display a confirmation message to the user
 W !!!?2,"Claim ",$P($G(^DGCR(399,IBIFN,0)),U,1)," has been assigned to "
 W $P($G(^VA(200,IBCIATPN,0)),U,1),"."
 ;
 ; Ask the user if they want to send the MailMan message to a specific
 ; mail group in addition to the new assigned to person.
 ; ESG - 9/4/01
 ;
 W !!!?2,"If you want to send a MailMan message about this bill assignment"
 W !?2,"to a specific Mail Group, then please choose that Mail Group here.",!
 S DIC="^XMB(3.8,",DIC(0)="ABEQV",DIC("A")="MAIL GROUP: "
 D ^DIC
 S (IBCIGRP,IBCIGRPN)=""
 I Y>0 S IBCIGRP=+Y,IBCIGRPN=$P(Y,U,2)    ; group ien and name
 ;
 ; Now determine if a MailMan message should get sent out and send it.
 ; Don't send a MailMan message to yourself and don't send a message
 ; if the assignment has not changed.  However, if the user chose a 
 ; mail group at the above prompt, then always send a MailMan message
 ; to that mail group.
 ;
 ; The GRPONLY variable is true if the assigned to person is the 
 ; current user OR if the assigned to person is the same as the original
 ; assigned to person.
 ;
 S GRPONLY=(IBCIATPN=DUZ)!(IBCIATPN=IBCIATPO)
 I 'IBCIGRP,GRPONLY G EDATPX          ; No mailman in this case at all
 ;
 ; Call the procedure that creates the message
 D CAT^IBCIUT6(IBIFN,DUZ,IBCIATPN,IBCIGRP,GRPONLY)
 ;
 ; The CONMSG array is the confirmation message array so the user
 ; knows to whom a message was sent.
 I 'GRPONLY S CONMSG(1)=$P($G(^VA(200,IBCIATPN,0)),U,1)
 I IBCIGRP S CONMSG(2)=IBCIGRPN
 ;
 ; Build and display the confirmation message
 W !!?2,"A MailMan message has been sent to "
 S X=0
 F  S X=$O(CONMSG(X)) Q:'X  W CONMSG(X) I $O(CONMSG(X)) W !?30,"and to "
 W "."
 ;
EDATPX ;
 ; Display a press return to continue message if coming in from
 ; the Listman screens
 I $D(VALMHDR) W !! S DIR("A")="Press RETURN to continue",DIR(0)="E",DIR("T")=10 D ^DIR K DIR
 Q
