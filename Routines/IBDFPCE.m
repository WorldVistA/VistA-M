IBDFPCE ;ALB/AAS - AICS UPDATE FROM PCE ; 12-DEC-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
MAN ; -- called from IBDF PCE EVENT (invoked by the PXK VISIT DATA EVENT)
 ;    if aics starts event, quit
 ;    else
 ;    find appointment date from visit node
 ;    find entry in forms tracking for visit
 ;    update manual data entry field to yes if new or old visit edited
 ;    update manual data entry field to no if entry deleted
 ;
 Q:$D(IBD("AICS"))
 N IBDVST,IBD,IBDFN
 S (IBDVST,IBDFN)=""
 ;
 F  S IBDVST=$O(^TMP("PXKCO",$J,IBDVST)) Q:'IBDVST  D
 .S IBDVST("AFTER")=$G(^TMP("PXKCO",$J,IBDVST,"VST",IBDVST,0,"AFTER")),IBDVST("BEFORE")=$G(^("BEFORE"))
 .;
 .; -- new or old visit
 .I IBDVST("AFTER")]"",IBDVST("BEFORE")]""!(IBDVST("BEFORE")="") S IBD("APPT")=+IBDVST("AFTER"),IBD("VALUE")=1,IBDFN=$P(IBDVST("AFTER"),"^",5) D UPDATE(.IBD) Q
 .;
 .; -- deleted visit
 .I IBDVST("AFTER")="",IBDVST("BEFORE")]"" S IBD("APPT")=+IBDVST("BEFORE"),IBD("VALUE")=0,IBDFN=$P(IBDVST("BEFORE"),"^",5) D UPDATE(.IBD) Q
 ;
 Q
 ;
UPDATE(IBD) ; -- procedure to update manual data entry detected
 ;
 N X,Y,DA,DIC,DIE,DR,IBDX,IBDC
 Q:'$G(IBDFN)!('$G(IBD("APPT")))!('$G(IBD("VALUE")))
 I '$D(IBD("FORM ID")) S IBD("FORM ID")=$$FINDID^IBDF18C(IBDFN,IBD("APPT"))
 ;
 ; -- ibd(form id) can be returned with multiple pieces if more than
 ;    one form for appt.
 F IBDX=1:1 S DA=+$P(IBD("FORM ID"),"^",IBDX) Q:'DA  D
 . Q:$P($G(^IBD(357.96,+DA,0)),"^",13)
 . Q:$P($G(^IBD(357.96,+DA,0)),"^",2)'=IBDFN
 . Q:$P($G(^IBD(357.96,+DA,0)),"^",3)'=IBD("APPT")
 . S DIE="^IBD(357.96,",DR=".13////"_+$G(IBD("VALUE"))
 . D ^DIE S IBDC=$G(IBDC)+1
 . I IBDC=1,'$D(ZTQUEUED) W !,"Updating Encounter Form Tracking (AICS)"
 Q
