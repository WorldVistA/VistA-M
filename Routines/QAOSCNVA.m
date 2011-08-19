QAOSCNVA ;HISC/DDA-CONVERT VALADATED/COMFIRMED SYS/EQIP ISSUES ;1/3/94  15:49
 ;;3.0;Occurrence Screen;**6**;09/14/1993
INFO ; INFORMATION ABOUT THIS CONVERSION PROCESS.
 W !!,"This conversion restores previous versions' SYSTEM and EQUIPMENT"
 W !,"issues and makes them available for historical reporting via the"
 W !,"option 'System/Equipment Problems' [QAOS RPT SYS/MGMT/EQUIP PROB]"
 W !!,"As part of the conversion a non-committee place holder,"
 W !,"VALIDATED/CONFIRMED, is added to the 'QA OCCURRENCE COMMITTEE'"
 W !,"file (#741.97)."
 W !!,"The actual conversion can be performed any number of times with"
 W !,"no adverse impact on the data.  If the conversion is interrupted"
 W !,"for any reason, simply run this routine again."
 W !,"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
 ; HAVE USER PRESS RETURN TO CONTINUE
 S DIR(0)="E" W ! D ^DIR K DIR
 I Y'=1 S CNVMSG="User stopped conversion process." G ERROR
 S STARTIME=$P($H,",",2)
 W !!,"Starting the conversion..."
ADDCOM W !!,"Adding place holder committee - VALIDATED/CONFIRMED"
 W !,"---------------------------------------------------"
 K DD,DIC,DINUM,DO
 S X="VALIDATED/CONFIRMED"
 ; IF IT IS ALREADY IN THE FILE, SKIP TO THE CONVERSION
 S CNVCOM=$O(^QA(741.97,"B",X,""))
 G:CNVCOM>0 LP
 S DIC="^QA(741.97,",DIC(0)="EL",DIC("DR")="1///XX",DLAYGO=741.97 D FILE^DICN I Y=-1 S CNVMSG="UNABLE TO ADD 'VALILATED/CONFIRMED' COMMITTEE TO FILE #741.97" G ERROR
 S CNVCOM=+Y K DIC,DLAYGO
LP W !,"Done..."
 W !!,"Moving VALIDATED/CONFIRMED data to the committee area"
 W !,"-----------------------------------------------------"
 S (CNT,CNV)=0
 D NOW^%DTC S CNVDT=X
 D WAIT^DICD
 D LOOP
 W !,"Done..."
 S ENDTIME=$P($H,",",2),%=ENDTIME-STARTIME D S^%DTC
 S HOURS=+$E(%,2,3),MINUTES=+$E(%,4,5),SECONDS=+$E(%,6,7)
 W !!,"-----------------------------------------------------"
 W !,"Total records checked: "_CNT_"  Total records modified: "_CNV
 W !,"Conversion completed in ",HOURS,"H ",MINUTES,"M ",SECONDS,"S."
EXIT K CNT,CNV,CNVCOM,CNVDT,CNVMSG,COMDA,COMIEN,COMMENTS,COMTTL,DA,DD,DIC,DINUM,DLAYGO,DO,ENDTIME,HOURS,IEN,MINUTES,OKAY,QAQADICT,QAQAFLD,SECONDS,STARTIME,VALDT,VC,X,Y,ZER0
 Q
LOOP ; LOOP VIA "AVAL" CROSS REFERENCE.  ONLY THOSE RECORDS WITH A VALIDATION DATE ARE CHECKED.
 S VALDT=0
 F  S VALDT=$O(^QA(741,"AVAL",VALDT)) Q:VALDT'>0  S IEN=0 F  S IEN=$O(^QA(741,"AVAL",VALDT,IEN)) Q:IEN'>0  S ZER0=$G(^QA(741,IEN,0)) D
 .S CNT=CNT+1
 .; CONTINUE IF THERE IS ISSUE CODE DATA (VC)
 .I +$P(ZER0,"^",20)'=0 D
 ..S VC=$P(ZER0,"^",20),COMIEN=0,OKAY=1
 ..; CHECK ALL COMMITTEE ENTRIES.  CONTINUE IF NONE HAVE THE SAME ISSUE CODE (VC)
 ..F  S:$D(^QA(741,IEN,"CMTE")) COMIEN=$O(^QA(741,IEN,"CMTE",COMIEN)) Q:COMIEN'>0  I $P($G(^QA(741,IEN,"CMTE",COMIEN,0)),"^",5)=VC S OKAY=0
 ..; SET HEADER IF NO PREVIOUS COMMITTEE DATA
 ..I OKAY D
 ...;SETUP AND STORE COMMITTEE DATA
 ...I '$D(^QA(741,IEN,"CMTE")) S ^QA(741,IEN,"CMTE",0)="^741.017PA^"
 ...S COMMENTS=$G(^QA(741,IEN,1))
 ...S COMDA=$P($G(^QA(741,IEN,"CMTE",0)),"^",3)
 ...S COMTTL=$P($G(^QA(741,IEN,"CMTE",0)),"^",4)+1
LDA ...S COMDA=COMDA+1
 ...L +^QA(741,IEN,"CMTE",COMDA):1 G:('$T)!($D(^QA(741,IEN,"CMTE",COMDA))) LDA
 ...S ^QA(741,IEN,"CMTE",COMDA,0)=CNVCOM_"^^^^"_VC
 ...S $P(^QA(741,IEN,"CMTE",0),"^",3,4)=COMDA_"^"_COMTTL
 ...;FIRE OFF XREFS
 ...S DA(1)=IEN,DA=COMDA,QAQADICT=741.017,QAQAFLD=.01,X=CNVCOM D ENSET^QAQAXREF
 ...S DA(1)=IEN,DA=COMDA,QAQADICT=741.017,QAQAFLD=4,X=VC D ENSET^QAQAXREF
 ...I COMMENTS]"" D
 ....S ^QA(741,IEN,"CMTE",COMDA,1,0)="^^1^1^"_VALDT_"^^"
 ....S ^QA(741,IEN,"CMTE",COMDA,1,1,0)=COMMENTS
 ....Q
 ...L -^QA(741,IEN,"CMTE",COMDA)
 ...S CNV=CNV+1
 ...Q
 ..Q
 .Q
 Q
ERROR ;
 W !!,"&%%#^%#))^$$##$^*$&%&*^%#%^$$#%%$#&_(*&&*$^%#)*^^$^%#^$$#@&%#)#%&^$##"
 W !?5,CNVMSG
 W !?5,"Conversion has been stopped."
 W !!,"&%%#^%#))^$$##$^*$&%&*^%#%^$$#%%$#&_(*&&*$^%#)*^^$^%#^$$#@&%#)#%&^$##"
 D EXIT
 Q
