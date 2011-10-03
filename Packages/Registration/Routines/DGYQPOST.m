DGYQPOST ;AISC/TET - POST INIT TO PATCH DG*5.3*41
 ;;5.3;Registration;**41**;Aug 13, 1993
EN ;entry point for entire post init
 D RCOMP,WARD,DOB
 Q
RCOMP ;entry point to re-compile templates
 N DGDASH,DGMAX,DGROU,DGTEMP,I
 S:'$D(DTIME) DTIME=300 S U="^",$P(DGDASH,"=",81)="",DGMAX=$G(^DD("ROU")) S:'DGMAX DGMAX=5000
 W !!?17,"Recompilation of affected Registration Input Templates",!,DGDASH,!
 F I=1:1 S DGTEMP=$P($T(ITEMP+I),";;",2) Q:DGTEMP="END"  W !?5,DGTEMP D
 .N DMAX,DGIEN,DGROU,X,Y
 .S DGIEN=$O(^DIE("B",DGTEMP,0)) Q:'DGIEN
 .S DGROU=$G(^DIE(DGIEN,"ROUOLD")) I DGROU']""!('$D(^DIE(DGIEN,0))) Q
 .S X=$P(DGROU,U),DMAX=DGMAX,Y=DGIEN D EN^DIEZ
 .W !?5,"===> ",DGTEMP," input template recompiled.",!
 ;Q
ITEMP ;input templates to be recompiled
 ;;DGPM ADMIT
 ;;DGPM ASIH ADMIT
 ;;DGPM SPECIALTY TRANSFER
 ;;DVBA C ADD 2507 PAT
 ;;END
 Q
WARD ;delete .001 field from ward location file (#42), if exists
 I $D(^DD(42,.001)) D
 .N DA,DIC,DIK
 .W !!,"Deleting the Number field (#.001) from the WARD LOCATION file (#42)."
 .S DIK="^DD(42,",DA=".001",DA(1)=42 D ^DIK K DIK,DA
 .W !?10," ... Deleted",!
 Q
DOB ;entry point to remove value from latest dob field (#.07) in period of service file (#21)
 W !!,">>>> Modifying data in the Period of Service File (#21)..."
 W !,"     >>>> Deleting the Latest DOB Field (#.07) for select entries",!
 N DIC,DIE,DA,DR,X,Y,DGX,DGERR
 S DIC="^DIC(21,"
 S DIC(0)="XZ"
 F DGX="PERSIAN GULF WAR","OPERATION DESERT SHIELD" D  Q:$G(DGERR)
 .S X=DGX
 .D ^DIC
 .I Y'>0 D
 ..W !!,"*****"
 ..W ?7,"There was a problem identifying the following PERIOD OF SERVICE"
 ..W !?7,"entry:  ",DGX,!
 ..S DGERR=1
 .I Y>0 D
 ..W !!,"IEN= ",+Y,?10," Period of Service: ",$P(Y,U,2)
 ..S DA=+Y,DIE=DIC,DR=".07///@"
 ..D ^DIE
 ..W ", Field #.07 deleted.",!
 D:$G(DGERR) ERRMESS
 W:'$G(DGERR) !!,"Done."
 Q
ERRMESS ;
 W !!!!
 F X=1:1 S DGX=$T(MESS+X) Q:$G(DGX)=""  W !,$P(DGX,";;",2)
 Q
MESS ;
 ;;It appears as if the PERIOD OF SERVICE File (#21) has been locally
 ;;modified at this site.
 ;;
 ;;The PERIOD OF SERVICE file contains entries as determined by VACO
 ;;MAS.  Alteration of existing entries or addition of new ones will
 ;;undoubtedly have a negative impact on the efficient operation of the
 ;;MAS module and other modules.
 ;;  
 ;;Please contact your Support ISC before continuing.  This routine,
 ;;at tag DOB^DGYQPOST, may be re-run multiple times.
