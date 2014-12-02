PXRMCSTX ;SLC/PKR - Routines for taxonomy code set update. ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**9,12,17,18,26**;Feb 04, 2005;Build 404
 ;
 ;=====================================================
CSU(TYPE) ;Entry point for code set update.
 I TYPE'="CPT",TYPE'="ICD" Q
 N IND,NL,NLINES,OUTPUT,PTYPE,XMSUB
 S PTYPE=$S(TYPE="CPT":"a CPT",TYPE="ICD":"an ICD")
 S ^TMP("PXRMXMZ",$J,1,0)="There was "_PTYPE_" code set update on "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")_"."
 S ^TMP("PXRMXMZ",$J,2,0)=" "
 S NL=2
 D REPTEXT^PXRMUIDR(.NLINES,.OUTPUT)
 F IND=1:1:NLINES S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=OUTPUT(IND)
 I NLINES>3 D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Please review the affected taxonomies and take appropriate action."
 S XMSUB="Clinical Reminder taxonomy updates, "_TYPE_" global was updated."
 N TO
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
