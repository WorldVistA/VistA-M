GMRCTIUA ;SLC/DCM,DLT - Add the TIU note to the results multiple ;4/30/98  11:13
 ;;3.0;CONSULT/REQUEST TRACKING;**4**;DEC 27, 1997
ADD(TIUDA,GMRCO) ;Add a new note from TIU to the associated results
 ;multiple and update the TIU NARRATIVE RESULT field as the last note
 ;modified.
 ;
 ;Input parameters:
 ;    TIUDA = pointer value to TIU(8925, not in variable pointer format
 ;    GMRCO = consult entry from 123 to get the result
 ;
 N GMRCY S GMRCY=0
 I '$D(^GMR(123,+GMRCO,50)),+$P(^GMR(123,+GMRCO,0),"^",20) S GMRCY=$$LOAD(GMRCO)
 Q:GMRCY  ;The consult is locked
 S GMRCY=$$UPDATE(TIUDA,GMRCO)
 Q
 ;
LOAD(GMRCO) ;function to load the result from field 16 into the 50th node
 N RSLT16,DR,DA,DIE,GMRCQUT
 S GMRCQUT=0
 S RSLT16=$P(^GMR(123,+GMRCO,0),"^",20)_";TIU(8925,"
 D ADDRSLT(GMRCO,RSLT16)
 Q GMRCQUT
 ;
UPDATE(TIUDA,GMRCO) ;Update the TIU Narrative Result last updated
 N GMRCVDA,DR,DA,DIE,GMRCQUT
 S GMRCQUT=0
 S DIE="^GMR(123,",DA=GMRCO,DR="16////"_TIUDA D ^DIE
 ;
 ;Add result to the result multiple
 S GMRCVDA=TIUDA_";TIU(8925,"
 D ADDRSLT(GMRCO,GMRCVDA)
 Q GMRCQUT
 ;
ADDRSLT(GMRCO,RESULT) ;Add a result to the Associated Results multiple
 Q:$O(^GMR(123,GMRCO,50,"B",RESULT,0))
 L +^GMR(123,+GMRCO,50):5 E  D  Q
 . S GMRCQUT=1,GMRCMSG="Result did NOT get associated with consult."
 . S GMRCMSG(1)="Consult in use by another user. Try again later."
 . D EXAC^GMRCADC(.GMRCMSG) K GMRCMSG
 ;Check if this result has already been added to the results multiple
 ;If it is already defined then quit processing this consult
 ;
 ;Get the next DA entry for a new result and add the result.
 S DA=$$ADD50(GMRCO)
 S DIE="^GMR(123,"_+GMRCO_",50,",DA(1)=+GMRCO,DR=".01////^S X=RESULT"
 D ^DIE
 L -^GMR(123,+GMRCO,50)
 Q
 ;
ADD50(GMRCO) ;Add a field 50 node if does not exist; add a new multiple to 50 if it already exists. Returns DA of added node if successful.
 N DA
 S:'$D(^GMR(123,+GMRCO,50,0)) ^(0)="^123.03V^^"
 S DA=$S(+$P(^GMR(123,+GMRCO,50,0),"^",3):$P(^(0),"^",3)+1,1:1)
 S $P(^GMR(123,+GMRCO,50,0),"^",3,4)=DA_"^"_DA
 Q DA
 ;
