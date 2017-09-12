ENXPIPS ;WIRMFO/SAB-POST-INIT ;4.11.97
 ;;7.0;ENGINEERING;**35**;AUG 17, 1993
 ;
 ; *** test site only section - remove for national release
 ;D BMES^XPDUTL("  Restoring Model cross-reference as regular...")
 ;K ^ENG(6914,"E")
 ;K DA S DIK="^ENG(6914,",DIK(1)="4^1" D ENALL^DIK K DIK
 ;D BMES^XPDUTL("  Restoring Serial cross-reference as regular...")
 ;K ^ENG(6914,"F")
 ;K DA S DIK="^ENG(6914,",DIK(1)="5^1" D ENALL^DIK K DIK
 ; *** end test site only section
 ;
 Q:$$PATCH^XPDUTL("EN*7.0*35")  ; only do during 1st install
 ;
 ; create KIDS checkpoints with call backs
 F ENX="EQMODXF","EQSERXF","ZZMAN","PMPROC","MISC","LOC" D
 . S Y=$$NEWCP^XPDUTL(ENX,ENX_"^ENXPIPS")
 . I 'Y D DMES^XPDUTL("ERROR Creating "_ENX_" Checkpoint.")
 Q
 ;
EQMODXF ; build new equipment model trigger cross-reference
 N DA,DIK
 D BMES^XPDUTL("  Building new Model cross-reference...")
 K DA S DIK="^ENG(6914,",DIK(1)="4^2" D ENALL^DIK K DIK
 Q
 ;
EQSERXF ; rebuild equipment serial # cross-references
 N DA,DIK
 D BMES^XPDUTL("  Building new Serial # cross-reference...")
 K DA S DIK="^ENG(6914,",DIK(1)="5^2" D ENALL^DIK K DIK
 Q
 ;
ZZMAN ; remove ZZ prefixes from #6912 local entries when not duplicate
 N DA,DIE,ENX,X,Y
 D BMES^XPDUTL("  Removing ZZ prefixes from Manufacturer List (#6912)")
 S DIE="^ENG(""MFG"",",DR=".01///^S X=ENX"
 S DA=49999
 F  S DA=$O(^ENG("MFG",DA)) Q:'DA  S Y=$G(^(DA,0)) D:$E($P(Y,U),1,2)="ZZ"
 . S ENX=$E($P(Y,U),3,99)
 . I ENX]"",'$O(^ENG("MFG","B",ENX,0)) D ^DIE
 Q
 ;
PMPROC ; Build new "C" xref: PM PROCEDURES (#69114.2) file PROCEDURE TITLE (#1)
 N DA,DIK
 D BMES^XPDUTL("  Building new 'C' x-ref in PM PROCEDURES (#6914.2)...")
 S DIK="^ENG(6914.2,",DIK(1)="1" D ENALL^DIK K DIK
 Q
 ;
MISC ; beginning of misc stuff
 N DA,DIK
SECT ; Build new "C" xref: ENG SECTION LIST (#6922) file ABBREVIATION (#1)
 D BMES^XPDUTL("  Building new 'C' x-ref in ENG SECTION LIST (#6922)...")
 S DIK="^DIC(6922,",DIK(1)="1" D ENALL^DIK K DIK
 ;
BIOMED ; Use ENWOBIOCLSE for shop 35 (Biomed) work order close out
 I $G(^DIC(6922,35,0))]"",$P(^(0),U,5)="" S $P(^(0),U,5)=1
 ;
ASKCC ; Loop thru shops and enable ASK CONDITION CODE
 D BMES^XPDUTL("  Setting ASK CONDITION CODE to ALWAYS for Sections...")
 S ENDA=0 F  S ENDA=$O(^DIC(6922,ENDA)) Q:'ENDA  D
 . S:$P($G(^DIC(6922,ENDA,0)),U,4)="" $P(^(0),U,4)=2
 ;
IIWO ; Set Incoming Inspection Software Option to 2
 D BMES^XPDUTL("  Set ASK INCOMING INSPECTION W.O. Software Option to YES...")
 S ENI=$O(^ENG(6910.2,"B","ASK INCOMING INSPECTION W.O.",0))
 I ENI,$P(^ENG(6910.2,ENI,0),U,2)="" S $P(^ENG(6910.2,ENI,0),U,2)="2"
 ;
BLDGXR ; Build regular x-ref of File 6928.3 by DIVISION
 N DA,DIK
 D BMES^XPDUTL("  Building regular DIVISION x-ref on File 6928.3.")
 S DIK="^ENG(6928.3,",DIK(1)=".2" D ENALL^DIK
 ;
MISCX ; end of misc stuff
 Q
 ;
LOC ; check exported templates for local version
 N ENTEXT,ENTYP,ENX,ENY
 D BMES^XPDUTL("  Checking for local versions of patched templates...")
 D LINPT^ENXPIEN ; input templates
 D LSRTT^ENXPIEN ; sort templates
 D LPRTT^ENXPIEN ; print templates
 ; report existence of local templates
 I '$D(ENY) D MES^XPDUTL("    none found.")
 I $D(ENY) D
 . D MES^XPDUTL("  Local versions of patched template(s) exist. These local template(s)")
 . D MES^XPDUTL("  are used in lieu of the national template(s) modified by this patch.")
 . D BMES^XPDUTL("    The following local template(s) should be examined and updated")
 . D MES^XPDUTL("    to include any appropriate changes made by this patch to the")
 . D MES^XPDUTL("    corresponding national template.")
 . S ENTEXT="    Local Template             Type   File      Patched National Template"
 . D BMES^XPDUTL(ENTEXT)
 . S ENTEXT="    -------------------------  -----  --------  -------------------------"
 . D MES^XPDUTL(ENTEXT)
 . F ENTYP="INP","SRT","PRT" D
 . . S ENTYP("E")=$S(ENTYP="INP":"Input",ENTYP="SRT":"Sort ",ENTYP="PRT":"Print",1:"")
 . . S ENX("L")="" F  S ENX("L")=$O(ENY(ENTYP,ENX("L"))) Q:ENX("L")=""  D
 . . . S ENTEXT="    "_$$LJ^XLFSTR(ENX("L"),25)
 . . . S ENTEXT=ENTEXT_"  "_ENTYP("E")
 . . . S ENTEXT=ENTEXT_"  "_$$LJ^XLFSTR($P(ENY(ENTYP,ENX("L")),U,3),8)
 . . . S ENTEXT=ENTEXT_"  "_$P(ENY(ENTYP,ENX("L")),U,2)
 . . . D MES^XPDUTL(ENTEXT)
 Q
 ;ENXPIPS
