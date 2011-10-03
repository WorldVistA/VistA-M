VBECDCM0 ;hoifo/gjc-VBECS MAPPING TABLE add, edit & delete utilities.;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ; main entry point for VBECS MAPPING TABLE (#6005) file operations
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
 ;Call to $$NOW^XLFDT is supported by IA: 10103
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN613 ;Initially populate the file with antigen/antibody data
 ;
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 I +$O(^VBEC(6005,"AA","61.3-"))'=61.3 D
 .Q:'$$LOCK^VBECDCU2(61.3)
 .W !!,"Adding site configured 'Antigen/Antibody' information into the VBECS MAPPING",!,"TABLE file (#6005)."
 .S CNT=0
 .F VBECANTI="AB","AN" D  ;antibodies & antigens
 ..S VBECY=0 F  S VBECY=$O(^LAB(61.3,"E",VBECANTI,VBECY)) Q:'VBECY  D
 ...S VBECY(0)=$G(^LAB(61.3,VBECY,0)),CNT=CNT+1
 ...D POP6005^VBECDCM2(61.3,VBECY,$P(VBECY(0),U),$P(VBECY(0),U,2),VBECANTI)
 ...W:'(CNT#100) "."
 ...Q
 ..Q
 .D UNLOCK^VBECDCU2(61.3)
 .Q
 S:+$O(^VBEC(6005,"AA","61.3-"))=61.3 VBECFLG=1
 I  W !!,CNT_" antibody/antigen record"_$S(CNT=1:"",1:"s")_" added.",!
 ;
 ;handle antigen/antibody edit, delete, and add events here
 ;
 E  D
 .Q:'$$LOCK^VBECDCU2(61.3)  S VBECFLG=0
 .F VBECANTI="AB","AN" D  ;antibodies & antigens
 ..S VBECY=0 F  S VBECY=$O(^LAB(61.3,"E",VBECANTI,VBECY)) Q:'VBECY  D
 ...S VBECY(0)=$G(^LAB(61.3,VBECY,0)),VBEC01=61.3_"-"_VBECY
 ...S VBECIEN=+$O(^VBEC(6005,"B",VBEC01,0))
 ...;
 ...;if antigen/antibody not filed in 6005, add it
 ...I 'VBECIEN S VBECFLG=1 D POP6005^VBECDCM2(61.3,VBECY,$P(VBECY(0),U),$P(VBECY(0),U,2),VBECANTI) Q
 ...S VBECIEN(0)=$G(^VBEC(6005,VBECIEN,0))
 ...;
 ...;check if the name or identifier attribute has been edited
 ...S VBECTOT=0,VBECTOT=$$CHECKSUM^VBECDCU2($P(VBECY(0),U))
 ...S VBECTOT=VBECTOT+$$CHECKSUM^VBECDCU2($P(VBECY(0),U,2))
 ...S VBECTOT=VBECTOT+$$CHECKSUM^VBECDCU2($P(VBECY(0),U,5))
 ...I VBECTOT'=$P(VBECIEN(0),U,6) D  S VBECFLG=1 K VBECTOT
 ....S:$P(VBECY(0),U)'=$P(VBECIEN(0),U,2) VBECFDA(6005,VBECIEN_",",.02)=$P(VBECY(0),U)
 ....S:$P(VBECY(0),U,2)'=$P(VBECIEN(0),U,3) VBECFDA(6005,VBECIEN_",",.03)=$P(VBECY(0),U,2)
 ....S:$P(VBECY(0),U,5)'=$P(VBECIEN(0),U,4) VBECFDA(6005,VBECIEN_",",.04)=$P(VBECY(0),U,5)
 ....S VBECFDA(6005,VBECIEN_",",.05)="@"
 ....S VBECFDA(6005,VBECIEN_",",.06)=VBECTOT
 ....S VBECFDA(6005,VBECIEN_",",.07)=+$E($$NOW^XLFDT(),1,12)
 ....D FILE^DIE("","VBECFDA")
 ....Q
 ...;
 ...Q
 ..Q
 .D UNLOCK^VBECDCU2(61.3)
 .Q
 D DELETE^VBECDCM2(61.3)
 I $G(VBECFLG) W !!,"Antigen/Antibody information updated.",!
 E  W !!,"Antigen/Antibody information current, not updated.",!
 D XIT^VBECDCM2
 Q
 ;
