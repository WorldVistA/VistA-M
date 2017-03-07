VBECDCM1 ;hoifo/gjc-VBECS MAPPING TABLE delete utilities.;Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to IX^DIC is supported by IA: 10006
 ;Call to FILE^DIE is supported by IA: 2053
 ;Call to ^DIK is supported by IA: 10013
 ;Call to ^DIR is supported by IA: 10026
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN613 ; decouple antibodies/antigens
 S VBECFN=61.3,VBECNME="Antibodies/Antigens"
 D ASK,XIT
 Q
EN654 ; decouple transfusion reactions
 S VBECFN=65.4,VBECNME="Transfusion Reactions"
 D ASK,XIT
 Q
ENP613 ; purge VistA antibodies/antigens 
 S VBECFN=61.3,VBECNME="Antibodies/Antigens"
 D PURGALL K VBECFN,VBECNME
 Q
ENP654 ; purge VistA transfusion reactions mapping
 S VBECFN=65.4,VBECNME="Transfusion Reactions"
 D PURGALL K VBECFN,VBECNME
 Q
 ;
PURGALL ; purge all the records in the VBECS MAPPING TABLE (#6005) file
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 Q:'$$LOCK^VBECDCU2(6005)
 N VBECXIT S VBECXIT=0
 I $O(^VBEC(6005,"AB",VBECFN,""))'="" D  Q:VBECXIT
 .;Data has been mapped, ask user if purge should proceed.
 .N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 .S DIR(0)="Y",DIR("B")="No"
 .S DIR("A")=VBECNME_" have been mapped, are you sure you want to purge"
 .S DIR("?")="Enter 'Yes' to purge "_VBECNME_", or 'No' to exit without purging."
 .D ^DIR
 .I $D(DIRUT)#2 S VBECXIT=1 Q
 .S VBECXIT=$S(Y=0:1,1:0)
 .;If the user takes the default of 'No', the value of Y is zero.
 .;Set VBECXIT accordingly to exit without purging.
 .Q
 S DIK="^VBEC(6005,",CNT=0
 W !,"Please be patient, this may take awhile"
 S:VBECFN'=66.01 VBEC01=VBECFN_"-"
 S:VBECFN=66.01 VBEC01=VBECFN
 I VBEC01'=66.01  F  S VBEC01=$O(^VBEC(6005,"B",VBEC01)) Q:VBEC01=""!(+VBEC01'=VBECFN)  D PURGE(VBEC01,.CNT) ; not blood supplier
 D:VBEC01=66.01 PURGE(VBEC01,.CNT) ; blood supplier
 W:CNT !!,"Done, total number of records deleted: "_CNT
 W:'CNT !!,"No record(s) to delete."
 D UNLOCK^VBECDCU2(6005)
 K %,CNT,DIC,VBEC01,X,Y
 Q
 ;
PURGE(VBEC01,CNT) ; purge at the record level using DIK
 ; input: VBEC01=sub-file number or file number-ien VBEC MATCHING TABLE
 ;               file.
 ;           CNT=The number of records purged.
 N %,DA,DIK,X,Y S DA=0,DIK="^VBEC(6005,"
 F  S DA=$O(^VBEC(6005,"B",VBEC01,DA)) Q:'DA  D
 .D ^DIK S CNT=CNT+1
 .W:'(CNT#100) "." ; process is active
 .Q
 Q
 ;
SINGLE ; decouple relations for a single record
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 Q:'$$LOCK^VBECDCU2(6005)
 S VBECFILE=$$ATTR^VBECDCU1() ; select data attribute family
 I VBECFILE="^" D KILSIN Q
 K D,DIC,DO S D="N",DIC="^VBEC(6005,",DIC(0)="QEFASZ",VBECFILE=+VBECFILE
 S DIC("S")="N VBEC S VBEC=$G(^(0)) I $P(VBEC,U,5)'="""",(+$P(VBEC,U)=VBECFILE)"
 S DIC("W")="W $S($P(^(0),U,3)'="""":"" (""_$P(^(0),U,3)_"")"",1:"""")"
 D IX^DIC K D,DIC,DO I +Y=-1 D KILSIN Q
 S VBECIEN=+Y,VBECREC=$P(Y(0),U,2)_" ("_$P(Y(0),U,3)_")"
 D DECUP(VBECIEN)
 W !!,"Mapping for "_VBECREC_" decoupled.",!
KILSIN D UNLOCK^VBECDCU2(6005) K VBECFILE,VBECIEN,VBECREC,X,Y
 Q
 ;
ASK ; decouple records from the VBECS MAPPING TABLE (#6005) file
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 S Y=$$YN() Q:Y=0  ; user chooses not to decouple
 S CNT=0 W !!?3,"Please be patient, this may take a while",!
 Q:'$$LOCK^VBECDCU2(6005)
 S VBECGUID=""
 F  S VBECGUID=$O(^VBEC(6005,"AB",VBECFN,VBECGUID)) Q:VBECGUID=""  D
 .S VBECIEN=0
 .F  S VBECIEN=$O(^VBEC(6005,"AB",VBECFN,VBECGUID,VBECIEN)) Q:'VBECIEN  D
 ..D DECUP(VBECIEN)
 ..S CNT=CNT+1 W:'(CNT#100) "." ; process is active
 ..Q
 .Q
 W !?3,"Finished decoupling ",CNT," mapped records from the VBECS MAPPING TABLE (#6005)",!?3,"file.  For VistA "_VBECNME_" data types."
 D UNLOCK^VBECDCU2(6005)
 Q
 ;
DECUP(Y) ; delete the STANDARD VBECS DATA (#.05), CHECKSUM (#.06), &
 ; TIMESTAMP (#.07) field level data (essentially unmap)
 ;input: Y=ien of record in file 6005
 K VBECFDA S VBECFDA(8,6005,Y_",",.05)="@"
 D FILE^DIE("E","VBECFDA(8)") K VBECFDA
 Q
 ;
XIT ; kill and quit
 K CNT,VBECFDA,VBECFN,VBECGUID,VBECIEN,VBECNME,X,Y
 Q
 ;
YN() ; yes/no to decoupling question...
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Are you sure you want to decouple mappings",DIR("B")="No"
 S DIR("?")="Enter 'Yes' to decouple mappings, or 'No' to exit without decoupling mappings."
 D ^DIR S:$D(DIRUT) Y=0
 Q Y
 ;
