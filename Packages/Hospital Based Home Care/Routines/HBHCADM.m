HBHCADM ;LR VAMC(IRMS)/MJT - HBHC eval/admit data entry; Apr 29, 2021@07:55
 ;;1.0;HOSPITAL BASED HOME CARE;**2,6,8,16,24,25,32**;NOV 01, 1993;Build 58
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to ^DG(40.8 supported by ICR #7024
 ;
 ;This routine appears to have locking flaws in that there is no allowance for
 ;locking failure. Any flaws will be researched and addressed in a future patch.
 ;HBH*1.0*32 is following the pattern of how HBHCADM currently locks records.
 ;
START ; Initialization
 ;Sites must have at least one parent site defined.
 I $O(^HBHC(631.9,1,1,"B",""))="" D  Q
 . W !!,"No parent sites are defined at this facility."
 . W !,"Contact your HBPC Program Manager to define at least one"
 . W !,"parent site in option ""System Parameters Edit"".",!
 . N DIR
 . S DIR("A")="Press any key to continue",DIR(0)="FO"
 . D ^DIR
 S HBHCFORM=3
 ;Variable HBHCMFHS is set if this site is a
 ;sanctioned Medical Foster Home site.
 D MFHS^HBHCUTL3
PROMPT ; Prompt user for patient name
 N HBHCHOSP
 S HBHCHOSP=$P(^HBHC(631.9,1,0),U,5)
 K DIC,HBHCFLG,HBHCPRCT S DIC="^HBHC(631,",DIC(0)="AELMQZ" D ^DIC
 G:Y=-1 EXIT
 S HBHCDFN=+Y,HBHCDPT=$P(Y,U,2),HBHCDPT0=^DPT(HBHCDPT,0),HBHCNOD0=Y(0)
 I $P(HBHCDPT0,U,9)'?9N W !!,"Patient has 'pseudo' social security number (SSN) on file.  If patient was",!,"not chosen in error, contact MAS to correct the invalid SSN.  Patient must",!,"have a valid SSN to be selected.",! H 3 G PROMPT
 S HBHCXMT3=$P($G(^HBHC(631,HBHCDFN,1)),U,17)
 I $P(^HBHC(631,HBHCDFN,0),U,40)]"" W $C(7),!!!,"***  Record contains Discharge data indicating a Complete Episode of Care  ***",!! H 3
 I (HBHCXMT3]"")&(HBHCXMT3'="N") D FORMMSG^HBHCUTL1 G:$D(HBHCNHSP) EXIT G:HBHCPRCT'=1 PROMPT
 I $P(Y,U,3) S $P(^HBHC(631,HBHCDFN,1),U,17)="N",^HBHC(631,"AE","N",HBHCDFN)="" S HBHCBXRF="" F  S HBHCBXRF=$O(^HBHC(631,"B",HBHCDPT,HBHCBXRF)) Q:(HBHCBXRF="")!(HBHCBXRF=HBHCDFN)  D CHECK
 G:$D(HBHCFLG) PROMPT
 ;
MFH ;HBH*1.0*32: first determine if an MFH patient
 ;Variable HBHCFMHS = does this site have Medical Foster Homes
 I $D(HBHCMFHS) D
 . N DIE,DA,DR,HBHCSAVY,HBHCMFHSTR,HBHCMFHX
 . ;preserving "Y" since will be killed downstream
 . M HBHCSAVY=Y
 . S DIE="^HBHC(631,",DA=HBHCDFN
 . S DR(2,631.01)=1,DR="K HBHCQ;88;S:X'=""Y"" Y=""@1"";89;90;@1;"
 . L +^HBHC(631,HBHCDFN):0 I $T D ^DIE
 . M Y=HBHCSAVY
 ;
MFHNO ;Either the site does not have medical foster homes,
 ;or this patient is not in a medical foster home.
 ;In that case, the Parent Site prompt is presented.
 I $P($G(^HBHC(631,HBHCDFN,3)),"^")'="Y" D
 . ;This section called only if patient is not an MFH patient.
 . ;HBH*1.0*32: add PARENT SITE (#91) field
 . ;set a default if there is only one parent site defined
 . ;at this site
 . N HBHCPARN,HBHCSAVY
 . ;saving original value of Y since used further down by pre-HBH*1.0*32 code
 . M HBHCSAVY=Y
 . S HBHCPARN=$S($P(^HBHC(631.9,1,1,0),"^",4)=1:$O(^HBHC(631.9,1,1,"B","")),1:"")
 . I HBHCPARN]"" S HBHCPARN=$P(^DG(40.8,HBHCPARN,0),"^")
 . S DR="91//^S X=HBHCPARN"
 . S DIE="^HBHC(631,",DA=HBHCDFN
 . L +^HBHC(631,HBHCDFN):0 I $T D ^DIE L -^HBHC(631,HBHCDFN)
 . M Y=HBHCSAVY
 . ;end of HBH*1.0*32
CONT ;end of MFH logic - continue with prompts, etc.
 ;Parent site is required if not a MFH patient.
 ;Parent site is not required for MFH patients since the MFH's parent site
 ;is retrieved for AITC transmissions.
 N HBHCQUIT
 S HBHCQUIT=1
 ;Is parent site defined - if yes, may continue with prompts.
 I $P($G(^HBHC(631,HBHCDFN,5)),"^")]"" S HBHCQUIT=0
 ;If no parent site and this is an MFH site, the patient needs to be defined
 ;as an MFH patient if there is no parent site in ^HBHC(631,HBHCDFN,5).
 I HBHCQUIT,$D(HBHCMFHS),$P($G(^HBHC(631,HBHCDFN,3)),"^")="Y" S HBHCQUIT=0
 Q:HBHCQUIT
 D DEMO
 K DIE S DIE="^HBHC(631,",DA=HBHCDFN,DIE("NO^")="OUTOK"
 ;added M code for Dx validation based on admission date
 ;added M code for Dx lookup instead of field 18
 S DR="K HBHCQ;17;2:5;D BIRTHYR^HBHCUTL1;7;D SEXRACE^HBHCUTL1;10:13;14;D ACTION^HBHCUTL;15;16"
 L +^HBHC(631,HBHCDFN):0 I $T D ^DIE
 I $D(Y)>0 G PROMPT
 ; For ICD-9 lookups, set key variables used by special lookup routine
 S ICDVDT=$P(^HBHC(631,DA,0),U,18)
 S ICDSYS=+$$SINFO^ICDEX("DIAG",ICDVDT)
 I ICDSYS=1 S ICDFMT=1
 I '$D(HBHCMFHS) D
 .S DR=$S(ICDSYS=1:"I $D(HBHCQ) K HBHCQ S Y=37;18;68;19:36;37:38;67",1:"I $D(HBHCQ) K HBHCQ S Y=37;D ADMDX^HBHCLKU1;68;19:36;37:38;67")
 I $D(HBHCMFHS) D
 .S DR=$S(ICDSYS=1:"I $D(HBHCQ) K HBHCQ S Y=37;18;68;19:36;37:38;67",1:"I $D(HBHCQ) K HBHCQ S Y=37;D ADMDX^HBHCLKU1;68;19:36;37:38;67")
 D ^DIE
 L -^HBHC(631,HBHCDFN) K ICDVDT,ICDSYS,ICDFMT G PROMPT
 W $C(7),!!,"Another user is editing this entry.",!! G PROMPT
EXIT ; Exit module
 K DA,DIC,DIE,DIK,DR,HBHCAFLG,HBHCBXRF,HBHCCNTY,HBHCDFN,HBHCDPT,HBHCDPT0,HBHCEL,HBHCELGE,HBHCFLG,HBHCFORM,HBHCI,HBHCIEN,HBHCINFO,HBHCJ,HBHCMARE,HBHCMFHS,HBHCMS,HBHCNHSP,HBHCNOD0,HBHCPRCT,HBHCPS,HBHCPSRV,HBHCQ,HBHCRFLG,HBHCST
 K HBHCXMT3,HBHCWRD1,HBHCWRD2,HBHCWRD3,HBHCY0,HBHCZIP,VAEL,X,Y
 Q
CHECK ; Check previous episode(s) of care for 'Reject' in Admit/Reject Action or Discharge Date to ensure completed episode of care before allowing another episode of care to be created
 Q:($P(^HBHC(631,HBHCBXRF,0),U,15)=2)!($P(^HBHC(631,HBHCBXRF,0),U,40)]"")
 W $C(7),!!,"Patient must be discharged from last episode of care before new episode",!,"can be entered.  Current episode not created.",! H 3
 K DIK S DIK="^HBHC(631,",DA=HBHCDFN D ^DIK
 S HBHCFLG=1
 Q
DEMO ; Obtain patient demographic info
 S (HBHCST,HBHCCNTY,HBHCZIP,HBHCEL,HBHCELGE,HBHCPS,HBHCPSRV,HBHCMS,HBHCMARE)=""
 I $D(^DPT(HBHCDPT,.11)) S HBHCINFO=^DPT(HBHCDPT,.11),HBHCCNTY=$P(HBHCINFO,U,7),HBHCZIP=$P(HBHCINFO,U,12),HBHCST=$P(HBHCINFO,U,5) I HBHCST]"" S HBHCIEN="" F  S HBHCIEN=$O(^HBHC(631.8,"B",HBHCST,HBHCIEN)) Q:HBHCIEN=""  S HBHCST=HBHCIEN
 I $D(^DPT(HBHCDPT,.36)) S DFN=HBHCDPT D ELIG^VADPT S HBHCEL=+VAEL(1),HBHCELGE=$S(HBHCEL=1:"01",HBHCEL=2:"02",HBHCEL=16:"02",HBHCEL=11:"03",HBHCEL=4:"04",1:"05") K DFN
 I $D(^DPT(HBHCDPT,.32)) S HBHCINFO=^DPT(HBHCDPT,.32),HBHCPS=$P(HBHCINFO,U,3),HBHCPSRV=$S(((HBHCPS>0)&(HBHCPS<9)):HBHCPS,HBHCPS=9:10,HBHCPS=121:11,1:"")
 S HBHCINFO=^DPT(HBHCDPT,0),HBHCMS=$P(HBHCINFO,U,5),HBHCMARE=$S(HBHCMS=1:4,HBHCMS=2:1,HBHCMS=4:2,HBHCMS=5:3,HBHCMS=6:5,1:"")
 I HBHCST]"" S:($P(HBHCNOD0,U,3)="")&($D(^HBHC(631.8,HBHCST,0))) $P(^HBHC(631,HBHCDFN,0),U,3)=HBHCST I (HBHCCNTY]"")&($P(HBHCNOD0,U,4)="") S:$D(^HBHC(631.8,HBHCST,0)) $P(^HBHC(631,HBHCDFN,0),U,4)=HBHCCNTY
 S:(HBHCZIP]"")&(($P(HBHCNOD0,U,5)="")!($P(HBHCNOD0,U,5)'?9N)) $P(^HBHC(631,HBHCDFN,0),U,5)=HBHCZIP
 S:(HBHCELGE]"")&($P(HBHCNOD0,U,6)="") $P(^HBHC(631,HBHCDFN,0),U,6)=HBHCELGE
 S:(HBHCPSRV]"")&($P(HBHCNOD0,U,8)="") $P(^HBHC(631,HBHCDFN,0),U,8)=HBHCPSRV
 S:(HBHCMARE]"")&($P(HBHCNOD0,U,11)="") $P(^HBHC(631,HBHCDFN,0),U,11)=HBHCMARE
 Q
