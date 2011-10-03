SCMCTSK7 ;ALB/JDS - PCMM FTEE REPORT ; 8/23/05 11:46am
 ;;5.3;Scheduling;**297**;AUG 13, 1993
 Q
DIOEND ;End of FTEE report
 N XX
 W @IOF
 W !!!,"REPORT KEY",!!
 F I=1:1 S A=$P($T(TIOEND+I),";;",2) Q:'$L(A)  W !,A I $Y>(IOSL-4) I $G(IOST)["C-" R XX:DTIME W @IOF
 Q
TIOEND ;
 ;;Column Heading             Explanation of column heading
 ;; 
 ;;Providers Name             The name of the primary care Provider
 ;;Institution                Institution name, previously called Division, where patient receives primary care
 ;;PC TEAM                    The name of the primary care team to which this position (and therefore provider) is assigned.
 ;;Provider's Team Position   The name of the Primary care team position to which this provider's assigned
 ;;AP or PCP                  This column displays whether this provider is an Associate Primary Care Provider
 ;;                           (AP) or a Primary Care Provider (PCP)
 ;;Associated Clinic(s)     The scheduling clinic(s) associated with this position/provider in the PCMM software
 ;;Direct PC FTEE             The number of hours the provider spends providing direct primary care expressed as a Full-Time Employee
 ;;                           Equivalent Examples: One FTEE=1.00=40 hours per week. 0.75 FTEE=30 hours per week. 0.50 FTEE=20 hours
 ;;                           per week. Percent FTEE is equal to 100 x the FTEE number on this report. For example FTEE=0.75= 75%
 ;;Patients for Position      This represents the total maximum number of patients this provider is expected to care for on this panel
 ;;              Allowed      This number is entered in the PCMM GUI 'Primary Care Team Position Setup' window on the 'Settings' tab
 ;;                           Additional patients above this number may be assigned to the provider depending on local management policy
 ;;Patients for Position      The actual current number of active patients assigned to this provider in PCMM at the time of this report
 ;;                Actual     This number displays on the PCMM GUI 'Primary Care Team Position Setup' window on the 'Settings' tab
 ;;Available Patient Openings The difference in the number of patients allowed and the actual number of patients currently assigned
 ;;                           If this is a positive number, additional patient assignments may be made
 ;;                           If this is a negative number (in parentheses,) the maximum number of patient assignments exceeds what is
 ;;                           indicated in PCMM. Local management decides whether to assign patients over the maximum number.
 ;;Adjusted Panel Size        The Adjusted Panel Size column is the result of the Active Patients column divided by the FTEE (when not 
 ;;                           0) and is an attempt to standardize the panel size so comparisons can be made for providers that have
 ;;                           different FTEE values.  Example, Active patients 500/0.85 FTEE=588. This is the number of patients this
 ;;                           provider would be expected to provide primary care for if their FTEE=1.0
 ;;FTEE and Panel Size Total  The total number of FTEE, patients for positions allowed, patients for positions actual, and available 
 ;;                           patient opening for this report. If this report is sorted on Associated Clinic, then subtotals for each 
 ;;                           clinic and a total for the entire report print. If this report is sorted on PC Team, then subtotals for
 ;;                           each team and a total for the entire report print
 Q
SETASC(RESULT,DATA) ;set associated clinics        
 N ENTRY,OLD S ENTRY=+$G(DATA(0))
 I ENTRY I '$D(^SCTM(404.57,+ENTRY,5,0)) S ^(0)="^404.575PA^^"
 F I=0:0 S I=$O(^SCTM(404.57,+ENTRY,5,I)) Q:'I  S OLD(I)=""
 F I=1:1 Q:'$D(DATA(I))  S A=$P(DATA(I),U,2) K OLD(+A) I '$D(^SCTM(404.57,+ENTRY,5,+A)) D
 .S DIC(0)="LM",DIC="^SCTM(404.57,"_ENTRY_",5,",X=(+A),DA(1)=ENTRY K OLD(+A) D ^DICN
 ;get rid of deleted
 F I=0:0 S I=$O(OLD(I)) Q:'I  S DIK="^SCTM(404.57,"_ENTRY_",5,",DA(1)=ENTRY,DA=I D ^DIK
 Q
DIS2 ;continue inactivation stuff
 ;  Existing varibles
 ;   ZERO  =  zero node of 404.43
 ;   ENTRY =  ien in 404.43
 ;  Newed at this line lable
 ;   DA    =  iens in 404.43 and 404.42
 ;   DIE   =  file numbers 404.43 and 404.42
 ;   DR    =  dr edit strings
 ;   SCV1  =  patient dfn
 ;   SCV2  =  is there team data 1 or 0
 ;   SCV3  =  team ien
 ;   SCV4  =  looper
 N DA,DIE,DR,SCV1,SCV2,SCV3,SCV4
 ;original code has next line commented
 ;I $P(ZERO,U,16)=1 Q
 ;next inactivate the patient team position assignment
 S DA=ENTRY,DIE="^SCPT(404.43,",DR=".04////"_DT_";.12////NA;.15///@;.13///@"
 D ^DIE K DIE
 ;check toggle for automatic team inactivations - site level
 ;if not 1 do not inactivate from team automatically (all teams)
 I $P($G(^SCTM(404.44,1,1)),U,10)'=1 Q
 S DA=$P(ZERO,U) Q:'DA
 ;check toggle for automatic team inactivations - team level
 ;if not 1 do not inactivate from team automaticaly (this team only)
 I $P($G(^SCPT(404.42,DA,0)),U,16)=1 Q
 S DIE="^SCPT(404.42,",DR=".09////"_DT_";.15////IU" D ^DIE K DIE
 S SCV1=$P($G(^SCPT(404.42,+$P(ZERO,U),0)),U) Q:SCV1=""
 ;make a call to GETALL^SCAPMCA(DFN)
 ;team info returned at ^TMP("SC",$J,DFN,"TM",IEN 404.51,IEN 404.42,"POS",IEN 404.43)    
 S SCV2=$$GETALL^SCAPMCA(SCV1) Q:'1
 S SCV3=$P($G(^SCTM(404.57,+$P(ZERO,U,2),0)),U,2) Q:SCV3=""
 ;loop thru and inactivate all positions associated with this patient on this team
 S SCV4=0 F  S SCV4=$O(^TMP("SC",$J,SCV1,"TM",SCV3,"POS",SCV4)) Q:'SCV4  D
 . S DA=SCV4
 . ;check for previous unassignment and quit if one exsists
 . I $P($G(^SCPT(404.43,SCV4,0)),U,4) Q
 . S DIE=404.43
 . S DR=".04////"_DT_";.12////NA;.15///@;.13///@"
 . D ^DIE K DIE
 K ^TMP("SC",$J,SCV1)
 Q
