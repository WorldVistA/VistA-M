TIUPREF ; SLC/JER - Enter/edit personal preferences ; 19-AUG-2002 13:10:05
 ;;1.0;TEXT INTEGRATION UTILITIES;**10,91,103,111,141**;Jun 20, 1997
 ;
GOODLOC(LOC) ; Returns 1 if ^SC hospital location IFN LOC is good, else 0
 ; Used in TIUVSIT, in DDs for LOCATION field of 8926
 N GOODLOC,INACTIVE,OOS,CLINIC S (GOODLOC,INACTIVE)=0
 I +$G(^SC(LOC,"I"))>0,(+$G(^("I"))'>DT) D
 . S INACTIVE=1
 . ; check if reactivated:
 . I +$P($G(^("I")),U,2)>0,$P($G(^("I")),U,2)'>DT S INACTIVE=0
 S OOS=+$D(^SC(LOC,"OOS")) ; Occasion of service
 S CLINIC=+($P(^SC(LOC,0),U,3)="C")
 I 'INACTIVE,'OOS,CLINIC S GOODLOC=1
 Q GOODLOC
 ;
MAIN ; Control branching
 N DA
 S DA=+$$GETREC
 I +DA'>0 Q
 D EDIT(DA)
 Q
GETREC() ; Get record in picklist file
 N DIC,DLAYGO,TIUNM,X,Y,ASKNEW
 S (DIC,DLAYGO)=8926,DIC(0)="NXLZ"
 S DIC("S")="I $P(^(0),U)=DUZ" ;TIU*1*91 If user already in file but has same name as another entry, select user
 S X="`"_DUZ,TIUNM=$P(^VA(200,+$G(DUZ),0),U)
 W !,"   Enter/edit Personal Preferences"
 W !!?5,TIUNM
 D ^DIC
 ;TIU*1*91 If DIC adds new entry, can get anyone w/ same name:
 I Y>0,+Y(0)'=DUZ N DA,DIK D
 . W !!,"   Sorry, you can edit preferences for YOURSELF only.  Please try again."
 . I $P(Y,U,3)=1 S DA=+Y,DIK="^TIU(8926," D ^DIK S Y=-1
 Q +$G(Y)
EDIT(DA) ; Call ^DIE to edit the record
 N DIE,DR,TIUCLASS,TIUREQCS,LOC
 S DIE=8926,TIUREQCS=+$$REQCOS(DUZ)
 S LOC=+$P(^TIU(8926,DA,0),U,2)
 I LOC>0,'$$GOODLOC(LOC) W !,"   Your default location is no longer valid and has been deleted.",!,"   Please choose a new one." S DR=".02///@" D ^DIE
 S DR=".02:.08;.1;.11;I +TIUREQCS'>0 S Y=""@1"";.09;@1;1"
 S DR(2,8926.01)=".01;.02;.03" D ^DIE
 Q
REQCOS(DUZ) ; Does user require cosignature for any documents
 N TIUI,TIUJ,TIUC,TIUY S (TIUI,TIUY)=0
 ; Is the user required to have a cosignature on any document?
 F  S TIUI=$O(^TIU(8925.95,TIUI)) Q:+TIUI'>0!+TIUY  D
 . S TIUJ=0
 . F  S TIUJ=$O(^TIU(8925.95,TIUI,5,TIUJ)) Q:+TIUJ'>0!+TIUY  D
 . . S TIUC=+$G(^TIU(8925.95,TIUI,5,TIUJ,0)) Q:+TIUC'>0
 . . S TIUY=+$$ISA^USRLM(DUZ,TIUC)
 Q TIUY
