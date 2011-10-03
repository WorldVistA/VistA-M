SDWLRP1 ;;IOFO BAY PINES/TEH - WAITING LIST - RPC;06/28/2002 ; 26 Aug 2002  1:25 PM  ; Compiled April 16, 2007 10:15:05
 ;;5.3;scheduling;**263,273,485,497,446**;AUG 13 1993;Build 77
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   2/21/03                     SD*5.3*273              Line new+12 added "/"
 ;   5/10/06                     SD*5.3*446              New field: INTRA-transfer
OUTPUT(SDWLOUT,SDWLDFN) ;-FULL
 ; input:
 ;   DFN = Patient
 ;     Lookup uses Wait List data file (409.3) and returns the following data.
 ;     
 ; output:
 ;   SCOUT = location of data = ^TMP("SDWLG",$J,i,0)
 ;   for i=1:number of records returned: 
 ;
 ;         Field  Location               Description
 ;               1               2                       ORIGINATION DATE
 ;               2               3                       INSTITUTION
 ;               3               4                       CLINIC
 ;               4               5                       WAIT LIST TYPE
 ;               5               6                       SPECIFIC TEAM
 ;               5.1             22                      MARKED OPEN (SPECIFIC TEAM)
 ;               6               7                       SPECIFIC POSITION
 ;               6.1             23                      MARKED OPEN (SPEICIFIC POSITION)
 ;               7               8                       SERVICE /SPECIALTY
 ;               8               9                       SPECIFIC CLINIC
 ;               9               10                      ORIGINATING USER
 ;               10              11                      PRIORITY
 ;               11              12                      REQUESTED BY
 ;               12              13                      PROVIDER
 ;               22              16                      DESIRED DATE OF APPT
 ;               23              17                      CURRENT STATUS
 ;               25              18                      COMMENTS
 ;               27              20                      NEW ENROLLE
 ;
 N DIERR,SDWLDAX
 I '$D(^SDWL(409.3,"B",SDWLDFN)) S SDWLRES=-1 Q  ;- No Entry in Wait List file.
 S SDWLDA="" F  S SDWLDA=$O(^SDWL(409.3,"B",SDWLDFN,SDWLDA)) Q:SDWLDA<1  D
 .S SDWLDAX="`"_SDWLDA
 .D FIND^DIC(409.3,,".01;1;2;3;4;5;5.1;6;6.1;7;8;9;10;11;12;15;22;23;25","PS",.SDWLDAX)
 I $G(DIERR) D CLEAN^DILF S SDWLRES=-1 Q
 K SDWLOUT S SDWLOUT=$NA(^TMP("DILIST",$J))
 Q
OUTPUT1(SDWLOUT,SDWLDFN) ;
 ;Brief Output - for Wait List.
 ; input:
 ;   DFN = Patient
 ;     Lookup uses Wait List data file (409.3) and returns the following data.
 ;
 ; output:
 ;   SWDLRES = On/Not on Wait list^Number of IENs^IEN;IEN;IEN;IEN.....
 ;            1     0            ^      2       ^1;2
 ;
 S SDWLCNT=0,SDWLIEN=""
 I '$D(^SDWL(409.3,"B",SDWLDFN)) S SDWLRES=$NA(^TMP("SDWLRP1",$J)),^TMP("SDWLRP1",$J,1)=-1
 S SDWLDA=""  F  S SDWLDA=$O(^SDWL(409.3,"B",SDWLDFN,SDWLDA)) Q:SDWLDA<1  D
 .I $P(^SDWL(409.3,SDWLDA,0),U,17)["C" Q
 .S SDWLCNT=SDWLCNT+1
 .S ^TMP("SDWLRP1",$J,SDWLCNT)=SDWLDA_"^"_$G(^SDWL(409.3,SDWLDA,0))
 S SDWLOUT=$NA(^TMP("SDWLRP1",$J))
 K SDWLDFN,SDWLDA,SDWLCNT,SDWLIEN
 Q
OUTPUT3(SDWLOUT,SDWLDFN) ;Disposition Data
 ;  input:
 ;    DFN = Patient Internal ID
 ;    
 ;  output: Subscript 'DIS'
 ;    Date Dsipositioned^Disposition by^Disposition  
 ;
 N SDWLRES,SDWLDFN,SDWLDA,DIERR
 I '$D(^SDWL(409.3,"B",SDWLDFN)) S SDWLRES=-1 Q  ;- No Entry in Wait List file.
 S SDWLDA="" F  S SDWLDA=$O(^SDWL(409.3,"B",SDWLDFN,SDWLDA)) Q:SDWLDA<1  D
 .S SDWLDAX="`"_SDWLDA
 .D FIND^DIC(409.3,,"19;20;21","PS",.SDWLDAX)
 I $G(DIERR) D CLEAN^DILF S SDWLRES=-1 Q
 K SDWLOUT S SDWLOUT="^TMP(""DILIST"","_$J_")",SDWLRES=1
 Q
INPUT(SDWLRES,SDWLSTR) ;
 ; Input:
 ;   SDWLSTR = location of data = ^TMP("SDWLG",$J,i,0)
 ;   (R) = Required Field
 ;   (O) = Optional
 ;   
 ;    .01    2           3                     5                  6                    
 ;  DFN (R)^TYPE (R)^SPECIFIC TEAM (O)^SPECIFIC POSITION (O)^ORGINATING USER (R)^COMMENT (O)^CLINIC (O)^INTRA FLAG (O)^REJ FLAG (O)^MULTI TEAM FLAG (O)
 ;     1     2           3                     4                  5                6            7           8               9             10
 ;
 ;  Output:
 ;               SDWLRES  =  0      Failed
 ;               SDWLRES  =  1^IEN  Saved to ^SDWL(409.3,IEN,0)            
 ;
 N DIERR,%H,SDWLF,SDWLFLD,SDWLFLG,SDWLI,SDWLIN,SDWLMSG,SDWLRNED,SDWLTP,SDWLVAL,SDWLX,SDWLY,X,Y
 K ^TMP("SDWLIN",$J),^TMP("SDWLOUT",$J),^TMP("DIERR",$J)
 I '$G(SDWLSTR) S SDWLRES="-1^Data String Missing" Q
 D NEW
 D FDA I SDWLRES<0 D DEL Q
 ;D VAL I SDWLRES<0 D DEL Q
 D SET I SDWLRES<0 D DEL Q
 D CLEAN^DILF K ^TMP("SDWLIN",$J),^TMP("SDWLOUT",$J)
 K SDWLDUZ,SDWLDFN,SDWLDA,Y
 Q
NEW ;Get IEN from ^SDWL(409.3,IEN,0).
 N DA,DIC,DIE,DIK,DR,SDREJ,SDINTRA,SDMULTI
 I $P(SDWLSTR,U,4) D
 .S SDWLTP=+$P(SDWLSTR,U,4)
 .S SDWLIN=$P($G(^SCTM(404.51,+$P(^SCTM(404.57,SDWLTP,0),U,2),0)),U,7)
 I $P(SDWLSTR,U,3) D
 .S SDWLIN=$P($G(^SCTM(404.51,+$P(SDWLSTR,U,3),0)),U,7)
 S SDWLDFN=+$P(SDWLSTR,U,1)
 S SDREJ=$P(SDWLSTR,U,9),SDINTRA=$P(SDWLSTR,U,8),SDMULTI=$P(SDWLSTR,U,10)
 ;identify INTRA-transfer
 ;- last team assignment
 S DIC(0)="LX",X=$P(SDWLSTR,U,1),DIC="^SDWL(409.3," D FILE^DICN I Y<0 S SDWLRES="-1^IEN failed" Q
 S SDWLDFN=$P(Y,U,2),SDWLDA=+Y,SDWLDUZ=$P(SDWLSTR,U,9)
 S DIE="^SDWL(409.3,",DA=SDWLDA
 S DR="1///^S X=DT" D ^DIE
 S DR="2////^S X=SDWLIN;32////^S X=SDREJ;34////^S X=SDINTRA;38////^S X=SDMULTI" D ^DIE
 S DR="23///^S X=""O""",DIE="^SDWL(409.3," D ^DIE
 ;
 ;DETERMINE ENROLLEE STATUS
 ;
 ;SDWLE=1 = NEW ENROLLEE
 ;SDWLE=2 = ESTABLISHED
 ;SDWLE=3 = PRIOR ENROLLEE
 ;SDWLE=4 = UNDETERMINED
 ;
 S SDWLDE=+$H,SDWLE=0,(SDWLEE,SDWLRNED,SDWLDB)=0 D SB1
 G SB0:SDWLE=2
 S SDWLRNE=$$ENROLL^EASWTAPI(SDWLDFN) G SB0:$P(SDWLRNE,U,4)="A" S SDWLRNED=$P(SDWLRNE,U,3)
 I SDWLRNED S X=SDWLRNED D H^%DTC S SDWLDS=%H S SDWLDE=+$H,SDWLDET=SDWLDE-SDWLDS,SDWLDB=2 I SDWLDET<366 S SDWLE=1
 I $D(SDWLDET),SDWLDET>365 S SDWLE=3
 I 'SDWLRNE S SDWLE=4
SB0 I $D(SDWLRNE),$P(SDWLRNE,U,4)="A" D
 .I 'SDWLRNE,SDWLEE>730!(SDWLEE=730) S SDWLE=4 Q
 .I 'SDWLEE S SDWLE=4 Q
 S SDWLRNE=$S(SDWLE=1:"N",SDWLE=2:"E",SDWLE=3:"P",SDWLE=4:"U",1:"U")
 ;-Code here for filling in 409.3
 S DR="27////^S X=SDWLRNE",DIE="^SDWL(409.3,",DA=SDWLDA D ^DIE
 S DR="9////^S X=DUZ" D ^DIE
 S DR="27.1////^S X=$S($G(SDWLRNED):SDWLRNED,$G(SDWLD):SDWLD,1:"""")" D ^DIE
 S DR="27.2////^S X=SDWLDB" D ^DIE
 K SDWLRNE,SDWLD,SDWLDE,SDWLEE,SDWLDET,DIC,DIR,DR,DIE,SDWLDS,SDWLE
 Q
SB1 I '$D(^DGCN(391.91,"B",SDWLDFN)) N SDWLDB S SDWLE=3 Q
 S SDWLX="" F  S SDWLX=$O(^DGCN(391.91,"B",SDWLDFN,SDWLX)) Q:SDWLX=""  D
 .S SDWLY=$G(^DGCN(391.91,SDWLX,0)) D
 ..;CHECK FOR TREATING FACILITY
 ..I $$TF^XUAF4(+$P(SDWLY,U,2)) D
 ...;SORT FOR LAST TREATMENT DATE
 ...S SDWLD=$P(SDWLY,U,3) I SDWLD S SDWLDTF(9999999-SDWLD)=SDWLX
 I '$D(SDWLDTF) Q
 S SDWLDTF=$O(SDWLDTF(0)) I SDWLDTF S (SDWLD,X)=9999999-SDWLDTF D H^%DTC S SDWLEE=SDWLDE-%H,SDWLDB=1 I SDWLEE<730 S SDWLE=2
 I $D(SDWLEE),SDWLEE>730!(SDWLEE=730) S SDWLE=3
 K SDWLDTF
 Q
FDA ;Get data from SDWLSTR string and set FDA.
 S SDWLF=409.3
 S SDWLVAL="" F SDWLI=2:1:7 S SDWLVAL=$P(SDWLSTR,"^",SDWLI) D
 .S SDWLFLD=SDWLI D
 ..S SDWLFLD=$S(SDWLFLD=2:4,SDWLFLD=3:5,SDWLFLD=4:6,SDWLFLD=5:9,SDWLFLD=7:15,1:25)
 .S SDWLFLG="F",SDWLIEN=$$IENS^DILF(SDWLDA) ;,SDWLVAL=$$EXTERNAL^DILFD(SDWLF,SDWLFLD,,SDWLVAL,"SDWLMSG")
 .I $D(SDWLMSG) M SDWLRES=SDWLMSG S SDWLRES=-1 Q
 .D FDA^DILF(SDWLF,SDWLIEN,SDWLFLD,"",SDWLVAL,"^TMP(""SDWLIN"",$J)")
 .S SDWLRES=1 M SDWLRES("SDWLIN")=^TMP("SDWLIN",$J)
 Q
VAL ;Validate fields
 N DIERR
 D VALS^DIE(,"^TMP(""SDWLIN"",$J)","^TMP(""SDWLOUT"",$J)","SDWLMSG")
 I $G(SDWLMSG("DIERR")) S SDWLRES=-1 Q
 M SDWLRES("SDWLOUT")=^TMP("SDWLOUT",$J)
 Q
SET ;Input data to file ^SDWL(409.3,IEN,0).
 D UPDATE^DIE(,"^TMP(""SDWLIN"",$J)","SDWLMSG")
 I $G(SDWLMSG("DIERR")) S SDWLRES=-1 Q
 S SDWLRES=1_"^"_$G(SDWLDA)
 Q
DEL S DA=SDWLDA,DIK="^SDWL(409.3," D ^DIK
 S SDWLRES="-1^Entry "_SDWLDA_" Deleted"
 Q
INPUTDP(SDWLRES,SDWLSTR) ;Set disposition in Wait List Patient file
 ;
 ;       Input:
 ;       
 ;               SDWLSTR=Patient DFN^Disposition^User DUZ^Wait List IEN
 ;               
 ;       Ouput:
 ;       
 ;           SDWLRES=-1 Failed
 ;           SDWKRES=1^IEN for Wait List File (409.3)
 ;
 N SDWLDFN,SDWLDISP,SDWLDUZ,SDWLDA,SDWLDDT
 I '$G(SDWLSTR) S SDWLRES="-1^Data String Missing" Q
 I '$G(^SDWL(409.3,SDWLDA,0)) S SDWLRES="-1^Missing Patient IEN" Q
 I '$D(^SDWL(409.3,"B",SDWLDFN)) S SDWLRES="-1^Missing Wait List data file" Q
 D FDA1 I SDWLRES<0 D DEL1 Q
 D VAL1 I SDWLRES<0 D DEL1 Q
 D SET1 I SDWLRES<0 D DEL1 Q
 D CLEAN^DILF K ^TMP("SDWLIN",$J),^TMP("SDWLOUT",$J)
 Q
FDA1 ;
 S SDWLDFN=$P(SDWLSTR,U,1),SDWLDISP=$P(SDWLSTR,U,2),SDWLDUZ=$P(SDWLSTR,U,3),SDWLDA=$P(SDWLSTR,U,4),SDWLDDT=DT
 S SDWLIEN=$$IENS^DILF(SDWLDA)
 F SDWLI=1:1:4 S SDWLVAL=$S(SDWLI=1:SDWLDISP,SDWLI=2:SDWLDUZ,SDWLI=3:SDWLDDT,SDWLI=4:"C"),SDWLFLD=$S(SDWLI=1:21,SDWLI=2:20,SDWLI=3:19,SDWLI=4:23) D
 .S SDWLVAL=$$EXTERNAL^DILFD(SDWLF,SDWLFLD,,SDWLVAL,"SDWLMSG")
 .I $D(SDWLMSG) M SDWLRES=SDWLMSG S SDWLRES=-1 Q
 .D FDA^DILF(SDWLF,SDWLIEN,SDWLFLD,"",SDWLVAL,"^TMP(""SDWLIN"",$J)")
 .S SDWLRES=1 M SDWLRES("SDWLIN")=^TMP("SDWLIN",$J)
 Q
VAL1 ;
 N DIERR
 D VALS^DIE(,"^TMP(""SDWLIN"",$J)","^TMP(""SDWLOUT"",$J)","SDWLMSG")
 I $G(SDWLMSG("DIERR")) S SDWLRES=-1 Q
 M SDWLRES("SDWLOUT")=^TMP("SDWLOUT",$J)
 Q
SET1 ;
 D UPDATE^DIE(,"^TMP(""SDWLOUT"",$J)","SDWLMSG")
 I $G(SDWLMSG("DIERR")) S SDWLRES=-1 Q
 S SDWLRES=1
 Q
DEL1 ;
 S DA(1)=SDWLDA,DIK="^SDWL("_DA(1)_",""DIS""," F DA=19,20,21,23 D ^DIK
 S SDWLRES="-1^"_"Disposition Nodes Deleted."
 Q
