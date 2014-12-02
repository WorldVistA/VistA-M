PXRMTXIC ;SLC/PKR - Reminder Taxonomy integrity check and repair. ;04/22/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;===================================
CHECKALL ;Check all taxonomies.
 N IEN,NAME,TEXT
 D MES^XPDUTL("Check the integrity of all reminder taxonomies.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:(NAME="")  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S TEXT(1)=" "
 . S TEXT(2)="Checking "_NAME_" (IEN="_IEN_")"
 . D MES^XPDUTL(.TEXT)
 . D INTCHK(IEN)
 Q
 ;
 ;===================================
CHECKONE ;Check selected definitions.
 N DIC,DTOUT,DUOUT,IEN,OK,Y
 S DIC="^PXD(811.2,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Reminder Taxonomy: "
GETTAX ;Get the taxonomy to check.
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 Q
 S IEN=$P(Y,U,1)
 D INTCHK(IEN)
 G GETTAX
 Q
 ;
 ;===================================
INTCHK(TAXIEN) ;Taxonomy integrity check.
 ;Check for search term inconsistencies.
 N CODESYS,DA1,IENS,NPROB,NTC,SAVEOK,TC,TCLIST,TEXT
 S TC=""
 F  S TC=$O(^PXD(811.2,TAXIEN,20,"ATC",TC)) Q:TC=""  D
 . S CODESYS=""
 . F  S CODESYS=$O(^PXD(811.2,TAXIEN,20,"ATC",TC,CODESYS)) Q:CODESYS=""  D
 .. S DA1=$P(^PXD(811.2,TAXIEN,20,"ATC",TC,CODESYS),U,1)
 .. S TCLIST(DA1,TC,CODESYS)=""
 ;Count the number of search terms that were stored and overwritten
 ;at DA1. There is a problem if there is more than one.
 S DA1=0
 F  S DA1=$O(TCLIST(DA1)) Q:DA1=""  D
 . S NTC=0,TC=""
 . F  S TC=$O(TCLIST(DA1,TC)) Q:TC=""  D
 .. S NTC=NTC+1
 . S TCLIST(DA1)=NTC
 S (DA1,NPROB)=0
 F  S DA1=$O(TCLIST(DA1)) Q:DA1=""  D
 . I TCLIST(DA1)<2 Q
 . S NPROB=NPROB+1
 . S NL=0,TC=""
 . S NL=NL+1,TEXT(NL)="WARNING: "_TCLIST(DA1)_" different search terms have been stored as the number "_DA1_" search term."
 . S NL=NL+1,TEXT(NL)="There can only be one number "_DA1_" search term."
 . S NL=NL+1,TEXT(NL)="The search terms were:"
 . F  S TC=$O(TCLIST(DA1,TC)) Q:TC=""  D
 .. S CODESYS=""
 .. F  S CODESYS=$O(TCLIST(DA1,TC,CODESYS)) Q:CODESYS=""  D
 ... S NL=NL+1,TEXT(NL)=" "_TC_"; coding system - "_CODESYS
 D MES^XPDUTL(.TEXT)
 ;If there were no problems quit.
 I NPROB=0 D MES^XPDUTL("No problems were found.") Q
 ;
 ;Reconstruct the 20 node using the "ATCC" index.
 K ^TMP("PXRMCODES",$J)
 M ^TMP("PXRMCODES",$J)=^PXD(811.2,TAXIEN,20,"ATCC")
 ;Delete the 20 node, then rebuild it.
 K ^PXD(811.2,TAXIEN,20)
 S SAVEOK=$$SAVETC^PXRMTXIM(TAXIEN)
 I SAVEOK D POSTSAVE^PXRMTXSM(TAXIEN)
 K ^TMP("PXRMCODES",$J)
 S TEXT="Reconstruction done."
 D MES^XPDUTL(.TEXT)
 Q
 ;
