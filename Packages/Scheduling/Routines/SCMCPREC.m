SCMCPREC ;bpoifo/swo move preceptors;3.20.08
 ;;5.3;Scheduling;**504**;AUG 13, 1993;Build 21
 Q
LISTPREC(SCRESULT,SCPIEN)  ;
 ;List preceptees for a preceptor position
 ;Input
 ;   SCPIEN   := preceptor pos ien (404.57) (required)
 ;   SCRESULT := return array
 ;               Piece     Description
 ;                 1       IEN of NEW PERSON file entry (#200)
 ;                 2       Name of person
 ;                 3       IEN of TEAM POSITION file (#404.57)
 ;                 4       Name of Position
 ;                 5       IEN OF USR CLASS(8930) of POSITION (404.57)
 ;                 6       USR Class Name
 ;                 7       IEN of STANDARD POSITION (#403.46)
 ;                 8       Standard Role (Position) Name
 ;                 9       Activation Date for 404.52 (not 404.59!)
 ;                 10      Inactivation Date for 404.52
 ;                 11      IEN of Position Asgn History (404.52)
 ;                 12      IEN of Current(=DT) Preceptor Position
 ;                 13      Name of Current(=DT) Preceptor Position
 ;                 14      precept start date
 ;                 15      precept end date
 ;                 16      IEN of Preceptor Asgn History (404.53)
 N SCDATES,V1
 I SCPIEN="" S SCRESULT(0)=0 Q 0
 S SCDATES("BEGIN")=DT
 S SCDATES("END")=DT
 S SCDATES("INCL")=0
 S V1=$$PRECHIS^SCMCLK(SCPIEN,"SCDATES","SCRESULT") I $D(SCRESULT) K SCRESULT("SCPR") Q 1
 S SCRESULT(0)=0
 Q 0
MOVEPREC(SCRESULT,SCPIEN1,SCED1,SCPIEN2,SCED2)  ;
 ;Move preceptees from one position to another
 ;Input
 ;   SCPIEN1   := FROM preceptor pos ien (404.57) (required)
 ;   SCPIEN2   := TO preceptor pos ien (404.57) (required)
 ;   SCED1     := FROM preceptor effective date
 ;   SCED2     := TO preceptor effective date
 ;   SCRESULT  := return array 0 = fail 1 = success
 I SCPIEN1="" S SCRESULT(0)=0 Q 0
 I SCPIEN2="" S SCRESULT(0)=0 Q 0
 S SCED1=$S($G(SCED1)="":"T-1",1:SCED1)
 S SCED2=$S($G(SCED2)="":"TODAY",1:SCED2)
 N V1,ZNODE,DIC,DIE,DR,DA,SCARRAY
 S DIE="^SCTM(404.53,"
 S DR=".02///"_SCED1_";.04///0;.05///CHANGE PRECEPTOR LINK;.08///NOW;.07///"_DUZ
 ;Loop thru "FROM" preceptor for current preceptees and inactivate them
 S V1=0 F  S V1=$O(^SCTM(404.53,"D",SCPIEN1,V1)) Q:'V1  D
 .S ZNODE=$G(^SCTM(404.53,V1,0)) Q:ZNODE=""
 .I '$P(ZNODE,"^",4) Q  ;INACTIVE
 .S SCARRAY($P(ZNODE,U))=""
 .S DA=V1
 .D ^DIE
 ;Create new assignments for the "TO" preceptor
 S DIC="^SCTM(404.53,"
 S DIC(0)="Z"
 S DIC("DR")=".02///"_SCED2_";.04///1;.05///ACTIVATE PRECEPTOR LINK;.06///"_SCPIEN2_";.08///NOW;.07///"_DUZ
 S V1=0 F  S V1=$O(SCARRAY(V1)) Q:'V1  D
 .K D0
 .S X=V1
 .D FILE^DICN
 S SCRESULT(0)=1
 Q 1
