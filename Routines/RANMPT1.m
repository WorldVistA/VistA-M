RANMPT1 ;HISC/GJC-Radiopharm interface; ;8/6/97  12:35
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; 'RAX': Patient IEN, 'RAY': Exam Date (external) ,'RAZ' : Case #  
 ; 'RAIEN702': new IEN in file 70.2
EN1(RAX,RAY,RAZ) ; add minimum entry info into file 70.2
 S RAIEN702=$O(^RADPTN("AA",RAX,RAY,RAZ,0)) Q:RAIEN702 RAIEN702
 N DIERR,RATMP
 S RATMP(70.2,"+1,",.01)=RAX
 S RATMP(70.2,"+1,",2)=RAY,RATMP(70.2,"+1,",3)=RAZ
 D UPDATE^DIE("","RATMP","RAIEN702")
 S RAIEN702=$S(+$G(RAIEN702(1))>0:RAIEN702(1),1:-1)
 I RAIEN702=-1 W !,*7,"  ??",!!,"** Error -- Unable to file drug info **",! G EN1Q
 N RA1,RA2,RAFDA,RAIEN,RAMSG
 Q:'$D(RAOPT("REG")) RAIEN702  ;stuff only during registration
 Q:'$G(RAPRI) RAIEN702
 ; enter default radiopharmaceutical(s) into subflds of file 70.2
 S RA1=0,RA2=RAIEN702
LOOP1 K RAFDA,RAIEN,RAMSG S RA1=$O(^RAMIS(71,RAPRI,"NUC",RA1)) G:'RA1 EN1Q
 S RA50PTR=+^RAMIS(71,RAPRI,"NUC",RA1,0)
 S RAFDA(70.21,"+2,"_RA2_",",.01)=RA50PTR
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG") G:'$D(RAMSG) LOOP1
 W !,*7,"  ??",!!,"** Error -- unable to enter default radiopharmaceutical info **",!
 ;keep RAIEN702 as it was, even tho can't insert radiopharm
EN1Q Q RAIEN702
 ;
EN2(RADFN,RADTI,RACNI) ; enter default pharmceutical(s) into subflds of file 70
 Q:'$G(RAPRI)
 N RA1,RA2,RAFDA,RAIEN,RAMSG,DIERR
 N RA50NDE ; Default Medications '0' node for this procedure
 Q:$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0))  ; old data ?
 S RA1=0,RA2=RACNI_","_RADTI_","_RADFN
LOOP2 K RAFDA,RAIEN,RAMSG S RA1=$O(^RAMIS(71,RAPRI,"P",RA1)) G:'RA1 EN2Q
 S RA50NDE=$G(^RAMIS(71,RAPRI,"P",RA1,0))
 S RAFDA(70.15,"+2,"_RA2_",",.01)=+RA50NDE
 S RAFDA(70.15,"+2,"_RA2_",",2)=$P(RA50NDE,"^",2)
 D UPDATE^DIE("","RAFDA","RAIEN","RAMSG")
 G:'$D(RAMSG) LOOP2
 W !,*7,"  ??",!!,"** Error -- unable to enter default pharmaceutical info **",!
EN2Q Q
