DG53705I ;ALB/TMK - DG*5.3*705 Pre-Install Routine ; 05-APR-2006
 ;;5.3;Registration;**705**;Aug 13, 1993
 ;
EN ; Description: This entry point will be used as a driver for
 ;  pre-installation updates.
 ; DBIA: 4542 for direct DD global access/kills and for one-time
 ;       call to Fileman PT node cleanup (PT^DDUCHK1)
 ;
 ; If the patch DVB*4*54 was not installed, skip the cleanup
 N %
 K ^TMP("DG*5.3*705",$J)
 S %=$$CKUPD^DG53705E()
 I '% D  Q
 . N ZMES,I
 . F I=1,2 S ZMES(I)=" "
 . S ZMES(3)="**** PATCH IS BEING INSTALLED IN NON-UPDATE MODE ****"
 . S ZMES(4)=" "
 . S ZMES(5)="NOTE: THE SYSTEM HAS DETERMINED THAT YOUR PATIENT FILE DOES NOT HAVE BAD"
 . S ZMES(6)="      DATA FROM PATCH DVB*4*54.  THEREFORE, THE STATUS OF PATCH DG*5.3*705"
 . S ZMES(7)="      WILL BE 'INSTALLED', HOWEVER NO UPDATES TO YOUR SYSTEM WILL BE MADE."
 . D MES^XPDUTL(.ZMES)
 ;
 D BMES^XPDUTL("**** PATCH IS BEING INSTALLED IN UPDATE MODE ****")
 D DELMISC
 D DELPTR
 D DELXREF
 D DELID
 D DELDESCR
 D DONE
 Q
 ;
DELMISC ; Delete various miscellaneous nodes:
 ; write access, help, executable help, audit, etc
 D BMES^XPDUTL(">>> Deleting bad write access, help, audit, other miscellaneous nodes")
 K ^DD(2,.12113,9),^DD(2,.14112,9)
 K ^DD(2,.108,3)
 K ^DD(2,.391,4)
 F Z=.01,.2924,.3111,.3192,991.07 K ^DD(2,Z,"AUDIT")
 K ^DD(2.312,.18,"AUDIT")
 K ^DIC(2,0,"AUDIT")
 K ^DD(2,0,"VR")
 K ^DD(2,0,"VRPK")
 K ^DIC(2,"%",7,0)
 K ^DIC(2,"%","B","QAM",7)
 D STEP
 Q
 ;
DELPTR ; Delete bad pointer nodes
 N Z,Z0
 D BMES^XPDUTL(">>> Deleting bad pointer nodes")
 S DDUCFI=2,DDUCFIX=1 D PT^DDUCHK1 ; IA
 D STEP
 Q
 ;
DELID ; Delete bad identifier nodes
 N Z
 D BMES^XPDUTL(">>> Deleting bad identifier nodes")
 F Z=.2924,.302,.351,"GARB","WARD","WR","ZREW" K ^DD(2,0,"ID",Z)
 D STEP
 Q
 ;
DELDESCR ;Delete excess description nodes
 N Z
 D BMES^XPDUTL(">>> Deleting bad field description nodes")
 S Z=1 F  S Z=$O(^DD(2,.107,21,Z)) Q:'Z  K ^DD(2,.107,21,Z,0)
 D STEP
 Q
 ;
DELXREF ; Delete cross references and indexes
 N DGZ,DGZF,DGZFLD,DGZN,DGDEL,DGXREF,X,Z
 D BMES^XPDUTL(">>> Deleting bad cross references and indexes")
 ;
 ; Delete indexes 'ADGFM01', 'ADGFM03', 'ADGFM09', 'ADGFM351'
 F DGZ="ADGFM01","ADGFM03","ADGFM09","ADGFM351" D DELIXN^DDMOD(2,DGZ)
 ; Delete a trigger xref for file 2.01, field 100.03
 S Z=0 F  S Z=$O(^DD(2.01,100.03,1,Z)) Q:'Z  I $P($G(^DD(2.01,100.03,1,Z,0)),U,3,5)="TRIGGER^20^.01" D DELIX^DDMOD(2.01,100.03,Z) Q
 ;
 F Z=2:1 S X=$P($T(@("XREF+"_Z)),";;",2) Q:X=""  S DGZ(+X,+$P(X,U,2),$P(X,U,4))=$P(X,U,3) ;Extracts xrefs to delete
 ;
 S DGZF=0
 F  S DGZF=$O(DGZ(DGZF)) Q:'DGZF  S DGZFLD=0 F  S DGZFLD=$O(DGZ(DGZF,DGZFLD)) Q:'DGZFLD  S DGZN="" F  S DGZN=$O(DGZ(DGZF,DGZFLD,DGZN)) Q:DGZN=""  D
 . S DGZ=$G(DGZ(DGZF,DGZFLD,DGZN))
 . I 'DGZ,'$$CHK1(DGZF,DGZFLD,DGZN) K ^DD(DGZF,0,"IX",DGZN,DGZF,DGZFLD)
 . I DGZ S Z=$$CHK2(DGZF,DGZFLD,DGZN,DGZ) I Z D DELIX^DDMOD(DGZF,DGZFLD,Z)
 K ^TMP("DIERR",$J)
 D STEP
 Q
 ;
CHK1(FILE,FLD,XREFNM) ; Check if xref exists
 ; Functon returns 1 if it exists, 0 if it doesn't
 N Z,OK
 S (OK,Z)=0
 F  S Z=$O(^DD(FILE,FLD,1,Z)) Q:'Z  I $P($G(^(Z,0)),U,2)=XREFNM S OK=1 Q
 Q OK
 ;
CHK2(FILE,FLD,XREFNM,XREFNO) ; Returns ien of xref
 N Z,NUM
 S Z=0
 S NUM=$S($P($G(^DD(FILE,FLD,1,XREFNO,0)),U,2)=XREFNM:XREFNO,1:0)
 I 'NUM F  S Z=$O(^DD(FILE,FLD,1,Z)) Q:'Z  I $P($G(^DD(FILE,FLD,1,Z,0)),U,2)=XREFNM S NUM=Z Q
 Q NUM
 ;
STEP D BMES^XPDUTL(">>> Step Completed.")
 Q
 ;
DONE D BMES^XPDUTL(">>> Pre-install Cleanup Completed.")
 S ^TMP("DG*5.3*705",$J)="1^PATCH DVB*4*54 INSTALLED"
 Q
 ;
CLEAN ; Erase TMP global used to screen DD update
 K ^TMP("DG*5.3*705",$J)
 Q
 ;
XREF ; Xrefs that must be deleted
 ;; Pieces are: File #^Fld #^xref default #or null^xref name
 ;;2^.01^^AHL
 ;;2^.02^^AHL2
 ;;2^.03^^AHL3
 ;;2^.03^5^DGFCMON
 ;;2^.05^993^AENR05
 ;;2^.06^^AHL5
 ;;2^.09^^AHL4
 ;;2^.102^^A4EC
 ;;2^.118^3^AENR118
 ;;2^.121^1^AENR121
 ;;2^.12111^1^AENR12111
 ;;2^.1219^1^AENR1219
 ;;2^.14111^1^AENR14111
 ;;2^.152^4^AU
 ;;2^.1656^1^AENR1656
 ;;2^.293^1^AENR293
 ;;2^.302^^ACP
 ;;2^.302^^AP
 ;;2^.3025^3^AENR3025
 ;;2^.3025^^CHK4
 ;;2^.304^1^AENR304
 ;;2^.307^1^AENR307
 ;;2^.3111^2^AENR3111
 ;;2^.31115^^AEMP
 ;;2^.31115^992^AENR31115
 ;;2^.31115^^MAC
 ;;2^.312^2^AENR312
 ;;2^.313^992^AENR313
 ;;2^.3192^1^AENR3192
 ;;2^.32102^^AI
 ;;2^.32103^^AK
 ;;2^.323^992^AENR323
 ;;2^.351^^AEXP
 ;;2^.351^^AHL6
 ;;2^.351^^AT
 ;;2^.353^1^AENR353
 ;;2^.354^1^AENR354
 ;;2^.361^^AR
 ;;2^.3611^3^AENR3611
 ;;2^.3612^2^AENR3612
 ;;2^.3615^1^AENR3615
 ;;2^.3617^1^AENR3617
 ;;2^.3618^1^AENR3618
 ;;2^.36205^^BEN
 ;;2^.36205^^CHK1
 ;;2^.36215^^CHK2
 ;;2^.36235^^CHK3
 ;;2^.381^^AT
 ;;2^.382^1^AENR382
 ;;2^.391^1^AENR391
 ;;2^.392^1^AENR392
 ;;2^.393^1^AENR393
 ;;2^.394^1^AENR394
 ;;2^.395^1^AENR395
 ;;2^.532^2^AENR532
 ;;2^.533^1^AENR533
 ;;2^1010.1511^1^AENR10101511
 ;;2^1010.159^1^AENR1010159
 ;;2^1901^2^AN
 ;;2.04^.01^1^AENR01
 ;;2.04^2^1^AENR2
 ;;2.04^3^1^AENR3
 ;;2.312^.01^6^AENR01
 ;;2.312^.18^2^AENR18
 ;;2.312^1^2^AENR1
 ;;2.312^2^1^AENR2
 ;;2.312^3^2^AENR3
 ;;2.312^6^1^AENR6
 ;;2.312^8^2^AENR8
 ;;2.312^17^1^AENR17
 ;;2.396^.01^2^AENR01
 ;;2.397^.01^2^AENR01
 ;;2.397^1^1^AENR1
 ;;2.398^.01^2^AENR01
 ;;2.398^1^1^AENR1
 ;;2.398^2^1^AENR2
