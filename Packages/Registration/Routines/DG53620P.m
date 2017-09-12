DG53620P ;Plano/DW - Post installation routine ; 8/2/2004
 ;;5.3;Registration;**620**;Aug 13, 1993
 Q
EN ;Entry point
 ;
 ;Update input transforms
 D DD^DG53620D
 ;
 ;Update cross-references
 D EN^DG53620X
 ;
 ;Recompile templates
 D TMPL
 ;
 ;Update triggered fields
 D TRIG
 ;
 Q
 ;
TMPL ;Recompile input templates
 N DGFLD
 D BMES^XPDUTL("Recompiling templates...")
 F DGFLD=.01,.211,.2191,.2401,.2402,.2403,.331,.3311,.341 S DGFLD(2,DGFLD)=""
 D DIEZ^DIKCUTL3(2,.DGFLD)
 K DGFLD S DGFLD(2.01,.01)="" D DIEZ^DIKCUTL3(2.01,.DGFLD)
 K DGFLD S DGFLD(2.101,30)="" D DIEZ^DIKCUTL3(2.101,.DGFLD)
 Q
 ;
TRIG ;Update trigger definitions
 N DGFLD
 D BMES^XPDUTL("Updating trigger field definitions...")
 F DGFLD=.01,.211,.2191,.2401,.2402,.2403,.331,.3311,.341 S DGFLD(2,DGFLD)=""
 D T1(.DGFLD)
 K DGFLD S DGFLD(2.01,.01)="" D T1(.DGFLD)
 K DGFLD S DGFLD(2.101,30)="" D T1(.DGFLD)
 Q
 ;
T1(DGFLD) ;Check/update triggering field definitions
 ;Input: DGFLD=array of fields to update
 N DGOUT,DGFILE
 D TRIG^DICR(.DGFLD,.DGOUT)
 S DGFILE=0 F  S DGFILE=$O(DGOUT(DGFILE)) Q:'DGFILE  D
 .S DGFLD=0 F  S DGFLD=$O(DGOUT(DGFILE,DGFLD)) Q:'DGFLD  D
 ..D MES^XPDUTL("         Field #"_DGFLD_" of file #"_DGFILE_" updated.")
 Q
 ;
