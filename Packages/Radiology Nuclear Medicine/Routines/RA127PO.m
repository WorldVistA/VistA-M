RA127PO ;BPFO/CLT - PATCH RA*5.0*127 POST INSTALL ; 23 Sep 2016  3:33 PM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
 ;
 ; This routine uses the following IAs:
 ; #4640 - ^HDISVF01 calls (supported)
 ; #4639 - ^HDISVCMR calls     (supported)
 ; #4651 - ^HDISVF09 calls     (supported)
 ;
EN ;MAIN ENTRY POINT
 N RAFAC,X,Y,DA,X1,X2,ZTRTN,ZTDESC,ZTDTH,TMP,DOMPTR,DIE,DA,DR,RADNTRT
 S RAFAC=$$KSP^XUPARAM("INST")
 S DIC="^RAMRPF(71.98,",DIC(0)="L",X=RAFAC D ^DIC S DA=+Y
 S $P(^RAMRPF(71.98,1,0),U,6)="M",$P(^RAMRPF(71.98,1,0),U,1)=RAFAC,^RAMRPF(71.98,"B",RAFAC,1)=""
 S RADNTRT="RADNTRT",DA=1
 ;S DIE="^RAMRPF(71.98,",DIE(0)="",DR="6///RADNTRT;11///"_"//vaauscttweb80.aac.domain.ext;11.5///isaac-rest/rest/1/request/termRequest;10///8080" D ^DIE
 ;S DIE="^RAMRPF(71.98,",DIE(0)="",DR="6///RADNTRT;11///isaac-rest/rest/1/request/termRequest;11.5///vaauscttweb80.aac.domain.ext;10///8080"
 S DIE="^RAMRPF(71.98,",DIE(0)="",DR="6///RADNTRT;11///vaauscttweb80.aac.domain.ext;11.5///isaac-rest/rest/1/request/termRequest;10///8080"
 S DR=DR_";11.6///MASTER-NTRT-RECEIVE_1.XSD" D ^DIE
 ;
TIMBUL ;QUEUE THE TIME BULLETIN
 S ZTRTN="RATIMBUL",ZTDESC="Radiology new procedure time bulletin"
 S X1=DT,X2=1 D C^%DTC S ZTDTH=X_.0300
 D ^%ZTLOAD
 ;
 ;
HDIS ; do HDIS 'seeding'
 N DOMPTR,TMP,DOMAIN,FIL,HDIMSG,A,B,C
 ; first check if 71.99 file has a .01 field
 S A=0,A=$O(^RAMRPF(71.99,A)) I 'A D  ;<
 . N INS,DIC,DA,XUMF,NITM
 . D INISEED
 ;
 ; check if process has already been done
 S DOMAIN="RADIOLOGY",FIL=71.99
 S A=$P($$GETSTAT^HDISVF01(FIL),U) I A S MSG="File: "_FIL_" Has already been seeded. Status is: "_A D PSTHALT(MSG) Q
 ;
 S TMP=$$GETIEN^HDISVF09(DOMAIN,.DOMPTR)
 I '+DOMPTR D MES^XPDUTL("***** Error retrieving the IEN for the "_DOMAIN_" domain."),PSTHALT("") Q
 D EN^HDISVCMR(DOMPTR,FIL)
 Q
 ;
PSTHALT(MSG) ; display error message
 S HDIMSG(1)=""
 S HDIMSG(2)=MSG
 S HDIMSG(3)="***** Post-installation of Patch RA*5.0*127 HDIS 'seeding' has been halted."
 S HDIMSG(4)="***** Please contact Enterprise VistA Support."
 S HDIMSG(5)=""
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
 ;
INISEED ; set initial items into ^RAMRPF(71.99
 N INS,DIC,DA,XUMF,NITM
 S INS="SPECT flow W RNC IV Liver+Spleen^US Guidance for Thoracentesis^US RUQ^US Spleen^US Aorta^Angio Adrenal Unilat^MRI Kidney(s) WO Contr^MRI Abd WO+W contr IV^XR Knee(s) Tunnel View"
 F NITM=1:1:9 S X=$P(INS,U,NITM) S DIC="^RAMRPF(71.99,",DIC(0)="F",XUMF=1 D FILE^DICN
 Q
