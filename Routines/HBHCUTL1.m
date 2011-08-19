HBHCUTL1 ; LR VAMC(IRMS)/MJT-HBHC Utility module, Entry points:  ENDRPT, END132, FORMMSG, BIRTHYR, SEXRACE, HOSP ;2/5/98  15:19
 ;;1.0;HOSPITAL BASED HOME CARE;**1,2,6,9,19,24**;NOV 01, 1993;Build 201
ENDRPT ; Print end of report message
 W !!?28,"==== End of Report ===="
 Q
END132 ; Print end of report message for 132 column report
 W !!?54,"==== End of Report ===="
 Q
FORMMSG ; Process Form 3/4/5/7 Transmit Status fields
 W $C(7),!!,"Transmit Status Flag must be reset before editing this record is allowed."
 I $P(^HBHC(631.9,1,0),U,5)="" W !!,"***  NOTICE:  Hospital Number is missing from System Parameter file (#631.9).",!,"Due to automatic Form 6 Correction Record generation, Transmit Status Flag"
 I $P(^HBHC(631.9,1,0),U,5)="" W !,"CANNOT be reset without this information.  Contact IRM to enter this",!,"information using FileMan.",! S HBHCNHSP=1 H 10 Q
 W !!,"Do you wish to reset the Flag" S %=2 D YN^DICN W ! I %=0 W !,"A 'Yes' response will reset the Transmit Status Flag field data.  A 'No'",!,"response will return you to the menu without resetting the Transmit",!,"Status Flag.",!! G FORMMSG
 S HBHCPRCT=%
 I %'=1 S:(HBHCFORM=4)!(HBHCFORM=7) Y=0 Q
 S HBHCFILE=$S(HBHCFORM=7:633.2,HBHCFORM=4:632,1:631),HBHCNODE=$S(HBHCFORM=7:12,HBHCFORM=4:0,1:1),HBHCPC1=$S(HBHCFORM=3:17,HBHCFORM=7:1,HBHCFORM=4:8,1:18),HBHCPC2=$S(HBHCFORM=3:25,HBHCFORM=7:5,HBHCFORM=4:12,1:27)
 L +^HBHC(HBHCFILE,HBHCDFN,HBHCNODE):$S($D(DILOCKTM):DILOCKTM,1:3) I '$T W !,"***  Record locked by another user.  Please try again later.  ***",!  H 3 Q
 S HBHCPC3=$S(HBHCFORM=3:26,HBHCFORM=7:6,HBHCFORM=4:13,1:28),HBHCXREF=$S(HBHCFORM=3:"AE",HBHCFORM=7:"AC",HBHCFORM=4:"AC",1:"AF")
 S HBHCSTAT=$S(HBHCFORM=3:$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,17),HBHCFORM=5:$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,18),HBHCFORM=7:$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U),1:$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,8))
 D NOW^%DTC S HBHCNOW=$E(%,1,12)
 K:HBHCSTAT]"" ^HBHC(HBHCFILE,HBHCXREF,HBHCSTAT,HBHCDFN)
 S $P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,HBHCPC1)="N",^HBHC(HBHCFILE,HBHCXREF,"N",HBHCDFN)="",$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,HBHCPC2)=HBHCNOW,$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,HBHCPC3)=DUZ
 I (HBHCFORM=3)&($P(^HBHC(HBHCFILE,HBHCDFN,0),U,40)]"") S HBHC5XMT=$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,18) K:HBHC5XMT]"" ^HBHC(HBHCFILE,"AF",HBHC5XMT,HBHCDFN) S $P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,18)="N",^HBHC(HBHCFILE,"AF","N",HBHCDFN)=""
 I HBHCFORM=5 S HBHC3XMT=$P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,17) K:HBHC3XMT]"" ^HBHC(HBHCFILE,"AE",HBHC3XMT,HBHCDFN) S $P(^HBHC(HBHCFILE,HBHCDFN,HBHCNODE),U,17)="N",^HBHC(HBHCFILE,"AE","N",HBHCDFN)=""
 L -^HBHC(HBHCFILE,HBHCDFN,HBHCNODE)
 D:(HBHCFORM'=4)&(HBHCFORM'=7) SETNODE
EXIT ; Exit FORMMSG module
 K DILOCKTM,HBHCADDT,HBHCDPT0,HBHCDSDT,HBHCFILE,HBHCHOSP,HBHCINFO,HBHCLNTH,HBHCNAME,HBHCNDX1,HBHCNODE,HBHCNOW,HBHCPC1,HBHCPC2,HBHCPC3,HBHCREC,HBHCS136,HBHCSP4,HBHCSP8,HBHCSTAT,HBHCXREF,HBHC3XMT,HBHC5XMT
 Q
SETNODE ; Set node in ^HBHC(634.4) (Form 6 Corrections file)
 S $P(HBHCSP4," ",5)="",$P(HBHCSP8," ",9)="",$P(HBHCS136," ",137)="",HBHCLNTH=30
 L +^HBHC(634.4,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  S HBHCNDX1=$P(^HBHC(634.4,0),U,3)+1,$P(^HBHC(634.4,0),U,3)=HBHCNDX1,$P(^HBHC(634.4,0),U,4)=$P(^HBHC(634.4,0),U,4)+1 L -^HBHC(634.4,0)
 S HBHCINFO=^HBHC(HBHCFILE,HBHCDFN,0),HBHCDPT0=^DPT(HBHCDPT,0)
 S HBHCADDT=$S($P(HBHCINFO,U,18)]"":$E($P(HBHCINFO,U,18),4,5)_$E($P(HBHCINFO,U,18),6,7)_(1700+$E($P(HBHCINFO,U,18),1,3)),1:HBHCSP8)
 S HBHCDSDT=$S($P(HBHCINFO,U,40)]"":$E($P(HBHCINFO,U,40),4,5)_$E($P(HBHCINFO,U,40),6,7)_(1700+$E($P(HBHCINFO,U,40),1,3)),1:HBHCSP8)
 S HBHCNAME=$P(HBHCDPT0,U) S:$L(HBHCNAME)<HBHCLNTH HBHCNAME=HBHCNAME_$J("",HBHCLNTH-$L(HBHCNAME))
 D HOSP
 S HBHCREC=6_HBHCHOSP_$P(HBHCDPT0,U,9)_HBHCADDT_HBHCNAME_HBHCDSDT_2_HBHCS136
 S ^HBHC(634.4,HBHCNDX1,0)=HBHCREC,^HBHC(634.4,"B",$E(HBHCREC,1,30),HBHCNDX1)=""
 Q
BIRTHYR ; Birth year field display during Evaluation/Admission Data Entry
 S HBHCDPT0=^DPT(HBHCDPT,0)
 W !!,"BIRTH YEAR:  ",$S($P(HBHCDPT0,U,3):1700+$E($P(HBHCDPT0,U,3),1,3),1:"0000"),$C(7) D MASMSG
 Q
SEXRACE ; Sex & Race fields display during Evaluation/Admission Data Entry
 S HBHCDPT0=^DPT(HBHCDPT,0),HBHCSEX=$P(HBHCDPT0,U,2)
 W !!,"SEX:  ",$S(HBHCSEX="M":"Male  (1)",1:"Female  (2)"),$C(7) D MASMSG
 ; Obsolete with Race/Ethnicity Info Jan 2003 mandate; commented out historical reference  mjt
 ; ,HBHCRACE=$S($P(HBHCDPT0,U,6)]"":$P(^DIC(10,$P(HBHCDPT0,U,6),0),U,2),1:"")
 ;W !,"RACE:  ",$S(HBHCRACE=4:"Black  (2)",HBHCRACE=3:"American Indian/Alaskan Native  (4)",HBHCRACE=6:"White  (1)",(HBHCRACE=1)!(HBHCRACE=2):"Hispanic Origin  (3)",HBHCRACE=5:"Asian/Pacific Islander  (5)",1:"Not Determined  (9)")
 ; Field retained until VA Form 10-0014 modified to remove field  mjt
 W !,"RACE:  Obsolete Field  Jan 2003",!
 K HBHCDPT0,HBHCSEX
 Q
MASMSG ; MAS message for BIRTHYR & SEX modules
 W !?18,"***  Contact MAS if value is incorrect.  ***",!
 Q
HOSP ; Obtain Hospital Number from ^DIC(4 (Institution file); set HBHCHOSP variable
 ; Newing Y to prevent undef in calling routines since DIQ1 call is apparently killing Y
 N Y
 S:'$D(HBHCSP4) $P(HBHCSP4," ",5)=""
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 S DIC=4,DR=99,DA=$P(^HBHC(631.9,1,0),U,5) D EN^DIQ1
 S HBHCHOSP=^UTILITY("DIQ1",$J,4,DA,DR)
 S:$L(HBHCHOSP)'=7 HBHCHOSP=HBHCHOSP_$E(HBHCSP4,1,(7-($L(HBHCHOSP))))
 K DA,DIC,DR,^UTILITY("DIQ1",$J)
 Q
