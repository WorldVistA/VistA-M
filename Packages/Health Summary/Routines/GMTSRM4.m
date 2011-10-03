GMTSRM4 ;SLC/JER,DLT - Create/Modify - Ins/Apnd/Del Comp ; 08/27/2002
 ;;2.7;Health Summary;**56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10013  ^DIK  (file #142)
 ;                      
INSRT ; Sets Summary Order to Insert Prior to Existing Node
 N LO,NO S (NO,LO)=0 F  S NO=$O(^GMT(142,GMTSIFN,1,NO)) Q:NO=SO  S LO=NO
 S CMP(.01)=+$J(((SO-LO)/2+LO),0,3),CMP(0)="^"_$P($G(CMP(0)),U,2,5),GMTSNEW=1
 I '$D(^GMT(142,GMTSIFN,1,CMP(.01),0)) S CMP(.01)=CMP(.01)
 W !,"Inserted as SUMMARY ORDER: ",CMP(.01)_" "_CMP("NM")
 Q
APPND ; Sets Summary Order to Insert After Existing Node
 N NO S NO=$O(^GMT(142,GMTSIFN,1,SO)) S CMP(.01)=$S(NO>0:+$J(((NO-SO)/2+SO),0,3),1:SO+5),GMTSNEW=1
 I '$D(^GMT(142,GMTSIFN,1,CMP(.01),0)) S CMP(.01)=CMP(.01)
 S CMP(0)="^"_$P($G(CMP(0)),U,2,5)
 W !,"Appended as SUMMARY ORDER: ",CMP(.01)_" "_CMP("NM")
 Q
DELCMP ; Deletes Component from Summary
 N DA,DIK S DIK="^GMT(142,"_GMTSIFN_",1,",DA=OLDSO,DA(1)=GMTSIFN
 S OLDSO("NM")=$S($D(^GMT(142,GMTSIFN,1,OLDSO,0)):$P(^GMT(142.1,$P(^GMT(142,GMTSIFN,1,OLDSO,0),U,2),0),U,1),1:"")
 D ^DIK I SOACTION="D"!(SOACTION="O") W !,$S(SOACTION="O":"Overwriting",1:"Deleting")_" Summary Order "_OLDSO_" "_OLDSO("NM")
 S CNT=$$GETCNT^GMTSRM(GMTSIFN)
 Q
