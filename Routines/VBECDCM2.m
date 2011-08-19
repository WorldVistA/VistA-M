VBECDCM2 ;hoifo/gjc-VBECS MAPPING TABLE add, edit & delete utilities;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
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
 ;Call to FILE^DIE is supported by IA: 2053
 ;Call to UPDATE^DIE is supported by IA: 2053
 ;Call to ^DIK is supported by IA: 10013
 ;Call to $$ROOT^DILFD is supported by IA: 2055
 ;Call to $$NOW^XLFDT is supported by IA: 10103
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN654 ; handle transfusion reactions.
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 ;initially add trans. reactions to file 6005
 ;
 I +$O(^VBEC(6005,"AA","65.4-"))'=65.4 D
 .Q:'$$LOCK^VBECDCU2(65.4)
 .W !!,"Adding site configured 'Transfusion Reaction' information into the VBECS MAPPING",!,"TABLE file (#6005)."
 .S (CNT,VBECY)=0
 .F  S VBECY=$O(^LAB(65.4,VBECY)) Q:'VBECY  D  ;trans. react.
 ..S VBECY(0)=$G(^LAB(65.4,VBECY,0)) Q:$P(VBECY(0),U,2)'="T"
 ..S CNT=CNT+1 D POP6005(65.4,VBECY,$P(VBECY(0),U),$P(VBECY(0),U,3))
 ..W:'(CNT#100) "."
 ..Q
 .D UNLOCK^VBECDCU2(65.4)
 .Q
 S:+$O(^VBEC(6005,"AA","65.4-"))=65.4 VBECFLG=1
 I  W !!,CNT_" transfusion record"_$S(CNT=1:"",1:"s")_" added.",!
 ;
 ;handle transfusion reaction edit, and add events here
 ;
 E  D
 .S VBECFLG=0 Q:'$$LOCK^VBECDCU2(65.4)  ;RLM 10/27/05
 .S VBECY=0 F  S VBECY=$O(^LAB(65.4,VBECY)) Q:'VBECY  D
 ..S VBECY(0)=$G(^LAB(65.4,VBECY,0)),VBEC01=65.4_"-"_VBECY
 ..S VBECIEN=+$O(^VBEC(6005,"B",VBEC01,0)),VBECIEN(0)=$G(^VBEC(6005,VBECIEN,0))
 ..;
 ..;if transfusion reaction not filed in 6005, add it
 ..I 'VBECIEN,($P(VBECY(0),U,2)="T") S VBECFLG=1 D POP6005(65.4,VBECY,$P(VBECY(0),U),$P(VBECY(0),U,3))  ;if added, no need to perform edit check
 ..Q:'VBECIEN
 ..;
 ..;check if the name or identifier attribute has been edited
 ..;if parent record changes from TRANSFUSION REACTION delete from 6005
 ..I $P(VBECY(0),U,2)'="T" D  Q
 ...K DA,DIK S DA=VBECIEN,DIK="^VBEC(6005,",VBECFLG=1 D ^DIK
 ...K %,DA,DIC,DIK,X,Y
 ...Q
 ..S VBECTOT=0,VBECTOT=$$CHECKSUM^VBECDCU2($P(VBECY(0),U))
 ..S VBECTOT=VBECTOT+$$CHECKSUM^VBECDCU2($P(VBECY(0),U,3))
 ..I VBECTOT'=$P(VBECIEN(0),U,6) D  S VBECFLG=1 K VBECTOT
 ...S:$P(VBECY(0),U)'=$P(VBECIEN(0),U,2) VBECFDA(6005,VBECIEN_",",.02)=$P(VBECY(0),U)
 ...S:$P(VBECY(0),U,3)'=$P(VBECIEN(0),U,3) VBECFDA(6005,VBECIEN_",",.03)=$P(VBECY(0),U,3)
 ...S VBECFDA(6005,VBECIEN_",",.05)="@"
 ...S VBECFDA(6005,VBECIEN_",",.06)=VBECTOT
 ...S VBECFDA(6005,VBECIEN_",",.07)=+$E($$NOW^XLFDT(),1,12)
 ...D FILE^DIE("","VBECFDA")
 ...Q
 ..Q
 .D UNLOCK^VBECDCU2(65.4)
 .Q
 ; handle delete transaction reaction actions here
 D DELETE(65.4)
 I $G(VBECFLG) W !!,"Transfusion Reaction information updated.",! ;RLM 10/27/05
 E  W !!,"Transfusion Reaction information current, not updated.",!
 D XIT
 Q
 ;
XIT ; unlock, kill, and quit
 L -^VBEC(6005)
 K CNT,DIR,DIRUT,DTOUT,DUOUT,VBEC01,VBECANTI,VBECFLD,VBECFLE,VBECFLG,VBECHLP,VBECIEN,VBECRT,VBECTMP,VBECXIT,VBECX,VBECY,VBECYN,X,Y
 K ^TMP($J,"VBEC SUPPLIER")
 Q
 ;
POP6005(VBECFILE,VBECIEN,VBEC01,VBECID,VBECANTI) ; Populate the
 ; VBECS MAPPING TABLE file (#6005) with antigen/antibody & blood
 ; transfusion reaction data.
 ; Input: VBECFILE=VistA file referenced (required)
 ;         VBECIEN=VistA internal entry number referenced
 ;          VBEC01=value of the .01 field (required, external)
 ;          VBECID=file identifier
 ;        VBECANTI=antibody/antigen identifier
 ;
 S VBECTOT=0,VBECTOT=$$CHECKSUM^VBECDCU2(VBEC01)
 S VBECTOT=VBECTOT+$$CHECKSUM^VBECDCU2(VBECID)
 S:$G(VBECANTI)'="" VBECTOT=VBECTOT+$$CHECKSUM^VBECDCU2(VBECANTI)
 F  S COUNT=(+$O(^VBEC(6005,$C(32)),-1)+1) Q:'($D(^VBEC(6005,COUNT,0))#2)
 S VBECFDA(6005,"+"_COUNT_",",.01)=VBECFILE_"-"_VBECIEN
 S VBECFDA(6005,"+"_COUNT_",",.02)=VBEC01
 S:$G(VBECID)'="" VBECFDA(6005,"+"_COUNT_",",.03)=VBECID
 S:$G(VBECANTI)'="" VBECFDA(6005,"+"_COUNT_",",.04)=VBECANTI
 S VBECFDA(6005,"+"_COUNT_",",.06)=VBECTOT
 S VBECFDA(6005,"+"_COUNT_",",.07)=+$E($$NOW^XLFDT(),1,12)
 D UPDATE^DIE("E","VBECFDA") K COUNT,VBECFDA,VBECTOT
 Q
 ;
DELETE(VBECFN) ; delete individual record from file 6005 that no longer exist
 ; in their parent files.
 ;Input: VBECFN=the file number of the parent file
 ;return: VBECFLG=indicates if updates (deletions) to file 6005 occurred
 N VBEC6005,VBECIEN,VBECRT,VBECX K %,DA,DIC,DIK,X,Y
 S VBECX=VBECFN_"-",VBECRT=$$ROOT^DILFD(VBECFN,"",1)
 F  S VBECX=$O(^VBEC(6005,"B",VBECX)) Q:VBECX=""!(+VBECX'=VBECFN)  D
 .S VBEC6005=$O(^VBEC(6005,"B",VBECX,0)) Q:VBEC6005=0
 .S VBECIEN=+$P(VBECX,"-",2)
 .I $D(@VBECRT@(VBECIEN,0))#2 Q  ;data resides in the parent file
 .S DIK="^VBEC(6005,",DA=VBEC6005,VBECFLG=1 D ^DIK K %,DA,DIC,DIK,X,Y
 Q
 ;
