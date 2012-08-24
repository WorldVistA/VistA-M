PXRMOCG ;SLC/PKR - Routines for editing order check groups ;02/17/2012
 ;;2.0;CLINICAL REMINDERS;**22**;Feb 04, 2005;Build 160
 ;Also contains routines used by the DD for file #801.
 ;=============================================
GETPINM(VP) ;Given the variable pointer VP get the pharmacy item name.
 N FNUM,IEN,NAME,PREFIX,ROOT,VPL
 S IEN=$P(VP,";",1)
 S ROOT=U_$P(VP,";",2)
 S FNUM=$$FNFR^PXRMUTIL(ROOT)
 S NAME=$$GET1^DIQ(FNUM,IEN,.01)
 D BLDNLIST^PXRMVPTR(801.015,.01,.VPL)
 S PREFIX=$P(VPL(FNUM),U,4)_"."
 Q PREFIX_NAME
 ;
 ;=============================================
KPID(DA,X) ;Kill logic for Pharmacy Item PID cross-reference.
 N NAME
 S NAME=$$PIOT^PXRMOCG(.DA,X)
 K ^PXD(801,DA(1),1.5,"PIDO",NAME,DA)
 K ^PXD(801,DA(1),1.5,"PIDN",DA)
 Q
 ;
 ;=============================================
OICAP(IEN) ;Executable caption for the orderable item selection.
 N NUM
 S NUM=+$P($G(^PXD(801,IEN,2,0)),U,4)
 Q "ORDERABLE ITEM LIST ("_NUM_" "_$S(NUM=1:"entry",1:"entries")_")"
 ;
 ;=============================================
OCRCAP(IEN) ;Executable caption for the reminder order checks rules list
 ;selection.
 N NUM
 S NUM=+$P($G(^PXD(801,IEN,3,0)),U,4)
 Q "REMINDER ORDER CHECKS RULES LIST ("_NUM_" "_$S(NUM=1:"entry",1:"entries")_")"
 ;
 ;=============================================
PICAP(IEN) ;Executable caption for the pharmacy item selection.
 N NUM
 S NUM=+$P($G(^PXD(801,IEN,1.5,0)),U,4)
 Q "PHARMACY ITEM LIST ("_NUM_" "_$S(NUM=1:"entry",1:"entries")_")"
 ;
 ;=============================================
PIOT(DA,PI) ;Output transform for pharmacy items.
 I '$D(DDS) Q $$GETPINM^PXRMOCG(PI)
 I DA=0 Q $$GETPINM^PXRMOCG(PI)
 Q ^PXD(801,DA(1),1.5,"PIDN",DA)
 ;
 ;=============================================
SPID(DA,X) ;Set logic for Pharmacy Item PID cross-reference.
 N FNUM,IEN,NAME,PREFIX,ROOT,VPL
 S NAME=$$GETPINM^PXRMOCG(X)
 S ^PXD(801,DA(1),1.5,"PIDO",NAME,DA)=""
 S ^PXD(801,DA(1),1.5,"PIDN",DA)=NAME
 Q
 ;
 ;=============================================
SMANEDIT(IEN,NEW) ;Invoke the ScreeMan editor for entry IEN.
 N DA,DR,DDSCHANG,DDSFILE,DDSPARM,DDSSAVE,OIGCLASS,RESTRICT
 S DDSFILE=801,DDSPARM="CS"
 S OIGCLASS=$P($G(^PXD(801,IEN,100)),U,1)
 S RESTRICT=$S($G(PXRMINST):0,OIGCLASS="N":1,1:0)
 S DR=$S(RESTRICT:"[PXRM OCG EDIT RESTRICTED]",1:"[PXRM OCG EDIT]")
 S DA=IEN
 D ^DDS
 ;If the entry is new and the user did not save, delete it.
 I $G(NEW),$G(DDSSAVE)'=1 D DELETE^PXRMEXFI(801,IEN) Q
 ;If changes were made update the edit history.
 I $G(DDSCHANG)'=1 Q
 ;Make sure the change was not a deletion.
 I '$D(^PXD(801,IEN)) Q
 N IENS,FDA,FDAIEN,MSG
 S IENS="+1,"_IEN_","
 S FDA(801.03,IENS,.01)=$$NOW^XLFDT
 S FDA(801.03,IENS,1)=DUZ
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 K DA,DDSFILE
 S DA=FDAIEN(1),DA(1)=IEN
 S DDSFILE=801,DDSFILE(1)=801.03
 S DR="[PXRM OCG EDIT HISTORY]"
 D ^DDS
 Q
 ;
 ;=============================================
VRULE(RULEIEN,DA) ;If the rules in a national orderable item group are being
 ;edited by a site national rules cannot be added or deleted. The
 ;ScreenMan form PXRM OCG EDIT RESTRICTED is for restricted editing.
 ;This check is made from the LAYGO and DEL nodes of the Rule List
 ;multiple. Return 1 if the entry can be added 0 if it cannot.
 I $G(PXRMINST) Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N FORMNAME,OIGCLASS,RESTRICT,RULECLASS
 S OIGCLASS=$P($G(^PXD(801,DA(1),100)),U,1)
 I OIGCLASS'="N" Q 1
 I '$D(DDS) S RESTRICT=1
 I $D(DDS) D
 . ;DBIA #5746
 . S FORMNAME=$P(DDS,U,2)
 . S RESTRICT=$S(FORMNAME="PXRM OCG EDIT RESTRICTED":1,1:0)
 I 'RESTRICT Q 1
 S RULECLASS=$P($G(^PXD(801.1,RULEIEN,100)),U,1)
 I RESTRICT,(RULECLASS="N") Q 0
 Q 1
 ;
 ;=============================================
VRULEA(RULEIEN,DA) ;This check is made from the LAYGO node of the Rule
 ;List multiple. Return 1 if the entry can be added 0 if it cannot.
 N ADD
 S ADD=$$VRULE^PXRMOCG(RULEIEN,.DA)
 I 'ADD D EN^DDIOL("Sites cannot add national Reminder Order Check Rules from national Reminder Order Check Items Groups.")
 Q ADD
 ;
 ;=============================================
VRULED(DA) ;This check is made from the DEL node of the Rule List
 ;multiple. Return 1 if the field canot be deleted, 0 if it can.
 N NODEL,RULEIEN
 S RULEIEN=$P(^PXD(801,DA(1),3,DA,0),U,1)
 S NODEL='$$VRULE^PXRMOCG(RULEIEN,.DA)
 I NODEL D EN^DDIOL("Sites cannot delete national Reminder Order Check Rules from national Reminder Order Check Items Groups.")
 Q NODEL
 ;
 ;=============================================
VRULESCR(RULEIEN,DA) ;Screen for the .01 of the Rule List multiple.
 N VALID
 S VALID=$$VRULE^PXRMOCG(RULEIEN,.DA)
 Q VALID
 ;
