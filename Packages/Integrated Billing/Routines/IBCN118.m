IBCN118 ;ALB/KML - TRIGGER LOGIC CALLED BY DD XREF 2.312, 1.08 ;06-APR-2015
 ;;2.0;INTEGRATED BILLING;**528,565**;21-MAR-94;Build 41
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
TRIGSET ; trigger called from MUMPS xref from DD(2.312, 1.08)
 ; ensure that the new fields at the new COMMENT - SUBSCRIBER POLICY multiple (2.312, 1.18) get updated when 2.312, 1.08 is edited
 ;
 ; Expected variables:
 ;   DA = system wide array of iens associated with the patient record
 ;  DUZ = system wide user IEN
 ;
 N IBDT,IBDFN,IBPOLDA,IBCDA,IBPOLCOM
 ;
 S IBDFN=$G(DA(1)),IBPOLDA=$G(DA),IBPOLCOM=$P($G(^DPT(IBDFN,.312,IBPOLDA,1)),U,8)
 ;
 ; -- comments do not exist for the user so add comments
 I '$O(^DPT(IBDFN,.312,IBPOLDA,13,"C",DUZ,"")) D ADCOM(IBDFN,IBPOLDA,IBPOLCOM) Q
 ;
 ; -- get the last policy comment entered and the comment IEN
 S IBDT=$O(^DPT(IBDFN,.312,IBPOLDA,13,"B",""),-1),IBCDA=$O(^DPT(IBDFN,.312,IBPOLDA,13,"B",IBDT,""),-1)
 ;
 ; -- edit comment if comment exist for the user
 I $P(^DPT(IBDFN,.312,IBPOLDA,13,IBCDA,0),U,2)=DUZ D EDCOM(IBDFN,IBDT,IBCDA)
 Q
 ;
ADCOM(IBDFN,IBPOLDA,IBPOLCOM) ; add new patient policy comment to multiple (2.312, 1.18)
 ;
 L +^DPT(IBDFN,.312,IBPOLDA,13):5 I '$T D CMLKD Q
 ;
 N FDA,IENS,DIERR
 ;
 ; -- populate FDA array
 S IENS="+1"_","_IBPOLDA_","_IBDFN_","
 S FDA(2.342,IENS,.01)=$$NOW^XLFDT()
 S FDA(2.342,IENS,.02)=DUZ
 S FDA(2.342,IENS,.03)=IBPOLCOM
 ;
 ; -- add comments
 D UPDATE^DIE(,"FDA",,"DIERR") I $D(DIERR) W !,!,"Error...ADCOM-IBCN118...Cannot Add policy comment" D PAUSE^VALM1
 L -^DPT(IBDFN,.312,IBPOLDA,13)
 Q
 ;
EDCOM(IBDFN,IBDT,IBCDA) ; edit existing comment entry at 2.312,1.18 multiple
 ; Input:
 ;   IBDT  = date/time that comment was made
 ;   CMIEN = comment IEN
 ;
 ; -- only make edits to comments if the first 80 characters are different
 Q:$P($G(^DPT(IBDFN,.312,IBPOLDA,1)),U,8)=$E($P(^DPT(IBDFN,.312,IBPOLDA,13,IBCDA,1),U),1,80)
 ;
 N FDA,IENS,DIERR
 ;
 L +^DPT(IBDFN,.312,IBPOLDA,13):5 I '$T D CMLKD Q
 ;
 ; -- populate FDA array
 S IENS=IBCDA_","_IBPOLDA_","_IBDFN_","
 S FDA(2.342,IENS,.01)=$$NOW^XLFDT()
 S FDA(2.342,IENS,.02)=DUZ
 S FDA(2.342,IENS,.03)=$P($G(^DPT(IBDFN,.312,IBPOLDA,1)),U,8)
 ;
 ; -- update comments
 D FILE^DIE("","FDA","DIERR") I $D(DIERR) W !,!,"Error...EDCOM-IBCN118...Cannot edit policy comments" D PAUSE^VALM1
 L -^DPT(IBDFN,.312,IBPOLDA,13)
 Q
 ;
TRIGKIL ; remove data at 2.312, 1.18 multiple when 2.312, 1.08 gets removed
 ;
 ; -- don't kill data at 1.18 multiple since data exists at 2.313, 1.08
 Q:$P(^DPT(DA(1),.312,DA,1),U,8)]""
 ;
 N FDA,IBDT,CMIEN,IENS,DIERR
 ;
 S IBDT=$O(^DPT(DA(1),.312,DA,13,"BB",DUZ,""),-1)
 ;
 ; -- user doesn't have comments at the 1.18 multiple or the user has comments but not for the current date so quit
 Q:IBDT']""  Q:$P(IBDT,".")'=DT
 ;
 ; -- populate FDA array
 S CMIEN=$O(^DPT(DA(1),.312,DA,13,"BB",DUZ,IBDT,""),-1)
 S IENS=CMIEN_","_DA_","_DA(1)_","
 S FDA(2.342,IENS,.01)="@"
 S FDA(2.342,IENS,.02)="@"
 S FDA(2.342,IENS,.03)="@"
 ;
 ; -- update comments
 D FILE^DIE("","FDA","DIERR") I $D(DIERR) W !,!,"Error...TRIGKIL-IBCN118...Cannot Remove data from (2.312,1.18)" D PAUSE^VALM1
 Q
 ;
CMLKD ; -- write record locked message
 W !!,"Sorry, another user currently editing this entry."
 W !,"Try again later."
 D PAUSE^VALM1
 Q
