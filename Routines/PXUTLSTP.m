PXUTLSTP ;ISL/dee,ESW - Utility routine used by PCE to add/edit/delete stop code visits ; 7/25/03 4:12pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,96,166**;Aug 12, 1996
 Q
 ;
STOPCODE(PXUTSOR,PXUTSTOP,PXUTVST,PXUTSVST) ;Makes or edits visit to create the secondary visit for the credit stops
 ; Parameters
 ;   PXUTSOR   IEN of the Data source
 ;   PXUTSTOP  Pointer to Stop Code if "@" the delete the secondary visit
 ;   PXUTVST   Main visit
 ;   PXUTSVST  Secondary visit
 ;               if there is not one then create one
 ;               if there is one then this is an edit or delete
 ;
 ; Returns the pointer to the secondary visit 
 ;   or 0 if the secondary visit was deleted,
 ;   or null if visit tracking did not create the visit.
 ;
 D EVENT^PXKMAIN
 N PXUAFTER,PXUTNODE,PXUTRET,PXKERROR,PXUTEXIT
 K ^TMP("PXK",$J)
 S PXUTEXIT=0
 ;
 I $G(PXUTSVST)>0 D  Q:PXUTEXIT -1
 . L +^AUPNVSIT(PXUTSVST):5 E  W !!,$C(7),"Cannot edit at this time, try again later." D PAUSE^PXCEHELP S PXUTEXIT=1 Q
 . I PXUTSTOP="@" D
 ..;--ENTERED TO TRY TO KILL STOP CODES
DELETE ..;If stop code has to be killed on credit stop code visit then 
 ..; the whole visit has to be killed with and pointing to it
 ..; outpatient encounter.
 .. F PXUTNODE=0,21,150,800,811,812 D
 ... S (^TMP("PXK",$J,"VST",1,PXUTNODE,"AFTER"),^TMP("PXK",$J,"VST",1,PXUTNODE,"BEFORE"))=$G(^AUPNVSIT(PXUTSVST,PXUTNODE))
 .. S $P(^TMP("PXK",$J,"VST",1,0,"AFTER"),"^",8)="@"
 .. S ^TMP("PXK",$J,"VST",1,"IEN")=PXUTSVST
 ..; Verify if this is really credit stop visit with only 1 dependent
 ..; entry that is outpatient encounter.
 .. I $$DEC^VSITKIL(PXUTSVST,0)<2,$P($G(^AUPNVSIT(PXUTSVST,150)),U,3)="C" D   ;PX/96
 ... S ^TMP("PXK",$J,"VST",1,0,"AFTER")="@"
 ...; Find Outpatient Encounter to take care of
 ... N SDOEP
 ... D LISTVST^SDOERPC(.SDOEP,PXUTVST)
 ... S SDOEP=$P(SDOEP,")")_","_""""""_")"
 ... S SDOEP=$O(@SDOEP) D CHLD^SDCODEL(SDOEP,0)
 . E  D
EDIT .. F PXUTNODE=0,21,150,800,811,812 D
 ... S (^TMP("PXK",$J,"VST",1,PXUTNODE,"AFTER"),^TMP("PXK",$J,"VST",1,PXUTNODE,"BEFORE"))=$G(^AUPNVSIT(PXUTSVST,PXUTNODE))
 .. S $P(^TMP("PXK",$J,"VST",1,0,"AFTER"),"^",8)=PXUTSTOP
 .. S ^TMP("PXK",$J,"VST",1,"IEN")=PXUTSVST
 ;
 E  I $G(PXUTVST)>0 D
CREATE . F PXUTNODE=150,800,811 D
 .. S ^TMP("PXK",$J,"VST",1,PXUTNODE,"AFTER")=""
 .. S ^TMP("PXK",$J,"VST",1,PXUTNODE,"BEFORE")=""
 . S ^TMP("PXK",$J,"VST",1,21,"AFTER")=$G(^AUPNVSIT(PXUTVST,21))
 . S ^TMP("PXK",$J,"VST",1,21,"BEFORE")=""
 . S ^TMP("PXK",$J,"VST",1,150,"AFTER")="^^S"
 . S ^TMP("PXK",$J,"VST",1,150,"BEFORE")=""
 . S ^TMP("PXK",$J,"VST",1,812,"AFTER")="^^"_PXUTSOR
 . S ^TMP("PXK",$J,"VST",1,812,"BEFORE")=""
 . S PXUAFTER=$G(^AUPNVSIT(PXUTVST,0))
 . S ^TMP("PXK",$J,"VST",1,0,"AFTER")=$P(PXUAFTER,"^",1)_"^^^^"_$P(PXUAFTER,"^",5,6)_"^^"_PXUTSTOP_"^^^^"_PXUTVST_"^^^^^^^^^"_$P(PXUAFTER,"^",21,22)
 . S ^TMP("PXK",$J,"VST",1,0,"BEFORE")=""
 . S ^TMP("PXK",$J,"VST",1,"IEN")=""
 E  Q -1
 ;
 S ^TMP("PXK",$J,"SOR")=PXUTSOR
 D EN1^PXKMAIN
 S PXUTRET=^TMP("PXK",$J,"VST",1,"IEN")
 D EVENT^PXKMAIN
 K ^TMP("PXK",$J)
 I PXUTRET>0,$G(PXUTSVST)>0,PXUTSTOP="@" D
 . N PXUTKILL
 . S PXUTKILL=$$KILL^VSITKIL(PXUTSVST)
 . S:'PXUTKILL PXUTRET=0
 I $G(PXUTSVST)>0 L -^AUPNVSIT(PXUTSVST):5
 D MODIFIED^VSIT(PXUTVST)
 Q PXUTRET
 ;
 ;
 ;
 ;
DEAD(VSIT) ;---*** ADDED IN ALBANY BY VAUGHN
 ;--TO KILL LEFT OVER CREDIT STOP ENTRY THAT IS NOT DELETED
 ;-added next line to quit
 Q:$G(VSIT)<1
 N DEAD,CHILD
 S CHILD=0 F  S CHILD=$O(^AUPNVSIT("AD",VSIT,CHILD)) Q:CHILD=""  D
 .I $P($G(^AUPNVSIT(CHILD,0)),"^",8)="",$P($G(^AUPNVSIT(CHILD,0)),"^",9)<1,$P($G(^AUPNVSIT(CHILD,150)),"^",3)="C" S DEAD=$$KILL^VSITKIL(CHILD)
 ;-----END OF ADDED CODE  VAUGHN----
 ;
