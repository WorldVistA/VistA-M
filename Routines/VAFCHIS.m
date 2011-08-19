VAFCHIS ;SF/CMC-TESTING CROSS REFERENCE ;11/20/97
 ;;5.3;Registration;**149,255,307,711**;Aug 13, 1993
 ;
 ; Integration Agreements Utilized:
 ;    CHECKDG^MPIFSPC - #3158
 ;
ICN(OLD,ENT) ;
 ;
 I '$D(OLD)!('$D(ENT)) Q
 N NEWICN,DIC,Y
 ;checking that CIRN PD/MPI is installed
 N X S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 N X S X="MPIFAPI" X ^%ZOSF("TEST") Q:'$T
 N X S X="MPIFMER" X ^%ZOSF("TEST") Q:'$T
 S NEWICN=+$$GETICN^MPIF001(ENT)
 Q:OLD=NEWICN!(OLD="")
 ; ^ UPDATE ICN WITH SAME ICN DON'T PUT IT IN HISTORY
 ;
 S OLDDA=DA,OLDX=OLD
 N DA
 ;
 D NOW^%DTC
 S HAP=%
 ;S NODE=$$MPINODE^MPIFAPI(ENT) **711
 S X=OLD
 S DIC="^DPT("_ENT_",""MPIFHIS"",",DIC(0)="L"
 I '$D(^DPT(ENT,"MPIFHIS",0)) S ^DPT(ENT,"MPIFHIS",0)="^2.0992A^0^0"
 S DIC("P")=$P(^DPT(ENT,"MPIFHIS",0),"^",2)
 S DA(1)=ENT
 D ^DIC
 ;**711 change setting of checksum and CMOR ensure correct data stored
 S $P(^DPT(ENT,"MPIFHIS",+Y,0),"^",2)=$$CHECKDG^MPIFSPC(OLD)
 S $P(^DPT(ENT,"MPIFHIS",+Y,0),"^",3)=$P($G(^DPT(ENT,"MPI")),"^",3)
 S $P(^DPT(ENT,"MPIFHIS",+Y,0),"^",4)=HAP
 ;
 S ^DPT("AICN",OLD,ENT)=""
 K NODE,%,HAP
 S X=OLDX,DA=OLDDA
 K OLDX,OLDDA
 ;**REPLACED BY LINK MSGS MPIF*1.0*21 changes MER^MPIFMER call to quit
 ;Send "Merge" (change) ICN message to all subscribers
 ;N ERROR,FLG
 ;S FLG=1
 ;I $P($$GETICN^MPIF001(DA),"^")'="" D MER^MPIFMER(DA,X,.ERROR,FLG)
 Q
CMOR(OLD,RGDFN) ;ALS 6/23/00
 ; Create CMOR History node
 I '$D(OLD)!('$D(RGDFN)) Q
 N NEWCMOR
 S NEWCMOR=$$GETVCCI^MPIF001(RGDFN)
 Q:OLD=NEWCMOR!(OLD="")
 ;
 D NOW^%DTC
 S CHGDT=%
 S NODE=$$MPINODE^MPIFAPI(RGDFN)
 S X=OLD
 S DIC="^DPT("_RGDFN_",""MPICMOR"",",DIC(0)="L"
 I '$D(^DPT(RGDFN,"MPICMOR",0)) S ^DPT(RGDFN,"MPICMOR",0)="^2.0993A^0^0"
 S DIC("P")=$P(^DPT(RGDFN,"MPICMOR",0),"^",2)
 S DA(1)=RGDFN
 D ^DIC
 ; add CMOR activity score and calculation date to node
 S $P(^DPT(RGDFN,"MPICMOR",+Y,0),"^",2)=$P(NODE,"^",6)
 S $P(^DPT(RGDFN,"MPICMOR",+Y,0),"^",3)=$P(NODE,"^",7)
 S $P(^DPT(RGDFN,"MPICMOR",+Y,0),"^",4)=CHGDT
 ;
 K NODE,%,Y,DIC,CHGDT
 Q
GETICNH(MDFN,ARRAY) ; **711 added API
 ; Returns ICN History in ARRAY 
 ;Input:  MDFN is the IEN in file 2
 ;ARRAY is passed by reference and will return from ICN History nodes: ICN 'V' ICN Checksum ^ deprecated date
 ;If there is a problem ARRAY will equal -1^error message
 K ARRAY
 S ARRAY=1
 I MDFN=""!(MDFN<1) S ARRAY="-1^No such DFN" Q
 I '$D(^DPT(MDFN)) S ARRAY="-1^No such DFN" Q
 I '$D(^DPT(MDFN,"MPIFHIS")) S ARRAY="-1^No ICN History" Q
 N CHK,HISTDT,HIST,CNT,VAFCHMN S HIST=0,CNT=1
 F  S HIST=$O(^DPT(MDFN,"MPIFHIS",HIST)) Q:'HIST  D
 .S VAFCHMN=$G(^DPT(MDFN,"MPIFHIS",HIST,0))
 .S HISTDT=$P(VAFCHMN,"^",4) D
 ..;due to a timing issue if checksum and D/T of deprication of ICN is not present hang two seconds and try again if still not able to get ICN set D/T to DT
 ..I $G(HISTDT)="" H 2 S VAFCHMN=^DPT(MDFN,"MPIFHIS",HIST,0) S HISTDT=$P(VAFCHMN,"^",4) I HISTDT="" S $P(VAFCHMN,"^",4)=DT
 .;verify checksum is correct, if not update it and return the updated value
 .S CHK=$$CHECKDG^MPIFSPC($P(VAFCHMN,"^"))
 .I CHK'=$P(VAFCHMN,"^",2) S $P(^DPT(MDFN,"MPIFHIS",HIST,0),"^",2)=CHK,$P(VAFCHMN,"^",2)=CHK
 .S ARRAY(CNT)=$P(VAFCHMN,"^")_"V"_$P(VAFCHMN,"^",2)_"^"_HISTDT,CNT=CNT+1
 I $O(ARRAY(0))="" S ARRAY="-1^No ICN History"
 Q
