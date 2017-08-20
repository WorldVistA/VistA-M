PXRMCSTX ;SLC/PKR - Routines for taxonomy code set update. ;10/01/2014
 ;;2.0;CLINICAL REMINDERS;**9,12,17,18,26,47**;Feb 04, 2005;Build 289
 ;
 ;=====================================================
CSU(TYPE) ;Entry point for code set update.
 I TYPE'="CPT",TYPE'="ICD" Q
 N IND,NL,NLINES,OUTPUT,PTYPE,TO,XMSUB
 D RBLDUID^PXRMTAXD
 S PTYPE=$S(TYPE="CPT":"a CPT",TYPE="ICD":"an ICD")
 S ^TMP("PXRMXMZ",$J,1,0)="There was "_PTYPE_" code set update on "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")_"."
 S ^TMP("PXRMXMZ",$J,2,0)=" "
 S ^TMP("PXRMXMZ",$J,3,0)="The taxonomy 'AUID' index has been rebuilt. "
 S ^TMP("PXRMXMZ",$J,4,0)=" "
 S NL=4
 D REPTEXT^PXRMUIDR(.NLINES,.OUTPUT)
 F IND=1:1:NLINES S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=OUTPUT(IND)
 I NLINES>3 D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Please review the affected taxonomies and take appropriate action."
 S XMSUB="Clinical Reminder taxonomy updates, "_TYPE_" global was updated."
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
