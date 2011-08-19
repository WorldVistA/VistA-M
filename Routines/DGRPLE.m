DGRPLE ;WAS/ERC/RMM,ALB/CKN - REGISTRATION EDITS OF PURPLE HEART FIELDS ; 11/22/05 4:13pm
 ;;5.3;Registration;**314,343,377,431,653,688**;Aug 13, 1993;Build 29
 ;
DIV() ;Get Institution Name
 ;If site is multi-divisional then ask user for division
 ;
 ; DBIA: #10112 - supported API $$SITE^VASITE and $$PRIM^VASITE
 ;                for retrieving Institution name
 ;
 ; Input: none
 ;
 ; Output:  DGNAM - Institution name
 ;
 N DGDIV,DGSTN,DGNAM
 S DGDIV=$S($D(^DG(40.8,"B")):$$MULTDIV,1:$$PRIM^VASITE)
 S DGSTN=$$SITE^VASITE(,DGDIV)
 S DGNAM=$S($P(DGSTN,U,2)]"":$P(DGSTN,U,2),1:"")
 Q DGNAM
 ;
MULTDIV() ;User selects from active divisions
 ;
 ; Input: none
 ;
 ; Output:
 ;      Function return value - Division IEN
 ;
 N DIR,X,Y
 S DIR(0)="PA^40.8:EM"
 S DIR("A")="Enter your division: "
 S DIR("S")="I $$SITE^VASITE(,+Y)>0"
 D ^DIR
 Q +Y
 ;
EDITPOW(DG1,DG2,DG3,DG4,DGDFN) ;entry from enrollment for HEC updates
 ;    DGDFN - Patient File IEN
 ;    DG1   - POW Indicator
 ;    DG2   - POW Confinement Location
 ;    DG3   - POW From Date
 ;    DG4   - POW To Date
 ; Update POW data from HEC - DG*5.3*653
 N DATA,DGENDA,ERROR,CURPOW,POW
 S DGENDA=DGDFN
 S CURPOW=$G(^DPT(DGDFN,.52))
 S POW(.525)=$P(CURPOW,"^",5) ;Current POW indicator
 S POW(.529)=$P(CURPOW,"^",9) ;Current POW verified status
 S DATA(.525)=$G(DG1)
 ;If Current POW Verified Status is null,
 ;OR Current POW Verified Status is not null and incoming POW indicator is different than current POW indicator,
 ;set POW Verified Status to current Date/Time.
 I (POW(.529)="")!((POW(.529)'="")&(DG1'=POW(.525))) S DATA(.529)=$$NOW^XLFDT()
 ;Remove the values in database if POW Indicator is NO
 ;otherwise update new values
 S DATA(.526)=$S(DG1="N":"@",1:DG2)
 S DATA(.527)=$S(DG1="N":"@",1:DG3)
 S DATA(.528)=$S(DG1="N":"@",1:DG4)
 I '$$UPD^DGENDBS(2,.DGENDA,.DATA,.ERROR) D
 . D ADDMSG^DGENUPL3(.MSGS,"Unable to update POW Data.",1)
 K DATA,DGENDA,ERROR,DG1,DG2,DG3,DG4
 Q
 ;
EDITPH(DG1,DG2,DG3,DGDFN) ;entry from enrollment for HEC updates
 ;    DGDFN - Patient File IEN
 ;    DG1   - PH Indicator
 ;    DG2   - PH Status
 ;    DG3   - PH Remarks
 ;
 N DATA,DGENDA,ERROR,DGUSER,DGPHARR,%
 S DGENDA=DGDFN
 S (DG(1),DATA(.531))=DG1
 S (DG(2),DATA(.532))=$S(DG1="N":"",1:DG2)
 S (DG(3),DATA(.533))=$S(DG1="Y":"",1:DG3)
 I '$$UPD^DGENDBS(2,.DGENDA,.DATA,.ERROR) D
 .D ADDMSG^DGENUPL3(.MSGS,"Unable to update Purple Heart Data.",1)
 K DATA,DGENDA,ERROR
 ; If the Database Server Failed, Quit.
 Q:'$D(^DPT(DGDFN,.53))
 S DGUSER="HEC User",DGPHARR=^DPT(DGDFN,.53)
 ; If nothing was changed, don't update the history, Quit.
 Q:'$$CHANGE(DG(1),DG(2),DG(3),DGDFN)
 ;
 D NOW^%DTC
 S DATA(.01)=%,DATA(1)=DG(1),DATA(2)=DG(2),DATA(3)=DG(3)
 S DATA(4)=DGUSER,DGENDA(1)=DGDFN
 I '$$ADD^DGENDBS(2.0534,.DGENDA,.DATA,.ERROR) D
 .D ADDMSG^DGENUPL3(.MSGS,"Unable to update Purple Heart History.",1)
 K DATA,DGENDA,ERROR
 ;
 Q
 ;
EDITPH1(DGUSER) ;
 ; Input:   DGUSER - Person filing Purple Heart changes
 ;
 ; Output:  none
 ;
 S DGUSER=$G(DGUSER,$P(^VA(200,DUZ,0),U))
 NEW DGPHARR,DG,DGX
 S DGPHARR=^DPT(DFN,.53)
 ;REDIE will ensure there is a STATUS only if indicator is 
 ;'yes' and a REMARK only if indicator is 'no'
 I $P(DGPHARR,U)="Y",($P(DGPHARR,U,3)]"") D REDIE(3)
 I $P(DGPHARR,U)="N",($P(DGPHARR,U,2)]"") D REDIE(2)
 F DGX=1:1:3 S DG(DGX)=$P(DGPHARR,U,DGX)
 I $$CHANGE(DG(1),DG(2),DG(3),DFN) D EDITPH2(DG(1),DG(2),DG(3),DGUSER)
 Q
 ;
EDITPH2(DG1,DG2,DG3,DG4) ;stuff PH values into the PH multiple of file #2
 S DFN=DA
 N DA,DIC,DIE
 S DIC="^DPT("_DFN_",""PH"","
 S DA(1)=DFN
 D NOW^%DTC S X=%
 S DIC(0)="L"
 S DIC("DR")="1///^S X=$G(DG1);2///^S X=$G(DG2);3///^S X=$G(DG3);4///^S X=$G(DG4)"
 D ^DIC
 Q
 ;
REDIE(DGPCE) ; make sure value in PH Status and PH Remarks consistent 
 ; with value of PH Indicator
 N DA,DIE,DR
 S DIE="^DPT(",DR=$S($G(DGPCE)=2:.532,1:.533)_"///^S X=""@"""
 S DA=DFN
 D ^DIE
 S DGPHARR=^DPT(DFN,.53)
 Q
 ;
CHANGE(DGPH1,DGPH2,DGPH3,DGPHDFN) ;Check to see if the entry has changed
 ; Input:
 ;       DGPH1  - PH Indicator
 ;       DGPH2  - PH Status
 ;       DGPH3  - PH Remarks
 ;       DGPHDFN- Patient file IEN
 ;
 ; Output:  none
 ;
 ; Return:  DGCHG = 1 - Change in any of the input values has occurred
 ;          DGCHG = 0 - No change
 ;
 N DGCHG    ;Return value
 N DGARR    ;Array containing last values from audit
 N DGPHVAL  ;Merged array of DGARR
 N DGERR    ;Error root for DIQ
 N DGIEN    ;IEN of last audit value
 N DGFILE   ;Purple Heart Multiple
 N DGI      ;Index counter
 ;
 K DGPHINC
 S DGCHG=0
 S DGFILE=2.0534
 S DGIEN=$O(^DPT(DGPHDFN,"PH","B"),-1)
 I DGIEN="" S DGCHG=1 G AUDITQ
 D GETS^DIQ(DGFILE,DGIEN_","_DGPHDFN_",","1;2;3","I","DGARR","DGERR")
 I $D(DGERR) S DGCHG=1 G AUDITQ
 M DGPHVAL=DGARR(DGFILE,DGIEN_","_DGPHDFN_",")
 F DGI=1:1:3 I @("DGPH"_DGI)'=DGPHVAL(DGI,"I") D
 . S DGCHG=1
 . I DGI=1 D  ; PH INDICATOR has changed
 . . I DGPH1="N",DGPHVAL(DGI,"I")="Y" S DGPHINC=1 ; Package Variable to note PH Indicator has changed
AUDITQ Q DGCHG
