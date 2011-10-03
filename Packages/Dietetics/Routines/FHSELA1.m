FHSELA1 ;Hines OIFO/RTK - Map GMR Allergy file to Food Prefs ;3/07/2007
 ;;5.5;DIETETICS;**8,12**;Jan 28, 2005;Build 3
 ;
 ;10/16/2007 BAY/KAM FH*5.5*12 Remedy Call 210385 Do not allow
 ;                             user to change Food Preference name or
 ;                             LIKE/DISLIKE field
 ;
CREATE ; Check for any missing Allergy-type FP's or one's not renamed in 115.2
 ; and allow user to create the FP on the fly
 D ^FHSELA2 S NUM=0,FHQUIT=0
 W !!!,"The following Allergy Food Preference titles are not on file."
 W !,"You may use this option to create these Food Preference entries:"
 D CRLIST I NUM=0 W !,"No Food Preferences need to be mapped." D EXIT Q
 I FHQUIT=1 D EXIT Q
 I FHRESP=""!(FHRESP="M") D EXIT Q
 S FHAFPNM=$P(FHLIST(FHRESP),"^",1)
 W !,FHAFPNM," "
 K DIR S DIR("A")="Add to Food Preference file",DIR(0)="Y" D ^DIR
 I $D(DIRUT) D EXIT Q
 I Y'=1 D CREATE Q
 D ADD
 W !!,"  ...done.  ",FHAFPNM," Food Preference has been added!" H 1
 D CREATE Q
 D EXIT Q
CRLIST ;
 W !!?5,"MISSING FOOD PREFERENCE LIST"
 W !?5,"============================"
 S FHSEL=0,FHK=""
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""!(FHQUIT=1)!(FHSEL=1)  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99)
 .S FHZ1="ALLERGY - "_$P(FHFPS,";",1)
 .I $D(^FH(115.2,"B",FHZ1)) Q
 .S NUM=NUM+1,PAD=$S($L(NUM)=1:" ",1:"") W !,PAD,NUM
 .W ?8,FHZ1
 .S FHLIST(NUM)=FHZ1_"^"_FHFPS
 .I NUM#5=0!($O(^TMP($J,"FHALG",FHK))="") D PG Q
 .Q
 I FHQUIT=0,FHSEL=0,NUM#5'=0 D PG Q
 Q
ADD ;
 S FHALGMZ=1
 S X=FHAFPNM K DIC,DO
 S (DIC,DIE)="^FH(115.2,",DIC(0)="L" D FILE^DICN
 ; 10/16/2007 BP/KAM FH*5.5*12 Default DISLIKE and prevent Food Preference name change in the next line
 S (FHDA,DA)=+Y,DR="26;1////D"
 D ^DIE K DA,DIE,DR
 D TRAN^FHSEL1
 Q
PG ;
 S FHRESP="" W ! K DIR
 S DIR("A")="Select Food Preference or 'M' to see more ('^' to EXIT)"
 S DIR(0)="F",DIR("B")="M" D ^DIR I $D(DIRUT) S FHQUIT=1 Q
 S FHRESP=Y
 I FHRESP?1"M" Q
 I FHRESP?1.3N,FHRESP>0,FHRESP<(NUM+1) S FHSEL=1 Q
 W !!,"Select from 1 to ",NUM D PG Q
 Q
MAP ; Map allergies by setting pointers in 115.2 to correct entries in 120.82
 D ^FHSELA2
 S FHK=""
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99)
 .S FHZ1="ALLERGY - "_$P(FHFPS,";",1)
 .I '$D(^FH(115.2,"B",FHZ1)) Q  ;not set-up in 115.2, can't map
 .S FHFPIEN=$O(^FH(115.2,"B",FHZ1,""))
 .S FHALMP=$P(FHFPS,";",2,99) I FHALMP="" Q  ;no allergies to map
 .S FHZ=0 F  S FHZ=FHZ+1 S FHANAM=$P(FHALMP,";",FHZ) Q:FHANAM=""  D
 ..D LOOKUP
 Q
LOOKUP ; Look-up the Allergy in 120.82 and set the pointer
 S FHX=FHANAM
 F FHVAL=0:0 S FHVAL=$O(^GMRD(120.82,"B",FHX,FHVAL)) Q:FHVAL'>0  D
 .I $D(^FH(115.2,FHFPIEN,"ALG","B",FHVAL)) Q  ;pointer already exists
 .S Y=FHVAL K DIC,DO S DA(1)=FHFPIEN,DIC="^FH(115.2,"_DA(1)_",""ALG"","
 .S DIC(0)="L",DIC("P")=$P(^DD(115.2,25,0),U,2),X=+Y
 .D FILE^DICN
 Q
DISPMAP ;
 W !!,"This option can be used to display the Standard GMR Allergy"
 W !,"entries and the Food Preferences they map to.",!! K DIR
 S DIR("A")="Display Map by Allergies or by Food Preferences (A/F): "
 S DIR(0)="SA^A:Allergies;F:Food Preferences" D ^DIR
 I $D(DIRUT) D EXIT Q
 S FHSEL=Y
 D DEV
 Q
DEV ;get device and set up queue
 W ! K %ZIS,IOP S %ZIS="Q" D ^%ZIS Q:POP
 I '$D(IO("Q")) U IO D LISTMAP,^%ZISC,EXIT Q
 S ZTRTN="LISTMAP^FHSELA1",ZTSAVE("FHSEL")=""
 S ZTDESC="GMR Allergy/Food Preference Map Display" D ^%ZTLOAD
 D ^%ZISC K %ZIS,IOP
 D EXIT
 Q
LISTMAP ; List Map by Allergies or by Food Preferences
 I FHSEL="A" D LISTAL Q
 I FHSEL="F" D LISTFP Q
 Q
LISTFP ; List all the Allergy-type Food Pref's and corresponding GMR Allergies
 D ^FHSELA2
 S FHK="" W !!,"ALLERGY TYPE FOOD PREFERENCE MAP"
 W !!,"NFS Food Preference Title",?40,"GMR Standard Allergy(s)"
 W !,"==================================="
 W ?40,"==================================="
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99),FHZ1=$P(FHFPS,";",1)
 .W !,"ALLERGY - ",FHZ1
 .S FHALMP=$P(FHFPS,";",2,99) I FHALMP="" W ?40,"** NONE **" Q
 .S FHZ=0,N=0 F  S FHZ=FHZ+1,FHANAM=$P(FHALMP,";",FHZ) Q:FHANAM=""  D
 ..W ?40,$S(FHZ>1:",",1:"") S N=N+$L(FHANAM)+1 W:N>40 !?40 S:N>40 N=0 W FHANAM I N=0 S N=N+$L(FHANAM)+1
 D EXIT Q
LISTAL ; List all the GMR Allergies and the Food Pref to map to
 D ^FHSELA2
 S FHK="" W !!,"GMR STANDARD FOOD ALLERGY MAP"
 W !!,"GMR Allergy Name",?25,"Corresponding NFS Food Preference"
 W !,"=======================",?25,"===================================="
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99),FHZ1=$P(FHFPS,";",1)
 .S FHALMP=$P(FHFPS,";",2,99) I FHALMP="" Q
 .S FHZ=0,N=0 F  S FHZ=FHZ+1,FHANAM=$P(FHALMP,";",FHZ) Q:FHANAM=""  D
 ..S ^TMP($J,"FHAL",FHANAM)="ALLERGY - "_FHZ1
 S FHANAMZ=""
 F  S FHANAMZ=$O(^TMP($J,"FHAL",FHANAMZ)) Q:FHANAMZ=""  D
 .W !,FHANAMZ,?25,"...maps to: ",^TMP($J,"FHAL",FHANAMZ)
 D EXIT Q
MISSING ; List all Food Pref's with no pointers to 120.82
 D ^FHSELA2
 S FHK=""
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99),FHZ1=$P(FHFPS,";",1)
 .I $P(FHFPS,";",2)'="" Q
 .W !?5,"ALLERGY - ",FHZ1," does not have corresponding 120.82 entries"
 D EXIT Q
CHECK ; Check for any missing Allergy-type FP's or one's not renamed in 115.2
 D ^FHSELA2
 S FHK="",FLG=0
 W !,"The following Food Preferences titles were not found in file #115.2:"
 F  S FHK=$O(^TMP($J,"FHALG",FHK)) Q:FHK=""  D
 .S FHFPS=$P(^TMP($J,"FHALG",FHK),";",1,99)
 .S FHZ1="ALLERGY - "_$P(FHFPS,";",1)
 .I '$D(^FH(115.2,"B",FHZ1)) W !,FHZ1 S FLG=1
 I FLG=0 W !,"ALL FOOD PREFERENCES HAVE BEEN RENAMED!"
 D EXIT Q
 ;
UPDATE ;Update Food Preferences for all Patient's based on Allergies
 D ^FHSELA2 S FHCOUNT=0,FHQT=0
 W !!,"...Updating Patient Food Preferences based on Food-Type Allergies"
 W "..." K FHMISS F FHDFN=0:0 S FHDFN=$O(^FHPT(FHDFN)) Q:FHDFN'>0  D
 .S FHCOUNT=FHCOUNT+1 I FHCOUNT#100=0 W "."
 .D GETZN^FHOMUTL I FILE'="P" Q
 .S DFN=IEN D ALG^FHCLN I '$O(^TMP($J,"FHGMRAL","")) Q
 .F FHGMRN=0:0 S FHGMRN=$O(^TMP($J,"FHGMRAL",FHGMRN)) Q:FHGMRN=""  D UPDFP1^FHWGMR
 I $G(FHPST8)=1 K ^TMP($J,"FHGMRAL"),^TMP($J,"FHMISS"),FHGMRN,FHMSAL,FHMSFP,FHMSPT,FHPST8,FHCOUNT Q
 D LIST
 K ^TMP($J,"FHGMRAL"),^TMP($J,"FHMISS"),FHGMRN,FHMSAL,FHMSFP,FHMSPT,FHPST8,FHCOUNT,FHQT
 Q
LIST ;
 I '$D(^TMP($J,"FHMISS")) Q
 W !!,"The following entries need to be mapped in order to automatically"
 W !,"update the Patient Food Preferences:",! S FHCOUNT=0,FHQT=0
 S FHMSFP="" F  S FHMSFP=$O(^TMP($J,"FHMISS",FHMSFP)) Q:FHMSFP=""!(FHQT=1)  D
 .W !,"'ALLERGY - ",FHMSFP,"'" S FHCOUNT=FHCOUNT+1
 .S FHMSPT="" F  S FHMSPT=$O(^TMP($J,"FHMISS",FHMSFP,FHMSPT)) Q:FHMSPT=""  D
 ..S FHMSAL=$P($G(^TMP($J,"FHMISS",FHMSFP,FHMSPT)),U,1)
 ..W !?3,"Patient: ",$E(FHMSPT,1,30),?43,"Allergy: ",FHMSAL
 ..S FHCOUNT=FHCOUNT+1
 ..I FHCOUNT>14 S FHCOUNT=0 W ! K DIR S DIR(0)="E" D ^DIR W ! I X="^" S FHQT=1
 Q
EXIT ;
 D MAP
 K ^TMP($J,"FHALG"),^TMP($J,"FHAL")
 K FHFPIEN,FHK,FHX,FHZ,FHFPS,FHZ1,FHVAL,N,FHANAM,FHANAMZ
 K FHQUIT,NUM,FHRESP,FHAFPNM,FHSEL,PAD,FHLIST,FHALGMZ,FHALMP
