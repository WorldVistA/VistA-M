EEOEEDIE ;HISC/JWR - BREAKS DOWN "DR" STRINGS, AND HOLDS DATA FOR TRANSMISSION ;11/23/92  10:03
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
ENTER ;Entry point, breaks down 'DR' strings, prepares a pre-edit session array of data from file 785
 K EEOEE S ^XTMP("EEOX",0)=DT+5_"^"_DT
 S EEOEE("DIE")=$S(+DIE:DIE,1:+$P(@(DIE_"0)"),"^",2)),EEOEE("DA")=DA,EEOEE("DR")=DR
 F AEE=1:1 S BEE=$P(EEOEE("DR"),";",AEE) Q:BEE=""  D
 .I '(+BEE) S EEOEE("DR")=$P(EEOEE("DR"),";",1,AEE-1)_$S(AEE=1:"",1:";")_$P(EEOEE("DR"),";",AEE+1,AEE+999),AEE=AEE-1
 .I BEE[":" S CEE=$P(EEOEE("DR"),";",AEE),EEOEE("DR")=$P(EEOEE("DR"),";",1,AEE-1)_$S(AEE=1:"",1:";")_$P(BEE,":",1)_";"_$P(EEOEE("DR"),";",AEE+1,AEE+999) S DEE=$P(BEE,":",1) F  S DEE=$O(^DD(785,DEE)) Q:DEE'>0  Q:DEE>$P(BEE,":",2)  D
 ..S:'$D(EEOEE("TEST",DEE)) EEOEE("DR")=$P(EEOEE("DR"),";",1,AEE)_";"_DEE_";"_$P(EEOEE("DR"),";",AEE+1,AEE+999),EEOEE("TEST",DEE)=""
 F AEE=1:1 S BEE=$P(EEOEE("DR"),";",AEE) Q:BEE=""  S EEOEE("TEST",+BEE)=""
 S EEOEE("ARRAY")="BEFORE" D ARRAY
 D DIE
AFTER ;Sets up an array of the data after the edit session and looks for changes from prior to the edit session
 S EEOEE("ARRAY")="AFTER" D ARRAY
 S AEE="" F  S AEE=$O(EEOEE("BEFORE",785,EEOEE("DA"),AEE)) Q:AEE=""  D
 .I AEE>6&(AEE<12) D MUCMP Q
 .F BEE=1:1 S DEE=$P(EEOEE("BEFORE",785,EEOEE("DA"),AEE),"^",BEE) Q:$P(EEOEE("BEFORE",785,EEOEE("DA"),AEE),"^",BEE-1,999)=""&($P(EEOEE("AFTER",785,EEOEE("DA"),AEE),"^",BEE-1,999)="")  S EEE=$P(EEOEE("AFTER",785,EEOEE("DA"),AEE),"^",BEE) D TEST
 K EEOEE Q
SAVE ;Marks those records to be transmitted by the tasked option
 Q:'$D(DA)!($G(FYI)=$G(DA))  I $P($G(^EEO(785,DA,1)),U,3)>0 S DR="62///X",FYI=DA D ^DIE Q
 Q
NEW ;Lookup on complaint
 D ^DIC Q:Y'>0  Q:DIC(0)'["L"  N Y Q
ARRAY ;Sets up before and after edit arrays to check for changed data
 S AEE="" F  S AEE=$O(EEOEE("TEST",AEE)) Q:AEE=""  D
 .Q:'$D(^DD(785,AEE,0))
 .S LEE=^DD(785,AEE,0) Q:$P(LEE,"^",2)["C"  S NEE=$P(LEE,"^",4),PEE=$P(NEE,";",2),NEE=$P(NEE,";",1) I PEE=0 D MULT Q
 .S $P(EEOEE(EEOEE("ARRAY"),785,EEOEE("DA"),NEE),"^",PEE)=$P($G(^EEO(785,EEOEE("DA"),NEE)),"^",PEE)
 Q
DIE ;The call to ^DIE
 N EEOEE D ^DIE Q
MULT ;Makes multiples into test arrays during edits (like 'ARRAY' entry pt.)
 I '$D(^EEO(785,EEOEE("DA"),NEE,0)) S EEOEE(EEOEE("ARRAY"),785,EEOEE("DA"),NEE,1)="" Q
 S EEOG=0 F  S EEOG=$O(^EEO(785,EEOEE("DA"),NEE,EEOG)) Q:EEOG'>0  D
 .S EEOEE(EEOEE("ARRAY"),785,EEOEE("DA"),NEE,EEOG)=$G(^EEO(785,EEOEE("DA"),NEE,EEOG,0))
 Q
TEST ;Test to determine if data has been changed
 I DEE=EEE Q
 I DEE'="",EEE="" D
 .I AEE>6&(AEE<12) S:BEE=1 $P(^XTMP("EEOX",EEOEE("DA"),AEE,VEE),U,BEE)="@"_DEE D SAVE S:BEE'=1 $P(^XTMP("EEOX",EEOEE("DA"),AEE,VEE),U,BEE)="@" Q
 .E  S X="@" S $P(^XTMP("EEOX",EEOEE("DA"),AEE),U,BEE)="@" D SAVE Q
 I DEE'=EEE S X=EEE D SAVE Q
 Q
MUCMP ;Puts multipes data into variables to be tested for changed data
 S VEE=0 F  S VEE=$O(EEOEE("BEFORE",785,EEOEE("DA"),AEE,VEE)) Q:VEE=""  D
 .F BEE=1:1 S DEE=$P(EEOEE("BEFORE",785,EEOEE("DA"),AEE,VEE),"^",BEE) Q:$P(EEOEE("BEFORE",785,EEOEE("DA"),AEE,VEE),"^",BEE-1,999)=""&($P($G(EEOEE("AFTER",785,EEOEE("DA"),AEE,VEE)),"^",BEE-1,999)="")  D
 ..S EEE=$P($G(EEOEE("AFTER",785,EEOEE("DA"),AEE,VEE)),"^",BEE) D TEST
 .K EEOEE("AFTER",785,EEOEE("DA"),AEE,VEE)
ADD I $O(EEOEE("AFTER",785,EEOEE("DA"),AEE,0))>0 D SAVE Q
