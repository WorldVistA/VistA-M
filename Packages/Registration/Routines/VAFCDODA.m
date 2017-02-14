VAFCDODA ;BIR/CML-Accept Date of Death Updates Utilities ;6/23/16
 ;;5.3;Registration;**926**;Aug 13, 1993;Build 6
 ;
 ; Routine created for DG*5.3*926 Story #340909 (cml)
 ;
CHK() ; API to return value of PROCESS MVI DOD UPDATE? field (#1401) in MAS Parameters file (#43)
 ; Return 1 if value is set to "YES" (1); otherwise return 0
 N RES S RES=1
 I $P($G(^DG(43,1,"MVI")),"^")'=1 S RES=0
 Q RES
 ;
EN(RET,TYPE,SET) ; API called from RPC [] to update or display the PROCESS MVI DOD UPDATE? (#1401) field in MAS Parameters (#43)
 ;TYPE: the type of action:
 ; If TYPE="S", this is a remote call from the MPI to toggle the value to set the PROCESS MVI DOD UPDATE? (#1401) 
 ; field in MAS Parameters (#43) at a specific site.
 ; If TYPE="D", this is a remote call from the MPI to return the current setting of the PROCESS MVI DOD UPDATE? (#1401) 
 ; field in MAS Parameters (#43) at a specific site.
 ;SET: If TYPE="S", SET is the value PROCESS MVI DOD UPDATE? is to be set to. (1:YES, 0:NO)
 ;
 N SITE,SITENAM,SITENUM
 S SITE=$$SITE^VASITE,SITENAM=$P(SITE,"^",2),SITENUM=$P(SITE,"^",3)
 ;
 I TYPE'="S"&(TYPE'="D") S RET(1)="-1:Station #"_SITENUM_" - Invalid TYPE sent for PROCESS MVI DOD UPDATE? field request." Q
 I TYPE="S" I SET'=1&(SET'=0) S RET(1)="-1:Station #"_SITENUM_" - Invalid update parameter sent for PROCESS MVI DOD UPDATE? field" Q
 I TYPE="S" I SET=1!(SET=0) D SET Q
 I TYPE="D" D DISP Q
 ; 
DISP ; Return display of PROCESS MVI DOD UPDATE? field (#1401) in MAS Parameters file (#43) set to "YES" (1); otherwise return 0
 N IEN
 S IEN=$O(^DG(43,0))
 Q:IEN<1
 S RET(1)="1:Station #"_SITENUM_" - PROCESS MVI DOD UPDATE? set to 'YES'"
 I $P($G(^DG(43,IEN,"MVI")),"^")'=1 S RET(1)="1:Station #"_SITENUM_" - PROCESS MVI DOD UPDATE? set to 'NO' or null"
 Q
 ;
SET ; Update PROCESS MVI DOD UPDATE? field (#1401) in MAS Parameters file (#43)
 ;
 N IEN,VAL,DIE,DA,DR
 S IEN=$O(^DG(43,0))
 Q:IEN<1
 S DIE="^DG(43,",DA=IEN,DR="1401////^S X=SET"
 D ^DIE
 S VAL=$P($G(^DG(43,IEN,"MVI")),"^")
 I VAL=1 S RET(1)="1:Station #"_SITENUM_" - PROCESS MVI DOD UPDATE? set to 'YES'"
 I VAL=0!(VAL="") S RET(1)="1:Station #"_SITENUM_" - PROCESS MVI DOD UPDATE? set to 'NO' or null"
 Q
